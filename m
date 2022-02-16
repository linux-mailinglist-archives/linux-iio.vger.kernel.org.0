Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A834B8AC5
	for <lists+linux-iio@lfdr.de>; Wed, 16 Feb 2022 14:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiBPNuS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Feb 2022 08:50:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiBPNuR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Feb 2022 08:50:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F61B2ABD13
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t21so4028917edd.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Feb 2022 05:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=F3NHurYKl9o/EgwB4OsNpjY3DQ0nR2AJS3FAZf5AJXz4+QxWPtugQ3X6pN0uUGO5FJ
         rOjXfQYuCwQP7MdRa2RgTwcanJAphfvNlRPBaR4MGxRZeCcMo57l+dfkzJYsn2jBrhf8
         atY4ciLDt/5mS0V4nDqSlcde4UwBeOBKwXv26aiVdu97cOHT4x+5zV1NM+NqiLrDZSmU
         vXsj3cCaJGkKflzcgkwMC0TY8fPrIOGElZLzsN6ZMKUdswEUlmwF5t9OpsN7s+9QcWGN
         YglwX4/z3zXky9rU9sxhULn7QpdYKbMPBp0cV1XScgUmuLEba4/lWoHncNHdUSa0UsRK
         KBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=60je+LDflCDSpm+PbhIAk73PJa9MombVHWRyiPaaQWE=;
        b=EKLyn++xkpYeAy31cqDG8nD104rNr5wOmAAmVWl2RPUz9QDOaEUszGKsY/deRHsqZC
         hhk1Qfo+G7Vz/tG6iYVnyhAw8Ytb3o6HCYjncWwKZF8PbsMubw/qvIrGO9Ed+1/7OUXS
         ZCZj8k6ZvenMY4FL0O/7Wu/Ra63j0gTPgS2r6dpZfnmE/RtUKHbKl+086IpoCjReykoR
         2suopgAaI3zugmt9Ez9ff7fVJcglNrCy40C0wT7ou7bNkwg8RIra+2DgIy2SY85iJuqM
         Ok3N8Z0VKSiZzcrL259AAB+FL/Hh+utnJpZzIVCbKCUuMTkuvNaenCy4wTktrfcdtUu2
         RrpA==
X-Gm-Message-State: AOAM533JsJ4K+cIc3B05VEq/qgEC3ZFlmU+PWZ7Gx2eceIEEmXRJioFl
        jtUhPUjpcIUK3p9Hy+5zkrnhvw==
X-Google-Smtp-Source: ABdhPJyOUq+UAaJkZIbN2IrhQOUWJFe3idwcENbpbYMWGivse7wyW6wUUyGn7bALOnLM3Ty3MaMRWQ==
X-Received: by 2002:a05:6402:176d:b0:410:80df:ff8e with SMTP id da13-20020a056402176d00b0041080dfff8emr3175720edb.324.1645019392147;
        Wed, 16 Feb 2022 05:49:52 -0800 (PST)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id o20sm1711996edc.84.2022.02.16.05.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:49:51 -0800 (PST)
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
Subject: [PATCH v7 9/9] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
Date:   Wed, 16 Feb 2022 13:49:20 +0000
Message-Id: <20220216134920.239989-10-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216134920.239989-1-caleb.connolly@linaro.org>
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
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

