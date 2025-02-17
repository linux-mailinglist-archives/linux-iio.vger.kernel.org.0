Return-Path: <linux-iio+bounces-15661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BFA38542
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E0188E27A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C413A86C;
	Mon, 17 Feb 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfRQ2fFj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A55944E
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800912; cv=none; b=SvT02xlGKnWMUgS10lEs6Qq8y3SKbcA4B53vjHwqFD64ngAEH5T5Q6G8KwfRqdaWRf47avewNSOAXTnkMb3BX5fkbrWX4BZdZcIXxG7fki3HVA8snhqbakc8Jc9qJYd+v6wh7k5bt7BY7IfgAel6oHZNmsrvoMqRKclHc61TVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800912; c=relaxed/simple;
	bh=0I+LxMd8qdHtKsfCsfGWQJPvZYTsFNPF7E1I3y1zto8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuGYX7F82G02+DMvNbMW08asukei6Wfx3S1Y0w4kXAcujEs2m+1T3/JznSmy1SqQKg9jBiLoQgHfZ7xVkd40WXjC70fNLeBoES+juraWkP4a/Wg/+towPAFtK1HGBwqRkiHbWhSdEkk+0Yf13cbx6m0LXEAk60/v9xP6U17zMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfRQ2fFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838AAC4CED1;
	Mon, 17 Feb 2025 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800912;
	bh=0I+LxMd8qdHtKsfCsfGWQJPvZYTsFNPF7E1I3y1zto8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfRQ2fFjPgLu2xigPY4cGsjAW5SSVg/MfsZV9pFGATxJHQBBXWCeNBsBnqe2mHZBu
	 E752j2B9H7VdFxYzqWaTEFpcnj9mRlBoFIqXE3SklwvFpEGjFYBjVDR+TSwewLFTvR
	 ETvcLonBEs0buO2f1B24V+vDCH4z6baaCRiuYDO9sr5cIemGBurnC3WuzHWXCo01Ey
	 mApzFymtfTxNdAmtodiLkSPuqOTDake+OTRGlPbEUGNkN1A23O9adNWIo8DTlb6rop
	 aM6P1Rzz5flTySjCtTsU5mhGjJ9/zI8LBt0xqpfxIhr0ZsGLp63QLtg+nheiY21pUD
	 5jDu6E+xQlKUA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/8] iio: accel: mma8452: Factor out guts of write_raw() to simplify locking
Date: Mon, 17 Feb 2025 14:01:29 +0000
Message-ID: <20250217140135.896574-3-jic23@kernel.org>
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

Factoring out those parts of write_raw() in which direct mode is held
allows for direct returns on errors, simplifying the code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma8452.c | 78 ++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1b2014c4c4b4..8ce4ddadc559 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -707,55 +707,45 @@ static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
 	return mma8452_change_config(data, MMA8452_HP_FILTER_CUTOFF, reg);
 }
 
-static int mma8452_write_raw(struct iio_dev *indio_dev,
+static int __mma8452_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int i, j, ret;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = mma8452_get_samp_freq_index(data, val, val2);
-		if (i < 0) {
-			ret = i;
-			break;
-		}
+		if (i < 0)
+			return i;
+
 		data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
 		data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
 
 		data->sleep_val = mma8452_calculate_sleep(data);
 
-		ret = mma8452_change_config(data, MMA8452_CTRL_REG1,
-					    data->ctrl_reg1);
-		break;
+		return mma8452_change_config(data, MMA8452_CTRL_REG1,
+					     data->ctrl_reg1);
+
 	case IIO_CHAN_INFO_SCALE:
 		i = mma8452_get_scale_index(data, val, val2);
-		if (i < 0) {
-			ret = i;
-			break;
-		}
+		if (i < 0)
+			return  i;
 
 		data->data_cfg &= ~MMA8452_DATA_CFG_FS_MASK;
 		data->data_cfg |= i;
 
-		ret = mma8452_change_config(data, MMA8452_DATA_CFG,
-					    data->data_cfg);
-		break;
+		return mma8452_change_config(data, MMA8452_DATA_CFG,
+					     data->data_cfg);
+
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if (val < -128 || val > 127) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val < -128 || val > 127)
+			return -EINVAL;
 
-		ret = mma8452_change_config(data,
-					    MMA8452_OFF_X + chan->scan_index,
-					    val);
-		break;
+		return mma8452_change_config(data,
+					     MMA8452_OFF_X + chan->scan_index,
+					     val);
 
 	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
 		if (val == 0 && val2 == 0) {
@@ -764,32 +754,38 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			data->data_cfg |= MMA8452_DATA_CFG_HPF_MASK;
 			ret = mma8452_set_hp_filter_frequency(data, val, val2);
 			if (ret < 0)
-				break;
+				return ret;
 		}
 
-		ret = mma8452_change_config(data, MMA8452_DATA_CFG,
+		return mma8452_change_config(data, MMA8452_DATA_CFG,
 					     data->data_cfg);
-		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		j = mma8452_get_odr_index(data);
 
 		for (i = 0; i < ARRAY_SIZE(mma8452_os_ratio); i++) {
-			if (mma8452_os_ratio[i][j] == val) {
-				ret = mma8452_set_power_mode(data, i);
-				break;
-			}
+			if (mma8452_os_ratio[i][j] == val)
+				return mma8452_set_power_mode(data, i);
 		}
-		if (i == ARRAY_SIZE(mma8452_os_ratio)) {
-			ret = -EINVAL;
-			break;
-		}
-		break;
+
+		return -EINVAL;
+
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
+
+static int mma8452_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
+	ret = __mma8452_write_raw(indio_dev, chan, val, val2, mask);
 	iio_device_release_direct_mode(indio_dev);
 	return ret;
 }
-- 
2.48.1


