Return-Path: <linux-iio+bounces-21335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B655AF8AA0
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755E51691F7
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47A2E2EE6;
	Fri,  4 Jul 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOhBYska"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129642DECC6;
	Fri,  4 Jul 2025 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615680; cv=none; b=HeKpA2t8mvhgzAHApBWJrQMcA1mpypCPTzGyL4ttnMEFgI0uCv4MpBao2q0H2SD8n8qgMuqp4tJLQxrrP3QWi9DwBZZHHmXVVOQWbSWCF126ukZwcuKloWqPJfYxjpbxVp9F6bZ/5eyvWHOBhluAHIlNnBDro2i0k/DxymudCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615680; c=relaxed/simple;
	bh=KXGcRkCRmz1Yw49o+1krTntMeAh4fibBDbmqTKlKnJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2UiKrjX7pWYb1kWglgeWGwFQhZBjuWFP3Zosf7mhM+dO4iVGI3pwhSnJPEg4pe/81l5EsK/SAadHHqpeNQ7xn5P2oaaoU8OnbrI8FDK3knlo7cnRCEFGyUP8+ExAWWcI/frvfIt1cNzPgB+zRodUiq7vZX0TfNlqXyZnZ2u4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOhBYska; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615678; x=1783151678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXGcRkCRmz1Yw49o+1krTntMeAh4fibBDbmqTKlKnJc=;
  b=mOhBYskac4u/u7hsom1f0v5Q7AsmI4pENvjpevX4wsJKvE6jgDyACe1l
   i9H9ShyDahabrar7OnWns3a+TAA8GtAD4imR1m9xYID8iS1tiqLz+9FWG
   2IurM4fspzh7YoChthDhbvzw4pTltFvq0ko6PpcUEWt1fe5Qfnk5jzah9
   KVZTRfnkIz7cNez+sPOgl25R5fb3CzgS/hTm5YibE9AXQQW9yDXgTjBed
   3vAnzQhUA9aNmV+/gjHIxhC76XZxy/JXEtMd5XVT/2ZV/nwbbQ3qFrJEl
   DZvF74X/OECCmIGnaa8OpfUotTTY7xNiB0s2Iyt98VWzGyrNRGTaj0V56
   A==;
X-CSE-ConnectionGUID: VAPZc6yZRHaNzqJG5yHHLg==
X-CSE-MsgGUID: 6QcJjU9CQDOCKn6tITgE9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494767"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494767"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:33 -0700
X-CSE-ConnectionGUID: 0Yoxver4SRSwG28kmp1JFg==
X-CSE-MsgGUID: HXkGrzJVS7uANh8xY2lUDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924290"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:28 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 02D0B4445A;
	Fri,  4 Jul 2025 10:54:26 +0300 (EEST)
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
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Hans de Goede <hansg@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jakob Hauser <jahau@rocketmail.com>,
	David Laight <david.laight@aculab.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 35/80] iio: magnetometer: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:25 +0300
Message-Id: <20250704075425.3219648-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
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
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/iio/magnetometer/ak8974.c        | 2 --
 drivers/iio/magnetometer/ak8975.c        | 1 -
 drivers/iio/magnetometer/als31300.c      | 2 --
 drivers/iio/magnetometer/bmc150_magn.c   | 1 -
 drivers/iio/magnetometer/tmag5273.c      | 2 --
 drivers/iio/magnetometer/yamaha-yas530.c | 2 --
 6 files changed, 10 deletions(-)

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
index 761daead5ada..53d860e640a9 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -263,7 +263,6 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(data->dev);
 	} else {
-		pm_runtime_mark_last_busy(data->dev);
 		ret = pm_runtime_put_autosuspend(data->dev);
 	}
 
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


