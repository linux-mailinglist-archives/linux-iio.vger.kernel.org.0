Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1899F74B0F5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jul 2023 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGGMal (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jul 2023 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjGGMaj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2023 08:30:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD22686
        for <linux-iio@vger.kernel.org>; Fri,  7 Jul 2023 05:30:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so14154951fa.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Jul 2023 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688733030; x=1691325030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inhVw6e4Q9ddaoZo0733sYa5ABh3cj99XWicDlFL0J8=;
        b=iS3I4RRDKKQDUR5KVYwdIk59LzwosQixQvzwHs9Az5vPYz+sIzaNLk7XVV1PDsLLNS
         2O1cjlxmn+V6zd84e7eci/+6pokoPaveCZWD4dh++U9+yAGav6s18RwMU2AqKewdMl01
         6W653cQeKOhkw8Fj7FuW/GMf6DijdAUPhJggTbaYsitvDvlOOV9dD2jojHnlBnJ5X51+
         95zi74BZl9E/VG3+kN7pZwgTsmmcPxpmhovhjmgApVjg47yg8OHcadjTnzFuD4KBXM01
         LHFalsXVoir1PAROVmhXCfd71fR5oNDYQ2B9BhzVcj5sDse4XoD3esQ+9oV3Acla7TmL
         Wqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688733030; x=1691325030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inhVw6e4Q9ddaoZo0733sYa5ABh3cj99XWicDlFL0J8=;
        b=SFYYLKT2nWOo8uFGB7J4TjPBl8Lq/UeQghPMQ+Gf2x0/rrr0BjLmryNfKuKP5fuWVf
         hozekS+rK01rn7nTjp3OKXjfx9Ez/VzgIwU1zUE/VTGOoryHQx0bJj6K+THYY/7ZfYKv
         poH2dA3/KqHu6sW2lLEn9vjY2J8f3Fh6IcugjSAjXUS9sqyz0VDOtRQd3+WTM7KKGcuW
         9hneZrC4wNrBbEu1TvRLTms4FiOy0JgSi2O3rGz0EAnf7j9Y3v+kAlpgBRxSpopcTeou
         d3WUbEDYteeTc3CTIT56JD+OtK1hE+1nkHWptNL/SyYbf3JY/BnLWevqYWzM3++XZMvG
         l6mw==
X-Gm-Message-State: ABy/qLbbbT/grNr6JV76hWQBYI0qQ2qIZxjU0QfHIqehO5v2m1DAXE0E
        6PW6UoKB1Sm3DR7mIHcPCtihDw==
X-Google-Smtp-Source: APBJJlH1KET23/8d2OCdFO837yIRhU6Bhpw62gPSeCNa/Y1/3b6xgMMa/izRXrkuBDREqW8yECHPtQ==
X-Received: by 2002:a2e:3a05:0:b0:2b6:e196:68c4 with SMTP id h5-20020a2e3a05000000b002b6e19668c4mr3838534lja.39.1688733029996;
        Fri, 07 Jul 2023 05:30:29 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8685000000b002b6ee99fff2sm756803lji.34.2023.07.07.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:30:29 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 2/8] arm64: dts: qcom: pm8350: fix thermal zone name
Date:   Fri,  7 Jul 2023 15:30:21 +0300
Message-Id: <20230707123027.1510723-3-dmitry.baryshkov@linaro.org>
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

The name of the thermal zone in pm8350.dtsi (pm8350c-thermal) conflicts
with the thermal zone in pm8350c.dtsi. Rename the thermal zone according
to the chip name.

Fixes: 7a79b95f4288 ("arm64: dts: qcom: pm8350: add temp sensor and thermal zone config")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
index 2dfeb99300d7..9ed9ba23e81e 100644
--- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	thermal-zones {
-		pm8350_thermal: pm8350c-thermal {
+		pm8350_thermal: pm8350-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&pm8350_temp_alarm>;
-- 
2.40.1

