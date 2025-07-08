Return-Path: <linux-iio+bounces-21454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC46AFDBA2
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0216480E6C
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58716239E86;
	Tue,  8 Jul 2025 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNh8IZDW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB452367BF;
	Tue,  8 Jul 2025 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016321; cv=none; b=grI8x4rGmO3JZsOOwr/q4nDuLJG1qQKuITUB2spv7g8mabunPTlgQ2+5k5cACC48h5FN0uP9nZEvC2t30PtQ22FWWXGqHJJ87MCs2yD/HWACnQ/oao0uky3PIhYX8yDB8UE2GMmUL8VIjRSy5VtFgs1XgEsTK6QPT/Otu5VjS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016321; c=relaxed/simple;
	bh=X1oeJ/Aqk3Svu4xL+7GP26tXuc1UXwViicS7mHHy4R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mj5TGTr6gCJvq5bj1d3kKlrpdaPN7StTL5wsc786sPMbXQYTEzWwlFzZ7o6gV/XZpn/+JObRNRqoyGCnjIqMSUN8bYCrVBnckR4VoECLWGONBs1Ob3qJawkYEzf+SlAT3VMnYBEVzyS3bOQBtDeBYgLYOaB8IYC5fRiqWO3EZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNh8IZDW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016319; x=1783552319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X1oeJ/Aqk3Svu4xL+7GP26tXuc1UXwViicS7mHHy4R4=;
  b=cNh8IZDWqjBTPtIyLItebCU5NG6h+wrGfvt07tQyY1/C4fKpz/MkWamy
   i5aeP39sI3+AvmaEFoaZ9/ajQkWpsEhbmNuevJzRqaKlIHEzGh/aNeC8C
   nHNVsQnyA880xBh8waxTNHKomxWRi91utq+F7khC0u+w+IYZsNY2esnCN
   684J1+aceNUd6nSrAJLQbhuMAoOjs2g04pSJs6YNvGAjZSiS24A9r2kdY
   7yvdbPk95P4e/7+AuKS/4zmtG6PnRhbGExEg5SHm3wwaqXeOCBsnwUwTn
   M/LBxATKn9klKtNGCEJG8MHRLmGYLJGPrLyyrP8r8++kCQLivv5rpqTDL
   Q==;
X-CSE-ConnectionGUID: pjySYsykTQeZOmn6H0T4ZA==
X-CSE-MsgGUID: u3FrVJbvRRuVCb5ikyIPpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986892"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986892"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:58 -0700
X-CSE-ConnectionGUID: lVxaFpnNQ1ixoeLNWDuFNw==
X-CSE-MsgGUID: lNUlbC2CTUaDFCkGgSOJdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622608"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:54 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 14BFB12090D;
	Wed,  9 Jul 2025 02:11:52 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTc-0044fc-01;
	Wed, 09 Jul 2025 02:11:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Bo Liu <liubo03@inspur.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sean Nyekjaer <sean@geanix.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Francisco Henriques <franciscolealhenriques@usp.br>,
	Gustavo Vaz <gustavo.vaz@usp.br>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] iio: accel: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:51 +0300
Message-Id: <20250708231151.971256-1-sakari.ailus@linux.intel.com>
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
---
 drivers/iio/accel/bmc150-accel-core.c | 6 ++----
 drivers/iio/accel/bmi088-accel-core.c | 3 ---
 drivers/iio/accel/fxls8962af-core.c   | 1 -
 drivers/iio/accel/kxcjk-1013.c        | 4 +---
 drivers/iio/accel/kxsd9.c             | 3 ---
 drivers/iio/accel/mma8452.c           | 6 ++----
 drivers/iio/accel/mma9551_core.c      | 4 +---
 drivers/iio/accel/msa311.c            | 6 ------
 8 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index be5fbb0c5d29..fe1783d439de 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -332,12 +332,10 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		pm_runtime_mark_last_busy(dev);
+	else
 		ret = pm_runtime_put_autosuspend(dev);
-	}
 
 	if (ret < 0) {
 		dev_err(dev,
diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index dea126f993c1..c7da90af0d2d 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -375,7 +375,6 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 
 out_read_raw_pm_put:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -419,7 +418,6 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = bmi088_accel_set_scale(data, val, val2);
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -428,7 +426,6 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = bmi088_accel_set_sample_freq(data, val);
-		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 		return ret;
 	default:
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 12598feaa693..8afd151c03ad 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -222,7 +222,6 @@ static int fxls8962af_power_off(struct fxls8962af_data *data)
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	pm_runtime_mark_last_busy(dev);
 	ret = pm_runtime_put_autosuspend(dev);
 	if (ret)
 		dev_err(dev, "failed to power off\n");
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 6aefe8221296..2823ddde4bf2 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -636,10 +636,8 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 
 	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else {
-		pm_runtime_mark_last_busy(&data->client->dev);
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: %s for %d\n", __func__, on);
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index cfc31265cdd0..4717d80fc24a 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -151,7 +151,6 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 		ret = kxsd9_write_scale(indio_dev, val2);
 	}
 
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return ret;
@@ -199,7 +198,6 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 	}
 
 error_ret:
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return ret;
@@ -250,7 +248,6 @@ static int kxsd9_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	pm_runtime_mark_last_busy(st->dev);
 	pm_runtime_put_autosuspend(st->dev);
 
 	return 0;
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index aba444a980d9..393294df02db 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -224,12 +224,10 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&client->dev);
+	else
 		ret = pm_runtime_put_autosuspend(&client->dev);
-	}
 
 	if (ret < 0) {
 		dev_err(&client->dev,
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 3e7d9b79ed0e..247c2eda8420 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -671,10 +671,8 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 
 	if (on)
 		ret = pm_runtime_resume_and_get(&client->dev);
-	else {
-		pm_runtime_mark_last_busy(&client->dev);
+	else
 		ret = pm_runtime_put_autosuspend(&client->dev);
-	}
 
 	if (ret < 0) {
 		dev_err(&client->dev,
diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 3e10225410e8..ec70a517c0a9 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -607,7 +607,6 @@ static int msa311_read_raw_data(struct iio_dev *indio_dev,
 	err = msa311_get_axis(msa311, chan, &axis);
 	mutex_unlock(&msa311->lock);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	iio_device_release_direct(indio_dev);
@@ -741,7 +740,6 @@ static int msa311_write_scale(struct iio_dev *indio_dev, int val, int val2)
 			break;
 		}
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	if (err)
@@ -781,7 +779,6 @@ static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 			break;
 		}
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	iio_device_release_direct(indio_dev);
@@ -832,7 +829,6 @@ static int msa311_debugfs_reg_access(struct iio_dev *indio_dev,
 
 	mutex_unlock(&msa311->lock);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	if (err)
@@ -855,7 +851,6 @@ static int msa311_buffer_postdisable(struct iio_dev *indio_dev)
 	struct msa311_priv *msa311 = iio_priv(indio_dev);
 	struct device *dev = msa311->dev;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -1231,7 +1226,6 @@ static int msa311_probe(struct i2c_client *i2c)
 	if (err)
 		return err;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	err = devm_iio_device_register(dev, indio_dev);
-- 
2.39.5


