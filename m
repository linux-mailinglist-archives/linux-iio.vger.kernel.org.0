Return-Path: <linux-iio+bounces-17440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A0A76580
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C96617A3448
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730F1E3790;
	Mon, 31 Mar 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7451HGm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BF1E377F
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423278; cv=none; b=CxtwEFoTJpog8j7ovOuF2mXgLHdkQHRpvyMbuviTxU3DMwFy8ZnpK7FPRNFHcMM3oUDmLqiPO/Y/02EI/Bi0ZT3xFdvbuQdqaOULwIvwE0RZGruiOqtp9jDjtVhmtCJ1BoJ9cq+iGcejxJkOuxGvMroQEVI9QZclfbuaXCa1GAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423278; c=relaxed/simple;
	bh=DfgN0kHZTotamsLbyfGFm/gx4q9zb++LGiw4XwXHyUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A18owY8p9bpyBgVWcH/sMFMaFtl/OkKkAUAbqfdlAvVGn/lc9PBshORD8Pchu4lRUDT358inFGDlNV6V388NsFCMFXVb4l6XyJmu6tRWWxFfg98qCf56fzJY8mMft8DtkcT/Ok6TXlnIv4fqbIezxslFMBnxbKxal3T7HR8gh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7451HGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B2FC4CEE3;
	Mon, 31 Mar 2025 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423278;
	bh=DfgN0kHZTotamsLbyfGFm/gx4q9zb++LGiw4XwXHyUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7451HGmcUehBr5UNLRfnKfHK0Ymf4ItFdvNt5UFkNAt0NbOu0HA+WvdWhG/Lhx3N
	 QmnJhWnVqti3j01/kzLh/4WipKJ8KV2rpsLxgcVp0Kgr5mnJLa9lDk+2msPYHoDM0B
	 z0Xy2+QmsFuDQZMwLr7IzrJHK9zY/7mfvcplOr46lr9nO6o2NxzuvAE/JzOAF3ekCo
	 lwiZRkd2a1vLKftjl7F6rsHzVFNXMF5sPjRpuLgLU/4Fg+DdPTasfE38y1d12hTOeY
	 bX0oaun+2bAGVObKX/zlWw5x7pwiVkAFwzIe3O2BntbBAbj5eJIzQpfRbC0GwNExlC
	 rcCDRsI/APFZw==
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
Subject: [PATCH 10/37] iio: humidity: hdc100x: Use guard(mutex) to simplify code flow
Date: Mon, 31 Mar 2025 13:12:50 +0100
Message-ID: <20250331121317.1694135-11-jic23@kernel.org>
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

By using autoreleasing on the lock a number of paths can use
direct returns allow earlier exit from functions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/humidity/hdc100x.c | 69 +++++++++++++---------------------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index a303f704b7ed..fb8584423ad8 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -13,6 +13,7 @@
  * https://www.ti.com/product/HDC1080/datasheet
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -206,26 +207,21 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW: {
 		int ret;
 
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 		if (chan->type == IIO_CURRENT) {
 			*val = hdc100x_get_heater_status(data);
-			ret = IIO_VAL_INT;
-		} else {
-			ret = iio_device_claim_direct_mode(indio_dev);
-			if (ret) {
-				mutex_unlock(&data->lock);
-				return ret;
-			}
-
-			ret = hdc100x_get_measurement(data, chan);
-			iio_device_release_direct_mode(indio_dev);
-			if (ret >= 0) {
-				*val = ret;
-				ret = IIO_VAL_INT;
-			}
+			return IIO_VAL_INT;
 		}
-		mutex_unlock(&data->lock);
-		return ret;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = hdc100x_get_measurement(data, chan);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
@@ -256,26 +252,23 @@ static int hdc100x_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct hdc100x_data *data = iio_priv(indio_dev);
-	int ret = -EINVAL;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_INT_TIME:
+	case IIO_CHAN_INFO_INT_TIME: {
 		if (val != 0)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		ret = hdc100x_set_it_time(data, chan->address, val2);
-		mutex_unlock(&data->lock);
-		return ret;
-	case IIO_CHAN_INFO_RAW:
+		guard(mutex)(&data->lock);
+		return hdc100x_set_it_time(data, chan->address, val2);
+	}
+	case IIO_CHAN_INFO_RAW: {
 		if (chan->type != IIO_CURRENT || val2 != 0)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_HEATER_EN,
-					val ? HDC100X_REG_CONFIG_HEATER_EN : 0);
-		mutex_unlock(&data->lock);
-		return ret;
+		guard(mutex)(&data->lock);
+		return hdc100x_update_config(data, HDC100X_REG_CONFIG_HEATER_EN,
+					     val ? HDC100X_REG_CONFIG_HEATER_EN : 0);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -284,27 +277,19 @@ static int hdc100x_write_raw(struct iio_dev *indio_dev,
 static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct hdc100x_data *data = iio_priv(indio_dev);
-	int ret;
 
 	/* Buffer is enabled. First set ACQ Mode, then attach poll func */
-	mutex_lock(&data->lock);
-	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
-				    HDC100X_REG_CONFIG_ACQ_MODE);
-	mutex_unlock(&data->lock);
-
-	return ret;
+	guard(mutex)(&data->lock);
+	return hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
+				     HDC100X_REG_CONFIG_ACQ_MODE);
 }
 
 static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct hdc100x_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->lock);
-	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
-	mutex_unlock(&data->lock);
-
-	return ret;
+	guard(mutex)(&data->lock);
+	return hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
 }
 
 static const struct iio_buffer_setup_ops hdc_buffer_setup_ops = {
-- 
2.48.1


