Return-Path: <linux-iio+bounces-21462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11CAFDBB2
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F00E7A52AD
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F3F23D28E;
	Tue,  8 Jul 2025 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FS+yW5DQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78762676C9;
	Tue,  8 Jul 2025 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016327; cv=none; b=XfKmfVQ55ndAd4QUrLn80n/HWVl8dyenSnBenzAaHE8qTN5QDnGG0hOEtX07xD6JPHuFyGnLx2q+nXau/3B1BoRWYBEuYpRqAYQnxyWpADHzQJ2X1HsIMM0wwQmrYesVk5LaEYmW9RCE+q2VPv0TRcVpoEEP+UjTLrNWsTbWw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016327; c=relaxed/simple;
	bh=MyuZM/zvtqIDn0Ng/dyNBpJyjLcOx/COhlBHQ8N/cus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjBxXRwnd2T7on3lHWWlIExDqWRs93+cpesXyz2P54fHmoPzA8+i9Zv0Dz2XPLyUeauItDLrF6loX44uxaRSkRtYeHif1pMwLCz9XXC4L6ybUIp9KM/zUCgsJA6Bi16xyimmXU7cjaq9EzHGvZLvf79tU9ACrKmOOq0x2b3MFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS+yW5DQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016326; x=1783552326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MyuZM/zvtqIDn0Ng/dyNBpJyjLcOx/COhlBHQ8N/cus=;
  b=FS+yW5DQEUIVcjDVyBqVUFd8wQ9wr2x+iegENAvrKKGMLRXgZivelWv6
   RD13fJ1tLm4In8TYxHkUFgbZeF6Qs92/YhzxHOM/qex3WS+Iw0L6YMgSG
   dWtqlUHlTtA1ap3JdWl4QS9sDzgAtaF2Csx2rUQ3zdQIJljI/FJDJnXZQ
   M35mBIIlrdVLRle9oumEPFxp9EYbiaHHH852GlvyPfB7iH1DtEZFtvkt4
   A8Hj/LCKiMBjHxy6I134vUxF+ZwbviBvQh/NWfPW3OMix5sKzRLuub5NM
   xxIWsSS5Pq/rcDSIrhk2gDK/dqfWjxN4LW2CeZl8pFjS3nbO4w1KeEmjz
   Q==;
X-CSE-ConnectionGUID: B6gHCeOWTI6nNMzurcITjw==
X-CSE-MsgGUID: ILsEWoxiQv6Celhr7QSKNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53987015"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53987015"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:05 -0700
X-CSE-ConnectionGUID: ho9m9RoIQfaMTaTkiNiUiQ==
X-CSE-MsgGUID: uFTmw4W8RZi4qDgmu8YOhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622634"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:01 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 3C6C912137B;
	Wed,  9 Jul 2025 02:11:53 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTd-0044oP-0i;
	Wed, 09 Jul 2025 02:11:53 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight@aculab.com>,
	Jakob Hauser <jahau@rocketmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] iio: magnetometer: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:52 +0300
Message-Id: <20250708231152.971801-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8974.c        | 2 --
 drivers/iio/magnetometer/ak8975.c        | 1 -
 drivers/iio/magnetometer/als31300.c      | 2 --
 drivers/iio/magnetometer/bmc150_magn.c   | 6 ++----
 drivers/iio/magnetometer/tmag5273.c      | 2 --
 drivers/iio/magnetometer/yamaha-yas530.c | 2 --
 6 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 947fe8a475f2..68ece700c7ce 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -583,7 +583,6 @@ static int ak8974_measure_channel(struct ak8974 *ak8974, unsigned long address,
 	*val = (s16)le16_to_cpu(hw_values[address]);
 out_unlock:
 	mutex_unlock(&ak8974->lock);
-	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
 	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
 
 	return ret;
@@ -678,7 +677,6 @@ static void ak8974_fill_buffer(struct iio_dev *indio_dev)
 
  out_unlock:
 	mutex_unlock(&ak8974->lock);
-	pm_runtime_mark_last_busy(&ak8974->i2c->dev);
 	pm_runtime_put_autosuspend(&ak8974->i2c->dev);
 }
 
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index a1e92b2abffd..3fd0171e5d69 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -775,7 +775,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	mutex_unlock(&data->lock);
 
-	pm_runtime_mark_last_busy(&data->client->dev);
 	pm_runtime_put_autosuspend(&data->client->dev);
 
 	/* Swap bytes and convert to valid range. */
diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
index f72af829715f..03d060995ba6 100644
--- a/drivers/iio/magnetometer/als31300.c
+++ b/drivers/iio/magnetometer/als31300.c
@@ -140,7 +140,6 @@ static int als31300_get_measure(struct als31300_data *data,
 	*z = ALS31300_DATA_Z_GET(buf);
 
 out:
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
@@ -401,7 +400,6 @@ static int als31300_probe(struct i2c_client *i2c)
 	pm_runtime_set_autosuspend_delay(dev, 200);
 	pm_runtime_use_autosuspend(dev);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	ret = devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 761daead5ada..7c5fef79ad04 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -260,12 +260,10 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(data->dev);
-	} else {
-		pm_runtime_mark_last_busy(data->dev);
+	else
 		ret = pm_runtime_put_autosuspend(data->dev);
-	}
 
 	if (ret < 0) {
 		dev_err(data->dev,
diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 2ca5c26f0091..f9ef501249e3 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -295,7 +295,6 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 
 		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle, &magnitude);
 
-		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
 
 		if (ret)
@@ -668,7 +667,6 @@ static int tmag5273_probe(struct i2c_client *i2c)
 	indio_dev->channels = tmag5273_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tmag5273_channels);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	ret = devm_iio_device_register(dev, indio_dev);
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 340607111d9a..d49e37edcbed 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -623,7 +623,6 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(yas5xx->dev);
 		ret = ci->get_measure(yas5xx, &t, &x, &y, &z);
-		pm_runtime_mark_last_busy(yas5xx->dev);
 		pm_runtime_put_autosuspend(yas5xx->dev);
 		if (ret)
 			return ret;
@@ -664,7 +663,6 @@ static void yas5xx_fill_buffer(struct iio_dev *indio_dev)
 
 	pm_runtime_get_sync(yas5xx->dev);
 	ret = ci->get_measure(yas5xx, &t, &x, &y, &z);
-	pm_runtime_mark_last_busy(yas5xx->dev);
 	pm_runtime_put_autosuspend(yas5xx->dev);
 	if (ret) {
 		dev_err(yas5xx->dev, "error refilling buffer\n");
-- 
2.39.5


