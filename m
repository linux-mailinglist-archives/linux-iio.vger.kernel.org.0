Return-Path: <linux-iio+bounces-21457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F5AFDBA8
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38341C276FC
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F72641C8;
	Tue,  8 Jul 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMr4ADAT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9B24397A;
	Tue,  8 Jul 2025 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016324; cv=none; b=eUnki5jPXrBurVBj8nJjrH94ZSV3RysNe9vqwR5KL5QZSpQs6WvglD9Q16B2ZbOrEitUIGoclDrVvP54kmu4e1qlpmyxZPX60i7byPwIZnzLgmT9Oae4deaukcQwkuB9neSg+a/HYTLPTc4FwzcWNS2w8gH4XrjbTwVvuf2HcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016324; c=relaxed/simple;
	bh=bWhbP3VuPV3S2LcHQFWpWHV8L/eXRJG+MjsHwV1hkZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=heFb9864JiVs78nf3QfWaE2YpMW/AYcvH7KK3OpgFSNJPKQFleFpJbOMOamc9gjoMLoGtr0kQOOYzw1Nt0Vls0ggytCm9UWhE0SUKibi4ur7aCn2NTubfnHRO85UePrY4cPbuIyJlKEx3kxbKizEcdB80YKhwODk2KBgC2xK8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMr4ADAT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016322; x=1783552322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bWhbP3VuPV3S2LcHQFWpWHV8L/eXRJG+MjsHwV1hkZg=;
  b=dMr4ADATcXqlsLtlk+OIv1s7yOpFXCHjt6RAR5V/WaDND7uubgq9iYGW
   SbCfrIsPthhQlfSI1jZF9nRFFFm+Ns9NvRD1H8LixJwJRkDE6QKV7dZ++
   WhbsYGPBJj4b6PeGO1pLUibQyQAXPP0WMFDTxQFStOef1JcbZ9+JGs/n9
   sZ2c3OVClGRtI9HKGZIRw+EH5MtAs5MUTo/CecVg34XgO6+Uid/cOhDWJ
   Ho+ZwtVS4FmErMnH+Wzr4gdiqUipkYAB39LMGllCCVs9ZW3ulAvfGJ3u2
   pj2LnRR5R2OjrG/C+zMxaCcoZtKp/yyKipbmkXQG06eLY5BIqjKm3miC2
   A==;
X-CSE-ConnectionGUID: UJ3z40gLSeKTrwP5HlfSGg==
X-CSE-MsgGUID: mIeoQHrETvyYBfFRkViu7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986957"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986957"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:02 -0700
X-CSE-ConnectionGUID: 0wMPOGKVSo+6DB8Z0zeGmw==
X-CSE-MsgGUID: /vWsDwttT+KKJexu1f9XEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622624"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:12:00 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id CAD5C121204;
	Wed,  9 Jul 2025 02:11:52 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTc-0044m0-2b;
	Wed, 09 Jul 2025 02:11:52 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:52 +0300
Message-Id: <20250708231152.971651-1-sakari.ailus@linux.intel.com>
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
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   | 1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 6 ------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      | 1 -
 drivers/iio/imu/kmx61.c                            | 6 ++----
 7 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 8a6f09e68f49..11cab815e1e2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -289,7 +289,6 @@ static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 exit:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -367,7 +366,6 @@ static int inv_icm42600_accel_write_scale(struct iio_dev *indio_dev,
 	ret = inv_icm42600_set_accel_conf(st, &conf, NULL);
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -471,7 +469,6 @@ static int inv_icm42600_accel_write_odr(struct iio_dev *indio_dev,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -523,7 +520,6 @@ static int inv_icm42600_accel_read_offset(struct inv_icm42600_state *st,
 	memcpy(data, st->buffer, sizeof(data));
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	if (ret)
 		return ret;
@@ -661,7 +657,6 @@ static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 00b9db52ca78..8c36ad87f328 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -439,7 +439,6 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	if (sleep)
 		msleep(sleep);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 9ba6f13628e6..8a7cc9127631 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -184,7 +184,6 @@ static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
 		ret = -EINVAL;
 exit:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -283,7 +282,6 @@ static int inv_icm42600_gyro_write_scale(struct iio_dev *indio_dev,
 	ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -378,7 +376,6 @@ static int inv_icm42600_gyro_write_odr(struct iio_dev *indio_dev,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
@@ -430,7 +427,6 @@ static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
 	memcpy(data, st->buffer, sizeof(data));
 
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	if (ret)
 		return ret;
@@ -567,7 +563,6 @@ static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
 
 out_unlock:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 8b15afca498c..684007376178 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -37,7 +37,6 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
 
 exit:
 	mutex_unlock(&st->lock);
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b8656c02354a..c351d0e4f810 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -735,7 +735,6 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
 		break;
 	}
 
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 
 	return ret;
@@ -938,7 +937,6 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 		break;
 	}
 
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 error_write_raw_unlock:
 	mutex_unlock(&st->lock);
@@ -1146,14 +1144,12 @@ static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool en)
 			st->chip_config.wom_en = false;
 		}
 
-		pm_runtime_mark_last_busy(pdev);
 		pm_runtime_put_autosuspend(pdev);
 	}
 
 	return result;
 
 error_suspend:
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 	return result;
 }
@@ -1249,7 +1245,6 @@ static int inv_mpu6050_write_event_value(struct iio_dev *indio_dev,
 	value = (u64)val * 1000000ULL + (u64)val2;
 	result = inv_mpu6050_set_wom_threshold(st, value, INV_MPU6050_FREQ_DIVIDER(st));
 
-	pm_runtime_mark_last_busy(pdev);
 	pm_runtime_put_autosuspend(pdev);
 
 	return result;
@@ -1357,7 +1352,6 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	if (result)
 		goto fifo_rate_fail_power_off;
 
-	pm_runtime_mark_last_busy(pdev);
 fifo_rate_fail_power_off:
 	pm_runtime_put_autosuspend(pdev);
 fifo_rate_fail_unlock:
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 5b1088cc3704..10a473342075 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -194,7 +194,6 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		result = inv_mpu6050_prepare_fifo(st, false);
 		if (result)
 			goto error_power_off;
-		pm_runtime_mark_last_busy(pdev);
 		pm_runtime_put_autosuspend(pdev);
 	}
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 55c82891e08c..3cd91d8a89ee 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -747,12 +747,10 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 		data->mag_ps = on;
 	}
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: kmx61_set_power_state for %d, ret %d\n",
-- 
2.39.5


