Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675CE6D349E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDAWIY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjDAWIU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F7E042
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s20so6332672ljp.7
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySASawghnPCNQg5Zy9Kh+8NS4Lf0RS8xKbNr318Bjz8=;
        b=W0BR1gprWBEUrZUSxwGBb2IrWYBu6TvL+Dc/SDq4/zx5tgDU+fWf342LRyB2KIZh+L
         nwVFdMoA74rq3OlHa5HCY6r9aYojW7LQytxykdn2WDRwuxl4TrqruoDonbb2+TYfwAhr
         bjBR0sqlqD/28o2nOQPa+OMO3Y2D6DNtIdz0mppoODFZdqFS5kMfGx+J1AQptN+APNio
         gRNLKjrp8OsXZHYZl4ouwN+Zwq22jx3dtnuP/Owk627psJrDGxhEt4X3fklh5wx0DoO+
         EsnULcnbyVDzueAGouaRcoRFR+sZ0vXix2pv21xsoP37Dk60Fh6WID2pNi+A5I9C0KRi
         zqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySASawghnPCNQg5Zy9Kh+8NS4Lf0RS8xKbNr318Bjz8=;
        b=4bQHFYxNmzibbHhZbKt9swBv/K+RhtSjzVeqiBZ9l1tttUHTaCBQ8nw8Us9v9bVb+I
         4TDVnQD2NP7SP3PEXoEczTDiZoZhfmmE1OdLVIj3G1v2V/ojVUTFTDo9IBAhVKYYwVKu
         kaIAeyQ74xUTpSfvZuiVU22rCiCok8NfNsvbDTFWOL5WFSfy5/1U6PMkBWr2/GEILEtP
         v75KWy2+usUuT4NE69w83zpClZEBgzRIef+m/IhL88y9nzjoSNKMgRr/7t4wRMt/FNz9
         Q16PtKRb+/rKoGiivjSdUWl52biJ52qfeg8r5u6kisZhrPolq1R9UeaJvsYr4/BeNnYZ
         ItDw==
X-Gm-Message-State: AAQBX9cUM19As1ooxwrbkINLTC1ED54aR7ELgVsixS5KUbZl7mwiREUv
        VVbo8HVXO30MHNn5oAb/TxrI/Q==
X-Google-Smtp-Source: AKy350ZxmTIiCYo+Tt/BzPNE4954hOljzXSHARk88CEN9GKuAWOPcmQQHgcJ9VX7U4x5wCjxcr4Smw==
X-Received: by 2002:a2e:8417:0:b0:2a6:1961:c865 with SMTP id z23-20020a2e8417000000b002a61961c865mr3122267ljg.12.1680386897818;
        Sat, 01 Apr 2023 15:08:17 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:17 -0700 (PDT)
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
Subject: [PATCH v2 10/22] arm64: dts: qcom: pmk8350: use interrupts-extended for IRQ specification
Date:   Sun,  2 Apr 2023 01:07:58 +0300
Message-Id: <20230401220810.3563708-11-dmitry.baryshkov@linaro.org>
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

As stated in the commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
Specify interrupt parent explicitly"), we should not use bare interrupts
for our PMIC devices. Instead interrupts-extended should be used. Change
pmk8350.dtsi to use interrupts-extended propery.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index f26ff3daf119..87b8e4269c60 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -33,14 +33,14 @@ LABEL(pon): pon@1300 {
 
 			LABEL(pon_pwrkey): pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
-				interrupts = <PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				interrupts-extended = <&spmi_bus PMIC_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
 
 			LABEL(pon_resin): resin {
 				compatible = "qcom,pmk8350-resin";
-				interrupts = <PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				interrupts-extended = <&spmi_bus PMIC_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
 				status = "disabled";
 			};
 		};
@@ -50,14 +50,14 @@ LABEL(vadc): adc@3100 {
 			reg = <0x3100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&spmi_bus PMIC_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#io-channel-cells = <1>;
 		};
 
 		LABEL(adc_tm): adc-tm@3400 {
 			compatible = "qcom,adc-tm7";
 			reg = <0x3400>;
-			interrupts = <PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&spmi_bus PMIC_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#thermal-sensor-cells = <1>;
@@ -68,7 +68,7 @@ LABEL(rtc): rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
-			interrupts = <PMIC_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&spmi_bus PMIC_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
-- 
2.30.2

