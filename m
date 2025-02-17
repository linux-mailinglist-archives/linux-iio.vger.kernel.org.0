Return-Path: <linux-iio+bounces-15695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF37A385FC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6317A247C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64700221DB5;
	Mon, 17 Feb 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUKv8Xhv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245FA21D58D
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801934; cv=none; b=O/WuEZC55wAp6+hsCBe8kFoySt2PZ8CdAowkSZkO97UQ5HYGQG5PwvtYrky+Idu6fS2NerNBvzjUDq9K5RBaPArTkGlwQW4glm0+sKEd4LWlOEjG5s2T55kk0Jbn0hiWDVFamUhvIIXi+ON/gFQoEihFK0hMFxcYG0NFvGoRe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801934; c=relaxed/simple;
	bh=XyEXje+7UoTCQ0Z9bQorD4JlxA7uXHLICJKwueCU6Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iR9g7WS2x1O9dHp2aURo35GfjNouVEvCoyqT/KsDfviL26KS0ZJTITmxfRh1Tc3L++nn6hF6l6Do5wMSY6rhMOiV9pIszZu/69uusx7QOlVb92TLMwXinBa2HGrIRjVtg2b1DN986Ds1tTY6rzJq0FcX+k1KPtgEEKm/8NCodYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUKv8Xhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81493C4CED1;
	Mon, 17 Feb 2025 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801933;
	bh=XyEXje+7UoTCQ0Z9bQorD4JlxA7uXHLICJKwueCU6Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUKv8XhvFcg5Ip1z2tm1GQhh1MTdEFnkf3XpujHRwHu8uSr5N819ELSniJqiPPcf4
	 q6uACLRaPFkHSInO8egINfINTu/WsjyOyGBaVOJd5RLQGMhahR3txcDV7z6+iJ6DMG
	 Lib02Lx71bSRCJCObiGG6E0X7EU6WlpQ3EHGp91hdAtkKIus+fUyvFhTnsr8tyBXrP
	 XSJs3nordk3FXfG6f/O6Jf263J11wLEorSO6y52KY0dT+lvofhjC/FNxJTvGvbqL+O
	 di2ZnhYb+QVHYr/5Wze5nBc7m2sz7ItfE6589QBOkDVPhPrPGLZmhAzUWT99cHik30
	 vo184FRo4sLeQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Phil Reid <preid@electromag.com.au>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Marek Vasut <marex@denx.de>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 22/29] iio: adc: at91-sama5d2: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:22 +0000
Message-ID: <20250217141630.897334-23-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217141630.897334-1-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 70d3dbb39b25..694ff96fc913 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1914,12 +1914,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = at91_adc_read_info_locked(indio_dev, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -1932,12 +1931,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->type != IIO_TEMP)
 			return -EINVAL;
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = at91_adc_read_temp(indio_dev, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 
 		return ret;
 
@@ -1967,28 +1965,26 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
 		if (val == st->oversampling_ratio)
 			return 0;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		mutex_lock(&st->lock);
 		/* update ratio */
 		ret = at91_adc_config_emr(st, val, 0);
 		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val < st->soc_info.min_sample_rate ||
 		    val > st->soc_info.max_sample_rate)
 			return -EINVAL;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		mutex_lock(&st->lock);
 		at91_adc_setup_samp_freq(indio_dev, val,
 					 st->soc_info.startup_time, 0);
 		mutex_unlock(&st->lock);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.48.1


