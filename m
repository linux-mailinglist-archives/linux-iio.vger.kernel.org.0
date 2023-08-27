Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31928789E6A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjH0N03 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjH0NZx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14E4188
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffa248263cso3767761e87.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142744; x=1693747544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBqdCLgmI8uo0vU5eXIGi0ZDA2gUAaQ0wjWhyRHtIN4=;
        b=WzQDdhbxhyb3CFD1Ise9X43yeK0eBklubmQUALdbE1mtUmKBOuzfr87dOnMyFppsyc
         Fg6yQEwmPWufbSacCC+vl/M66bGtsyv9yIFG11cMECGm6o5QK0c7oon7YLgmvnwY64Ez
         4ebrhPPRTAUqw6QZ+e9RLDXmUGgEPYrhb1d001goT1clB9CA1GcovokQbxjqvSxYJE6/
         GEUMMNjGP47MOb6EBsZYcH6r1XX3a7rg20qLdxxhj39k8u+ANKEZRNJUdD1J1eCJd4Ct
         BNQb6tglCvz0mPrImMP5DlsNZia1qBd2wygC/Z6auMJpgb8FpgVH4RPSqL0OF45bP1Jz
         Fw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142744; x=1693747544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBqdCLgmI8uo0vU5eXIGi0ZDA2gUAaQ0wjWhyRHtIN4=;
        b=HNRiexWA1eCeV1fYIBzdv7wTfdLFJKLD52DPcKSFelZsgH5LpVbVZVlaa+mRo3QyiV
         anTgAqc4SnooQBK370+CFBkk0PyrqwI0FiunxSrekZuaicAlC0YWLdfpJDs5P1c0PrBn
         UgH2HHARaqi6KaXa578nG5f70yRYhO0iPHPuk35RGnaJmUdjxjaUHHrXW3r2zxUP3aII
         bE+Sh5aU+6ZGVxI/9vzc134mse03RCcvOsmnVGxJm6TMOTb3S9jjL1j37aonddJTJwMZ
         qFqg56HxLhK8p0DWL5gCUr5MNl1QmO1Kwzch3ij5b38aowR0X2FgL5hvp19yaZx0KUpM
         J5uA==
X-Gm-Message-State: AOJu0YzazF6ySeBiS0kLj9YkC/+MzZ3BxV4y9RHnb2NIdzZ2/+4FNW8X
        v2jYrSPPl1p5EVFiQNCx30Mx2A==
X-Google-Smtp-Source: AGHT+IHEsWLff8sz7+cXozX2g3wUtTemGaeTU2/vVa3eItFY48+c64WhGvM8vc5AZmrlm3v37xfpbQ==
X-Received: by 2002:ac2:520c:0:b0:500:a5af:86a4 with SMTP id a12-20020ac2520c000000b00500a5af86a4mr5030921lfl.43.1693142744115;
        Sun, 27 Aug 2023 06:25:44 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:43 -0700 (PDT)
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
Subject: [PATCH v5 21/37] ARM: dts: qcom: pm8058: reorder nodes
Date:   Sun, 27 Aug 2023 16:25:09 +0300
Message-Id: <20230827132525.951475-22-dmitry.baryshkov@linaro.org>
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

Move pm8058 device nodes to follow the alphanumberic sorting order.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/pm8058.dtsi | 90 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/pm8058.dtsi b/arch/arm/boot/dts/qcom/pm8058.dtsi
index ad581c3bcbd2..913a511719fa 100644
--- a/arch/arm/boot/dts/qcom/pm8058.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8058.dtsi
@@ -8,15 +8,24 @@ pm8058: pmic {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pm8058_gpio: gpio@150 {
-			compatible = "qcom,pm8058-gpio",
-				     "qcom,ssbi-gpio";
-			reg = <0x150>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pm8058_gpio 0 0 44>;
-			#gpio-cells = <2>;
+		pwrkey@1c {
+			compatible = "qcom,pm8058-pwrkey";
+			reg = <0x1c>;
+			interrupt-parent = <&pm8058>;
+			interrupts = <50 1>, <51 1>;
+			debounce = <15625>;
+			pull-up;
+		};
+
+		pm8058_led48: led@48 {
+			compatible = "qcom,pm8058-keypad-led";
+			reg = <0x48>;
+			status = "disabled";
+		};
+
+		vibrator@4a {
+			compatible = "qcom,pm8058-vib";
+			reg = <0x4a>;
 		};
 
 		pm8058_mpps: mpps@50 {
@@ -30,13 +39,22 @@ pm8058_mpps: mpps@50 {
 			#interrupt-cells = <2>;
 		};
 
-		pwrkey@1c {
-			compatible = "qcom,pm8058-pwrkey";
-			reg = <0x1c>;
-			interrupt-parent = <&pm8058>;
-			interrupts = <50 1>, <51 1>;
-			debounce = <15625>;
-			pull-up;
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
 		};
 
 		pm8058_keypad: keypad@148 {
@@ -49,6 +67,17 @@ pm8058_keypad: keypad@148 {
 			row-hold = <91500>;
 		};
 
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
 		pm8058_xoadc: xoadc@197 {
 			compatible = "qcom,pm8058-adc";
 			reg = <0x197>;
@@ -109,35 +138,6 @@ rtc@1e8 {
 			interrupts = <39 1>;
 			allow-set-time;
 		};
-
-		vibrator@4a {
-			compatible = "qcom,pm8058-vib";
-			reg = <0x4a>;
-		};
-
-		pm8058_led48: led@48 {
-			compatible = "qcom,pm8058-keypad-led";
-			reg = <0x48>;
-			status = "disabled";
-		};
-
-		pm8058_led131: led@131 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x131>;
-			status = "disabled";
-		};
-
-		pm8058_led132: led@132 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x132>;
-			status = "disabled";
-		};
-
-		pm8058_led133: led@133 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x133>;
-			status = "disabled";
-		};
 	};
 };
 
-- 
2.39.2

