Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A35AC5CA
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406565AbfIGJUb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 05:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388924AbfIGJUa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 05:20:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C39321907;
        Sat,  7 Sep 2019 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567848029;
        bh=kNGAeMnxvdXlA5z3Dc2JoX9K2D1dYgnE5dY/Pa4e/rU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RlXjtBMtEIK7dgmUEEbVbHPMJxgMv1gIygNPsQYOqbZqaGfPssGUrAa9QjlDviHOF
         iMRoC4mMevtJGnxRtl33iH5GH3ALBZsHNLCVBnhqa8/oKQr/OcBvoAvsPyLLJacH0n
         DC2y9AjIo/A6nbZIEPodP55H6rN++sLeHbm57s5Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH v2 02/11] dt-bindings: power: syscon-poweroff: Convert bindings to json-schema
Date:   Sat,  7 Sep 2019 11:19:58 +0200
Message-Id: <20190907092007.9946-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907092007.9946-1-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the Syscon poweroff bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove unneeded maxItems from uint32 fields,
2. Simplify if-else-then.
---
 .../bindings/power/reset/syscon-poweroff.txt  | 30 ----------
 .../bindings/power/reset/syscon-poweroff.yaml | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
deleted file mode 100644
index 022ed1f3bc80..000000000000
--- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Generic SYSCON mapped register poweroff driver
-
-This is a generic poweroff driver using syscon to map the poweroff register.
-The poweroff is generally performed with a write to the poweroff register
-defined by the register map pointed by syscon reference plus the offset
-with the value and mask defined in the poweroff node.
-
-Required properties:
-- compatible: should contain "syscon-poweroff"
-- regmap: this is phandle to the register map node
-- offset: offset in the register map for the poweroff register (in bytes)
-- value: the poweroff value written to the poweroff register (32 bit access)
-
-Optional properties:
-- mask: update only the register bits defined by the mask (32 bit)
-
-Legacy usage:
-If a node doesn't contain a value property but contains a mask property, the
-mask property is used as the value.
-
-Default will be little endian mode, 32 bit access only.
-
-Examples:
-
-	poweroff {
-	   compatible = "syscon-poweroff";
-	   regmap = <&regmapnode>;
-	   offset = <0x0>;
-	   mask = <0x7a>;
-	};
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
new file mode 100644
index 000000000000..fb812937b534
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/syscon-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic SYSCON mapped register poweroff driver
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |+
+  This is a generic poweroff driver using syscon to map the poweroff register.
+  The poweroff is generally performed with a write to the poweroff register
+  defined by the register map pointed by syscon reference plus the offset
+  with the value and mask defined in the poweroff node.
+  Default will be little endian mode, 32 bit access only.
+
+properties:
+  compatible:
+    const: syscon-poweroff
+
+  mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Update only the register bits defined by the mask (32 bit).
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the poweroff register (in bytes).
+
+  regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the register map node.
+
+  value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The poweroff value written to the poweroff register (32 bit access).
+
+required:
+  - compatible
+  - regmap
+  - offset
+
+allOf:
+  - if:
+      not:
+        required:
+          - mask
+    then:
+      required:
+        - value
+
+examples:
+  - |
+    poweroff {
+      compatible = "syscon-poweroff";
+      regmap = <&regmapnode>;
+      offset = <0x0>;
+      mask = <0x7a>;
+    };
-- 
2.17.1

