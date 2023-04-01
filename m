Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC96D34AC
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjDAWI2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjDAWIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F46C29502
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b6so6591222ljr.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7Y3KWurDVmeNMJ1PgoNSWwvLTrrzW/b+U81BYECoKQ=;
        b=WL6veunStgKvS/trjZTjbc5YO4zQum/MCdtE3rB7wM7s+JjAR+j1wDmxs59w29Ajjz
         eCtCdR7nsdZGNNW23rWOc0U0xhCskN3PmBhkEu0THZm52oTQ4x4wxryMzSti4xFhnT7z
         vF801nMY/k8l3LKdb5yButx2bU7H/sTQIl7dUlAFmd87k2uHwAv1UCLXMnPJdflpufYL
         9BwZJvd6OAQeK4gbUBS4aC/4Fru88nhTv/EG/iDKAwxlV3OAqltg/E9cHjZ6z/bAR0ir
         HOCLISPIsJ/8HmWAhDn29wOavKw7hQLzbGFUKPgYebH6woJURAckseIXO0843Qgywyz9
         nKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7Y3KWurDVmeNMJ1PgoNSWwvLTrrzW/b+U81BYECoKQ=;
        b=GPSkRAvYz6cxMIDOnkHHKEBTzhJRXQ8S10P9ohqScg7qgJUU1qKqhJWjB6IvKAdcsn
         r+DDN0U7ezJPacNHsZyhP3LAjRZViRDgAvEDfAukEyl6ZA6vITBvOIT8HRb0L15kF5rR
         MNtRQlakdSEZXi4gKJhZAhyAFhKi2NsFwmSX2hV9BUGQYa47H+gOMLg5/jFzFwYNj0tT
         du9FkZ66SxlmPbgsZvb9MBP5zlHXkpESbNZfoEiwr8znZtW7DL+m14mVuK8uyDZa4L1x
         OE+HrvrgFZAHuGE7Y0ev5ZeXEVUG2ZZn78YOZzL6GtZhV3Zi4gP/obFFG1HQm1htLCe6
         0muA==
X-Gm-Message-State: AAQBX9cywkQciD14wAGic5rEbI1eZaUSIPwYQ73D/J3wNx+ILsex5LOA
        0UYEf7f+dFm28Fgb9D7iAgCsVw==
X-Google-Smtp-Source: AKy350YJE78lIeCkl5UjUQWNcbugthNjhLSEs2bkDo+SlJ9QrSPkLbCENDegNkd9WqIMkX4MDx2u7w==
X-Received: by 2002:a2e:97ce:0:b0:2a2:5a2e:1d46 with SMTP id m14-20020a2e97ce000000b002a25a2e1d46mr9235511ljj.28.1680386901602;
        Sat, 01 Apr 2023 15:08:21 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:21 -0700 (PDT)
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
Subject: [PATCH v2 16/22] arm64: dts: qcom: pm8350c: allow overriding SID and label
Date:   Sun,  2 Apr 2023 01:08:04 +0300
Message-Id: <20230401220810.3563708-17-dmitry.baryshkov@linaro.org>
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

The platform can use several instances of PM8350C PMIC. Allow overriding
the SID and node labels inside pm8350c.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8350c.dtsi | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
index ee25c07ce31d..ddfc8fd6bb3e 100644
--- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
@@ -6,12 +6,23 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/* (Sadly) this PMIC can be configured to be at different SIDs */
+#ifndef PMIC_SID
+	#define PMIC_SID 2
+#endif
+
+#ifndef PMIC_LABEL
+	#define PMIC_LABEL pm8350c
+#endif
+
+#include "pmic-dyn-header.dtsi"
+
 / {
 	thermal-zones {
 		pm8350c-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
-			thermal-sensors = <&pm8350c_temp_alarm>;
+			thermal-sensors = <&LABEL(temp_alarm)>;
 
 			trips {
 				trip0 {
@@ -31,33 +42,35 @@ pm8350c-crit {
 };
 
 &spmi_bus {
-	pm8350c: pmic@2 {
+	pmic@PMIC_SID {
 		compatible = "qcom,pm8350c", "qcom,spmi-pmic";
-		reg = <0x2 SPMI_USID>;
+		reg = <PMIC_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pm8350c_temp_alarm: temp-alarm@a00 {
+		LABEL(temp_alarm): temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
 			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
 			#thermal-sensor-cells = <0>;
 		};
 
-		pm8350c_gpios: gpio@8800 {
+		LABEL(gpios): gpio@8800 {
 			compatible = "qcom,pm8350c-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
-			gpio-ranges = <&pm8350c_gpios 0 0 9>;
+			gpio-ranges = <&LABEL(gpios) 0 0 9>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 
-		pm8350c_pwm: pwm {
+		LABEL(pwm): pwm {
 			compatible = "qcom,pm8350c-pwm";
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
 	};
 };
+
+#include "pmic-dyn-footer.dtsi"
-- 
2.30.2

