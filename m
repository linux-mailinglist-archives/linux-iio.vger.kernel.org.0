Return-Path: <linux-iio+bounces-15696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBBEA38649
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4933BB1AA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC621E0BF;
	Mon, 17 Feb 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQiLw9kP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D750621D587
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801939; cv=none; b=TODICwQlXwlbFHkUtxVBHqddJ1RxbA4NPQZv7kGvP8IjIQsedOUUUNlnKkY7MforVL8FpufY51wS9ps4R/IYBdt4oiuofCN4B3mti9hBIteRwmOCoNcUNouXCevS81H+xf421PmZX7ALX5TyR4f9xNVbXzcqMrJzI5vITXu20z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801939; c=relaxed/simple;
	bh=W6hpPZ2GKjpygZRhmNByhv0deg1JHT2avhpEn0QnycA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkC+nCsIoVZfiIFCiCmXrWEfkI+IH22BuVAqOEdRv1FaOSO5213X0RemtZhMPM7FmKYBhAvqmDl2xwFCytG35WUDKPhz/xf7rGQ5IU1KwXyKRLZc6WcvVy5U5+Fyoo9TvnYcWP1/NMKSkEPCyiNazw+r8o5UmH/9JASbKILF508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQiLw9kP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421A5C4CEE7;
	Mon, 17 Feb 2025 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739801939;
	bh=W6hpPZ2GKjpygZRhmNByhv0deg1JHT2avhpEn0QnycA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQiLw9kPhSuBcC/AKpFf59fVLC+3SK0R5138Fvp+4ZpxIMvoGiKQV2nsCC/L1ET5B
	 2JW2zb3uNTGQ+OeSVPaGPurdtaOuXB7aSsdAQAJTX8CIUGYS5uhSnXGpaBctxpjGIJ
	 xS1rRMPLjZJQB0Df5T7km7jZM/bd2e5YX3ClELLhaIevVYNws3B8A8K+F2q7dx7WlC
	 CjZ08n3UrbSn3a50d6bcNM9u2msyBdSclDRtJPQwfOyLl7LCBd1WLDwDY/Yqe4FH64
	 1om5jhQ5wKhjD1C8Y1BH6EyeT8JKbK1w/iZo5jiPLUeWxF2jXYFy8dn5+jjI8rwPu+
	 9/KrPLxk0p09Q==
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
Subject: [PATCH 23/29] iio: adc: max1027: Move claim of direct mode up one level and use guard()
Date: Mon, 17 Feb 2025 14:16:23 +0000
Message-ID: <20250217141630.897334-24-jic23@kernel.org>
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

Move iio_device_claim_direct_mode() into the read_raw() callback
and use guard() to release a mutex. This enables simpler error
handling via direct returns.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index f5ba4a1b5a7d..e6a47abc862f 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -336,10 +336,6 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	int ret;
 	struct max1027_state *st = iio_priv(indio_dev);
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
 	/* Configure conversion register with the requested chan */
 	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
 		  MAX1027_NOSCAN;
@@ -349,7 +345,7 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	if (ret < 0) {
 		dev_err(&indio_dev->dev,
 			"Failed to configure conversion register\n");
-		goto release;
+		return ret;
 	}
 
 	/*
@@ -359,14 +355,10 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	 */
 	ret = max1027_wait_eoc(indio_dev);
 	if (ret)
-		goto release;
+		return ret;
 
 	/* Read result */
 	ret = spi_read(st->spi, st->buffer, (chan->type == IIO_TEMP) ? 4 : 2);
-
-release:
-	iio_device_release_direct_mode(indio_dev);
-
 	if (ret < 0)
 		return ret;
 
@@ -382,37 +374,33 @@ static int max1027_read_raw(struct iio_dev *indio_dev,
 	int ret = 0;
 	struct max1027_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret
+
 		ret = max1027_read_single_value(indio_dev, chan, val);
-		break;
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_TEMP:
 			*val = 1;
 			*val2 = 8;
-			ret = IIO_VAL_FRACTIONAL;
-			break;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_VOLTAGE:
 			*val = 2500;
 			*val2 = chan->scan_type.realbits;
-			ret = IIO_VAL_FRACTIONAL_LOG2;
-			break;
+			return IIO_VAL_FRACTIONAL_LOG2;
 		default:
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
-- 
2.48.1


