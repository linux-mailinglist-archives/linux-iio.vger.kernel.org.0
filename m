Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D2789E65
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjH0N0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjH0NZw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EDB1BE
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso3561778e87.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142743; x=1693747543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOijttIhX4pC24Tx4gkoYM4fEkA3UENDYI9aQrNhx68=;
        b=U0yL3/M/tziXiwB4FtS2nFWatFTIqPkB3Ex9IvibTlH+DqPg3LpIBrof+4EparrTOv
         VyvuUiaQzHyDczxo0JNfT+V9aoiRJfkkRdrgN0GcoAQeiR9fcr+AAfxe6qBv6tv0Ml7x
         ZkpoHl4h13+QBDFp9gB/pJ/myBFVDmBFr9j4MudOOW0PTzPd40C2oF4pFGcI80Nmtso4
         qVaZYLoOuWb0jPwf1huyYoYyAPne2Nbycpac8H4097hq0cr4PPEYziwc68WM59ACkMdn
         kfWWrOhRtf9GQy0rpRY4y5HC1lBb9N2LmsjuJfmjgR+e4oYFJiTHrswA2iWgKcVQDL6d
         zm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142743; x=1693747543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOijttIhX4pC24Tx4gkoYM4fEkA3UENDYI9aQrNhx68=;
        b=Wk+3EpCLMskyJatHr7HPMK4eJ4z1HE0lq8n4FZp4qDD0vf3zL2n0losGGZyUKYcOzZ
         lQhcoKA5ml/BX5ZRT2M8CAOFo44Egi3MCQblPc1A6/MY+wkUCvhJur2pL04WOxadFzFY
         M8uX+zO9zBGpgh+RKIMzq2YI3KRKqBuPN4UrHjGfBoBKzUQDAWTSFsAIk3NXZBHWAnYU
         14MNl4aTqRwHX1LbgRYUwiwH0y0p6/dkRUYen5PQUNJpadgL25yZ3NBNTM4tbhdkDVIX
         08S+59PkTGQFcJDQiyrw1gN2D4ALAtqu1HduGA50FxyXhT6qDWVDrmIgXtyaEx63zjOh
         WPyw==
X-Gm-Message-State: AOJu0Ywu1aznFhZh6RJk9eif++Jeovalk1mJenKJ3jbINDb4cwNyu4Dd
        yp2ROJyfxCBslhoQ1/lCOfgQPg==
X-Google-Smtp-Source: AGHT+IE3RrdyS42MeM0zTXZBGUZY6k1ofam+8imYN84Da1Fiua8g5lHAhik/aTVVwJEDH50zxuy5pg==
X-Received: by 2002:ac2:46f7:0:b0:500:9b7d:ee22 with SMTP id q23-20020ac246f7000000b005009b7dee22mr7644076lfo.60.1693142743308;
        Sun, 27 Aug 2023 06:25:43 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:42 -0700 (PDT)
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
Subject: [PATCH v5 20/37] ARM: dts: qcom: msm8660: split PMIC to separate dtsi files
Date:   Sun, 27 Aug 2023 16:25:08 +0300
Message-Id: <20230827132525.951475-21-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
References: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
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

