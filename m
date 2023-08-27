Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40149789E3B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjH0N0T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjH0NZp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCBDCEE
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50078eba7afso3740749e87.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142737; x=1693747537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/uFYzKBfDqxN7TN/A9wLoMgNTaV3aT+WyYPs1U/WFk=;
        b=ENg1NmqzPgHXu7JG/8ETUiFjAdxeGQpuVw/Y70B+E+nzDBsdThxvXJdAoLPRRTniX9
         BUijm+JQM6jkPUQhH/beQswGlOoAfdi7Fp3cRH4v7zRvkoq6KQT6CEYbcdBGh5hNT4G/
         qt8o7mEyjADVgbvCOR1zHfQtl6x+hzageHaGCFZF/srEo2/ihuP599F0jJc5W/9d0+6S
         3m7CwKDuz3wn7UHLZlCQ940Lj38Z26UJC2WDYznPfchOBP+vVGVDBjHAlrOLGRttLXG0
         L0m7vNnxTzoVlrObapuA84tHGpqverbGIfm5yJbCP+BwYZLlX1TRv9BG3NQGTeryTn81
         5aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142737; x=1693747537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/uFYzKBfDqxN7TN/A9wLoMgNTaV3aT+WyYPs1U/WFk=;
        b=UfgjEbYMxxZfwe6nC8I0auKVDzUhshHMoV9kS0nmKAf/R3h7RhduX9Zs0YyM8U1Cr6
         S5esUGjV8suZMvTOeTwJS6bqc3MJunVrASF/vZ4aRjmBM0EfI52KAcnkmyfxqyf+b6kO
         y3cYTNM26Mo1/XtsqjLlXf5PLas7eNNsdWB6OkfX5ZerV3XrSiQI0FgNQ9egHUtsJSOU
         HsHU0fGKN6GLnYNvGIJ7YnlS28uOFbGW6oJaFwliRjm9wcyegiSpCDAGyctadEHT+uWd
         ajwRRnTMJd2Zho+fqOHr+cI1ylacvNW3nHyXclNTOVsg7MZ+jL6eHJ7Ly94y9EF+lzAm
         QORQ==
X-Gm-Message-State: AOJu0YxY3zdMMP9QpWmy8fYaj3QH2CMJJcrs/gdYy2vX9T/wTUmKulJ5
        oOU1rVFMwRcWN8SPkl/xuSqvZA==
X-Google-Smtp-Source: AGHT+IGmyJIZ9lh0JzmqGSN3mEqtIy1GbkbAD6qpYQO2SSTwfeYyyGU9FmWB2IeRv2ZPbmM2wOmfhw==
X-Received: by 2002:a05:6512:318f:b0:500:b74b:e53 with SMTP id i15-20020a056512318f00b00500b74b0e53mr1077646lfe.46.1693142737583;
        Sun, 27 Aug 2023 06:25:37 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:37 -0700 (PDT)
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
Subject: [PATCH v5 13/37] ARM: dts: qcom: apq8064: move PMIC interrupts to the board files
Date:   Sun, 27 Aug 2023 16:25:01 +0300
Message-Id: <20230827132525.951475-14-dmitry.baryshkov@linaro.org>
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

