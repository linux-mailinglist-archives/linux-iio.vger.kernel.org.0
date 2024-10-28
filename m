Return-Path: <linux-iio+bounces-11428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9C9B29A3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E21728169B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1281D47A6;
	Mon, 28 Oct 2024 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdLcrOxF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718F191F91;
	Mon, 28 Oct 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101892; cv=none; b=osaRn7RqAxvQTo4U4cAzvYJa+PXFzDZnXjZwFmxnkwRziK4BTfuGmHM/s7BKqnoASkheHusYpTKh9/fgp//y4N3GZzkXivNRG6KvPgyPspeJfuj9wg8J4v/xn+GPLaDlGZr7A+gtXhCkc1Wx6FIW+TIm4ZzS4ORgg+mOheQfpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101892; c=relaxed/simple;
	bh=rlB5luWUnPMFxZLsAJNBTH+KfMj0AeBMA7Y0LrVgo9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZBUKW0hfW//PbolwBpgJRyrhuF6s6cFqVm/gxJR4oQA8Fr267+knyq2ErIksjNm171K0ZNffyQtwGxK/Wq3nqeCKWpfIpvuvgVe0l5AWq2CydOPLpRYcc3V45zyQTEz0V+LqnUzosABgx5T9/ZWNtlVgGf1f1bJ29IdVTHLg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdLcrOxF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730101890; x=1761637890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rlB5luWUnPMFxZLsAJNBTH+KfMj0AeBMA7Y0LrVgo9A=;
  b=kdLcrOxFuEzlFdweibPJhB4eLe5atE42mFtUYv43YXXB4RF0D28EnIm8
   DZIyMq2B0yc9/ckic6IDJPA4g5Zjlo/toQAxafv4TG0qdoyexbemqNTaR
   i0v/PV3sEHeeYEIFqovyjJPOgTW9qkNz1A7kRL4YqTUYuY4RMnekfHHTF
   EO1Jf+Hl0PCXjDCfRvjDyULFfeJnkrzZ94irZQdkFPV33cAA2buFyfu7B
   gTMZ6vOycIMd15/jso7Ssok+RQHXg2UAs+sgIBfRaE2HEY8Uy1RGnMrH7
   tY7z88DLJOA5gxMVSCDzxzoF96z35EJGm865rMlIONVb1+zI6YeH988U9
   g==;
X-CSE-ConnectionGUID: bwlzFZ84S0+c+O4iMoCzCg==
X-CSE-MsgGUID: uFBLa/88RaWdPgooLv7iJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="17325885"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="17325885"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:51:29 -0700
X-CSE-ConnectionGUID: GSwhJVN9StyaknSFA3Kqag==
X-CSE-MsgGUID: oNmLfPRsRI2xAM91scp68w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81127439"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 28 Oct 2024 00:51:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 19B2813E; Mon, 28 Oct 2024 09:51:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: accel: kxcjk-1013: Add missing terminator entries
Date: Mon, 28 Oct 2024 09:50:26 +0200
Message-ID: <20241028075123.615813-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing terminator entries to struct kx_odr_start_up_time
initializators.

Fixes: d381089dda44 ("iio: accel: kxcjk-1013: Convert ODR times array to variable in chip_info")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Jonathan, sorry for the last minute update, but it seems I was thinking,
but forgot to modify the initializers. Feel free to fold this one into
the original commit if you can / want to do it.

 drivers/iio/accel/kxcjk-1013.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a6621cd69707..28ed0e09d099 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -190,6 +190,7 @@ static const struct kx_odr_start_up_time kxcjk1013_odr_start_up_times[] = {
 	{ 0x05, 3900 },
 	{ 0x06, 2700 },
 	{ 0x07, 2100 },
+	{ }
 };
 
 /* KXCJ9-1008 */
@@ -206,6 +207,7 @@ static const struct kx_odr_start_up_time kxcj91008_odr_start_up_times[] = {
 	{ 0x05, 3900 },
 	{ 0x06, 2700 },
 	{ 0x07, 2100 },
+	{ }
 };
 
 /* KXCTJ2-1009 */
@@ -222,6 +224,7 @@ static const struct kx_odr_start_up_time kxtj21009_odr_start_up_times[] = {
 	{ 0x05, 4000 },
 	{ 0x06, 3000 },
 	{ 0x07, 2000 },
+	{ }
 };
 
 /* KXTF9 */
@@ -232,6 +235,7 @@ static const struct kx_odr_start_up_time kxtf9_odr_start_up_times[] = {
 	{ 0x04, 11000 },
 	{ 0x05, 5100 },
 	{ 0x06, 2700 },
+	{ }
 };
 
 /* KX023-1025 */
@@ -249,6 +253,7 @@ static const struct kx_odr_start_up_time kx0231025_odr_start_up_times[] = {
 	{ 0x05, 4400 },
 	{ 0x06, 3000 },
 	{ 0x07, 3000 },
+	{ }
 };
 
 enum kx_acpi_type {
-- 
2.43.0.rc1.1336.g36b5255a03ac


