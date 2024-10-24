Return-Path: <linux-iio+bounces-11222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3739AF25F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F42894CC
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474D921BB07;
	Thu, 24 Oct 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKWuizoa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60ED21A6FB;
	Thu, 24 Oct 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797134; cv=none; b=Zm9b+O89optTLflRSdk1DwhbU1kG9DzjkgMaQeh1mvl04FCrZtfSKZ6GCRzZmeWaQkFervxTpGT0UMbHfIndscwpkusQ9cessqireV8ArrkTcgR6oQBHfBrzEAj9oi8nEdWh8k/pnHHyvRRAPvlR1ana3EGCO+67HpDQLyO4T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797134; c=relaxed/simple;
	bh=bTHjEgjwF7ziSPu2OTlI6hYQ0inmQWL2SPBud47igzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meA/njnjqVIA3g4IyJJX6eq4bU4m5EOb8ZAJm08Vbh+qhHLDD7FKt148+y4rwsEazzpeKV7OIQi8FejEZb4CGZnu3v1cI7/JqkDaCbi3A990qCHKqcfoqy0ZMHgVUKG2okB10H/jwSFWzdYCvdbxDzQWJqQT+0KR3/299o6vjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKWuizoa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797132; x=1761333132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bTHjEgjwF7ziSPu2OTlI6hYQ0inmQWL2SPBud47igzQ=;
  b=kKWuizoauO6zIHS0wxi4RRnsbU0KK7BKpInXK9CCu6RXuksE8FWPUD2S
   4rwjLugobfZyV4uYbLpDEJ8brPj7aU3Tm+zh8CIbGVXZ/T2VD2Gtx9y3f
   smTfYlSRmGKyobVi/gHr3rsmDNVUWKUxFPm3HAyMFGTAUUSAdqmMCFFRd
   vwkXwESCkZg9XxyW2MMbxjvRMsVrz1lCo/enBgJFiZWYWaVZNmpuQ7Q/F
   vf6bt+6+f+Jch7eWblOGFPszoN2ySTZUIvNB9GVqVcEF9gx5Yfupp5Vk7
   hnxdk3L2mYyFsGYXIcjW6OmjCyQEp9LPmx0CcbNY8Ns2iPM3c7YvwteJ1
   Q==;
X-CSE-ConnectionGUID: EnZW/ztwS7Cv4Ptl1COvIA==
X-CSE-MsgGUID: ksu17oOtTT2mji9q/UfvMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934449"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: xztK5kVWT5m08OJRI5kwqw==
X-CSE-MsgGUID: G1bb/SvzRbyhO4bdp9Edug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266683"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A356374C; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 12/24] iio: accel: kxcjk-1013: Move odr_start_up_times up in the code
Date: Thu, 24 Oct 2024 22:05:01 +0300
Message-ID: <20241024191200.229894-13-andriy.shevchenko@linux.intel.com>
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

Move odr_start_up_times up in the code in a preparation of
the further cleaning up changes.

While at it, make it clear what values from enum are being used for
the respective array entries.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 154 ++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 37c82fdf7c43..f384969a922d 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -178,6 +178,83 @@ enum kx_chipset {
 	KX_MAX_CHIPS /* this must be last */
 };
 
+/* Refer to section 4 of the specification */
+static const struct {
+	int odr_bits;
+	int usec;
+} odr_start_up_times[KX_MAX_CHIPS][12] = {
+	/* KXCJK-1013 */
+	[KXCJK1013] = {
+		{0x08, 100000},
+		{0x09, 100000},
+		{0x0A, 100000},
+		{0x0B, 100000},
+		{0, 80000},
+		{0x01, 41000},
+		{0x02, 21000},
+		{0x03, 11000},
+		{0x04, 6400},
+		{0x05, 3900},
+		{0x06, 2700},
+		{0x07, 2100},
+	},
+	/* KXCJ9-1008 */
+	[KXCJ91008] = {
+		{0x08, 100000},
+		{0x09, 100000},
+		{0x0A, 100000},
+		{0x0B, 100000},
+		{0, 80000},
+		{0x01, 41000},
+		{0x02, 21000},
+		{0x03, 11000},
+		{0x04, 6400},
+		{0x05, 3900},
+		{0x06, 2700},
+		{0x07, 2100},
+	},
+	/* KXCTJ2-1009 */
+	[KXTJ21009] = {
+		{0x08, 1240000},
+		{0x09, 621000},
+		{0x0A, 309000},
+		{0x0B, 151000},
+		{0, 80000},
+		{0x01, 41000},
+		{0x02, 21000},
+		{0x03, 11000},
+		{0x04, 6000},
+		{0x05, 4000},
+		{0x06, 3000},
+		{0x07, 2000},
+	},
+	/* KXTF9 */
+	[KXTF9] = {
+		{0x01, 81000},
+		{0x02, 41000},
+		{0x03, 21000},
+		{0x04, 11000},
+		{0x05, 5100},
+		{0x06, 2700},
+	},
+	/* KX023-1025 */
+	[KX0231025] = {
+		/* First 4 are not in datasheet, taken from KXCTJ2-1009 */
+		{0x08, 1240000},
+		{0x09, 621000},
+		{0x0A, 309000},
+		{0x0B, 151000},
+		{0, 81000},
+		{0x01, 40000},
+		{0x02, 22000},
+		{0x03, 12000},
+		{0x04, 7000},
+		{0x05, 4400},
+		{0x06, 3000},
+		{0x07, 3000},
+	},
+};
+
 enum kx_acpi_type {
 	ACPI_GENERIC,
 	ACPI_SMO8500,
@@ -361,83 +438,6 @@ static const struct kx_odr_map kxtf9_samp_freq_table[] = {
 static const char *const kxtf9_samp_freq_avail =
 	"25 50 100 200 400 800";
 
-/* Refer to section 4 of the specification */
-static const struct {
-	int odr_bits;
-	int usec;
-} odr_start_up_times[KX_MAX_CHIPS][12] = {
-	/* KXCJK-1013 */
-	{
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
-	{
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
-	{
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
-	{
-		{0x01, 81000},
-		{0x02, 41000},
-		{0x03, 21000},
-		{0x04, 11000},
-		{0x05, 5100},
-		{0x06, 2700},
-	},
-	/* KX023-1025 */
-	{
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
-};
-
 static const struct {
 	u16 scale;
 	u8 gsel_0;
-- 
2.43.0.rc1.1336.g36b5255a03ac


