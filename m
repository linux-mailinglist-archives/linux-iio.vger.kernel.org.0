Return-Path: <linux-iio+bounces-26182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BE1C53233
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 16:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E63E6501BA4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Nov 2025 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E63451CA;
	Wed, 12 Nov 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qzx54ikB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D45346E58;
	Wed, 12 Nov 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959463; cv=none; b=RFxfetxlTkMRHZAnGF2SIupZ7l36BZDPySNRXMKkxEOApIydTaBhGqX0kPpAFEyL/RVNUHyvYBxHDo2QlKvW22FsCA9x9KQIfXlp2vKhXiiMuqtF0Boptbh2AesYpUibz7063elGEEgtvAvdRhh8SO8soIoNJEk0TJvzDwIIQn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959463; c=relaxed/simple;
	bh=igzg+SgGyMnbqCojYaqGL+0t/DAUq1ocYpBoPxC7Ko4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogm4EWCjrfS+NeJipIZBDb2ub+yLw5az5V7fOVPjgFK7BQKIuF8g8mQge32AhZsdvfuT7tsHBstIVXjH7hln6/veqvVU1h5EkBCRdLKsRbk0j72GE3ts/zZoxgxVwih0asSZVxwgv5eQjITi+pfLDfWfo2X1AvyOa4foQ01+Y0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qzx54ikB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762959461; x=1794495461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=igzg+SgGyMnbqCojYaqGL+0t/DAUq1ocYpBoPxC7Ko4=;
  b=Qzx54ikBxmdnc52ryUoB1smrsr7IgpQZ/3HSD9PH31HYM/edSLCLliLh
   k6yttJQuWCdmt7wP9nTKtU+zn42D5IjgOUDju16dPA6FwqQaXMdzHWBPT
   Gs20AnuEXpm7BOkdlRPpllNyHQvXtCetdcEMQlt6qIx/eeofG4eef4deV
   utpauYzSoAzZV+MN4MDl4zkLP7uzUYe8+wL/6h6GaWizKq3L6tpvSbNbU
   I/ShZbY/5sLlJftXl+AOrX5Sr0EgJjt+oFMRCfiXNFKS0I4liE83Y813M
   hrE3Yyk1El0jCCfktyWULbfnHLUdGQCV3DXTX78q7Smz6q4+9KNZTeP0o
   A==;
X-CSE-ConnectionGUID: TdSYsctmTfiLevErmHCA7g==
X-CSE-MsgGUID: 5KGMhpJfQKW80B2vgc/VCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64728031"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64728031"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:57:38 -0800
X-CSE-ConnectionGUID: mBBSeF9USISFXGG3QWB+dg==
X-CSE-MsgGUID: hINlLCbwQsSAi1BNT9b0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="188874872"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2025 06:57:37 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 24F0696; Wed, 12 Nov 2025 15:57:36 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] iio: core: add missing mutex_destroy in iio_dev_release()
Date: Wed, 12 Nov 2025 15:55:08 +0100
Message-ID: <20251112145735.2075527-2-andriy.shevchenko@linux.intel.com>
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

Add missing mutex_destroy() call in iio_dev_release() to properly
clean up the mutex initialized in iio_device_alloc(). Ensure proper
resource cleanup and follows kernel practices.

Found by code review.

While at it, create a lockdep key before mutex initialisation.
This will help with converting it to the better API in the future.

Fixes: 847ec80bbaa7 ("Staging: IIO: core support for device registration and management")
Fixes: ac917a81117c ("staging:iio:core set the iio_dev.info pointer to null on unregister under lock.")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 88c3d585a1bd..93d6e5b101cf 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1654,6 +1654,9 @@ static void iio_dev_release(struct device *device)
 
 	iio_device_detach_buffers(indio_dev);
 
+	mutex_destroy(&iio_dev_opaque->info_exist_lock);
+	mutex_destroy(&iio_dev_opaque->mlock);
+
 	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
 
 	ida_free(&iio_ida, iio_dev_opaque->id);
@@ -1698,8 +1701,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	indio_dev->dev.type = &iio_device_type;
 	indio_dev->dev.bus = &iio_bus_type;
 	device_initialize(&indio_dev->dev);
-	mutex_init(&iio_dev_opaque->mlock);
-	mutex_init(&iio_dev_opaque->info_exist_lock);
+
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
 	iio_dev_opaque->id = ida_alloc(&iio_ida, GFP_KERNEL);
@@ -1722,6 +1724,9 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
 	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 
+	mutex_init(&iio_dev_opaque->mlock);
+	mutex_init(&iio_dev_opaque->info_exist_lock);
+
 	return indio_dev;
 }
 EXPORT_SYMBOL(iio_device_alloc);
-- 
2.50.1


