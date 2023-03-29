Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D86CCE95
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC2AIp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjC2AIo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:08:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C3A211B
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g19so4876034lfr.9
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680048520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv3nXZmu951wyz4rQx8seqOJOpLq5+CWgoV+CHe6mco=;
        b=VSLWG9u/Vc9NDvKTNYAnkyfZ8xfXYlQHeQqMaL3ylOGuGWhCtFXWwpOWnw2ggMINwC
         hjz25Ty+32YhpnhEbPgaDVBY5fxJXpQURzoQc9/9KbYuXgBNaPlvjuBoHyH2lsot3MfX
         +pAVEABnpMO0GEBiv8/aehICdBgT0qEa/7nK4GR0NZ+9EhlCoVNKdM+9qeAKR4XPGLKX
         WtYdxaKpOjl/6lkLloXE+etx9eRfN1n1wBSBjSRIc8BuV4iZ+2hvEtyLr4x35fNKgs6s
         HnmoxCM43W30yUEttbjgdXARZhObhX2s7kVRKB3e0liY2L9J/tP+Q7rOnao6Gr7n2k3q
         aDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv3nXZmu951wyz4rQx8seqOJOpLq5+CWgoV+CHe6mco=;
        b=bVkYZhhR5eKWcr8/wx8zTp5VAg0bnkM1ADkoY3LAycuHmVsK8mJgl0f72TtiqlU0So
         kHFZJqAbSQbcruN9wFtDZ6xexUaqsk/ZBP8O9YzJhv9QduchHW022z7XC1UKINHGk0qE
         dViFj9X3R/kJGqFlhWSw2nk8zndXazvziXgW5CNatRpH6ajyHtKMPmJFmZd6Tfc/NyUE
         N7MV83Bn/jCvrHOhPBsJGP7rioDmu1x8aYqtcpaQNlIbCrgNKirJ7ae/UQaBva5xAzlK
         646NmUhd8fAL+gdh/uTJ51seq44+1SzJSAjapZ7ZFaoMmXAYvVvX8Mi8Go4mArC4HXiB
         ELLw==
X-Gm-Message-State: AAQBX9cIa46/daVdrqT1uI4fSo56FxPYXYWszwvHmnSPnvfmY9fUmSOr
        pTfdlF4TieHdAmz4Qf6t0nbJJA==
X-Google-Smtp-Source: AKy350bBnYrVYXCQ0LNAkNBhyKHmeWzJ1bfJmZBWhA0on9nYbdiTBPX+mX5pSbmd36iuON4PeQoljw==
X-Received: by 2002:ac2:5d2c:0:b0:4db:3ddf:2fbd with SMTP id i12-20020ac25d2c000000b004db3ddf2fbdmr4400730lfb.45.1680048520346;
        Tue, 28 Mar 2023 17:08:40 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004e8011cbaa0sm5238341lfo.111.2023.03.28.17.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 17:08:39 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: qcom: sc8280xp*: use pm8350.dtsi
Date:   Wed, 29 Mar 2023 03:08:32 +0300
Message-Id: <20230329000833.2507594-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Employ PM8350_SID and switch sc8280xp-pmics to use pm8350.dtsi to reduce
duplication and possible discrepancies.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 12 +--
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 12 +--
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  | 98 ++-----------------
 3 files changed, 19 insertions(+), 103 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index d32594b5a4e7..58a14c39633b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -25,7 +25,7 @@ aliases {
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pmc8280c_lpg 3 1000000>;
-		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pm8350_1_gpios 8 GPIO_ACTIVE_HIGH>;
 		power-supply = <&vreg_edp_bl>;
 
 		pinctrl-names = "default";
@@ -137,7 +137,7 @@ vreg_edp_bl: regulator-edp-bl {
 		regulator-min-microvolt = <3600000>;
 		regulator-max-microvolt = <3600000>;
 
-		gpio = <&pmc8280_1_gpios 9 GPIO_ACTIVE_HIGH>;
+		gpio = <&pm8350_1_gpios 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
@@ -167,7 +167,7 @@ vreg_misc_3p3: regulator-misc-3p3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;
+		gpio = <&pm8350_1_gpios 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
@@ -200,7 +200,7 @@ vreg_wwan: regulator-wwan {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&pmc8280_2_gpios 1 GPIO_ACTIVE_HIGH>;
+		gpio = <&pm8350_3_gpios 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
@@ -686,7 +686,7 @@ &xo_board_clk {
 
 /* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
 
-&pmc8280_1_gpios {
+&pm8350_1_gpios {
 	edp_bl_en: edp-bl-en-state {
 		pins = "gpio8";
 		function = "normal";
@@ -703,7 +703,7 @@ misc_3p3_reg_en: misc-3p3-reg-en-state {
 	};
 };
 
-&pmc8280_2_gpios {
+&pm8350_3_gpios {
 	wwan_sw_en: wwan-sw-en-state {
 		pins = "gpio1";
 		function = "normal";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 7d61108daede..023ccb7725ef 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -55,7 +55,7 @@ wcd938x: audio-codec {
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pmc8280c_lpg 3 1000000>;
-		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pm8350_1_gpios 8 GPIO_ACTIVE_HIGH>;
 		power-supply = <&vreg_edp_bl>;
 
 		pinctrl-names = "default";
@@ -178,7 +178,7 @@ vreg_edp_bl: regulator-edp-bl {
 		regulator-min-microvolt = <3600000>;
 		regulator-max-microvolt = <3600000>;
 
-		gpio = <&pmc8280_1_gpios 9 GPIO_ACTIVE_HIGH>;
+		gpio = <&pm8350_1_gpios 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
@@ -194,7 +194,7 @@ vreg_misc_3p3: regulator-misc-3p3 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;
+		gpio = <&pm8350_1_gpios 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
@@ -253,7 +253,7 @@ vreg_wwan: regulator-wwan {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&pmc8280_2_gpios 1 GPIO_ACTIVE_HIGH>;
+		gpio = <&pm8350_3_gpios 1 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
 		pinctrl-names = "default";
@@ -1148,7 +1148,7 @@ &lpass_tlmm {
 	status = "okay";
 };
 
-&pmc8280_1_gpios {
+&pm8350_1_gpios {
 	edp_bl_en: edp-bl-en-state {
 		pins = "gpio8";
 		function = "normal";
@@ -1165,7 +1165,7 @@ misc_3p3_reg_en: misc-3p3-reg-en-state {
 	};
 };
 
-&pmc8280_2_gpios {
+&pm8350_3_gpios {
 	wwan_sw_en: wwan-sw-en-state {
 		pins = "gpio1";
 		function = "normal";
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 781fb6448a52..505bb8f9a13c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -7,79 +7,19 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
-/ {
-	thermal-zones {
-		pm8280_1_thermal: pm8280-1-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-			thermal-sensors = <&pm8280_1_temp_alarm>;
-
-			trips {
-				trip0 {
-					temperature = <95000>;
-					hysteresis = <0>;
-					type = "passive";
-				};
-
-				trip1 {
-					temperature = <115000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-
-		pm8280_2_thermal: pm8280-2-thermal {
-			polling-delay-passive = <100>;
-			polling-delay = <0>;
-			thermal-sensors = <&pm8280_2_temp_alarm>;
-
-			trips {
-				trip0 {
-					temperature = <95000>;
-					hysteresis = <0>;
-					type = "passive";
-				};
-
-				trip1 {
-					temperature = <115000>;
-					hysteresis = <0>;
-					type = "critical";
-				};
-			};
-		};
-	};
-};
-
 #define PMK8350_SID 0
 #include "pmk8350.dtsi"
 #undef PMK8350_SID
 
-&spmi_bus {
-	pmc8280_1: pmic@1 {
-		compatible = "qcom,pm8350", "qcom,spmi-pmic";
-		reg = <0x1 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
+#define PM8350_SID 1
+#include "pm8350.dtsi"
+#undef PM8350_SID
 
-		pm8280_1_temp_alarm: temp-alarm@a00 {
-			compatible = "qcom,spmi-temp-alarm";
-			reg = <0xa00>;
-			interrupts-extended = <&spmi_bus 0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
-			#thermal-sensor-cells = <0>;
-		};
-
-		pmc8280_1_gpios: gpio@8800 {
-			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
-			reg = <0x8800>;
-			gpio-controller;
-			gpio-ranges = <&pmc8280_1_gpios 0 0 10>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
+#define PM8350_SID 3
+#include "pm8350.dtsi"
+#undef PM8350_SID
 
+&spmi_bus {
 	pmc8280c: pmic@2 {
 		compatible = "qcom,pm8350c", "qcom,spmi-pmic";
 		reg = <0x2 SPMI_USID>;
@@ -108,30 +48,6 @@ pmc8280c_lpg: pwm {
 		};
 	};
 
-	pmc8280_2: pmic@3 {
-		compatible = "qcom,pm8350", "qcom,spmi-pmic";
-		reg = <0x3 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pm8280_2_temp_alarm: temp-alarm@a00 {
-			compatible = "qcom,spmi-temp-alarm";
-			reg = <0xa00>;
-			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
-			#thermal-sensor-cells = <0>;
-		};
-
-		pmc8280_2_gpios: gpio@8800 {
-			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
-			reg = <0x8800>;
-			gpio-controller;
-			gpio-ranges = <&pmc8280_2_gpios 0 0 10>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-	};
-
 	pmr735a: pmic@4 {
 		compatible = "qcom,pmr735a", "qcom,spmi-pmic";
 		reg = <0x4 SPMI_USID>;
-- 
2.30.2

