Return-Path: <linux-iio+bounces-15680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D2A38608
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE867171FBB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD25B223700;
	Mon, 17 Feb 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcEb3f26"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6C2236EE
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801853; cv=none; b=q4zF2f4hCFNWWy73WTUDh1A9PX3G/AQeWHgM29H4LIZUTuW9Vbs21xM2ewz8a9BT5p7vi0BdPdx1Banf5Mhpux/ma1vsMWElsW9iz/VXWRsa8TfkxWwW2Lfg9E3ztUBzMbCdhDNsVLKmc4oPS4lXSA5dGhRKgbeDft2HdMXNNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801853; c=relaxed/simple;
	bh=P/ekOOL/Hm7vsID+46Wh8NlqGhZlNRtf4X/EyKh2ZR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6o0FFsAYVU5SIWt6IzZNYUOIH/JD9g3q6YpDz8rpv41wVEOZNjcrtTTZUIm4vaeqd5dH9+OwerN35CtzcjGmuSC0QyoElQEFwSHa2bhGmzdvL4DMRjxkZarEvgej8f9bGZx0L6hPQLw394mXheP8Y1FHfN42E6EsbbN01cGriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcEb3f26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8C8C4CEEB;
	Mon, 17 Feb 2025 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801853;
	bh=P/ekOOL/Hm7vsID+46Wh8NlqGhZlNRtf4X/EyKh2ZR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcEb3f26B6F+BOwYpq15o7uGyifcZy6eLWSabLSnAWDxXX4q6MtLFP8lGbpdieLVA
	 KeOg0QP3NcVGDOUf30l+RZ3cSlxIHWykneh8eBWun8XpoI6gqMNE4Gl2ELYec1aKuY
	 YHSDMJeyupD59kUQSWO0Wtt7U87JTmS2XJldiHaRQCoiWBseO1F3BLDdNKnbY7xPTQ
	 Otc4x3qehk34nw939JUFTyVUwEt0mPI/dn+n+X6b8VLSnErNMBrJOsxvnnTJ42F+2+
	 tOSj3+Zb94mVogSFXwQTq6gGs2O4+lzXunJl6hxMLD4v9PcMZyBT1vbOhDmP+X0oR5
	 ZhatE5mYy107A==
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
Subject: [PATCH 08/29] iio: adc: stm32-dfsdm: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:16:08 +0000
Message-ID: <20250217141630.897334-9-jic23@kernel.org>
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
Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1cf2594d6872..726ddafc9f6d 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1275,9 +1275,8 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = stm32_dfsdm_compute_all_osrs(indio_dev, val);
 		if (!ret) {
@@ -1287,19 +1286,18 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 			adc->oversamp = val;
 			adc->sample_freq = spi_freq / val;
 		}
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!val)
 			return -EINVAL;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = dfsdm_adc_set_samp_freq(indio_dev, val, spi_freq);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	}
 
@@ -1355,12 +1353,11 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = __stm32_dfsdm_read_info_raw(indio_dev, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 		return IIO_VAL_INT;
-- 
2.48.1


