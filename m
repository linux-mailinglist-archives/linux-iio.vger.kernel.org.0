Return-Path: <linux-iio+bounces-11224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC539AF264
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB236289534
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138B421BB1C;
	Thu, 24 Oct 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3js1TC7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDE21A713;
	Thu, 24 Oct 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797134; cv=none; b=enVu6lMao/HP125oLVjhaObM5dIN2Tzbf1Y39JJa6TaDVisyYU5PugniaqKHB2LfnyyHCsAIkbCq/P0W/rHW9IqZagOsl0R3iQzcq3W7i3uf8r0I5816W8SQZPZXw+QuctSvkpx3xIC7T9r88F1pr2aZ/wCWEdoIRF+9A0qPgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797134; c=relaxed/simple;
	bh=Zm8+zqk41NUOu3UmS3GvGn8c3EpWUBfPhtq7naAdJ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r35n2eg71lF7wPdwAlv70FsV+2C9aoIslJcBOlcjzoM4xo7nQ9fk24Mxo/MjkPkDBRmcshjx2TqqMYmRZ0gMJ1SraAnuMAJqQ2S2ljecDQ2jDln/pAzw1vzV8csADIS3TzPivd9RZ5DQgJOA9J8b833BGEHVP9OdtrBo5TgpSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3js1TC7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797132; x=1761333132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zm8+zqk41NUOu3UmS3GvGn8c3EpWUBfPhtq7naAdJ3I=;
  b=V3js1TC7GKWRRuBERit+wZXa8k7rg0QwEojWIVRlqKPRN/WMCJRigSys
   iUhqx5i8tkRcMFOY/tQadAdfzBIFdRjgr8famy8XeNFfAgMFmGNl7/eWN
   mgDXld7qltpD4jDMroBMNfUugQgXojr6hwDrhlAZCePlqw6RLzHwlP5Gx
   9+7EfJnGNBjWCoNzujoKR5zRQhxeYVMEWK+5m250ZRxF5YSrtnIv0P8tJ
   wgKaXajyYtCQTJkEh1uktpOYpcDhWt1IwTpL/ZOrIYJIjkvYbKvOXeYwE
   G1uVhiG4dziK9SGNvDK1XIy1N827/6WZ7MtiJbIHfcMtLLA4let5IpM5c
   g==;
X-CSE-ConnectionGUID: 0YncX3iVRrq17T3y3+v8pQ==
X-CSE-MsgGUID: 5SxT0jhDRoa8HSXbvF0j4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934456"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934456"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: /JFxhPxGT76Mc6uTll3N+g==
X-CSE-MsgGUID: 71Nl+S2ATsK+ILCmUm0Hyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266687"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B04A77A7; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 13/24] iio: accel: kxcjk-1013: Convert ODR times array to variable in chip_info
Date: Thu, 24 Oct 2024 22:05:02 +0300
Message-ID: <20241024191200.229894-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert odr_start_up_times array to the variable in chip_info.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 166 ++++++++++++++++++---------------
 1 file changed, 89 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index f384969a922d..91f890275a18 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -179,80 +179,84 @@ enum kx_chipset {
 };
 
 /* Refer to section 4 of the specification */
-static const struct {
+struct kx_odr_start_up_time {
 	int odr_bits;
 	int usec;
-} odr_start_up_times[KX_MAX_CHIPS][12] = {
-	/* KXCJK-1013 */
-	[KXCJK1013] = {
-		{0x08, 100000},
-		{0x09, 100000},
-		{0x0A, 100000},
-		{0x0B, 100000},
-		{0, 80000},
-		{0x01, 41000},
-		{0x02, 21000},
-		{0x03, 11000},
-		{0x04, 6400},
-		{0x05, 3900},
-		{0x06, 2700},
-		{0x07, 2100},
-	},
-	/* KXCJ9-1008 */
-	[KXCJ91008] = {
-		{0x08, 100000},
-		{0x09, 100000},
-		{0x0A, 100000},
-		{0x0B, 100000},
-		{0, 80000},
-		{0x01, 41000},
-		{0x02, 21000},
-		{0x03, 11000},
-		{0x04, 6400},
-		{0x05, 3900},
-		{0x06, 2700},
-		{0x07, 2100},
-	},
-	/* KXCTJ2-1009 */
-	[KXTJ21009] = {
-		{0x08, 1240000},
-		{0x09, 621000},
-		{0x0A, 309000},
-		{0x0B, 151000},
-		{0, 80000},
-		{0x01, 41000},
-		{0x02, 21000},
-		{0x03, 11000},
-		{0x04, 6000},
-		{0x05, 4000},
-		{0x06, 3000},
-		{0x07, 2000},
-	},
-	/* KXTF9 */
-	[KXTF9] = {
-		{0x01, 81000},
-		{0x02, 41000},
-		{0x03, 21000},
-		{0x04, 11000},
-		{0x05, 5100},
-		{0x06, 2700},
-	},
-	/* KX023-1025 */
-	[KX0231025] = {
-		/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
-		{0x08, 1240000},
-		{0x09, 621000},
-		{0x0A, 309000},
-		{0x0B, 151000},
-		{0, 81000},
-		{0x01, 40000},
-		{0x02, 22000},
-		{0x03, 12000},
-		{0x04, 7000},
-		{0x05, 4400},
-		{0x06, 3000},
-		{0x07, 3000},
-	},
+};
+
+/* KXCJK-1013 */
+static const struct kx_odr_start_up_time kxcjk1013_odr_start_up_times[] = {
+	{0x08, 100000},
+	{0x09, 100000},
+	{0x0A, 100000},
+	{0x0B, 100000},
+	{0, 80000},
+	{0x01, 41000},
+	{0x02, 21000},
+	{0x03, 11000},
+	{0x04, 6400},
+	{0x05, 3900},
+	{0x06, 2700},
+	{0x07, 2100},
+};
+
+/* KXCJ9-1008 */
+static const struct kx_odr_start_up_time kxcj91008_odr_start_up_times[] = {
+	{0x08, 100000},
+	{0x09, 100000},
+	{0x0A, 100000},
+	{0x0B, 100000},
+	{0, 80000},
+	{0x01, 41000},
+	{0x02, 21000},
+	{0x03, 11000},
+	{0x04, 6400},
+	{0x05, 3900},
+	{0x06, 2700},
+	{0x07, 2100},
+};
+
+/* KXCTJ2-1009 */
+static const struct kx_odr_start_up_time kxtj21009_odr_start_up_times[] = {
+	{0x08, 1240000},
+	{0x09, 621000},
+	{0x0A, 309000},
+	{0x0B, 151000},
+	{0, 80000},
+	{0x01, 41000},
+	{0x02, 21000},
+	{0x03, 11000},
+	{0x04, 6000},
+	{0x05, 4000},
+	{0x06, 3000},
+	{0x07, 2000},
+};
+
+/* KXTF9 */
+static const struct kx_odr_start_up_time kxtf9_odr_start_up_times[] = {
+	{0x01, 81000},
+	{0x02, 41000},
+	{0x03, 21000},
+	{0x04, 11000},
+	{0x05, 5100},
+	{0x06, 2700},
+};
+
+/* KX023-1025 */
+static const struct kx_odr_start_up_time kx0231025_odr_start_up_times[] = {
+	/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
+	{0x08, 1240000},
+	{0x09, 621000},
+	{0x0A, 309000},
+	{0x0B, 151000},
+	{0, 81000},
+	{0x01, 40000},
+	{0x02, 22000},
+	{0x03, 12000},
+	{0x04, 7000},
+	{0x05, 4400},
+	{0x06, 3000},
+	{0x07, 3000},
 };
 
 enum kx_acpi_type {
@@ -313,50 +317,59 @@ static const struct kx_chipset_regs kx0231025_regs = {
 
 struct kx_chipset_info {
 	const struct kx_chipset_regs *regs;
+	const struct kx_odr_start_up_time *times;
 	enum kx_chipset chipset;
 	enum kx_acpi_type acpi_type;
 };
 
 static const struct kx_chipset_info kxcjk1013_info = {
 	.regs = &kxcjk1013_regs,
+	.times = pm_ptr(kxcjk1013_odr_start_up_times),
 	.chipset = KXCJK1013,
 };
 
 static const struct kx_chipset_info kxcj91008_info = {
 	.regs = &kxcjk1013_regs,
+	.times = pm_ptr(kxcj91008_odr_start_up_times),
 	.chipset = KXCJ91008,
 };
 
 static const struct kx_chipset_info kxcj91008_kiox010a_info = {
 	.regs = &kxcjk1013_regs,
+	.times = pm_ptr(kxcj91008_odr_start_up_times),
 	.chipset = KXCJ91008,
 	.acpi_type = ACPI_KIOX010A,
 };
 
 static const struct kx_chipset_info kxcj91008_kiox020a_info = {
 	.regs = &kxcjk1013_regs,
+	.times = pm_ptr(kxcj91008_odr_start_up_times),
 	.chipset = KXCJ91008,
 	.acpi_type = ACPI_GENERIC,
 };
 
 static const struct kx_chipset_info kxcj91008_smo8500_info = {
 	.regs = &kxcjk1013_regs,
+	.times = pm_ptr(kxcj91008_odr_start_up_times),
 	.chipset = KXCJ91008,
 	.acpi_type = ACPI_SMO8500,
 };
 
 static const struct kx_chipset_info kxtj21009_info = {
 	.regs = &kxcjk1013_regs,
+	.times = pm_ptr(kxtj21009_odr_start_up_times),
 	.chipset = KXTJ21009,
 };
 
 static const struct kx_chipset_info kxtf9_info = {
 	.regs = &kxtf9_regs,
+	.times = pm_ptr(kxtf9_odr_start_up_times),
 	.chipset = KXTF9,
 };
 
 static const struct kx_chipset_info kx0231025_info = {
 	.regs = &kx0231025_regs,
+	.times = pm_ptr(kx0231025_odr_start_up_times),
 	.chipset = KX0231025,
 };
 
@@ -655,12 +668,11 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 
 static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 {
-	int idx = data->info->chipset;
-	int i;
+	const struct kx_odr_start_up_time *times;
 
-	for (i = 0; i < ARRAY_SIZE(odr_start_up_times[idx]); ++i) {
-		if (odr_start_up_times[idx][i].odr_bits == data->odr_bits)
-			return odr_start_up_times[idx][i].usec;
+	for (times = data->info->times; times->usec; times++) {
+		if (times->odr_bits == data->odr_bits)
+			return times->usec;
 	}
 
 	return KXCJK1013_MAX_STARTUP_TIME_US;
-- 
2.43.0.rc1.1336.g36b5255a03ac


