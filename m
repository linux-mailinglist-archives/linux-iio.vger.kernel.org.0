Return-Path: <linux-iio+bounces-11114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA609AE5A0
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C017F1C22173
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF8E1E3DC4;
	Thu, 24 Oct 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="da8zLoxq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347E1E1A18;
	Thu, 24 Oct 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775088; cv=none; b=Yl26ngWtDdueeeuyMWixpTF/eKqCBFbC4Luc97EdaNKce39Uw+Eop4ZisA1+u09wJyhn0v0VKyizx3VmbBk1voCG6a81sg1zF8cQOBSWTBeYdxZCWSw7YD4P8YMq5eMsUc0IrfOFwVpeUc4X5JL/ktDc9mLzcja9fIs2IZzi6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775088; c=relaxed/simple;
	bh=fvNel6p61T3jK3xq1Ew/lp5LBDNzFIYblZQCIwx3ZuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrWTCPG2EFdIIsspQ+8kwkv2rOYKXAvcglP4a2W+oHlIi6LdG+u586hYz/lp0YJXALL+3Qjy+6yeV4se3ZCG1jvDPL/dy+tHnd5o9Di8MZ67Y9SuBLK++quXdST+n1NQVycTclUiVfXnqrncWLeODszYhef1K6TyH3vQ43sL7W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=da8zLoxq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775087; x=1761311087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvNel6p61T3jK3xq1Ew/lp5LBDNzFIYblZQCIwx3ZuI=;
  b=da8zLoxqKpLAtPHDG8ierjbUJ5EgH6YGMVIf5ACxGAjIGfh+DBevFnRL
   KXJBPu0pT4n3JKUN8m8nnXMR7fVFFJrOnOQ2YgMPb6Wab5Jw8fV0pVPOz
   Jgjr76O8Y/8Q1j7ou+pOe1W7yG5vMAhBWSlm4MYX+nzyTbxdwKDsTRkpB
   4qxigUZk2EWs6xAqiVo54F+il0wrJMeJoWMniPk0ZYUpwvOhPu9DLzMsE
   8NuC8+5RaS3nxiTaYa3vM5CwNqdeQNwSkSnkmrpkhoOG0iRjURlVnZyJN
   TOX6imUQXXKFgLptiWaopUz77SIfTak/K3CyjViT/yqnLJSHVuWxuMXfq
   w==;
X-CSE-ConnectionGUID: JnyUe+d2SLChvobgTXxBaw==
X-CSE-MsgGUID: TaDAQqZyTlCw2CdEht01zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802832"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802832"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:32 -0700
X-CSE-ConnectionGUID: v4K9xq7jQm62svSFktsecw==
X-CSE-MsgGUID: Uy8RVuK6R/CKackwGFt8Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238792"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3FA407B8; Thu, 24 Oct 2024 16:04:25 +0300 (EEST)
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
Subject: [PATCH v2 12/13] iio: light: ltr501: Add LTER0303 to the supported devices
Date: Thu, 24 Oct 2024 15:36:17 +0300
Message-ID: <20241024130424.3818291-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
References: <20241024130424.3818291-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been found that the (non-vendor issued) ACPI ID for Lite-On
LTR303 is present in Microsoft catalog. Add it to the list of the
supported devices.

Link: https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303
Closes: https://lore.kernel.org/r/9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com
Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 3fff5d58ba3c..4051d0d9e799 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1611,6 +1611,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
 	{ "LTER0301", ltr301 },
+	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
+	{ "LTER0303", ltr303 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
-- 
2.43.0.rc1.1336.g36b5255a03ac


