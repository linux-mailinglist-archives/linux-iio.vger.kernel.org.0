Return-Path: <linux-iio+bounces-16602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA07A585F0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61061696B7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC81DFDBB;
	Sun,  9 Mar 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx35PC7C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F541DEFCC
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539538; cv=none; b=Hev71RMrzuPy6IJwd0cvYCWETjH3vCjSvh9yI3ohH4IQ4ukdFGCxYoU5bt6vKN2qc8bz6mXfLTWzyyUO1LI/Kpedz6315vw+mQ6KUEHXc+WDadDmgbgGm1kvcdTjJkZMVAGtFFPflNbH7vQ6G9UJvITm8r55v4pWdF6+P/86DZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539538; c=relaxed/simple;
	bh=B8SUDPlYXHdaz8iiWcbksHgfY95ACf8YIXHXwmHGnPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0BiRI09ilrUG6CFMVMvZ2Md+JFScqjxSY2Frawcxu1VazZy4qQN05NPiNKf+qoK9tirjjeyargVXXpD1MR2yICZ6325IOvCEyqfG8gcExYwH+CAzJfUc4nJ7QrhxPZgXS6iHMVwcvubcC7Tm1RMoNCVb2kpo5HbMEs4aq1HEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx35PC7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BC4C4CEE3;
	Sun,  9 Mar 2025 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539537;
	bh=B8SUDPlYXHdaz8iiWcbksHgfY95ACf8YIXHXwmHGnPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xx35PC7COi3x5KcrPNr9UccejiNZ22TwcEXY/h+sZOv1i/MT9ip0q1XSgyHm/SBaj
	 6lNhzm1bJmuw4DOm7Uo7eN8CP3M1VzgFuzfoEfBE5Pf6DC2CZcwjrqOFtoURf47puX
	 psKW3c0jQLKE2nE2I5TU8W9e1Uj+MttGv9zVWVAlM5g8OMnxHl3Y8okBKTds3WPi87
	 hwIFD08M6n5a7cJakXwgtpLOWzMIsWsWvJ+mVQVQt3xK5Jm0k4IDNxWqF9lKzh4RZY
	 CkCUOfdG0+wsCnL5QJuYOnKhk8DcNxuCBsz+wyQMdN6i8ZeIMongBTxIY6E9cvjemY
	 vpzdpwbvTtoag==
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
Subject: [PATCH v2 5/8] iio: adc: ti-ads1015: Use guard(mutex) and factor out code for INFO_RAW
Date: Sun,  9 Mar 2025 16:58:16 +0000
Message-ID: <20250309165819.1346684-6-jic23@kernel.org>
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

By use of automatic lock release and introducing a new utility
function to handle the core activity of reading the ADC channel,
many more complex code flows can be replaced by direct returns.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/iio/adc/ti-ads1015.c | 162 ++++++++++++++---------------------
 1 file changed, 64 insertions(+), 98 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 4355726b373a..a91ec18ddbec 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
@@ -533,6 +534,31 @@ static int ads1015_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int __ads1015_read_info_raw(struct ads1015_data *data,
+				   struct iio_chan_spec const *chan, int *val)
+{
+	int ret;
+
+	if (ads1015_event_channel_enabled(data) &&
+	    data->event_channel != chan->address)
+		return -EBUSY;
+
+	ret = ads1015_set_power_state(data, true);
+	if (ret < 0)
+		return ret;
+
+	ret = ads1015_get_adc_result(data, chan->address, val);
+	if (ret < 0) {
+		ads1015_set_power_state(data, false);
+		return ret;
+	}
+
+	*val = sign_extend32(*val >> chan->scan_type.shift,
+			     chan->scan_type.realbits - 1);
+
+	return ads1015_set_power_state(data, false);
+}
+
 static int ads1015_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -540,58 +566,30 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 	int ret, idx;
 	struct ads1015_data *data = iio_priv(indio_dev);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
-			break;
-
-		if (ads1015_event_channel_enabled(data) &&
-				data->event_channel != chan->address) {
-			ret = -EBUSY;
-			goto release_direct;
-		}
-
-		ret = ads1015_set_power_state(data, true);
-		if (ret < 0)
-			goto release_direct;
-
-		ret = ads1015_get_adc_result(data, chan->address, val);
-		if (ret < 0) {
-			ads1015_set_power_state(data, false);
-			goto release_direct;
-		}
-
-		*val = sign_extend32(*val >> chan->scan_type.shift,
-				     chan->scan_type.realbits - 1);
-
-		ret = ads1015_set_power_state(data, false);
-		if (ret < 0)
-			goto release_direct;
-
-		ret = IIO_VAL_INT;
-release_direct:
+			return ret;
+		ret = __ads1015_read_info_raw(data, chan, val);
 		iio_device_release_direct_mode(indio_dev);
-		break;
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		idx = data->channel_data[chan->address].pga;
 		*val = ads1015_fullscale_range[idx];
 		*val2 = chan->scan_type.realbits - 1;
-		ret = IIO_VAL_FRACTIONAL_LOG2;
-		break;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		idx = data->channel_data[chan->address].data_rate;
 		*val = data->chip->data_rate[idx];
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
 
 static int ads1015_write_raw(struct iio_dev *indio_dev,
@@ -599,23 +597,16 @@ static int ads1015_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct ads1015_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = ads1015_set_scale(data, chan, val, val2);
-		break;
+		return ads1015_set_scale(data, chan, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = ads1015_set_data_rate(data, chan->address, val);
-		break;
+		return ads1015_set_data_rate(data, chan->address, val);
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int ads1015_read_event(struct iio_dev *indio_dev,
@@ -624,20 +615,18 @@ static int ads1015_read_event(struct iio_dev *indio_dev,
 	int *val2)
 {
 	struct ads1015_data *data = iio_priv(indio_dev);
-	int ret;
 	unsigned int comp_queue;
 	int period;
 	int dr;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		*val = (dir == IIO_EV_DIR_RISING) ?
 			data->thresh_data[chan->address].high_thresh :
 			data->thresh_data[chan->address].low_thresh;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_EV_INFO_PERIOD:
 		dr = data->channel_data[chan->address].data_rate;
 		comp_queue = data->thresh_data[chan->address].comp_queue;
@@ -646,16 +635,10 @@ static int ads1015_read_event(struct iio_dev *indio_dev,
 
 		*val = period / USEC_PER_SEC;
 		*val2 = period % USEC_PER_SEC;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int ads1015_write_event(struct iio_dev *indio_dev,
@@ -666,24 +649,22 @@ static int ads1015_write_event(struct iio_dev *indio_dev,
 	struct ads1015_data *data = iio_priv(indio_dev);
 	const int *data_rate = data->chip->data_rate;
 	int realbits = chan->scan_type.realbits;
-	int ret = 0;
 	long long period;
 	int i;
 	int dr;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		if (val >= 1 << (realbits - 1) || val < -1 << (realbits - 1)) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val >= 1 << (realbits - 1) || val < -1 << (realbits - 1))
+			return -EINVAL;
+
 		if (dir == IIO_EV_DIR_RISING)
 			data->thresh_data[chan->address].high_thresh = val;
 		else
 			data->thresh_data[chan->address].low_thresh = val;
-		break;
+		return 0;
 	case IIO_EV_INFO_PERIOD:
 		dr = data->channel_data[chan->address].data_rate;
 		period = val * USEC_PER_SEC + val2;
@@ -694,15 +675,10 @@ static int ads1015_write_event(struct iio_dev *indio_dev,
 				break;
 		}
 		data->thresh_data[chan->address].comp_queue = i;
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int ads1015_read_event_config(struct iio_dev *indio_dev,
@@ -710,25 +686,19 @@ static int ads1015_read_event_config(struct iio_dev *indio_dev,
 	enum iio_event_direction dir)
 {
 	struct ads1015_data *data = iio_priv(indio_dev);
-	int ret = 0;
 
-	mutex_lock(&data->lock);
-	if (data->event_channel == chan->address) {
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			ret = 1;
-			break;
-		case IIO_EV_DIR_EITHER:
-			ret = (data->comp_mode == ADS1015_CFG_COMP_MODE_WINDOW);
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
-	}
-	mutex_unlock(&data->lock);
+	guard(mutex)(&data->lock);
+	if (data->event_channel != chan->address)
+		return -EBUSY;
 
-	return ret;
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return 1;
+	case IIO_EV_DIR_EITHER:
+		return (data->comp_mode == ADS1015_CFG_COMP_MODE_WINDOW);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ads1015_enable_event_config(struct ads1015_data *data,
@@ -813,14 +783,12 @@ static int ads1015_write_event_config(struct iio_dev *indio_dev,
 	int comp_mode = (dir == IIO_EV_DIR_EITHER) ?
 		ADS1015_CFG_COMP_MODE_WINDOW : ADS1015_CFG_COMP_MODE_TRAD;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/* Prevent from enabling both buffer and event at a time */
 	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret) {
-		mutex_unlock(&data->lock);
+	if (ret)
 		return ret;
-	}
 
 	if (state)
 		ret = ads1015_enable_event_config(data, chan, comp_mode);
@@ -828,8 +796,6 @@ static int ads1015_write_event_config(struct iio_dev *indio_dev,
 		ret = ads1015_disable_event_config(data, chan, comp_mode);
 
 	iio_device_release_direct_mode(indio_dev);
-	mutex_unlock(&data->lock);
-
 	return ret;
 }
 
-- 
2.48.1


