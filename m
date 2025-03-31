Return-Path: <linux-iio+bounces-17445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41DA76586
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F643A9F8F
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074F153801;
	Mon, 31 Mar 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Ow70ns"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF49165F13
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423309; cv=none; b=QVMx/daBzS7JtjT719k48MKA4Z4iXOdP2tODZzvZwowtXZOssWLpWP3UCbM/MiTw2/zjl9P9nlMDYgq7/Ui0KPf105fTysU2LfBo3VceEvNb67UrjBqpcG6mUxdlOvJyT5g6dGePyKFX/TgWJlhuBwXmthdLlp4veON2b8gneAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423309; c=relaxed/simple;
	bh=Y9aSTD/po3NwLmiYivy/mMRxniwb43HjsKIJi01vf/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9KwyERs7o7yMMLqU5a3cn8wKkq0pbfh0v7aoVJHBeezw+gGt6Ds/bgOv7oYPqO/OG4WiG7plpztGav8XKqFM/v1CaTA4X10+du9P4GIzUfiBCUPj663DW0e54aw0aUYM+a3g1ZPf5XtI62O30o/Tv5l9LvnYSkfcspQsc5NHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Ow70ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1583C4CEE3;
	Mon, 31 Mar 2025 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423309;
	bh=Y9aSTD/po3NwLmiYivy/mMRxniwb43HjsKIJi01vf/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z8Ow70nsfZIrLr0PDGjibljA/cYBVTlq1nBw3Gco/ZymvPAIKWfLw8hX7tgFwN5E+
	 agXr5U7sVCPrEmo0w3g8yWj4sE5WgoQuABJHJrrgukkOCELwFQW+Pnre7Kwqju+wkL
	 WBQvZ0j3niDH8g+IkXJcJWVGaryLKxWKBL/SRTZSEUah9WMyu2TEfoCWry7jIkmDCl
	 z7g/g5+DTMqPjwNXy+oW0gufphDmXk5QU6q64HoHGWXDm7N+pz9JojNfhh5OuRhzCd
	 o3DK2LT9RMwD4Hns01unJD3/7xgn+rf2UWIghvoTvO5uTiOLfgjLXUtGzuNIJngXxD
	 gRlaXMiX1RXAg==
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
Subject: [PATCH 15/37] iio: imu: inv_icm42600: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:55 +0100
Message-ID: <20250331121317.1694135-16-jic23@kernel.org>
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

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 21 ++++++++-----------
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 21 ++++++++-----------
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  7 +++----
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 388520ec60b5..1a67f5ce1800 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -685,11 +685,10 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = inv_icm42600_accel_read_sensor(indio_dev, chan, &data);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 		*val = data;
@@ -747,20 +746,18 @@ static int inv_icm42600_accel_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = inv_icm42600_accel_write_scale(indio_dev, val, val2);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42600_accel_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = inv_icm42600_accel_write_offset(st, chan, val, val2);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	default:
 		return -EINVAL;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 591ed78a55bb..70bac8ca28fa 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -591,11 +591,10 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = inv_icm42600_gyro_read_sensor(st, chan, &data);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 		*val = data;
@@ -653,20 +652,18 @@ static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = inv_icm42600_gyro_write_scale(indio_dev, val, val2);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42600_gyro_write_odr(indio_dev, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = inv_icm42600_gyro_write_offset(st, chan, val, val2);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return ret;
 	default:
 		return -EINVAL;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 213cce1c3111..f77645d92efd 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -56,11 +56,10 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = inv_icm42600_temp_read(st, &temp);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 		*val = temp;
-- 
2.48.1


