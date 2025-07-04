Return-Path: <linux-iio+bounces-21329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D696AF8A7D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FFD1C84C10
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8A2DAFC8;
	Fri,  4 Jul 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjHA7Ifo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802772D8DDF;
	Fri,  4 Jul 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615671; cv=none; b=rcqvqCEGhyGhufiycgfKnb5wPIh5KT4beVSoUHZ2kxLYrghXjohJ9m3/D1dbzmQychnt21RVe9/+IXzGpNghO5jRR5DLOL8gj3KJGdX5Dnx70Nl3Jk0aq+Gd72eF00pM7b2KZXdEwIFGck169Jncss7Pz1gX9IcPopI0/EbmBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615671; c=relaxed/simple;
	bh=qbtIAI5uewIloEDrr1CezLGRWGhcnEHM5qLOuB4lMpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDq6OQwfXL5H2/WJArA2Qtq23WX5TxZrxtMJEQHd0lvDIu1k/mErgxdm7Aonl+BO3dlTCk4hEJGfVf/orektNwly0Z4FQekk2jWQP3mwyve62AVGrFxM2pWYofP6g5D6/T+l5WQg8pf3A9z8PtpJ5663LXt+3XXnAe56r1zKu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjHA7Ifo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615669; x=1783151669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qbtIAI5uewIloEDrr1CezLGRWGhcnEHM5qLOuB4lMpw=;
  b=YjHA7IfofF//qKXbqbohx2YBhyjGRCDM9H8LAMMJ4cY7gRcKOzxEF7p1
   2u6pfsY187OqNRDpiZbxICb4TgX1Snp+R1g/jbGofx43O1DndK/gT+QVB
   16DeaxRL80sZ1pz80X0YdA3eOH/5KayvszxTyanw1sm74We3fKgrn+5jH
   AoLpXYd/ZmOaI7zmzkKz+IbSRdYBZVuTRsX2O4UXHiLsIRaAYsFphgx+V
   7JKUqC7KAMWrnN10bBSybrMZIVzOZco3qgWgc+jlUWAtO8xXwHIwg4p++
   Y9YRnbYCwS6/RkbalJJC0TTAeL5MXIiws/8X9ktpp6DB1TVa3rsYsbBdo
   w==;
X-CSE-ConnectionGUID: Xs6hYK3dRIGpr/F019v61Q==
X-CSE-MsgGUID: AZaOR70qTpupVRV+F28F4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494680"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494680"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:28 -0700
X-CSE-ConnectionGUID: ZasxoBPFS3+kUOoWDH4WVg==
X-CSE-MsgGUID: 0Tl0AWXQQq2Do/O0e42OXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924277"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:26 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 06D7944424;
	Fri,  4 Jul 2025 10:54:24 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 33/80] iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:23 +0300
Message-Id: <20250704075423.3219461-1-sakari.ailus@linux.intel.com>
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

 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c   | 1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 6 ------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      | 1 -
 drivers/iio/imu/kmx61.c                            | 1 -
 7 files changed, 20 deletions(-)

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
index 55c82891e08c..42016d56c852 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -750,7 +750,6 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
 	} else {
-		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
 	}
 	if (ret < 0) {
-- 
2.39.5


