Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46F789A15
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjH0BAE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjH0A7b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D8CD2
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso2879269e87.0
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097967; x=1693702767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii+ERiIP/+rN5/93TQF2YXZBm9/0F6AmtInKGYg6uG8=;
        b=YnXj2JRWVD800aA1O+VYnKAQZZuAou+xn/tMJ0KB6b2/poATOIgVz3pUSgZgBz4a08
         7s69jDOdY+UeUF+oL1iJ+vkeKp7dXBSZ2XjkX53Aqaa0xWdJxQYLav5v//hC/z20iY5l
         42cYyRAOW9IjZbBv1g6a7fGotfoYjI4rqVvehgAq+bYVvFlOIwjyKhwdcZNBFjQJ63T5
         DeseIUiPM8Y0a25fXKsJkNJBW80+7e4T8/wCb1Ya4ghNVa/tcy/PC/DbALV0ZpTco8/y
         x3Xs/fZrnVnUOG3B5AiEOtoBE1YliQxpYAh2LUOTo2nsTaXhIjIBX9LkyKguEbTTCLOp
         0B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097967; x=1693702767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii+ERiIP/+rN5/93TQF2YXZBm9/0F6AmtInKGYg6uG8=;
        b=cVQ9RY/J/JVOCdhC98Qndt8RBB8hzRtp5237RVMBglpIDnXOAWNYxJOUyxaaYNfgtD
         Ur8SFsP6ry0a/df/634pCb0qjH0cLhYPirwlKwvZ0+SPXr9L3aH8tSwTF8k/tiH4xZbv
         19mQaudFn+Y7o/Gmx6BxI++pS4YMGrH98JsHrUQL9vaZGi78RnXfus7hTVE5iAcytjR7
         kzGKKRknNNSXb+0fu9CiRsFMAB2BQXUqR2jbxaffAuoYPEOa0guoCJjoG9OIpkTMVwuW
         6mwhn0j4V5LMJA06NkYPSRc8BLYxhXgEJ+2bS89+e7vPrHtmxO9vdJ6Sj31qkfo/Eot7
         AkEA==
X-Gm-Message-State: AOJu0YzWQWpnmdI0EJUdf3XVq/k5nNGeqXkp4eJfDTKKVLabVzFS/jMS
        WAulLkLD8O9DhEbFAah9cff4cA==
X-Google-Smtp-Source: AGHT+IHDesWF4oTCc1w0eMaN+QlzAxy6hFCSMlS0N0H4u700hiB1Qj7WOBjPZWE0I0np6J56JxP9IQ==
X-Received: by 2002:a05:6512:10d5:b0:4fe:7df0:41ab with SMTP id k21-20020a05651210d500b004fe7df041abmr17354055lfg.17.1693097967155;
        Sat, 26 Aug 2023 17:59:27 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:26 -0700 (PDT)
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
Subject: [PATCH v4 05/38] ARM: dts: qcom: msm8960: introduce label for PMIC keypad
Date:   Sun, 27 Aug 2023 03:58:47 +0300
Message-Id: <20230827005920.898719-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

To simplify MSM8960 CDP board file, add label to PMIC keypad node.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts | 20 +++++++++-----------
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi    |  2 +-
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
index 6c1bc3818883..4641b4f2195d 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
@@ -88,17 +88,15 @@ clk-pins {
 	};
 };
 
-&pmicintc {
-	keypad@148 {
-		linux,keymap = <
-			MATRIX_KEY(0, 0, KEY_VOLUMEUP)
-			MATRIX_KEY(0, 1, KEY_VOLUMEDOWN)
-			MATRIX_KEY(0, 2, KEY_CAMERA_FOCUS)
-			MATRIX_KEY(0, 3, KEY_CAMERA)
-			>;
-		keypad,num-rows = <1>;
-		keypad,num-columns = <5>;
-	};
+&pm8921_keypad {
+	linux,keymap = <
+		MATRIX_KEY(0, 0, KEY_VOLUMEUP)
+		MATRIX_KEY(0, 1, KEY_VOLUMEDOWN)
+		MATRIX_KEY(0, 2, KEY_CAMERA_FOCUS)
+		MATRIX_KEY(0, 3, KEY_CAMERA)
+		>;
+	keypad,num-rows = <1>;
+	keypad,num-columns = <5>;
 };
 
 &rpm {
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index d13080fcbeea..a34fda93d6a4 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -283,7 +283,7 @@ pwrkey@1c {
 					pull-up;
 				};
 
-				keypad@148 {
+				pm8921_keypad: keypad@148 {
 					compatible = "qcom,pm8921-keypad";
 					reg = <0x148>;
 					interrupt-parent = <&pmicintc>;
-- 
2.39.2

