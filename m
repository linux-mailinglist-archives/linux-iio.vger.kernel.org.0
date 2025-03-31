Return-Path: <linux-iio+bounces-17451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A5EA7658E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197F216A264
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457F1E47A5;
	Mon, 31 Mar 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFc7hBme"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526413B59B
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423347; cv=none; b=bfp6WUN6bxiWpYeULZb66qx3NxdeuxLZ64Ld0jJsZRxzdoZiOjCUDLbLQI97hj3kMqnqTl+HnMfuRPLb1W0RQ90t7xBkQobb+6XNFeWnKzc24CAPxNgHHWmHD3n8qXGr4QOfkK6ax35OqUG36ejRnp76kruYncwL9zmfPcW2mq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423347; c=relaxed/simple;
	bh=oXXPdmlxo+9iJaskNtKtTIIyojX65VSEdTnhD2H7kCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0qzAnph7vWDWTOZEC4qiO7WeYRhwUMJ7GzijmK32K4ByNiXtAn4HNMOMb/7AInsRbJeoCaPbOwCduc/moFSXcgK+jrbj4PwQ+jvWxlbM/l0n1VXpW/VWMsgzyO5R4Dwcn3p0Y/kJnuk6SSdbs1wNtQFZaTsKDPmKcxegP1TlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFc7hBme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBB2C4CEE5;
	Mon, 31 Mar 2025 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423346;
	bh=oXXPdmlxo+9iJaskNtKtTIIyojX65VSEdTnhD2H7kCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFc7hBmelxZAUzVVwAjYmU3VzOKScLrVt/QyMIlLzd6gw4+D+0yl11lawRpLTP0m9
	 sl20TbAQ+KOJVpofsvwP3mUU6TsHudcQ9XBD3fR8XA5jAEDrR8qHVvhCRQhf/HmO56
	 4Ju/Qi+MiJLyaXz0ItQ1Sbnq89sOtUKVN9ogV9g90vIfWDLaIFnRJqTF5P+VymC6EL
	 l6EDGuAoTbLcwfhvfu0YLk4mC1G22vlVPgPT6bE8zeClqdiS1ti8ssC1uf3HY+FQeE
	 m1pzAzmheWjtK3q+wux4fYzLOj8mf7iIZeChzIHYKo8R4lURUEwcy2nCIuoMh1wgpa
	 wn3JIyKC/aqLQ==
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
Subject: [PATCH 21/37] iio: magnetometer: mag3110: Factor out core of read/write_raw() and use guard() to simplify code flow.
Date: Mon, 31 Mar 2025 13:13:01 +0100
Message-ID: <20250331121317.1694135-22-jic23@kernel.org>
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

The combination of guard(mutex) and factoring out sections of code
that occur with the device held in direct mode simplifies code flow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/mag3110.c | 153 ++++++++++++++---------------
 1 file changed, 75 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 2fe8e97f2cf8..b633bdf793ed 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -9,6 +9,7 @@
  * TODO: irq, user offset, oversampling, continuous mode
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -102,17 +103,12 @@ static int mag3110_read(struct mag3110_data *data, __be16 buf[3])
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = mag3110_request(data);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
+	if (ret < 0)
 		return ret;
-	}
-	ret = i2c_smbus_read_i2c_block_data(data->client,
-		MAG3110_OUT_X, 3 * sizeof(__be16), (u8 *) buf);
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return i2c_smbus_read_i2c_block_data(data->client, MAG3110_OUT_X,
+					     3 * sizeof(__be16), (u8 *) buf);
 }
 
 static ssize_t mag3110_show_int_plus_micros(char *buf,
@@ -231,19 +227,17 @@ static int mag3110_change_config(struct mag3110_data *data, u8 reg, u8 val)
 	int ret;
 	int is_active;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	is_active = mag3110_is_active(data);
-	if (is_active < 0) {
-		ret = is_active;
-		goto fail;
-	}
+	if (is_active < 0)
+		return is_active;
 
 	/* config can only be changed when in standby */
 	if (is_active > 0) {
 		ret = mag3110_standby(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
 	/*
@@ -252,23 +246,52 @@ static int mag3110_change_config(struct mag3110_data *data, u8 reg, u8 val)
 	 */
 	ret = mag3110_wait_standby(data);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	ret = i2c_smbus_write_byte_data(data->client, reg, val);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	if (is_active > 0) {
 		ret = mag3110_active(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
-	ret = 0;
-fail:
-	mutex_unlock(&data->lock);
+	return 0;
+}
 
-	return ret;
+static int __mag3110_read_info_raw(struct mag3110_data *data,
+				   struct iio_chan_spec const *chan,
+				   int *val)
+{
+	__be16 buffer[3];
+	int ret;
+
+	switch (chan->type) {
+	case IIO_MAGN: /* in 0.1 uT / LSB */
+		ret = mag3110_read(data, buffer);
+		if (ret < 0)
+			return ret;
+		*val = sign_extend32(be16_to_cpu(buffer[chan->scan_index]),
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+
+	case IIO_TEMP: { /* in 1 C / LSB */
+		guard(mutex)(&data->lock);
+		ret = mag3110_request(data);
+		if (ret < 0)
+			return ret;
+		ret = i2c_smbus_read_byte_data(data->client,
+					       MAG3110_DIE_TEMP);
+		if (ret < 0)
+			return ret;
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	}
+	default:
+		return -EINVAL;
+	}
 }
 
 static int mag3110_read_raw(struct iio_dev *indio_dev,
@@ -276,7 +299,6 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct mag3110_data *data = iio_priv(indio_dev);
-	__be16 buffer[3];
 	int i, ret;
 
 	switch (mask) {
@@ -284,37 +306,7 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
-
-		switch (chan->type) {
-		case IIO_MAGN: /* in 0.1 uT / LSB */
-			ret = mag3110_read(data, buffer);
-			if (ret < 0)
-				goto release;
-			*val = sign_extend32(
-				be16_to_cpu(buffer[chan->scan_index]),
-					    chan->scan_type.realbits - 1);
-			ret = IIO_VAL_INT;
-			break;
-		case IIO_TEMP: /* in 1 C / LSB */
-			mutex_lock(&data->lock);
-			ret = mag3110_request(data);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
-				goto release;
-			}
-			ret = i2c_smbus_read_byte_data(data->client,
-				MAG3110_DIE_TEMP);
-			mutex_unlock(&data->lock);
-			if (ret < 0)
-				goto release;
-			*val = sign_extend32(ret,
-					     chan->scan_type.realbits - 1);
-			ret = IIO_VAL_INT;
-			break;
-		default:
-			ret = -EINVAL;
-		}
-release:
+		ret = __mag3110_read_info_raw(data, chan, val);
 		iio_device_release_direct_mode(indio_dev);
 		return ret;
 
@@ -346,24 +338,18 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static int mag3110_write_raw(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
+static int __mag3110_write_raw(struct mag3110_data *data,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
 {
-	struct mag3110_data *data = iio_priv(indio_dev);
-	int rate, ret;
-
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	int rate;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		rate = mag3110_get_samp_freq_index(data, val, val2);
-		if (rate < 0) {
-			ret = -EINVAL;
-			break;
-		}
+		if (rate < 0)
+			return -EINVAL;
+
 		data->ctrl_reg1 &= 0xff & ~MAG3110_CTRL_DR_MASK
 					& ~MAG3110_CTRL_AC;
 		data->ctrl_reg1 |= rate << MAG3110_CTRL_DR_SHIFT;
@@ -371,22 +357,33 @@ static int mag3110_write_raw(struct iio_dev *indio_dev,
 		if (data->sleep_val < 40)
 			data->ctrl_reg1 |= MAG3110_CTRL_AC;
 
-		ret = mag3110_change_config(data, MAG3110_CTRL_REG1,
-					    data->ctrl_reg1);
-		break;
+		return mag3110_change_config(data, MAG3110_CTRL_REG1,
+					     data->ctrl_reg1);
+
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if (val < -10000 || val > 10000) {
-			ret = -EINVAL;
-			break;
-		}
-		ret = i2c_smbus_write_word_swapped(data->client,
+		if (val < -10000 || val > 10000)
+			return -EINVAL;
+
+		return i2c_smbus_write_word_swapped(data->client,
 			MAG3110_OFF_X + 2 * chan->scan_index, val << 1);
-		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
+}
+
+static int mag3110_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mag3110_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+	ret = __mag3110_write_raw(data, chan, val, val2, mask);
 	iio_device_release_direct_mode(indio_dev);
+
 	return ret;
 }
 
-- 
2.48.1


