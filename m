Return-Path: <linux-iio+bounces-16600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCFA585ED
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E2F169558
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D7748F;
	Sun,  9 Mar 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeAjuJd5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F21DF745
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539530; cv=none; b=iae4NUO1GySAL1zbKKdVvVRG1jiRFYcMD78mPbRQjr50VjUyC0Qdfr2C388gmYb8TToDSy7HjhVXWEKKwP6/5NfBdyN5kkhLyK/GJlPjs8R3ZWd/HoKAGKFrwUuPwQYxLmaSP0Khz4qSfyPLh+gjRooWD3epK00zzZXKXoKoINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539530; c=relaxed/simple;
	bh=YUYZpYWu3qEndzwnWpszt3bx3yZgChkcVon2XZ2sCTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1yBApEAEcnfoE0ycbBeBUdFY3knJG79q55C2N5aA9BJnvoxlOSEionVcKE3stJwzBTdlfv6ZihDglhfGy5bLSIih2quog+0Frmv/couzsJpyF8Gk8GyW/ZhhOC8kmnqjh99f+kh8EBxaHL2qHFCXqEesKqlHISIbLv/Lfp22wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeAjuJd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68241C4CEE3;
	Sun,  9 Mar 2025 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539529;
	bh=YUYZpYWu3qEndzwnWpszt3bx3yZgChkcVon2XZ2sCTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FeAjuJd5QplWqt7q5SFRD1DLxzF9rKRHT5E9HX366v2M5nVepKNlgsyMxl9Ipwrlh
	 yhbJn2ur9CFtbe4qVYqnUokC/YZ5W88FauQvha8LYe8ky1b9ou2l5Ez8A7ScbM14wA
	 OwX2knESELpbqbNQapceZwezbiEjMFAdBRLtiRKkWYEgtKHzQ0V6VtfljcUwLpy0QE
	 ElA8sVt2aGCmf8D4VBYtg5oFi8DpQclLwL7911bGqiWi5/NYCSkkHWstjLPwmCoRwy
	 Ty+B2PR+ijii7q3dWYPccgCZaAFO1wqRbjujGkXMm6PThWl10FpwzE+Ls2ee5oyNY3
	 vZw+bxvjN/h+Q==
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 3/8] iio: adc: ti-ads1100: Use guard(mutex) to allow direct returns
Date: Sun,  9 Mar 2025 16:58:14 +0000
Message-ID: <20250309165819.1346684-4-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309165819.1346684-1-jic23@kernel.org>
References: <20250309165819.1346684-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use of automated lock release simplifies the code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/adc/ti-ads1100.c | 39 +++++++++++++-----------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
index 1e46f07a9ca6..0519f8afb033 100644
--- a/drivers/iio/adc/ti-ads1100.c
+++ b/drivers/iio/adc/ti-ads1100.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -219,36 +220,31 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ads1100_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
-			break;
+			return ret;
 
 		ret = ads1100_get_adc_result(data, chan->address, val);
-		if (ret >= 0)
-			ret = IIO_VAL_INT;
 		iio_device_release_direct_mode(indio_dev);
-		break;
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* full-scale is the supply voltage in millivolts */
 		*val = ads1100_get_vdd_millivolts(data);
 		*val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
-		ret = IIO_VAL_FRACTIONAL_LOG2;
-		break;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
 						   data->config)];
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int ads1100_write_raw(struct iio_dev *indio_dev,
@@ -256,23 +252,16 @@ static int ads1100_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct ads1100_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = ads1100_set_scale(data, val, val2);
-		break;
+		return ads1100_set_scale(data, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = ads1100_set_data_rate(data, chan->address, val);
-		break;
+		return ads1100_set_data_rate(data, chan->address, val);
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static const struct iio_info ads1100_info = {
-- 
2.48.1


