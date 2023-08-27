Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99405789A55
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjH0BAJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjH0A7n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDFF7
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50079d148aeso3189931e87.3
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097979; x=1693702779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k8syU2Srvebbo9uffVrELQey0TuexhEArMkFZwpoCw=;
        b=UelkDbY9mmwDDWExbt8RZEAzlcBOd+t6oC2qpYweMP0FHfWNDJ70RegeCv2E/tieEz
         xxZEs+k77PXb1R2somEPsilT5HpvXr7gTsF6gm9zbBgINM5/s9KFTp+t72WgujYYghZ3
         PI/TrjCGgL7ER99LNH0Piihe9nn7rDlaopKggp1GY3lmPjV4p7QMsxUPaoXF9rzqEeR4
         N1oSZKnkAyTdz8Lsf7pOIHPHUJlrdQm05EG4kK78TjUXfoW78ecFBmNI8ISSojWMzhEH
         tPSH6LACZUK3rrGDpu1efucwtpaQ2Py63z1vpYiz1Lf8zrbwFkSojB8zAS74mj4+iCz5
         7/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097979; x=1693702779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2k8syU2Srvebbo9uffVrELQey0TuexhEArMkFZwpoCw=;
        b=VrumEe1l3ouKMHfNpdRPWv7c1dN20eZyxFJyWPYwBHJsboKL5JnXxBNWFCWBU5bGrs
         Dba7e2lwf0Rs3qwBbjVy0WZ2cYm7t9onaidZTC089ogsn1/CzQBSZuS5xI0ZGywlBbRl
         vQO+XV7gqnR7oFMVxIrVN1c7YMoAJSdtu+peYflNZbxf84eHQXLq0sMmPIpGgItgeiJ5
         NgKbTp8yj3g3xq7Qqy04LbETTTKJqq+qDs8UQExvYFiymgT0UtausxP/fKXhziGbKUAM
         nU2fGzI6NSUfQqG4VT+FoNT5ZY57TyhdGS+F8ZYTbvp8fk3H7dEurMBLWdubPkywuXas
         fJKw==
X-Gm-Message-State: AOJu0YyJkq8BB3Y3lghY0r9J7I5sWV99pln2TKP6VjjHJN//wAVCxbo5
        lXtorIc9UmS15g908/7MLuOd3g==
X-Google-Smtp-Source: AGHT+IE7pqwC2OhylGwqhqjrWU1lhu8X2Rfn9q98cEQSx2d8WDMBD/9m56LPgRiBjGtpzLTwm5RfrQ==
X-Received: by 2002:a05:6512:202c:b0:4f8:7772:3dfd with SMTP id s12-20020a056512202c00b004f877723dfdmr12987540lfs.11.1693097979263;
        Sat, 26 Aug 2023 17:59:39 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:38 -0700 (PDT)
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
Subject: [PATCH v4 18/38] ARM: dts: qcom: msm8960: split PMIC to separate dtsi files
Date:   Sun, 27 Aug 2023 03:59:00 +0300
Message-Id: <20230827005920.898719-19-dmitry.baryshkov@linaro.org>
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

The PMIC is not a part of the SoC, so move PMIC to a separate file and
include it from the board files.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/pm8921.dtsi            | 40 +++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts   |  1 +
 .../qcom/qcom-msm8960-samsung-expressatt.dts  |  3 +-
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      | 39 +-----------------
 4 files changed, 44 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom/pm8921.dtsi

diff --git a/arch/arm/boot/dts/qcom/pm8921.dtsi b/arch/arm/boot/dts/qcom/pm8921.dtsi
new file mode 100644
index 000000000000..414941f7a42f
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/pm8921.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+&ssbi {
+	pm8921: pmic {
+		compatible = "qcom,pm8921";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pwrkey@1c {
+			compatible = "qcom,pm8921-pwrkey";
+			reg = <0x1c>;
+			interrupt-parent = <&pm8921>;
+			interrupts = <50 IRQ_TYPE_EDGE_RISING>,
+				     <51 IRQ_TYPE_EDGE_RISING>;
+			debounce = <15625>;
+			pull-up;
+		};
+
+		pm8921_keypad: keypad@148 {
+			compatible = "qcom,pm8921-keypad";
+			reg = <0x148>;
+			interrupt-parent = <&pm8921>;
+			interrupts = <74 IRQ_TYPE_EDGE_RISING>,
+				     <75 IRQ_TYPE_EDGE_RISING>;
+			debounce = <15>;
+			scan-delay = <32>;
+			row-hold = <91500>;
+		};
+
+		rtc@11d {
+			compatible = "qcom,pm8921-rtc";
+			interrupt-parent = <&pm8921>;
+			interrupts = <39 IRQ_TYPE_EDGE_RISING>;
+			reg = <0x11d>;
+			allow-set-time;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
index 43149c90c4fc..a5ea4843db43 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts
@@ -2,6 +2,7 @@
 #include <dt-bindings/input/input.h>
 
 #include "qcom-msm8960.dtsi"
+#include "pm8921.dtsi"
 
 / {
 	model = "Qualcomm MSM8960 CDP";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
index 9e203164beb6..1a5116336ff0 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/reset/qcom,gcc-msm8960.h>
 
 #include "qcom-msm8960.dtsi"
-#include <dt-bindings/reset/qcom,gcc-msm8960.h>
+#include "pm8921.dtsi"
 
 / {
 	model = "Samsung Galaxy Express SGH-I437";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index f1267c83d67a..774f507fa25a 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -259,47 +259,10 @@ gsbi5_serial: serial@16440000 {
 			};
 		};
 
-		ssbi@500000 {
+		ssbi: ssbi@500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
-
-			pm8921: pmic {
-				compatible = "qcom,pm8921";
-				#interrupt-cells = <2>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				pwrkey@1c {
-					compatible = "qcom,pm8921-pwrkey";
-					reg = <0x1c>;
-					interrupt-parent = <&pm8921>;
-					interrupts = <50 IRQ_TYPE_EDGE_RISING>,
-						     <51 IRQ_TYPE_EDGE_RISING>;
-					debounce = <15625>;
-					pull-up;
-				};
-
-				pm8921_keypad: keypad@148 {
-					compatible = "qcom,pm8921-keypad";
-					reg = <0x148>;
-					interrupt-parent = <&pm8921>;
-					interrupts = <74 IRQ_TYPE_EDGE_RISING>,
-						     <75 IRQ_TYPE_EDGE_RISING>;
-					debounce = <15>;
-					scan-delay = <32>;
-					row-hold = <91500>;
-				};
-
-				rtc@11d {
-					compatible = "qcom,pm8921-rtc";
-					interrupt-parent = <&pm8921>;
-					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
-					reg = <0x11d>;
-					allow-set-time;
-				};
-			};
 		};
 
 		rng@1a500000 {
-- 
2.39.2

