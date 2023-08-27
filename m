Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B09789A41
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjH0BAG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjH0A7g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD954CFA
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50043cf2e29so3183605e87.2
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097972; x=1693702772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TSiCQU8z8gMyHopnKHftqR+4tVxRcnW4JwBU1qA13I=;
        b=RTtnNCm/IXoNg0jA7QLdswbmeSxHDamrcA91Zib48AkN3M9r3IVY1Y6dw35DSrg3SM
         2e1IK0NCw6eGq8IOUBQhQDLiZLMs6GzJDi1orxZXFenYJmVbgT+gpAAR/hxoFJOcS61P
         Yj9BI67WyiSgLv3ZPZ3i3lV2Azu7lLXRL/KIN3BsPApMRFQAIq6jGvLJivJEI/dnsIQr
         muWdKZ3yyfKPymdq2mCPaZBI+tcYvt2kVBWS4o4+K7MPaR3dA2dRhpXPcuxnhOWBvP7d
         gndgnvWdFJZWYVTHVUsf1h91zMLuUOlkuO8vFcJhqe+qIFI/FV+zCgtFC3vzOdennfAY
         JHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097972; x=1693702772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TSiCQU8z8gMyHopnKHftqR+4tVxRcnW4JwBU1qA13I=;
        b=A75RDqiVhKYc5d5FpwRAXkRXyDWWL/B5vQNy7vdY6ZCbIt3Y6TOIt8V33uPyzy9s3J
         KpydAfrxmQM9dsMFoeotLYpE4qp3vXYVKmSpFk4JMUADdqPRNgWNjbrVwRx+FIhGF1dx
         3vT2Q7Sg87NZ1An6e58jumq6GI41R48aCB+f1TGZiOnuZl63YyPUbXAbCQtNN4w74q1l
         vwbSoQDuQgMGRatWnygn7qXDDpGM144IPcHmxWu/PLqN2PCifpHs83zBqI5e8Wy+8iCo
         ydSmxpOrboU54PGis1pSOBo4bEt9VXTnzKI7HLmvcC21QyVdiOKGpXtrK5d74chFc3wa
         DNVA==
X-Gm-Message-State: AOJu0Yzm1Qhq6yNVYQiVvEt67DfinXZkLcLM/jLjCzCXPo5y03o9oadX
        yBmdfgIwXRiD+JDUFyjE7wGYzQ==
X-Google-Smtp-Source: AGHT+IEA7HGVvFUJrB0jxldMZBkcU3XelpylEBi9iQGpKwgAqqHt8AiJewy++98mjHSZT9+0vkknQw==
X-Received: by 2002:a05:6512:3246:b0:500:b5db:990b with SMTP id c6-20020a056512324600b00500b5db990bmr278150lfr.47.1693097972041;
        Sat, 26 Aug 2023 17:59:32 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:31 -0700 (PDT)
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
Subject: [PATCH v4 11/38] ARM: dts: qcom: mdm9615: fix PMIC node labels
Date:   Sun, 27 Aug 2023 03:58:53 +0300
Message-Id: <20230827005920.898719-12-dmitry.baryshkov@linaro.org>
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

Change PM8018 node labels to start with pm8018_ prefix, following other
Qualcomm PMIC device nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi |  2 +-
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi        | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
index 92c8003dac25..dac3aa793f71 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
@@ -76,7 +76,7 @@ reset-out-pins {
 	};
 };
 
-&pmicgpio {
+&pm8018_gpio {
 	usb_vbus_5v_pins: usb-vbus-5v-state {
 		pins = "gpio4";
 		function = "normal";
diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
index fc4f52f9e9f7..c4cfbdbcdf14 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
@@ -263,7 +263,7 @@ qcom,ssbi@500000 {
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
 
-			pmicintc: pmic {
+			pm8018: pmic {
 				compatible = "qcom,pm8018", "qcom,pm8921";
 				interrupts = <GIC_PPI 226 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
@@ -274,38 +274,38 @@ pmicintc: pmic {
 				pwrkey@1c {
 					compatible = "qcom,pm8018-pwrkey", "qcom,pm8921-pwrkey";
 					reg = <0x1c>;
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8018>;
 					interrupts = <50 IRQ_TYPE_EDGE_RISING>,
 						     <51 IRQ_TYPE_EDGE_RISING>;
 					debounce = <15625>;
 					pull-up;
 				};
 
-				pmicmpp: mpps@50 {
+				pm8018_mpps: mpps@50 {
 					compatible = "qcom,pm8018-mpp", "qcom,ssbi-mpp";
 					interrupt-controller;
 					#interrupt-cells = <2>;
 					reg = <0x50>;
 					gpio-controller;
 					#gpio-cells = <2>;
-					gpio-ranges = <&pmicmpp 0 0 6>;
+					gpio-ranges = <&pm8018_mpps 0 0 6>;
 				};
 
 				rtc@11d {
 					compatible = "qcom,pm8018-rtc", "qcom,pm8921-rtc";
-					interrupt-parent = <&pmicintc>;
+					interrupt-parent = <&pm8018>;
 					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
 					reg = <0x11d>;
 					allow-set-time;
 				};
 
-				pmicgpio: gpio@150 {
+				pm8018_gpio: gpio@150 {
 					compatible = "qcom,pm8018-gpio", "qcom,ssbi-gpio";
 					reg = <0x150>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
 					gpio-controller;
-					gpio-ranges = <&pmicgpio 0 0 6>;
+					gpio-ranges = <&pm8018_gpio 0 0 6>;
 					#gpio-cells = <2>;
 				};
 			};
-- 
2.39.2

