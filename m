Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7413048587E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jan 2022 19:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiAESe3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Jan 2022 13:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243073AbiAESe1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jan 2022 13:34:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4653C061201
        for <linux-iio@vger.kernel.org>; Wed,  5 Jan 2022 10:34:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso3785936wme.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Jan 2022 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VD8BhFQsi1gAqizHlVU3fMYSmPUmL03WAYruvW0snE=;
        b=jpVf08kdAsBCv9Fz1w8bfk9PWLBPKBl9jzBJsjlc/B4Uw7dDo0HJSxclDVckHXkeD3
         Ed89gG+Jy8B1f91gnAnK6RzuZLwz0ZhG81vZtGMNGWsSxWZUQ5u4S47VBWtdSdemKV+7
         RwswXCHkcHRQYKVEI4zbckjsWmLTHwE/KAenkOaaOe0r1lJjjyvYbTNZWONLAks9O8Lt
         4uGuc0gatO2kVE6unROXpwzYYmXIGOePVlp4CtzONKWd93tjEamYaKBTH2MmHPohAaA9
         qCQ5AWZJlIhH3Jm0eJFA5tWi54zYiHkUoBXtom4WrMPFzCYjWC0WFN+RnCe6ksonxx0t
         vJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VD8BhFQsi1gAqizHlVU3fMYSmPUmL03WAYruvW0snE=;
        b=DX0NwbyXrZ/VQHR8e940FeZ17pM93D3xxGiyitsQB2tbAbhtRBHbhyX9YLP1mRhg2u
         JlJyHhKcHfgkmMBWPvkckegkDg7HGtt4/nZAnOgBxOOzXYPVR1WIqngnK5yIgthnE4Yv
         vIg5lJ71BuJLBPOfIDPnkAPVZ69VCx36YXDb7Xj8vwCIx8UGVfqpn7OJFIq7HvcnpW6h
         frzEN3fS7zmoQa9IuND8Vw2YjOs0dM8qfNj0W1i2L4IZtatEEahoo70VG+KUoGqpKGpr
         vKLICcqmLhJtrlAJHaUxwehFIeaEdNZe6/OafbQx+IxQcv7s50hHNIPsLiTxMpr/qsQg
         LjrA==
X-Gm-Message-State: AOAM530Mu8GqXPBCOFNj7z7J6WoqG7b2uscnCbQBD11xDHgBvRDYeNK5
        FktrlLRJst4icENcpTsM2Cwiew==
X-Google-Smtp-Source: ABdhPJy+Q4ONifaTzqm79p0+0JVlKoXxb6uoAj5vX4aBkr8L4Bh2cHFh9pPBz3ji3n1eSLAiTW/vWA==
X-Received: by 2002:a05:600c:4013:: with SMTP id i19mr3986331wmm.93.1641407665309;
        Wed, 05 Jan 2022 10:34:25 -0800 (PST)
Received: from localhost.localdomain ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id o1sm3272215wmc.38.2022.01.05.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:34:24 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: [PATCH v2 7/7] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable RRADC
Date:   Wed,  5 Jan 2022 18:33:53 +0000
Message-Id: <20220105183353.2505744-8-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105183353.2505744-1-caleb.connolly@linaro.org>
References: <20220105183353.2505744-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enable the PMI8998 RRADC.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 580d4cc1296f..481132b0cee4 100644
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
2.34.1

