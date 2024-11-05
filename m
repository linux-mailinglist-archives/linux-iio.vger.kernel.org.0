Return-Path: <linux-iio+bounces-11928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3059BD5E4
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241DA1F238C9
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1860520D505;
	Tue,  5 Nov 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWlhPsqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507021EB9EC;
	Tue,  5 Nov 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835143; cv=none; b=XLnmxH9FcfRzR870r/FBu4bj5gVsKTcvNHjHFkhr2x0bYoBA8edz70sVDfnWCk0dNVJNEZoeCYyXJW2ejD11g7ZndiqfsEHBDPBxflIzaC6EbqfKzVaVO755QH2MIu2qXF+PGi3gs14xrtu/k9ONCy9VU9RlGnKdJvr7MC/6Vls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835143; c=relaxed/simple;
	bh=qLEWU4xRhKVleppQ9yRG49K89MpB2qshrxMMpXqLLkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sJUTTmMJXxJHo8LJb9/g3Zz4CU2cXmplPZMMXFSgDkp6CWFHu/Pk+KicWrQ1s8F3UAyYTehItRVmQyRi14Pb3MSfZ/sZdwuKZmtkPj1IWGthaegZ+KzsszA2XN05wouyHANg0SzOLnqumASW+tkgVCuHxULx4V6rkcXp4UXIvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWlhPsqF; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b157c9ad12so368964885a.1;
        Tue, 05 Nov 2024 11:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730835141; x=1731439941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlpXLUDiuAj4Ax3s/8PaCa808KyyiZFwFmndcMeabmA=;
        b=PWlhPsqFmUP6ayMAZCJ0b+H1wLRIVpa288Z48AKsx8Td7ylVCigDPVlMRgqsuFN5xF
         7+GBIDiAB0kUXQBCveA2Qn3kJkoTknzPVs+JJPTbBqyclZZ04NJcSyyeoEWAZYPqRAlV
         zKkD2o7ADgzpBzUcNqgAx/++LrU9u5FsJY9msLFwkxD/CAKHuYCQ6JSGcYx7JLkvFwlW
         SdRDyVcOaZFrFZVqTsApHhlfmpY0Ftbgcq/fgm4/7sZKW3ALYne76R/KLWWFhLYNsmig
         3LXUEut+A6f4g1HvF7QC930ftcY4f6OxJNLpxMyw4E9m+3BeXnMOAJ/mgSzOpPu1th4t
         2V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730835141; x=1731439941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlpXLUDiuAj4Ax3s/8PaCa808KyyiZFwFmndcMeabmA=;
        b=nuRzIVBHMqOsgRj7b/nD3MMyqL+jpkaS50HMXU9Qi8/Lo8RYhxVnDbTkqt3uiQN6Uu
         3PMPkYiJAHLijmDabTQlcYNbCmYdCHLURm4uOlHbSGS8fzbFrI0dZhoPjBeNlELIwy2h
         2vZVjM/U49vd5vwcypB8frJEopAZQFlTqNV9KsCgqe9k13LH3NtLrBPg73wByzE1KjFD
         shKfBMEx3RxjbqLzPO1j4pUcWE3uZEW3gG3OxFbWursApjqY3QoBBh0vxZq/YwYlku8F
         g7424a/hg7XWG4XwnYi9ebLvLHVQZfL0+fcRkRLm3ExUN4daK/oTmfWp5tRLj5K2sMN0
         ZDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUThfin3EwSsuosmXvQBsrF/62J/cp+MPzSFXZjRPoKNXpg5rHh9xE+QdwYH7rpSoaH7D8Y0xKBfw8wO6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzre9rj5OlsGyCcVpaBXq8LjZF/G2KBPun3DR2BRaz2ygksdPIU
	MULJucISvbiKSHBPhm12yXsrTvesily5VQquRreZ9Zo4r1jpJLiM
X-Google-Smtp-Source: AGHT+IHmPYcPWfZhwOxujigyXrVRSB8kRoNxKABpVBwVCQzAOZBWznyCKjCQL89t1FiTLIwjVZF9zw==
X-Received: by 2002:a05:620a:14e:b0:7ac:ae32:286a with SMTP id af79cd13be357-7b193f041d5mr4080201485a.34.1730835141086;
        Tue, 05 Nov 2024 11:32:21 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a9b991sm553343285a.127.2024.11.05.11.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:32:20 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	u.kleine-koenig@baylibre.com,
	tgamblin@baylibre.com,
	fabrice.gasnier@st.com,
	benjamin.gaignard@linaro.org,
	lee@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
Date: Tue,  5 Nov 2024 19:32:12 +0000
Message-Id: <20241105193212.2082-1-jiashengjiangcool@gmail.com>
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

Fixes: 3192ade7b6f6 ("iio: trigger: stm32-timer: enable clock when in master mode")
Fixes: 90938ca432e6 ("iio: trigger: stm32-timer: add enable attribute")
Fixes: 93fbe91b5521 ("iio: Add STM32 timer trigger driver")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 40 +++++++++++++++++++----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 0684329956d9..0d5bb808c61d 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -119,7 +119,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 			     unsigned int frequency)
 {
 	unsigned long long prd, div;
-	int prescaler = 0;
+	int prescaler = 0, ret;
 	u32 ccer;
 
 	/* Period and prescaler values depends of clock rate */
@@ -153,7 +153,13 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	mutex_lock(&priv->lock);
 	if (!priv->enabled) {
 		priv->enabled = true;
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret) {
+			mutex_unlock(&priv->lock);
+			return dev_err_probe(priv->dev, ret,
+					     "failed to enable clock: %d\n",
+					     ret);
+		}
 	}
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
@@ -307,7 +313,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	u32 mask, shift, master_mode_max;
-	int i;
+	int i, ret;
 
 	if (stm32_timer_is_trgo2_name(trig->name)) {
 		mask = TIM_CR2_MMS2;
@@ -326,7 +332,13 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 			if (!priv->enabled) {
 				/* Clock should be enabled first */
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret) {
+					mutex_unlock(&priv->lock);
+					return dev_err_probe(priv->dev, ret,
+							     "failed to enable clock: %d\n",
+							     ret);
+				}
 			}
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
 					   i << shift);
@@ -482,6 +494,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				   int val, int val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -496,7 +509,13 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 		if (val) {
 			if (!priv->enabled) {
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret) {
+					mutex_unlock(&priv->lock);
+					return dev_err_probe(priv->dev, ret,
+							     "failed to enable clock: %d\n",
+							     ret);
+				}
 			}
 			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		} else {
@@ -601,7 +620,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 				 unsigned int mode)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
-	int sms = stm32_enable_mode2sms(mode);
+	int sms = stm32_enable_mode2sms(mode), ret;
 
 	if (sms < 0)
 		return sms;
@@ -611,7 +630,14 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 */
 	mutex_lock(&priv->lock);
 	if (sms == 6 && !priv->enabled) {
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret) {
+			mutex_unlock(&priv->lock);
+			return dev_err_probe(priv->dev, ret,
+					     "failed to enable clock: %d\n",
+					     ret);
+		}
+
 		priv->enabled = true;
 	}
 	mutex_unlock(&priv->lock);
-- 
2.25.1


