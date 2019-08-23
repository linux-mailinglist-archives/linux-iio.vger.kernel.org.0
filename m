Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A386B9B2AE
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393829AbfHWOy4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 10:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393814AbfHWOy4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 10:54:56 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BF2233A2;
        Fri, 23 Aug 2019 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572094;
        bh=eolNUp8mZ/BwktdYdW3QiL10TCXKR9LKNhvDP3sPFYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PqK37sp8eqbiycRUtPerYIm/4+VO7fdHc95T1yUguiuMeHaYEMLU+rDBcYzAfCfME
         W+NWzQ39liC5BB495Zxs4BjJhx1fnspvy3U22tzDKFSUD5PNZRTejFm/R7qcEd02+A
         R/gZ/vPrU9oeRGw8gFcU2+ja/FiS1CBOi9WHgBgQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     notify@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RFC 7/9] dt-bindings: rtc: s3c: Convert S3C/Exynos RTC bindings to json-schema
Date:   Fri, 23 Aug 2019 16:53:54 +0200
Message-Id: <20190823145356.6341-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823145356.6341-1-krzk@kernel.org>
References: <20190823145356.6341-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert Samsung S3C/Exynos Real Time Clock bindings to DT schema format
using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/rtc/s3c-rtc.txt       | 31 ------
 .../devicetree/bindings/rtc/s3c-rtc.yaml      | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 31 deletions(-)
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
index 000000000000..44b021812a83
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -0,0 +1,95 @@
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
+# Select also deprecated compatibles (for finding deprecate usage)
+select:
+  properties:
+    compatible:
+      items:
+        - enum:
+            - samsung,s3c2410-rtc
+            - samsung,s3c2416-rtc
+            - samsung,s3c2443-rtc
+            - samsung,s3c6410-rtc
+            # Deprecated, use samsung,s3c6410-rtc
+            - samsung,exynos3250-rtc
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - samsung,s3c2410-rtc
+          - samsung,s3c2416-rtc
+          - samsung,s3c2443-rtc
+          - samsung,s3c6410-rtc
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
+      Must contain "rtc" and for a s3c6410 compatible controller,
+      a "rtc_src" sorted in the same order as the clocks property.
+    oneOf:
+      - items:
+          - const: rtc
+      - items:
+          # TODO: This can be in any order matching clocks, how to express it?
+          - const: rtc
+          - const: rtc_src
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
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+          - const: rtc
+          - const: rtc_src
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

