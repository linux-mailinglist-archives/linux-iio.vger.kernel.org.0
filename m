Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25BF74B0FB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jul 2023 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjGGMam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jul 2023 08:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjGGMak (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2023 08:30:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7DB2689
        for <linux-iio@vger.kernel.org>; Fri,  7 Jul 2023 05:30:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so28971021fa.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Jul 2023 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688733031; x=1691325031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iOhcYpnzo0XIV0YBU7Aq8iXtwYGavR9eFvXZloUIQ8=;
        b=wGceMGK7XXBwAwlUtHh99qpcolXpleueiazdnHEdysvWB0uA98ZxytfmjJESZXrbuw
         5h6WRAc92f/nIMUuLzjy9oQp5vlQK1JOKCPcT221fnICI6jVM4hwXDwFEhtO7E4m04yP
         4vLZ/uqcnTtYYYcd3s3rjBeRmIPnQWVpT6LeE/WqY9fJeZ4csnr3zAGV8WjKQfjEqDMn
         2e1JOybYDfs/NwfGoP6wfmmOgtiZrRzHkEtAkEL1SsuxS5ySQUz0tFw+Wy/HNBIAf4Qa
         erGllcSCxRIZoSoFAIDBH3N9uB/RVIck771EKrCrxavdDoBnnPbYtyw2CDy9aoEIqKLB
         UKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688733031; x=1691325031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iOhcYpnzo0XIV0YBU7Aq8iXtwYGavR9eFvXZloUIQ8=;
        b=InCjjaAGc8rMv2ogTwL7o2pC3k+O8C/CUewOyDkaGelwP0ACWRchxP0LC8EL4XD3MW
         vzj+rkRA5k/ZOkk2CFt6peyxzVr1FZtCFxJi6Ywquq3VFk5l3AYPhPqnaT6GPJU2487V
         i4kZA5iYnoBbtVfNEty78U0QlEjlsjZboOI7WA9LCY2P45Fp9Db17JNXuN3Lkl5hag5B
         o29wk1swlGfl22/raUD5VA+yHJ42gM+YNT8BHml4NSLAzmLZ359PwyLkD00AjouUwB5a
         4x7+5qBbvgHKJAWRDJjoyp6z5O6FrQES3JbegOmtqC2Hd6w3tBlajlku6jHLxI5U55Vt
         zrVw==
X-Gm-Message-State: ABy/qLZ/g+JW+ZaEludL7CiDRdy1v71vs/XK6SfXyHXtZIHIW6TVX61M
        Pvf2przj7BYX/fta2rDqFkkFFg==
X-Google-Smtp-Source: APBJJlFfJhjGwXsY+2oKhsXoUHiy189s6DkLIg75Za/l/C8VYS/r3oD5tr71GYraH1xRa97GjDARLw==
X-Received: by 2002:a2e:8447:0:b0:2b5:80c9:9806 with SMTP id u7-20020a2e8447000000b002b580c99806mr3430469ljh.6.1688733030723;
        Fri, 07 Jul 2023 05:30:30 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8685000000b002b6ee99fff2sm756803lji.34.2023.07.07.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:30:30 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH v2 3/8] arm64: dts: qcom: pm8350b: fix thermal zone name
Date:   Fri,  7 Jul 2023 15:30:22 +0300
Message-Id: <20230707123027.1510723-4-dmitry.baryshkov@linaro.org>
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

The name of the thermal zone in pm8350b.dtsi (pm8350c-thermal) conflicts
with the thermal zone in pm8350c.dtsi. Rename the thermal zone according
to the chip name.

Fixes: 5c1399299d9d ("arm64: dts: qcom: pm8350b: add temp sensor and thermal zone config")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8350b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8350b.dtsi b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
index f1c7bd9d079c..05c105898892 100644
--- a/arch/arm64/boot/dts/qcom/pm8350b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	thermal-zones {
-		pm8350b_thermal: pm8350c-thermal {
+		pm8350b_thermal: pm8350b-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&pm8350b_temp_alarm>;
-- 
2.40.1

