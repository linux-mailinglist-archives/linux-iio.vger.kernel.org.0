Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D016D3496
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDAWIW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjDAWIU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF27EFB
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e9so11382455ljq.4
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auhVCLXv3fO8ZAo9OD1BbJNImSoPje+kK0+NreVCtXI=;
        b=qmcTQxgZZhT0WKiawRJHVvusVuA3P6pfm6DKwhLxxtddcSE5S5Yx+1BVKQmMbZPo2e
         EcDunjbF/j+ktcnK6k7XGqDkJB7AHzJb2o8VQIhhZ2Yn2/SVcRmwTQ8+3OhED5fFtV31
         pxKw8dSLkOQY5iIfJjiNzMWPrAWRPi7vXCNAIrTErY3YBIn3HJyIE7eBk8Ov6tiuuirA
         k8WjWxX9BuU0+aWc9VJYIXKUxRRSMj6wAFP2Ts3UuolXGv5escIG0DKfYObgPAV3Vdy2
         x80ijEYCvl6x8pvejmDvSVM4lI5HHupoAQq8EtUf+tH0lce0zYKNF5BqmrPooPkxWHUR
         WHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auhVCLXv3fO8ZAo9OD1BbJNImSoPje+kK0+NreVCtXI=;
        b=styt6+ihnYAl8sZHIK9Su3PxdxBBQTMnkb+xixkdTIuk5QlY8MdcsuGnCXplY7RMv1
         aiJFYUtq08t6MMRja9Qf6wqsm7wRfdHbEj1VHhnyd7WV+m58Xwo6PrmmdK9e3a9LfjbM
         mQJ8nU/VqYFHNGcui4W2VdVRqbv385y6X0SI0aP8wsvTQ9Hb63c1Ne6Dis3/T/YZEK5W
         5Vv+VFCJqk4VHyaSXDN4ocmuCju54NDSHbuBIlG/WAL6347zjXAXQBUULwpM9FYT8oyq
         rd0Mb/N1GG0/VSvY747nftIdXmg9tTass5YvXfVxLo8KYgzOVedU2jo+M5Ci6QLGEyI5
         DMUA==
X-Gm-Message-State: AAQBX9efArHpd2dYWtXnf8rHEzGugcXUSyD2k40XR+NOrM/tFhFTKO4i
        c4g+5FS25y6l01MWku3gwmWtuQ==
X-Google-Smtp-Source: AKy350YQocIcRLL0wIu0npSlWeIyQU0VL8/DBpGRkcboyhPBiNIxIzdMMtxteIVNwyIGwLnsaXxfEA==
X-Received: by 2002:a2e:9ccc:0:b0:2a6:183a:9a13 with SMTP id g12-20020a2e9ccc000000b002a6183a9a13mr3113541ljj.46.1680386897244;
        Sat, 01 Apr 2023 15:08:17 -0700 (PDT)
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
Subject: [PATCH v2 09/22] arm64: dts: qcom: pmk8350: allow overriding the label
Date:   Sun,  2 Apr 2023 01:07:57 +0300
Message-Id: <20230401220810.3563708-10-dmitry.baryshkov@linaro.org>
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

sc8280xp-pmics.dtsi incorporates a copy of pmk8350, but the dts files
use labels following the markings found in the schematics. Allow
overriding the labels in pmk8350.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi | 13 +++++++++
 arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi | 14 ++++++++++
 arch/arm64/boot/dts/qcom/pmk8350.dtsi         | 28 +++++++++++--------
 3 files changed, 44 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
new file mode 100644
index 000000000000..1c81269f0783
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmic-dyn-footer.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+/* cleanly revert the effects pmic-dyn-header.dtsi */
+
+#undef LABEL
+#undef _LABEL
+#undef __LABEL
+
+#undef PMIC_SID
+#undef PMIC_LABEL
diff --git a/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
new file mode 100644
index 000000000000..75f0448568bd
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmic-dyn-header.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+/*
+ * Preprocessor symbols to assist in describing PMICs which have configurable
+ * SID. All effects of this header (or its parameters) must be reverted in
+ * pmic-dyn-footer.dtsi.
+ */
+
+#define LABEL(name) _LABEL(PMIC_LABEL, name)
+#define _LABEL(pmic, name) __LABEL(pmic, name)
+#define __LABEL(pmic, name) pmic ## _ ## name
diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 02e7518ab57b..f26ff3daf119 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -13,33 +13,39 @@
 	#define PMIC_SID 0
 #endif
 
+#ifndef PMIC_LABEL
+#define PMIC_LABEL pmk8350
+#endif
+
+#include "pmic-dyn-header.dtsi"
+
 &spmi_bus {
-	pmk8350: pmic@PMIC_SID {
+	PMIC_LABEL: pmic@PMIC_SID {
 		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
 		reg = <PMIC_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pmk8350_pon: pon@1300 {
+		LABEL(pon): pon@1300 {
 			compatible = "qcom,pmk8350-pon";
 			reg = <0x1300>, <0x800>;
 			reg-names = "hlos", "pbs";
 
-			pmk8350_pon_pwrkey: pwrkey {
+			LABEL(pon_pwrkey): pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
 				interrupts = <PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
 
-			pmk8350_pon_resin: resin {
+			LABEL(pon_resin): resin {
 				compatible = "qcom,pmk8350-resin";
 				interrupts = <PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
 				status = "disabled";
 			};
 		};
 
-		pmk8350_vadc: adc@3100 {
+		LABEL(vadc): adc@3100 {
 			compatible = "qcom,spmi-adc7";
 			reg = <0x3100>;
 			#address-cells = <1>;
@@ -48,7 +54,7 @@ pmk8350_vadc: adc@3100 {
 			#io-channel-cells = <1>;
 		};
 
-		pmk8350_adc_tm: adc-tm@3400 {
+		LABEL(adc_tm): adc-tm@3400 {
 			compatible = "qcom,adc-tm7";
 			reg = <0x3400>;
 			interrupts = <PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
@@ -58,7 +64,7 @@ pmk8350_adc_tm: adc-tm@3400 {
 			status = "disabled";
 		};
 
-		pmk8350_rtc: rtc@6100 {
+		LABEL(rtc): rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
@@ -66,7 +72,7 @@ pmk8350_rtc: rtc@6100 {
 			status = "disabled";
 		};
 
-		pmk8350_sdam_6: nvram@8500 {
+		LABEL(sdam_6): nvram@8500 {
 			compatible = "qcom,spmi-sdam";
 			reg = <0x8500>;
 			#address-cells = <1>;
@@ -75,11 +81,11 @@ pmk8350_sdam_6: nvram@8500 {
 			status = "disabled";
 		};
 
-		pmk8350_gpios: gpio@b000 {
+		LABEL(gpios): gpio@b000 {
 			compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
 			reg = <0xb000>;
 			gpio-controller;
-			gpio-ranges = <&pmk8350_gpios 0 0 4>;
+			gpio-ranges = <&LABEL(gpios) 0 0 4>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -87,4 +93,4 @@ pmk8350_gpios: gpio@b000 {
 	};
 };
 
-#undef PMIC_SID
+#include "pmic-dyn-footer.dtsi"
-- 
2.30.2

