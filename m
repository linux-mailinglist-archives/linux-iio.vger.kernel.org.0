Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A440AC5B1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406676AbfIGJVF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 05:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406642AbfIGJVE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Sep 2019 05:21:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280792196F;
        Sat,  7 Sep 2019 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567848063;
        bh=GcrD/sv7DLi5xWC3eiU0BnDQb87oE7zqISebVvfQpYs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=g8r8DFh5r7pp8N8I+aEhNXJ74OTFVwpoAkusFOQ7guB7ekrcxGg4mQfPx1mqugXVl
         WMH34phnyyn3la1iYXzOBtD7GsXmNQopTsDHUsFReSMjr2YDXB8YlCZJDNHdGxTDCD
         KwN4xWalmp75WRhNoNdD085OEKividHEbtzSAtb8=
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
Subject: [PATCH v2 09/11] dt-bindings: rtc: s3c: Convert S3C/Exynos RTC bindings to json-schema
Date:   Sat,  7 Sep 2019 11:20:05 +0200
Message-Id: <20190907092007.9946-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190907092007.9946-1-krzk@kernel.org>
References: <20190907092007.9946-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert Samsung S3C/Exynos Real Time Clock bindings to DT schema format
using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use deprecated property instead of custom select,
2. Rework clocks and clock-names matching for specific compatibles.
---
 .../devicetree/bindings/rtc/s3c-rtc.txt       | 31 -------
 .../devicetree/bindings/rtc/s3c-rtc.yaml      | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt b/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
deleted file mode 100644
index fdde63a5419c..000000000000
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* Samsung's S3C Real Time Clock controller
-
-Required properties:
-- compatible: should be one of the following.
-    * "samsung,s3c2410-rtc" - for controllers compatible with s3c2410 rtc.
-    * "samsung,s3c2416-rtc" - for controllers compatible with s3c2416 rtc.
-    * "samsung,s3c2443-rtc" - for controllers compatible with s3c2443 rtc.
-    * "samsung,s3c6410-rtc" - for controllers compatible with s3c6410 rtc.
-    * "samsung,exynos3250-rtc" - (deprecated) for controllers compatible with
-                                 exynos3250 rtc (use "samsung,s3c6410-rtc").
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: Two interrupt numbers to the cpu should be specified. First
-  interrupt number is the rtc alarm interrupt and second interrupt number
-  is the rtc tick interrupt. The number of cells representing a interrupt
-  depends on the parent interrupt controller.
-- clocks: Must contain a list of phandle and clock specifier for the rtc
-          clock and in the case of a s3c6410 compatible controller, also
-          a source clock.
-- clock-names: Must contain "rtc" and for a s3c6410 compatible controller,
-               a "rtc_src" sorted in the same order as the clocks property.
-
-Example:
-
-	rtc@10070000 {
-		compatible = "samsung,s3c6410-rtc";
-		reg = <0x10070000 0x100>;
-		interrupts = <44 0 45 0>;
-		clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
-		clock-names = "rtc", "rtc_src";
-	};
diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
new file mode 100644
index 000000000000..951a6a485709
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/s3c-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S3C, S5P and Exynos Real Time Clock controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - samsung,s3c2410-rtc
+          - samsung,s3c2416-rtc
+          - samsung,s3c2443-rtc
+          - samsung,s3c6410-rtc
+      - const: samsung,exynos3250-rtc
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      Must contain a list of phandle and clock specifier for the rtc
+      clock and in the case of a s3c6410 compatible controller, also
+      a source clock.
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    description:
+      Must contain "rtc" and for a s3c6410 compatible controller
+      also "rtc_src".
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    description:
+      Two interrupt numbers to the cpu should be specified. First
+      interrupt number is the rtc alarm interrupt and second interrupt number
+      is the rtc tick interrupt. The number of cells representing a interrupt
+      depends on the parent interrupt controller.
+    minItems: 2
+    maxItems: 2
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,s3c6410-rtc
+              - samsung,exynos3250-rtc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: rtc
+            - const: rtc_src
+    else:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        clock-names:
+          items:
+            - const: rtc
+
+examples:
+  - |
+    rtc@10070000 {
+      compatible = "samsung,s3c6410-rtc";
+      reg = <0x10070000 0x100>;
+      interrupts = <0 44 4>, <0 45 4>;
+      clocks = <&clock 0>, // CLK_RTC
+               <&s2mps11_osc 0>; // S2MPS11_CLK_AP
+      clock-names = "rtc", "rtc_src";
+    };
-- 
2.17.1

