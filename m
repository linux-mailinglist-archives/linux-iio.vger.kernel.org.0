Return-Path: <linux-iio+bounces-26027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42307C41863
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 21:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A25B4EAAAB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60A3093C7;
	Fri,  7 Nov 2025 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6C/qgwy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549432F90CA;
	Fri,  7 Nov 2025 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546216; cv=none; b=cUf54VWxkDQUz+hDefOy1D6NBZ/clw0T0kZ1F4OdJ1L2B0F9hXQaJyZYXQJdN0bM7ljnKt5grpVpgBLYcRUOMDov2a35OhI4W5UhiIFFNZviLqt/sFm6gLA+kA53ZV6je2yQTI/pemMH9Cqj3+bhogNT2/XLxdKIxIpIWCIss1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546216; c=relaxed/simple;
	bh=cP9DN2wA6tmoni0SP93QiDeuwGHTaMLX9aB3XhWVMFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILtoR6Ahp/ERKTVUf884ia3wigzMud1dyHimtUvAoFOZuJ1VG9dUwNWoYruUPofjDOviJxgT91N41zk6WYqT90RpmDjJ7fOmYfD+vuRXtN2aVaadTlb74kvsdylnrGcrd1XToPfavz+fyLn9lw2c9Z+QVZPU+iBeAdQkFchMPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6C/qgwy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762546215; x=1794082215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cP9DN2wA6tmoni0SP93QiDeuwGHTaMLX9aB3XhWVMFM=;
  b=S6C/qgwy0oi0Q+Fh8i+aVoaHAzQ2C4W726jITy8IKmUNjv/usyRrWrQK
   ayIhPHcXhrBxxdttUm+aX6GT1Hz3n3kNLFsA1AwmaW/2NQ61S5tuAhEXI
   z0zBfrkkkSuaYU7B7qFF+qWT8tWGu7nn2u5Jx0VghOrNnzAmqZ+mHA6Vy
   ntU62m6qDkufrYkcICGwtg7dk4KRFZNQeUazl5XN6DxMXyK0bmBmruKrR
   Tpy3DsTl1MQpwIKhETVsCjOmnODxbjkBAPVEJGN3yJYmx9gtpNBFs/Otj
   npCRAtq3Z14Ome425QsB5aOV/r57+v/RTigZfahj+8HLgn+d4eDHADJNx
   A==;
X-CSE-ConnectionGUID: BGCbHhP4RNqQnQMzrj7Itg==
X-CSE-MsgGUID: P6pRL4vcTSWMy3cXpZRm8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="68539689"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="68539689"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 12:10:14 -0800
X-CSE-ConnectionGUID: JYfyRC4TRbabWn4R+B2AhA==
X-CSE-MsgGUID: tGAtMTO/RqOpbmA3tHb96g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187372878"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 12:10:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E820899; Fri, 07 Nov 2025 21:10:09 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: [PATCH v2 4/6] iio: cros_ec_sensors: Convert to use PI definition
Date: Fri,  7 Nov 2025 21:03:02 +0100
Message-ID: <20251107201005.3156118-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use PI definition instead of open coded value of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 82cef4a12442..e248ba1eb3f9 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
 #include <linux/slab.h>
 
 #define CROS_EC_SENSORS_MAX_CHANNELS 4
@@ -120,7 +121,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 			 * loss. Round to the nearest integer.
 			 */
 			*val = 0;
-			*val2 = div_s64(val64 * 3141592653ULL,
+			*val2 = div_s64(val64 * DIV_ROUND_UP_ULL(PI_LL, GIGA),
 					180 << (CROS_EC_SENSOR_BITS - 1));
 			ret = IIO_VAL_INT_PLUS_NANO;
 			break;
-- 
2.50.1


