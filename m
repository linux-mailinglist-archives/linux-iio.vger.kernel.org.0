Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73B2483001
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jan 2022 11:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiACKop (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jan 2022 05:44:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12578 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232749AbiACKoo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jan 2022 05:44:44 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2038J52h012992;
        Mon, 3 Jan 2022 05:44:31 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dbwhb07qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 05:44:31 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 203AiUGo053152
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Jan 2022 05:44:30 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Jan 2022 05:44:29 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Jan 2022 05:44:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Jan 2022 05:44:29 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 203AiPiG029854;
        Mon, 3 Jan 2022 05:44:26 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <alexandru.tachici@analog.com>, <dragos.bogdan@analog.com>,
        <nuno.sa@analog.com>, <lars@metafoo.de>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] MAINTAINERS: fix Analog Devices links
Date:   Mon, 3 Jan 2022 12:44:12 +0200
Message-ID: <20220103104412.81247-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: MgkjUqq5iIoAFGzXojyJKOOIrYBxodDC
X-Proofpoint-GUID: MgkjUqq5iIoAFGzXojyJKOOIrYBxodDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_04,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201030072
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The forum link for the Analog Devices linux drivers has changed.

Fix the links to redirect to the correct forum subsection.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d311fd7e445..aa5ebb5a4b6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -459,35 +459,35 @@ AD525X ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/AD5254
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/misc/ad525x_dpot.c
 
 AD5398 CURRENT REGULATOR DRIVER (AD5398/AD5821)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/AD5398
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/regulator/ad5398.c
 
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/AD7142
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/misc/ad714x.c
 
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/AD7877
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/touchscreen/ad7877.c
 
 AD7879 TOUCHSCREEN DRIVER (AD7879/AD7889)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/AD7879
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/input/touchscreen/ad7879.c
 
 ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
@@ -499,7 +499,7 @@ M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	linux-wpan@vger.kernel.org
 S:	Supported
 W:	https://wiki.analog.com/ADF7242
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/net/ieee802154/adf7242.txt
 F:	drivers/net/ieee802154/adf7242.c
 
@@ -533,7 +533,7 @@ ADP5520 BACKLIGHT DRIVER WITH IO EXPANDER (ADP5520/ADP5501)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/ADP5520
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/gpio/gpio-adp5520.c
 F:	drivers/input/keyboard/adp5520-keys.c
 F:	drivers/leds/leds-adp5520.c
@@ -544,7 +544,7 @@ ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/ADP5588
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/gpio/gpio-adp5588.c
 F:	drivers/input/keyboard/adp5588-keys.c
 
@@ -552,7 +552,7 @@ ADP8860 BACKLIGHT DRIVER (ADP8860/ADP8861/ADP8863)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/ADP8860
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/video/backlight/adp8860_bl.c
 
 ADT746X FAN DRIVER
@@ -591,7 +591,7 @@ ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/ADXL345
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 F:	drivers/input/misc/adxl34x.c
 
@@ -608,7 +608,7 @@ F:	drivers/iio/accel/adxl355_spi.c
 ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
 F:	drivers/iio/accel/adxl372.c
 F:	drivers/iio/accel/adxl372_i2c.c
@@ -1040,7 +1040,7 @@ ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
 F:	drivers/iio/adc/ad7192.c
 
@@ -1048,7 +1048,7 @@ ANALOG DEVICES INC AD7292 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 F:	drivers/iio/adc/ad7292.c
 
@@ -1064,7 +1064,7 @@ ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
 F:	drivers/iio/adc/ad7768-1.c
 
@@ -1073,7 +1073,7 @@ M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Renato Lui Geh <renatogeh@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
@@ -1093,7 +1093,7 @@ ANALOG DEVICES INC ADIN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/net/adi,adin.yaml
 F:	drivers/net/phy/adin.c
 
@@ -1108,14 +1108,14 @@ ANALOG DEVICES INC ADIS16460 DRIVER
 M:	Dragos Bogdan <dragos.bogdan@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 F:	drivers/iio/imu/adis16460.c
 
 ANALOG DEVICES INC ADIS16475 DRIVER
 M:	Nuno Sa <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 S:	Supported
 F:	drivers/iio/imu/adis16475.c
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -1124,7 +1124,7 @@ ANALOG DEVICES INC ADM1177 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 F:	drivers/hwmon/adm1177.c
 
@@ -1148,7 +1148,7 @@ ANALOG DEVICES INC ADP5061 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/power/supply/adp5061.c
 
 ANALOG DEVICES INC ADRF6780 DRIVER
@@ -1163,7 +1163,7 @@ ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/media/i2c/adv7180.c
 F:	Documentation/devicetree/bindings/media/i2c/adv7180.yaml
 
@@ -1205,7 +1205,7 @@ M:	Nuno Sá <nuno.sa@analog.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 W:	http://wiki.analog.com/
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	sound/soc/codecs/ad1*
 F:	sound/soc/codecs/ad7*
 F:	sound/soc/codecs/adau*
@@ -1216,7 +1216,7 @@ F:	sound/soc/codecs/ssm*
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
 ANALOG DEVICES INC IIO DRIVERS
@@ -1224,7 +1224,7 @@ M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 S:	Supported
 W:	http://wiki.analog.com/
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	Documentation/devicetree/bindings/iio/*/adi,*
@@ -3254,7 +3254,7 @@ AXI-FAN-CONTROL HARDWARE MONITOR DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 F:	drivers/hwmon/axi-fan-control.c
 
@@ -11199,7 +11199,7 @@ LTC2947 HARDWARE MONITOR DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
 F:	drivers/hwmon/ltc2947-core.c
 F:	drivers/hwmon/ltc2947-i2c.c
@@ -11210,7 +11210,7 @@ LTC2983 IIO TEMPERATURE DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
 F:	drivers/iio/temperature/ltc2983.c
 
@@ -11225,7 +11225,7 @@ LTC4306 I2C MULTIPLEXER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
 
-- 
2.34.1

