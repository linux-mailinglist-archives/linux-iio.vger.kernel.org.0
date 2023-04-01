Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0B6D34B5
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjDAWIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDAWI0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4352D2780F
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:23 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x20so26623095ljq.9
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Prd++xPaLuXWKrZ9/YvClXLdfWQ6hYA83t8qkIsDY/s=;
        b=X0HJIBmB+sEjaqhIloH0DkRY8Qaqtm4WsmOB2ZeSD+a2griARyH/GFyzmz1kMhjd8d
         dZSrBTSRWAWxRCcURw1a8buklE/v9eYxgjgrGda3hMpM3Oerm506ZTHOqpo7g0fiv59r
         h8tHxmPG0kwU8YVloZHepoeE4NZEo2YIc5KEHIhxttk+h1sUrgtBvO5qB+StZNi0jA8t
         UtqLhXqdNguId/JTTMTykMw8AosFguRucZ147HknoQc8xACoWCpLixgzW387VVITeX45
         iJLVD3MZeR7NQIA/EN/viMBJiAz/h/XZcJ6Zf99lb1xtJ5MqoVkpDXsThdUKF58eTH75
         ofbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Prd++xPaLuXWKrZ9/YvClXLdfWQ6hYA83t8qkIsDY/s=;
        b=KWkcdUe6GFKQ9tBRqS4YuztXS0qlOTonPWqCjv4yYVQshwahXHdecwdFg5QgEmQkQl
         rCAXfZ86MJ4N7QelWVfDKg27H+7i42g1gy1w05/OldV0jfHYdUlSiIFfcwf9Xn0fbDui
         06bCi0FhUGyO6vMRSHmbr8ADUqKi0apN6yhPFk1PK8wRNBrtO7MQy5kgmAG9u3fhRLDh
         QcP7RvVvzktavfL3YCyts/rvLkGSUPgVnfg+uKOxq1qrmuOQm576t6axyuXDrP3wBz8S
         NsHhb5O7tGbKqEVLJ9zcl+4Ehylr/RKSIDBtMlbgKdt7zdQuidRA0wHfNtWNLSqUc6vx
         uUGQ==
X-Gm-Message-State: AAQBX9dNOukQKodPdczFAHSuBifFlFSNC7iG6ahlbEqJ8qBYYi1B3Xj2
        7JFV8nBBzsrz2HQKJSVPLva7EQ==
X-Google-Smtp-Source: AKy350Y07FInGOk+rwDxq5xduEweLqehE6tsu1usirPoiFmQj1rrjZUT/sX9JfowVUsm9AU45VYS4Q==
X-Received: by 2002:a2e:aa8b:0:b0:2a1:ed00:4b9e with SMTP id bj11-20020a2eaa8b000000b002a1ed004b9emr3834703ljb.1.1680386902809;
        Sat, 01 Apr 2023 15:08:22 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:22 -0700 (PDT)
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
Subject: [PATCH v2 18/22] arm64: dts: qcom: sc8280xp*: use pm8350c.dtsi
Date:   Sun,  2 Apr 2023 01:08:06 +0300
Message-Id: <20230401220810.3563708-19-dmitry.baryshkov@linaro.org>
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

Employ PMIC_SID/_LABEL and switch sc8280xp-pmics to use pm8350c.dtsi in
order to reduce duplication and possible discrepancies.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  4 +--
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  4 +--
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  | 32 +++----------------
 3 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index d7b537284990..18f821d99434 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -24,7 +24,7 @@ aliases {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pmc8280c_lpg 3 1000000>;
+		pwms = <&pmc8280c_pwm 3 1000000>;
 		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
 		power-supply = <&vreg_edp_bl>;
 
@@ -555,7 +555,7 @@ &pcie4_phy {
 	status = "okay";
 };
 
-&pmc8280c_lpg {
+&pmc8280c_pwm {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 590400985055..c74d32f7931e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -54,7 +54,7 @@ wcd938x: audio-codec {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pmc8280c_lpg 3 1000000>;
+		pwms = <&pmc8280c_pwm 3 1000000>;
 		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
 		power-supply = <&vreg_edp_bl>;
 
@@ -725,7 +725,7 @@ &pcie4_phy {
 	status = "okay";
 };
 
-&pmc8280c_lpg {
+&pmc8280c_pwm {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 69f79ed87f62..3d2914d13fd2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -16,40 +16,16 @@
 #define PMIC_NODE pmc82801
 #include "pm8350.dtsi"
 
+#define PMIC_SID 2
+#define PMIC_LABEL pmc8280c
+#include "pm8350c.dtsi"
+
 #define PMIC_SID 3
 #define PMIC_LABEL pmc8280_2
 #define PMIC_NODE pmc82802
 #include "pm8350.dtsi"
 
 &spmi_bus {
-	pmc8280c: pmic@2 {
-		compatible = "qcom,pm8350c", "qcom,spmi-pmic";
-		reg = <0x2 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pmc8280c_gpios: gpio@8800 {
-			compatible = "qcom,pm8350c-gpio", "qcom,spmi-gpio";
-			reg = <0x8800>;
-			gpio-controller;
-			gpio-ranges = <&pmc8280c_gpios 0 0 9>;
-			#gpio-cells = <2>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		pmc8280c_lpg: pwm {
-			compatible = "qcom,pm8350c-pwm";
-
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			#pwm-cells = <2>;
-
-			status = "disabled";
-		};
-	};
-
 	pmr735a: pmic@4 {
 		compatible = "qcom,pmr735a", "qcom,spmi-pmic";
 		reg = <0x4 SPMI_USID>;
-- 
2.30.2

