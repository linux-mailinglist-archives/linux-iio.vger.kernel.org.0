Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4F2789E2A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjH0N0R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjH0NZm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC0CCC8
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500b6456c7eso568672e87.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142734; x=1693747534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tXAJeuiQtGgKA8BCw8CS7aa8g2kLTD4bdEBZkP9I3s=;
        b=daD9ARWCDN16lW/XcIYv2r6Bx2umzwMzHPEBgT0qOz22Tnz5Sgtq4Xsc86D70VJYfN
         tTIiy0M5/6vOqSMeSVrZ8ydtubDGqhOHmb8mAsBZ2TumgvwYgGmrZW8RbG3QHuA3TgUS
         3DwKUjXsmfq9Uzd18pVEN3ZzIFbf5RiyHLoZo/5TOiSAmvMCDxlYw2gEyI6y7FsXp9WD
         X3uxZzHv7ZEdDL9xnv0izdTod/r9TSoJloR/mM1BDDYqHCypgnStcS2Z6h53G8SBOrc9
         y6ZsYQAPaiA/pCSMq5B/uAbMXANvtnNE0mY6MnSkm3VifQWOPjtpQdXuurIn/gZMUh1k
         EvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142734; x=1693747534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tXAJeuiQtGgKA8BCw8CS7aa8g2kLTD4bdEBZkP9I3s=;
        b=dWJ5BlxYdVXV8loSFcAjLldZTYkqKccM7Q29CJA/wj3WjQdaKn1P4WnwH5uy9pceYo
         tUvDrd1mWqJAQ+RTcNspsjeiYB5Q81/PrGu3dCIzSaAhd5j3oWS+y7Q6ZcREsvzw3GqR
         1c3GsFfCFpZKswaKW/lL9LNJBKyy+AVFZMFpj5nkkLI5Gn/oDNw9akLVyd3bwdAzh9KH
         ++pO/X3eTNkddKn3NcrKUSul2HUc3ms98RPjjfTqBoNZsdfWsmpR3oCWfK05/RvT/mFM
         CoUEf8UKTdeuW/lu2Ub8kJxf3jzJOLNSmDcobKGSPa4wo/gph1PBKD/hfBaSAybFFFkd
         XHxQ==
X-Gm-Message-State: AOJu0YzP+wuh7F6k+ZPaA/XlPM1EiYpbKpQxoc3IRcfGg9RyJUumrHwX
        YAIoGXN3/hE6SPRuPq2wkgFzhQ==
X-Google-Smtp-Source: AGHT+IEn+KkLkLdfMUFm+FjjFlUdHvav1Gxy+1tdPkPmurwBWkE+Xp2eXUe4+8r72E+jjSvGC0RnwA==
X-Received: by 2002:a05:6512:7c:b0:500:aed0:cb1b with SMTP id i28-20020a056512007c00b00500aed0cb1bmr2543171lfo.24.1693142734282;
        Sun, 27 Aug 2023 06:25:34 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:33 -0700 (PDT)
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
Subject: [PATCH v5 09/37] ARM: dts: qcom: apq8064: fix PMIC node labels
Date:   Sun, 27 Aug 2023 16:24:57 +0300
Message-Id: <20230827132525.951475-10-dmitry.baryshkov@linaro.org>
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

Change PM8921 node labels to start with pm8921_ prefix, following other
Qualcomm PMIC device nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 950adb63af70..6514d728b1ec 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -292,13 +292,13 @@ scm {
 	 */
 	iio-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&xoadc 0x00 0x01>, /* Battery */
-			    <&xoadc 0x00 0x02>, /* DC in (charger) */
-			    <&xoadc 0x00 0x04>, /* VPH the main system voltage */
-			    <&xoadc 0x00 0x0b>, /* Die temperature */
-			    <&xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
-			    <&xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
-			    <&xoadc 0x00 0x0e>; /* Charger temperature */
+		io-channels = <&pm8921_xoadc 0x00 0x01>, /* Battery */
+			      <&pm8921_xoadc 0x00 0x02>, /* DC in (charger) */
+			      <&pm8921_xoadc 0x00 0x04>, /* VPH the main system voltage */
+			      <&pm8921_xoadc 0x00 0x0b>, /* Die temperature */
+			      <&pm8921_xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
+			      <&pm8921_xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
+			      <&pm8921_xoadc 0x00 0x0e>; /* Charger temperature */
 	};
 
 	soc: soc {
@@ -686,7 +686,7 @@ ssbi@500000 {
 			reg = <0x00500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
 
-			pmicintc: pmic {
+			pm8921: pmic {
 				compatible = "qcom,pm8921";
 				interrupt-parent = <&tlmm_pinmux>;
 				interrupts = <74 8>;
@@ -721,7 +721,7 @@ pm8921_mpps: mpps@50 {
 
 				rtc@11d {
 					compatible = "qcom,pm8921-rtc";
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8921>;
 					interrupts = <39 1>;
 					reg = <0x11d>;
 					allow-set-time;
@@ -730,16 +730,16 @@ rtc@11d {
 				pwrkey@1c {
 					compatible = "qcom,pm8921-pwrkey";
 					reg = <0x1c>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8921>;
 					interrupts = <50 1>, <51 1>;
 					debounce = <15625>;
 					pull-up;
 				};
 
-				xoadc: xoadc@197 {
+				pm8921_xoadc: xoadc@197 {
 					compatible = "qcom,pm8921-adc";
 					reg = <0x197>;
-					interrupts-extended = <&pmicintc 78 IRQ_TYPE_EDGE_RISING>;
+					interrupts-extended = <&pm8921 78 IRQ_TYPE_EDGE_RISING>;
 					#address-cells = <2>;
 					#size-cells = <0>;
 					#io-channel-cells = <2>;
-- 
2.39.2

