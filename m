Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67B7789A74
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjH0BAK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjH0A7r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCF2F7
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50078eba7afso3335140e87.0
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097983; x=1693702783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOijttIhX4pC24Tx4gkoYM4fEkA3UENDYI9aQrNhx68=;
        b=AUQpmBlA9PoFcShRs85XYC/t7pQV8a0sOlQUQyYzhOTQrbJlPBLUAaWJBVEXTd7rWo
         WhnzuRjNAyu79uBZiKj11cXIHeC9iP3LYZeWAebRfsVN9lANr8vgi4YX4rTDZlSxo48P
         i/Et4gKURwHXBWgcIzFGDUXxMJto520+696lE1EKQM4am7Gj+dddALp71yGDMrP74/jc
         PyACZlQEeerluwnpW2uFSkEdrO208IejyAHghCpU/pMkti7iXoiKY1ID9ITX2IA4Nb9U
         nwudJdFBGHEA2ni04Blm5EXkyQroKSE8N964t2+/o6gwHoMbawI2jsi+wY5P3Z74yRqE
         wt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097983; x=1693702783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOijttIhX4pC24Tx4gkoYM4fEkA3UENDYI9aQrNhx68=;
        b=gmQ6vchbHMk3ekRR5bpNdFdl4X6OjPBAwleGGX7zpLYMxEOEvf/B8hURd6uBXyu6pG
         9YjzqnuNracZoq7dRng2VrhkXpvK+8dF67c5GlW7HBcjZHH905HtwTda3tmDMS1bWPDP
         02YY6SpTvXyN4eXbUvrIDJtBfgzOwqQupTTYCS/XEBdZ0q3Itei0CkCMdDJtQtmVrnA7
         kiEB+tlK/tdRGrI7PgQnNjEKrd4NOJcYKhV1RqycDmKFsMKS3Q8yY/ls34WI50VVQRAw
         XAdIjTKj/tQpT1jkeG148TFFuatHRHXpXpiuH+IMI073vP/OdkYh6h8/rxULe+DChwsm
         1jpw==
X-Gm-Message-State: AOJu0YyORWgBNSDc+RuPrPDvwWTRbylb8MNdiPxKv82unZc7KPGIhbYj
        1jmvBVFHdXPvhiZG9quDOroipA==
X-Google-Smtp-Source: AGHT+IHJ5NHnPub1MVJVG912s0zf6y75FP6S7cfNzxrZUzy/Bp8gOwZbdltvGv+jaxAgHXKQt6Ck0Q==
X-Received: by 2002:a05:6512:4012:b0:4fe:8ba9:4c4 with SMTP id br18-20020a056512401200b004fe8ba904c4mr19779764lfb.59.1693097983197;
        Sat, 26 Aug 2023 17:59:43 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:42 -0700 (PDT)
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
Subject: [PATCH v4 21/38] ARM: dts: qcom: msm8660: split PMIC to separate dtsi files
Date:   Sun, 27 Aug 2023 03:59:03 +0300
Message-Id: <20230827005920.898719-22-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The PMIC is not a part of the SoC, so move PMIC to a separate file and
include it from the board files.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/pm8058.dtsi            | 160 ++++++++++++++++++
 .../dts/qcom/qcom-apq8060-dragonboard.dts     |   1 +
 arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts  |   1 +
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi      | 149 +---------------
 4 files changed, 163 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom/pm8058.dtsi

diff --git a/arch/arm/boot/dts/qcom/pm8058.dtsi b/arch/arm/boot/dts/qcom/pm8058.dtsi
new file mode 100644
index 000000000000..ad581c3bcbd2
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/pm8058.dtsi
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+
+&ssbi {
+	pm8058: pmic {
+		compatible = "qcom,pm8058";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8058_gpio: gpio@150 {
+			compatible = "qcom,pm8058-gpio",
+				     "qcom,ssbi-gpio";
+			reg = <0x150>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pm8058_gpio 0 0 44>;
+			#gpio-cells = <2>;
+		};
+
+		pm8058_mpps: mpps@50 {
+			compatible = "qcom,pm8058-mpp",
+				     "qcom,ssbi-mpp";
+			reg = <0x50>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8058_mpps 0 0 12>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pwrkey@1c {
+			compatible = "qcom,pm8058-pwrkey";
+			reg = <0x1c>;
+			interrupt-parent = <&pm8058>;
+			interrupts = <50 1>, <51 1>;
+			debounce = <15625>;
+			pull-up;
+		};
+
+		pm8058_keypad: keypad@148 {
+			compatible = "qcom,pm8058-keypad";
+			reg = <0x148>;
+			interrupt-parent = <&pm8058>;
+			interrupts = <74 1>, <75 1>;
+			debounce = <15>;
+			scan-delay = <32>;
+			row-hold = <91500>;
+		};
+
+		pm8058_xoadc: xoadc@197 {
+			compatible = "qcom,pm8058-adc";
+			reg = <0x197>;
+			interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
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
+			ichg: adc-channel@3 {
+				reg = <0x00 0x03>;
+			};
+
+			vph_pwr: adc-channel@4 {
+				reg = <0x00 0x04>;
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
+			ref_325mv: adc-channel@e {
+				reg = <0x00 0x0e>;
+			};
+
+			ref_muxoff: adc-channel@f {
+				reg = <0x00 0x0f>;
+			};
+		};
+
+		rtc@1e8 {
+			compatible = "qcom,pm8058-rtc";
+			reg = <0x1e8>;
+			interrupt-parent = <&pm8058>;
+			interrupts = <39 1>;
+			allow-set-time;
+		};
+
+		vibrator@4a {
+			compatible = "qcom,pm8058-vib";
+			reg = <0x4a>;
+		};
+
+		pm8058_led48: led@48 {
+			compatible = "qcom,pm8058-keypad-led";
+			reg = <0x48>;
+			status = "disabled";
+		};
+
+		pm8058_led131: led@131 {
+			compatible = "qcom,pm8058-led";
+			reg = <0x131>;
+			status = "disabled";
+		};
+
+		pm8058_led132: led@132 {
+			compatible = "qcom,pm8058-led";
+			reg = <0x132>;
+			status = "disabled";
+		};
+
+		pm8058_led133: led@133 {
+			compatible = "qcom,pm8058-led";
+			reg = <0x133>;
+			status = "disabled";
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
+		io-channels = <&pm8058_xoadc 0x00 0x01>, /* Battery */
+			      <&pm8058_xoadc 0x00 0x02>, /* DC in (charger) */
+			      <&pm8058_xoadc 0x00 0x04>, /* VPH the main system voltage */
+			      <&pm8058_xoadc 0x00 0x0b>, /* Die temperature */
+			      <&pm8058_xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
+			      <&pm8058_xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
+			      <&pm8058_xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
index e4261d729d35..10b8f529c337 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
@@ -5,6 +5,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 #include "qcom-msm8660.dtsi"
+#include "pm8058.dtsi"
 
 / {
 	model = "Qualcomm APQ8060 Dragonboard";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
index a5441aecd637..be2fbc1e0950 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8660-surf.dts
@@ -2,6 +2,7 @@
 #include <dt-bindings/input/input.h>
 
 #include "qcom-msm8660.dtsi"
+#include "pm8058.dtsi"
 
 / {
 	model = "Qualcomm MSM8660 SURF";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
index 84b0366792d4..eef4712bbcc4 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
@@ -73,22 +73,6 @@ sleep-clk {
 		};
 	};
 
-	/*
-	 * These channels from the ADC are simply hardware monitors.
-	 * That is why the ADC is referred to as "HKADC" - HouseKeeping
-	 * ADC.
-	 */
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&pm8058_xoadc 0x00 0x01>, /* Battery */
-			      <&pm8058_xoadc 0x00 0x02>, /* DC in (charger) */
-			      <&pm8058_xoadc 0x00 0x04>, /* VPH the main system voltage */
-			      <&pm8058_xoadc 0x00 0x0b>, /* Die temperature */
-			      <&pm8058_xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
-			      <&pm8058_xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
-			      <&pm8058_xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
-	};
-
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -334,141 +318,10 @@ ebi2: external-bus@1a100000 {
 			status = "disabled";
 		};
 
-		ssbi@500000 {
+		ssbi: ssbi@500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
-
-			pm8058: pmic {
-				compatible = "qcom,pm8058";
-				#interrupt-cells = <2>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				pm8058_gpio: gpio@150 {
-					compatible = "qcom,pm8058-gpio",
-						     "qcom,ssbi-gpio";
-					reg = <0x150>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					gpio-controller;
-					gpio-ranges = <&pm8058_gpio 0 0 44>;
-					#gpio-cells = <2>;
-
-				};
-
-				pm8058_mpps: mpps@50 {
-					compatible = "qcom,pm8058-mpp",
-						     "qcom,ssbi-mpp";
-					reg = <0x50>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&pm8058_mpps 0 0 12>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-				};
-
-				pwrkey@1c {
-					compatible = "qcom,pm8058-pwrkey";
-					reg = <0x1c>;
-					interrupt-parent = <&pm8058>;
-					interrupts = <50 1>, <51 1>;
-					debounce = <15625>;
-					pull-up;
-				};
-
-				pm8058_keypad: keypad@148 {
-					compatible = "qcom,pm8058-keypad";
-					reg = <0x148>;
-					interrupt-parent = <&pm8058>;
-					interrupts = <74 1>, <75 1>;
-					debounce = <15>;
-					scan-delay = <32>;
-					row-hold = <91500>;
-				};
-
-				pm8058_xoadc: xoadc@197 {
-					compatible = "qcom,pm8058-adc";
-					reg = <0x197>;
-					interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
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
-					ichg: adc-channel@3 {
-						reg = <0x00 0x03>;
-					};
-					vph_pwr: adc-channel@4 {
-						reg = <0x00 0x04>;
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
-					ref_325mv: adc-channel@e {
-						reg = <0x00 0x0e>;
-					};
-					ref_muxoff: adc-channel@f {
-						reg = <0x00 0x0f>;
-					};
-				};
-
-				rtc@1e8 {
-					compatible = "qcom,pm8058-rtc";
-					reg = <0x1e8>;
-					interrupt-parent = <&pm8058>;
-					interrupts = <39 1>;
-					allow-set-time;
-				};
-
-				vibrator@4a {
-					compatible = "qcom,pm8058-vib";
-					reg = <0x4a>;
-				};
-
-				pm8058_led48: led@48 {
-					compatible = "qcom,pm8058-keypad-led";
-					reg = <0x48>;
-					status = "disabled";
-				};
-
-				pm8058_led131: led@131 {
-					compatible = "qcom,pm8058-led";
-					reg = <0x131>;
-					status = "disabled";
-				};
-
-				pm8058_led132: led@132 {
-					compatible = "qcom,pm8058-led";
-					reg = <0x132>;
-					status = "disabled";
-				};
-
-				pm8058_led133: led@133 {
-					compatible = "qcom,pm8058-led";
-					reg = <0x133>;
-					status = "disabled";
-				};
-
-			};
 		};
 
 		l2cc: clock-controller@2082000 {
-- 
2.39.2

