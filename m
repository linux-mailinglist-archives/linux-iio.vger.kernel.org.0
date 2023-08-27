Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFC789A87
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjH0BAN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjH0A76 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 20:59:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB8F7
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50098cc8967so3399621e87.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 17:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693097995; x=1693702795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm6eWdkXRtbkiE6yiEQEBoDe5iM/WM4eQNZl22nI37Q=;
        b=fYsQQ5f9D4Tl1la//og32+7TCw3xIPNxtstBJHBz/BjEfWsKMO8JM7Wtf+/pgrkd/a
         5XNMqKs5O877rDA4brflvNpxX6U1zVfPEV3XSeKtpfRlFBTOwbGJpgkbtLgVEa6ZeR7s
         4B1yalxEPVh+e0Q9kjBC7j5jeUcHKjofkJESiJH+ws85Lta5/PP+6dAqUSF5ZVVyu3Fz
         fEwalUvucUoKaZRa+l8Yqewm14gvmUeLp4op/YnMxurigwI/vglon8IGfyztoqRz3u36
         dX317Adg0lnOg6N0Od/hehm8ZjE5V8tm99H4f7peACFwCDouQrLRf8XCRl5HRgIr3zUh
         pajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097995; x=1693702795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dm6eWdkXRtbkiE6yiEQEBoDe5iM/WM4eQNZl22nI37Q=;
        b=lISvxfGFxOzR81j6GZ02bZr0JuQiPVlUi7S47tLKv2RSWgxHfu/xF02W99b5dMnTZ4
         ZrZcIGmfZzUGD5/XEQwzeBUXPH2JgknlycUvA1IOSB0crAkdcKc0pQkZuFVe55gmIUvE
         6nXkmRjokuQLIel/WCBODFs8aAVQxjoW10Yk6Nsr2/31CtsgYusGtBcdFCoiZS3OreB+
         4cKnZpg0amFseQzKAKOzO+QB5QADttwC37iOUwOYlwQ7ybefkF7f3CfxVCh/JSwaLbbb
         AXbPPcpuAq+Z23igAf08Fe6boSMmPr8S0akFI1KiTWaEhAedjnClVrmNR93AYaWNtOmY
         EZjw==
X-Gm-Message-State: AOJu0YyoVqk7YJawe2kWzjLWPzKuMD865l17uAzWNA3YTZGnOzBMeNxW
        RoXJCsS+WKh29EFNluZOMfGc8w==
X-Google-Smtp-Source: AGHT+IEA2hNGmxXgiibIwZ/Ztepkxcc5PGN45Y5PRuGqln1C1aV05bNQazb2Fqmn2Iv4lNbMkRgL2g==
X-Received: by 2002:a19:5f43:0:b0:4ff:70d2:4512 with SMTP id a3-20020a195f43000000b004ff70d24512mr12268981lfj.23.1693097995155;
        Sat, 26 Aug 2023 17:59:55 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.17.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:59:53 -0700 (PDT)
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
        linux-leds@vger.kernel.org
Subject: [PATCH v4 28/38] ARM: dts: qcom: pm8018: switch to interrupts-extended
Date:   Sun, 27 Aug 2023 03:59:10 +0300
Message-Id: <20230827005920.898719-29-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Merge interrups and interrupt-parent properties into a single
interrupts-extended property.

Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/pm8018.dtsi | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/pm8018.dtsi b/arch/arm/boot/dts/qcom/pm8018.dtsi
index 85ab36b6d006..22f3c7bac522 100644
--- a/arch/arm/boot/dts/qcom/pm8018.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8018.dtsi
@@ -18,9 +18,8 @@ pwrkey@1c {
 			compatible = "qcom,pm8018-pwrkey",
 				     "qcom,pm8921-pwrkey";
 			reg = <0x1c>;
-			interrupt-parent = <&pm8018>;
-			interrupts = <50 IRQ_TYPE_EDGE_RISING>,
-				     <51 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&pm8018 50 IRQ_TYPE_EDGE_RISING>,
+					      <&pm8018 51 IRQ_TYPE_EDGE_RISING>;
 			debounce = <15625>;
 			pull-up;
 		};
@@ -38,8 +37,7 @@ pm8018_mpps: mpps@50 {
 		rtc@11d {
 			compatible = "qcom,pm8018-rtc", "qcom,pm8921-rtc";
 			reg = <0x11d>;
-			interrupt-parent = <&pm8018>;
-			interrupts = <39 IRQ_TYPE_EDGE_RISING>;
+			interrupts-extended = <&pm8018 39 IRQ_TYPE_EDGE_RISING>;
 			allow-set-time;
 		};
 
-- 
2.39.2

