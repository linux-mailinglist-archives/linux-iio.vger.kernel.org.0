Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B54B77D6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Feb 2022 21:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiBOQzj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Feb 2022 11:55:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbiBOQzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Feb 2022 11:55:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2180811AA1F
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:24 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1835024wmb.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Feb 2022 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=E8LzTxcfY5dvseeiGNkFNuW/pys92VspPUtpDNKtcH3sGc6k52/VSIyMRJH4y7xagk
         PxP40ovf2K9GSmyKh8FHNJlqjck88RDO2A9Uy5pbXf/TcBoDKobX9GH49syJ6BEWYisb
         zM2xICQ8xTRrMM+gZJxY4F9VJ79Fxdl8ZV7qV82ckXHTpJGmMb54bcS8glshWktNFos7
         a5vThGwfCrYK2aVJcTcGHGw0H7/IjaJVfMd69Mimu7UIAqkcmso5kNuP0hLcPTSO1JV8
         52FlDy313lgoLu+069H6aZ92dxgGIDOsqGaf4jNCgFXuwKcnqQY1YZE8Y99hnL55UE/x
         KG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=k+vo0urR2qDocnvTg6d1dkZJXS6+AcVIlSdHlck5VLeP4Qh5EbLyxAtHWWG4UzZX8k
         UGaVyOc0W8f0+WGfv4SJ83qP0J3vrJkQFkyQgy42Mv74qTSJccyAO1y4T/JrWk/+yBGJ
         Jq75bevqTMKQJwDw0NW8jxupe8gLuIBPz7Hr/3NuJvD7GHGrpsSzZSLAuVyphAGhUIjf
         TmC3pRNnHQm70citdOJVqwHShQs2PWLIuwhxSQ5O98DP4rAJYO4MTiRDjmO6xXg8MH84
         mRGddAbkGThlnjjIeDftuaoO1xd2f/EAz+I8kO+HYHfI3yMVYtK8VEDQk4tMCa0U1FzN
         rY+w==
X-Gm-Message-State: AOAM5310MEKQAET6vND1jxvZXpae+MVQW4+xKNeZdQ4roKFBmh+5YZLn
        Y1Ksp0t4AMv0ukgh5kYX18o2Eg==
X-Google-Smtp-Source: ABdhPJwXNiBcYGsZ0PKorDAIu7CJINJdxe4YqpSdeZUY2ocDkL8ErZgh9CYmBgDtQnjZmBAYCZ4MQA==
X-Received: by 2002:a05:600c:220b:b0:37b:ec02:32c4 with SMTP id z11-20020a05600c220b00b0037bec0232c4mr3913488wml.11.1644944122741;
        Tue, 15 Feb 2022 08:55:22 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f14sm15373652wmq.3.2022.02.15.08.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:22 -0800 (PST)
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
Subject: [PATCH v5 9/9] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
Date:   Tue, 15 Feb 2022 16:54:56 +0000
Message-Id: <20220215165456.1205583-10-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215165456.1205583-1-caleb.connolly@linaro.org>
References: <20220215165456.1205583-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

