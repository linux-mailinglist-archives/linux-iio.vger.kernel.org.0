Return-Path: <linux-iio+bounces-12050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D739C2644
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 21:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4019B20DE7
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1E1C1F3F;
	Fri,  8 Nov 2024 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTrJPVMV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB971C1F33;
	Fri,  8 Nov 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096546; cv=none; b=kLbNYfAgWrB7vrrjB7ztn+rWlaI74wFUT5rNkTYVzUpYBxW4FPTxOh7xtZ4gzddKLC4IQ7dRf4JHAO08WKZvzZlXt4RlR/ZhLCpic2RlLpstYD047tAPwb2qxowtdx2MSMRuLQMBH1MwjBLdXbVOUTknTizU6kIdwVgFkxKKRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096546; c=relaxed/simple;
	bh=cVHXkXl4YfbFHHGVd+O5NWSSdeuYOemYbz9sSO834Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jy7L7ni2YOsWrJgKWV3bTQF0VFQXvLYn0sTVD+uMyu60Gp/Op42CkXWcAzChNfbEINq/f41bOI5l3kOSSOs1cCCaFU+ONt9gR8jKlfA8lGJa0CRAg8v9OvAkH1wuCdLxpjp856de/hxsMTIeP2PSCdz3+XSkACi/AZqMXMnkZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTrJPVMV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609c9b39d0so16330491cf.1;
        Fri, 08 Nov 2024 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731096544; x=1731701344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NI6P3TUYrkoyoEc/tfD3lrh0bzVj5BXDH9t+6MLHSl4=;
        b=MTrJPVMVbNXNipptKiCwEY5MpthTkp8uqntGqSpH87rFVOgcEHKiFgTBk4BQRE08ht
         q7hzRA/uz4sCK0RH4n7NCZFnwAveN/Bk0x463GennLAThjJ0TtXZXr0yxz/YkPNt37+1
         xg2mNy5fhtd23zgVcfoSa3XAZI9F7hJAI+Bmu3i0vGFxoKlOfmaomsLM1ygwn9EC0ED3
         4VoSF5wFKlUIuDdS/OrIeXPzXIKrBgS9PiKrXs+MIlH+J+HsUBg47QLp8OvI+fRFLHGC
         CxnFd3HfsUK6TeE7h34CDEqTpxL5XYRzozPMX3bExGWQ9iyXcBa0UmFkbJ8/GT7ez4kl
         mufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731096544; x=1731701344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI6P3TUYrkoyoEc/tfD3lrh0bzVj5BXDH9t+6MLHSl4=;
        b=D13Ip0VWPpm1b+AtJK8C4nc7tZubK6ABqi1I5zuGnnQRZcjQpuTyGzF1rT0gOUIRKH
         qkL2dYG3vmoHo6yfQ4KICT4Fsikmcek6l7xfhbxyxhze+JnRoY5UKLpg2OOWvbN21O1z
         VrHp9xJ8diHH28VD08WMG6Q6hrV9/TPAA9iSSF6TyLYWxpJy/ispsGCxZr7ePF1xD/3L
         S9yUKARhgsTdfRX3fZDRyHEb+UlNhzOrK1U2tkP1NFW9P3EX/QFV14E8eYnADmZP8NGU
         1WzPUE0DTWlAyufDiOlZdJzv+hg7IGdJDbWit7bZDmZv1TBriA9N/s0/nzny0J5+xehw
         OXyg==
X-Forwarded-Encrypted: i=1; AJvYcCUoDBvbCZGkgnbBa4T8s4iBUfYGi39RzjM9Rt527tyjwnKGfpI9bw4fPyM8O94BWG5IRXbZ2V74xcVtDyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuXHEMnNh6Y+JH7Z+tOEO0rHYUqe/jIGtg1TZhukPwkxmMv92
	4UyBf0Uic8RGY3IlhZg+AAq+tcSu/GiD6Hl8UGgA6MWCUl0GlF2O
X-Google-Smtp-Source: AGHT+IE82TZXwTUiZGRTAp/L5/S3ZlnP1aQ28alBcXNmIEDpLw5fXICy0ok9tKG1jh+N+mTRfrzA/A==
X-Received: by 2002:ac8:5a91:0:b0:458:23fc:f345 with SMTP id d75a77b69052e-463093ecfdamr48531501cf.38.1731096544010;
        Fri, 08 Nov 2024 12:09:04 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff47c162sm24151271cf.53.2024.11.08.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:09:03 -0800 (PST)
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
Subject: [PATCH v2] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
Date: Fri,  8 Nov 2024 20:09:00 +0000
Message-Id: <20241108200900.44727-1-jiashengjiangcool@gmail.com>
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

v1 -> v2:

1. Remove unsuitable dev_err_probe().
---
 drivers/iio/trigger/stm32-timer-trigger.c | 32 ++++++++++++++++++-----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 0684329956d9..e1e077122f73 100644
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
@@ -153,7 +153,11 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	mutex_lock(&priv->lock);
 	if (!priv->enabled) {
 		priv->enabled = true;
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret) {
+			mutex_unlock(&priv->lock);
+			return ret;
+		}
 	}
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
@@ -307,7 +311,7 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	struct stm32_timer_trigger *priv = dev_get_drvdata(dev);
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	u32 mask, shift, master_mode_max;
-	int i;
+	int i, ret;
 
 	if (stm32_timer_is_trgo2_name(trig->name)) {
 		mask = TIM_CR2_MMS2;
@@ -326,7 +330,11 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 			if (!priv->enabled) {
 				/* Clock should be enabled first */
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret) {
+					mutex_unlock(&priv->lock);
+					return ret;
+				}
 			}
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
 					   i << shift);
@@ -482,6 +490,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				   int val, int val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -496,7 +505,11 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 		if (val) {
 			if (!priv->enabled) {
 				priv->enabled = true;
-				clk_enable(priv->clk);
+				ret = clk_enable(priv->clk);
+				if (ret) {
+					mutex_unlock(&priv->lock);
+					return ret;
+				}
 			}
 			regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN);
 		} else {
@@ -601,7 +614,7 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 				 unsigned int mode)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
-	int sms = stm32_enable_mode2sms(mode);
+	int sms = stm32_enable_mode2sms(mode), ret;
 
 	if (sms < 0)
 		return sms;
@@ -611,7 +624,12 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 */
 	mutex_lock(&priv->lock);
 	if (sms == 6 && !priv->enabled) {
-		clk_enable(priv->clk);
+		ret = clk_enable(priv->clk);
+		if (ret) {
+			mutex_unlock(&priv->lock);
+			return ret;
+		}
+
 		priv->enabled = true;
 	}
 	mutex_unlock(&priv->lock);
-- 
2.25.1


