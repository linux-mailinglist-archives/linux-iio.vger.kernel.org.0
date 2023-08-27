Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1A789E56
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjH0N00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjH0NZt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540351A3
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500b0f06136so1479637e87.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142741; x=1693747541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f71IcvptqSg5g7AuIhvK++aaEOWi79M2v+yqgEz0APA=;
        b=sgi11CD5AbNQhsn1WzJXHFWkjwIvapEhw/EJWShy5XTPsiMnTptkLGjdIv8bsz+2O4
         7nKe2kBTyZ4pn5LJn7683sQKtDPH7RJd7ptO6B+xQiGGoxEJa5FFGHfBsFX/Av5iQL/m
         RFdzOK4XrZTNBwGTwsed/AYR11SXwuKCWRhp5TxrupIVJ1xX+SnWIFmlSGYUv9pNGejU
         nySbsf/ug1dao9SwtH9UBqcfMcIxkmfGTlxgWyOHkkO+UcBq6kyPnZOENWt8OCvPoYKn
         t/uiU/dzkAQcyNLZo4VSjtN6vlVAtdwkUE3PxC0YwPmScS9akMqSZ5EPvaYrWvSDmBij
         hrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142741; x=1693747541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f71IcvptqSg5g7AuIhvK++aaEOWi79M2v+yqgEz0APA=;
        b=ciFG0PytiBAU4ihMbaB5zGjGhRHut0n0zBtpKfPtWa2/MBRkuwUtx7UlQ/Kbj7fMiw
         wX0mVklq9tciGHwYdzubIUeYNXpt7TKPq+CJJH70rLj91F9v8suxBlJh1EFieb3EVjHB
         fsAUPX2Sf2i3qktcVrfZWOWpS7WsmYy1LWW3Gg9mN/XTCfmeXC8Ju10auVV1QZbqTx42
         QsYes6gxHZ91+ZgLv0b4Ka4RPy7iTzsSMpFJbNUvmTnAtcU9Ji0nUDCwau1c76RRUc1K
         3fXrna0cu0FCySmXeTqRDqLOW399nWSMlvgHb+/SUtTb3FOsqmjhbiuBvgtmQSbKe4IM
         jmdg==
X-Gm-Message-State: AOJu0YzZqJQrgSMYPYfGhulw3+7yS3Kz8kIVVkSKODu1EpeiT/WAjEPp
        lY9RON2Mcxwf5Rmbijp5hoTFfQ==
X-Google-Smtp-Source: AGHT+IF/H+u+Jw9GC/f4dKyJLj8u4RjXIWabSZw8j+AvJodxCmj+wU6wigBCfiL0ZgROpaKyvWG0sw==
X-Received: by 2002:ac2:4bd4:0:b0:4fd:c84f:30d4 with SMTP id o20-20020ac24bd4000000b004fdc84f30d4mr18752861lfq.36.1693142741614;
        Sun, 27 Aug 2023 06:25:41 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:41 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org
Subject: [PATCH v5 18/37] ARM: dts: qcom: apq8064: split PMICs to separate dtsi files
Date:   Sun, 27 Aug 2023 16:25:06 +0300
Message-Id: <20230827132525.951475-19-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
References: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The PMICs are not a part of the SoC, so move PMICs to separate files and
include them from the board files.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/pm8821.dtsi            |  22 +++
 arch/arm/boot/dts/qcom/pm8921.dtsi            |  99 +++++++++++++
 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts |   6 +-
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts   |   5 +-
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    |   5 +-
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   |   5 +-
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 134 +-----------------
 7 files changed, 140 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom/pm8821.dtsi

diff --git a/arch/arm/boot/dts/qcom/pm8821.dtsi b/arch/arm/boot/dts/qcom/pm8821.dtsi
new file mode 100644
index 000000000000..064e3ba54e18
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/pm8821.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* This PMIC is used on a secondary SSBI bus */
+&ssbi2 {
+	pm8821: pmic {
+		compatible = "qcom,pm8821";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8821_mpps: mpps@50 {
+			compatible = "qcom,pm8821-mpp", "qcom,ssbi-mpp";
+			reg = <0x50>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8821_mpps 0 0 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/pm8921.dtsi b/arch/arm/boot/dts/qcom/pm8921.dtsi
index 414941f7a42f..ad41d99ab265 100644
--- a/arch/arm/boot/dts/qcom/pm8921.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8921.dtsi
@@ -8,6 +8,30 @@ pm8921: pmic {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8921_gpio: gpio@150 {
+
+			compatible = "qcom,pm8921-gpio",
+				     "qcom,ssbi-gpio";
+			reg = <0x150>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pm8921_gpio 0 0 44>;
+			#gpio-cells = <2>;
+
+		};
+
+		pm8921_mpps: mpps@50 {
+			compatible = "qcom,pm8921-mpp",
+				     "qcom,ssbi-mpp";
+			reg = <0x50>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8921_mpps 0 0 12>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		pwrkey@1c {
 			compatible = "qcom,pm8921-pwrkey";
 			reg = <0x1c>;
@@ -36,5 +60,80 @@ rtc@11d {
 			reg = <0x11d>;
 			allow-set-time;
 		};
+
+		pm8921_xoadc: xoadc@197 {
+			compatible = "qcom,pm8921-adc";
+			reg = <0x197>;
+			interrupts-extended = <&pm8921 78 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			#io-channel-cells = <2>;
+
+			vcoin: adc-channel@0 {
+				reg = <0x00 0x00>;
+			};
+
+			vbat: adc-channel@1 {
+				reg = <0x00 0x01>;
+			};
+
+			dcin: adc-channel@2 {
+				reg = <0x00 0x02>;
+			};
+
+			vph_pwr: adc-channel@4 {
+				reg = <0x00 0x04>;
+			};
+
+			batt_therm: adc-channel@8 {
+				reg = <0x00 0x08>;
+			};
+
+			batt_id: adc-channel@9 {
+				reg = <0x00 0x09>;
+			};
+
+			usb_vbus: adc-channel@a {
+				reg = <0x00 0x0a>;
+			};
+
+			die_temp: adc-channel@b {
+				reg = <0x00 0x0b>;
+			};
+
+			ref_625mv: adc-channel@c {
+				reg = <0x00 0x0c>;
+			};
+
+			ref_1250mv: adc-channel@d {
+				reg = <0x00 0x0d>;
+			};
+
+			chg_temp: adc-channel@e {
+				reg = <0x00 0x0e>;
+			};
+
+			ref_muxoff: adc-channel@f {
+				reg = <0x00 0x0f>;
+			};
+		};
+	};
+};
+
+/ {
+	/*
+	 * These channels from the ADC are simply hardware monitors.
+	 * That is why the ADC is referred to as "HKADC" - HouseKeeping
+	 * ADC.
+	 */
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&pm8921_xoadc 0x00 0x01>, /* Battery */
+			      <&pm8921_xoadc 0x00 0x02>, /* DC in (charger) */
+			      <&pm8921_xoadc 0x00 0x04>, /* VPH the main system voltage */
+			      <&pm8921_xoadc 0x00 0x0b>, /* Die temperature */
+			      <&pm8921_xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
+			      <&pm8921_xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
+			      <&pm8921_xoadc 0x00 0x0e>; /* Charger temperature */
 	};
 };
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index b820f3255c16..d709d6e840ec 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "qcom-apq8064-v2.0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+#include "qcom-apq8064-v2.0.dtsi"
+#include "pm8821.dtsi"
+#include "pm8921.dtsi"
+
 / {
 	model = "Asus Nexus7(flo)";
 	compatible = "asus,nexus7-flo", "qcom,apq8064";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
index c01254b1a3a7..d4db84e9fcf3 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "qcom-apq8064-v2.0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
+#include "qcom-apq8064-v2.0.dtsi"
+#include "pm8821.dtsi"
+#include "pm8921.dtsi"
+
 / {
 	model = "CompuLab CM-QS600";
 	compatible = "qcom,apq8064-cm-qs600", "qcom,apq8064";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index f1bd29333c9b..5fd84319254e 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "qcom-apq8064-v2.0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
+#include "qcom-apq8064-v2.0.dtsi"
+#include "pm8821.dtsi"
+#include "pm8921.dtsi"
+
 / {
 	model = "Qualcomm APQ8064/IFC6410";
 	compatible = "qcom,apq8064-ifc6410", "qcom,apq8064";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
index 7917f1657025..ba18a02b1c57 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "qcom-apq8064-v2.0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
+#include "qcom-apq8064-v2.0.dtsi"
+#include "pm8821.dtsi"
+#include "pm8921.dtsi"
+
 / {
 	model = "Sony Xperia Z";
 	compatible = "sony,xperia-yuga", "qcom,apq8064";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 76796002bda6..5704d0598b96 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -284,23 +284,6 @@ scm {
 		};
 	};
 
-
-	/*
-	 * These channels from the ADC are simply hardware monitors.
-	 * That is why the ADC is referred to as "HKADC" - HouseKeeping
-	 * ADC.
-	 */
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&pm8921_xoadc 0x00 0x01>, /* Battery */
-			      <&pm8921_xoadc 0x00 0x02>, /* DC in (charger) */
-			      <&pm8921_xoadc 0x00 0x04>, /* VPH the main system voltage */
-			      <&pm8921_xoadc 0x00 0x0b>, /* Die temperature */
-			      <&pm8921_xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
-			      <&pm8921_xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
-			      <&pm8921_xoadc 0x00 0x0e>; /* Charger temperature */
-	};
-
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -655,129 +638,16 @@ rng@1a500000 {
 			clock-names = "core";
 		};
 
-		ssbi@c00000 {
+		ssbi2: ssbi@c00000 {
 			compatible = "qcom,ssbi";
 			reg = <0x00c00000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
-
-			pm8821: pmic {
-				compatible = "qcom,pm8821";
-				#interrupt-cells = <2>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				pm8821_mpps: mpps@50 {
-					compatible = "qcom,pm8821-mpp", "qcom,ssbi-mpp";
-					reg = <0x50>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&pm8821_mpps 0 0 4>;
-				};
-			};
 		};
 
-		ssbi@500000 {
+		ssbi: ssbi@500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x00500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
-
-			pm8921: pmic {
-				compatible = "qcom,pm8921";
-				#interrupt-cells = <2>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				pm8921_gpio: gpio@150 {
-
-					compatible = "qcom,pm8921-gpio",
-						     "qcom,ssbi-gpio";
-					reg = <0x150>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					gpio-controller;
-					gpio-ranges = <&pm8921_gpio 0 0 44>;
-					#gpio-cells = <2>;
-
-				};
-
-				pm8921_mpps: mpps@50 {
-					compatible = "qcom,pm8921-mpp",
-						     "qcom,ssbi-mpp";
-					reg = <0x50>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&pm8921_mpps 0 0 12>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-				};
-
-				rtc@11d {
-					compatible = "qcom,pm8921-rtc";
-					interrupt-parent = <&pm8921>;
-					interrupts = <39 1>;
-					reg = <0x11d>;
-					allow-set-time;
-				};
-
-				pwrkey@1c {
-					compatible = "qcom,pm8921-pwrkey";
-					reg = <0x1c>;
-					interrupt-parent = <&pm8921>;
-					interrupts = <50 1>, <51 1>;
-					debounce = <15625>;
-					pull-up;
-				};
-
-				pm8921_xoadc: xoadc@197 {
-					compatible = "qcom,pm8921-adc";
-					reg = <0x197>;
-					interrupts-extended = <&pm8921 78 IRQ_TYPE_EDGE_RISING>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-					#io-channel-cells = <2>;
-
-					vcoin: adc-channel@0 {
-						reg = <0x00 0x00>;
-					};
-					vbat: adc-channel@1 {
-						reg = <0x00 0x01>;
-					};
-					dcin: adc-channel@2 {
-						reg = <0x00 0x02>;
-					};
-					vph_pwr: adc-channel@4 {
-						reg = <0x00 0x04>;
-					};
-					batt_therm: adc-channel@8 {
-						reg = <0x00 0x08>;
-					};
-					batt_id: adc-channel@9 {
-						reg = <0x00 0x09>;
-					};
-					usb_vbus: adc-channel@a {
-						reg = <0x00 0x0a>;
-					};
-					die_temp: adc-channel@b {
-						reg = <0x00 0x0b>;
-					};
-					ref_625mv: adc-channel@c {
-						reg = <0x00 0x0c>;
-					};
-					ref_1250mv: adc-channel@d {
-						reg = <0x00 0x0d>;
-					};
-					chg_temp: adc-channel@e {
-						reg = <0x00 0x0e>;
-					};
-					ref_muxoff: adc-channel@f {
-						reg = <0x00 0x0f>;
-					};
-				};
-			};
 		};
 
 		qfprom: qfprom@700000 {
-- 
2.39.2

