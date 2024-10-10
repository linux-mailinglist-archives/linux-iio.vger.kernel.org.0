Return-Path: <linux-iio+bounces-10411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D023998F92
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2201F24F0D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51DA1CB303;
	Thu, 10 Oct 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cx+eS+vk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88B19AA75;
	Thu, 10 Oct 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584146; cv=none; b=fiM5p8zDQiyVVaY+FLaN/RH/KuQWKfeN2H3inj37ZKTy+t8MopCpo1B3ewOJVX+ijyy+5D33+5bJQvwo/ICcX4u+Yv4kwviB8DE2aTV4cWhHfnGwJ24thcNCztlz4zcykV+g/BzcfWSL8Od2zvW0YvxUtS7AsXnWOoefG8Tzj+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584146; c=relaxed/simple;
	bh=Sa7h91+6d1o7OSMAqD81PIFnEOb4b5qX62U+JceZIL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kTfTyORAuZHjY/D2hC3tko7Wq/mUKkmCHngsXiTY4RrtFqREM60VIcvZ/SuTu87U4YaagZSctaDaDQn7CMdPXj+hH0O9aH18mv1eQnaSRq3/K+9vi7evrimKTI1qEp1qAipD9PN698iYHvBoOtwEhK/8Qb5U0SwQ/+ORKDYnn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cx+eS+vk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728584145; x=1760120145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sa7h91+6d1o7OSMAqD81PIFnEOb4b5qX62U+JceZIL8=;
  b=Cx+eS+vkLsIUQ33m0IdFIpPihQUbNtAjZrdN+UJnZEbbeVCeTHf7PE2T
   Z9aavdRYt3tHfgO1+2YqNn7ZKM+m1HcTMVidnVyw3IxSydvwgQe06gv1K
   siz/76J3nP7eej2U5SwsdHtZDZwYPD6Vqr9SnjnINREX5Npbcp1ibdY+I
   S3ikdUt7TQz8dFY44NZpfRw1gA71wW+HI1rh/vxheOO/ToBAt2gIE/x9y
   gJGYUg/MxGjlDX+qBKite0rmdBM6uC8w2z8vOSsNzlZcqYW4pLKMcOJ8j
   JWy/HhKjyL4/6Maj+cVZHpTUh2yPVsfBDmY3Y86hD5iywAu/DD90pzVXY
   w==;
X-CSE-ConnectionGUID: eFJWUTNFQECgojKZ2Li/qg==
X-CSE-MsgGUID: 8+Y/5LPfQOeSEusLC/Rc8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28076474"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28076474"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:15:42 -0700
X-CSE-ConnectionGUID: ldJPhoapTX2Sdt8Z53xf+A==
X-CSE-MsgGUID: dzC4wgKTSoiec32kVkl+tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="80675975"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 10 Oct 2024 11:15:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0E52B1BD; Thu, 10 Oct 2024 21:15:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: Convert unsigned to unsigned int
Date: Thu, 10 Oct 2024 21:15:35 +0300
Message-ID: <20241010181535.3083262-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simple type conversion with no functional change implied.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/iio/iio-opaque.h |  2 +-
 include/linux/iio/iio.h        | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
index 5aec3945555b..a89e7e43e441 100644
--- a/include/linux/iio/iio-opaque.h
+++ b/include/linux/iio/iio-opaque.h
@@ -70,7 +70,7 @@ struct iio_dev_opaque {
 
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry			*debugfs_dentry;
-	unsigned			cached_reg_addr;
+	unsigned int			cached_reg_addr;
 	char				read_buf[20];
 	unsigned int			read_buf_len;
 #endif
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 18779b631e90..3a9b57187a95 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -282,11 +282,11 @@ struct iio_chan_spec {
 	const struct iio_chan_spec_ext_info *ext_info;
 	const char		*extend_name;
 	const char		*datasheet_name;
-	unsigned		modified:1;
-	unsigned		indexed:1;
-	unsigned		output:1;
-	unsigned		differential:1;
-	unsigned		has_ext_scan_type:1;
+	unsigned int		modified:1;
+	unsigned int		indexed:1;
+	unsigned int		output:1;
+	unsigned int		differential:1;
+	unsigned int		has_ext_scan_type:1;
 };
 
 
@@ -541,13 +541,13 @@ struct iio_info {
 	int (*update_scan_mode)(struct iio_dev *indio_dev,
 				const unsigned long *scan_mask);
 	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
-				  unsigned reg, unsigned writeval,
-				  unsigned *readval);
+				  unsigned int reg, unsigned int writeval,
+				  unsigned int *readval);
 	int (*fwnode_xlate)(struct iio_dev *indio_dev,
 			    const struct fwnode_reference_args *iiospec);
-	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned val);
+	int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned int val);
 	int (*hwfifo_flush_to_buffer)(struct iio_dev *indio_dev,
-				      unsigned count);
+				      unsigned int count);
 };
 
 /**
@@ -609,7 +609,7 @@ struct iio_dev {
 	int				scan_bytes;
 
 	const unsigned long		*available_scan_masks;
-	unsigned			__private masklength;
+	unsigned int			__private masklength;
 	const unsigned long		*active_scan_mask;
 	bool				scan_timestamp;
 	struct iio_trigger		*trig;
-- 
2.43.0.rc1.1336.g36b5255a03ac


