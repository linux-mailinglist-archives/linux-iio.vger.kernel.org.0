Return-Path: <linux-iio+bounces-26181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A1C5345E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 17:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7C28564D18
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592C1346FB3;
	Wed, 12 Nov 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSqcILE1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D2346E46;
	Wed, 12 Nov 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959463; cv=none; b=E0cd7iAQLjgS9BwhfR+Cy26TLF3m69zbJQnQScTAUq0KKrxKIrxKD21yJ2lP/j4Ev0PUREN0WjXt3Cjx7r+HQqed2JZKfgwlmGfWQIcehaT3x59LDMMycCIoD94JfyZDB5fS2uDJZ5y2wWZnX8LEfLtK1TOu1hHFLXbgtiyazZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959463; c=relaxed/simple;
	bh=pYvFKKD4RrCAt43G3E8x50+Y+idteWAh5jNa5Ia/hIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0CP1GGDSwVIX+5TkbTrTiy+GtwEDj+e5L3Ldfr37La+T0m8ACS33tB7k8F/1az+YIlP7evRsQeMnWQRDxuPhywwmrpN1bBbBdIeu8k+cgIpHFZ7/GMBnSnyEqKgNCdaaLMPUg9+2XBVAbxLmVzVQIQiRDQb08yDIskhZTqoPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSqcILE1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762959461; x=1794495461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYvFKKD4RrCAt43G3E8x50+Y+idteWAh5jNa5Ia/hIM=;
  b=MSqcILE1RdWn4qWv5IBDifmeBCBJHFeQcJQ/7SBOJOgpMKkz1d/dkPl1
   AZo2EONc98inBl1WTjjtpXB2vG2/b7Ool95t6v8J5H8Cu7X6j4yaz+6X7
   T1ittP7+tBnVtxGxV7FJRZpWQaOivYtTIpTyzc5Kkt+oG2Dtysf/RQqeE
   NOk/xk3MRrSs7Gm33CC4CPC3O/8Y8nHcmtN8r53T53z6mZ4wkYRKXrybq
   59Pjfj3uuhDrHAPzAhHReDLdCK4h4o6/GzoT+G38cOBJr5viUsNM3MRT6
   MwWcUGttz5XWM05aVces0jQ5vj9+3mrUnkUDrnw0d4hpioxB29RlCoQFO
   A==;
X-CSE-ConnectionGUID: vrPti66AS6+JI4t9bHB2RA==
X-CSE-MsgGUID: dsXjd++cSCak1ayNWfjeFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64728026"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64728026"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:57:38 -0800
X-CSE-ConnectionGUID: 4bq1oUjrT7iPAASnPCeSXw==
X-CSE-MsgGUID: C9L1zFCQSJSZoFeRN3g+WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="188874871"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2025 06:57:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 28E9097; Wed, 12 Nov 2025 15:57:36 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] iio: core: Clean up device correctly on iio_device_alloc() failure
Date: Wed, 12 Nov 2025 15:55:09 +0100
Message-ID: <20251112145735.2075527-3-andriy.shevchenko@linux.intel.com>
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

Once we called device_initialize() we have to call put_device()
on it. Refactor the code to make it in the right order.

Fixes: fe6f45f6ba22 ("iio: core: check return value when calling dev_set_name()")
Fixes: 847ec80bbaa7 ("Staging: IIO: core support for device registration and management")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 93d6e5b101cf..5d2f35cf18bc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1697,11 +1697,6 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 		ACCESS_PRIVATE(indio_dev, priv) = (char *)iio_dev_opaque +
 			ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN);
 
-	indio_dev->dev.parent = parent;
-	indio_dev->dev.type = &iio_device_type;
-	indio_dev->dev.bus = &iio_bus_type;
-	device_initialize(&indio_dev->dev);
-
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
 	iio_dev_opaque->id = ida_alloc(&iio_ida, GFP_KERNEL);
@@ -1727,6 +1722,11 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	mutex_init(&iio_dev_opaque->mlock);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 
+	indio_dev->dev.parent = parent;
+	indio_dev->dev.type = &iio_device_type;
+	indio_dev->dev.bus = &iio_bus_type;
+	device_initialize(&indio_dev->dev);
+
 	return indio_dev;
 }
 EXPORT_SYMBOL(iio_device_alloc);
-- 
2.50.1


