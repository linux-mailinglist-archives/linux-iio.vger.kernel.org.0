Return-Path: <linux-iio+bounces-12169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72D9C4931
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D75B269C4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19F175D48;
	Mon, 11 Nov 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEvBQt68"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755716C451;
	Mon, 11 Nov 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363795; cv=none; b=ZlPVZnzx6Yxy/YNw43t6ImRBvySeWjze3GI4MqQxmxioDxr4HkeKYnru7wKtshnx2zkqS5gf+8ik1WQdZJ5Q2CQ4Xu7SEpnJIFN1KKJDTjp3E+h4Cxa+RnOMW5V2xdHBaS8snnQENW2M7b9/fBhLoIIBOwbGANfGI51x0cFlHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363795; c=relaxed/simple;
	bh=SrKi8yEGLUqZQbWobBL3c2MT2C7UeatXwBHABdEFGhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RWwwd+FHwQlAntRKlN0m+pwthBX/ARd/0RDLt7GrL8ZFK+GwOr7rGV47y63iIZKLg6MQF+BCIkjzJmZLL2AG1HBFeWZSPA+Q3YrJHlWMXBZzdExXAJi+vytkv75aHTQrKCb8jrFGbbL59XIEXE72QTIUDA5hX/tFqtuyClFP7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEvBQt68; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1474b1377so397880285a.2;
        Mon, 11 Nov 2024 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731363793; x=1731968593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKJrUNekn+fLC6kP93590FUWGJ6YXqoOuHlp1oOaerI=;
        b=nEvBQt68GetpvsAgayPafODA007uYY5EjW3K4JpXWS6nGTxNiPHOJ3DxQ7Z7fOF/WK
         kJSEhYnY4kOV/0gi496V3zOGokBWyR+WvDuBYRqBc5ckdwBEAgJyKoexaxFZSuRcso4u
         VACGm4vCErSyP/uvpZ9dbIMuDEY86euYtbvpRh+x+bLAZlALOKBC+TdI/XQ+ZOAIdn80
         Nq/mYVlmsWGipSCPZz0Y+3F1QLv6G3c4bJK1JrqSgq5IBWq9SwklQSjdicjeMfN0CSmc
         mFCj0uIdmcUpCsI1n6yUNTK4NxUl0+NgWhNGhq6hha9QuDJcREL7RvH9DzxrKhtW3/IC
         yEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731363793; x=1731968593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKJrUNekn+fLC6kP93590FUWGJ6YXqoOuHlp1oOaerI=;
        b=hTo9yuVVzjS9PfJs7hkXzyE1Buo/0/doDRhP4YoEPzy1W8LWx5B5o4Y+/3PKvUS6vf
         rlhrDWldeaoOK6MvVRK/XORD5h7UZunUJn+y+spIi/gpNgGnmFlbf2eDkENF18Ddlgba
         8Plfzg9Dly+9XL8lqekwAnumnvrxfEpTTJ9Qo1bWu+Z0xAzGAeVvsc63IEf6PdyT7VQD
         gMGRhlTS/E5qaTtvb46Q5N6nHBPu0IvWyBdDWW4joQ1dGch7fuGglMel2MlcGO9AJekx
         XHs8/0iSEF2VcMnkxRTcOZBIoz5XcR0RDeoGcwrd/kqiIXcJmPYE9Xp28RycPg3Wl40N
         KQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX33th3BHdcKwQPbdE+wQlXTwtYfYcEI6pP7NlLRot4G6HMu3j9vX8FZn3IMO2D+Kv0TSVnIHSiGXsjRMRW@vger.kernel.org, AJvYcCXZzBx/HAzHbO6jebvLii5MrHPV3rvI1HYdg5xkBp0bYV2ls3LDgoLyYjpkZ5VwmT6BZUx98PQ8GpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBu5rXEooSnMmD268iz13d5+r/IYDEc6mLL5jsNmWzNWZbS1OK
	QHkneuI9vp7P4wwGFyFALffFO0UJT87kOvy6ak9EzuS+94npElGl
X-Google-Smtp-Source: AGHT+IGFThbZRbYxwToYYeuVu+7TuIAwrVPuAA2eieBL7N+tsgVpKFWjBEQC2tvJmKh1er5auG0BMA==
X-Received: by 2002:a05:620a:1aaa:b0:7ac:b118:a732 with SMTP id af79cd13be357-7b331dd2fb1mr2162857285a.32.1731363793253;
        Mon, 11 Nov 2024 14:23:13 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dc06sm535599885a.12.2024.11.11.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 14:23:13 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: dlechner@baylibre.com
Cc: jic23@kernel.org,
	lars@metafoo.de,
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
Subject: [PATCH v4] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
Date: Mon, 11 Nov 2024 22:23:10 +0000
Message-Id: <20241111222310.12339-1-jiashengjiangcool@gmail.com>
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

v3 -> v4:

1. Place braces around the case body.

v2 -> v3:

1. Simplify code with cleanup helpers.

v1 -> v2:

1. Remove unsuitable dev_err_probe().
---
 drivers/iio/trigger/stm32-timer-trigger.c | 45 ++++++++++++++---------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 0684329956d9..d599d50fbb3b 100644
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
@@ -491,12 +494,14 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 		/* fixed scale */
 		return -EINVAL;
 
-	case IIO_CHAN_INFO_ENABLE:
-		mutex_lock(&priv->lock);
+	case IIO_CHAN_INFO_ENABLE: {
+		guard(mutex)(&priv->lock);
 		if (val) {
 			if (!priv->enabled) {
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret)
+					return ret;
 			}
 			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		} else {
@@ -506,9 +511,10 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				clk_disable(priv->clk);
 			}
 		}
-		mutex_unlock(&priv->lock);
+
 		return 0;
 	}
+	}
 
 	return -EINVAL;
 }
@@ -601,7 +607,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 				 unsigned int mode)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
-	int sms = stm32_enable_mode2sms(mode);
+	int sms = stm32_enable_mode2sms(mode), ret;
 
 	if (sms < 0)
 		return sms;
@@ -609,12 +615,15 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
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


