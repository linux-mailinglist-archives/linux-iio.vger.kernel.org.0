Return-Path: <linux-iio+bounces-11773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191239B91CE
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D9F1C245C7
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645741A4F1F;
	Fri,  1 Nov 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiTMuVOi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D54381B9;
	Fri,  1 Nov 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467035; cv=none; b=iTj2uPtJir/BbgI1tH6TtVvVeUd7TLT0mXUDu5QwcPdTZ/ZACoIkN+6iyQIq66BbN5B4MGETV/CzTgJT66IAD6W2RqL+a82hzsYGOu4RUVw5OxXwMvWHzEg0eFhxuVqXpbLJEh6EKmV8F+KUL3zp8LSnUNJKzSsCC9+G9SG7myc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467035; c=relaxed/simple;
	bh=fBv79w3eKoOjs9m//MWJ8cMaBmRaNg6AHgoFuopBHP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFu01vpiQTyw/5d2FmY/TeUdXdsxj9WIVi/VmEGQjbY/XiUpgPtl8IG/AOW979ovlLoMvDHtYRnpNlS5VpSlAPUHddQnrbO8NVEb2agzzDRdX6Q5N6vXZArJ0FtNDg7uNgDpX64ofcta9AnMxmKCwoMkNW62cKeLmcQdVYCE1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiTMuVOi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467033; x=1762003033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBv79w3eKoOjs9m//MWJ8cMaBmRaNg6AHgoFuopBHP4=;
  b=aiTMuVOihFb+YNsXWFprJMkwY1Du9CtPjFSyebg89mfN09TwGMuw/OAl
   km9oG9F271zJLmnbAavOlUqqmQfcpSJUCQiqPjX9pDoHmc847t67Wh+d2
   8/JNwJBzJIG9FI1igzoE1044JSaXBEMey4ckCSPQ7spPTZyPOnWZvxNnF
   /FrEResljZ/akYKr2UCAVywaMPvftMXWTFQx32EKXHOwzgasCklFZ5zUJ
   8safOvf7+WSdWO6ms5Tu13+CNMw/lK5QDeixW0Mcp5nvbm1BFir9dmikF
   3JocmRyM1ufr+IJJuLLvxcDnQ2pDhqJRpc0OiPM2SX6ELYGhEYJSh3etF
   Q==;
X-CSE-ConnectionGUID: GwKNAQNJRwubVYGZFp1lUw==
X-CSE-MsgGUID: LRVg380qRe6ueUm7m7k9pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33920651"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33920651"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:17:11 -0700
X-CSE-ConnectionGUID: BZCaD6QaRoOz5OYelz7f9g==
X-CSE-MsgGUID: /HLlG+NxTmqV1fEAG9KjgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87754309"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2024 06:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4F0CB2D3; Fri, 01 Nov 2024 15:17:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 4/4] iio: accel: kxcjk-1013: Deduplicate ODR startup time array
Date: Fri,  1 Nov 2024 15:16:04 +0200
Message-ID: <20241101131705.3697913-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241101131705.3697913-1-andriy.shevchenko@linux.intel.com>
References: <20241101131705.3697913-1-andriy.shevchenko@linux.intel.com>
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


