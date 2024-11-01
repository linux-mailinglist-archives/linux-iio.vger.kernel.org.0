Return-Path: <linux-iio+bounces-11772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CE9B91CB
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 14:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC43C1C243B1
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCE19B3D3;
	Fri,  1 Nov 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUI+DQYx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A77168DA;
	Fri,  1 Nov 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467033; cv=none; b=kgWmUfFBocrDCv6MLqB1Y8HOZc3m7ofbFwICdIgQX6GzkDttw5EfBEk8YwqYQciY3VCbnA9+bQ86yuXGrspltcLIuQsLTyvVyS4avL3sngSEbBlKgv9KSA0ZvUhc2ybUjINdJNeybsnekAQtZSR4PAYb1AKcOFrjXKFH1PRR75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467033; c=relaxed/simple;
	bh=aOLbCzDG18JjRhWg9vu/kyWY/YfLn12G2M8765yV5HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHV+fhQ1zrZGs/oes3T82DM5s9KtTcE5l54/3fvFRPlECC1fict43v33uER+S3dcfkhhT5xsryGxZ3MOAWeebkZfVnGYnOBWkr6bTHXaneQbKShv1a3Ua3uLbiKDve+sLCUqCzibq8AffxEUMdiiSKyXu8LbCQWd0IC45fbVc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUI+DQYx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730467031; x=1762003031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aOLbCzDG18JjRhWg9vu/kyWY/YfLn12G2M8765yV5HA=;
  b=TUI+DQYx6cqVbVx4L/kfJ9ZXRR8isflgzHbzfspbM50jf6EFYEXUZ4KV
   vR2VD/Z9RSh4l+cFhvNUsq3RiFmUw6zzvf+YJYwj4pNylbkxNXojvFx+4
   Hp50swtD29LarIIWSLCH5NqJlsLQ/nQnE7KPSalcZmQtXVzuiUDYD1evx
   CnCAeV2xDSsWzxFCw4/IgT5mccTFDw9J41Gzr6T6Byjb3kNDvKn6hi9KC
   dYfAa1v6uXngPeX4+n+DzaNg/1mQt1MTbXbzlRB1idL33+IuEq7InyzQ7
   3KHpwHnyfqxnnrqfydXZIXiGXmpWP4Y9eqUQsDzr1eRnWkaIaOQI0O90A
   w==;
X-CSE-ConnectionGUID: +SgEuXhyRgq5uwWmwzfFCw==
X-CSE-MsgGUID: RBVKqQNSSvS88K0n/Nr9Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30088447"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30088447"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 06:17:11 -0700
X-CSE-ConnectionGUID: ICmC6/MhQ3WEu5u1eNIjZw==
X-CSE-MsgGUID: /E9M4tpNSQmtymv1thRh/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83100792"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 01 Nov 2024 06:17:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 458BF357; Fri, 01 Nov 2024 15:17:08 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 3/4] iio: accel: kxcjk-1013: Assign NULL to ddata in kxcjk1013_probe()
Date: Fri,  1 Nov 2024 15:16:03 +0200
Message-ID: <20241101131705.3697913-4-andriy.shevchenko@linux.intel.com>
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
uninitialised. Initialise it to NULL and drop unneeded NULL check
in kxcjk1013_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 28ed0e09d099..753ec2f71a9a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1462,7 +1462,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
 	struct kxcjk_1013_platform_data *pdata;
-	const void *ddata;
+	const void *ddata = NULL;
 	const char *name;
 	int ret;
 
@@ -1507,8 +1507,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 		data->info = (const struct kx_chipset_info *)(id->driver_data);
 	} else {
 		name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
-		if (name)
-			data->info = ddata;
+		data->info = ddata;
 		if (data->info == &kxcj91008_kiox010a_info)
 			indio_dev->label = "accel-display";
 		else if (data->info == &kxcj91008_kiox020a_info)
-- 
2.43.0.rc1.1336.g36b5255a03ac


