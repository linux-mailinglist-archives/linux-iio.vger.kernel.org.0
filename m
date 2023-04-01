Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064A26D3499
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjDAWIX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjDAWIT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228672702E
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id by14so7465885ljb.12
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbYMjr8axBk3951HCSojoBjEFzExGGWWF+tXKuXtXzw=;
        b=rByn2aOlbs4CijcEPk7eFC1228R7hF2TZ22PmjQlvQRWcukEy4FoPbjCOAO0tdSnBV
         0FroMWOe9kcKSqzHDnl3IInbCZNv9hQeP+XSqdnUr66L9M3bujkpmWz37RQHYULjdlOs
         7oNP6J5SAG8WPuD+xFGcKQOT0kVwuXZHcKLv5VMpusHkouOWK5mnGj0Cb5vvcbAcATgD
         DlldJ3iO+UzIPJ3VfuRFwZod4Iwt0+DDSi1/VnLzSJQwUQ6GlemqxqH+pX3eDI4Bj1LY
         kLTEHvvRlA0zEu02E/rZVOQ0m+3OUYfRwdyyHzfGGdJilktdtSHoweM4OBzFBdqqUs3D
         WpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbYMjr8axBk3951HCSojoBjEFzExGGWWF+tXKuXtXzw=;
        b=qcmVNoUzyjy53zLdWIl/8uR5t/jwn4mfmGc9Wpzyd3dJkC3fQXGQGGXibyM9pkm4//
         fpsPY9hcZKFfphHsILhWaNmP1r/tUh4ZYdEwaIEZ02iduAZKrYUcwgj2wltiXmGNE/nE
         h0YWwe1H3aCZMprNO1D+QpduMWY70J1/hJWgw42fNHXDsevPd3DwPC+tAZ+53ZETFTnB
         /cEj383ijKcQ3XlJhH2Bv02qmXTAxpzes/AD5LC/KD6Sfpd3Rtbpg/nSwWGWkRB5jWlc
         LaXGpLk/kLDFc8zRnLJRno0CoV3b0V5ywYmJSOZojK8SLByEk0wiq0Z1NSEk7m/zMyLC
         2OAg==
X-Gm-Message-State: AAQBX9eeIqGD/Jw8SZNFp7yX9b6jExA/QzJeYz6qHViuN98kXe8bCQtv
        HBXFSnPrUb0OjY0p1FpdxVU/2g==
X-Google-Smtp-Source: AKy350acBpKROXD/B0ZV4u66ffLJMowqKcRArGgeLknsFWg1GCMr+JKspSwRwwMRd52TO4gwGxQavw==
X-Received: by 2002:a2e:8543:0:b0:298:aa76:2fb8 with SMTP id u3-20020a2e8543000000b00298aa762fb8mr9700370ljj.12.1680386896681;
        Sat, 01 Apr 2023 15:08:16 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:16 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 08/22] arm64: dts: qcom: pmk8350: rename PMK8350_SID to PMIC_SID
Date:   Sun,  2 Apr 2023 01:07:56 +0300
Message-Id: <20230401220810.3563708-9-dmitry.baryshkov@linaro.org>
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

Several next patches are going to introduce flexibility into several
other PMICs in order to support variable SID and node labels. This will
result in close duplication of several similar preprocessor
constructions. Having a per-PMIC defines would be error prone and can
result in hard-to-notices mistakes. Thus rename PMK8350_SID to a generic
PMIC_SID.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi         | 20 ++++++++++---------
 .../qcom/sm6375-sony-xperia-murray-pdx225.dts |  7 ++++---
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  6 +++---
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 26e40dbfc173..02e7518ab57b 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -9,14 +9,14 @@
 #include <dt-bindings/spmi/spmi.h>
 
 /* (Sadly) this PMIC can be configured to be at different SIDs */
-#ifndef PMK8350_SID
-	#define PMK8350_SID 0
+#ifndef PMIC_SID
+	#define PMIC_SID 0
 #endif
 
 &spmi_bus {
-	pmk8350: pmic@PMK8350_SID {
+	pmk8350: pmic@PMIC_SID {
 		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
-		reg = <PMK8350_SID SPMI_USID>;
+		reg = <PMIC_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -27,14 +27,14 @@ pmk8350_pon: pon@1300 {
 
 			pmk8350_pon_pwrkey: pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
-				interrupts = <PMK8350_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
 
 			pmk8350_pon_resin: resin {
 				compatible = "qcom,pmk8350-resin";
-				interrupts = <PMK8350_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
 				status = "disabled";
 			};
 		};
@@ -44,14 +44,14 @@ pmk8350_vadc: adc@3100 {
 			reg = <0x3100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <PMK8350_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#io-channel-cells = <1>;
 		};
 
 		pmk8350_adc_tm: adc-tm@3400 {
 			compatible = "qcom,adc-tm7";
 			reg = <0x3400>;
-			interrupts = <PMK8350_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#thermal-sensor-cells = <1>;
@@ -62,7 +62,7 @@ pmk8350_rtc: rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
-			interrupts = <PMK8350_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMIC_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
@@ -86,3 +86,5 @@ pmk8350_gpios: gpio@b000 {
 		};
 	};
 };
+
+#undef PMIC_SID
diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index b691c3834b6b..863fc1f4b0b6 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -5,13 +5,14 @@
 
 /dts-v1/;
 
-/* PMK8350 is configured to use SID6 instead of 0 */
-#define PMK8350_SID 6
-
 #include <dt-bindings/gpio/gpio.h>
 #include "sm6375.dtsi"
 #include "pm6125.dtsi"
+
+/* PMK8350 is configured to use SID6 instead of 0 */
+#define PMIC_SID 6
 #include "pmk8350.dtsi"
+
 #include "pmr735a.dtsi"
 
 /* PM6125 PON is used and we can't have duplicate labels */
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index af6cf4fbddc7..965b37245007 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -5,9 +5,6 @@
 
 /dts-v1/;
 
-/* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
-#define PMK8350_SID 6
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/input.h>
@@ -18,6 +15,9 @@
 #include "pm6150l.dtsi"
 #include "pm6350.dtsi"
 #include "pm7250b.dtsi"
+
+/* PMK8350 (in reality a PMK8003) is configured to use SID6 instead of 0 */
+#define PMIC_SID 6
 #include "pmk8350.dtsi"
 
 / {
-- 
2.30.2

