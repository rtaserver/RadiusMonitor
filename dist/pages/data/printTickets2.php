<?php
// PrintTickets RadiusMonitor By Maizil
include "phpqrcode/qrlib.php";

$jsonFile = 'config_print.json';
$jsonData = file_get_contents($jsonFile);

$config = json_decode($jsonData, true);

$hsname1 = isset($config['hsname1']) ? $config['hsname1'] : '';
$hsname2 = isset($config['hsname2']) ? $config['hsname2'] : '';
$hsip = isset($config['hsip']) ? $config['hsip'] : '';
$hsdomain = isset($config['hsdomain']) ? $config['hsdomain'] : '';
$hscsn = isset($config['hscsn']) ? $config['hscsn'] : '';
$hsqrmode = isset($config['hsqrmode']) ? $config['hsqrmode'] : '';
$hsipdomain = isset($config['hsipdomain']) ? $config['hsipdomain'] : '';
$logomode = isset($config['logomode']) ? $config['logomode'] : '';

$configValues = array(
    "CONFIG_DB_TBL_DALOBILLINGPLANS" => "billing_plans",
    "CONFIG_DB_TBL_RADGROUPREPLY" => "radgroupreply",
    "CONFIG_DB_TBL_RADGROUPCHECK" => "radgroupcheck" 
);

if (isset($_REQUEST["type"]) && $_REQUEST["type"] == "batch") {
    if (isset($_REQUEST['format'])) {
        $format = $_REQUEST['format'];

    } else {
        
    }

    $plan = $_REQUEST["plan"];
    $accounts_temp = $_REQUEST["accounts"];
    $accounts = explode("||", $accounts_temp);

    // Konfigurasi database
    $host = '127.0.0.1';
    $dbname = 'radius';
    $username = 'radius';
    $password = 'radius';

        $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT planCost, planTimeBank, planCurrency FROM " . $configValues["CONFIG_DB_TBL_DALOBILLINGPLANS"] . " WHERE planName = :plan";
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':plan', $plan, PDO::PARAM_STR);
        $stmt->execute();

        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($row) {
            $ticketCurrency = $row["planCurrency"];
            $ticketCost = $row["planCost"] . " " . $ticketCurrency;
            $ticketTime = time2str($row["planTimeBank"]);
            
        } else {
        $ticketCurrency = '0';
        $ticketCost = '0';
        $ticketTime = '';
        }

            $sqlQuota = "SELECT value FROM " . $configValues["CONFIG_DB_TBL_RADGROUPREPLY"] . " WHERE groupname = :plan AND attribute = 'ChilliSpot-Max-Total-Octets'";
            $stmtQuota = $pdo->prepare($sqlQuota);
            $stmtQuota->bindParam(':plan', $plan, PDO::PARAM_STR);
            $stmtQuota->execute();

            $quotaRow = $stmtQuota->fetch(PDO::FETCH_ASSOC);
            $ticketQuota = isset($quotaRow["value"]) ? formatBytes($quotaRow["value"]) : "";

            $sqlActiveTime = "SELECT value FROM " . $configValues["CONFIG_DB_TBL_RADGROUPCHECK"] . " WHERE groupname = :plan AND attribute = 'Max-All-Session'";
            $stmtActiveTime = $pdo->prepare($sqlActiveTime);
            $stmtActiveTime->bindParam(':plan', $plan, PDO::PARAM_STR);
            $stmtActiveTime->execute();

            $activeRow = $stmtActiveTime->fetch(PDO::FETCH_ASSOC);
            $ticketActiveTime = isset($activeRow["value"]) ? time2str($activeRow["value"]) : "";

            $timestamp = date('Y-m-d H:i:s');

            printTicketsHTMLTable($accounts, $ticketCost, $ticketTime, $ticketQuota, $ticketActiveTime, $timestamp);

}

function formatBytes($bytes, $decimal = 0) {
    $units = array('B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
    $factor = floor((strlen($bytes) - 1) / 3);
    return sprintf("%." . $decimal . "f", $bytes / pow(1024, $factor)) . ' ' . $units[$factor];
}

function time2str($time) {
    if (!is_numeric($time)) {
        return '';
    }
    $units = array(
        "TAHUN" => 365*24*3600,
        "BULAN" => 30*24*3600,
        "HARI" => 24*3600,
        "JAM" => 3600,
        "MENIT" => 60,
        "DETIK" => 1,
    );

    $str = "";
    foreach ($units as $name => $divisor) {
        $quot = intval($time / $divisor);
        if ($quot) {
            $str .= "$quot $name ";
            $time -= $quot * $divisor;
        }
    }

    return trim($str);
}

function printTicketsHTMLTable($accounts, $ticketCost, $ticketTime, $ticketQuota, $ticketActiveTime, $timestamp)
{
    global $dnsname, $hslogo, $hsip, $hscsn, $hsdomain, $hsname1, $hsname2, $hsqrmode, $hsipdomain, $qrcodeData, $logomode;

    if ($ticketCost <= 500) {
        $color = "#4bde97";
    } elseif ($ticketCost >= 1000 && $ticketCost <= 4000) {
        $color = "#e83e8c";
    } elseif ($ticketCost >= 4000 && $ticketCost <= 24000) {
        $color = "#f74e07";
    } elseif ($ticketCost >= 25000 && $ticketCost <= 49000) {
        $color = "#0f8d43";
    } elseif ($ticketCost >= 50000 && $ticketCost <= 100000) {
        $color = "#9911b1";
    }

    array_shift($accounts);
    foreach ($accounts as $userpass) {
        list($user, $pass) = explode(",", $userpass);

        $size = isset($_REQUEST["size"]) ? (int)$_REQUEST["size"] : 5;
        $matrixPointSize = min(max($size, 5), 10);

?>
<title><?php echo $timestamp ?></title>
<table style="display: inline-block;border-collapse: collapse;border: 1px solid #666;margin: 2.5px;width: 190px;overflow:hidden;position:relative;padding: 0px;margin: 2px;border: 1px solid #000000;">
  <tbody>
    <tr>
      <td style="color:#666;" valign="top">
        <table style="width:100%;">
          <tbody>
            <tr>
              <td style="width:75px">
                <div style="position:relative;z-index:-1;padding: 0px;float:left;">
                  <div style="position:absolute;top:0;display:inline;margin-top:-100px;width: 0; height: 0; border-top: 230px solid transparent;border-left: 50px solid transparent;border-right:140px solid #DCDCDC; "></div>
                </div>
                <?php if ($logomode == "text"): ?>
				<span style="font-size: 13.5px;font-weight: bold;"><?php echo $hsname1; ?><span style="color:<?php echo $color; ?>;"><?php echo $hsname2; ?>
                <?php elseif ($logomode == "image"): ?>
                <img src="../logo/logo.png" alt="logo" style="height: 30px; width: 80px; border: 0;">
                <?php endif; ?>
              </td>
              <td style="width:115px">
                <div style="float:right;margin-top:-6px;margin-right:0px;width:5%;text-align:right;font-size:7px;"></div>
                <div style="text-align:right;font-weight:bold;font-family:Tahoma;font-size:15px;padding-left:17px;color:
				<?php echo $color ?>">Rp <?php echo $ticketCost;?> </div>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
    <tr>
      <td style="color:#666;border-collapse: collapse;" valign="top">
        <table style="width:100%;border-collapse: collapse;">
          <tbody>
            <tr>
              <td style="width:95px" valign="top">
                <div style="clear:both;color:#555;margin-top:2px;margin-bottom:2.5px;">
                  <div style="padding:0px;border-bottom:1px solid;text-align:center;font-weight:bold;font-size:10px;color:#555">voucher</div>
                  <div style="padding:0px;border-bottom:1px solid;text-align:center;font-weight:bold;font-size:12px;color:#111;"> <?php echo $user;?> </div>
                </div>
                <div style="text-align:center;color:#111;font-size:9px;font-weight:bold;margin:0px;padding:2.5px;"> Hubungkan Ke Jaringan <?= $hsname1.$hsname2; ?> <div style="text-align:center;color:#111;font-size:7px;font-weight:bold;margin:0px;padding:2.5px;"> Buka Browser Ketik: <?= $hsip; ?> </div>
              </td>
              <p style=" margin-top:-14px;margin-bottom:5px">
                <td style="width:100px;text-align:right;">
                  <div style="clear:both;padding:0 2.5px;font-size:7px;font-weight:bold;color:#000000"> Masa Aktif: <?php echo $ticketActiveTime;?> <br>Durasi: <?php echo $ticketTime;?> <br>Kuota: <?php echo $ticketQuota; ?>  </div> 
                  <?php
                    $tempdir = "tmp/";

                    if (!file_exists($tempdir)) {
                        mkdir($tempdir, 0777, true);
                    }
                    
                    if($hsqrmode == "code") {
                        $qrcodeData = "$user";
                    } elseif ($hsqrmode == "url") {
                        if($hsipdomain == "ip") {
                            $qrcodeData = "http://$hsip:3990/login?username=$user&password=$pass";
                        } elseif ($hsipdomain == "domain") {
                            $qrcodeData = "http://$hsdomain:3990/login?username=$user&password=$pass";
                        }
                    }

                    $errorCorrectionLevel = "L";
                    $matrixPointSize = 4;

                    QRcode::png($qrcodeData, $tempdir . $user . ".png", $errorCorrectionLevel, $matrixPointSize, 2);
                    ?> <div style="float:right;padding:1px;text-align:right;width:70%;margin:0 5px -15px 0;">
                    <img style="height:70px;width:70px;" src="<?php echo htmlspecialchars($tempdir . $user . ".png"); ?>" alt="QR Code">
                  </div>
                </td>
            </tr>
            <tr>
              <td style="background:<?php echo $color ?>;color:#666;padding:0px;" valign="top" colspan="2">
                <div style="text-align:left;color:#fff;font-size:8px;font-weight:bold;margin:0px;padding:2.5px;"><?php echo $hscsn;?><br>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </td>
    </tr>
  </tbody>
</table> <?php
    }
}
?>