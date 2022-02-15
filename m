Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D224B76C6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbiBORKb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 12:10:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiBORK3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 12:10:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DD511B31A
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1864131wmb.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 09:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=e95A44tpHIjq1YsdKuKzU5OONEu/+yXCT8kuOp2UiKbTHYKRM+skWvxv3kT6tlQHi9
         kuAkvUo6I8mngxLzdV8aD0WTym4+cnEDeGOr8rm379aJHXW+OsbXpcZGxlmRRsonaeYQ
         UP+qOTQ30HOWhwgisLlBU3j0+2ZF0q2MkYC61AfUlHJ8/5+IEc61vkm+X78YHa49P2Bm
         jB6R+qZ5bMMAv6BV8HDvvXyiBnCig0k9n7N96HGKQ91cLjYNjrD99g8zEWz01bex8eXn
         HzviMayuNMZ3ZpNneZpsJ0lmKMaQqY8YZjrMOLjVKlCfGHoGm5jXoqQBPSXqylZ+MS6v
         At3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=cJe4H53kWzJz65czLeOBAjFACTJwaiE/0v8yTaZKKv7GcH3RyGb9L5tjX2hbYfhZRE
         ObmxkgoCx0QyX7xjqY0bZ5fbjmmCd7k4M1EIg+iaCmMs8xqKwiLyWWWE0r7wAHB6WYeR
         W9eKJc2R62/lNJYuAogNU8AKEX5nNMGYSEcClcfLOO4HfafFo9RciPSyr9u/xa3ffhnK
         az+pZlaKbr7Qgy9kINoIVql67sDbEOSAnL2pOfDXgeDUHE5wYntOwkcNCkKHqIpR8XbS
         osp+e8FAK4t4FGcljj5Yv7gj+LaflqXfOUZXm8hi0Jd0ASLgJvwmrSh1Q+bTItGZQvuV
         qI1A==
X-Gm-Message-State: AOAM533sUZn+1izGV+IUVYtlPryoim6e2Ud4pTkvU6r3ntEE1najfj2a
        MiC8wSteG3VY+Q5WyknOQQcNMg==
X-Google-Smtp-Source: ABdhPJw0YbHf61twQt8zIjpAB6CwQlGiDquDN/ZzgdBbTGfVK01KJvsAZyMdB3byIr6GGeUOd7b30Q==
X-Received: by 2002:a05:600c:2e53:: with SMTP id q19mr6132wmf.189.1644945015688;
        Tue, 15 Feb 2022 09:10:15 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id g5sm15558474wmk.38.2022.02.15.09.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:10:15 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v6 9/9] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
Date:   Tue, 15 Feb 2022 17:09:51 +0000
Message-Id: <20220215170951.1233375-10-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215170951.1233375-1-caleb.connolly@linaro.org>
References: <20220215170951.1233375-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the PMI8998 RRADC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 367389526b41..b3b6aa4e0fa3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -312,6 +312,10 @@ resin {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 	qi2s@22 {
-- 
2.35.1

