Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C36D34BD
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjDAWIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjDAWI3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDDB27839
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by14so7466048ljb.12
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFAjGC6zhILn0mPDKxdlAN+y3zIIQ7ldIAczmYLBd2A=;
        b=E6m9YA+qlZGexpONIIU75zHZXRTM7DPLwq7cQkLNBc2wFE9185ToWbeehqqwpl5cmJ
         LcG0RHc/i5ls7z7Ljo740RzL6FxpfR7f+STsxOX2n+oIp89pkbVdez+4jiMc/JIJZsXX
         M6qwmm2ZKVi1+6AAT6ucHex2L5WuO1d4Ku/iOG4rAM/Eit23o6AsH2YjB5X6fF/SnSG5
         crR/I3qoExdcuCx7Nz4y7kx2eTY9+SXTgBr5GH51gE0oTOf+vnkmaWDoNvfpKH9jvf2x
         fx/bxlZZ9JlWTr40YcqQqw7jM0JOgM9ganDle21cyKASkniX4YqnmhICId76w9Qd6xvC
         Vigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFAjGC6zhILn0mPDKxdlAN+y3zIIQ7ldIAczmYLBd2A=;
        b=yw2nGjUurUpUaqb6GpaDKDSe3OrCL/6LWtcrwqacaOXZYUCAhT0lxh3jKkKtlY3ISu
         PV6lhJowcVRsU6zkz7TId9fmNRMEBF0OUZzpyTjGQVrcAk3yH+HywMGgi4HRXbCpvZJA
         isAQQkAeAdzjZO07VzdLRkSen7pWRmwYW14ofQm7kq3kJ8DMgRKhrql+ex3K3HVz3ECF
         k7Z7Ppk03hQ+x+atSuo3DPNsMGnTMzHtYlvEXEpncrO79wJRGLXZZl5EZRAs9t0SV6ce
         +W1u6Idljn04vacqtj8FUoZOdsZGdA6aPXyTx/xZ26nscGzLcUmlz/5zDBjnGOUnKCx2
         sBdg==
X-Gm-Message-State: AAQBX9dEyRedpjYRTxD5PIAW/J8ijbUp1YeyX7ZX7EzrTbkgfbHjS2Kt
        RFNc6+9eqAJPCo/nAx1xRkHB0g==
X-Google-Smtp-Source: AKy350a94Su8jmKkZ/4NO1jhSAxMM3jX5OQ85DUUOpiRViRuYvwfcPgmfXV8EaMZwoeZNTalOQIXcA==
X-Received: by 2002:a2e:7812:0:b0:298:a853:1c3c with SMTP id t18-20020a2e7812000000b00298a8531c3cmr9343919ljc.4.1680386904575;
        Sat, 01 Apr 2023 15:08:24 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:24 -0700 (PDT)
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
Subject: [PATCH v2 21/22] arch: arm64: dts: qcom: pm8150: support SID greater that 9
Date:   Sun,  2 Apr 2023 01:08:09 +0300
Message-Id: <20230401220810.3563708-22-dmitry.baryshkov@linaro.org>
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

Supporting SIDs greater than 9 required additional handling in order to
properly generatae hex values. Apply this customization to pm8150.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi          | 16 ++++++++--------
 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi |  6 ++++++
 arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi |  6 ++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 77bb325e425b..37cc99e5d1a6 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -58,7 +58,7 @@ trip2 {
 &spmi_bus {
 	pmic@0 {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <PMIC_SID SPMI_USID>;
+		reg = <PMIC_SID_HEX SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -70,7 +70,7 @@ pon: pon@800 {
 
 			pon_pwrkey: pwrkey {
 				compatible = "qcom,pm8941-pwrkey";
-				interrupts = <PMIC_SID 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMIC_SID_HEX 0x8 0x0 IRQ_TYPE_EDGE_BOTH>;
 				debounce = <15625>;
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
@@ -80,7 +80,7 @@ pon_pwrkey: pwrkey {
 
 			pon_resin: resin {
 				compatible = "qcom,pm8941-resin";
-				interrupts = <PMIC_SID 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMIC_SID_HEX 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
 				debounce = <15625>;
 				bias-pull-up;
 
@@ -91,7 +91,7 @@ pon_resin: resin {
 		LABEL(temp): temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
-			interrupts = <PMIC_SID 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <PMIC_SID_HEX 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
 			io-channels = <&LABEL(adc) ADC5_DIE_TEMP>;
 			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
@@ -103,7 +103,7 @@ LABEL(adc): adc@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			interrupts = <PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMIC_SID_HEX 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
 			ref-gnd@0 {
 				reg = <ADC5_REF_GND>;
@@ -127,7 +127,7 @@ die-temp@6 {
 		LABEL(adc_tm): adc-tm@3500 {
 			compatible = "qcom,spmi-adc-tm5";
 			reg = <0x3500>;
-			interrupts = <PMIC_SID 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMIC_SID_HEX 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
 			#thermal-sensor-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -138,7 +138,7 @@ rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
-			interrupts = <PMIC_SID 0x61 0x1 IRQ_TYPE_NONE>;
+			interrupts = <PMIC_SID_HEX 0x61 0x1 IRQ_TYPE_NONE>;
 		};
 
 		LABEL(gpios): gpio@c000 {
@@ -154,7 +154,7 @@ LABEL(gpios): gpio@c000 {
 
 	pmic@PMIC_SID1 {
 		compatible = "qcom,pm8150", "qcom,spmi-pmic";
-		reg = <PMIC_SID1 SPMI_USID>;
+		reg = <PMIC_SID1_HEX SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
index 83a2bada48ff..f3743ef3aa13 100644
--- a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
@@ -11,6 +11,12 @@
 
 #undef NODE
 
+#undef HEX
+#undef _HEX
+
+#undef PMIC_SID_HEX
+#undef PMIC_SID1_HEX
+
 #undef PMIC_SID
 #undef PMIC_SID1
 #undef PMIC_LABEL
diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
index bb41c9387aba..640d1bf5ce8e 100644
--- a/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
@@ -18,3 +18,9 @@
 #define __LABEL(pmic, name) pmic ## _ ## name
 
 #define NODE(name) PMIC_NODE ##-##  name
+
+#define HEX(sid) _HEX(sid)
+#define _HEX(sid) 0x## sid
+
+#define PMIC_SID_HEX HEX(PMIC_SID)
+#define PMIC_SID1_HEX HEX(PMIC_SID1)
-- 
2.30.2

