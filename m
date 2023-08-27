Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D36789A4F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjH0BAH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjH0A7k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10F1AC
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so31876991fa.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097975; x=1693702775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/uFYzKBfDqxN7TN/A9wLoMgNTaV3aT+WyYPs1U/WFk=;
        b=ZJDQggftIaHpnjRJ99L0XiXXXtFK07GRcwhbH7MDqnanOsd+RAfwO1lHh9+Y2+cOOP
         tEgp4tVYatoxkCvb+3pR8EC6bhK7BnMTGyK+QDOBjAQFqAXf6eTX+Vo9Jcs8Mr9/E5aV
         V8PZqJd5jc/TobLs/4uQbFiS680RqblXrFfk7TX+X3WcVpKhtNUOcdr5CyRTIM+SbeKs
         RGc/LAdVBfuguyxXlgCAqPSnDWqWbspOLbYKhT3IwEDVe+Yd+7rXxNlmIbSgG/ODxPFL
         J2pzQuG9hVKW++B8aQtBCUl6bU6frSaPXA4Uc1B879phFw4fwdgJrdHO+x8M9DaI57sp
         OMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097975; x=1693702775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/uFYzKBfDqxN7TN/A9wLoMgNTaV3aT+WyYPs1U/WFk=;
        b=DBAU8Ci+V6wMii8yfRu1XzzpEKKMpr4yF5D7PmaqYwI0PXqrn+18sAceeRp7/rn8Ue
         3XSXTt2D3oeRf/xDMw0FxAgc28I7lodT1Zifb1wLuhkGLMdImqaAZ6t3EjdEkVur1n4y
         b/V2AH4G5JSGdYhfLD5YxMt5WZIVnBrhqF10ZR/X89UctRZN1dNBABowZEyPRcKyU4HZ
         I01FV6pvtMDoueD7p0KsQ2y7e1cxtS9zCPNDV6kNrxdi0QdztyXe6E82zaR7KngSLczo
         /ncRQldYPqVcQLdLNuw+LCxNYPxQ6+f3maxeUiEpLngmLoCjrtVDV6nHdaN4Pc+7+J5/
         M88Q==
X-Gm-Message-State: AOJu0YxlnduoHYjSNODNBH9H50vQ2swzavmSARMa6Enp1nGEWiJ44TV4
        3o5HYVJXbcSB26DpUhg+Oo1hYg==
X-Google-Smtp-Source: AGHT+IFXq4EzfFRO/m2zlqJdxRYL+kGlY9I0hSQSAqhn/n5IfcnvB1SBvCicq76KguJR5LXZCHg+Sg==
X-Received: by 2002:a05:6512:33c1:b0:4f8:4512:c846 with SMTP id d1-20020a05651233c100b004f84512c846mr20095528lfg.49.1693097975151;
        Sat, 26 Aug 2023 17:59:35 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:34 -0700 (PDT)
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
Subject: [PATCH v4 14/38] ARM: dts: qcom: apq8064: move PMIC interrupts to the board files
Date:   Sun, 27 Aug 2023 03:58:56 +0300
Message-Id: <20230827005920.898719-15-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
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

The interrupt of SSBI PMICs is routed to the SoCs GPIO. As such, it is
not a property of the SoC, it is a property of the particular board
(even if it is standard and unified between all devices). Move these
interrupt specifications to the board files.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts   | 8 ++++++++
 arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts          | 8 ++++++++
 arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts           | 8 ++++++++
 .../boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts | 8 ++++++++
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi                  | 4 ----
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index 0e80a5a8e3c6..b820f3255c16 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -185,6 +185,14 @@ &mdp_dsi1_out {
 	remote-endpoint = <&dsi0_in>;
 };
 
+&pm8821 {
+	interrupts-extended = <&tlmm_pinmux 76 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&pm8921 {
+	interrupts-extended = <&tlmm_pinmux 74 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &rpm {
 	regulators {
 		vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
index d6ecfd8addb7..c01254b1a3a7 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
@@ -69,6 +69,14 @@ &pcie {
 	status = "okay";
 };
 
+&pm8821 {
+	interrupts-extended = <&tlmm_pinmux 76 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&pm8921 {
+	interrupts-extended = <&tlmm_pinmux 74 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &pm8921_gpio {
 	wlan_default_gpios: wlan-gpios-state {
 		pinconf {
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index 96307550523a..f1bd29333c9b 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -171,6 +171,14 @@ &pcie {
 	perst-gpios = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
 };
 
+&pm8821 {
+	interrupts-extended = <&tlmm_pinmux 76 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&pm8921 {
+	interrupts-extended = <&tlmm_pinmux 74 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &pm8921_gpio {
 	wlan_default_gpios: wlan-gpios-state {
 		pinconf {
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
index 9244512b74d1..7917f1657025 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -65,6 +65,14 @@ &gsbi5_serial {
 	status = "okay";
 };
 
+&pm8821 {
+	interrupts-extended = <&tlmm_pinmux 76 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&pm8921 {
+	interrupts-extended = <&tlmm_pinmux 74 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &pm8921_gpio {
 	gpio_keys_pin_a: gpio-keys-active-state {
 		pins = "gpio3", "gpio4", "gpio29", "gpio35";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 6514d728b1ec..76796002bda6 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -662,8 +662,6 @@ ssbi@c00000 {
 
 			pm8821: pmic {
 				compatible = "qcom,pm8821";
-				interrupt-parent = <&tlmm_pinmux>;
-				interrupts = <76 IRQ_TYPE_LEVEL_LOW>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
 				#address-cells = <1>;
@@ -688,8 +686,6 @@ ssbi@500000 {
 
 			pm8921: pmic {
 				compatible = "qcom,pm8921";
-				interrupt-parent = <&tlmm_pinmux>;
-				interrupts = <74 8>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
 				#address-cells = <1>;
-- 
2.39.2

