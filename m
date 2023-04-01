Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A94A6D34A3
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjDAWI0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjDAWIV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67F2B0C8
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h9so26658219ljq.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m0hdfq0uiUbCtIDj7GtLY/zovcSFcUMPdTKKyhrM9A=;
        b=rlCf6nwQVKQmnNVNtddeGfkzHqk1sS7gMvpv+/FNvEEkmiW8m5hUY8z+cKVaRfNPn4
         y//KdphYqgCRa2y8+m5EqNpcG02Q5GBlmBy60BMKFNSIYzGt1/3JmKOpnA0Fvo6oimyH
         WRkOvOpEFiZvEuxmaSQFqteNnHBOaJwPdhdu/gYxd67YCqHKvI+18xtKeDV0KrFukTMz
         Fa4epttegyFCb7ImN5aXKm2oTkxnVPf8AonEaAC9C8lFkr7ewdBKb/AJFnar5tD3gJuq
         dwY4Q6mn0H6r7ObwvH57oWK4NsQ6/aP9b44hjpESv5CMqcKiyqm4CsDf++PxR29aD39I
         aDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m0hdfq0uiUbCtIDj7GtLY/zovcSFcUMPdTKKyhrM9A=;
        b=Qi38iprALxj+nH0E7x6xYrWud+8Wgu7XOz/QNqNFySlq9AeSzupMwYszjk3JesThZt
         HAth6GdIoXU9XwD+sKpSNXSz0a3l76HQOWjlMAS1r9YcgBPfqXWDl7Nu+wt/0Uvc3w0Z
         m5clAwe/4PS/2jNOInSSP/+dBYYjWK5TcKIHSGRm1b04ge0kWa5FGqchDhqnU+dw4ByR
         ne1IaPfmDXR9cC/cZV8JpTJ+19l7hHG1hyOEAbilfE59PpYZt2FG78P7GuWapxJptQ3W
         CC7ai1kdY2x0I1bhzMf+FECkziAcRHt6KlJIIVLbob/JoOKjfKzMg+HJouktO7/gKz7V
         VDkA==
X-Gm-Message-State: AAQBX9eEjEtAoT0z5FYTS2e1+KjpL38rqtlDbzUOhz7iZpzyh1u7ks6T
        oc9xs7TpeSjdJ9Np9kNgxkR286tlCaOLLb2LP3hKaw==
X-Google-Smtp-Source: AKy350a3fAKWohjrLSSjtytWHa012WYJ6te7dAnRvRG/lWN9D4ucYtLhOMjxCQAnS1oZIFuIhbxpLw==
X-Received: by 2002:a2e:9589:0:b0:298:a7bd:5c56 with SMTP id w9-20020a2e9589000000b00298a7bd5c56mr9194539ljh.53.1680386898434;
        Sat, 01 Apr 2023 15:08:18 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:18 -0700 (PDT)
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
Subject: [PATCH v2 11/22] arm64: dts: qcom: sc8280xp*: use pmk8350.dtsi
Date:   Sun,  2 Apr 2023 01:07:59 +0300
Message-Id: <20230401220810.3563708-12-dmitry.baryshkov@linaro.org>
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

Employ PMIC_LABEL and switch sc8280xp-pmics to use pmk8350.dtsi in order
to reduce duplication and possible discrepancies.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 67 ++------------------
 1 file changed, 4 insertions(+), 63 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 254337345e45..6c183b6c9207 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -51,70 +51,11 @@ trip1 {
 	};
 };
 
-&spmi_bus {
-	pmk8280: pmic@0 {
-		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pmk8280_pon: pon@1300 {
-			compatible = "qcom,pmk8350-pon";
-			reg = <0x1300>, <0x800>;
-
-			pmk8280_pon_pwrkey: pwrkey {
-				compatible = "qcom,pmk8350-pwrkey";
-				interrupts-extended = <&spmi_bus 0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
-				linux,code = <KEY_POWER>;
-				status = "disabled";
-			};
-
-			pmk8280_pon_resin: resin {
-				compatible = "qcom,pmk8350-resin";
-				interrupts-extended = <&spmi_bus 0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
-				status = "disabled";
-			};
-		};
-
-		pmk8280_vadc: adc@3100 {
-			compatible = "qcom,spmi-adc7";
-			reg = <0x3100>;
-			interrupts-extended = <&spmi_bus 0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#io-channel-cells = <1>;
-			status = "disabled";
-		};
-
-		pmk8280_adc_tm: adc-tm@3400 {
-			compatible = "qcom,spmi-adc-tm5-gen2";
-			reg = <0x3400>;
-			interrupts-extended = <&spmi_bus 0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#thermal-sensor-cells = <1>;
-			status = "disabled";
-		};
-
-		pmk8280_rtc: rtc@6100 {
-			compatible = "qcom,pmk8350-rtc";
-			reg = <0x6100>, <0x6200>;
-			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
-			wakeup-source;
-			status = "disabled";
-		};
-
-		pmk8280_sdam_6: nvram@8500 {
-			compatible = "qcom,spmi-sdam";
-			reg = <0x8500>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x8500 0x100>;
-			status = "disabled";
-		};
-	};
+/* SID 0 */
+#define PMIC_LABEL pmk8280
+#include "pmk8350.dtsi"
 
+&spmi_bus {
 	pmc8280_1: pmic@1 {
 		compatible = "qcom,pm8350", "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
-- 
2.30.2

