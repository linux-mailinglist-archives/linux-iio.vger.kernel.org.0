Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C3FBBAAF
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2019 19:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394181AbfIWRrD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Sep 2019 13:47:03 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbfIWRrD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2019 13:47:03 -0400
Received: from localhost ([46.183.103.8]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTikV-1ibaZH1myj-00U6mY; Mon, 23 Sep 2019 19:46:38 +0200
Date:   Mon, 23 Sep 2019 19:46:34 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: maxbotix,mb1232.yaml: transform to yaml
Message-ID: <20190923174605.mhrbmdic3ynaw22o@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Fan6vgtAYstQ9EsYsO6l1PGcJWJzGhm7B7DfBKFUat6EzC703YH
 8oI9GI5mpy2w07uxgH3pzFOyGA+jyhV+HoSw7qPEGW7lOWrhvP/UtP+qNJ2cHCueZTUGjSe
 uJDuDulVUzUZgi7U+vahnHcKfRFtfGHdvTm4aklSLU4vNVnUrZMFN71YGTGQYFyArKhFvHf
 QLc6PSodvrixVGZYXXVaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M0QNqFl7cB0=:DTk2VE7Np88/QhC2VQhDWa
 TThd5wzZs/k5hNPjw13wqTzy+v+OGSPwKQlGC6El92OBefoH1p7gf3Hs2a7J/+PlwMm0J2IgU
 DGSrsg5wBOCHeehn6P/dmrmtef6lwJwXrfJ8P0NGI1WncUOOt3zCT6v3knu78XC9CcP6IzZp8
 BBtdUYdZJwvicScAGtN3/y3iYSvK97SPaMFIKqr4fefdJJNILpiqQqmoTH00xWrGe2bx+IUFa
 4+QBWD/3TJr2mHsuTwvWgo+TbFrEeuOfGTqE1fD0EfWI8twqd6af7ehh/jQTnGt976eAErXOB
 qxyM/i57Zi+uHavej0IB55r1dYcqgfAMiIWv9CISxmQO9HAEjPKv7iIEI0bAhpsJTd6Ss3IpY
 G4b7pOCQIdYUmmnQRP30VRkIpBmt4Q2A9KM6QMj2T5H5EZpAwbcGEXXFmpIISethKeFepW1vy
 MJNCFDBeaGdSwbNH0LFpQ30nCYnICHjTHsvW4vRK93YPfhAjqMRRnx7XPrZYQNmQgb+7+zueq
 nZ9Y3+yrJpb5WRjoiBWBwfUYr9sgAwErZi39p0zwgKOxqhFMxalxlxfyvx5hc9Uh7XYFiznGh
 ELRdmPttS1Ev9iTCFiBoFfXauxsyBphbFLTDmFtcL7iRHTHRXzghTLsKQqJfBnvImIUQIjI6c
 0sUO7ELi2VnHPY6FCWW9OYlYyiLLRm+/AJYdXTspWbHWXI1Wxmhakr+UThHmo5XBvEE8fECCu
 JjvYIf5PCPf8uUaRDVb3EoRbncW+mlD15qxFTy7eVzjcNaNGnbcS1E30ygmx9tdINg7yo1y78
 zosmwyF3qN2g3vhx5hbQDeI0IQ5shdPqUp1w19hMCzq3onGFeJ/xSxlkzpJOFi4kc9fZHYldg
 FEpI4H+njx+KH9jLzpGBCsDXP++0IDgpR1zNXc4Zw=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

transform existing documentation of maxbotix,mb1232 ultrasonic ranger
from text documentation format into yaml.

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
index 000000000000..8301a1ad2a47
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
+    description:
+      i2c address of the device, see also i2c/i2c.txt
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
