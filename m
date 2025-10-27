Return-Path: <linux-iio+bounces-25483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99CC0E805
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF6884F8EC7
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B089723BCEE;
	Mon, 27 Oct 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMOAOk9p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3511E32D6;
	Mon, 27 Oct 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575940; cv=none; b=kbPMrCGq0odqNFD3jxRYY6G5OJ4NrPGBHgr++I3SUOgJA9cv2To9UZoQtuPzF0YX7uV7OOUwM981k35NjWpQqzCH3ku6sW46XROpo8Bb+XZx7rMg1HzXfumaKRQ/XN2oHP9fqK1jTUDwpoi7QrTQiLbmSaX2pnqLCe8FHXz8gNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575940; c=relaxed/simple;
	bh=nJ5njJ5+9hYtCs0aj31BczBczYllyXS0BJAPe/01RYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjArORaunJMPBhXgUpL2OTCO3ngb4yo61QdqjX2TmeUzlcPsZlz4K10xcJaEmahaC0LOmymwzhgYhnSqSFJbR9vO4Ere7n3EF67kdQPNthbIWZTiM8v0w2p2X2HJO8/U0EXRqg23N8JFqCrWVlXstUmw0pK1M6vFyCJpg7uj0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMOAOk9p; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761575938; x=1793111938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJ5njJ5+9hYtCs0aj31BczBczYllyXS0BJAPe/01RYE=;
  b=cMOAOk9pZK7C0bormuX8vpfPNdRB/oI5CjMsur1YZEGs0vu1VRdKIiLP
   oKLiiD/sRNuOdaaGiXt3LIvJHpf2tqkFNrcBU1TpkJ05RNV/M1xfmQv5K
   YDCBAkJiqAHSeugcuXorqDDQFFE/Jw6oFQE+ACkkx/MESkaBclkyUXF3C
   vi3DfJGTcvfGdkrob42YDhkgtBOb+Qn7RCMkMtoqgTnFhy7w5SfRaU3FH
   U96MS8svJS3MIpDhqux3pHtR3N6JRYHEGmxGaXuFgJPEaHSZQXvjA01kh
   slopciid3njk6GfwrDq9F/INwxSZDe72bNe7yz615nGET+8BIzDdG901b
   A==;
X-CSE-ConnectionGUID: flvKeVlXR/yc9m4mLwhGgw==
X-CSE-MsgGUID: hGbtvWosTaCLdlukdn6fEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63562458"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="63562458"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:38:57 -0700
X-CSE-ConnectionGUID: KdQ8Cx24S+CkfiR30J0CGg==
X-CSE-MsgGUID: 9ObjXCVMTXq4FJg4Ehc4/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="215712208"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2025 07:38:55 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5A09B99; Mon, 27 Oct 2025 15:38:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: [PATCH v1 4/6] iio: cros_ec_sensors: Convert to use PI definition
Date: Mon, 27 Oct 2025 15:34:53 +0100
Message-ID: <20251027143850.2070427-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 82cef4a12442..7e7b7f97454d 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -21,6 +21,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/units.h>
 #include <linux/slab.h>
 
 #define CROS_EC_SENSORS_MAX_CHANNELS 4
@@ -120,8 +121,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 			 * loss. Round to the nearest integer.
 			 */
 			*val = 0;
-			*val2 = div_s64(val64 * 3141592653ULL,
-					180 << (CROS_EC_SENSOR_BITS - 1));
+			*val2 = div_s64(val64 * PI, 180 << (CROS_EC_SENSOR_BITS - 1));
 			ret = IIO_VAL_INT_PLUS_NANO;
 			break;
 		case MOTIONSENSE_TYPE_MAG:
-- 
2.50.1


