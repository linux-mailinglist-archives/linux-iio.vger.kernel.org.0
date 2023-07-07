Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D574B0F7
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jul 2023 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjGGMaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jul 2023 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGGMam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2023 08:30:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85479213F
        for <linux-iio@vger.kernel.org>; Fri,  7 Jul 2023 05:30:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fbcbf4375dso2057588e87.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Jul 2023 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688733034; x=1691325034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PTCa9Eb+3TnyEnviBdJNY98MQJTj8XpgBrb8rcKVOo=;
        b=woMXTtK1rBMkAjJbab8TJIgbHj8vq+4z+J84OGBnj9JrOSWWqKgjZzgE0ii4vjqZrr
         9Hh8nlo16hJcahweXCGGFi5+tO9a1TJ1Wq6imVF9EqxdobtY9TqAt0o1iDzzas0EGDAz
         LSQ+G78WvJxFv8JBGdBtGjKTDp/eFmokhnI4Tr30g9eRFDDv9muaJc90aHfZSVdB4z9N
         S0T6+9DAUVMcI7fkzRXoNXhb0tOOcZMsMjPw3bTYH2HMYplCtHbofkKCpcIxdj2fq4yc
         I3p3+VyuUu7HJUCG6Z2G/MtKerQaoLtC++L0SrmplmN5IqhmeMx94XAnFHiYI/GuM+5c
         MjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688733034; x=1691325034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PTCa9Eb+3TnyEnviBdJNY98MQJTj8XpgBrb8rcKVOo=;
        b=FVjbZaMzZJGgnpxsnKZ34hSv5XdJhfQOu6/QutK9FUl3IIPSScmbzEOMx62ubG3zsY
         KmkPuUmiEBG/WaosuLQDU9DVeSIXvV5RUx8ZKEjmOaf9PJPhUwEBAVStZCx1yAzMTOfG
         A5N56z4TP351tvd2n8NyW3usJddB8I+yWugpggKw9dNGcDvx3ZeBMKmIHLQEvYVf3aOi
         sObq6BqrusG5JnU8lAfNSQDFf9hcHIleaLR8Ykisjt6XcxJHf2+74scPj3tFEWQNCbrW
         vtdjT983KgW3XVS7hT28d7KiPjWGTmLeecwyEmDIz8j0MBpr8JCVB27ClRmpUFhkem7j
         Nnhg==
X-Gm-Message-State: ABy/qLaGeMVTCObXeapDA3juyJhVvMpFvt4UhjagQOLZ0bGzaQ9VXxBT
        X3cU8hDuvGThQenpkUltLhzTzA==
X-Google-Smtp-Source: APBJJlEVWz936J/Qpk9Z39PvdPUeaI0iNevQYNquvaUyh5Nu/7wyfP3QStK7pRROcgVaI9lWpWnNMQ==
X-Received: by 2002:a05:6512:3d87:b0:4fb:95b0:1423 with SMTP id k7-20020a0565123d8700b004fb95b01423mr3015421lfv.4.1688733033921;
        Fri, 07 Jul 2023 05:30:33 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8685000000b002b6ee99fff2sm756803lji.34.2023.07.07.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:30:33 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: qcom: sm8450-hdk: define DIE_TEMP channels
Date:   Fri,  7 Jul 2023 15:30:26 +0300
Message-Id: <20230707123027.1510723-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
References: <20230707123027.1510723-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Declare the DIE_TEMP channels provided by PMICs. Use them to provide
temperature reading for the spmi-temp-alarm thermal zones.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index dabb7e872f38..d07e402eaba3 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -6,6 +6,10 @@
 /dts-v1/;
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "sm8450.dtsi"
 #include "pm8350.dtsi"
@@ -588,6 +592,45 @@ &pcie1_phy {
 	vdda-pll-supply = <&vreg_l6b_1p2>;
 };
 
+&pm8350_temp_alarm {
+	io-channels = <&pmk8350_vadc PM8350_ADC7_DIE_TEMP(1)>;
+	io-channel-names = "thermal";
+};
+
+&pm8350b_temp_alarm {
+	io-channels = <&pmk8350_vadc PM8350B_ADC7_DIE_TEMP>;
+	io-channel-names = "thermal";
+};
+
+&pmr735a_temp_alarm {
+	io-channels = <&pmk8350_vadc PMR735A_ADC7_DIE_TEMP>;
+	io-channel-names = "thermal";
+};
+
+&pmk8350_vadc {
+	status = "okay";
+
+	channel@3 {
+		reg = <PMK8350_ADC7_DIE_TEMP>;
+		label = "pmk8350_die_temp";
+	};
+
+	channel@103 {
+		reg = <PM8350_ADC7_DIE_TEMP(1)>;
+		label = "pm8350_die_temp";
+	};
+
+	channel@303 {
+		reg = <PM8350B_ADC7_DIE_TEMP>;
+		label = "pm8350b_die_temp";
+	};
+
+	channel@403 {
+		reg = <PMR735A_ADC7_DIE_TEMP>;
+		label = "pmr735a_die_temp";
+	};
+};
+
 &remoteproc_adsp {
 	status = "okay";
 	firmware-name = "qcom/sm8450/adsp.mbn";
-- 
2.40.1

