Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F194C789AAD
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 03:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjH0BAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Aug 2023 21:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjH0BAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 21:00:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686CCCDE
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso3217963e87.1
        for <linux-iio@vger.kernel.org>; Sat, 26 Aug 2023 18:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693098006; x=1693702806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzXt286sPhU+yVmzfDKl882XWnXgjzSmy9rWB6wpkCI=;
        b=hxbFxl2SA4TE2bOgEYJOmTDYgKgaBo+/T5pdXgIBXr7RnaYeDuWKyoSJFgqmAMWqF4
         xdUDCjIej49W8wu7KAJXEwmZ31TAXRte16SViK3n6mW4RnJszlleR5jLy+q469qRXOk6
         SkoFd3VXRL3LAI5ZQhdEVmc8mM382A+Wm3ztwzlx+GSpdbbjrQiiy9F31YKX+wyqY5YI
         aPBvMVLvz4bdwcrFuvmnK6g+q2mawoDLsxrKFuGdjW9BI8DMZ4io+MO82rD4wt93L6YU
         Cd4Lxhat+ogRu/4+/77yxbXFpyVhycLyqFErGYy3fzcp69wfbL3lXtGNriRhA4vVv6fo
         kQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693098006; x=1693702806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzXt286sPhU+yVmzfDKl882XWnXgjzSmy9rWB6wpkCI=;
        b=ELekj/BeDubn+JluNXCF/h00AUdczKelSqDrpCU0dtgDreSApFmwkyPufl7cJsyivv
         UieNGfV+Q8iAgxHfhEuH6Go+yrZojb8Mlvyfu7aLs4SoBvkG7eJI0PATWRaZN1TUJlTy
         BWi1ZPMWF6FzJg37cnwGDexYiBBzMy18CkER9o8/+xv/LJs7fKgqd7dBAEv2NEY6s5cK
         pC4/2S8Kb0U1n5fPkDFsvEzSU4iQpzHDhP4YVRAcpY7XV5jxtseRdtBsX/FfyXVFCtPB
         9SYkW4ov2uzdARAc9JzRWwLERnoL8V0cPvBwYy/O5jalc/zaNb8MEYlQqmpxiaXR7EN9
         WcuA==
X-Gm-Message-State: AOJu0YyzdvjPg+jeW4CyXCZCx3zY7Wql36Ox0kQcckV8ptFZm5cji5a2
        Ga0sSCviS86Lc3ROt4EpUb4hag==
X-Google-Smtp-Source: AGHT+IEByNujKNl5zs1G/zJRvv6FCSd+whhLWn+hP15NRohlEiaQyu5W2ck27zhgeilwS3Sv1pX7uA==
X-Received: by 2002:ac2:43ad:0:b0:500:a694:46f with SMTP id t13-20020ac243ad000000b00500a694046fmr3756053lfl.19.1693098005850;
        Sat, 26 Aug 2023 18:00:05 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p18-20020ac246d2000000b00500a08e42e7sm917729lfo.124.2023.08.26.18.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:00:05 -0700 (PDT)
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
Subject: [PATCH v4 36/38] ARM: dts: qcom: apq8060-dragonboard: rename mpp ADC channels to adc-channel
Date:   Sun, 27 Aug 2023 03:59:18 +0300
Message-Id: <20230827005920.898719-37-dmitry.baryshkov@linaro.org>
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

Use generic `adc-channel@N' node names for board-specific ADC channels
(routed to MPP pins) to follow the schema.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
index 8b70d4a59c7b..bf2527941917 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts
@@ -998,23 +998,27 @@ &pm8058_xoadc {
 	xoadc-ref-supply = <&pm8058_l18>;
 
 	/* Board-specific channels */
-	mpp5@5 {
+	adc-channel@5 {
 		/* Connected to AOUT of ALS sensor */
 		reg = <0x00 0x05>;
 	};
-	mpp6@6 {
+
+	adc-channel@6 {
 		/* Connected to test point TP43 */
 		reg = <0x00 0x06>;
 	};
-	mpp7@7 {
+
+	adc-channel@7 {
 		/* Connected to battery thermistor */
 		reg = <0x00 0x07>;
 	};
-	mpp8@8 {
+
+	adc-channel@8 {
 		/* Connected to battery ID detector */
 		reg = <0x00 0x08>;
 	};
-	mpp9@9 {
+
+	adc-channel@9 {
 		/* Connected to XO thermistor */
 		reg = <0x00 0x09>;
 	};
-- 
2.39.2

