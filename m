Return-Path: <linux-iio+bounces-11634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FB9B6907
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA33285814
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A06D214424;
	Wed, 30 Oct 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJde8Tdj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A752141AA;
	Wed, 30 Oct 2024 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305220; cv=none; b=NujIX/csQ6Y7zQI04dMUBfsOw4k5aOLVqgZgxX7rZUrnrvrAhRBTs/NA1/XFnX1lcEwpooBNQcur/hyxk09xAd5AT9wz0HftvIGq066mLQdi/5/Bj9VBDG1zhlYpMJZSfYckxhitDKzaMia4m4zOUDlppg027FKCZ1gyJ4Jo1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305220; c=relaxed/simple;
	bh=N8s35Qe2bx8CieRiI0UaDWB2QYYHwBkmDmOL1tMkXBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRYya3MFtYQF8sWW4gCoA8ZDCHB4GU8l2S8uQWwaL5wxViimjzB45K0u9joMlqOqo8zPqa34cbYsKfswYYnP2cMOXD2KCMW5srEWsAkLIpSam9h/unw1TwojAPgu6kjB5MFvJZnC31B474e9YjQthf9W1ZpD2RiQqbxus0dk5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJde8Tdj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730305219; x=1761841219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N8s35Qe2bx8CieRiI0UaDWB2QYYHwBkmDmOL1tMkXBU=;
  b=WJde8TdjPWThNRM/49uGG0Ua/mbX2YpHDATD5m5+UcEIqQJa52kFl2SQ
   mKb+3+cu1UQ6GGwHBXcZEFwm696bsImdJpo6W+Wemu/G7J3HSbTerToW/
   GnmPsHlAYD49UBe9fCRo2gMzzEAVqYA/IAb6cb/r9O8hQiIKCwSEXMkDf
   2L+WfKkPNgm2Epg8J4HA+3fdEuOJlymo41KIuF2vQrfkg9b/MxhwtI6P6
   Pq9ZxPry5darQKfUVd5tA17H7iMlBz0KFowhK14IjiKmdSmPbIm0KwcoH
   hogaLJWHFIJEEaBmAeujL4moPAnqQkAWuoVfkNGgcpbKoOM9gpjA0l/+K
   Q==;
X-CSE-ConnectionGUID: 1qJ7TfPzTpe6qDQEbIc90w==
X-CSE-MsgGUID: ubVUwaUlTWuBT1Ba5BYlRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30230402"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="30230402"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:20:18 -0700
X-CSE-ConnectionGUID: tMHAJnt9SRC7gjjATOkhZw==
X-CSE-MsgGUID: QP6RjMU0Q7GTLORfzNVxEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82459067"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 30 Oct 2024 09:20:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0575B1CF; Wed, 30 Oct 2024 18:20:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/2] iio: adc: ad4000: Check for error code from devm_mutex_init() call
Date: Wed, 30 Oct 2024 18:19:18 +0200
Message-ID: <20241030162013.2100253-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com>
References: <20241030162013.2100253-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something. Add the missed
check.

Fixes: 938fd562b974 ("iio: adc: Add support for AD4000")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ad4000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 6ea491245084..b4a23c97ee52 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -637,7 +637,9 @@ static int ad4000_probe(struct spi_device *spi)
 	indio_dev->name = chip->dev_name;
 	indio_dev->num_channels = 1;
 
-	devm_mutex_init(dev, &st->lock);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	st->gain_milli = 1000;
 	if (chip->has_hardware_gain) {
-- 
2.43.0.rc1.1336.g36b5255a03ac


