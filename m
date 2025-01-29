Return-Path: <linux-iio+bounces-14712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA29A22032
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242B21887EB2
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BCE1DE4C6;
	Wed, 29 Jan 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhX2Dh59"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAC1DDC35;
	Wed, 29 Jan 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164356; cv=none; b=gcq7899VyagArY6h8ntBCl2+A6w6/QPBA8FzcPIKmDCeaqmTVB7AMWH77r34SPvt6ahPBLfkPtB7Wfey7YbWj01TCtOcFX2euTcCnLEbD3WnaNsTlx5PJR5SH2WZHR0z+tQIxqFeyT1sxMb6sNZ99SDRfXHydqaoZSG7bK568BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164356; c=relaxed/simple;
	bh=a+rrefX8dP/2cjWiPdFir1iGJYrcjbldK4bZrM4dDcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toOVrDcSUZLiCrU4WETWTl3Ymdae85A7sBkD1nBuv8/C8Ry0OzbWl9eNb9/yQhZOCz9GuxEQQHdChaf8/UuuXvaUb/bPmxL44XvlqNCRmSfsAk7h2kV7FeBeCewdZs/R7Q+DSNpa+B2A8GwtM61a32BorTsDAdmh1pJ+EdrsWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhX2Dh59; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738164355; x=1769700355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a+rrefX8dP/2cjWiPdFir1iGJYrcjbldK4bZrM4dDcs=;
  b=DhX2Dh59nhtl48ry78KMXBCWYFWz6oE6vuwM3Kg+RVsrtKLxd2fB35Oo
   fTgwWFAgfPVp7ko0HOERKBtHuNMeGrgGxvYm9gzPexzr1xfFSouSdtW9/
   AhvAVSqSJWbovoMaMcpdxdADnDvEAPI97LttM6P7xI/dxnT3yXrJiMwjV
   HtN7H2ZSwatTxWjL/iovhzV37zgTJ8mmgT3wH9DUIiUD1uvwjSMf51Stw
   IH/2Q+OuwJA6dNidC9A5P4GH9BH3BOStDE9HFu0HBYniIvMx3MuixOAB5
   n25TgZ3QLodeVW4prVJJ/nXRRtZonrJZ2tF4R0m/a9rpxUSmSCehI3sE7
   g==;
X-CSE-ConnectionGUID: U1vkYZh+TvSwlTVWkB/EVg==
X-CSE-MsgGUID: DOtk9b5QTs+nHO3NoVkkOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37879638"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="37879638"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 07:25:52 -0800
X-CSE-ConnectionGUID: Rn9XHpLNRbW49haca4KIEQ==
X-CSE-MsgGUID: 2s/nJ1i8QjaDViBfDUiexA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114051107"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 29 Jan 2025 07:25:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D02634CC; Wed, 29 Jan 2025 17:25:47 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Icenowy Zheng <icenowy@aosc.io>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] iio: drop useless assignment of cache_type
Date: Wed, 29 Jan 2025 17:24:39 +0200
Message-ID: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Default value is REGCACHE_NONE, no need to assign it explicitly.
Fix all IIO drivers that do that.

Andy Shevchenko (3):
  iio: light: adux1020: Drop unneeded assignment for cache_type
  iio: magnetometer: af8133j: Drop unneeded assignment for cache_type
  iio: pressure: zpa2326: Drop unneeded assignment for cache_type

 drivers/iio/light/adux1020.c       | 1 -
 drivers/iio/magnetometer/af8133j.c | 1 -
 drivers/iio/pressure/zpa2326_i2c.c | 1 -
 drivers/iio/pressure/zpa2326_spi.c | 1 -
 4 files changed, 4 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


