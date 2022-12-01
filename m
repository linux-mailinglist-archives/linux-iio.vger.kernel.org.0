Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE263F8FB
	for <lists+linux-iio@lfdr.de>; Thu,  1 Dec 2022 21:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiLAUVy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Dec 2022 15:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiLAUVu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2022 15:21:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0ABFCD4
        for <linux-iio@vger.kernel.org>; Thu,  1 Dec 2022 12:21:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f21so3381884lfm.9
        for <linux-iio@vger.kernel.org>; Thu, 01 Dec 2022 12:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF6o3uPyABz/JCGS6mnoQHfG46FmIuXFpnlO4Zq7ZHg=;
        b=f+fcwi4CQzJW8ZkO4WEjn5M6xr060pyBYRag6KT0553j4iRKyzxDf+vDKr9jLvyGWM
         EbZ/fD4CeEwjTmGYWAsiCrKhHm/d7ugchP3M5ptCcFWuvNub3fSzLOsfWv0RqJjnqbO3
         bwUzjpqfpqM0CTFsOfTYcaNFz79VDt3x5Aodgf08XyEliE9h9gVfPdrMWzRsFjr2gUQZ
         5ZoZrZU7KembWHy5YRGnj1pmzZj4VVtFngg6NrYd/kl+F5dEikfLKFmLsWaPUbtlNEPb
         OrW6Y809soPTgHf5yuvxk4pz1PL+5BwTfC1IHsDgQqk/LxIUW+XZZNWQNldWa6tjxsnu
         io8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF6o3uPyABz/JCGS6mnoQHfG46FmIuXFpnlO4Zq7ZHg=;
        b=plCJHm3aS5CtgMB+PiGKKueOGs1r6nRQ6LnAKi269AR/5iDZtuAezwPZbDuIsKuIht
         octSEHvwYu+ne5vbWO3B6yzmIUrGSK/Y8N00dohjym6uCgAzlV+5T7HwsTC8Ae3Hb6KD
         nFoaGPcD0Li2XGHpEY0E6D+RyfeYLm+jGZNZhpSptYNheAJ7GczJgmbUDc2jqd2C48cX
         nEt5Cj/qCylDDtUGA6H6uKwTBa90txwQI4GTmFHEQPG230uIxg38wnlDkc+kWUrHhX5q
         UY13WwjYr2FPfgEOeCb+QnYU/WjTSqZsYKqhRSx6S1S5/iND/QQF2OW6r7rZe/wQrX0J
         +sxA==
X-Gm-Message-State: ANoB5plJ1Wuz8mMYujlSnhG9NmhuOF0UF6zIEH3PQLPf9X5ahVsblUcm
        52H4se/lo3DrrN+1zfQj1Alw4w==
X-Google-Smtp-Source: AA0mqf5kUlQyWDWL6WaRuqUuiBGnYZgINSU+I31mAkOyo4uzdi8VNv4sdz5kTjTvEE5BC9Bi1HbfzA==
X-Received: by 2002:ac2:58ca:0:b0:4b4:eed:ec3e with SMTP id u10-20020ac258ca000000b004b40eedec3emr22276212lfo.446.1669926107482;
        Thu, 01 Dec 2022 12:21:47 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l30-20020a19495e000000b004b514b27c86sm769679lfj.13.2022.12.01.12.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 12:21:47 -0800 (PST)
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
Subject: [PATCH 2/5] dt-bindings: leds: pm8058: convert from txt to YAML format
Date:   Thu,  1 Dec 2022 22:21:41 +0200
Message-Id: <20221201202144.448694-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221201202144.448694-1-dmitry.baryshkov@linaro.org>
References: <20221201202144.448694-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the bindings for the leds subdevice of Qualcomm PM8058 PMIC
from text to YAML format.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/leds/leds-pm8058.txt  | 67 ---------------
 .../devicetree/bindings/leds/leds-pm8058.yaml | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pm8058.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pm8058.txt b/Documentation/devicetree/bindings/leds/leds-pm8058.txt
deleted file mode 100644
index 89584c49aab2..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-pm8058.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Qualcomm PM8058 LED driver
-
-The Qualcomm PM8058 is a multi-functional device which contains
-an LED driver block for up to six LEDs: three normal LEDs, two
-"flash" LEDs and one "keypad backlight" LED. The names are
-quoted because sometimes these LED drivers are used for wildly
-different things than flash or keypad backlight: their names
-are more of a suggestion than a hard-wired usecase.
-
-Hardware-wise the different LEDs support slightly different
-output currents. The "flash" LEDs do not need to charge nor
-do they support external triggers. They are just powerful LED
-drivers.
-
-The LEDs appear as children to the PM8058 device, with the
-proper compatible string. For the PM8058 bindings see:
-mfd/qcom-pm8xxx.txt.
-
-Each LED is represented as a sub-node of the syscon device. Each
-node's name represents the name of the corresponding LED.
-
-LED sub-node properties:
-
-Required properties:
-- compatible: one of
-  "qcom,pm8058-led" (for the normal LEDs at 0x131, 0x132 and 0x133)
-  "qcom,pm8058-keypad-led" (for the "keypad" LED at 0x48)
-  "qcom,pm8058-flash-led" (for the "flash" LEDs at 0x49 and 0xFB)
-
-Optional properties:
-- label: see Documentation/devicetree/bindings/leds/common.txt
-- default-state: see Documentation/devicetree/bindings/leds/common.txt
-- linux,default-trigger: see Documentation/devicetree/bindings/leds/common.txt
-
-Example:
-
-qcom,ssbi@500000 {
-	pmicintc: pmic@0 {
-		compatible = "qcom,pm8058";
-		led@48 {
-			compatible = "qcom,pm8058-keypad-led";
-			reg = <0x48>;
-			label = "pm8050:white:keypad";
-			default-state = "off";
-		};
-		led@131 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x131>;
-			label = "pm8058:red";
-			default-state = "off";
-		};
-		led@132 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x132>;
-			label = "pm8058:yellow";
-			default-state = "off";
-			linux,default-trigger = "mmc0";
-		};
-		led@133 {
-			compatible = "qcom,pm8058-led";
-			reg = <0x133>;
-			label = "pm8058:green";
-			default-state = "on";
-			linux,default-trigger = "heartbeat";
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/leds-pm8058.yaml b/Documentation/devicetree/bindings/leds/leds-pm8058.yaml
new file mode 100644
index 000000000000..a73bffb36808
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-pm8058.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-pm8058.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8058 LED driver
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
+
+description: |
+  The Qualcomm PM8058 is a multi-functional device which contains
+  an LED driver block for up to six LEDs: three normal LEDs, two
+  "flash" LEDs and one "keypad backlight" LED. The names are
+  quoted because sometimes these LED drivers are used for wildly
+  different things than flash or keypad backlight: their names
+  are more of a suggestion than a hard-wired usecase.
+
+  Hardware-wise the different LEDs support slightly different
+  output currents. The "flash" LEDs do not need to charge nor
+  do they support external triggers. They are just powerful LED
+  drivers.
+
+  The LEDs appear as children to the PM8058 device, with the
+  proper compatible string. For the PM8058 bindings see:
+  mfd/qcom-pm8xxx.txt.
+
+  Each LED is represented as a sub-node of the syscon device. Each
+  node's name represents the name of the corresponding LED.
+
+$ref: common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8058-led
+      - qcom,pm8058-keypad-led
+      - qcom,pm8058-flash-led
+
+  reg:
+    description: resource address
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led@48 {
+            compatible = "qcom,pm8058-keypad-led";
+            reg = <0x48>;
+            label = "pm8050:white:keypad";
+            default-state = "off";
+        };
+        led@131 {
+            compatible = "qcom,pm8058-led";
+            reg = <0x131>;
+            label = "pm8058:red";
+            default-state = "off";
+        };
+        led@132 {
+            compatible = "qcom,pm8058-led";
+            reg = <0x132>;
+            label = "pm8058:yellow";
+            default-state = "off";
+            linux,default-trigger = "mmc0";
+        };
+        led@133 {
+            compatible = "qcom,pm8058-led";
+            reg = <0x133>;
+            label = "pm8058:green";
+            default-state = "on";
+            linux,default-trigger = "heartbeat";
+        };
+    };
+...
-- 
2.35.1

