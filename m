Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26E6D3490
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjDAWIV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjDAWIT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDCCEC5F
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bx10so8316753ljb.8
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+ncye5umI1tZvLHf/bJkbEX997B+2yRqwH3006HgP8=;
        b=BwXech6rabDvRwHHsDRFT26Wam60tZJF5p879RE7a5XG/j2cGfL2hujErQGGGyraLo
         SXVbxQ0M+ZEWoLcjJBypymfNGTSQiEgGLIzAGA8VQDmovOusMD/AuHKFd66vXI+S8wIE
         cHzz69TA5riZh1m+ZAXHmlxlBoBc0s3y2FS3DGfCefWByRF/x8XNBaqbNpcE/thMNpPb
         s2BToVAvchbBfzIC3snIqWmwMrKZgXAyU39Hd4NiCtyq1W80qpZsX7Dvc3YGdGp8nFuC
         Ug8mmc2RCitSqprjF88SVdy7SZ8mlOhbP8HEGD4ukv5Hz9Wd5wu9aUX2AFtPvm4J/DJQ
         1L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+ncye5umI1tZvLHf/bJkbEX997B+2yRqwH3006HgP8=;
        b=bMaG5gZL5OLUg/bYVuGZjpTr7GtExZ0OM2fnbjbxVsdGOIXEzZ4Yvv1+3jCbuQEJ1J
         w4XBdm9+O7DknbT1K8kMLsXcq2ixBjLXxRf5rEr4Tc1lIh6SEtLOm73rMl7VuRXqh0Gm
         fWVwpLt3rlYpVRTaO/JbRiRFqB1xtL7TT3EnZEFi6/cCQIxKG1uZJ/pwRA4gdkhXfx+A
         cFkee1TBeiauZTWt1WlX4SmHwylDL4zpUKxux7F/91cIzq7Dw3poRClCnr/C8ubF0Xyl
         TZngVtW1fZBbcowOUD8E5VhD3Bqt98ZwdGBboUNN7who7kgQPXj53DCfG6d3xzFyw2IG
         eSmA==
X-Gm-Message-State: AAQBX9cAC4u7PhAeVW0XgUXaWynWN+d4aBfEtWYenKYH8vH93r8oUHdR
        KohGERisZh+8gJJWLJPD2yMpLA==
X-Google-Smtp-Source: AKy350YipCjOjQ7c/Icad8BxlePwV7waZJV+UTgvZeyWRN6iXbLIMhEnRkRO8sKiYhHkWIvA2YgwcA==
X-Received: by 2002:a2e:9cc1:0:b0:299:a984:94b with SMTP id g1-20020a2e9cc1000000b00299a984094bmr10963243ljj.8.1680386894605;
        Sat, 01 Apr 2023 15:08:14 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:14 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 05/22] dt-bindings: iio: qcom,spmi-adc7-pmk8350.h: include sid into defines
Date:   Sun,  2 Apr 2023 01:07:53 +0300
Message-Id: <20230401220810.3563708-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

