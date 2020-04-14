Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329861A8F65
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 02:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634501AbgDNX5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 19:57:03 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:51180 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1732541AbgDNX5C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 19:57:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id A5A8F20156CF;
        Wed, 15 Apr 2020 07:56:58 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rITjnQJBjKIy; Wed, 15 Apr 2020 07:56:58 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 8AB8F2001496;
        Wed, 15 Apr 2020 07:56:58 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 879A2C019EC;
        Wed, 15 Apr 2020 07:56:58 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 81CC9201602; Wed, 15 Apr 2020 07:56:58 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     chris.ruehl@gtsys.com.hk
Cc:     devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml
Date:   Wed, 15 Apr 2020 07:56:04 +0800
Message-Id: <20200414235609.20125-4-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414235609.20125-1-chris.ruehl@gtsys.com.hk>
References: <20200414235609.20125-1-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Conversion of the ltc2632 to yaml format and name the file 'lltc,ltc2632.yaml'.

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 .../bindings/iio/dac/lltc,ltc2632.yaml        | 78 +++++++++++++++++++
 .../devicetree/bindings/iio/dac/ltc2632.txt   | 49 ------------
 2 files changed, 78 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
new file mode 100644
index 000000000000..314bf700d934
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+# Copyright 2020 Christopher Ruehl <chris.ruehl@gtsys.com.hk>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Bindings for the Linear Technology LTC2632/2634/2636 DAC
+  Datasheet can be found here: https://www.analog.com/media/en/technical-documentation/data-sheets/LTC263[246].pdf
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc2632-l12
+      - lltc,ltc2632-l10
+      - lltc,ltc2632-l8
+      - lltc,ltc2632-h12
+      - lltc,ltc2632-h10
+      - lltc,ltc2632-h8
+      - lltc,ltc2634-l12
+      - lltc,ltc2634-l10
+      - lltc,ltc2634-l8
+      - lltc,ltc2634-h12
+      - lltc,ltc2634-h10
+      - lltc,ltc2634-h8
+      - lltc,ltc2636-l12
+      - lltc,ltc2636-l10
+      - lltc,ltc2636-l8
+      - lltc,ltc2636-h12
+      - lltc,ltc2636-h10
+      - lltc,ltc2636-h8
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 2000000
+
+  vref-supply:
+    description:
+	  Phandle to the external reference voltage supply. This should
+      only be set if there is an external reference voltage connected to the VREF
+      pin. If the property is not set the internal reference is used.
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    vref: regulator-vref {
+        compatible = "regulator-fixed";
+        regulator-name = "vref-ltc2632";
+        regulator-min-microvolt = <1250000>;
+        regulator-max-microvolt = <1250000>;
+        regulator-always-on;
+    };
+
+    spi_master {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dac: ltc2632@0 {
+        compatible = "lltc,ltc2632";
+        reg = <0>;    /* CS0 */
+        spi-max-frequency = <1000000>;
+        vref-supply = <&vref>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
deleted file mode 100644
index 1ab9570cf219..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Linear Technology LTC2632/2634/2636 DAC
-
-Required properties:
- - compatible: Has to contain one of the following:
-	lltc,ltc2632-l12
-	lltc,ltc2632-l10
-	lltc,ltc2632-l8
-	lltc,ltc2632-h12
-	lltc,ltc2632-h10
-	lltc,ltc2632-h8
-	lltc,ltc2634-l12
-	lltc,ltc2634-l10
-	lltc,ltc2634-l8
-	lltc,ltc2634-h12
-	lltc,ltc2634-h10
-	lltc,ltc2634-h8
-	lltc,ltc2636-l12
-	lltc,ltc2636-l10
-	lltc,ltc2636-l8
-	lltc,ltc2636-h12
-	lltc,ltc2636-h10
-	lltc,ltc2636-h8
-
-Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
-apply. In particular, "reg" and "spi-max-frequency" properties must be given.
-
-Optional properties:
-	- vref-supply: Phandle to the external reference voltage supply. This should
-	  only be set if there is an external reference voltage connected to the VREF
-	  pin. If the property is not set the internal reference is used.
-
-Example:
-
-	vref: regulator-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref-ltc2632";
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1250000>;
-		regulator-always-on;
-	};
-
-	spi_master {
-		dac: ltc2632@0 {
-			compatible = "lltc,ltc2632-l12";
-			reg = <0>; /* CS0 */
-			spi-max-frequency = <1000000>;
-			vref-supply = <&vref>; /* optional */
-		};
-	};
-- 
2.20.1

