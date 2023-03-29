Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014486CCE8A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC2AIn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjC2AIl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:08:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF152D68
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h11so11024851lfu.8
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680048518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQDYYo8+UubQkx926hIq/DqgEQQ/S0G2YPIgZd0iTFI=;
        b=qPcn8QdRqHa11njfKJsPvL4QTb40wYBlPWxf7fBsNsMLC/wHDBq9nyb9GjEzUyrDiM
         X+nnRMmrdNbNdN73QAbkzyodotCbEr4koG7SlTZfLm8ZO0lr9OnJJJKDPM2RoUe2Clno
         xuZeMiAKW80M3suKhS8pAdVwswKdcRm/yWh+5Ai3G0GYz1JMYLGiLK7b+5yzWhwA3WMN
         59dcLHgJDf0rZiL1veOtXM0EbTrfiBns2KPD1SaW/ZTLUVgF/88nzzDxwupS8w5QcJYQ
         5npBCh27/1F6qP7g0ZaV2ISyOxtAWcRamE7YvNEucWgDjtaHFl4dQn15zD+mPTpzo3Jn
         6oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQDYYo8+UubQkx926hIq/DqgEQQ/S0G2YPIgZd0iTFI=;
        b=UiS4aPCFfRgk1n7hdAemo37ct9oJ1wZUGxJJV8AMjutn4OwhYA1hkWUBQixijIW8ce
         qdExGEY6Lzc73JTEaykYC9NYkRmy6v0sF9LPYB+zOg7CrJF3nOTu4CwXqRQrs22V7sxq
         PsaG4LkI0weQmgbCAv+wYAfNYm+xFefxIrdvqdxKHiaCButQo37bhKF2819T6/mLTdpg
         kV7U+1RdmgVxvKErr9Tci7J6kFXuiIsQzUt1+gNRZDCnBSh2Nu9rLQsMU3nFRJuSP7V9
         KQ3naK18XgPnQj5LoUE0/+wTEKL2V1mDjy64dX1Z5ESUqkEDVTvg2lKXxdjQ2cHdY1ho
         TFGQ==
X-Gm-Message-State: AAQBX9cMTYGN0H/5j0oIYSZhhRwLIJc3rz8hM/3N5+Ez6MkHhIykEHIS
        WjEfXYDx+slqCGsdfqAVtrjI/VebETP4CAOXQ5A=
X-Google-Smtp-Source: AKy350b3iop1p6zuLzIxdAFVWn6gByDQ4b3ywhZ80fYOgL5Sa0lgpBkLLRsyXbp+D8XOaXsLSfVjVw==
X-Received: by 2002:a19:f60e:0:b0:4e2:337d:65d3 with SMTP id x14-20020a19f60e000000b004e2337d65d3mr5573643lfe.40.1680048518236;
        Tue, 28 Mar 2023 17:08:38 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004e8011cbaa0sm5238341lfo.111.2023.03.28.17.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 17:08:37 -0700 (PDT)
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
Subject: [PATCH 3/6] arm64: dts: qcom: use main pmk8350.dtsi for sc8280xp platform
Date:   Wed, 29 Mar 2023 03:08:30 +0300
Message-Id: <20230329000833.2507594-4-dmitry.baryshkov@linaro.org>
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

Employ existing PMK8350_SID and switch sc8280xp-pmics to use
pmk8350.dtsi to reduce duplication and possible discrepancies.

For example, this changes sc8280xp platforms to use qcom,pmk8350-pon
for the pon device compatibility rather than the incorrect
qcom,pm8998-pon.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi         |  9 +++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  6 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 30 ++++-----
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  | 67 ++-----------------
 4 files changed, 31 insertions(+), 81 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 455ffffb5f5c..26e40dbfc173 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -66,6 +66,15 @@ pmk8350_rtc: rtc@6100 {
 			status = "disabled";
 		};
 
+		pmk8350_sdam_6: nvram@8500 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x8500>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x8500 0x100>;
+			status = "disabled";
+		};
+
 		pmk8350_gpios: gpio@b000 {
 			compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
 			reg = <0xb000>;
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index d7b537284990..d32594b5a4e7 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -559,18 +559,18 @@ &pmc8280c_lpg {
 	status = "okay";
 };
 
-&pmk8280_pon_pwrkey {
+&pmk8350_pon_pwrkey {
 	status = "okay";
 };
 
-&pmk8280_rtc {
+&pmk8350_rtc {
 	nvmem-cells = <&rtc_offset>;
 	nvmem-cell-names = "offset";
 
 	status = "okay";
 };
 
-&pmk8280_sdam_6 {
+&pmk8350_sdam_6 {
 	status = "okay";
 
 	rtc_offset: rtc-offset@bc {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 590400985055..7d61108daede 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -275,7 +275,7 @@ thermal-zones {
 		skin-temp-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
-			thermal-sensors = <&pmk8280_adc_tm 5>;
+			thermal-sensors = <&pmk8350_adc_tm 5>;
 
 			trips {
 				skin_temp_alert0: trip-point0 {
@@ -729,12 +729,12 @@ &pmc8280c_lpg {
 	status = "okay";
 };
 
-&pmk8280_adc_tm {
+&pmk8350_adc_tm {
 	status = "okay";
 
 	sys-therm@0 {
 		reg = <0>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM1_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -742,7 +742,7 @@ sys-therm@0 {
 
 	sys-therm@1 {
 		reg = <1>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM2_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -750,7 +750,7 @@ sys-therm@1 {
 
 	sys-therm@2 {
 		reg = <2>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM3_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -758,7 +758,7 @@ sys-therm@2 {
 
 	sys-therm@3 {
 		reg = <3>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -766,7 +766,7 @@ sys-therm@3 {
 
 	sys-therm@4 {
 		reg = <4>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM1_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -774,7 +774,7 @@ sys-therm@4 {
 
 	sys-therm@5 {
 		reg = <5>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM2_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -782,7 +782,7 @@ sys-therm@5 {
 
 	sys-therm@6 {
 		reg = <6>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM3_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
@@ -790,29 +790,29 @@ sys-therm@6 {
 
 	sys-therm@7 {
 		reg = <7>;
-		io-channels = <&pmk8280_vadc PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
+		io-channels = <&pmk8350_vadc PM8350_ADC7_AMUX_THM4_100K_PU(3)>;
 		qcom,hw-settle-time-us = <200>;
 		qcom,avg-samples = <2>;
 		qcom,ratiometric;
 	};
 };
 
-&pmk8280_pon_pwrkey {
+&pmk8350_pon_pwrkey {
 	status = "okay";
 };
 
-&pmk8280_pon_resin {
+&pmk8350_pon_resin {
 	status = "okay";
 };
 
-&pmk8280_rtc {
+&pmk8350_rtc {
 	nvmem-cells = <&rtc_offset>;
 	nvmem-cell-names = "offset";
 
 	status = "okay";
 };
 
-&pmk8280_sdam_6 {
+&pmk8350_sdam_6 {
 	status = "okay";
 
 	rtc_offset: rtc-offset@bc {
@@ -820,7 +820,7 @@ rtc_offset: rtc-offset@bc {
 	};
 };
 
-&pmk8280_vadc {
+&pmk8350_vadc {
 	status = "okay";
 
 	pmic-die-temp@3 {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index c35e7f6bd657..781fb6448a52 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -51,70 +51,11 @@ trip1 {
 	};
 };
 
-&spmi_bus {
-	pmk8280: pmic@0 {
-		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pmk8280_pon: pon@1300 {
-			compatible = "qcom,pm8998-pon";
-			reg = <0x1300>;
-
-			pmk8280_pon_pwrkey: pwrkey {
-				compatible = "qcom,pmk8350-pwrkey";
-				interrupts-extended = <&spmi_bus 0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
-				linux,code = <KEY_POWER>;
-				status = "disabled";
-			};
-
-			pmk8280_pon_resin: resin {
-				compatible = "qcom,pmk8350-resin";
-				interrupts-extended = <&spmi_bus 0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
-				status = "disabled";
-			};
-		};
-
-		pmk8280_vadc: adc@3100 {
-			compatible = "qcom,spmi-adc7";
-			reg = <0x3100>;
-			interrupts-extended = <&spmi_bus 0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#io-channel-cells = <1>;
-			status = "disabled";
-		};
-
-		pmk8280_adc_tm: adc-tm@3400 {
-			compatible = "qcom,spmi-adc-tm5-gen2";
-			reg = <0x3400>;
-			interrupts-extended = <&spmi_bus 0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#thermal-sensor-cells = <1>;
-			status = "disabled";
-		};
-
-		pmk8280_rtc: rtc@6100 {
-			compatible = "qcom,pmk8350-rtc";
-			reg = <0x6100>, <0x6200>;
-			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
-			wakeup-source;
-			status = "disabled";
-		};
-
-		pmk8280_sdam_6: nvram@8500 {
-			compatible = "qcom,spmi-sdam";
-			reg = <0x8500>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x8500 0x100>;
-			status = "disabled";
-		};
-	};
+#define PMK8350_SID 0
+#include "pmk8350.dtsi"
+#undef PMK8350_SID
 
+&spmi_bus {
 	pmc8280_1: pmic@1 {
 		compatible = "qcom,pm8350", "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
-- 
2.30.2

