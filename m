Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3738789A91
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjH0BAj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjH0BAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 21:00:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF1BF7
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso3217929e87.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097999; x=1693702799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mq8gLiHCENn619WtS9zSkZ5VudJvKeJvyGd1i9pvkE=;
        b=AThUsTpyu+iMd1QAK6XADOKNl1C7CM5spoxpO5Nu9e5sESE6/svZuWQt/jfvPZERPz
         1meXsHXTww975mQqa9Y2kFMGcKM3cxRq8VCWd7oiymeR5DW/11jzgVyDzQhbazZtyZD8
         gUPoJG0J76yqL2YhLGF853Y4iGVjrFd2SQTVhGRaShCqDfQmlU56nBXq03SePdhrBULc
         cNTRgsQAUBPzLk0v38FWB75MLqG98ZO9XnHsRojY8RIv2jVOQRsICGL9otzZQG9d7hP7
         tebp7DOeutmMjqeaqIxZcn6pjTAO6y/9YKt+1tkLNxPZcsBf12j+zTWr/D/1IE3OQmsM
         hGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097999; x=1693702799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mq8gLiHCENn619WtS9zSkZ5VudJvKeJvyGd1i9pvkE=;
        b=DEmNoJm7Yh1LTW55IHEzbMTCKTPFp7E8WNNgUMk8G9vWtoJ6o6lrI6v0x//ccIwxG+
         t/K70OYbmFtKx1HpvXhgfxxQh7agZiVvyAr8cwfOddwXc/6XdmM00UJjr6R0yVmOs6gi
         TBPBBb/v8gPKZvaQPPnpggMVf6Z6bJ8TpQG2YUZt5T7mkLfjfLCX3AvIFD60KdvCjENa
         CVjxuAhB3uBsrFYn8R9KzwJjimY3xUCnZeT/+S4KBKYx1NQI7TkrvUc6REo9lrUMwpUl
         nmSwgxMFmz0OTCfwr+8Q8gB3aXb3AI0wpig61QxQGu7bmC4/RwrerXrr3vjtfWXt8BKh
         i/rQ==
X-Gm-Message-State: AOJu0YzoCsF8+iSXBTCqaQwq6SkSwOZ8Y3Wrlz7kxikkRE4fqo2G6qfd
        w3cVN7sKMpH50/7OlLEYZJ+X5A==
X-Google-Smtp-Source: AGHT+IH6O+dBD/100iov8wxDdgonmaGJ9RZR6vi4V8pz+9MqWTqmbXinZnhOSci59ozP4ZG6oGRKug==
X-Received: by 2002:ac2:4bc6:0:b0:4fe:7e7f:1333 with SMTP id o6-20020ac24bc6000000b004fe7e7f1333mr17666827lfq.6.1693097999516;
        Sat, 26 Aug 2023 17:59:59 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:57 -0700 (PDT)
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
Subject: [PATCH v4 30/38] ARM: dts: qcom: apq8064: move RPM regulators to board files
Date:   Sun, 27 Aug 2023 03:59:12 +0300
Message-Id: <20230827005920.898719-31-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
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

The set of regulators available over the RPM requests is not a property
of the SoC. Move them to board files.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../dts/qcom/qcom-apq8064-asus-nexus7-flo.dts | 42 ++++----
 .../boot/dts/qcom/qcom-apq8064-cm-qs600.dts   | 22 ++---
 .../boot/dts/qcom/qcom-apq8064-ifc6410.dts    | 29 +++---
 .../qcom-apq8064-sony-xperia-lagan-yuga.dts   | 98 +++++++++++--------
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      | 63 ------------
 5 files changed, 108 insertions(+), 146 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
index d709d6e840ec..329c2546aa0a 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-asus-nexus7-flo.dts
@@ -199,11 +199,12 @@ &pm8921 {
 
 &rpm {
 	regulators {
+		compatible = "qcom,rpm-pm8921-regulators";
+
 		vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
 		vin_lvs1_3_6-supply = <&pm8921_s4>;
 		vin_lvs4_5_7-supply = <&pm8921_s4>;
 
-
 		vdd_l24-supply = <&pm8921_s1>;
 		vdd_l25-supply = <&pm8921_s1>;
 		vin_lvs2-supply = <&pm8921_s1>;
@@ -215,7 +216,7 @@ regulators {
 		vdd_ncp-supply = <&pm8921_l6>;
 
 		/* Buck SMPS */
-		s1 {
+		pm8921_s1: s1 {
 			regulator-always-on;
 			regulator-min-microvolt = <1225000>;
 			regulator-max-microvolt = <1225000>;
@@ -224,7 +225,7 @@ s1 {
 		};
 
 		/* msm otg HSUSB_VDDCX */
-		s3 {
+		pm8921_s3: s3 {
 			regulator-min-microvolt = <500000>;
 			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
@@ -237,55 +238,58 @@ s3 {
 		 * tabla2x-slim-CDC_VDD_CP
 		 * tabla2x-slim-VDDIO_CDC
 		 */
-		s4 {
+		pm8921_s4: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			qcom,switch-mode-frequency = <3200000>;
 			regulator-always-on;
 		};
 
-		s7 {
+		pm8921_s7: s7 {
 			regulator-min-microvolt = <1300000>;
 			regulator-max-microvolt = <1300000>;
 			qcom,switch-mode-frequency = <3200000>;
 		};
 
 		/* mipi_dsi.1-dsi1_pll_vdda */
-		l2 {
+		pm8921_l2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-always-on;
 		};
 
 		/* msm_otg-HSUSB_3p3 */
-		l3 {
+		pm8921_l3: l3 {
 			regulator-min-microvolt = <3075000>;
 			regulator-max-microvolt = <3075000>;
 			bias-pull-down;
 		};
 
 		/* msm_otg-HSUSB_1p8 */
-		l4 {
+		pm8921_l4: l4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			bias-pull-down;
 		};
 
 		/* msm_sdcc.1-sdc_vdd */
-		l5 {
+		pm8921_l5: l5 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
 			regulator-always-on;
 			bias-pull-down;
 		};
 
-		l6 {
+		pm8921_l6: l6 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
 		};
 
+		pm8921_l8: l8 {
+		};
+
 		/* mipi_dsi.1-dsi1_avdd */
-		l11 {
+		pm8921_l11: l11 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3000000>;
 			bias-pull-down;
@@ -293,14 +297,14 @@ l11 {
 		};
 
 		/* pwm_power for backlight */
-		l17 {
+		pm8921_l17: l17 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3000000>;
 			regulator-always-on;
 		};
 
 		/* camera, qdsp6 */
-		l23 {
+		pm8921_l23: l23 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			bias-pull-down;
@@ -310,32 +314,32 @@ l23 {
 		 * tabla2x-slim-CDC_VDDA_A_1P2V
 		 * tabla2x-slim-VDDD_CDC_D
 		 */
-		l25 {
+		pm8921_l25: l25 {
 			regulator-min-microvolt = <1250000>;
 			regulator-max-microvolt = <1250000>;
 			bias-pull-down;
 		};
 
-		lvs1 {
+		pm8921_lvs1: lvs1 {
 			bias-pull-down;
 		};
 
-		lvs4 {
+		pm8921_lvs4: lvs4 {
 			bias-pull-down;
 		};
 
-		lvs5 {
+		pm8921_lvs5: lvs5 {
 			bias-pull-down;
 		};
 
-		lvs6 {
+		pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
 		/*
 		 * mipi_dsi.1-dsi1_vddio
 		 * pil_riva-pll_vdd
 		 */
-		lvs7 {
+		pm8921_lvs7: lvs7 {
 			bias-pull-down;
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
index d4db84e9fcf3..671d58cc2741 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-cm-qs600.dts
@@ -93,6 +93,8 @@ pinconf {
 
 &rpm {
 	regulators {
+		compatible = "qcom,rpm-pm8921-regulators";
+
 		vin_lvs1_3_6-supply = <&pm8921_s4>;
 		vin_lvs2-supply = <&pm8921_s1>;
 		vin_lvs4_5_7-supply = <&pm8921_s4>;
@@ -104,9 +106,8 @@ regulators {
 		vdd_l27-supply = <&pm8921_s7>;
 		vdd_l28-supply = <&pm8921_s7>;
 
-
 		/* Buck SMPS */
-		s1 {
+		pm8921_s1: s1 {
 			regulator-always-on;
 			regulator-min-microvolt = <1225000>;
 			regulator-max-microvolt = <1225000>;
@@ -114,52 +115,51 @@ s1 {
 			bias-pull-down;
 		};
 
-		s3 {
+		pm8921_s3: s3 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1400000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
 
-		s4 {
+		pm8921_s4: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			qcom,switch-mode-frequency = <3200000>;
 		};
 
-		s7 {
+		pm8921_s7: s7 {
 			regulator-min-microvolt = <1300000>;
 			regulator-max-microvolt = <1300000>;
 			qcom,switch-mode-frequency = <3200000>;
 		};
 
-		l3 {
+		pm8921_l3: l3 {
 			regulator-min-microvolt = <3050000>;
 			regulator-max-microvolt = <3300000>;
 			bias-pull-down;
 		};
 
-		l4 {
+		pm8921_l4: l4 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1800000>;
 			bias-pull-down;
 		};
 
-		l5 {
+		pm8921_l5: l5 {
 			regulator-min-microvolt = <2750000>;
 			regulator-max-microvolt = <3000000>;
 			bias-pull-down;
 		};
 
-		l23 {
+		pm8921_l23: l23 {
 			regulator-min-microvolt = <1700000>;
 			regulator-max-microvolt = <1900000>;
 			bias-pull-down;
 		};
 
-		lvs6 {
+		pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
-
 	};
 };
 
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
index 5fd84319254e..3078afda37c6 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-ifc6410.dts
@@ -204,6 +204,8 @@ pinconf {
 
 &rpm {
 	regulators {
+		compatible = "qcom,rpm-pm8921-regulators";
+
 		vin_lvs1_3_6-supply = <&pm8921_s4>;
 		vin_lvs2-supply = <&pm8921_s1>;
 		vin_lvs4_5_7-supply = <&pm8921_s4>;
@@ -215,9 +217,8 @@ regulators {
 		vdd_l27-supply = <&pm8921_s7>;
 		vdd_l28-supply = <&pm8921_s7>;
 
-
 		/* Buck SMPS */
-		s1 {
+		pm8921_s1: s1 {
 			regulator-always-on;
 			regulator-min-microvolt = <1225000>;
 			regulator-max-microvolt = <1225000>;
@@ -225,59 +226,63 @@ s1 {
 			bias-pull-down;
 		};
 
-		s3 {
+		pm8921_s3: s3 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1400000>;
 			qcom,switch-mode-frequency = <4800000>;
 		};
 
-		s4 {
+		pm8921_s4: s4 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			qcom,switch-mode-frequency = <3200000>;
 		};
 
-		s7 {
+		pm8921_s7: s7 {
 			regulator-min-microvolt = <1300000>;
 			regulator-max-microvolt = <1300000>;
 			qcom,switch-mode-frequency = <3200000>;
 		};
 
-		l3 {
+		pm8921_l3: l3 {
 			regulator-min-microvolt = <3050000>;
 			regulator-max-microvolt = <3300000>;
 			bias-pull-down;
 		};
 
-		l4 {
+		pm8921_l4: l4 {
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1800000>;
 			bias-pull-down;
 		};
 
-		l5 {
+		pm8921_l5: l5 {
 			regulator-min-microvolt = <2750000>;
 			regulator-max-microvolt = <3000000>;
 			bias-pull-down;
 		};
 
-		l6 {
+		pm8921_l6: l6 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
 			bias-pull-down;
 		};
 
-		l23 {
+		pm8921_l23: l23 {
 			regulator-min-microvolt = <1700000>;
 			regulator-max-microvolt = <1900000>;
 			bias-pull-down;
 		};
 
-		lvs1 {
+		pm8921_lvs1: lvs1 {
+			bias-pull-down;
+		};
+
+		pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
 
-		lvs6 {
+		pm8921_hdmi_switch: hdmi-switch {
 			bias-pull-down;
 		};
 	};
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
index ba18a02b1c57..2412aa3e3e8d 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-sony-xperia-lagan-yuga.dts
@@ -93,11 +93,25 @@ gpio_keys_pin_a: gpio-keys-active-state {
 &riva {
 	pinctrl-names = "default";
 	pinctrl-0 = <&riva_wlan_pin_a>, <&riva_bt_pin_a>, <&riva_fm_pin_a>;
+
+	vddcx-supply = <&pm8921_s3>;
+	vddmx-supply = <&pm8921_l24>;
+	vddpx-supply = <&pm8921_s4>;
+
 	status = "okay";
+
+	iris {
+		vddxo-supply = <&pm8921_l4>;
+		vddrfa-supply = <&pm8921_s2>;
+		vddpa-supply = <&pm8921_l10>;
+		vdddig-supply = <&pm8921_lvs2>;
+	};
 };
 
 &rpm {
 	regulators {
+		compatible = "qcom,rpm-pm8921-regulators";
+
 		vin_l1_l2_l12_l18-supply = <&pm8921_s4>;
 		vin_lvs_1_3_6-supply = <&pm8921_s4>;
 		vin_lvs_4_5_7-supply = <&pm8921_s4>;
@@ -109,7 +123,7 @@ regulators {
 		vin_l28-supply = <&pm8921_s7>;
 
 		/* Buck SMPS */
-		s1 {
+		pm8921_s1: s1 {
 			regulator-always-on;
 			regulator-min-microvolt = <1225000>;
 			regulator-max-microvolt = <1225000>;
@@ -117,21 +131,21 @@ s1 {
 			bias-pull-down;
 		};
 
-		s2 {
+		pm8921_s2: s2 {
 			regulator-min-microvolt = <1300000>;
 			regulator-max-microvolt = <1300000>;
 			qcom,switch-mode-frequency = <1600000>;
 			bias-pull-down;
 		};
 
-		s3 {
+		pm8921_s3: s3 {
 			regulator-min-microvolt = <500000>;
 			regulator-max-microvolt = <1150000>;
 			qcom,switch-mode-frequency = <4800000>;
 			bias-pull-down;
 		};
 
-		s4 {
+		pm8921_s4: s4 {
 			regulator-always-on;
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
@@ -140,205 +154,207 @@ s4 {
 			qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
 		};
 
-		s7 {
+		pm8921_s7: s7 {
 			regulator-min-microvolt = <1300000>;
 			regulator-max-microvolt = <1300000>;
 			qcom,switch-mode-frequency = <3200000>;
 		};
 
-		s8 {
+		pm8921_s8: s8 {
 			regulator-min-microvolt = <2200000>;
 			regulator-max-microvolt = <2200000>;
 			qcom,switch-mode-frequency = <1600000>;
 		};
 
 		/* PMOS LDO */
-		l1 {
+		pm8921_l1: l1 {
 			regulator-always-on;
 			regulator-min-microvolt = <1100000>;
 			regulator-max-microvolt = <1100000>;
 			bias-pull-down;
 		};
 
-		l2 {
+		pm8921_l2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			bias-pull-down;
 		};
 
-		l3 {
+		pm8921_l3: l3 {
 			regulator-min-microvolt = <3075000>;
 			regulator-max-microvolt = <3075000>;
 			bias-pull-down;
 		};
 
-		l4 {
+		pm8921_l4: l4 {
 			regulator-always-on;
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			bias-pull-down;
 		};
 
-		l5 {
+		pm8921_l5: l5 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
 			bias-pull-down;
 		};
 
-		l6 {
+		pm8921_l6: l6 {
 			regulator-min-microvolt = <2950000>;
 			regulator-max-microvolt = <2950000>;
 			bias-pull-down;
 		};
 
-		l7 {
+		pm8921_l7: l7 {
 			regulator-min-microvolt = <1850000>;
 			regulator-max-microvolt = <2950000>;
 			bias-pull-down;
 		};
 
-		l8 {
+		pm8921_l8: l8 {
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
 			bias-pull-down;
 		};
 
-		l9 {
+		pm8921_l9: l9 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3000000>;
 			bias-pull-down;
 		};
 
-		l10 {
+		pm8921_l10: l10 {
 			regulator-min-microvolt = <2900000>;
 			regulator-max-microvolt = <2900000>;
 			bias-pull-down;
 		};
 
-		l11 {
+		pm8921_l11: l11 {
 			regulator-min-microvolt = <3000000>;
 			regulator-max-microvolt = <3000000>;
 			bias-pull-down;
 		};
 
-		l12 {
+		pm8921_l12: l12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			bias-pull-down;
 		};
 
-		l14 {
+		pm8921_l14: l14 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			bias-pull-down;
 		};
 
-		l15 {
+		pm8921_l15: l15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2950000>;
 			bias-pull-down;
 		};
 
-		l16 {
+		pm8921_l16: l16 {
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
 			bias-pull-down;
 		};
 
-		l17 {
+		pm8921_l17: l17 {
 			regulator-min-microvolt = <2000000>;
 			regulator-max-microvolt = <2000000>;
 			bias-pull-down;
 		};
 
-		l18 {
+		pm8921_l18: l18 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			bias-pull-down;
 		};
 
-		l21 {
+		pm8921_l21: l21 {
 			regulator-min-microvolt = <1050000>;
 			regulator-max-microvolt = <1050000>;
 			bias-pull-down;
 		};
 
-		l22 {
+		pm8921_l22: l22 {
 			regulator-min-microvolt = <2600000>;
 			regulator-max-microvolt = <2600000>;
 			bias-pull-down;
 		};
 
-		l23 {
+		pm8921_l23: l23 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			bias-pull-down;
 		};
 
-		l24 {
+		pm8921_l24: l24 {
 			regulator-min-microvolt = <750000>;
 			regulator-max-microvolt = <1150000>;
 			bias-pull-down;
 		};
 
-		l25 {
+		pm8921_l25: l25 {
 			regulator-always-on;
 			regulator-min-microvolt = <1250000>;
 			regulator-max-microvolt = <1250000>;
 			bias-pull-down;
 		};
 
-		l27 {
+		pm8921_l27: l27 {
 			regulator-min-microvolt = <1100000>;
 			regulator-max-microvolt = <1100000>;
 		};
 
-		l28 {
+		pm8921_l28: l28 {
 			regulator-min-microvolt = <1050000>;
 			regulator-max-microvolt = <1050000>;
 			bias-pull-down;
 		};
 
-		l29 {
+		pm8921_l29: l29 {
 			regulator-min-microvolt = <2000000>;
 			regulator-max-microvolt = <2000000>;
 			bias-pull-down;
 		};
 
 		/* Low Voltage Switch */
-		lvs1 {
+		pm8921_lvs1: lvs1 {
 			bias-pull-down;
 		};
 
-		lvs2 {
+		pm8921_lvs2: lvs2 {
 			bias-pull-down;
 		};
 
-		lvs3 {
+		pm8921_lvs3: lvs3 {
 			bias-pull-down;
 		};
 
-		lvs4 {
+		pm8921_lvs4: lvs4 {
 			bias-pull-down;
 		};
 
-		lvs5 {
+		pm8921_lvs5: lvs5 {
 			bias-pull-down;
 		};
 
-		lvs6 {
+		pm8921_lvs6: lvs6 {
 			bias-pull-down;
 		};
 
-		lvs7 {
+		pm8921_lvs7: lvs7 {
 			bias-pull-down;
 		};
 
-		usb-switch {};
+		pm8921_usb_switch: usb-switch {};
 
-		hdmi-switch {};
+		pm8921_hdmi_switch: hdmi-switch {
+			bias-pull-down;
+		};
 
-		ncp {
+		pm8921_ncp: ncp {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			qcom,switch-mode-frequency = <1600000>;
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 5704d0598b96..5b7d2c6f0ce9 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -757,60 +757,6 @@ rpmcc: clock-controller {
 				clocks = <&pxo_board>, <&cxo_board>;
 				clock-names = "pxo", "cxo";
 			};
-
-			regulators {
-				compatible = "qcom,rpm-pm8921-regulators";
-
-				pm8921_s1: s1 {};
-				pm8921_s2: s2 {};
-				pm8921_s3: s3 {};
-				pm8921_s4: s4 {};
-				pm8921_s7: s7 {};
-				pm8921_s8: s8 {};
-
-				pm8921_l1: l1 {};
-				pm8921_l2: l2 {};
-				pm8921_l3: l3 {};
-				pm8921_l4: l4 {};
-				pm8921_l5: l5 {};
-				pm8921_l6: l6 {};
-				pm8921_l7: l7 {};
-				pm8921_l8: l8 {};
-				pm8921_l9: l9 {};
-				pm8921_l10: l10 {};
-				pm8921_l11: l11 {};
-				pm8921_l12: l12 {};
-				pm8921_l14: l14 {};
-				pm8921_l15: l15 {};
-				pm8921_l16: l16 {};
-				pm8921_l17: l17 {};
-				pm8921_l18: l18 {};
-				pm8921_l21: l21 {};
-				pm8921_l22: l22 {};
-				pm8921_l23: l23 {};
-				pm8921_l24: l24 {};
-				pm8921_l25: l25 {};
-				pm8921_l26: l26 {};
-				pm8921_l27: l27 {};
-				pm8921_l28: l28 {};
-				pm8921_l29: l29 {};
-
-				pm8921_lvs1: lvs1 {};
-				pm8921_lvs2: lvs2 {};
-				pm8921_lvs3: lvs3 {};
-				pm8921_lvs4: lvs4 {};
-				pm8921_lvs5: lvs5 {};
-				pm8921_lvs6: lvs6 {};
-				pm8921_lvs7: lvs7 {};
-
-				pm8921_usb_switch: usb-switch {};
-
-				pm8921_hdmi_switch: hdmi-switch {
-					bias-pull-down;
-				};
-
-				pm8921_ncp: ncp {};
-			};
 		};
 
 		usb1: usb@12500000 {
@@ -1490,10 +1436,6 @@ riva: riva-pil@3200800 {
 
 			memory-region = <&wcnss_mem>;
 
-			vddcx-supply = <&pm8921_s3>;
-			vddmx-supply = <&pm8921_l24>;
-			vddpx-supply = <&pm8921_s4>;
-
 			status = "disabled";
 
 			iris {
@@ -1501,11 +1443,6 @@ iris {
 
 				clocks = <&cxo_board>;
 				clock-names = "xo";
-
-				vddxo-supply = <&pm8921_l4>;
-				vddrfa-supply = <&pm8921_s2>;
-				vddpa-supply = <&pm8921_l10>;
-				vdddig-supply = <&pm8921_lvs2>;
 			};
 
 			smd-edge {
-- 
2.39.2

