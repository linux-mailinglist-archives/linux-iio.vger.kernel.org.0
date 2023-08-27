Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08E789A60
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjH0BAK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjH0A7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:48 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B1BCD5
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5007abb15e9so3227252e87.0
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097984; x=1693702784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBqdCLgmI8uo0vU5eXIGi0ZDA2gUAaQ0wjWhyRHtIN4=;
        b=lM6RHeILYnF6pidE43A138Xe5kZBCZDtTCDrHg0mxN1KQ8rTC2TFiADxFPFsNREiBq
         hijm7Ic0s9bcQlzBTB0m+Zf+75s7mSPrEyd9w27Gei3cK6eH+IoDKk5VUSVasfVt/gbf
         kFpF6lbtl9IfaTilzRR8uIM1HUAbbuZyfMQbZqqpDLPLkmROKdgCVup0OeqM/7PPvfkL
         PUMqleyqrh9mofRArIzAHqkjhPkz2X1y/5WHsITREXpWKcmHREQynKh0DAS0SC4HnxH+
         48gcDE2j6ECGib5yejCqu+gY2UBCSD5XIx3DOODaGc7fJZ7kh+4DrHiNLnN4Tgcp0elZ
         7Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097984; x=1693702784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBqdCLgmI8uo0vU5eXIGi0ZDA2gUAaQ0wjWhyRHtIN4=;
        b=ON7/2vdiUR+cn+sHLYsuQD8wdoxAoBkjJWkrv3IrHk5jJcuDhdI/6F7P7zy36ng9gc
         vXnQWLG22q6QoBy2vYOIg2JJVf7vD0TsT1ZcwjeSYCXDY9L2mtHwg2zU3nbfo7aKWvNs
         Gb/lwA02XphKWWx27bM8aBDsA7CZ6qoqFBIhxvpIzI7P9gSBLQIvcoQOxHi5Siyp4GVk
         wLRfptLKSK4Dj0JK/VEDqJjxB+c1rYuWgFTDYT6RxqwlzGTlsaDnZdG37uo4ZxndqFhJ
         fffNLQv6xDfXxONV9cfnoaFDGd7nAkiAaK+Ht65gAEW2HZC1/UjlNU4ghjDf+WXynn2O
         z05A==
X-Gm-Message-State: AOJu0YxBl5/Z1vqF45mliKy+7mMOVCbHXvyzcRw7QxJUOhWzDZunFcdn
        /XNiCBIM6VdoO+uenxhklZ/uaw==
X-Google-Smtp-Source: AGHT+IHsvxq04wRlSo5sHZ5kIlMd62ow4DQzecvtkmLw20RSF9UVyglOHaMXNnQ718FIMCGfCD5eQA==
X-Received: by 2002:ac2:5f4b:0:b0:500:9ee2:15f with SMTP id 11-20020ac25f4b000000b005009ee2015fmr4590419lfz.46.1693097984172;
        Sat, 26 Aug 2023 17:59:44 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:43 -0700 (PDT)
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
Subject: [PATCH v4 22/38] ARM: dts: qcom: pm8058: reorder nodes
Date:   Sun, 27 Aug 2023 03:59:04 +0300
Message-Id: <20230827005920.898719-23-dmitry.baryshkov@linaro.org>
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

