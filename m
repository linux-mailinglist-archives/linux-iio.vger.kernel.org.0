Return-Path: <linux-iio+bounces-11757-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12A9B8FC3
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 11:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF17E1C2116D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B1C168488;
	Fri,  1 Nov 2024 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghJQ3v9o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB9170A3D;
	Fri,  1 Nov 2024 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458429; cv=none; b=FIhC6HIbT9bnn5jh3OKfCjmBiuaByDGMDOE21HWzNFljcRluZ4QDz7PzNoafm0oPw9Q4JZc2QH9hZS5aJ9Mv3goVqLkf0DdokNCXcbnFJJbkwJAh96CNhPbMyTMwuQMP/ivzv9IQHvb4IiyRgm7EcjbzSUMRV77/LSkqr4QmFKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458429; c=relaxed/simple;
	bh=3nd+aO8xFQcDiX2wwxz/jvBUUPBaYHyn5n+Smz/yuVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCB8whRsoRDAGYvRuJTbyz/TemfrhSjkiqVpH3uaTjyIy/IpTyfFhZ2J4hOTcrCNoOF/p5Ue5qSiIyyl1ZYwqiRmpZpOe3YGVK/05DJv7tzjIIRL4MRpVkCt8ge0vErbxA4E8D5WFtQbCc6xKZVWcqIblsqkRUYcCvROj+Sy9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghJQ3v9o; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730458427; x=1761994427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3nd+aO8xFQcDiX2wwxz/jvBUUPBaYHyn5n+Smz/yuVs=;
  b=ghJQ3v9oMBzEBBP8Gz630GLOWmGVKmM3AA2iRHSOyDoMzrRcH0uG4MoK
   sES0BgooQWZuGuu2apD9ejLoTQb+ofVtGwg2QQVQnBdBrjxJQ5qSRppMZ
   CuDxbS1jfCtu43y4LeMxRnPhTP91kQabaHJgOqEl2qpBv//EOnrDwVJrU
   PnjnFSjKT538LOo32e6T8hQ+pDa3zkH5LSoOfdwXaLEdfgRu7b+icAq2M
   GSIa4g8vtrxssXTfAzaPbyLxRUX0HBncca9YePilhv6Z1XyEVF4N8jgsi
   ri+cm5jMYQyAxQYJH74XyAy7cb/k2rReV8M0MHao2MOq835nEmOIee8+7
   A==;
X-CSE-ConnectionGUID: fNvHRwlHTk+T6pQZ0A5CHA==
X-CSE-MsgGUID: fYru22mWQcOzf1NybcV8CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30179197"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30179197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 03:53:47 -0700
X-CSE-ConnectionGUID: 6jJUseMgSh6YMKn1wOdLBQ==
X-CSE-MsgGUID: nI7LtuUOTBaUS/BqiH5rfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="87748250"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2024 03:53:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BA8871AC; Fri, 01 Nov 2024 12:53:43 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: Mark iio_dev::priv member with __private
Date: Fri,  1 Nov 2024 12:53:42 +0200
Message-ID: <20241101105342.3645018-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The member is not supposed to be accessed directly, mark it with
__private to catch the misuses up.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 include/linux/iio/iio.h         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6a6568d4a2cb..4c543490e56c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1665,7 +1665,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	indio_dev = &iio_dev_opaque->indio_dev;
 
 	if (sizeof_priv)
-		indio_dev->priv = (char *)iio_dev_opaque +
+		ACCESS_PRIVATE(indio_dev, priv) = (char *)iio_dev_opaque +
 			ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN);
 
 	indio_dev->dev.parent = parent;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 445d6666a291..5c6682bd4cb9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -624,7 +624,7 @@ struct iio_dev {
 	const struct iio_info		*info;
 	const struct iio_buffer_setup_ops	*setup_ops;
 
-	void				*priv;
+	void				*priv __private;
 };
 
 int iio_device_id(struct iio_dev *indio_dev);
@@ -785,7 +785,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 /* The information at the returned address is guaranteed to be cacheline aligned */
 static inline void *iio_priv(const struct iio_dev *indio_dev)
 {
-	return indio_dev->priv;
+	return ACCESS_PRIVATE(indio_dev, priv);
 }
 
 void iio_device_free(struct iio_dev *indio_dev);
-- 
2.43.0.rc1.1336.g36b5255a03ac


