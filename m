Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6350F6D34BA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDAWIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDAWI2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94334265A9
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b6so6591274ljr.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4p6ERzkRu9AnspBZ9AUdWZ5pV1CnYsS0+M38enTe40=;
        b=QJkW3nrrwWYXButVD/8lohroU9VKsy0Tz9GCgpQYYtdNEiQaoFsKHuztsjtChSDcBp
         enmC5Y696r0oyOYF60G/qGY4YN89XpCwnC5AOPiqyG9q7JWOxNJMtdGfZ00/aPijC5u3
         3D0o25iF8XApAWX44NvyfUCEtgzsDZhL4msP+dYpm7PMSxY+mmmEttbYP+kvtGcsayN6
         dL0Y+fWsr69l2YdbB2xfx/R4YVHj2zh/CgSjFkACTEaj0FOA/OZf+H2yCDcP9inX9PoT
         ZiNFE96EaX0LRbdaynht3Br7wfOnK38ANohaPxrCYJ1RiKH+z1K77BGT/1FPfwnhGV59
         sqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4p6ERzkRu9AnspBZ9AUdWZ5pV1CnYsS0+M38enTe40=;
        b=DNJnjOSeLpUgYLuD54ZL5UheaFskGbpKiHou0+rVBmSQXhDouccqARFBmWpw8NckUf
         oYouEtIkTtvLB1ARGxLTe5vi4P/rppw41jsX8Uu2hpMUVlqXP3BVtYD8iBMMqkW/Z8hk
         PY2QVTh88sLNWqPh5TmewHUwWaGGXsc9h3liwkfJpDLqHJaQJ53b6JZ6A1hIilyaNvQ/
         OgV9iB9km5XXy45OkJaNjWYfFfi4F4dcKM5vFuF+9kkMITzHJp4p50EtkRozW2aFVXcd
         WnZPGMQh2DslAenHnFvqHUI6AOCArIREPKa5gJHmjsLuCznCXfr6cPOmJfHhoKED597x
         p1PQ==
X-Gm-Message-State: AAQBX9d/bJXe4ykndz8EJIKVX6hYQ3Z+6VLxJ55IwiaibzDKqqa+jsRI
        Jq0TFTlXvY2AaQ24tE71v0Vhrg==
X-Google-Smtp-Source: AKy350YSwXn/xytYEtSL/8SZ4zXa7JBKVo9QRL5uy42lweXVIbHc7vyTxdHGFOoeFIg8b9VXeriHGA==
X-Received: by 2002:a2e:a40e:0:b0:2a6:22fd:6b08 with SMTP id p14-20020a2ea40e000000b002a622fd6b08mr1938648ljn.3.1680386903986;
        Sat, 01 Apr 2023 15:08:23 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 20/22] arm64: dts: qcom: pm8150: convert to use dynamic SID/LABEL
Date:   Sun,  2 Apr 2023 01:08:08 +0300
Message-Id: <20230401220810.3563708-21-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
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

SA8450p-based platforms have 4 instances of pm8150. Convert pm8150.dtsi
to use pmic-dyn-header.dtsi in order to support dynamic and label
assignment.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi          | 53 ++++++++++++-------
 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi |  1 +
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index db90c55fa2cf..77bb325e425b 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -9,13 +9,28 @@
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/iio/qcom,spmi-vadc.h>
 
+/* (Sadly) this PMIC can be configured to be at different SIDs */
+#ifndef PMIC_SID
+	#define PMIC_SID 0
+#endif
+
+#ifndef PMIC_SID1
+	#define PMIC_SID1 1
+#endif
+
+#ifndef PMIC_LABEL
+	#define PMIC_LABEL pm8150
+#endif
+
+#include "pmic-dyn-header.dtsi"
+
 / {
 	thermal-zones {
-		pm8150-thermal {
+		NODE(thermal) {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 
-			thermal-sensors = <&pm8150_temp>;
+			thermal-sensors = <&LABEL(temp)>;
 
 			trips {
 				trip0 {
@@ -41,9 +56,9 @@ trip2 {
 };
 
 &spmi_bus {
-	pm8150_0: pmic@0 {
+	pmic@0 {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
+		reg = <PMIC_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -55,7 +70,7 @@ pon: pon@800 {
 
 			pon_pwrkey: pwrkey {
 				compatible = "qcom,pm8941-pwrkey";
-				interrupts = <0x0 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMIC_SID 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
 				debounce = <15625>;
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
@@ -65,7 +80,7 @@ pon_pwrkey: pwrkey {
 
 			pon_resin: resin {
 				compatible = "qcom,pm8941-resin";
-				interrupts = <0x0 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMIC_SID 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
 				debounce = <15625>;
 				bias-pull-up;
 
@@ -73,22 +88,22 @@ pon_resin: resin {
 			};
 		};
 
-		pm8150_temp: temp-alarm@2400 {
+		LABEL(temp): temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
-			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
-			io-channels = <&pm8150_adc ADC5_DIE_TEMP>;
+			interrupts = <PMIC_SID 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			io-channels = <&LABEL(adc) ADC5_DIE_TEMP>;
 			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
 		};
 
-		pm8150_adc: adc@3100 {
+		LABEL(adc): adc@3100 {
 			compatible = "qcom,spmi-adc5";
 			reg = <0x3100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
 			ref-gnd@0 {
 				reg = <ADC5_REF_GND>;
@@ -109,10 +124,10 @@ die-temp@6 {
 			};
 		};
 
-		pm8150_adc_tm: adc-tm@3500 {
+		LABEL(adc_tm): adc-tm@3500 {
 			compatible = "qcom,spmi-adc-tm5";
 			reg = <0x3500>;
-			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMIC_SID 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
 			#thermal-sensor-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -123,24 +138,26 @@ rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+			interrupts = <PMIC_SID 0x61 0x1 IRQ_TYPE_NONE>;
 		};
 
-		pm8150_gpios: gpio@c000 {
+		LABEL(gpios): gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
-			gpio-ranges = <&pm8150_gpios 0 0 10>;
+			gpio-ranges = <&LABEL(gpios) 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 	};
 
-	pmic@1 {
+	pmic@PMIC_SID1 {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <0x1 SPMI_USID>;
+		reg = <PMIC_SID1 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
 };
+
+#include "pmic-dyn-footer.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
index 29b10e7fb8c3..83a2bada48ff 100644
--- a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
@@ -12,5 +12,6 @@
 #undef NODE
 
 #undef PMIC_SID
+#undef PMIC_SID1
 #undef PMIC_LABEL
 #undef PMIC_NODE
-- 
2.30.2

