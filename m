Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E97789E4A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjH0N0Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjH0NZr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BE1B1
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso4019259e87.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142740; x=1693747540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ri9rnBcw0W1qOwLlQ2m7qIoeFZgXWEcLeX6e6XSReOc=;
        b=cs1+63JKby2ocFBdvTb2ZVWZGagpFDc3ExWmRz1ZXCYbp82dloCfC5XKdsLGZYheL4
         o3ESv7i9HXlvBVzx5mWYjy/o5l29Ca205GhQr4yVc/y235WHHTD6vPBvMWnajxIjG4Uf
         rzSbo0PlxL/o787dHK8BVlicdPFWQ/8uNjZ7LK1yGU+TmUxWRXoi7uyj0OFmhD4+OPYD
         jSsNJOKCK4JQWNTZ7uCo50KKZ6Kve4ujhARI6cd0Qi0FwtuWK3BP3SM2+C670a0ndBPs
         m1dFXbpdAgEk3BBtRzBG8/tIGKVilHCIght8j0C6qBgU7sollEzKmxC9ATq+349t4Ky3
         fHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142740; x=1693747540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri9rnBcw0W1qOwLlQ2m7qIoeFZgXWEcLeX6e6XSReOc=;
        b=jl6KdHyqa/1vN1u46s4wpkXOmxes2PZ8axx6kVQHDVTiqtbYlvXgoYG7SLq4tKl19c
         8GMXRTHIlpPC5dlsKoYUL5ZzYDUSfhirdvEk72ar36sFLwxcToWqffYyfnNs1/lUSsd4
         RShjVTOlyy+c50MWZ2P+c1gZI7l098n0yvSUiist59gBJWgHSkR+jTyjM7AgJAp2iDpY
         jBUDfud8lb2MGg1RpEQdfdyW0F49+IdT0CK9dHlVE4tejmEerxDZJ3nQfsEbCue0I8iN
         vMpGEFgRK6lJsY6pKgXYb+PzjBxepvNVeZmTyAWJB0J3kmMuABDH+kCFLCUcGMm7Z9kU
         b9Wg==
X-Gm-Message-State: AOJu0YxvmkvRfESRLBYbZru21Z5XVIw+hMWF0ga3523BDglq+61U4UYV
        n8I9h15NGb5fzAIbd0vJ+NNB3w==
X-Google-Smtp-Source: AGHT+IHSEtkXU6xPOjxwzRKjzVfifStq0O2VYy/tvlLQ0hzwYmh+RjxmbeLPYlCaihP99OIIb0i0Hg==
X-Received: by 2002:a05:6512:b03:b0:500:8fcb:e0c8 with SMTP id w3-20020a0565120b0300b005008fcbe0c8mr4928176lfu.10.1693142739921;
        Sun, 27 Aug 2023 06:25:39 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:39 -0700 (PDT)
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
Subject: [PATCH v5 16/37] ARM: dts: qcom: msm8960: move PMIC interrupts to the board files
Date:   Sun, 27 Aug 2023 16:25:04 +0300
Message-Id: <20230827132525.951475-17-dmitry.baryshkov@linaro.org>
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
 arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts                | 4 ++++
 arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts | 4 ++++
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi                   | 2 --
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
index 4641b4f2195d..43149c90c4fc 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
@@ -88,6 +88,10 @@ clk-pins {
 	};
 };
 
+&pm8921 {
+	interrupts-extended = <&msmgpio 104 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &pm8921_keypad {
 	linux,keymap = <
 		MATRIX_KEY(0, 0, KEY_VOLUMEUP)
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index 13e85c287498..9e203164beb6 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -84,6 +84,10 @@ clk-pins {
 	};
 };
 
+&pm8921 {
+	interrupts-extended = <&msmgpio 104 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &rpm {
 	regulators {
 		compatible = "qcom,rpm-pm8921-regulators";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index ea2d961b266b..f1267c83d67a 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -266,8 +266,6 @@ ssbi@500000 {
 
 			pm8921: pmic {
 				compatible = "qcom,pm8921";
-				interrupt-parent = <&msmgpio>;
-				interrupts = <104 IRQ_TYPE_LEVEL_LOW>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
 				#address-cells = <1>;
-- 
2.39.2

