Return-Path: <linux-iio+bounces-11771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62579B91CA
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7228390A
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD824174A;
	Fri,  1 Nov 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIsTSwqD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A519BBC;
	Fri,  1 Nov 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467033; cv=none; b=IhQaqX4DCXspYOjXsCy2jRoltIplTjg+Uto142C8sO9e1z50F0m+cyST1sD6fpfhg503EnG2TOLYN0Bc/tlZus0el8mVH245NFt+7aMBeKqIlxoaBJGN0xARkm5dP9EGIiFvrO4WoLpNlf0aKk28NEoaFRJanVmmkzOp9D5c1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467033; c=relaxed/simple;
	bh=/TArAnxsNcro0yGmSdNhHVG87gaDRBp0F+b6ECdeI4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JI5ho1cjZF6iIK4VE1+Bywe0cCQHQgGhFA2DP/FxLeNOpjGc1vopPjBwBR64cST2GF2Om0flXPf5JRMAr9QPD/Gu5U64O27X9XjXZz7I5CGTOgw6USRUfz6o32lmADGqeS+DnSiDsiK7oP+1Mbag0QOy9QZiFjsAVL1eFpG1A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIsTSwqD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467031; x=1762003031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/TArAnxsNcro0yGmSdNhHVG87gaDRBp0F+b6ECdeI4Q=;
  b=MIsTSwqD5xq1lv20h35FOHsHjvC7DMIH+EghJxiXfs29SnpE8M6ZY/YF
   7v7B7ZkNLQbP4yUM+FZMDcLqrQESy8kyfDNINZ/S84gKRcUzD5lC1+f1Q
   KAheH11eSxaYlsbGf9uet5ttsju75YseFzpHvmATzt+kpenc5mD+tAR8e
   knrsI2k+Dr1llNe9k2vBqRPrI8rKx7TMBLc9BOgTSMWtVaZO7hYfRewWF
   81/TfLvPdmbMNLzw95Iu2tTIrCQWEPrhq2NRPsHGO9ReVJu6BAnYs3Fn0
   DsAN524QZetZW/33qHrJAYr6f+dTDMzRswQ6HCQCqEs/h58BVmA/G4HzB
   A==;
X-CSE-ConnectionGUID: 9+O+4jnxSrSQJ5fiPmul5w==
X-CSE-MsgGUID: C6Pgc7n+SPGcvuRGnku53w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33920647"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33920647"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:17:11 -0700
X-CSE-ConnectionGUID: ce217UrTThSrwRmgEJLC9w==
X-CSE-MsgGUID: KiS7kbAoR+W17MUxoumkeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87754308"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2024 06:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 180861AC; Fri, 01 Nov 2024 15:17:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 0/4] iio: initialise ddata for iio_get_acpi_device_name_and_data()
Date: Fri,  1 Nov 2024 15:16:00 +0200
Message-ID: <20241101131705.3697913-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan reported that ddata might be used uninitialised in some cases.
Let's initialise it to NULL (patches 1 - 3). With that, update one driver
to drop an unneeded anymore check (included in patch 3).

While at it, one more cleanup to kxcjk-1013 (patch 4) is added.

Jonathan, dunno if you want to rebase at this stage (probably not),
but if you do, feel free to fold the patches 1-3 to the initial code.

In v3:
- made Subject more specific for patches 1-3 (Markus)

In v2:
- rewritten patches 1-3 to do the job on the caller side (Jonathan)

Andy Shevchenko (4):
  iio: light: isl29018: Assign NULL to ddata in isl29018_probe()
  iio: light: ltr501: Assign NULL to ddata in ltr501_probe()
  iio: accel: kxcjk-1013: Assign NULL to ddata in kxcjk1013_probe()
  iio: accel: kxcjk-1013: Deduplicate ODR startup time array

 drivers/iio/accel/kxcjk-1013.c | 30 ++++++------------------------
 drivers/iio/light/isl29018.c   |  2 +-
 drivers/iio/light/ltr501.c     |  2 +-
 3 files changed, 8 insertions(+), 26 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


