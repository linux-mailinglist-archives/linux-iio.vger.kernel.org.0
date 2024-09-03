Return-Path: <linux-iio+bounces-9099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FAE96AA20
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 23:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07B71F2185B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96E126BE8;
	Tue,  3 Sep 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnsacCtu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529E1EBFE5;
	Tue,  3 Sep 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398972; cv=none; b=UBwK7rI7E2S6fwiTWnI4R9NznNjiwXkQA8/HOcvPqcsPKQoagiD3AqeZT3NRiIyS76THYXWXQhguzAVqK4975215HC/9m+vpz0bgtM/wFeujSk3EDgBD7LctDaHh+DrerXKD0CiF0Scz7pV5/LcMqwsfl9dLT2hSrHtlvur9hMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398972; c=relaxed/simple;
	bh=sIWDRW33SUcBNQhQUvd8BZYlOvScCHHrfjck+6JwMdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suZzlBw5BvzIB0jJrkNQdEIHkJ/x91Xbjki3C4lgubgmEPcQXr5FygYr9x3vmxlQRBCGta+rJO8MTNa97r+gtr0iMgzDP6Z4qO4oz0OTVH/2h9/DqArK7wDYX7tkJzF4lgbdER35486nzStGneU74mEECWesP5c5cQ7yH/YzdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnsacCtu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725398971; x=1756934971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sIWDRW33SUcBNQhQUvd8BZYlOvScCHHrfjck+6JwMdc=;
  b=VnsacCtuW5Y2neeKyVvGv/OC563Ph7vO408P9jp42nHiWNNsfFc1bBhc
   SSO6+jUUahw33kg7sz8fteAaDeinQwjRe0rQWbwPyaipplshCXGOPV+Rs
   oey6JCwM5UuyhvzLe0DCXKr/79EdT1I5U7Nbs3l2gNPbwFsiI9Sa92uAo
   0KhPU1FddCzJyjiryRySmeX+U7N69wuY10/0QkIxAm6gurc2vARuKoqVz
   KAsTLkJApqqGCmK2l65LpDc2L6f5F6XA86vnlXYGl8+dI5gL5i+FrKSsx
   xDK8x7o6Aeyh2QFGRSkG+4R8Wu3ab6OQ78pfvLyOj7dDpi/uzlNpqNvw7
   g==;
X-CSE-ConnectionGUID: Su7vd85lS66LXYSswHGNeA==
X-CSE-MsgGUID: 49lHY3wnThmvtx51WTzsSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="46554417"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="46554417"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 14:29:30 -0700
X-CSE-ConnectionGUID: JJll3/5RTTaBcV8o7V8tDA==
X-CSE-MsgGUID: cVh/eHQXQt6d1g/JA5F8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95781596"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 Sep 2024 14:29:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CB12E3C1; Wed, 04 Sep 2024 00:29:26 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/3] iio: reduce acpi.h usage
Date: Wed,  4 Sep 2024 00:28:19 +0300
Message-ID: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce acpi.h usage (partially, more will come).

Andy Shevchenko (3):
  iio: imu: fxos8700: Drop unused acpi.h
  iio: proximity: sx_common: Unexport
    sx_common_get_raw_register_config()
  iio: proximity: sx_common: Drop unused acpi.h

 drivers/iio/imu/fxos8700_core.c   |  1 -
 drivers/iio/proximity/sx9324.c    | 20 ++++++++++++++++++++
 drivers/iio/proximity/sx9360.c    |  1 -
 drivers/iio/proximity/sx_common.c | 21 ---------------------
 drivers/iio/proximity/sx_common.h |  4 ----
 5 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


