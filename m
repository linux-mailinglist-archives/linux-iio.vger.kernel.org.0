Return-Path: <linux-iio+bounces-11900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD69BBDDD
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 20:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FE5283490
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C518CC00;
	Mon,  4 Nov 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbzx6VrD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C563AD2D;
	Mon,  4 Nov 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747910; cv=none; b=VcfcyBZb4PtJTpVYCdARa7y9sTkq13Z8c2CDoWaOTu3p1Taqrg4i1AnKtN8YH60M7HpAJr6udeJzgA52QwZ8sMb2RFebksUh7pZrNZSFX3RreBhim6IL2Q9TV62ANZYYW2dYobMKKieiqf6HX6K0sBxOSQ2ML7EIm6pOUFljHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747910; c=relaxed/simple;
	bh=S9jUQmg8h331e2Pj63NU2N83tcF8B984es3Wedsa/lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVP0PvzK44ugSEm1T5opmSbDdXBUj52Mg4n72o3P45t+RN4trgnVyuManLP8lI6ZjMxHW6TZJrdVGnK+rl7LFQ1oNGRFdlhwAhJXl7LAtYZd7vpDdxEd4rWY5906JbccILZSWFa2RJGETLaDdXoW5StEoUuIU4Qbk9+3+vdTHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbzx6VrD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460ad98b043so36536091cf.1;
        Mon, 04 Nov 2024 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730747908; x=1731352708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unJ9b+rts3y1hb3/PAxKDJbTMcuKEtEuGFYI5bvW40k=;
        b=bbzx6VrDTBD/vh/ksEzbQb8gmhPgQDM5rgjkjg3tMgc7IBR2agJqmEVgd6qK3z1W+Z
         Si8O8bKsaWwczBBssLAAI2ntckkgF51MSgUJj9Unh9ZkWVBSmbOt61lbUzWrSNZqEqRO
         YycCHfnH24T/qJkKgfUduEm2/mhethQkn/tX855M0kVTYXFMYP+xgMZOua69An+XSEHe
         2AQgidJcYuyv8kVndgLXzn+qr8Doo38jspi5R1sWjfir0fYJJQ2McEyP1hFZiShAikig
         +InsMAfa9blE6deAuQ2lB614bNlnL54sVC+vB32DfAqVQs7Iw6pvLwLV7qYZe2LoyYCJ
         n4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730747908; x=1731352708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unJ9b+rts3y1hb3/PAxKDJbTMcuKEtEuGFYI5bvW40k=;
        b=icbmxweGA+G8kZwAArArHj5mxujgP5FqSqbDT266ucn59sduJrNAWeGeQmQnNF/2SU
         t9I3I9OrmJGu/qJpmVeUGRPM+yi66U//xoZL81TVrOC9RnN58ckmMxWaF2P4Oi4RPhw3
         M6tbHjZ/lI2hrJrCx1Wi8v2jq9QNbXR9AwJ+hojGG/1m8hiOS5zZT346YNBrqTYrs8aT
         0+LUE1ZjE8loa33Vqe9S8daK6HRwqRGnpBzAHcvZf3zZU5DntcScL+MuAAvXEDl/BDhJ
         WIZ2Fj8NSltoI/Wu4RnkvPjPM/BZNahACE8Z3qzEcK8g30TQXlWazNSl0G/7LtvHrdsy
         25Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWsl1XX3Am2BePaz4skbYh+UCTtc4gqGH+mNtEN4+5dVScZcDSEe5DMgpxSrIwOSPMoqAFZUqRmAoCtUU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIgk+3qBUOOAbG8MgkGHUYR/cmVa/3n9b+KL6i0N1iImzZdaV
	Dnj+ReNOjX+yS3lkGBwXpVhB98e0YSuyMxZlEC9E0N6pF8AkhESd
X-Google-Smtp-Source: AGHT+IELakiFzr59EudtKLiMCMHPt484NaNIT6Kjz/ZSDX/NpW9fjmCjoWrs7c/vQ4eTZTNX7i2z4g==
X-Received: by 2002:ac8:58ce:0:b0:44f:fb6d:4b2f with SMTP id d75a77b69052e-462b6e83130mr228655931cf.23.1730747908255;
        Mon, 04 Nov 2024 11:18:28 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad086e55sm50174351cf.7.2024.11.04.11.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:18:28 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: wbg@kernel.org,
	fabrice.gasnier@foss.st.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	Jonathan.Cameron@huawei.com,
	benjamin.gaignard@st.com,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v2] counter: stm32-timer-cnt: Add check for clk_enable()
Date: Mon,  4 Nov 2024 19:18:25 +0000
Message-Id: <20241104191825.40155-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() in order to catch the
potential exception.

Fixes: c5b8425514da ("counter: stm32-timer-cnt: add power management support")
Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Add dev_err() to indicate the reason for the error code.
---
 drivers/counter/stm32-timer-cnt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 186e73d6ccb4..9c188d9edd89 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -214,11 +214,17 @@ static int stm32_count_enable_write(struct counter_device *counter,
 {
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1;
+	int ret;
 
 	if (enable) {
 		regmap_read(priv->regmap, TIM_CR1, &cr1);
-		if (!(cr1 & TIM_CR1_CEN))
-			clk_enable(priv->clk);
+		if (!(cr1 & TIM_CR1_CEN)) {
+			ret = clk_enable(priv->clk);
+			if (ret) {
+				dev_err(counter->parent, "Cannot enable clock %d\n", ret);
+				return ret;
+			}
+		}
 
 		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 				   TIM_CR1_CEN);
@@ -816,7 +822,11 @@ static int __maybe_unused stm32_timer_cnt_resume(struct device *dev)
 		return ret;
 
 	if (priv->enabled) {
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret) {
+			dev_err(dev, "Cannot enable clock %d\n", ret);
+			return ret;
+		}
 
 		/* Restore registers that may have been lost */
 		regmap_write(priv->regmap, TIM_SMCR, priv->bak.smcr);
-- 
2.25.1


