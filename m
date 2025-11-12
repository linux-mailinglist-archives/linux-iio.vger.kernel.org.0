Return-Path: <linux-iio+bounces-26180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69631C532E4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7485F544F0A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A60346E50;
	Wed, 12 Nov 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPgj24so"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611A346E41;
	Wed, 12 Nov 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959461; cv=none; b=YPPBCuh+jzyZ9PGbLZ9j6g3MI8VDygmPninz+3RZuy+psSDSIm4MW/yPIsUbixJqVo/7zi+E+oLFK+pVc63DZN6bkdqrP2Cf24mFYsplbSdbjgJ0KMVqX9tXrrvkkpt6URYmKlqFmMDBXF+kLMbzZJZxq992uT1XR8KJTh3FzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959461; c=relaxed/simple;
	bh=dzPIN1K4a2crXL9FdXtllClPyLCjvr+amLRN6CCJ9DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHXje7MYDg67YF7mZz/ddKPj5rgxb9QZtuyP4MZLYuSHHkFJOLnOdj0hwByMjqVkXmekmR6EdiA1PlkUfhY4LHNixRtr3uIg4wu2inOGLnGcQY3sTcWTJW6Oaibe64wGPm4hacKors5AtIZu/ZaIj1XUaMBTGocT2MNf1+S1AmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPgj24so; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762959459; x=1794495459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzPIN1K4a2crXL9FdXtllClPyLCjvr+amLRN6CCJ9DE=;
  b=hPgj24soos9MQ0bn94V+Ffm2mXCkY6Rq8qEbOB+1Kwp4X39SGYmsXE5Z
   px4vZlnyRErYhCCbB3c8YXlFoNJBaf8RjQ/HM4HPms4rTVxgXJCJ6hb4X
   yhyi4nMw5EijP7vBQ/GvtKZ6dAEX0DeoOsPyyTmBgAWClCZGwtYZPWXts
   oLuvcnDKXQZ+zK8w17D3Vel1T0fguOF6f9iJdeP70GQdjJ40dQCv/s3IK
   FEt6ILf7tRU/r9dQBQpCIPQfvEpO121WQQS3c60RAYPwRKHE1V8UKaZPj
   JabYxHD+oPe9Te0gXkLx6x/J2TJUYg0p5coLN/aFco1Bpl57FDDiTWWWR
   Q==;
X-CSE-ConnectionGUID: DweKAa+IT3SNMpR2Sm7rng==
X-CSE-MsgGUID: O2zy6zldTsaBY4HpBP3cTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64728018"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64728018"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:57:38 -0800
X-CSE-ConnectionGUID: 7mz2q09mQNC7ixwOcD8f/g==
X-CSE-MsgGUID: h0CL+YTFTgSZ8gNpn7iqHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="188874869"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2025 06:57:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2C87798; Wed, 12 Nov 2025 15:57:36 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] iio: core: Replace lockdep_set_class() + mutex_init() by combined call
Date: Wed, 12 Nov 2025 15:55:10 +0100
Message-ID: <20251112145735.2075527-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
References: <20251112145735.2075527-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace lockdep_set_class() + mutex_init() by combined call
mutex_init_with_key().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 5d2f35cf18bc..f69deefcfb6f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1717,9 +1717,8 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
-	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 
-	mutex_init(&iio_dev_opaque->mlock);
+	mutex_init_with_key(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 
 	indio_dev->dev.parent = parent;
-- 
2.50.1


