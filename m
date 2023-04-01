Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782B46D34AB
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDAWI1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjDAWIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FAE2953F
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so33422315lfu.5
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5ruaswPTr4aTQUaqOUNDdtLf7Fy/weN6GQ93n/n+pk=;
        b=wUS5/NeTMj/GEX9U9VbtMXGTZS5sR18rzgRXIWNtONvEkF1tirg/cNAfXLIy+VCRiV
         J37oJXNMj/zalgk85iGGzUTFV4qa0SGpVpcs+gKm0sI8m2jp62Vv+pGYqLwnDb0nw6iu
         GW7cX0e5BssInpeHmfIGoUViP893Q8Pvga8yLwdJ2CFeo7eVvRr9Lkk8ai+Sx/INif7K
         VcgI8ZKx2QvYTQ1hIgJmcWjNkHzgRPeY7voKqgMovMIYhn4Y2DxNo/oF/NQD1ilyrCTU
         XxEg/f0fi2plYneOCCe5xP4q5h3P+2KSRdBHmCiaLjYjn26STWKHxRYI4OoZAToBxOi6
         /Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5ruaswPTr4aTQUaqOUNDdtLf7Fy/weN6GQ93n/n+pk=;
        b=3d7B4ZigOHZQJHSX0p7Cr5j0feByaWQcLFpE9pyMtMRBKmHSQCyUHm73MGrEyGqvuI
         K9mnVynf9wOV3tcBZq3s/GFddHhvZhRcljjToXVH5fkstQQoDfPSovH1uRa2+eZk89fv
         hn8FYp0SBeZjWYk6d03ilQkgItdg2RTXgTKjDH0O8ZD7vfdRP2vsuu+GNLqe6/sO1tWy
         4vjAa2CCSg4gSy91RmmvKhRFx9qznzYmN7ly/IFpsMNp3LWRcR0lGZcnFFfzDMs/53dZ
         By6hnunFz2o+WLuUO4I2RNnjYY7xtLYbhSCyz0kf7Qmqyx9JBIifHO7mJ9wp+im7Id+v
         8jvg==
X-Gm-Message-State: AAQBX9eLX7xi+6yUHw0pMFeShqqu9AOXqBaCFI0IxJ/5MGFnWP/WZFX6
        kebVchg81IVm2XiweResnF5wlA==
X-Google-Smtp-Source: AKy350avgAeQ5DR2a8K7GdxlOow51bxZGCa1YIEYOP2BtdmZG42HCzEOQEsCttNlfrMgsNEmN0zH8A==
X-Received: by 2002:ac2:5499:0:b0:4e9:c792:c95b with SMTP id t25-20020ac25499000000b004e9c792c95bmr8316305lfk.42.1680386899714;
        Sat, 01 Apr 2023 15:08:19 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:19 -0700 (PDT)
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
Subject: [PATCH v2 13/22] arm64: dts: qcom: pm8350: use interrupts-extended for IRQ specification
Date:   Sun,  2 Apr 2023 01:08:01 +0300
Message-Id: <20230401220810.3563708-14-dmitry.baryshkov@linaro.org>
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
pm8350.dtsi to use interrupts-extended propery.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
index b7b14b5fe67d..b05bc01e3ef5 100644
--- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
@@ -51,7 +51,7 @@ PMIC_LABEL: pmic@PMIC_SID {
 		LABEL(temp_alarm): temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
-			interrupts = <PMIC_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&spmi_bus PMIC_SID 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
 			#thermal-sensor-cells = <0>;
 		};
 
-- 
2.30.2

