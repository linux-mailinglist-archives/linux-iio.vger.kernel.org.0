Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C839F6D3487
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjDAWIS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjDAWIP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 18:08:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43730FF0D
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:08:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 20so26677361lju.0
        for <linux-iio@vger.kernel.org>; Sat, 01 Apr 2023 15:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680386892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AggToq1LerLWW8VVOtxwYKPnVhm1iAj3sd5znRZbW7E=;
        b=b3TISBuujfIMLfND7fbsWNW3TLzKR+YacZ6TIAbqjKcaa9vbFl+Lo41HZKzBzFv9Q3
         JWnOor3VFJqrGoQiwjhUrLkC2pnCfKV3bhuD5QjX1ACrX2ls2NBGkW42WOZi6H0kI8Ol
         T/h/NnzLHnPszfzTnbi90Sa2yAx9hP6UoXPFZR5iysNkgaOjfo86IzBWvAk1XyMJw52r
         XSuJmeM+ZsfVxAbHM2ObZd6f5sozQh/TZLI0RCRmtrWPkUIFdHJvODe3CmFGhzuHtnuq
         VT232aQkNtJBsvaPg7OjFmpyn9m741+ArVLddbOOD/bb7rFyOIwq1TNmsJhhUJ99hkbI
         5ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680386892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AggToq1LerLWW8VVOtxwYKPnVhm1iAj3sd5znRZbW7E=;
        b=5m9rrE1NXGZRU43VxHeW0u7+IIey/ki4JqL2RSXQzpRsq3iGnN0od2EEi7KPWI/dmH
         FIDHsXGUjMu/ErmcbyQ4LleEcjDBSbGNqoV40jClfezagHOgxBAOu4XwIpIUT64vM84C
         j47b47NsRaOmB3Jrq1cLI2pV/JlHifhyTkalVuuDDh58IvvllZhhVXzkyZK4FxhG6Z3i
         vgFMaWbqOYe/e5ckiAXYARmoXK75ImfLODjlWjoUAXZeoEpuIwLkEhZ+MHRieexgKxCN
         UT3SloZB78lrEC9CSlbRpY7Ql+GyKar+2SitSVd+mfMwMdDEURkmXJDHdTlPq2jaxyk2
         eOiw==
X-Gm-Message-State: AAQBX9c/gCldsNcOIm+AMiNGrjmwBNj9whMzH6aIVPGb6ROv93FPq6/U
        5v9mjILPqo4CoatUBEoWvEQqWw==
X-Google-Smtp-Source: AKy350aiQGt1kwAWWmJxnSdDFlBt+Wu2X9kjyZezW2VbG9k6HLGbnlhvPf7VznQkv4uihVW8Nqz33w==
X-Received: by 2002:a2e:988a:0:b0:29b:d235:2c50 with SMTP id b10-20020a2e988a000000b0029bd2352c50mr9219932ljj.25.1680386892586;
        Sat, 01 Apr 2023 15:08:12 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k17-20020a2e9211000000b0029bd4d0d3f2sm997590ljg.33.2023.04.01.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 15:08:12 -0700 (PDT)
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
Subject: [PATCH v2 02/22] arm64: dts: qcom: pm8350b: fix thermal zone node name
Date:   Sun,  2 Apr 2023 01:07:50 +0300
Message-Id: <20230401220810.3563708-3-dmitry.baryshkov@linaro.org>
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

Correct the thermal zone node name to remove the clash with
pm8350c.dtsi. Remove unused labels.

Fixes: 5c1399299d9d ("arm64: dts: qcom: pm8350b: add temp sensor and thermal zone config")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8350b.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8350b.dtsi b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
index f1c7bd9d079c..95e971b80ccc 100644
--- a/arch/arm64/boot/dts/qcom/pm8350b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
@@ -8,19 +8,19 @@
 
 / {
 	thermal-zones {
-		pm8350b_thermal: pm8350c-thermal {
+		pm8350b-thermal {
 			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&pm8350b_temp_alarm>;
 
 			trips {
-				pm8350b_trip0: trip0 {
+				trip0 {
 					temperature = <95000>;
 					hysteresis = <0>;
 					type = "passive";
 				};
 
-				pm8350b_crit: pm8350c-crit {
+				crit {
 					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
-- 
2.30.2

