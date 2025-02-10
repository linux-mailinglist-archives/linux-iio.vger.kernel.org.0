Return-Path: <linux-iio+bounces-15224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF0A2E460
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7517C3A5158
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC871B2186;
	Mon, 10 Feb 2025 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCUZMhTt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95D1AF0DB;
	Mon, 10 Feb 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170173; cv=none; b=GLKGA0tlpjPtVXOy9RGlRoxt84u192ViTHDg/rdUrjtMqbDoE41AaAMz25pGLxnyWeYqdqymTslhhiC0FQFBkpG5/+FG+8J53Rb3aP0nyszovKf0ZoDZB0IYhN3iI66Ak+GN/KbxSKKroAwMBqsI3bNbgO+/HPIOoXD2dIr0+g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170173; c=relaxed/simple;
	bh=67RSFInZFm0DdSiUI+c1fBuDjIAFg7k6SbR7C8UNsAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGEZda+/nRBfEtgsXq2SSqLwaWBh7ZLeXYXSa9DnljKjjyPfU+ObOwwrKtuqk8lL6e1wTzZ/ptVskViBGwJNU6HWs6wiLuE+H94NRJx1kO5N8dWpUaL/QLSTuz7WCG8mN1jcUhzPcw7XHS7VqlJjeDL+9Vn9qfgbVflqKzajgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCUZMhTt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170173; x=1770706173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=67RSFInZFm0DdSiUI+c1fBuDjIAFg7k6SbR7C8UNsAs=;
  b=jCUZMhTtIPCs+XmMtZlQ8nnRdgMGVQh1ofGOXjz0Mh3ew51ugYhHnBQ5
   p/GEgXf2pSgGRDh+JQxylZoiUOFJiJW39V6mvmYJZ9gJbXCfTxp5buBx3
   kft0jiv3AVDelT0forIDMYMx/u4MMgyms7llZbFkUyTFPuuE71/8WZS/3
   wNQcwMfiHK3oq+1jDODm5fBfSQVUKxL1owSNae2LRgdcMEyJsU71TeMMz
   +MDCf9cLTYUPZKqOtzsNzoJ+t2MG1mpwcxKo0rg+HXKLrpvBOC/K+etjY
   QJ7JPiAfuOQgffyL4s9n8zQRC02Vjq/Zgx6+YMvql1Wq7zN0REZ5aL70l
   g==;
X-CSE-ConnectionGUID: jVwkTU1gQ9eCs1Ri02OBOQ==
X-CSE-MsgGUID: k6JDt/sKTP+CGWGUngUuRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499297"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499297"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:49:32 -0800
X-CSE-ConnectionGUID: eTf7Cd0dSOyC17dl+jrboA==
X-CSE-MsgGUID: ebPmSzptRhuwsw107IT2Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122402"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:26 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	sre@kernel.org,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 02/20] iio: imu: st_lsm9ds0: Replace device.h with what is needed
Date: Mon, 10 Feb 2025 12:18:48 +0530
Message-Id: <20250210064906.2181867-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210064906.2181867-1-raag.jadav@intel.com>
References: <20250210064906.2181867-1-raag.jadav@intel.com>
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


