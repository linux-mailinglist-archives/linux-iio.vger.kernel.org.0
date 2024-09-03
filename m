Return-Path: <linux-iio+bounces-9102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97796AA26
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 23:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A811F25BB8
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE41CF7DD;
	Tue,  3 Sep 2024 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPonUOwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386131946B3;
	Tue,  3 Sep 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398978; cv=none; b=ohgsisvQAwyiS4G9BLWBnB1sG0IOivo6282xtxgwY/YnF2smg102tyjVm4vx1Pch/xAfSyN3Ak7ngvJmcW7wosWk74NEo06GlDWd0avcFqls85Vvj4NDmGFvkGq/lg2naHmhx2qs8RLnFXEhU0xiG8Qo4zUNsHf6Rm29E3qJULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398978; c=relaxed/simple;
	bh=w54SVlVeEUFCmYJKwf/xbI5scbr67deThfvxet6SzkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGyiAAt6z/y4lW0OpZ525y9MOdKECOvp/6Jd6YdPR5t7WkCFNOIYfEPXxGmLvkujPV57mVE5L6KovEwavZto9OvMZTNFIcXzRj9Ir4/hWfgAAv03VfkZpsfLpr+I6gAMZ+K7g8u9wSlICS5qEE4UCfOjeOSKJjrjmRRXZF5F0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPonUOwC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725398976; x=1756934976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w54SVlVeEUFCmYJKwf/xbI5scbr67deThfvxet6SzkM=;
  b=jPonUOwCn8QOtGXydHe9SWcfpztGJE3/4Ew4SNV4gGnMQeT59ix0oWVr
   Rcrzs1m1b/HX0OdnIDaWSpx4NPKeieWM/jO5woH6zUzNC7XVkMkn3SEJ/
   o+6nYbCUZ7p3GScVE6RJ5H/3l1GXwHeBPoy2AKF3Ik8CISJdLgPU6spys
   oB6JT0/+cZxnGTF/mREteVxtILFTdqjQrC1lFKrLkaPNjtatzu+4CnlJ7
   CzyAQEGqeqmb6VQjomxCbL0+2LYzo4SxgAMDMV57h75sr1itZmi/oKD0I
   2WEqdVpPcWLYNVecFrzPbbDjGk6J8wq3F+HxQJjGH5lI3Z377NonfEsbh
   w==;
X-CSE-ConnectionGUID: dGhnz31KTcCVcyWssgCrsw==
X-CSE-MsgGUID: qbzVrMFTT1609Tgrzdu2vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23588418"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23588418"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 14:29:35 -0700
X-CSE-ConnectionGUID: WsUSqZhfRgKSV+PIpyIzQg==
X-CSE-MsgGUID: 82p4Z4PdSTecbPZZgM781w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="102459367"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 03 Sep 2024 14:29:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8143A48D; Wed, 04 Sep 2024 00:29:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/3] iio: proximity: sx_common: Unexport sx_common_get_raw_register_config()
Date: Wed,  4 Sep 2024 00:28:21 +0300
Message-ID: <20240903212922.3731221-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
References: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx_common_get_raw_register_config() is used in a single driver,
move it there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx9324.c    | 20 ++++++++++++++++++++
 drivers/iio/proximity/sx_common.c | 21 ---------------------
 drivers/iio/proximity/sx_common.h |  3 ---
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 629f83c37d59..40747d7f6e7e 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -868,6 +868,26 @@ static u8 sx9324_parse_phase_prop(struct device *dev,
 	return raw;
 }
 
+static void sx_common_get_raw_register_config(struct device *dev,
+					      struct sx_common_reg_default *reg_def)
+{
+#ifdef CONFIG_ACPI
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	u32 raw = 0, ret;
+	char prop[80];
+
+	if (!reg_def->property || !adev)
+		return;
+
+	snprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", acpi_device_hid(adev), reg_def->property);
+	ret = device_property_read_u32(dev, prop, &raw);
+	if (ret)
+		return;
+
+	reg_def->def = raw;
+#endif
+}
+
 static const struct sx_common_reg_default *
 sx9324_get_default_reg(struct device *dev, int idx,
 		       struct sx_common_reg_default *reg_def)
diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 71aa6dced7d3..bcf502e02342 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -421,27 +421,6 @@ static const struct iio_buffer_setup_ops sx_common_buffer_setup_ops = {
 	.postdisable = sx_common_buffer_postdisable,
 };
 
-void sx_common_get_raw_register_config(struct device *dev,
-				       struct sx_common_reg_default *reg_def)
-{
-#ifdef CONFIG_ACPI
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	u32 raw = 0, ret;
-	char prop[80];
-
-	if (!reg_def->property || !adev)
-		return;
-
-	snprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", acpi_device_hid(adev), reg_def->property);
-	ret = device_property_read_u32(dev, prop, &raw);
-	if (ret)
-		return;
-
-	reg_def->def = raw;
-#endif
-}
-EXPORT_SYMBOL_NS_GPL(sx_common_get_raw_register_config, SEMTECH_PROX);
-
 #define SX_COMMON_SOFT_RESET				0xde
 
 static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
index 101b90e52ff2..175505eaae7b 100644
--- a/drivers/iio/proximity/sx_common.h
+++ b/drivers/iio/proximity/sx_common.h
@@ -150,9 +150,6 @@ int sx_common_probe(struct i2c_client *client,
 		    const struct sx_common_chip_info *chip_info,
 		    const struct regmap_config *regmap_config);
 
-void sx_common_get_raw_register_config(struct device *dev,
-				       struct sx_common_reg_default *reg_def);
-
 /* 3 is the number of events defined by a single phase. */
 extern const struct iio_event_spec sx_common_events[3];
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


