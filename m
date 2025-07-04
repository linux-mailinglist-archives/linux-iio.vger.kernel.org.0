Return-Path: <linux-iio+bounces-21325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F138AF8A7C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54266E5F2A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE6F2D8DA9;
	Fri,  4 Jul 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuCZpGej"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170C2BEC5F;
	Fri,  4 Jul 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615669; cv=none; b=r0P9jL53GLe3Eg0iaRoOYDL+h93WqoFIm8TeCl5hUUBEBX2Kisd9Ti9+3ziFgxFDq4+nCwsjglCJaP3Gntezs9SsLyu7sGUxKcCbJP7/0W3sUAfPsCT+RahNxT4gq5Fw2DD/vsdHYVlMfmi6SagU40K9mVy/gkpYCi+HOXTUfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615669; c=relaxed/simple;
	bh=hodRrjwtQdKJyAnyDT8gDvka1yFbsBbyR3nOMwfXLaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oaKv11wQhcQ2TpL/zBH/obMnyA++Ls58M4IxUNBOLJq/H/hW2jGokpbm1Gd+69DIS09DV1Dg7//6b/wcbc5o+t2ZfbEOY/WS5BoCffIvatp73b2iSDxXhMbmbBF4iuynBRQwJ2fgJern4ErAOxzLXwd5Y2RstLp2gjf49tdyhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuCZpGej; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615667; x=1783151667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hodRrjwtQdKJyAnyDT8gDvka1yFbsBbyR3nOMwfXLaQ=;
  b=HuCZpGejcNKBwgYUtmgDGcQLkDDI4KME9sPKhDbYf8nRQHHIME87PiGM
   xJz3OFf7vfESDm2PqcXJnsMvCAFJbYhAYY4Gj6qOXf+SvX+LQiY7oY+Xy
   9rgoiSq9eXNm2JIIjtFUM2U8t72o+1Gldw9d+jfoN2jXawJNasMMTVUJm
   LWAhjV5YTBRHcZ6r/XG58NX8rD0kD7LJ95lqCcB+VsPNIVKsSOz5E2vpx
   rCLdNmRDgIvPQkFwdu1beR/BsjfpbJWxwZG8yju6KljdNAFb3FMOD0yeB
   Lxqa9pZvhdQMb8+cfhck4Q/N+dzRtOAg9gaEcoiE2oxTTpkOhs3IRD6vz
   g==;
X-CSE-ConnectionGUID: Rixt8luaTEm+MtgoFiyc7g==
X-CSE-MsgGUID: WfMNvqsPQl2Z8wpj1dBAXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494620"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:25 -0700
X-CSE-ConnectionGUID: Nhg5XJTsR8uk/JCZIms7Bw==
X-CSE-MsgGUID: DtTDLEm6RCqiTN8aWa3q5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924255"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:21 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id EEDC54445A;
	Fri,  4 Jul 2025 10:54:18 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Bo Liu <liubo03@inspur.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sean Nyekjaer <sean@geanix.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Francisco Henriques <franciscolealhenriques@usp.br>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/80] iio: accel: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:18 +0300
Message-Id: <20250704075418.3218938-1-sakari.ailus@linux.intel.com>
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

 drivers/iio/accel/bmc150-accel-core.c | 1 -
 drivers/iio/accel/bmi088-accel-core.c | 3 ---
 drivers/iio/accel/fxls8962af-core.c   | 1 -
 drivers/iio/accel/kxcjk-1013.c        | 1 -
 drivers/iio/accel/kxsd9.c             | 3 ---
 drivers/iio/accel/mma8452.c           | 1 -
 drivers/iio/accel/mma9551_core.c      | 1 -
 drivers/iio/accel/msa311.c            | 6 ------
 8 files changed, 17 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index be5fbb0c5d29..f45beae83f8b 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -335,7 +335,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
 	} else {
-		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
 	}
 
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
index 6aefe8221296..44d770729186 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -637,7 +637,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
 	else {
-		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
 	}
 	if (ret < 0) {
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
index aba444a980d9..5863478bab62 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -227,7 +227,6 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 	if (on) {
 		ret = pm_runtime_resume_and_get(&client->dev);
 	} else {
-		pm_runtime_mark_last_busy(&client->dev);
 		ret = pm_runtime_put_autosuspend(&client->dev);
 	}
 
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 3e7d9b79ed0e..22768f43fd24 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -672,7 +672,6 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 	if (on)
 		ret = pm_runtime_resume_and_get(&client->dev);
 	else {
-		pm_runtime_mark_last_busy(&client->dev);
 		ret = pm_runtime_put_autosuspend(&client->dev);
 	}
 
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


