Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D91789E6F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjH0N01 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjH0NZu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445411BB
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff09632194so3767475e87.2
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142742; x=1693747542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDHR/qTLZAAlEyQL6qHwxIGFzk6+uGKbaVZYZcIFL9s=;
        b=St20vM2iK1YgWwlvlDXk+Lk0CR4j13FIX+jhA64dAGzX7x0X2ZmV3eR4xclDqsrNS7
         MaNEisAVDI6eP0mJeuFXEZ1NiR2SArVMPq+cozGggAB6PLsMvPKYGi6D91pr7Ezkpaub
         dxTi51xJIq3CRbYWghD7wIg4MKFH8FdMrrTdr/eBi6xSZgCUl48O1ro+2/dvZj8bo8bi
         yZzHGvWyEim3d0dF8gb+dlphzZG2dmwlo/6YDWOVnsrRmMmDf0+z/c4BHtQVVFsEFwUr
         3krfcWXo/QU+af4hEhT/4QZssPiRnCJ/eyLDl4lZikP43aCM9ZJZt0/SXvKM7NOlA7XH
         oV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142742; x=1693747542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDHR/qTLZAAlEyQL6qHwxIGFzk6+uGKbaVZYZcIFL9s=;
        b=bj543VYpIUCJ4nJgRIYcEWIATOt6GzY1mJt5rOcxoWk08t34uHeilZosVry+M0c+zq
         HQbw+pvsPTIlaWbSGmzmEcRw/VCh1Y9GeXwIAdAfs8pBkxKIPK8z+Er3YMUcdFAeW5nP
         ZugYZ+oq82E0Wqh1UFsFChbkXcI+x+Dwkflsl1oWLfQdFXyx13iFrY1Vyu2Ddr4r3NIy
         hVrYoHOChau5VR29GfaJJ6X7rx2kVZ5iy69v119G9po2ArUkqyj1nH4xHDNzPCM0q0fk
         Gsb3FVKPEhPFXDVrbFo6t9kqx6VBR+6Ph6pCJRw+kmVPVtNfcdF8fO4u86QXzAECPk09
         FqDA==
X-Gm-Message-State: AOJu0YxBfMg8D5gDgIUSssVHXo2jx3tDVdy65Wojx37Go/qTH9HsMvwJ
        No5wus1m9i3kZPyWMNYDllVmwA==
X-Google-Smtp-Source: AGHT+IElZOMBTleDmJrI9pKCss+OIb7I5ELYkoq0otj3rpQAMJRhKK0rJwgCiPdYTsVGf6yjy84KPw==
X-Received: by 2002:a05:6512:10d1:b0:4fb:92df:a27c with SMTP id k17-20020a05651210d100b004fb92dfa27cmr18715418lfg.25.1693142742544;
        Sun, 27 Aug 2023 06:25:42 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:41 -0700 (PDT)
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
        linux-leds@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 19/37] ARM: dts: qcom: mdm9615: split PMIC to separate dtsi files
Date:   Sun, 27 Aug 2023 16:25:07 +0300
Message-Id: <20230827132525.951475-20-dmitry.baryshkov@linaro.org>
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

The PMIC is not a part of the SoC, so move PMIC to a separate file and
include it from the board files.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/pm8018.dtsi            | 57 +++++++++++++++++++
 .../boot/dts/qcom/qcom-mdm9615-wp8548.dtsi    |  1 +
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi      | 48 +---------------
 3 files changed, 59 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom/pm8018.dtsi

diff --git a/arch/arm/boot/dts/qcom/pm8018.dtsi b/arch/arm/boot/dts/qcom/pm8018.dtsi
new file mode 100644
index 000000000000..c602544900b2
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/pm8018.dtsi
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Device Tree Source for Qualcomm PM8018
+ *
+ * Copyright (C) 2016 BayLibre, SAS.
+ * Author : Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+&ssbi {
+	pm8018: pmic {
+		compatible = "qcom,pm8018", "qcom,pm8921";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pwrkey@1c {
+			compatible = "qcom,pm8018-pwrkey",
+				     "qcom,pm8921-pwrkey";
+			reg = <0x1c>;
+			interrupt-parent = <&pm8018>;
+			interrupts = <50 IRQ_TYPE_EDGE_RISING>,
+				     <51 IRQ_TYPE_EDGE_RISING>;
+			debounce = <15625>;
+			pull-up;
+		};
+
+		pm8018_mpps: mpps@50 {
+			compatible = "qcom,pm8018-mpp", "qcom,ssbi-mpp";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x50>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8018_mpps 0 0 6>;
+		};
+
+		rtc@11d {
+			compatible = "qcom,pm8018-rtc", "qcom,pm8921-rtc";
+			interrupt-parent = <&pm8018>;
+			interrupts = <39 IRQ_TYPE_EDGE_RISING>;
+			reg = <0x11d>;
+			allow-set-time;
+		};
+
+		pm8018_gpio: gpio@150 {
+			compatible = "qcom,pm8058-gpio",
+				     "qcom,ssbi-gpio";
+			reg = <0x150>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pm8018_gpio 0 0 6>;
+			#gpio-cells = <2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
index b782ff0d16cd..27c3d92d9452 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include "qcom-mdm9615.dtsi"
+#include "pm8018.dtsi"
 
 / {
 	model = "Sierra Wireless WP8548 Module";
diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
index 373d9425b8bd..e23ca6c42683 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
@@ -258,56 +258,10 @@ gsbi5_serial: serial@16440000 {
 			};
 		};
 
-		qcom,ssbi@500000 {
+		ssbi: qcom,ssbi@500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
-
-			pm8018: pmic {
-				compatible = "qcom,pm8018", "qcom,pm8921";
-				#interrupt-cells = <2>;
-				interrupt-controller;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				pwrkey@1c {
-					compatible = "qcom,pm8018-pwrkey", "qcom,pm8921-pwrkey";
-					reg = <0x1c>;
-					interrupt-parent = <&pm8018>;
-					interrupts = <50 IRQ_TYPE_EDGE_RISING>,
-						     <51 IRQ_TYPE_EDGE_RISING>;
-					debounce = <15625>;
-					pull-up;
-				};
-
-				pm8018_mpps: mpps@50 {
-					compatible = "qcom,pm8018-mpp", "qcom,ssbi-mpp";
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					reg = <0x50>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&pm8018_mpps 0 0 6>;
-				};
-
-				rtc@11d {
-					compatible = "qcom,pm8018-rtc", "qcom,pm8921-rtc";
-					interrupt-parent = <&pm8018>;
-					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
-					reg = <0x11d>;
-					allow-set-time;
-				};
-
-				pm8018_gpio: gpio@150 {
-					compatible = "qcom,pm8018-gpio", "qcom,ssbi-gpio";
-					reg = <0x150>;
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					gpio-controller;
-					gpio-ranges = <&pm8018_gpio 0 0 6>;
-					#gpio-cells = <2>;
-				};
-			};
 		};
 
 		sdcc1bam: dma-controller@12182000 {
-- 
2.39.2

