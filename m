Return-Path: <linux-iio+bounces-11775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4209B91D2
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CB41F2264C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C21AA785;
	Fri,  1 Nov 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2fsHLML"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90179195811;
	Fri,  1 Nov 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467036; cv=none; b=MH5ji4uqrj3qCyorZgtlfyXXkGK92+8GWt6Y62S4ZyAdhiLFuqKtZvzkmp6EZQ/g/oPFRxx72eDzlGecWw30Vmr5fTTA9qo8/Nr5zxdVihR+sC7Edp6uwGMj2Tc+m1ZxNaRKba+OIv+PWkot6jXqVzDqARUDoeGSLDP/NOz4E2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467036; c=relaxed/simple;
	bh=zb/4/bFX10GCalAWVbRwK1NHWuKv704m0q1ZHqlV4MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyngTB8O1uoDBeg7dk+fR7C1vUZbOkf7+dueTU3+pvwp+McS4BcCfQlo8G5tc/hV7XGw0P+d1/HmUqN1EKfk8MuVURjRy4f9oTLo4YHeBPDU8zFZ60dYSfbM6iftywjLozDZinGT1go7q9ZVbnw4p7wZQVwsdLIj0bdEceDgRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2fsHLML; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467033; x=1762003033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zb/4/bFX10GCalAWVbRwK1NHWuKv704m0q1ZHqlV4MM=;
  b=P2fsHLMLCuBCeaCkMyZW333QaU9wUTfPA+HG18NKPA5HuJ1bKW6831wV
   dS/xydRcnKJ5rENrjmHsFXPITXdBLO4cy9jhYkzyx32UOcHcanyMP2POD
   3ZVQIoP9wkCPw6RWJiVVwS6pi2qooh6bwdut0AdzmlHh3D+9fGJK4+t5e
   tHoA3Uez/NYpL9dQfXGAW4kkbXACq/toAxYYD51gP46qX1CrSyrdOHrDf
   HrwwqolWoLev21VDmINUzDxbEVbhEDLqtXz5F/UdBiAaNdEmmG+/C+395
   KPFK2RI9v3Ny3VAcbE7tN/+/uovUMvDsXa8CxF0yUDnUGN4HYge8q4B5/
   A==;
X-CSE-ConnectionGUID: wm8RaoR9Qua9HSk5wp6CFA==
X-CSE-MsgGUID: 4rjonPSpQreaUstr3f4c7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30088451"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30088451"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:17:11 -0700
X-CSE-ConnectionGUID: l0OJ6fyyS3WeV8QytZGIcw==
X-CSE-MsgGUID: xGC0gNFeSb+w03fa+4FomA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83100793"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 01 Nov 2024 06:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 321C62AF; Fri, 01 Nov 2024 15:17:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 2/4] iio: light: ltr501: Assign NULL to ddata in ltr501_probe()
Date: Fri,  1 Nov 2024 15:16:02 +0200
Message-ID: <20241101131705.3697913-3-andriy.shevchenko@linux.intel.com>
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
Fixes: 61da460b813d ("iio: light: ltr501: Replace a variant of iio_get_acpi_device_name_and_data()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 7228611d4c59..616dc6921702 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1424,8 +1424,8 @@ static int ltr501_probe(struct i2c_client *client)
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
+	const void *ddata = NULL;
 	int partid, chip_idx;
-	const void *ddata;
 	const char *name;
 	int ret;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


