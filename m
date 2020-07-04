Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC2E21486B
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGDTeC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 15:34:02 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:34908 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgGDTeC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 15:34:02 -0400
X-Greylist: delayed 88580 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jul 2020 15:34:00 EDT
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 6FB43BC07E;
        Sat,  4 Jul 2020 19:33:56 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     michael.hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        ribalda@kernel.org, tomislav.denis@avl.com,
        grandmaster@al2klimov.de, sboyd@kernel.org, ak@it-klinger.de,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Replace HTTP links with HTTPS ones: Documentation/devicetree/bindings/iio
Date:   Sat,  4 Jul 2020 21:33:45 +0200
Message-Id: <20200704193345.18847-1-grandmaster@al2klimov.de>
In-Reply-To: <20200704173459.78ceec60@archlinux>
References: <20200704173459.78ceec60@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
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
 Addressed https://lore.kernel.org/linux-iio/20200704173459.78ceec60@archlinux/

 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml  | 4 ++--
 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt      | 2 +-
 Documentation/devicetree/bindings/iio/iio-bindings.txt        | 2 +-
 Documentation/devicetree/bindings/iio/light/apds9300.txt      | 2 +-
 Documentation/devicetree/bindings/iio/light/apds9960.txt      | 2 +-
 Documentation/devicetree/bindings/iio/light/opt3001.txt       | 2 +-
 Documentation/devicetree/bindings/iio/light/vl6180.txt        | 2 +-
 .../devicetree/bindings/iio/potentiometer/mcp41010.txt        | 2 +-
 .../devicetree/bindings/iio/potentiostat/lmp91000.txt         | 4 ++--
 .../devicetree/bindings/iio/pressure/asc,dlhl60d.yaml         | 2 +-
 .../devicetree/bindings/iio/proximity/devantech-srf04.yaml    | 4 ++--
 11 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index d124eba1ce54..fd4eaa3d0ab4 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -12,8 +12,8 @@ maintainers:
 description: |
   Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers that supports
   both I2C & SPI interfaces.
-    http://www.analog.com/en/products/mems/accelerometers/adxl345.html
-    http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
+    https://www.analog.com/en/products/mems/accelerometers/adxl345.html
+    https://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
index 639c94ed83e9..17af395b99d9 100644
--- a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
@@ -6,7 +6,7 @@ Is is programmable through an SPI interface.
 
 The internal DACs are loaded when the LOADDACS pin is pulled down.
 
-http://www.ti.com/lit/ds/sbas106/sbas106.pdf
+https://www.ti.com/lit/ds/sbas106/sbas106.pdf
 
 Required Properties:
 - compatible: Should be one of:
diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index af33267727f4..aa63cac7323e 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -9,7 +9,7 @@ specifier is an array of one or more cells identifying the IIO
 output on a device. The length of an IIO specifier is defined by the
 value of a #io-channel-cells property in the IIO provider node.
 
-[1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
+[1] https://marc.info/?l=linux-iio&m=135902119507483&w=2
 
 ==IIO providers==
 
diff --git a/Documentation/devicetree/bindings/iio/light/apds9300.txt b/Documentation/devicetree/bindings/iio/light/apds9300.txt
index aa199e09a493..3aa6db3ee99d 100644
--- a/Documentation/devicetree/bindings/iio/light/apds9300.txt
+++ b/Documentation/devicetree/bindings/iio/light/apds9300.txt
@@ -1,6 +1,6 @@
 * Avago APDS9300 ambient light sensor
 
-http://www.avagotech.com/docs/AV02-1077EN
+https://www.avagotech.com/docs/AV02-1077EN
 
 Required properties:
 
diff --git a/Documentation/devicetree/bindings/iio/light/apds9960.txt b/Documentation/devicetree/bindings/iio/light/apds9960.txt
index 3af325ad194b..c53ddb81c4aa 100644
--- a/Documentation/devicetree/bindings/iio/light/apds9960.txt
+++ b/Documentation/devicetree/bindings/iio/light/apds9960.txt
@@ -1,6 +1,6 @@
 * Avago APDS9960 gesture/RGB/ALS/proximity sensor
 
-http://www.avagotech.com/docs/AV02-4191EN
+https://www.avagotech.com/docs/AV02-4191EN
 
 Required properties:
 
diff --git a/Documentation/devicetree/bindings/iio/light/opt3001.txt b/Documentation/devicetree/bindings/iio/light/opt3001.txt
index 47b13eb8f4ec..9e6f2998e751 100644
--- a/Documentation/devicetree/bindings/iio/light/opt3001.txt
+++ b/Documentation/devicetree/bindings/iio/light/opt3001.txt
@@ -6,7 +6,7 @@ the optional generation of IIO events on rising/falling light threshold changes
 requires the use of interrupts. Without interrupts, only the simple reading
 of the current light value is supported through the IIO API.
 
-http://www.ti.com/product/opt3001
+https://www.ti.com/product/opt3001
 
 Required properties:
   - compatible: should be "ti,opt3001"
diff --git a/Documentation/devicetree/bindings/iio/light/vl6180.txt b/Documentation/devicetree/bindings/iio/light/vl6180.txt
index 2c52952715a0..fb9137d85df9 100644
--- a/Documentation/devicetree/bindings/iio/light/vl6180.txt
+++ b/Documentation/devicetree/bindings/iio/light/vl6180.txt
@@ -1,6 +1,6 @@
 STMicro VL6180 -  ALS, range and proximity sensor
 
-Link to datasheet: http://www.st.com/resource/en/datasheet/vl6180x.pdf
+Link to datasheet: https://www.st.com/resource/en/datasheet/vl6180x.pdf
 
 Required properties:
 
diff --git a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
index 566711b9950c..4f245e8469fd 100644
--- a/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
+++ b/Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
@@ -1,7 +1,7 @@
 * Microchip MCP41010/41050/41100/42010/42050/42100 Digital Potentiometer
 
 Datasheet publicly available at:
-http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
+https://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
 
 The node for this driver must be a child node of a SPI controller, hence
 all mandatory properties described in
diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
index e6d0c2eb345c..f3ab02b0dd41 100644
--- a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
+++ b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
@@ -1,7 +1,7 @@
 * Texas Instruments LMP91000 series of potentiostats
 
-LMP91000: http://www.ti.com/lit/ds/symlink/lmp91000.pdf
-LMP91002: http://www.ti.com/lit/ds/symlink/lmp91002.pdf
+LMP91000: https://www.ti.com/lit/ds/symlink/lmp91000.pdf
+LMP91002: https://www.ti.com/lit/ds/symlink/lmp91002.pdf
 
 Required properties:
 
diff --git a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
index 64c18f1693f0..be2be4b556db 100644
--- a/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
@@ -13,7 +13,7 @@ description: |
   Bindings for the All Sensors DLH series pressure sensors.
 
   Specifications about the sensors can be found at:
-    http://www.allsensors.com/cad/DS-0355_Rev_B.PDF
+    https://www.allsensors.com/cad/DS-0355_Rev_B.PDF
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
index f86f8b23ef18..ce795279839e 100644
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -17,9 +17,9 @@ description: |
     until it is received once again
 
   Specifications about the devices can be found at:
-  http://www.robot-electronics.co.uk/htm/srf04tech.htm
+  https://www.robot-electronics.co.uk/htm/srf04tech.htm
 
-  http://www.maxbotix.com/documents/LV-MaxSonar-EZ_Datasheet.pdf
+  https://www.maxbotix.com/documents/LV-MaxSonar-EZ_Datasheet.pdf
 
 properties:
   compatible:
-- 
2.27.0

