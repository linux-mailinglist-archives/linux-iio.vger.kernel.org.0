Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165F7CD23D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 16:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfJFO1s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 10:27:48 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfJFO1s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 10:27:48 -0400
Received: from localhost ([89.204.130.45]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGQWr-1iK5WR21YD-00Gt1q; Sun, 06 Oct 2019 16:27:30 +0200
Date:   Sun, 6 Oct 2019 16:27:25 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iio: maxbotix,mb1232.yaml: transform to yaml
Message-ID: <20191006142715.45k64cgw7mzlekm5@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:hsUfaTgosEV7amE7feQIBikFio7g0T5/tjrcIq3gpeVamcNr4Tu
 YRhnnNXWe6jGB1FAC0Sk+Fpc74D3FDCvCPdZ+BvqhewFnGA3rlx3lZpBLYbr/A38oI0PSpd
 AESLUzO2xKznEQbw2gXEk4WHB8momlJrfMSFYsuIhA95KMDkMu4M+SLFaElzsDv5OzXeAY2
 v3CPwCmdT909QkEG8UmnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8VIWqkWXIzI=:5iwjz5UfkPzhoutpLsQOr1
 ZXHhCm0/2l2eYbu7nO4KiTZ5+L+WchMcmHKDy/QhVs6ErFdFSCR9QdTK8c9FBj7onbVrAshfr
 Cu1/vKrpazuuqkxec1+sJyYwafpRTHrl6gXU/Y9uSj+8jypjGP69ErU0Iy0VOyW3k8SLQVsd3
 gz8mJHNei4sE83wT0C66N+LzE2ueIC81YUzAYePymYVZvfhLgx3hY9998lYKeXCQ+AXyKNAJ5
 G8OnsBdgUM9TsyRcUZmmKEk2f/xib5maQPbfKGBGLk6J/bclzL21zLffRjSMwr8RbFr/a8t6x
 AWoSOrt9tOKb1JWEc+6LHAQPEX4AxlIqyL6oUN77ICu+O4DkXBQafV07zsZbYxiOl+YZgsqNa
 797TZHSRyNdzrhLoNgDWiwRPIbcc/MgVwyZRK4phVGAlZ5TCo8HbSOn2o1tsf/VhegmIxhIrD
 gfT2JImGsO9Na5zZC+SvcSA/onB9WLfI9URDOwzYvkbwe+cpZrLcJoKJ5agt9tQuykGsLeAot
 rzqpqHcSv7QKNXXYB2Ub3Ye+vDcvAsdZ1V4Vkw4+Y2plmR0PxLioY8uALQB890qGoVw+pUOFB
 P9OzWSViKAlUiDdUDwlGT9PenKP8QW+UBxvKNq0UMVLGYGEnB8B4VTU5fhEgUgLhoTisW8ND3
 gUk+50vkGW2JUc7Mu2pepGPbmotYQov122J5IwAR0Q0iZn8m+vd9+vXYFCttPGvuxSTdiiV5G
 8KGBjyn1v9+EZKEGgsMimKpEfwRd0CIuH3N8cP5okLauszvb/U3mU0KtNSqDc3m9qnIEJzP5S
 8KC+0+GngRayMY7LCC1c5L/0lgNCQlQiu+MdTd3hBwp235C/cCApMVsOl9suiR/PIDUVktA8j
 NLB02+r1VrHmmuLnvnnw==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

transform existing documentation of maxbotix,mb1232 ultrasonic ranger
from text documentation format into yaml.

Changes in v2:
- removed description of reg property
- added a line:
  additionalProperties: false

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/maxbotix,mb1232.txt     | 29 -----------
 .../bindings/iio/proximity/maxbotix,mb1232.yaml    | 56 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 29 deletions(-)
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
index 000000000000..e2fb1f6d4dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
@@ -0,0 +1,56 @@
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
+    proximity@70 {
+      compatible = "maxbotix,mb1232";
+      reg = <0x70>;
+      interrupt-parent = <&gpio2>;
+      interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+    };
-- 
2.11.0
