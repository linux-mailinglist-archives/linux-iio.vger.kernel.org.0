Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E86CCE88
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjC2AIm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Mar 2023 20:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjC2AIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2023 20:08:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3171FE0
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k37so18051947lfv.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Mar 2023 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680048516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okTUc2oz20b8x16zB41RfR2tNAdbERt7gZi2YK1IOFU=;
        b=FRcdutQPgk4tv33RGAzytw972fgyChZiKxdxbOYQKkg7n1eqVKLGt9tod/ay4dz7Bd
         jHOiolSMwa6dgKHifFW4tWh+welL2Sc4daOgfShmJKoMsJUsXUcLYq2pgCYfrElcL0HL
         vreCrQsgDTW+U2VqapLDAD92fpRIXzvB1F6bwQHTbXheoJv4e/H0D8+XJiFGfQepStfA
         yX8EcR6KJd362OiaKgaY8dmvhOBITGYG3kfreV/7X8FJ+HY6s8RyMLAl4yxhONA3Gk30
         GfLsnpbyXbwlaQ+umsPCtJC/CAP61ee94o1AW7Y2JIelTUHCgxM8HZzVvQl20DNyk0Dh
         GKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680048516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okTUc2oz20b8x16zB41RfR2tNAdbERt7gZi2YK1IOFU=;
        b=0XUmRqbiyJHPmZCn1yJcsOn+QhS46VNQlVgAFj5HuQdFo60d1l66jB89DA+NRXzWtZ
         H31qnmeKxHk0t9VCgTGOSRQ2mjCWV3hKnjhdDAyWbHAGuDGV3p95r76uHua/R2cixhoL
         l9R5BoFxGtDOaFURRgu+PVlZpwHFkbF6mtJ3Hacz9e9LekCFof/pR4cO5s8bmNJSqllc
         eSyeJCTl63fDuzUSQQToPX3B7AK+UW1/jRcM3lUBCfl3pgc7ZHVYi4PEsRz0ZPiFDcpU
         JWt2/zNFlK9w6m7QzwfC3hpm+9RnCpVySTZYtcH80HHKne8KI2pVASN0XNC1f0xvnrzm
         YZnA==
X-Gm-Message-State: AAQBX9dzbU3fSY2lCo2x1FW+Q1rtWGcfiY/bol2LuCqjXuRM9Je58amf
        JRtQ6MUZ9thPDJuP0/FTAVkKTw==
X-Google-Smtp-Source: AKy350YcCuC5Xh3d+SgdfQKYsIH+Lw9GYfJ2yQqxDLDJ6FaBBbpoaUgrO3u6GDN5cEVtAJEIp6yb/g==
X-Received: by 2002:a19:ee14:0:b0:4e9:74fe:91be with SMTP id g20-20020a19ee14000000b004e974fe91bemr5199512lfb.27.1680048516550;
        Tue, 28 Mar 2023 17:08:36 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004e8011cbaa0sm5238341lfo.111.2023.03.28.17.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 17:08:35 -0700 (PDT)
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
Subject: [PATCH 1/6] dt-bindings: iio: qcom,spmi-adc7-pmk8350.h: include sid into defines
Date:   Wed, 29 Mar 2023 03:08:28 +0300
Message-Id: <20230329000833.2507594-2-dmitry.baryshkov@linaro.org>
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

pmk8350 can take different addresses on SPMI bus. Rather than having a
default SID, follow the pm8350's example and make the sid explicit when
specifying ADC channels.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  2 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  4 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  2 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  4 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  2 +-
 .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  | 52 +++++++++----------
 7 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index bd6e0d6f6e0c..df317901e7d0 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -293,7 +293,7 @@ examples:
 
             /* Other properties are omitted */
             xo-therm@44 {
-                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
             };
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 52ec18cf1eda..ff07d27775dc 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -218,7 +218,7 @@ examples:
 
             /* Other properties are omitted */
             xo-therm@44 {
-                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
                 qcom,ratiometric;
                 qcom,hw-settle-time = <200>;
             };
@@ -240,7 +240,7 @@ examples:
 
             pmk8350-xo-therm@0 {
                 reg = <0>;
-                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+                io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
                 qcom,decimation = <340>;
                 qcom,ratiometric;
                 qcom,hw-settle-time-us = <200>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 5dc9bee28e7f..14c9bdaa46ed 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -433,7 +433,7 @@ &pcie1_phy {
 
 &pmk8350_vadc {
 	pmk8350-die-temp@3 {
-		reg = <PMK8350_ADC7_DIE_TEMP>;
+		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index cb0cc2ba2fa3..e3919e074ebd 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -389,7 +389,7 @@ &pm8350c_pwm {
 
 &pmk8350_vadc {
 	pmk8350-die-temp@3 {
-		reg = <PMK8350_ADC7_DIE_TEMP>;
+		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
 		label = "pmk8350_die_temp";
 		qcom,pre-scaling = <1 1>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 46c7fdafb840..590400985055 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -824,13 +824,13 @@ &pmk8280_vadc {
 	status = "okay";
 
 	pmic-die-temp@3 {
-		reg = <PMK8350_ADC7_DIE_TEMP>;
+		reg = <PMK8350_ADC7_DIE_TEMP(0)>;
 		qcom,pre-scaling = <1 1>;
 		label = "pmk8350_die_temp";
 	};
 
 	xo-therm@44 {
-		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
 		qcom,hw-settle-time = <200>;
 		qcom,ratiometric;
 		label = "pmk8350_xo_therm";
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 7ae6aba5d2ec..af6cf4fbddc7 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -516,7 +516,7 @@ &pmk8350_rtc {
 
 &pmk8350_vadc {
 	adc-chan@644 {
-		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU(0)>;
 		qcom,ratiometric;
 		qcom,hw-settle-time = <200>;
 		qcom,pre-scaling = <1 1>;
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
index 6c296870e95b..ca85a2d69453 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
+++ b/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
@@ -6,41 +6,37 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H
 
-#ifndef PMK8350_SID
-#define PMK8350_SID					0
-#endif
-
 /* ADC channels for PMK8350_ADC for PMIC7 */
-#define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | 0x0)
-#define PMK8350_ADC7_1P25VREF			(PMK8350_SID << 8 | 0x01)
-#define PMK8350_ADC7_VREF_VADC			(PMK8350_SID << 8 | 0x02)
-#define PMK8350_ADC7_DIE_TEMP			(PMK8350_SID << 8 | 0x03)
+#define PMK8350_ADC7_REF_GND(sid)			((sid) << 8 | 0x0)
+#define PMK8350_ADC7_1P25VREF(sid)			((sid) << 8 | 0x01)
+#define PMK8350_ADC7_VREF_VADC(sid)			((sid) << 8 | 0x02)
+#define PMK8350_ADC7_DIE_TEMP(sid)			((sid) << 8 | 0x03)
 
-#define PMK8350_ADC7_AMUX_THM1			(PMK8350_SID << 8 | 0x04)
-#define PMK8350_ADC7_AMUX_THM2			(PMK8350_SID << 8 | 0x05)
-#define PMK8350_ADC7_AMUX_THM3			(PMK8350_SID << 8 | 0x06)
-#define PMK8350_ADC7_AMUX_THM4			(PMK8350_SID << 8 | 0x07)
-#define PMK8350_ADC7_AMUX_THM5			(PMK8350_SID << 8 | 0x08)
+#define PMK8350_ADC7_AMUX_THM1(sid)			((sid) << 8 | 0x04)
+#define PMK8350_ADC7_AMUX_THM2(sid)			((sid) << 8 | 0x05)
+#define PMK8350_ADC7_AMUX_THM3(sid)			((sid) << 8 | 0x06)
+#define PMK8350_ADC7_AMUX_THM4(sid)			((sid) << 8 | 0x07)
+#define PMK8350_ADC7_AMUX_THM5(sid)			((sid) << 8 | 0x08)
 
 /* 30k pull-up1 */
-#define PMK8350_ADC7_AMUX_THM1_30K_PU		(PMK8350_SID << 8 | 0x24)
-#define PMK8350_ADC7_AMUX_THM2_30K_PU		(PMK8350_SID << 8 | 0x25)
-#define PMK8350_ADC7_AMUX_THM3_30K_PU		(PMK8350_SID << 8 | 0x26)
-#define PMK8350_ADC7_AMUX_THM4_30K_PU		(PMK8350_SID << 8 | 0x27)
-#define PMK8350_ADC7_AMUX_THM5_30K_PU		(PMK8350_SID << 8 | 0x28)
+#define PMK8350_ADC7_AMUX_THM1_30K_PU(sid)		((sid) << 8 | 0x24)
+#define PMK8350_ADC7_AMUX_THM2_30K_PU(sid)		((sid) << 8 | 0x25)
+#define PMK8350_ADC7_AMUX_THM3_30K_PU(sid)		((sid) << 8 | 0x26)
+#define PMK8350_ADC7_AMUX_THM4_30K_PU(sid)		((sid) << 8 | 0x27)
+#define PMK8350_ADC7_AMUX_THM5_30K_PU(sid)		((sid) << 8 | 0x28)
 
 /* 100k pull-up2 */
-#define PMK8350_ADC7_AMUX_THM1_100K_PU		(PMK8350_SID << 8 | 0x44)
-#define PMK8350_ADC7_AMUX_THM2_100K_PU		(PMK8350_SID << 8 | 0x45)
-#define PMK8350_ADC7_AMUX_THM3_100K_PU		(PMK8350_SID << 8 | 0x46)
-#define PMK8350_ADC7_AMUX_THM4_100K_PU		(PMK8350_SID << 8 | 0x47)
-#define PMK8350_ADC7_AMUX_THM5_100K_PU		(PMK8350_SID << 8 | 0x48)
+#define PMK8350_ADC7_AMUX_THM1_100K_PU(sid)		((sid) << 8 | 0x44)
+#define PMK8350_ADC7_AMUX_THM2_100K_PU(sid)		((sid) << 8 | 0x45)
+#define PMK8350_ADC7_AMUX_THM3_100K_PU(sid)		((sid) << 8 | 0x46)
+#define PMK8350_ADC7_AMUX_THM4_100K_PU(sid)		((sid) << 8 | 0x47)
+#define PMK8350_ADC7_AMUX_THM5_100K_PU(sid)		((sid) << 8 | 0x48)
 
 /* 400k pull-up3 */
-#define PMK8350_ADC7_AMUX_THM1_400K_PU		(PMK8350_SID << 8 | 0x64)
-#define PMK8350_ADC7_AMUX_THM2_400K_PU		(PMK8350_SID << 8 | 0x65)
-#define PMK8350_ADC7_AMUX_THM3_400K_PU		(PMK8350_SID << 8 | 0x66)
-#define PMK8350_ADC7_AMUX_THM4_400K_PU		(PMK8350_SID << 8 | 0x67)
-#define PMK8350_ADC7_AMUX_THM5_400K_PU		(PMK8350_SID << 8 | 0x68)
+#define PMK8350_ADC7_AMUX_THM1_400K_PU(sid)		((sid) << 8 | 0x64)
+#define PMK8350_ADC7_AMUX_THM2_400K_PU(sid)		((sid) << 8 | 0x65)
+#define PMK8350_ADC7_AMUX_THM3_400K_PU(sid)		((sid) << 8 | 0x66)
+#define PMK8350_ADC7_AMUX_THM4_400K_PU(sid)		((sid) << 8 | 0x67)
+#define PMK8350_ADC7_AMUX_THM5_400K_PU(sid)		((sid) << 8 | 0x68)
 
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8350_H */
-- 
2.30.2

