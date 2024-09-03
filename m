Return-Path: <linux-iio+bounces-9084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D938296A616
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798B6B22988
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6849D1917CE;
	Tue,  3 Sep 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUXp0Bu5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5718E03B;
	Tue,  3 Sep 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386550; cv=none; b=i66Yf6qclT+3+0qqx/uyRTp+CmxBh8+v4o70mO3oA2n3H3TCfyApeVdvmVJV568BNwQiCl9mPx/JLTKbUzn3ama+Wa+0znDXDVBmu+EhLlCE8kOrOI60PQCkoTNsmEuZt5P0nwOaxouM9PIsp8G4Qh+ceJmK2luXmXIEVKhjvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386550; c=relaxed/simple;
	bh=sxUw7sTT1Ze0YVA00KOQGbPUOTeTK2TesmW6TEx4mIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uraU/lKcQN+PvqRmzf70aeO8XN/3JgB8rEFuYLKnPstn2kjioNKxitG9IIsHSSFfTeQPgWgk3nhea6b2GGfpsytjJREEK4LYyWHypORuDhcJdLtXXSYZ0b+qBu35mE3wnZZ8onREgW6EO7dGaYLsh1p14SzCXqkI7ljAUQ7SYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUXp0Bu5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725386548; x=1756922548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sxUw7sTT1Ze0YVA00KOQGbPUOTeTK2TesmW6TEx4mIc=;
  b=DUXp0Bu5mhIZm8skVEVzGlIU0cc++/gzYFNHYyoD5E9DvoecQurGDPGg
   lXPuh9yHLs2HY1L34xvCybe36Eg2d46P1bkP1yYu5qUd5vnztguMT8Vme
   5T5rlakROg1flcSyixoi0Ykbox6xNH4yqtf1K9QbiPnpWxJfaiymJxMcx
   IkQCV0o0z7HzjVoMkp4mDvmdd8u5++48RmFaC04/AW/q6LWAcOXdINsBp
   utwVSCMlrHGXQJHr150FisduiXlqA1uVs5vrZPrZH9HFjd54qno0LUQRP
   zZyX/w1eSNINrlmF7+DcbErNDQnbHSGCC1KyfISgm+hJDyuc30nMpToiV
   Q==;
X-CSE-ConnectionGUID: TW5LFDJhSvygIAiBuMrv5A==
X-CSE-MsgGUID: qGH1wHhOQiCsUlQPb5Fqqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24194284"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24194284"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:02:26 -0700
X-CSE-ConnectionGUID: RtawkUaKSvauPLVCnK/EHQ==
X-CSE-MsgGUID: THljokd+RdCN81b0+sYaAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69151344"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2024 11:02:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9BA3D3C1; Tue, 03 Sep 2024 21:02:21 +0300 (EEST)
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
Subject: [PATCH v2 0/3] iio: Introduce and use aligned_s64 type
Date: Tue,  3 Sep 2024 20:59:03 +0300
Message-ID: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having open coded idea of aligned member, use
a newly defined type like it's done in, e.g., u64 case.
Update a few IIO drivers to show how to use it.

v2 (took only one year from v1, not bad!):
- avoided touching unrelated comments, code lines, etc. (Jonathan)
- used kernel internal type for the in-kernel code (Jonathan)

Andy Shevchenko (3):
  types: Complement the aligned types with signed 64-bit one
  iio: imu: st_lsm6dsx: Use aligned data type for timestamp
  iio: hid-sensor: Use aligned data type for timestamp

 drivers/iio/accel/hid-sensor-accel-3d.c              | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
 drivers/iio/humidity/hid-sensor-humidity.c           | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h              | 3 +--
 drivers/iio/light/hid-sensor-als.c                   | 2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 2 +-
 drivers/iio/orientation/hid-sensor-rotation.c        | 2 +-
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 drivers/iio/pressure/hid-sensor-press.c              | 2 +-
 drivers/iio/temperature/hid-sensor-temperature.c     | 2 +-
 include/linux/types.h                                | 3 ++-
 include/uapi/linux/types.h                           | 1 +
 12 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


