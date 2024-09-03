Return-Path: <linux-iio+bounces-9085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7E96A619
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DCE1C23720
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 18:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C6191F62;
	Tue,  3 Sep 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rl9H3hru"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9C190682;
	Tue,  3 Sep 2024 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386550; cv=none; b=SrH9QoZf2YywJ3/ETJSSbgvr4fQpKWZY+3RlUTc7TaI12T9O+RTef1kN09q3xRA6TvgF/I+YEnn7K8GzzJ6ppkYDARjoswTjqkY7lrZUV+tHrkhpjrFd0owQOjYQF1csLw2jxuOt+3cX9hE+ErefNoTKWN47bLSrNNyXArV0sWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386550; c=relaxed/simple;
	bh=WXdmBtP+Y0S73T1rCgBKBG+heoNHf4g8ekVA/ZA9/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1Jl9m8EcQXWGMxepe81yL2Bq6ZumVZaMtNzS3ACrYAskUIEvpOy5a8zGmiSYS4hY4fUXHoz2btFnQCbckRB1oCoDDjbjCARTdiWXDOBv+JZOKDfg/4WjipCb1nP8ckXWmlUNBuMJb50NG8MtEMywrGMXs+QHZtlqdPltD6DcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rl9H3hru; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725386549; x=1756922549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXdmBtP+Y0S73T1rCgBKBG+heoNHf4g8ekVA/ZA9/Kc=;
  b=Rl9H3hruJ8vhjxrjA/0RGgOcSF5TLbJi7mbHLFEFic6FabCf2ewRpExu
   GS0ll65r4FzrOj5i/saOx10nNJwfXprfBw+XJCzE0hIvJHzTlKM8fuzUh
   Help1Hnmqgf3VQYt4PNfoNUntYYOMeqRDVEjBWL5ym0v5U02I+fN63V/R
   Db4qBpJ5jugdhAGhVCUQvlvzX1kMc5Umxh5k92y9IhD73rfs7Gua27gkS
   e5ECs4USPvwPIyGM20+MH1LX9x8ju9V5SGzgqYOfrQVhmDVO60PrcV1rD
   g5PY80eT8M4qKB72mEOKFGkw/nj9JDLYTKC784ZciZnXd4TsHRK2TPaTU
   A==;
X-CSE-ConnectionGUID: JkpAfN8ISymsfMaPZt+R8A==
X-CSE-MsgGUID: 2Kw13RiZRf2fVhCrTho2nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24194288"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24194288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:02:26 -0700
X-CSE-ConnectionGUID: XlidVr0OQF2XCKfpaEqy5w==
X-CSE-MsgGUID: Y3RlitJTSYaqgy1paMchdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69151346"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2024 11:02:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B712EAF3; Tue, 03 Sep 2024 21:02:21 +0300 (EEST)
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
Subject: [PATCH v2 2/3] iio: imu: st_lsm6dsx: Use aligned data type for timestamp
Date: Tue,  3 Sep 2024 20:59:05 +0300
Message-ID: <20240903180218.3640501-3-andriy.shevchenko@linux.intel.com>
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

Use __aligned_s64 for the timestamp field.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a3b93566533b..d5e2771042bd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -444,10 +444,9 @@ struct st_lsm6dsx_hw {
 	const struct st_lsm6dsx_settings *settings;
 
 	struct iio_mount_matrix orientation;
-	/* Ensure natural alignment of buffer elements */
 	struct {
 		__le16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan[ST_LSM6DSX_ID_MAX];
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


