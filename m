Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A5789A8E
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjH0BAj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjH0BAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 21:00:08 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473611AC
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso3239330e87.0
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693098002; x=1693702802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPuoBnKtEFgCdxUoOIFl3Fx3Gw36qHVcIvB+5tSO88E=;
        b=hdxZ1ukOwIUNxZPRfe636/5gmh6q+CBV8ZK23WSrlq3zRrfoczBW/fzrrs3BWKPF8y
         4wf9CaK1SgVX5sBMj2N0DYmIHuLIysORPf8ycLfKIxOkFzL7wS/0PCSG6g9uXm+9/p8C
         7+OI9Hb7qLn+63MLB0xKXuVo1CPbXECkf796piAW6Ywu2E5E1LHYxuceugvfabRFbXjh
         pth2DYWnDQYvYtz7ztPRZ9gG8oHGEoxofDCV+Izk5Q2JZ0GKN3Mb2QENCconpjPwQrXn
         XnwpQtzhuNqfeUTC4nsLS2VzC6RZaXab5IxWuQR6L4HiD6A9Bo1i0JzK7yosC67aE6VT
         BP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693098002; x=1693702802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPuoBnKtEFgCdxUoOIFl3Fx3Gw36qHVcIvB+5tSO88E=;
        b=NSOamiziKxQ9snc4lCQgHJzWpg4wu7tlawi6D4iyWYcAMq9XQuEL3t3S+5UWwEGjmf
         9avfudWv3srLrrRtAZLLfHwvy81ZHdPqNMWS65eeFOXPev9tpK3HAJmrS8KGSr1qAfyU
         YlKpxDn/rNsZWP0DpY/maGnmmpOuE5N/fY/ZE8RbZk+JCJxPT9pjacrrluuioZc6DnUT
         /6xo8xHdxj6U0f7ZhmOcgfqYs1jY4MGQGvTze+6i/IRKWbbBoB9u+H9Y+0ZxgLe7n0/D
         +RXNayW2M5ehQE5ZtrOdpDOD3NAz8Szh6HnVtd8VQBKJJJNmOaBPnYxj6s38tNCxY+Fx
         b5iQ==
X-Gm-Message-State: AOJu0YyYpmw4vlD37yQNppsiOVtuI0ZN2/yHQEAXO8QfqC2nVBMLMQT/
        YQf4ULmmqMjoxzbDUtZmo2VxrA==
X-Google-Smtp-Source: AGHT+IEfwOCN9sG8SIH1ak7yLq0QHqyBFkzTTpVBAmCsilqIu6Z9dh3h4VBV7K3ppIL9QQjIPPJ/4A==
X-Received: by 2002:a05:6512:b8a:b0:4fb:96f3:2f4 with SMTP id b10-20020a0565120b8a00b004fb96f302f4mr19500539lfv.51.1693098002683;
        Sat, 26 Aug 2023 18:00:02 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.18.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:00:01 -0700 (PDT)
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
Subject: [PATCH v4 33/38] ARM: dts: qcom: msm8960: drop useless rpm regulators node
Date:   Sun, 27 Aug 2023 03:59:15 +0300
Message-Id: <20230827005920.898719-34-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
References: <20230827005920.898719-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The set of regulators available over the RPM requests is not a property
of the SoC. The only msm8960 board file (qcom-msm8960-cdp) also defines
this node together with the compatible string. Drop the useless device
node.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
index 774f507fa25a..f420740e068e 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8960.dtsi
@@ -200,10 +200,6 @@ rpm: rpm@108000 {
 				     <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "ack", "err", "wakeup";
-
-			regulators {
-				compatible = "qcom,rpm-pm8921-regulators";
-			};
 		};
 
 		acc0: clock-controller@2088000 {
-- 
2.39.2

