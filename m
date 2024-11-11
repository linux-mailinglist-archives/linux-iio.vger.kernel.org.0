Return-Path: <linux-iio+bounces-12155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD5D9C45B7
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12100283792
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8D1AA7B1;
	Mon, 11 Nov 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMGDTxr8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69441A707D;
	Mon, 11 Nov 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352779; cv=none; b=VvB2cC8u072YE4Vz4XnsH1evkUKUr2PIUSlL1bzRAeTB8ydqSNfruOTXfIc7GuByjxDrO1al/4Yz9fGq9AyNQAp05ALQecrqBge6eLzmdE0Rm81qt9OUUjm+LPe3ZR6eWSVqSnlnt4bw7xdCv2w0SFprCjrLK5S7ySE2PutAjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352779; c=relaxed/simple;
	bh=Dx6/d9sBvhAkLyAjgIerUL6Iig8GaroNuSSlB607hgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGSH8BEGJAMGorWcHQWpB3Uc6FPlzewE4Upcd3Xrj9cGZwTuaWnE01M2JICGdRRB6uPO4pyikXXC3m7Q0srmUycPgbiaaVyUHgUAEdMg0U1jeFF1HdY4g5znVlvqRdrONDro8c4eCIugWGgPSne3u1Ha4SHmuxEgQ6V9uVnRD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMGDTxr8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b14df8f821so452821885a.2;
        Mon, 11 Nov 2024 11:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731352777; x=1731957577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQMnATqh+SGGYH0r7raKXS0Fsq0x/ZjmMKT6ggo6pts=;
        b=lMGDTxr8dK0ZExdg5KRoXDLjX9Wl5wu1zyq5S4jTznCfWDF9HP59aA5SDVXBzsAhz5
         PHN+7LNbADtlEv7OLNYWR7dO+IyQn377mHYl6lwJy6pb7d75yqOz52C+O5SkML7cqk7x
         CbZVhUrPAyedXs/fzWIXDT4aVwUCn4SFtJPmOOVLBzDjz0PDz/46aSkN53kKefol2Ac5
         aDQs6CSlIrRya9kjfjZKDA9Ai43f1VgftfYZGLRLoQ+px2HvEE04PpEcDUGih876kkkL
         YPYoodHqzP7qX5Tv1awPM/+ieqerbZiqVY0LXLvzhxHt/iO2Uyd2vhRoCOSkLy6uJLV0
         aB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352777; x=1731957577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQMnATqh+SGGYH0r7raKXS0Fsq0x/ZjmMKT6ggo6pts=;
        b=n8Dcu4MdGVFKVQmQNIIuj36aihoYkCtHgBDufZicYzqrDImomGZx3eax54vXCALApn
         W1h4NDGrL7zlHkNkxWe9tbm2Tz/xDZmerAbyJ7B3SXasiBk4aPtu80Rg64YzlX5Y97cD
         KRrP+WgKdwu6DPAlusNrmh+zMQnI0ULpjawH403TcsojfXrUlS6HMdkrtJOcVvR5PWD1
         wpTr0nsgJai3kmkHwSoH8h82TZPSEtD9HYKrAE9ieUvylEu0t3W6t9WBHUm8jtt0uwXI
         z9hlgS8oEjaONRwZ7lBo9+rG6Kd4Pg5InrklsZuMne1PbVgChNW44rguRqT8I2hOhmyF
         bPBA==
X-Forwarded-Encrypted: i=1; AJvYcCUE4ASPBtdsRPTglqwdlHVjGYWWK8tPpg351x9Hegbjn84r061Y5lf2lrRInphvI5XvI1pXD54i8abMF1ai@vger.kernel.org, AJvYcCV9w3YOxMsBUo97iDpxrYvNsMst+GTyUNM4WJfnQYZbtpFjrutO5uAp8rfIRg/scjcrP6W4jo/7AP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvja3d6pUZ/m528ZBj2HY+93CQk3s3naQi0axK1fg5vnomf/Oh
	HBwE2qtFU46cl+JxbvRqwxwbqwsVOJMO+iM4iAJu+HK9rHyPa7b+
X-Google-Smtp-Source: AGHT+IEcOVSl3jFobC5PUujK1odI1lKT7irYGmOBBfsWM2du/Qe8Rbme5AUeOm0Ku5j48EPEYBDbjA==
X-Received: by 2002:a05:620a:1787:b0:7b1:49a4:d1e2 with SMTP id af79cd13be357-7b331f2e94amr1783569085a.54.1731352776900;
        Mon, 11 Nov 2024 11:19:36 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acb30d0sm524995885a.94.2024.11.11.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 11:19:36 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	u.kleine-koenig@baylibre.com,
	tgamblin@baylibre.com,
	fabrice.gasnier@st.com,
	benjamin.gaignard@linaro.org,
	lee@kernel.org,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v3] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
Date: Mon, 11 Nov 2024 19:19:34 +0000
Message-Id: <20241111191934.17231-1-jiashengjiangcool@gmail.com>
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

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v2 -> v3:

1. Simplify code with cleanup helpers.

v1 -> v2:

1. Remove unsuitable dev_err_probe().
---
 drivers/iio/trigger/stm32-timer-trigger.c | 64 +++++++++++++----------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 0684329956d9..9fb4f7eefa86 100644
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
@@ -150,10 +150,12 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	if (ccer & TIM_CCER_CCXE)
 		return -EBUSY;
 
-	mutex_lock(&priv->lock);
+	guard(mutex)(&priv->lock);
 	if (!priv->enabled) {
 		priv->enabled = true;
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret)
+			return ret;
 	}
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
@@ -173,7 +175,6 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 
 	/* Enable controller */
 	regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
-	mutex_unlock(&priv->lock);
 
 	return 0;
 }
@@ -307,7 +308,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	u32 mask, shift, master_mode_max;
-	int i;
+	int i, ret;
 
 	if (stm32_timer_is_trgo2_name(trig->name)) {
 		mask = TIM_CR2_MMS2;
@@ -322,15 +323,16 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	for (i = 0; i <= master_mode_max; i++) {
 		if (!strncmp(master_mode_table[i], buf,
 			     strlen(master_mode_table[i]))) {
-			mutex_lock(&priv->lock);
+			guard(mutex)(&priv->lock);
 			if (!priv->enabled) {
 				/* Clock should be enabled first */
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret)
+					return ret;
 			}
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
 					   i << shift);
-			mutex_unlock(&priv->lock);
 			return len;
 		}
 	}
@@ -482,6 +484,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				   int val, int val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -492,21 +495,25 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	case IIO_CHAN_INFO_ENABLE:
-		mutex_lock(&priv->lock);
-		if (val) {
-			if (!priv->enabled) {
-				priv->enabled = true;
-				clk_enable(priv->clk);
-			}
-			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
-		} else {
-			regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
-			if (priv->enabled) {
-				priv->enabled = false;
-				clk_disable(priv->clk);
+
+		scoped_guard(mutex, &priv->lock) {
+			if (val) {
+				if (!priv->enabled) {
+					priv->enabled = true;
+					ret = clk_enable(priv->clk);
+					if (ret)
+						return ret;
+				}
+				regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
+			} else {
+				regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
+				if (priv->enabled) {
+					priv->enabled = false;
+					clk_disable(priv->clk);
+				}
 			}
 		}
-		mutex_unlock(&priv->lock);
+		
 		return 0;
 	}
 
@@ -601,7 +608,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 				 unsigned int mode)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
-	int sms = stm32_enable_mode2sms(mode);
+	int sms = stm32_enable_mode2sms(mode), ret;
 
 	if (sms < 0)
 		return sms;
@@ -609,12 +616,15 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 * Triggered mode sets CEN bit automatically by hardware. So, first
 	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
 	 */
-	mutex_lock(&priv->lock);
-	if (sms == 6 && !priv->enabled) {
-		clk_enable(priv->clk);
-		priv->enabled = true;
+	scoped_guard(mutex, &priv->lock) {
+		if (sms == 6 && !priv->enabled) {
+			ret = clk_enable(priv->clk);
+			if (ret)
+				return ret;
+
+			priv->enabled = true;
+		}
 	}
-	mutex_unlock(&priv->lock);
 
 	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
 
-- 
2.25.1


