Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19EAC8DC6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfJBQIE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 12:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbfJBQID (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Oct 2019 12:08:03 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103BE21A4C;
        Wed,  2 Oct 2019 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570032482;
        bh=J9kAmUOB10/t7fTLkTz1mlbDgiv+TRuGOWFvZUNtgNg=;
        h=From:To:Subject:Date:From;
        b=pCgz4GjDBNXPxEehf+0JiRELjoO0FbTJxMmPJGoeWqq0uwlKXSrVEo0uk1y0maNq6
         oB0K/yIJropauxHqIgq/xXfq7K0uO9QvdhCm76Gm2BgJRehe2xbECsLDYoMyMNeBF6
         oFgTb3bsqOsURPyCoePxqIscwS7ZmJSBWafG8ZhU=
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
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: samsung: Indent examples with four spaces
Date:   Wed,  2 Oct 2019 18:07:41 +0200
Message-Id: <20191002160744.11307-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change the indentation of examples used in json-schema bindings from two
to four spaces as this makes the code easier to read and seems to be
preferred in other files.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/arm/samsung/exynos-chipid.yaml   |  4 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml  | 64 +++++++++----------
 .../bindings/power/reset/syscon-poweroff.yaml |  8 +--
 .../bindings/power/reset/syscon-reboot.yaml   |  8 +--
 .../devicetree/bindings/rtc/s3c-rtc.yaml      | 12 ++--
 5 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
index 9c573ad7dc7d..ce40adabb4e8 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
@@ -20,6 +20,6 @@ properties:
 examples:
   - |
     chipid@10000000 {
-      compatible = "samsung,exynos4210-chipid";
-      reg = <0x10000000 0x100>;
+        compatible = "samsung,exynos4210-chipid";
+        reg = <0x10000000 0x100>;
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index b4c6c26681d9..a0a9b909ac40 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -112,40 +112,40 @@ allOf:
 examples:
   - |
     adc: adc@12d10000 {
-      compatible = "samsung,exynos-adc-v1";
-      reg = <0x12d10000 0x100>;
-      interrupts = <0 106 0>;
-      #io-channel-cells = <1>;
-      io-channel-ranges;
-
-      clocks = <&clock 303>;
-      clock-names = "adc";
-
-      vdd-supply = <&buck5_reg>;
-      samsung,syscon-phandle = <&pmu_system_controller>;
-
-      /* NTC thermistor is a hwmon device */
-      ncp15wb473@0 {
-        compatible = "murata,ncp15wb473";
-        pullup-uv = <1800000>;
-        pullup-ohm = <47000>;
-        pulldown-ohm = <0>;
-        io-channels = <&adc 4>;
-      };
+        compatible = "samsung,exynos-adc-v1";
+        reg = <0x12d10000 0x100>;
+        interrupts = <0 106 0>;
+        #io-channel-cells = <1>;
+        io-channel-ranges;
+
+        clocks = <&clock 303>;
+        clock-names = "adc";
+
+        vdd-supply = <&buck5_reg>;
+        samsung,syscon-phandle = <&pmu_system_controller>;
+
+        /* NTC thermistor is a hwmon device */
+        ncp15wb473@0 {
+            compatible = "murata,ncp15wb473";
+            pullup-uv = <1800000>;
+            pullup-ohm = <47000>;
+            pulldown-ohm = <0>;
+            io-channels = <&adc 4>;
+          };
     };
 
   - |
     adc@126c0000 {
-      compatible = "samsung,exynos3250-adc";
-      reg = <0x126C0000 0x100>;
-      interrupts = <0 137 0>;
-      #io-channel-cells = <1>;
-      io-channel-ranges;
-
-      clocks = <&cmu 0>, // CLK_TSADC
-               <&cmu 1>; // CLK_SCLK_TSADC
-      clock-names = "adc", "sclk";
-
-      vdd-supply = <&buck5_reg>;
-      samsung,syscon-phandle = <&pmu_system_controller>;
+        compatible = "samsung,exynos3250-adc";
+        reg = <0x126C0000 0x100>;
+        interrupts = <0 137 0>;
+        #io-channel-cells = <1>;
+        io-channel-ranges;
+
+        clocks = <&cmu 0>, // CLK_TSADC
+                 <&cmu 1>; // CLK_SCLK_TSADC
+        clock-names = "adc", "sclk";
+
+        vdd-supply = <&buck5_reg>;
+        samsung,syscon-phandle = <&pmu_system_controller>;
     };
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
index fb812937b534..520e07e6f21b 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
@@ -53,8 +53,8 @@ allOf:
 examples:
   - |
     poweroff {
-      compatible = "syscon-poweroff";
-      regmap = <&regmapnode>;
-      offset = <0x0>;
-      mask = <0x7a>;
+        compatible = "syscon-poweroff";
+        regmap = <&regmapnode>;
+        offset = <0x0>;
+        mask = <0x7a>;
     };
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index a7920f5eef79..d38006b1f1f4 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -53,8 +53,8 @@ allOf:
 examples:
   - |
     reboot {
-      compatible = "syscon-reboot";
-      regmap = <&regmapnode>;
-      offset = <0x0>;
-      mask = <0x1>;
+        compatible = "syscon-reboot";
+        regmap = <&regmapnode>;
+        offset = <0x0>;
+        mask = <0x1>;
     };
diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
index 951a6a485709..95570d7e19eb 100644
--- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
@@ -76,10 +76,10 @@ allOf:
 examples:
   - |
     rtc@10070000 {
-      compatible = "samsung,s3c6410-rtc";
-      reg = <0x10070000 0x100>;
-      interrupts = <0 44 4>, <0 45 4>;
-      clocks = <&clock 0>, // CLK_RTC
-               <&s2mps11_osc 0>; // S2MPS11_CLK_AP
-      clock-names = "rtc", "rtc_src";
+        compatible = "samsung,s3c6410-rtc";
+        reg = <0x10070000 0x100>;
+        interrupts = <0 44 4>, <0 45 4>;
+        clocks = <&clock 0>, // CLK_RTC
+                 <&s2mps11_osc 0>; // S2MPS11_CLK_AP
+        clock-names = "rtc", "rtc_src";
     };
-- 
2.17.1

