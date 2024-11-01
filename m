Return-Path: <linux-iio+bounces-11774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A65B9B91CF
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0331F22C33
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9B4594D;
	Fri,  1 Nov 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JG7KG6NJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287D4503C;
	Fri,  1 Nov 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467035; cv=none; b=i0V/+afueMBGod/GxFurUIsbYbVcseNzboJC0qaJMcgPgrKFUaE4dMMaKTyKp33WPqAxromulPZpsBmao6a+PkIBU7oMCboAsCgZr9v0DoSwiN+j+UAP5PsTq/7FXrc5Nyc9EhaJry7mdIavDZNn0uhzgmKOUFon9B4lojCWhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467035; c=relaxed/simple;
	bh=dju4LAP4QTdsPDNP1GHQ1R4Awpczpb0FwVCmmtIPoE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHqyq75F8J3dyHoXqYfoAcSDkme7AX6PXKvRAALWWH+O52iRttEE20rBEEp3tUUL2UZNWlrQcqL7ibhVJTdaNXhOa8CpFjiyAMbGOz7YIyS0OCETazOdr7S2z4PwQRzw+DfwBmVvQxqnDfMMgLAkWm6zKmoDyFcEMMg2dLFhCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JG7KG6NJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467034; x=1762003034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dju4LAP4QTdsPDNP1GHQ1R4Awpczpb0FwVCmmtIPoE0=;
  b=JG7KG6NJiuK1HaFMPrk0KskEW5nq1Sv6k/gaqHfrkiH67q+NfxTyQAI0
   ncYlKtPWx9nhmmr9Mq5k3Ll93jxsH4euQgVXBKePMmxfSVrGt6gT/ROB5
   7Xhplw46y/xdFMTuqxcPuaO+pm8b6umTZzzKgVHyOY2M0nzh8yOqKwj/F
   WePyeWC0RG6FRrjSBZPavNlL3QKQ0yQBBtPwaOb5OhfG+XRLBIKZACX7t
   mYl9RN1cXI47iTbsSKW30SSo45jpAmEMXWvKp63FOZcvHjEsKxPdSSsjl
   FksLRg7boWHvAMWB6D8+kaW9ALlhpIKlvdemATfHX2z+40+G3ru4pos26
   w==;
X-CSE-ConnectionGUID: h+chALQFS9uPg63XwKoLKQ==
X-CSE-MsgGUID: TZcR7D+YRV27N6UDWR7T1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33920655"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33920655"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:17:11 -0700
X-CSE-ConnectionGUID: 94z10vAnQhuht2Di7MimOA==
X-CSE-MsgGUID: /6g0SziUR62Iz/qqlYdDiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87754310"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2024 06:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 281F693; Fri, 01 Nov 2024 15:17:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 1/4] iio: light: isl29018: Assign NULL to ddata in isl29018_probe()
Date: Fri,  1 Nov 2024 15:16:01 +0200
Message-ID: <20241101131705.3697913-2-andriy.shevchenko@linux.intel.com>
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

When iio_get_acpi_device_name_and_data() fails, the ddata may be left
uninitialised. Initialise it to NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain
Fixes: 14686836fb69 ("iio: light: isl29018: Replace a variant of iio_get_acpi_device_name_and_data()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/isl29018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index cbe34026bda6..201eae1c4589 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -703,7 +703,7 @@ static int isl29018_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct isl29018_chip *chip;
 	struct iio_dev *indio_dev;
-	const void *ddata;
+	const void *ddata = NULL;
 	const char *name;
 	int dev_id;
 	int err;
-- 
2.43.0.rc1.1336.g36b5255a03ac


