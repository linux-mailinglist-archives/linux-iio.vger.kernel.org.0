Return-Path: <linux-iio+bounces-21456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA488AFDBA7
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451E91784C7
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1501A262FFE;
	Tue,  8 Jul 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQUHMhUK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A123D28E;
	Tue,  8 Jul 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016323; cv=none; b=HlXtWAaNOgWXjaVPpJY/iGRob8uzjoaRHtot4SuuhPaTr0W4t+raMIPa6KAZGIGGr2w9LewS+qb61uguuwgymgdUNK4F65dAXWcJUWW8RwBtIUppKl4H9v28gODBALPVrIVou0Gjaf/prbUO5uukH5bZ4vqdFiqzIDmoWCB2bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016323; c=relaxed/simple;
	bh=/9Ql1RznOCh/aMvUBxnbO/0kCjv9M5VVSCrcy8ZROAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OY/dL681bWBk5B2pXp2nAGnj9uKHcGTh8yV9I0Kzf+nY9AWYqZntOixAq14rWBpDP5to8dtNvKnxQy0iCBK0C0y0q/bUms7pbFNaXZjMnu2NDdw/4g8gtBv4UQ+GM33E0OxzTJHJqWMuG45lgwVJCfXcM+5nKC3HkHW1CFbHmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQUHMhUK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016322; x=1783552322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9Ql1RznOCh/aMvUBxnbO/0kCjv9M5VVSCrcy8ZROAg=;
  b=eQUHMhUKOBDRhxCZun65o/EsJaUxIZfp+mWPtZokeTwwQkXmyrvqsczK
   tP08RMxymo5VCwIpEuZIF2z1Hmf3Md31iSMwaGAyDBcTUGGRG37R9P0A+
   G83jMBmuYCVG0HkfyX7bETLz4p0zVWC5CTc4V2Fh8Shc9UffpVrz94gul
   cjChIM77FXH9ITYcs2Z7IBuGLnus5XTNUeZIs3J2HhE7fy9AkftOwcU2b
   xo8biUJ0F6Rgoh4eHFnCy0IPgvoZyMGHHaqOZau5SecdTIH9gi3Oe/s6R
   yZkC0zZd+5GdG7+pBDGvQI4QdytUlsxGRJ6HcOAkWr54fGQncqQqzujGA
   A==;
X-CSE-ConnectionGUID: BR8QWPg5SVaQbu2mYolcFA==
X-CSE-MsgGUID: awU9n/hCTTGBF1uGtwaqhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986951"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986951"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:02 -0700
X-CSE-ConnectionGUID: cVmLi5TLQLWii6KuNhD3aQ==
X-CSE-MsgGUID: vQnIcd2KTLqDmAxbcP7fcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622623"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:59 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B4CEF121202;
	Wed,  9 Jul 2025 02:11:52 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTc-0044lD-2I;
	Wed, 09 Jul 2025 02:11:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:52 +0300
Message-Id: <20250708231152.971602-1-sakari.ailus@linux.intel.com>
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
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/bmg160_core.c     | 4 +---
 drivers/iio/gyro/fxas21002c_core.c | 2 --
 drivers/iio/gyro/mpu3050-core.c    | 3 ---
 drivers/iio/gyro/mpu3050-i2c.c     | 1 -
 4 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 781d3e96645f..38394b5f3275 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -309,10 +309,8 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 
 	if (on)
 		ret = pm_runtime_get_sync(dev);
-	else {
-		pm_runtime_mark_last_busy(dev);
+	else
 		ret = pm_runtime_put_autosuspend(dev);
-	}
 
 	if (ret < 0) {
 		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 754c8a564ba4..a88670207cec 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -373,8 +373,6 @@ static int  fxas21002c_pm_put(struct fxas21002c_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 
-	pm_runtime_mark_last_busy(dev);
-
 	return pm_runtime_put_autosuspend(dev);
 }
 
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 16553948c5c3..67ae7d1012bc 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -370,7 +370,6 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
 
 out_read_raw_unlock:
 	mutex_unlock(&mpu3050->lock);
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 
 	return ret;
@@ -662,7 +661,6 @@ static int mpu3050_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 
 	return 0;
@@ -976,7 +974,6 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		if (ret)
 			dev_err(mpu3050->dev, "error resetting FIFO\n");
 
-		pm_runtime_mark_last_busy(mpu3050->dev);
 		pm_runtime_put_autosuspend(mpu3050->dev);
 		mpu3050->hw_irq_trigger = false;
 
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index 8e284f47242c..092878f2c886 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -27,7 +27,6 @@ static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)
 {
 	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
 
-	pm_runtime_mark_last_busy(mpu3050->dev);
 	pm_runtime_put_autosuspend(mpu3050->dev);
 	return 0;
 }
-- 
2.39.5


