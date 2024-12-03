Return-Path: <linux-iio+bounces-13039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB559E2CED
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD1EB42DCB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 19:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC6205E25;
	Tue,  3 Dec 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k87i4zbr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21A202F86;
	Tue,  3 Dec 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255630; cv=none; b=lOTPTv7ZfQ3vp4fdguoz9N/2ZTV/2GZtrg+YmFrkQywCUQ9I4jk0nK4yU9oDW+3uFyZjgcYc59nG5ZlRx5uldGRZFMNDrwzQaY9Maiei1jJP+/ejGKaA2HoSw4iPODbG7pEiljM13VO+CvOoiXwVDwWAjTHbnNKS9l3/lmU3TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255630; c=relaxed/simple;
	bh=pyUYHh95ohHtp9zFDPFoOhi3+W1Y80mrJ/4n1GI/sEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGTChK+20Gzu+8oCYRiXKyc7w5zjFWCSfVjJoTkvHZd/JF8tFiMLhzCkps3M0vOobLMm9PUneypEIMq+P4HPA+s6iceJjbQ94lxw+deufj/Fsew9OPnpMqKw3khsF+bWDnIqewnvLwSyZoEWuTavkFBDLCijrwIYiGy0+swC4Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k87i4zbr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733255627; x=1764791627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pyUYHh95ohHtp9zFDPFoOhi3+W1Y80mrJ/4n1GI/sEg=;
  b=k87i4zbrKJE9I+TwjjRIy0lp8fm6qiZsP9UMaZf4zYPDCYMlUEGkeqfY
   lpSwdWbpo7xOYPASjg1nKtKnuPxGiK79PsvQTLSTtRtaxOrT0hDre2MXG
   zlYaIWZRdtCQnaF3s+e6GTlLC5x2P3YMrKZtrws/xlYIei6RDtZ//okBu
   uVh5hqPB5nYyv2dr/kSGZ1S58L3yRaZujITTLRjHh1u/6htMGftD6Hjo9
   1WAUvP4mGCTXqI/+5oM++3MTAGQryX9T7jECtoQySZK48JC2TN0Cen55B
   xkKboaQdro7bagM4RbOVX5eDLNuXB7i5kesTQMaxHdrViEgVmJ8XnfzPZ
   w==;
X-CSE-ConnectionGUID: HQbXvxFhSHqpUxQbcTh/NA==
X-CSE-MsgGUID: x/LuHl2QQIGFpeobG80a+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33238671"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33238671"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 11:53:47 -0800
X-CSE-ConnectionGUID: 8mB7cbDTReKx5lztkL3KBg==
X-CSE-MsgGUID: SekiPKj0TrepfrA8G9xPPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98621153"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Dec 2024 11:53:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 20312557; Tue, 03 Dec 2024 21:53:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/2] iio: imu: st_lsm9ds0: Replace device.h with what is needed
Date: Tue,  3 Dec 2024 21:48:52 +0200
Message-ID: <20241203195340.855879-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of including a huge device.h with tons of dependencies
include only what driver actually uses.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index d03cec3b24fe..2b1b57761688 100644
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
index 69e9135795a3..d3bfd74a69ab 100644
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
2.43.0.rc1.1336.g36b5255a03ac


