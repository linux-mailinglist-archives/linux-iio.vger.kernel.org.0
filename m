Return-Path: <linux-iio+bounces-9086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29D96A61B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 20:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0D01C24173
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658D190063;
	Tue,  3 Sep 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfnME7bX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0918FDC9;
	Tue,  3 Sep 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386558; cv=none; b=ZZv4mOztWIzbUlkhWEVL68uPJSRJklMW3FgI+ntFU5V4ZduMB0ISsz72lCeCnOjjecaIOtCCqRuRxmQnI+a2Lj4vfOokxhOtZw12GVxPWYbEI992bvVajgG1b1NGpGC28gPVc4JgIafepTwbZOtCjs22Hj3B+9S+nild2shiJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386558; c=relaxed/simple;
	bh=15lUl9DT/EEDyPW+SspeiBhFvrArESxMwxZwES6PhF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKRpiMGCHvUBCY82M3/DkfwI4PTIjniCnOjtr/BpCZDEhbEKcQn756ajT579kpXsP6Fau54Pj1PFvb64fVxoTUSiRT4+vUzPuh6QIRDMNlySXEhEV46WP8eRoSspoJcKqNIqCWa1X02f2n4ENfDa7WAP/lB9UuS6DklbJRkUghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfnME7bX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725386557; x=1756922557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15lUl9DT/EEDyPW+SspeiBhFvrArESxMwxZwES6PhF4=;
  b=XfnME7bXAyS+vUOa8d2unGYFbBlV0aLPLHMRjHc6l702QBXXdrr0EEyQ
   j/UaQZALP8NcJzLfzgB14J74bSuFg1f611/MoUeUQ7asoAJg/Kw/ozfo2
   FMa0QevuZ13pAIXAVB9OBpcbOGzdb11oWnk4P5jaEstz7LHq6zlrevRma
   HOy4dp0wCN8fP8KCoxsExTgkQGHwrWQIDXXUV/f1VrvmuGzG21y8uY/Bh
   ypndavobqhi2IZTvHaHrzZ6a2cP/I7slUHvruxwT7yhphQDTliofWy32n
   77+N4GVnI0S/JFoCVzn6piN46amH/2NoNr9ig+bxJufnuSrkvDSY0xjUB
   w==;
X-CSE-ConnectionGUID: kvn7TpP/SweLVJ38tUDeAQ==
X-CSE-MsgGUID: F1gC/DitRqqhIG4VWRHWnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="41476152"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="41476152"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:02:36 -0700
X-CSE-ConnectionGUID: tIiyXnQMTKWaOo5zYPHPlw==
X-CSE-MsgGUID: bcb6TimOQ4CaSJBCmlwHcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65503890"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 03 Sep 2024 11:02:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C408EB34; Tue, 03 Sep 2024 21:02:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 3/3] iio: hid-sensor: Use aligned data type for timestamp
Date: Tue,  3 Sep 2024 20:59:06 +0300
Message-ID: <20240903180218.3640501-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
References: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use aligned_s64 for the timestamp field.

Note, the actual data is signed, hence with this we also amend that.
While at it, drop redundant __alignment directive.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c              | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
 drivers/iio/humidity/hid-sensor-humidity.c           | 2 +-
 drivers/iio/light/hid-sensor-als.c                   | 2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 2 +-
 drivers/iio/orientation/hid-sensor-rotation.c        | 2 +-
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 drivers/iio/pressure/hid-sensor-press.c              | 2 +-
 drivers/iio/temperature/hid-sensor-temperature.c     | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 9b7a73a4c48a..431a12171504 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -28,7 +28,7 @@ struct accel_3d_state {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u32 accel_val[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 59a38bf9459b..d6562bd425f2 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -27,7 +27,7 @@ struct gyro_3d_state {
 	struct hid_sensor_hub_attribute_info gyro[GYRO_3D_CHANNEL_MAX];
 	struct {
 		u32 gyro_val[GYRO_3D_CHANNEL_MAX];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index bf6d2636a85e..eb1c022f73c8 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -18,7 +18,7 @@ struct hid_humidity_state {
 	struct hid_sensor_hub_attribute_info humidity_attr;
 	struct {
 		s32 humidity_data;
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 260281194f61..0c1d97aecd71 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -31,7 +31,7 @@ struct als_state {
 	struct iio_chan_spec channels[CHANNEL_SCAN_INDEX_MAX + 1];
 	struct {
 		u32 illum[CHANNEL_SCAN_INDEX_MAX];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 8943d5c78bc0..f5e5fb68caf8 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -29,7 +29,7 @@ struct incl_3d_state {
 	struct hid_sensor_hub_attribute_info incl[INCLI_3D_CHANNEL_MAX];
 	struct {
 		u32 incl_val[INCLI_3D_CHANNEL_MAX];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 5e8cadd5177a..501c312ce752 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -20,7 +20,7 @@ struct dev_rot_state {
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
 		s32 sampled_vals[4] __aligned(16);
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 76e173850a35..6239e2f72a05 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -39,7 +39,7 @@ struct hinge_state {
 	const char *labels[CHANNEL_SCAN_INDEX_MAX];
 	struct {
 		u32 hinge_val[3];
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 
 	int scale_pre_decml;
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 956045e2db29..0419bb3c3494 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -24,7 +24,7 @@ struct press_state {
 	struct hid_sensor_hub_attribute_info press_attr;
 	struct {
 		u32 press_data;
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 0143fd478933..d2209cd5b98c 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -18,7 +18,7 @@ struct temperature_state {
 	struct hid_sensor_hub_attribute_info temperature_attr;
 	struct {
 		s32 temperature_data;
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
-- 
2.43.0.rc1.1336.g36b5255a03ac


