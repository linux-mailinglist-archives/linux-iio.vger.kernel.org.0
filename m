Return-Path: <linux-iio+bounces-11753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F78F9B8CB3
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 09:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038A5284444
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785661586F2;
	Fri,  1 Nov 2024 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQSIudXM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F60815697A;
	Fri,  1 Nov 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448736; cv=none; b=av7cp4XkuEjhn3u8xCz6RYQUllAlEDHiCElHkbNhMtmi5HtvHQuVIRRTxfkg/8aEc3oVp/91hFAoZSLq6BoErrxk9GbKZRuPWGivik+p0tdF7+D0QQXuFA2ne22GU16rk1l4I6cIkGEwt8YmE+UXgYLpN59xel7CezZDmGUhT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448736; c=relaxed/simple;
	bh=fBv79w3eKoOjs9m//MWJ8cMaBmRaNg6AHgoFuopBHP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ83pobfCdboGizEOGTEXuycSqEkMk0SqE86MZNQ+zRE+jXaIBXQzIYxe84QqYkM2ikPoC+gffpprSktx6TUQNc+M/Q5kWF675xPKsJzfbklKG2uf228l/hNAoxEb/wCA27kY1BQvijZ+0oMi0CNMb5xPsqHRKYxfLCdWp38XyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQSIudXM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448734; x=1761984734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBv79w3eKoOjs9m//MWJ8cMaBmRaNg6AHgoFuopBHP4=;
  b=cQSIudXMxfMYr+IWber6IRHgukCG1NJNwmU8QTlpCyJfGlBwOuLX2kYS
   xrasQdH9/kAjIUtmB8188nzXUS9Z8R+SjYE7ZmchsYdi5hOb0xw+/d7yz
   O7xya6TkuwaLWWDTT7veQQizGO+iuvMWp0f3a1nKAatfXvNpv0xT2BiHT
   J6CkXs9x9LHMUoAjCXNGG+cJkSZUYHG1uKGBLAE/9Wudc8fsRtGIUdorF
   8fVxwoYDgEFFEaG60osSuqnChVphelRK4zYh49QtdbRiq0pEEuj43DgdB
   2xvoIJxU71zapjweWVF9Goj6/AeiKFuSy5GVtJ5Ovuh9GJvzf6nbk14Yy
   Q==;
X-CSE-ConnectionGUID: z9p8vRgDSaeQJj37F/2dRw==
X-CSE-MsgGUID: cJMJjyNrRRyLAhlh5kVbJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="47698435"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="47698435"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:12:11 -0700
X-CSE-ConnectionGUID: Y4Bg4QaqRqu2v99qxk7ofA==
X-CSE-MsgGUID: KZL/9SQSSvaeFF9OXYJRsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="87712824"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2024 01:12:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3113944B; Fri, 01 Nov 2024 10:12:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 4/4] iio: accel: kxcjk-1013: Deduplicate ODR startup time array
Date: Fri,  1 Nov 2024 10:08:29 +0200
Message-ID: <20241101081203.3360421-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
References: <20241101081203.3360421-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The content of kxcj91008_odr_start_up_times and kxcjk1013_odr_start_up_times
is identical, deduplicate it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 753ec2f71a9a..f65fde06f2c1 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -193,23 +193,6 @@ static const struct kx_odr_start_up_time kxcjk1013_odr_start_up_times[] = {
 	{ }
 };
 
-/* KXCJ9-1008 */
-static const struct kx_odr_start_up_time kxcj91008_odr_start_up_times[] = {
-	{ 0x08, 100000 },
-	{ 0x09, 100000 },
-	{ 0x0A, 100000 },
-	{ 0x0B, 100000 },
-	{ 0x00, 80000 },
-	{ 0x01, 41000 },
-	{ 0x02, 21000 },
-	{ 0x03, 11000 },
-	{ 0x04, 6400 },
-	{ 0x05, 3900 },
-	{ 0x06, 2700 },
-	{ 0x07, 2100 },
-	{ }
-};
-
 /* KXCTJ2-1009 */
 static const struct kx_odr_start_up_time kxtj21009_odr_start_up_times[] = {
 	{ 0x08, 1240000 },
@@ -325,24 +308,24 @@ static const struct kx_chipset_info kxcjk1013_info = {
 
 static const struct kx_chipset_info kxcj91008_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 };
 
 static const struct kx_chipset_info kxcj91008_kiox010a_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 	.acpi_type = ACPI_KIOX010A,
 };
 
 static const struct kx_chipset_info kxcj91008_kiox020a_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 	.acpi_type = ACPI_GENERIC,
 };
 
 static const struct kx_chipset_info kxcj91008_smo8500_info = {
 	.regs = &kxcjk1013_regs,
-	.times = pm_ptr(kxcj91008_odr_start_up_times),
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 	.acpi_type = ACPI_SMO8500,
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


