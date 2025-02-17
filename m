Return-Path: <linux-iio+bounces-15663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAA9A38546
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2358D7A1D4D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3A21CC42;
	Mon, 17 Feb 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHTMId9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF1B21C177
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800919; cv=none; b=Jz6yOSTp5LqwcROkV4JifYJQVih6Y4NErH0W/baQCLBm5C7Fcu8OyY9D1HpfUs8IxECX4Tljkqa9Mu/mP4uf8s6+MYc2NYUDcmweN838vwtrtFvD/TjBBpYBASI98e7ySKKm48td0/0bryGAn3MRRXIUTtNT6UXIWsGhnDSpkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800919; c=relaxed/simple;
	bh=8OnohwFxfDI7bGeLRnQHXh5mTMkLAajhDEx2poQ7OkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZwTobSRYVUUDykAPHsaA5OtkYz+z0Rjrj6bNNEL+FL3DB3CYz/4mz3mK/Nc6inM/PWNANWhcpblwDI5yHGj/rLxY15QGCtzyvVJLEY/ox5Dj+1LHl2TnFaWo8B5WtaTG5IxGpjYOrtx8q2k09ULsxmF9ODKtBlpoo/OICdA/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHTMId9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB7AC4CED1;
	Mon, 17 Feb 2025 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800918;
	bh=8OnohwFxfDI7bGeLRnQHXh5mTMkLAajhDEx2poQ7OkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHTMId9pzNXagsmO2hXVqLbUL0V0AMw3k5nnTG4rnRKiuSYtViNAmfUtaQd58aE0f
	 wkabTXTL6UbJ7S+NhAFpWC4pGE2JatydQG8csGk5gXitxRJBQ/jw1BiHefe3tJ9BRo
	 6hkNAPSi27RamfWhgRE+bgoP0z2ES43TUiUSDqbNaYUXkfntwAHfb+Au75T497ts+g
	 NWEQ9M8tCpsSjwKZqBwvhBnDcf5QfejPP8gs49Jas7yJxY2bp9Nlx77hwE4B/p4hQ/
	 bGE1UkdeZm7TCLft8DPrpYXKTWEsKqqm+eJix+SMM+odq2jG2Ebptlv6/HPpqiy1ph
	 vNFvi84lPl0qw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/8] iio: accel: kx022a: Factor out guts of write_raw() to allow direct returns
Date: Mon, 17 Feb 2025 14:01:31 +0000
Message-ID: <20250217140135.896574-5-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217140135.896574-1-jic23@kernel.org>
References: <20250217140135.896574-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Create a new utility function for the actions taken when direct mode
is held. This allows for direct returns, simplifying the code flow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 66 ++++++++++++++++---------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 3a56ab00791a..727e007c5fc1 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -510,26 +510,13 @@ static int kx022a_write_raw_get_fmt(struct iio_dev *idev,
 	}
 }
 
-static int kx022a_write_raw(struct iio_dev *idev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int __kx022a_write_raw(struct iio_dev *idev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
 	struct kx022a_data *data = iio_priv(idev);
 	int ret, n;
 
-	/*
-	 * We should not allow changing scale or frequency when FIFO is running
-	 * as it will mess the timestamp/scale for samples existing in the
-	 * buffer. If this turns out to be an issue we can later change logic
-	 * to internally flush the fifo before reconfiguring so the samples in
-	 * fifo keep matching the freq/scale settings. (Such setup could cause
-	 * issues if users trust the watermark to be reached within known
-	 * time-limit).
-	 */
-	ret = iio_device_claim_direct_mode(idev);
-	if (ret)
-		return ret;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		n = ARRAY_SIZE(kx022a_accel_samp_freq_table);
@@ -538,20 +525,19 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			if (val == kx022a_accel_samp_freq_table[n][0] &&
 			    val2 == kx022a_accel_samp_freq_table[n][1])
 				break;
-		if (n < 0) {
-			ret = -EINVAL;
-			goto unlock_out;
-		}
+		if (n < 0)
+			return -EINVAL;
+
 		ret = kx022a_turn_off_lock(data);
 		if (ret)
-			break;
+			return ret;
 
 		ret = regmap_update_bits(data->regmap,
 					 data->chip_info->odcntl,
 					 KX022A_MASK_ODR, n);
 		data->odr_ns = kx022a_odrs[n];
 		kx022a_turn_on_unlock(data);
-		break;
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		n = data->chip_info->scale_table_size / 2;
 
@@ -559,26 +545,44 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			if (val == data->chip_info->scale_table[n][0] &&
 			    val2 == data->chip_info->scale_table[n][1])
 				break;
-		if (n < 0) {
-			ret = -EINVAL;
-			goto unlock_out;
-		}
+		if (n < 0)
+			return -EINVAL;
 
 		ret = kx022a_turn_off_lock(data);
 		if (ret)
-			break;
+			return ret;
 
 		ret = regmap_update_bits(data->regmap, data->chip_info->cntl,
 					 KX022A_MASK_GSEL,
 					 n << KX022A_GSEL_SHIFT);
 		kx022a_turn_on_unlock(data);
-		break;
+		return ret;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
+
+static int kx022a_write_raw(struct iio_dev *idev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int ret;
+
+	/*
+	 * We should not allow changing scale or frequency when FIFO is running
+	 * as it will mess the timestamp/scale for samples existing in the
+	 * buffer. If this turns out to be an issue we can later change logic
+	 * to internally flush the fifo before reconfiguring so the samples in
+	 * fifo keep matching the freq/scale settings. (Such setup could cause
+	 * issues if users trust the watermark to be reached within known
+	 * time-limit).
+	 */
+	ret = iio_device_claim_direct_mode(idev);
+	if (ret)
+		return ret;
+
+	ret = __kx022a_write_raw(idev, chan, val, val2, mask);
 
-unlock_out:
 	iio_device_release_direct_mode(idev);
 
 	return ret;
-- 
2.48.1


