Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C015219EBAC
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 15:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDENun (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 09:50:43 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44838 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgDENun (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 09:50:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7CA19FB04;
        Sun,  5 Apr 2020 15:50:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sg_tHY6aIAbQ; Sun,  5 Apr 2020 15:50:37 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EF26C414C6; Sun,  5 Apr 2020 15:50:32 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v4 1/5] dt-bindings: iio: vcnl4000: convert bindings to YAML format
Date:   Sun,  5 Apr 2020 15:50:28 +0200
Message-Id: <fa148ef5a3e27f7acc0a675217524453ca010575.1586094535.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1586094535.git.agx@sigxcpu.org>
References: <cover.1586094535.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the vcnl4000 device tree bindings to the new YAML format.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/light/vcnl4000.txt           | 24 ----------
 .../bindings/iio/light/vishay,vcnl4000.yaml   | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
deleted file mode 100644
index 955af4555c90..000000000000
--- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-VISHAY VCNL4000 -  Ambient Light and proximity sensor
-
-This driver supports the VCNL4000/10/20/40 and VCNL4200 chips
-
-Required properties:
-
-	-compatible: must be one of :
-        vishay,vcnl4000
-        vishay,vcnl4010
-        vishay,vcnl4020
-        vishay,vcnl4040
-        vishay,vcnl4200
-
-	-reg: I2C address of the sensor, should be one from below based on the model:
-        0x13
-        0x51
-        0x60
-
-Example:
-
-light-sensor@51 {
-	compatible = "vishay,vcnl4200";
-	reg = <0x51>;
-};
diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
new file mode 100644
index 000000000000..21ef2eb7a205
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,vcnl4000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VISHAY VCNL4000 ambient light and proximity sensor
+
+maintainers:
+  - Peter Meerwald <pmeerw@pmeerw.net>
+
+description: |
+  Ambient light sensing with proximity detection over an i2c
+  interface.
+
+properties:
+  compatible:
+    enum:
+      - vishay,vcnl4000
+      - vishay,vcnl4010
+      - vishay,vcnl4020
+      - vishay,vcnl4040
+      - vishay,vcnl4200
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+- |
+  i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      light-sensor@51 {
+              compatible = "vishay,vcnl4200";
+              reg = <0x51>;
+      };
+  };
+...
-- 
2.23.0

