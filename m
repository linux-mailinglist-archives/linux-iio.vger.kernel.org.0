Return-Path: <linux-iio+bounces-17456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202BCA76594
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBD31889803
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2E51E4928;
	Mon, 31 Mar 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL22rUjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9451E500C
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423379; cv=none; b=lgWhkytMVZ8UYilpqTRnxHbfwHLqwdFX9AYeASmPa1Oq7PJfblKa6pr4e0WV35+gzXnIj21bvSQnlPQZFGiW1vAfctdtCzYYxeElapXl9yb0MTijAIaYdpD++yOizrAFbi17ii+1QOsGz9qmdW5VF0SiyHxtj8P472i1DgJhUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423379; c=relaxed/simple;
	bh=maMHlrcpg9cp/PofwmTKahkmOwMVxbiFXs/Yqza8F2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOiS1foJL1nYQdPqt0ma+RAvGHwBhmbI7kuHyzWIRbYoxKRY6fImTB387ZVbWG56xibsv2w/YX0+CqD36PndYERQLOYi8BluyOxBuXqSVzfSAOMt23AQPNLkMIQnuSpK2tCwEAz/gza6MjD9Vni7rpzP4arcpE8HsayFAaTjtT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL22rUjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05663C4CEE3;
	Mon, 31 Mar 2025 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423378;
	bh=maMHlrcpg9cp/PofwmTKahkmOwMVxbiFXs/Yqza8F2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OL22rUjhslthYPKc4lX9GWBAyWkAfUjndMurUr19vBulTqscgeIUKrEuhRI38CiTN
	 Rb4DM0MJoH6fOMJpKK6oqghcMfkD/BBiiU4S4WnEhgsi4Kaj8+eKHSgis0J7W0SCqe
	 HGCqdQd2zqaqaK4YzXLBMEZWsg/p8uWO3lLtCIOFakXi3nQiEXiKx7PiS0byPaE06b
	 gw3BGVinZCKCwv+/r9PaO7he7/yT2obM5KQC8HaxX5iuJUPSQZHiIMhBUoUYKz8y38
	 1lexiPRlNFnTNuZa2Xv1X4lboivkar2HnAZn71/IHkXdrcYm7L9Nb7OOmCVCQCr3ml
	 FDEKza279opSg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 26/37] iio: pressure: mpl3115: factor out core of IIO_INFO_RAW read to simplify code flow
Date: Mon, 31 Mar 2025 13:13:06 +0100
Message-ID: <20250331121317.1694135-27-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Apply guard(mutex) to remove the need for manual release of the lock.
Factor out the code that occurs under the direct claim.
These two changes allow for direct returns simplifying code flow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/mpl3115.c | 90 ++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 71ded2eee060..207031b5ff72 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -69,6 +69,52 @@ static int mpl3115_request(struct mpl3115_data *data)
 	return 0;
 }
 
+static int mpl3115_read_info_raw(struct mpl3115_data *data,
+				 struct iio_chan_spec const *chan, int *val)
+{
+	int ret;
+
+	switch (chan->type) {
+	case IIO_PRESSURE: { /* in 0.25 pascal / LSB */
+		__be32 tmp = 0;
+
+		guard(mutex)(&data->lock);
+		ret = mpl3115_request(data);
+		if (ret < 0)
+			return ret;
+
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    MPL3115_OUT_PRESS,
+						    3, (u8 *) &tmp);
+		if (ret < 0)
+			return ret;
+
+		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
+		return IIO_VAL_INT;
+	}
+	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
+		__be16 tmp;
+
+		guard(mutex)(&data->lock);
+		ret = mpl3115_request(data);
+		if (ret < 0)
+			return ret;
+
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    MPL3115_OUT_TEMP,
+						    2, (u8 *) &tmp);
+		if (ret < 0)
+			return ret;
+
+		*val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -82,49 +128,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		switch (chan->type) {
-		case IIO_PRESSURE: { /* in 0.25 pascal / LSB */
-			__be32 tmp = 0;
-
-			mutex_lock(&data->lock);
-			ret = mpl3115_request(data);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
-				break;
-			}
-			ret = i2c_smbus_read_i2c_block_data(data->client,
-				MPL3115_OUT_PRESS, 3, (u8 *) &tmp);
-			mutex_unlock(&data->lock);
-			if (ret < 0)
-				break;
-			*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
-			ret = IIO_VAL_INT;
-			break;
-		}
-		case IIO_TEMP: { /* in 0.0625 celsius / LSB */
-			__be16 tmp;
-
-			mutex_lock(&data->lock);
-			ret = mpl3115_request(data);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
-				break;
-			}
-			ret = i2c_smbus_read_i2c_block_data(data->client,
-				MPL3115_OUT_TEMP, 2, (u8 *) &tmp);
-			mutex_unlock(&data->lock);
-			if (ret < 0)
-				break;
-			*val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
-					     chan->scan_type.realbits - 1);
-			ret = IIO_VAL_INT;
-			break;
-		}
-		default:
-			ret = -EINVAL;
-			break;
-		}
-
+		ret = mpl3115_read_info_raw(data, chan, val);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 
-- 
2.48.1


