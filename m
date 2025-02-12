Return-Path: <linux-iio+bounces-15397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1BA31EC0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11C01887E3C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993541FF1DF;
	Wed, 12 Feb 2025 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYrLlLxa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357B1FBEB6;
	Wed, 12 Feb 2025 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341535; cv=none; b=bjtdyWcuepTw3Cnx41ThYlS5MjqXJs1j30LA44g/pHCa0Ctjpfgjt1r6OW5q9W8i5ZJeaRcbFacNQbsNQtNfREt8DlGrmd5Uijo8K7m4Kj03/d0c8lAxvJC369JqB3wpIj6r2UXMbqbZWPYV+hmPQKDGmQC1haQKYo5Y2vszqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341535; c=relaxed/simple;
	bh=67RSFInZFm0DdSiUI+c1fBuDjIAFg7k6SbR7C8UNsAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlh/Uc5nhBWJuvN9mZvEclKJwxTiIB1UETsnc1Vp3rmpnSegEWu6W4qYKMBmXsV3Vz1J2y5mUdkqd3qBK4wyKge0Q+j8Mtw6ouzK2Dwa+j8fY5W7pxMIg0KNANxeKLqqq+71VYBsabAYDs9I//jVD6LbDKbthRdyv8mc3t30N5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYrLlLxa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341533; x=1770877533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=67RSFInZFm0DdSiUI+c1fBuDjIAFg7k6SbR7C8UNsAs=;
  b=dYrLlLxavv1Rq2lLQJ1g/bfJwH86Q156tJooI7s9pr7fpxU9aHclslPm
   ob85dnyc6m4+FcAzTsqXKX0tHfAaS8q4hgwV0kiEsmf6yvq6i9qZw64rM
   9/hEKPJ0lQodS69kA2C8jaUXDZbKO+3iN3nCN1m2FOyzXHQGtMwO5ubEK
   mhDl9Kau8lqZ9C5THTQ+DX7ottyDXIStogbEG3WhHuMD8XjdZpNQecdTA
   ro1psqVNNuGkGUj9X0Xw28DnbA6ijskaDc6abYz5h9Di+li0683Odcv/N
   n1CKygzUhUvMVQ+5Xpu+krhK2JIySn8vPT4W3JmSoJUiXb7ZoWCQXCM4v
   A==;
X-CSE-ConnectionGUID: JxnLE1ApRna/AdO3FicBBg==
X-CSE-MsgGUID: 5OpkW1QNQPeVHcG5ZJyamw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005166"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005166"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:32 -0800
X-CSE-ConnectionGUID: eJzr0gOsTrCZAjxoc3scjg==
X-CSE-MsgGUID: bEIkeAsJQaWEqzHSgn0a7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117811984"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:29 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 03/12] iio: imu: st_lsm9ds0: Replace device.h with what is needed
Date: Wed, 12 Feb 2025 11:55:04 +0530
Message-Id: <20250212062513.2254767-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212062513.2254767-1-raag.jadav@intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of including a huge device.h with tons of dependencies
include only what driver actually uses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 0732cfa258c4..8cc071463249 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -7,7 +7,7 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/err.h>
 #include <linux/gfp_types.h>
 #include <linux/i2c.h>
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 43ec57c1e604..806e55f75f65 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -7,7 +7,7 @@
  * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  */
 
-#include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/err.h>
 #include <linux/gfp_types.h>
 #include <linux/module.h>
-- 
2.34.1


