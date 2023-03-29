Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F0F6CCE8D
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC2AIo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjC2AIm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:08:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249151720
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h25so17991643lfv.6
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680048519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Anp0yj4hrP2BGkDafjXptqjvHet/PfY+NJdrlzSWHIQ=;
        b=J+4nUbY4ebvjmG7lpW5adDKr1N7DvYrWZyxu+9VsO8CNnGCsvW6Ox9ZLGhg2rtGjgX
         YbUYJ+SScDtvs0Nkp0KDIJQzmbpEouSw9RVdvGYsCqd1wMUUBRtwh1Z7PCCG4bdpfeER
         asUxDBm8IDTbdx7YDiwmudYI1rlsGdDA49DyJDGeFSA4L0+vDlwAM+YuiHun5diMq9JJ
         xCOXx4vW/SN4J2ssP8WN6d7Az+0nOUSSFyHfgP8JcyllTJXCAdc2PHf8zHOOnRNsXR3m
         VdhueqXP9P4dknKBTAK41bbBNoKwSgDWe4XvZXQLe07899ZLMwMlN6mF7WmkeZ/KLnh/
         Tybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Anp0yj4hrP2BGkDafjXptqjvHet/PfY+NJdrlzSWHIQ=;
        b=vn6Dqn7SpFwg2F6eRBYOli5nTFYf25/8aR4Zz4MX7UXbfb+eiEAZ0neHc25STU6dJK
         wdb/s9igu7LVMB7EfsVKiCzrASOUiysJUqCedj3ug8ZJfLi6ZLptLdJXoBBn0eGeSkp3
         ZQiYW5EBgEL4UyAjY6ATh/fKaogf2TZTWOheFT4u/E5ZixN93pgEbbUYFSIyBazSEAdk
         05Ym4vYyukDsCV7qYHXM2QGxX2nRrdpJfk/x2LhaUOEhSfecyBIvU0B7xl5seeimPhub
         gtqhWqcCHIL4MLfYNat0uS4ZcpOglBWfu5iVWMX6bUnLPp6lpj/Jr5UhNOyx8teLOW8h
         3vaQ==
X-Gm-Message-State: AAQBX9fzfUNVskSoZc13/8qEj+/65iMQNESqYwKzb3HJT3kzq4M7qYDS
        ShBVurJNAuXJkp9Ee3HQuFd+7g==
X-Google-Smtp-Source: AKy350YXr+yiWgQVyLFhE/utxU0M7JhVdvyIcNKMVJDA4DiU4YX4oTa0VPXxvej1pPI6NmUhV4T/Eg==
X-Received: by 2002:ac2:442a:0:b0:4ea:e68c:91bc with SMTP id w10-20020ac2442a000000b004eae68c91bcmr5421354lfl.18.1680048519533;
        Tue, 28 Mar 2023 17:08:39 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004e8011cbaa0sm5238341lfo.111.2023.03.28.17.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 17:08:38 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: qcom: pm8350: include SID into labels
Date:   Wed, 29 Mar 2023 03:08:31 +0300
Message-Id: <20230329000833.2507594-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
References: <20230329000833.2507594-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The platform can use several instances of PM8350 PMIC. Include SID into
all the labels to simplify such platforms configuration.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8350.dtsi          | 31 +++++++++++++------
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   |  4 +--
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   |  4 +--
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
index 2dfeb99300d7..f1ef242760f2 100644
--- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
@@ -6,21 +6,30 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/* (Sadly) this PMIC can be configured to be at different SIDs */
+#ifndef PM8350_SID
+	#define PM8350_SID 1
+#endif
+
+#define __LABEL(pmic, sid, name) pmic ## _ ## sid ## _ ## name
+#define _LABEL(pmic, sid, name) __LABEL(pmic, sid, name)
+#define LABEL(name) _LABEL(pm8350, PM8350_SID, name)
+
 / {
 	thermal-zones {
-		pm8350_thermal: pm8350c-thermal {
+		LABEL(thermal): pm8350c-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
-			thermal-sensors = <&pm8350_temp_alarm>;
+			thermal-sensors = <&LABEL(temp_alarm)>;
 
 			trips {
-				pm8350_trip0: trip0 {
+				LABEL(trip0): trip0 {
 					temperature = <95000>;
 					hysteresis = <0>;
 					type = "passive";
 				};
 
-				pm8350_crit: pm8350c-crit {
+				LABEL(crit): pm8350c-crit {
 					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
@@ -33,25 +42,29 @@ pm8350_crit: pm8350c-crit {
 &spmi_bus {
 	pm8350: pmic@1 {
 		compatible = "qcom,pm8350", "qcom,spmi-pmic";
-		reg = <0x1 SPMI_USID>;
+		reg = <PM8350_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pm8350_temp_alarm: temp-alarm@a00 {
+		LABEL(temp_alarm): temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
-			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <PM8350_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
 			#thermal-sensor-cells = <0>;
 		};
 
-		pm8350_gpios: gpio@8800 {
+		LABEL(gpios): gpio@8800 {
 			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
-			gpio-ranges = <&pm8350_gpios 0 0 10>;
+			gpio-ranges = <&LABEL(gpios) 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 	};
 };
+
+#undef LABEL
+#undef _LABEL
+#undef __LABEL
diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index e28f49e31b9f..5c09b1d8881b 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -72,7 +72,7 @@ key-camera-snapshot {
 
 		key-google-assist {
 			label = "Google Assistant Key";
-			gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
+			gpios = <&pm8350_1_gpios 9 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_LEFTMETA>;
 			debounce-interval = <15>;
 			linux,can-disable;
@@ -564,7 +564,7 @@ &mpss {
 	firmware-name = "qcom/sm8350/Sony/sagami/modem.mbn";
 };
 
-&pm8350_gpios {
+&pm8350_1_gpios {
 	gpio-line-names = "ASSIGN1_THERM", /* GPIO_1 */
 			  "LCD_ID",
 			  "SDR_MMW_THERM",
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 99e9b776b93d..d90e3fedb742 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -56,7 +56,7 @@ key-camera-snapshot {
 		key-volume-down {
 			label = "Volume Down";
 			linux,code = <KEY_VOLUMEDOWN>;
-			gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
+			gpios = <&pm8350_1_gpios 6 GPIO_ACTIVE_LOW>;
 			debounce-interval = <15>;
 			linux,can-disable;
 			wakeup-source;
@@ -622,7 +622,7 @@ &pcie0_phy {
 	status = "okay";
 };
 
-&pm8350_gpios {
+&pm8350_1_gpios {
 	gpio-line-names = "ASSIGN1_THERM", /* GPIO_1 */
 			  "LCD_ID",
 			  "SDR_MMW_THERM",
-- 
2.30.2

