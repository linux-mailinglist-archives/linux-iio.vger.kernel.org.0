Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE77E21485F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 21:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGDT2F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDT2E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 15:28:04 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB91C061794;
        Sat,  4 Jul 2020 12:28:04 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 74155BC078;
        Sat,  4 Jul 2020 19:27:56 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, tomislav.denis@avl.com,
        ak@it-klinger.de, grandmaster@al2klimov.de,
        sergiu.cuciurean@analog.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        alexandre.belloni@bootlin.com, gregory.clement@bootlin.com,
        sre@kernel.org, matt.ranostay@konsulko.com, hslester96@gmail.com,
        chris.lesiak@licor.com, alexandru.ardelean@analog.com,
        dannenberg@ti.com, dpfrey@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Replace HTTP links with HTTPS ones: drivers/iio
Date:   Sat,  4 Jul 2020 21:27:43 +0200
Message-Id: <20200704192743.18382-1-grandmaster@al2klimov.de>
In-Reply-To: <20200704172513.03815356@archlinux>
References: <20200704172513.03815356@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Changes in v2:
 Addressed https://lore.kernel.org/linux-iio/20200704172513.03815356@archlinux/

 drivers/iio/accel/adxl345_core.c     |  2 +-
 drivers/iio/adc/ad7949.c             |  2 +-
 drivers/iio/adc/ina2xx-adc.c         |  2 +-
 drivers/iio/adc/mcp320x.c            |  8 ++++----
 drivers/iio/adc/mcp3422.c            |  4 ++--
 drivers/iio/adc/ti-adc081c.c         |  6 +++---
 drivers/iio/adc/ti-adc0832.c         |  2 +-
 drivers/iio/adc/ti-adc084s021.c      |  2 +-
 drivers/iio/adc/ti-adc128s052.c      |  6 +++---
 drivers/iio/adc/ti-ads124s08.c       |  2 +-
 drivers/iio/adc/ti-ads7950.c         |  2 +-
 drivers/iio/adc/ti-ads8344.c         |  2 +-
 drivers/iio/adc/ti-tlc4541.c         |  4 ++--
 drivers/iio/adc/ti_am335x_adc.c      |  2 +-
 drivers/iio/adc/twl4030-madc.c       |  2 +-
 drivers/iio/dac/ti-dac082s085.c      | 12 ++++++------
 drivers/iio/dac/ti-dac5571.c         | 18 +++++++++---------
 drivers/iio/dac/ti-dac7311.c         |  2 +-
 drivers/iio/health/afe4403.c         |  2 +-
 drivers/iio/health/afe4404.c         |  2 +-
 drivers/iio/health/afe440x.h         |  2 +-
 drivers/iio/humidity/hdc100x.c       | 10 +++++-----
 drivers/iio/light/lv0104cs.c         |  2 +-
 drivers/iio/light/opt3001.c          |  2 +-
 drivers/iio/potentiometer/ad5272.c   |  2 +-
 drivers/iio/potentiometer/max5481.c  |  2 +-
 drivers/iio/potentiometer/mcp41010.c |  2 +-
 drivers/iio/potentiometer/mcp4131.c  |  2 +-
 drivers/iio/pressure/dlhl60d.c       |  2 +-
 drivers/iio/proximity/srf04.c        |  2 +-
 drivers/iio/proximity/srf08.c        |  6 +++---
 31 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 9c269799e6c1..71d36bde9727 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
  *
- * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
  */
 
 #include <linux/module.h>
diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 2c6f60edb7ce..3aba75b23bab 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2018 CMC NV
  *
- * http://www.analog.com/media/en/technical-documentation/data-sheets/AD7949.pdf
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/AD7949.pdf
  */
 
 #include <linux/delay.h>
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index bdd7cba6f6b0..de9924df437c 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -273,7 +273,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
  * Available averaging rates for ina226. The indices correspond with
  * the bit values expected by the chip (according to the ina226 datasheet,
  * table 3 AVG bit settings, found at
- * http://www.ti.com/lit/ds/symlink/ina226.pdf.
+ * https://www.ti.com/lit/ds/symlink/ina226.pdf.
  */
 static const int ina226_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
 
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 2c0eb5de110c..6a31ee970678 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -27,13 +27,13 @@
  * MCP3553
  *
  * Datasheet can be found here:
- * http://ww1.microchip.com/downloads/en/DeviceDoc/21293C.pdf  mcp3001
- * http://ww1.microchip.com/downloads/en/DeviceDoc/21294E.pdf  mcp3002
- * http://ww1.microchip.com/downloads/en/DeviceDoc/21295d.pdf  mcp3004/08
+ * https://ww1.microchip.com/downloads/en/DeviceDoc/21293C.pdf  mcp3001
+ * https://ww1.microchip.com/downloads/en/DeviceDoc/21294E.pdf  mcp3002
+ * https://ww1.microchip.com/downloads/en/DeviceDoc/21295d.pdf  mcp3004/08
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21290D.pdf  mcp3201
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21034D.pdf  mcp3202
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf  mcp3204/08
- * http://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf  mcp3301
+ * https://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf  mcp3301
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf  mcp3550/1/3
  */
 
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index d86c0b5d80a3..a0a3619ae3df 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -6,8 +6,8 @@
  * Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>
  *
  * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/22088b.pdf
- *            http://ww1.microchip.com/downloads/en/DeviceDoc/22226a.pdf
- *            http://ww1.microchip.com/downloads/en/DeviceDoc/22072b.pdf
+ *            https://ww1.microchip.com/downloads/en/DeviceDoc/22226a.pdf
+ *            https://ww1.microchip.com/downloads/en/DeviceDoc/22072b.pdf
  *
  * This driver exports the value of analog input voltage to sysfs, the
  * voltage unit is nV.
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 0235863ff77b..12cca86b85b0 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -6,9 +6,9 @@
  * Copyright (C) 2016 Intel
  *
  * Datasheets:
- *	http://www.ti.com/lit/ds/symlink/adc081c021.pdf
- *	http://www.ti.com/lit/ds/symlink/adc101c021.pdf
- *	http://www.ti.com/lit/ds/symlink/adc121c021.pdf
+ *	https://www.ti.com/lit/ds/symlink/adc081c021.pdf
+ *	https://www.ti.com/lit/ds/symlink/adc101c021.pdf
+ *	https://www.ti.com/lit/ds/symlink/adc121c021.pdf
  *
  * The devices have a very similar interface and differ mostly in the number of
  * bits handled. For the 8-bit and 10-bit models the least-significant 4 or 2
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 6ea39f4bbb37..9c469540d57a 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
  *
- * Datasheet: http://www.ti.com/lit/ds/symlink/adc0832-n.pdf
+ * Datasheet: https://www.ti.com/lit/ds/symlink/adc0832-n.pdf
  */
 
 #include <linux/module.h>
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index bdedf456ee05..e8df70fd3f49 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -4,7 +4,7 @@
  *
  * Driver for Texas Instruments' ADC084S021 ADC chip.
  * Datasheets can be found here:
- * http://www.ti.com/lit/ds/symlink/adc084s021.pdf
+ * https://www.ti.com/lit/ds/symlink/adc084s021.pdf
  */
 
 #include <linux/err.h>
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 1e5a936b5b6a..26e088bcbc34 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -4,9 +4,9 @@
  *
  * Driver for Texas Instruments' ADC128S052, ADC122S021 and ADC124S021 ADC chip.
  * Datasheets can be found here:
- * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
- * http://www.ti.com/lit/ds/symlink/adc122s021.pdf
- * http://www.ti.com/lit/ds/symlink/adc124s021.pdf
+ * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
+ * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
+ * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index f1ee3b1e2827..2e775c3eabd2 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* TI ADS124S0X chip family driver
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/err.h>
diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index f9edc1207f75..857ffed3ae00 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -9,7 +9,7 @@
  * Copyright 2012 CS Systemes d'Information
  *
  * And also on hwmon/ads79xx.c
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  *	Nishanth Menon
  */
 
diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index 8a8792010c20..aa0ad5df50ac 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -4,7 +4,7 @@
  *
  * Author: Gregory CLEMENT <gregory.clement@bootlin.com>
  *
- * Datasheet: http://www.ti.com/lit/ds/symlink/ads8344.pdf
+ * Datasheet: https://www.ti.com/lit/ds/symlink/ads8344.pdf
  */
 
 #include <linux/delay.h>
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 77620359b54c..571bbf9aea4d 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -5,8 +5,8 @@
  * Copyright (C) 2017 Phil Reid
  *
  * Datasheets can be found here:
- * http://www.ti.com/lit/gpn/tlc3541
- * http://www.ti.com/lit/gpn/tlc4541
+ * https://www.ti.com/lit/gpn/tlc3541
+ * https://www.ti.com/lit/gpn/tlc4541
  *
  * The tlc4541 requires 24 clock cycles to start a transfer.
  * Conversion then takes 2.94us to complete before data is ready
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 9d984f2a8ba7..350b85da0417 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -1,7 +1,7 @@
 /*
  * TI ADC MFD driver
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 472b08f37fea..05e3e51d26f9 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -5,7 +5,7 @@
  * conversion of analog signals like battery temperature,
  * battery type, battery level etc.
  *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  * J Keerthy <j-keerthy@ti.com>
  *
  * Based on twl4030-madc.c
diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
index 57b498d2a2a5..8ed2cc012ac1 100644
--- a/drivers/iio/dac/ti-dac082s085.c
+++ b/drivers/iio/dac/ti-dac082s085.c
@@ -4,12 +4,12 @@
  *
  * Copyright (C) 2017 KUNBUS GmbH
  *
- * http://www.ti.com/lit/ds/symlink/dac082s085.pdf
- * http://www.ti.com/lit/ds/symlink/dac102s085.pdf
- * http://www.ti.com/lit/ds/symlink/dac122s085.pdf
- * http://www.ti.com/lit/ds/symlink/dac084s085.pdf
- * http://www.ti.com/lit/ds/symlink/dac104s085.pdf
- * http://www.ti.com/lit/ds/symlink/dac124s085.pdf
+ * https://www.ti.com/lit/ds/symlink/dac082s085.pdf
+ * https://www.ti.com/lit/ds/symlink/dac102s085.pdf
+ * https://www.ti.com/lit/ds/symlink/dac122s085.pdf
+ * https://www.ti.com/lit/ds/symlink/dac084s085.pdf
+ * https://www.ti.com/lit/ds/symlink/dac104s085.pdf
+ * https://www.ti.com/lit/ds/symlink/dac124s085.pdf
  */
 
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 3a2bb0efe50d..61974563d1e5 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -4,15 +4,15 @@
  *
  * Copyright (C) 2018 Prevas A/S
  *
- * http://www.ti.com/lit/ds/symlink/dac5571.pdf
- * http://www.ti.com/lit/ds/symlink/dac6571.pdf
- * http://www.ti.com/lit/ds/symlink/dac7571.pdf
- * http://www.ti.com/lit/ds/symlink/dac5574.pdf
- * http://www.ti.com/lit/ds/symlink/dac6574.pdf
- * http://www.ti.com/lit/ds/symlink/dac7574.pdf
- * http://www.ti.com/lit/ds/symlink/dac5573.pdf
- * http://www.ti.com/lit/ds/symlink/dac6573.pdf
- * http://www.ti.com/lit/ds/symlink/dac7573.pdf
+ * https://www.ti.com/lit/ds/symlink/dac5571.pdf
+ * https://www.ti.com/lit/ds/symlink/dac6571.pdf
+ * https://www.ti.com/lit/ds/symlink/dac7571.pdf
+ * https://www.ti.com/lit/ds/symlink/dac5574.pdf
+ * https://www.ti.com/lit/ds/symlink/dac6574.pdf
+ * https://www.ti.com/lit/ds/symlink/dac7574.pdf
+ * https://www.ti.com/lit/ds/symlink/dac5573.pdf
+ * https://www.ti.com/lit/ds/symlink/dac6573.pdf
+ * https://www.ti.com/lit/ds/symlink/dac7573.pdf
  */
 
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
index 6f5df1a30a1c..6ef98f0d9999 100644
--- a/drivers/iio/dac/ti-dac7311.c
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2018 CMC NV
  *
- * http://www.ti.com/lit/ds/symlink/dac7311.pdf
+ * https://www.ti.com/lit/ds/symlink/dac7311.pdf
  */
 
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index e9f87e42ff4f..3d8dd5c94832 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -2,7 +2,7 @@
 /*
  * AFE4403 Heart Rate Monitors and Low-Cost Pulse Oximeters
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  */
 
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index e728bbb21ca8..978e016975be 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -2,7 +2,7 @@
 /*
  * AFE4404 Heart Rate Monitors and Low-Cost Pulse Oximeters
  *
- * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  */
 
diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
index 7829c4fcd03b..0adea0047eba 100644
--- a/drivers/iio/health/afe440x.h
+++ b/drivers/iio/health/afe440x.h
@@ -2,7 +2,7 @@
 /*
  * AFE440X Heart Rate Monitors and Low-Cost Pulse Oximeters
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
  *	Andrew F. Davis <afd@ti.com>
  */
 
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 7ecd2ffa3132..826dfe17a7f3 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -6,11 +6,11 @@
  * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * Datasheets:
- * http://www.ti.com/product/HDC1000/datasheet
- * http://www.ti.com/product/HDC1008/datasheet
- * http://www.ti.com/product/HDC1010/datasheet
- * http://www.ti.com/product/HDC1050/datasheet
- * http://www.ti.com/product/HDC1080/datasheet
+ * https://www.ti.com/product/HDC1000/datasheet
+ * https://www.ti.com/product/HDC1008/datasheet
+ * https://www.ti.com/product/HDC1010/datasheet
+ * https://www.ti.com/product/HDC1050/datasheet
+ * https://www.ti.com/product/HDC1080/datasheet
  */
 
 #include <linux/delay.h>
diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
index 55b8e2855647..f7c9a8398ec0 100644
--- a/drivers/iio/light/lv0104cs.c
+++ b/drivers/iio/light/lv0104cs.c
@@ -7,7 +7,7 @@
  *
  * 7-bit I2C slave address: 0x13
  *
- * Link to data sheet: http://www.onsemi.com/pub/Collateral/LV0104CS-D.PDF
+ * Link to data sheet: https://www.onsemi.com/pub/Collateral/LV0104CS-D.PDF
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 82abfa57b59c..1d789196a93f 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -2,7 +2,7 @@
 /**
  * opt3001.c - Texas Instruments OPT3001 Light Sensor
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Andreas Dannenberg <dannenberg@ti.com>
  * Based on previous work from: Felipe Balbi <balbi@ti.com>
diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index 154f9a5da8bc..b1f47535392b 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -3,7 +3,7 @@
  * Analog Devices AD5272 digital potentiometer driver
  * Copyright (C) 2018 Phil Reid <preid@electromag.com.au>
  *
- * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/AD5272_5274.pdf
+ * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5272_5274.pdf
  *
  * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
  * ad5272	1	1024		20, 50, 100		01011xx
diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index 732375b6d131..3ec750381243 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -4,7 +4,7 @@
  * Copyright 2016 Rockwell Collins
  *
  * Datasheet:
- * http://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
+ * https://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/iio/potentiometer/mcp41010.c b/drivers/iio/potentiometer/mcp41010.c
index 2368b39debf5..e4932b456732 100644
--- a/drivers/iio/potentiometer/mcp41010.c
+++ b/drivers/iio/potentiometer/mcp41010.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2018 Chris Coffey <cmc@babblebit.net>
  * Based on: Slawomir Stepien's code from mcp4131.c
  *
- * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
+ * Datasheet: https://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
  *
  * DEVID	#Wipers	#Positions	Resistance (kOhm)
  * mcp41010	1	256		10
diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index 98df91e97f2f..5e4d0751e49c 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2016 Slawomir Stepien
  * Based on: Peter Rosin's code from mcp4531.c
  *
- * Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22060b.pdf
+ * Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/22060b.pdf
  *
  * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)
  * mcp4131	1	129		5, 10, 50, 100
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index b8c99e7bd6cf..c989893ef1dc 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2019 AVL DiTEST GmbH
  *   Tomislav Denis <tomislav.denis@avl.com>
  *
- * Datasheet: http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
+ * Datasheet: https://www.allsensors.com/cad/DS-0355_Rev_B.PDF
  */
 
 #include <linux/module.h>
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 568b76e06385..6d509040b358 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2017 Andreas Klinger <ak@it-klinger.de>
  *
  * For details about the device see:
- * http://www.robot-electronics.co.uk/htm/srf04tech.htm
+ * https://www.robot-electronics.co.uk/htm/srf04tech.htm
  *
  * the measurement cycle as timing diagram looks like:
  *
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index b23ce446b7be..7b539127fcc2 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -7,9 +7,9 @@
  * Copyright (c) 2016, 2017 Andreas Klinger <ak@it-klinger.de>
  *
  * For details about the device see:
- * http://www.robot-electronics.co.uk/htm/srf08tech.html
- * http://www.robot-electronics.co.uk/htm/srf10tech.htm
- * http://www.robot-electronics.co.uk/htm/srf02tech.htm
+ * https://www.robot-electronics.co.uk/htm/srf08tech.html
+ * https://www.robot-electronics.co.uk/htm/srf10tech.htm
+ * https://www.robot-electronics.co.uk/htm/srf02tech.htm
  */
 
 #include <linux/err.h>
-- 
2.27.0

