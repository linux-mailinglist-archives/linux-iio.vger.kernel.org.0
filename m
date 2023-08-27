Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E25789E08
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjH0N0K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjH0NZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 09:25:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63313E
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso3733493e87.1
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693142729; x=1693747529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7ewwDA5rK2znaB44N+h4kM3uTy6kez9qLlohwFRQDU=;
        b=PhRITrkCHy9xXeC4xMUovqjUW0kGvDzAFWEOUQ+fpLStqRAe/VmjOokuUEDCQd6nTU
         HRqWTOzIara7zgKN2sEQbubjF08zHvNADSyoW1tjA6xDp7gQhfr6Wc/gZEiCc9nLoABK
         yxpah5rmzqjxI5ITK5I4LWpw8dZkcaUHYWlZXdOf9FGnDzpssV/7HgteanA07+Zkkd5m
         UdvEzXFaJizIz8UOqL0aA+qGniTtt4Nwkfahi/TGho6PMCWVhnZWdzbGuUA6wgPxwP+/
         f6Db+nx/rF2d8FmHufmFnkfH6DmuxrYevR4BWPY4c2h8zzJX5lnHBRbifV0SWTz4fv6O
         ilqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693142729; x=1693747529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7ewwDA5rK2znaB44N+h4kM3uTy6kez9qLlohwFRQDU=;
        b=iJ0nHBqbcQ20uS1t7IipSdxoAIoKlzptfB4RiJNtKbO964FNVq0T06kNgYn/B5OlZ7
         70dD7NLC6WeYh04MK87nM0drxuqBg9ibnyRbE9prFjFVlynkN9G7fwFlt+y+tWgje51p
         /Vlrke7Cz9hOVYhAK3/4YrLlXSE/iFYRX5FnGdS0V/ZvAp8WzjzoPyEg6OXOc3curKrU
         lUKzB1OOH88ulzShq974BojZ4oWgd3C68NBj4BubJ0q3ehABLaLgS9gLgB4eDzXLG3xM
         uZqH1UIOPFkVQ6EqgPA90ayPkOohBGztNtTbu6DAF7CCaZQ341yt3K4Ypn0YB1X3oqgj
         8oTg==
X-Gm-Message-State: AOJu0Yz4ZeWHzyQgqFPGPf9T0BG5POu+h4/8a+c/PyZjp6CmKZuWBgUc
        1HGN68r2ssVz5W6IhBr9VffeKQ==
X-Google-Smtp-Source: AGHT+IGfyRNdx7XScmxKKNYPtWH7EVnunOlJNWZM3AapeV+8RTTrAAj8dlVnpCn4asSwcF/pfnyPxA==
X-Received: by 2002:ac2:4bd4:0:b0:4fd:c84f:30d4 with SMTP id o20-20020ac24bd4000000b004fdc84f30d4mr18752550lfq.36.1693142729486;
        Sun, 27 Aug 2023 06:25:29 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t9-20020ac243a9000000b004faa2de9877sm1142040lfl.286.2023.08.27.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:25:29 -0700 (PDT)
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
        linux-leds@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 03/37] ARM: dts: qcom: apq8064: correct XOADC register address
Date:   Sun, 27 Aug 2023 16:24:51 +0300
Message-Id: <20230827132525.951475-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
References: <20230827132525.951475-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The XOADC is present at the address 0x197 rather than just 197. It
doesn't change a lot (since the driver hardcodes all register
addresses), but the DT should present correct address anyway.

Fixes: c4b70883ee33 ("ARM: dts: add XOADC and IIO HWMON to APQ8064")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 516f0d2495e2..950adb63af70 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -738,7 +738,7 @@ pwrkey@1c {
 
 				xoadc: xoadc@197 {
 					compatible = "qcom,pm8921-adc";
-					reg = <197>;
+					reg = <0x197>;
 					interrupts-extended = <&pmicintc 78 IRQ_TYPE_EDGE_RISING>;
 					#address-cells = <2>;
 					#size-cells = <0>;
-- 
2.39.2

