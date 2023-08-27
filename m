Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14578789AB7
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjH0BAp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjH0BAO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 21:00:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0CCE54
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50079d148aeso3190205e87.3
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693098007; x=1693702807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgscUjE5yDYSGHC1956h5azSC53EgKvpe5p9UzSNGuk=;
        b=Ltz2C1HJNu7vP+v9xWUs3JGPdJ6MtfPz4e6tiLD4W8mO4hKhoqxcLl4A2i0yIzAeZo
         qCVPLH7F74n4/T5FgaVwi7oBXLPmxZPmj0N6SkCXa0M54OY2dv4U4Y74erESnpDZNIS3
         I1fpxsjkYaSoLYMPMYTyVqWIsu3KvAYEmcm+iq96I2UbQ71XtwG05H69g7QxdFSTxNAz
         G2bF0oXmUlvG/062tOEuh1mLafvsO0SVO0CTDcC3QDczy4Hc7/les9aWW1m1sswAU2mv
         4xhK902bzFuRjCPEK+DfXs7A3ZiiY7x0kNncwK/CnHh3k+quaOq1vDxCHrsjH1WmCEE9
         QvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693098007; x=1693702807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgscUjE5yDYSGHC1956h5azSC53EgKvpe5p9UzSNGuk=;
        b=DdvWa4b5mTbdG8CmKUoQvKHaEI8xO2KaZa/Cn9jwm5+f1Up9nVffhhkBKgb4rXArcJ
         iKl0a4uHCirfAPtZk2BQ9EM+Sr4qQ23i3ykLpEql8F64tqZ5oqxxsr3GICLzRh7Tpa9n
         VcEbKucfekTneeUQzDYY5ffEuoqSH0JC27X1qwuBhYZP2Y7k0jJiR7j2A1UdO0JoT6s1
         DpDeT8XfgKcBglJnk07ZhavmnnGpBxcn1+JmGOxyyP1b7oLfBi6Au5lw1KJFQzs6vHfr
         BZXQIZt9cufJHWseZsmjXKJy/RB6T0dETM6BwHqQ0ZC8Eq6q1D+qjmqMyvYbZ7CLKSgG
         jg9Q==
X-Gm-Message-State: AOJu0Yxqu7ztI4gVuNIiWCeolvTSX8d0Wh4orEADRk2bkXgCusRiw3Yd
        hFlPq1WWWZCtbCpGAKw8pvbigw==
X-Google-Smtp-Source: AGHT+IEfU6g8xk3TlLFDQZKmBEJCe3koZ5101OaR+MtGsHgNyPucXI5am8COezn5/591tL/dLkZAug==
X-Received: by 2002:a05:6512:3e9:b0:4fb:8de9:ac0e with SMTP id n9-20020a05651203e900b004fb8de9ac0emr13229291lfq.1.1693098007650;
        Sat, 26 Aug 2023 18:00:07 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.18.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:00:06 -0700 (PDT)
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
Subject: [PATCH v4 38/38] ARM: dts: qcom: mdm9615: drop qcom, prefix from SSBI node name
Date:   Sun, 27 Aug 2023 03:59:20 +0300
Message-Id: <20230827005920.898719-39-dmitry.baryshkov@linaro.org>
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

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
index 07e712e890f6..b02336bd8370 100644
--- a/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi
@@ -258,7 +258,7 @@ gsbi5_serial: serial@16440000 {
 			};
 		};
 
-		ssbi: qcom,ssbi@500000 {
+		ssbi: ssbi@500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x500000 0x1000>;
 			qcom,controller-type = "pmic-arbiter";
-- 
2.39.2

