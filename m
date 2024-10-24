Return-Path: <linux-iio+bounces-11233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4CD9AF276
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F421F26908
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A34228B7E;
	Thu, 24 Oct 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkfndoRx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83C3224B68;
	Thu, 24 Oct 2024 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797140; cv=none; b=IuRRf7qKd+AhJyG/o1VXrfgSx6rOsLtRyMREK+liJ05+eJtxiab7wGGAYk+YJxFNn1zZG5qO4FsJEXdSnQ1mV9E2XFv4JGtuaK2ph/ScJ9zk8pgUZlLwbSxyxyLcqczfKbpR9ELQXFTMgbggG3zlgBZE000+Otr5P07fCZeNbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797140; c=relaxed/simple;
	bh=Iocz/KVSforp7TWPBNMBSymCJu2I9Wm9f+hSS1P8ifo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXs373SilWeEh1h1QoUNOh5mgqG29wut0c4z+P6ve9iXKco+5yGA+qv7t55ICYUKBL3LXfwxqUUj/cZZNYioykMO8oa7Eex80eieZVGd7Dg8+XxgtF6Eq4oPsIc5fR717JRgJ+2tb5uZxxU5VP/+DACHW3e/g++KQdA098eMKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkfndoRx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797139; x=1761333139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iocz/KVSforp7TWPBNMBSymCJu2I9Wm9f+hSS1P8ifo=;
  b=TkfndoRxlxQNFeQ/yOi6+PQv8MpaOeJwm/tQEm1NkRoFru8VqBNte3sV
   mDmTkxbzot+KqfPqBl2ovUnfOQtVCt2HEq2TOTrZC5UFqfSKF8XuNAt00
   YQHDzWtfnPpQHf5ShMWOo6tr9LXwDou9/T0OLqaTC45+RZjh60xrihX7p
   495kzRoZE9LNiPNzXQk5fvMqVxEEEjT9iOLem2p0f8ihQLDeFFP1G0Sj6
   md1e1HApEkMrATs2Apwk0zm7m6qBCJbVUIjCOFcu62J36cFe5gvvLmBG8
   fKgH6YUaDjogubu8NNLE0MlW/JP2PJuy4KZ/MnVk3TOW4lD35nYMvMEtD
   Q==;
X-CSE-ConnectionGUID: a2U8nMMoT4erEV1J7dttAA==
X-CSE-MsgGUID: q3jutD6CRb+D3OGVhPsX5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934540"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934540"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:11 -0700
X-CSE-ConnectionGUID: vbbQ2Q4FT2yD+eWOXpNK+g==
X-CSE-MsgGUID: ZatQtDjqRRqcsokRUtAiTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266719"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1C738ACF; Thu, 24 Oct 2024 22:12:02 +0300 (EEST)
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
Subject: [PATCH v3 22/24] iio: light: ltr501: Drop most likely fake ACPI IDs
Date: Thu, 24 Oct 2024 22:05:11 +0300
Message-ID: <20241024191200.229894-23-andriy.shevchenko@linux.intel.com>
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

The commits in question do not proove that ACPI IDs exist.
Quite likely it was a cargo cult addition while doing that
for DT-based enumeration. Drop most likely fake ACPI IDs.

The to be removed IDs has been checked against the following resources:
1) DuckDuckGo
2) Google
3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
This gives no useful results in regard to DSDT, moreover, the official
vendor ID in the registry for Lite-On is LCI.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8c516ede9116..3fff5d58ba3c 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1610,8 +1610,6 @@ static int ltr501_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
-	{ "LTER0501", ltr501 },
-	{ "LTER0559", ltr559 },
 	{ "LTER0301", ltr301 },
 	{ },
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


