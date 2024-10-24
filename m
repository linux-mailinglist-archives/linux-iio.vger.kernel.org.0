Return-Path: <linux-iio+bounces-11225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4A9AF265
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956491C25D69
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E021C193;
	Thu, 24 Oct 2024 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkc1j1oi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13221B42E;
	Thu, 24 Oct 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797135; cv=none; b=sNvxI6dEddmxAAR92VoDTemdImUf97TZfWlCQioER8PpIrBLVC6Er3pVzw3bDOQM3YrK0lF1BF4+pHDqSZz9UDFDXUMyUwiLcTioCSIHDvHmpSP47HZDWcmeePayVxYrFbf+ln/gz4pmL7z79bjTMkwi6dmgidykz7aBh8Nywrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797135; c=relaxed/simple;
	bh=lQsVcIQwAn8KhzDOMnY7WmBQepBX8sbl0BQBGSWimoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyJdqM/jThaYxdEWUYmgv/sqw1HzXOJRL/XpYAZx2e5D30tFrnq6jWyt6ebwijlpm+YN6FqPm3uWGQKjA0OvOVqjy5l7TwT9zdaDS06jgV7VRGHHB3051aSkZJMt+GV8768gilJIOdaNpN0P76dSLCo3G9aaZLg3WOoHqfP1mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkc1j1oi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797133; x=1761333133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQsVcIQwAn8KhzDOMnY7WmBQepBX8sbl0BQBGSWimoU=;
  b=mkc1j1oiz3mWYnoVg9lRrpyYKz0RCx7WjDbxsrOMQzQOKgIzYO6N7mOq
   KvmSyEPCE1+WvWPMLtinoJRBDbuCGxXZcjTRqiGgRfHEgvlryFc8TAOhJ
   /+BbzeqPsNtIwR13LN3ldUxQNuWGE36gF0J0DEzDZgn5fyyj0KrvxF8k2
   Ucr3/BwgqNI0Pg1TZQsXGlFqqOaICzDsWrk+J/L7aj8svQt23XwQIpy5M
   Pfc44QiyzQLFlK9hrq+tvi52wlL3fJz7E8U9aChmWhZsj4e9TzOsTPuJg
   1qrFBTHz2BODFfcOf9a1dLUwo/0cP5vPWCCDSL9ISWV+mQuzPorK3f2DD
   g==;
X-CSE-ConnectionGUID: 5J83zkmQRuGu7tLs6VtvqQ==
X-CSE-MsgGUID: QqBzVvzXRtSUT6HbjVOicA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934473"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934473"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: 6sZhBLgJQzCLw8OwzjoGUA==
X-CSE-MsgGUID: MlFM+kzHS6mqaiPNcF+WpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266688"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B827B7B8; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 14/24] iio: accel: kxcjk-1013: Get rid of enum kx_chipset
Date: Thu, 24 Oct 2024 22:05:03 +0300
Message-ID: <20241024191200.229894-15-andriy.shevchenko@linux.intel.com>
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

Instead of using enum, out of which only a couple of values
are being actully used, make a comparisons against pointer
to the respective chip_info structures.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 91f890275a18..a8c73e401f95 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -169,15 +169,6 @@
 
 #define KXCJK1013_DEFAULT_WAKE_THRES	1
 
-enum kx_chipset {
-	KXCJK1013,
-	KXCJ91008,
-	KXTJ21009,
-	KXTF9,
-	KX0231025,
-	KX_MAX_CHIPS /* this must be last */
-};
-
 /* Refer to section 4 of the specification */
 struct kx_odr_start_up_time {
 	int odr_bits;
@@ -318,59 +309,50 @@ static const struct kx_chipset_regs kx0231025_regs = {
 struct kx_chipset_info {
 	const struct kx_chipset_regs *regs;
 	const struct kx_odr_start_up_time *times;
-	enum kx_chipset chipset;
 	enum kx_acpi_type acpi_type;
 };
 
 static const struct kx_chipset_info kxcjk1013_info = {
 	.regs = &kxcjk1013_regs,
 	.times = pm_ptr(kxcjk1013_odr_start_up_times),
-	.chipset = KXCJK1013,
 };
 
 static const struct kx_chipset_info kxcj91008_info = {
 	.regs = &kxcjk1013_regs,
 	.times = pm_ptr(kxcj91008_odr_start_up_times),
-	.chipset = KXCJ91008,
 };
 
 static const struct kx_chipset_info kxcj91008_kiox010a_info = {
 	.regs = &kxcjk1013_regs,
 	.times = pm_ptr(kxcj91008_odr_start_up_times),
-	.chipset = KXCJ91008,
 	.acpi_type = ACPI_KIOX010A,
 };
 
 static const struct kx_chipset_info kxcj91008_kiox020a_info = {
 	.regs = &kxcjk1013_regs,
 	.times = pm_ptr(kxcj91008_odr_start_up_times),
-	.chipset = KXCJ91008,
 	.acpi_type = ACPI_GENERIC,
 };
 
 static const struct kx_chipset_info kxcj91008_smo8500_info = {
 	.regs = &kxcjk1013_regs,
 	.times = pm_ptr(kxcj91008_odr_start_up_times),
-	.chipset = KXCJ91008,
 	.acpi_type = ACPI_SMO8500,
 };
 
 static const struct kx_chipset_info kxtj21009_info = {
 	.regs = &kxcjk1013_regs,
 	.times = pm_ptr(kxtj21009_odr_start_up_times),
-	.chipset = KXTJ21009,
 };
 
 static const struct kx_chipset_info kxtf9_info = {
 	.regs = &kxtf9_regs,
 	.times = pm_ptr(kxtf9_odr_start_up_times),
-	.chipset = KXTF9,
 };
 
 static const struct kx_chipset_info kx0231025_info = {
 	.regs = &kx0231025_regs,
 	.times = pm_ptr(kx0231025_odr_start_up_times),
-	.chipset = KX0231025,
 };
 
 enum kxcjk1013_axis {
@@ -647,7 +629,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	}
 
 	/* On KX023, route all used interrupts to INT1 for now */
-	if (data->info->chipset == KX0231025 && data->client->irq > 0) {
+	if (data->info == &kx0231025_info && data->client->irq > 0) {
 		ret = i2c_smbus_write_byte_data(data->client, KX023_REG_INC4,
 						KX023_REG_INC4_DRDY1 |
 						KX023_REG_INC4_WUFI1);
@@ -883,7 +865,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 	if (ret < 0)
 		return ret;
 
-	if (data->info->chipset == KXTF9)
+	if (data->info == &kxtf9_info)
 		odr_setting = kxcjk1013_find_odr_value(kxtf9_samp_freq_table,
 						       ARRAY_SIZE(kxtf9_samp_freq_table),
 						       val, val2);
@@ -927,7 +909,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
 {
-	if (data->info->chipset == KXTF9)
+	if (data->info == &kxtf9_info)
 		return kxcjk1013_convert_odr_value(kxtf9_samp_freq_table,
 						   ARRAY_SIZE(kxtf9_samp_freq_table),
 						   data->odr_bits, val, val2);
@@ -1194,7 +1176,7 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 	const char *str;
 
-	if (data->info->chipset == KXTF9)
+	if (data->info == &kxtf9_info)
 		str = kxtf9_samp_freq_avail;
 	else
 		str = kxcjk1013_samp_freq_avail;
@@ -1443,7 +1425,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 	}
 
 	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
-		if (data->info->chipset == KXTF9)
+		if (data->info == &kxtf9_info)
 			iio_push_event(indio_dev,
 				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 				       0,
-- 
2.43.0.rc1.1336.g36b5255a03ac


