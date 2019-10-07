Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88E9CEA05
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 19:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfJGRCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 13:02:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGRCk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 13:02:40 -0400
Received: from localhost ([82.212.252.42]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MrPVJ-1hn6vf1KA3-00oUjS; Mon, 07 Oct 2019 19:02:24 +0200
Date:   Mon, 7 Oct 2019 19:02:20 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: maxbotix,mb1232.yaml: transform to yaml
Message-ID: <20191007170219.xfipsry5nk4raiem@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:xxbsipgqywTVmxBZp91ZiKC+MBBD68T9Zw0bMWt9DI/YfwmpBlJ
 0zkIo8Xjxe7znePELaRxnvFWtNQPh4ZLdjfqrCK6iYahxuObASJ9/5fwFCDLm4AGLHCLZb6
 fKkVDuO18/zcEO3gWssHLIGQqWUdS0ezuAgJNZejkpvoB0G/a+svlRUkGaqxKHOEnh54U5N
 uxTBoi6opnYJNS71Gl/2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WvVXiygURg4=:YuKnj1XLkdBTDngb12vgxh
 nzOeJtyeKfCWcqjS15hkBVoHW4+/UCtyz7q5RtyTOFpPsMal5EMOfn77KGyCEodXr7RA10oBu
 bT/C/+rr8M/+QI8PWinf+bBLGaJVfZ20/r58/WXMnei6gdKB+NKHjWMSBd32ctfTgGeVBnR50
 MhD+X/9zZBuLryLQFwhxFwPBHfhUqhN9boLXrLAoQW2e4eg4aqKi96f8dMvMDyqPQwKPM9hLr
 C9Zstr/aQ1Dlxgp+FDjFAIUPn6iYvqvvveLv4a/eKr8QIHAY+Cyiadh5zxxUJ4FmU0iZpGP0l
 /gV6GE4YtM/WwQcbjpoHtcFxfEz1rCQHgcrLfjGPaVFM3GHo+6qJEfMYCR7/cm9OUJ5Y3lNxg
 Aji6V08CfByxsr78eApzvwJWUehIfQIDIxAKpdwFkyt0QNcWIXiIl09EtWVRRUNNfWR5f6zky
 6S+aORgkGz3COkjEdfllWPcMNvk4h70kzZksHUZDuFTdW1hddCqNy1jAIt/9dTjf86EpxVkLm
 idf3cR3smGEFd5kbZ0zPaLitmZCbm3PvBw8Akwsp/EExs7z4I8u5WZcq/HfKEncIkbXslw85J
 lanjhFnQrITw2n7vUH5O9kYCTizIZ3sVALbWp4nXvQunHSquTK2tEyx9n8f58mTkkYSW6EpWo
 nIlbmw5FzZ/c0m9CRsFkTVhnMqD1JsVKS/V1R226XHGhHL3MXCtA5iy7xISDKhUZCK7Gpq24h
 vwOKK3cUH9DPJFEUP7p0+iZZMKnBAGNgdTE53oZdG4BRBzGqvCV6qy6EUDyO2mnCj9vh6F21L
 G2G4JOpvsegLr6MzVpOzAifYOJLUG+hOCeiVhTW5iZw0RB5gWgj5uDUbAu9nb7OU7/oR7Q2Tn
 NgigUuV1y371aW2msVEA==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

transform existing documentation of maxbotix,mb1232 ultrasonic ranger
from text documentation format into yaml.

Changes in v3:
- add a i2c node around device node to set up #address-cells and
  #size-cells for omitting error during make dt_binding_check

Changes in v2:
- removed description of reg property
- added a line:
  additionalProperties: false

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/maxbotix,mb1232.txt     | 29 -----------
 .../bindings/iio/proximity/maxbotix,mb1232.yaml    | 60 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
deleted file mode 100644
index dd1058fbe9c3..000000000000
--- a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
-  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
-  for ranging
-
-Required properties:
- - compatible:		"maxbotix,mb1202",
-			"maxbotix,mb1212",
-			"maxbotix,mb1222",
-			"maxbotix,mb1232",
-			"maxbotix,mb1242",
-			"maxbotix,mb7040" or
-			"maxbotix,mb7137"
-
- - reg:			i2c address of the device, see also i2c/i2c.txt
-
-Optional properties:
- - interrupts:		Interrupt used to announce the preceding reading
-			request has finished and that data is available.
-			If no interrupt is specified the device driver
-			falls back to wait a fixed amount of time until
-			data can be retrieved.
-
-Example:
-proximity@70 {
-	compatible = "maxbotix,mb1232";
-	reg = <0x70>;
-	interrupt-parent = <&gpio2>;
-	interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
-};
diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
new file mode 100644
index 000000000000..3eac248f291d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/maxbotix,mb1232.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MaxBotix I2CXL-MaxSonar ultrasonic distance sensor
+
+maintainers:
+  - Andreas Klinger <ak@it-klinger.de>
+
+description: |
+  MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
+  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
+  for ranging
+
+  Specifications about the devices can be found at:
+  https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxbotix,mb1202
+      - maxbotix,mb1212
+      - maxbotix,mb1222
+      - maxbotix,mb1232
+      - maxbotix,mb1242
+      - maxbotix,mb7040
+      - maxbotix,mb7137
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt used to announce the preceding reading request has finished
+      and that data is available.  If no interrupt is specified the device
+      driver falls back to wait a fixed amount of time until data can be
+      retrieved.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@70 {
+        compatible = "maxbotix,mb1232";
+        reg = <0x70>;
+        interrupt-parent = <&gpio2>;
+        interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+      };
+    };
-- 
2.11.0
