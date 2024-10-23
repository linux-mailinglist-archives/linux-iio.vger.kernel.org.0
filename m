Return-Path: <linux-iio+bounces-11005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45F99ACE9F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE5A1F24922
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD71A08C2;
	Wed, 23 Oct 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4hjJHxS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964411CCB21;
	Wed, 23 Oct 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696957; cv=none; b=V7ILh9p7Q6BqgHuD6RphT9JzdaqXadaQXGK2k/KmsOsBTdoXVv7FPfy9Z97WC9diETu0wSbYbL5JIGq8owuJMDWoYHJoFq8wccIPTCT6hSXDzTJ4A/lFs+Cw1WNy24yb7Yipg0kX0zmeEN6tu4JsR5/NVXJtyWDbNT5703mYj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696957; c=relaxed/simple;
	bh=NkIV1nzqb7imB9npMg2g1/t1SJVRLG/zDhOXrFCjnwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORVdMLx2oG9RGjyBBY6nvZ47bcp3DorqrMJMMe4BvjY/zSWAPNnW8OiTJU3hwMLi4xwXi5+WvzSIJYdqvyuV0ujlbh5lvX/lLIO30c/KztV6fpx9YSHZJYio/FfwJHnkIV5Gw6hxJLjdXdF5JkmHt/sszqsXxp5cX/rSyAI/m5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4hjJHxS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696956; x=1761232956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NkIV1nzqb7imB9npMg2g1/t1SJVRLG/zDhOXrFCjnwI=;
  b=S4hjJHxSXPPfPEl8hqAMlPNuuKthZAHgCkIDzUaSia1WqGy02zt7/tgT
   ivnqu2rBKl702DOZwZZm4R128aS4bxYhsp6bTJVeIGHwOyunIPjtZFnAe
   PDtcrhNQtf6+4mGS819ayo2rkb75YH6TS8sLP1cqQBitDoWoHSnsZCA1C
   MpBJvtPHyPbbWsRaFdXCkyFIjTLUJyQ0TwTd9Lcgz9ch0VfCElZqiJWC3
   ui4fv4XKhoT6qRKHQop52m5qfl8AsdSa8SlmJBhI35la/W8xwwlFiRzSs
   0HM353asUM0XnrLEPBiQlR06UgysLiagXL1laeqiiC7+/NAZKvi6aFEoM
   Q==;
X-CSE-ConnectionGUID: GHZRl8iESry4c6dDB51hgw==
X-CSE-MsgGUID: ap8sl8OQQUKPmk1NojNizA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39841516"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39841516"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:56 -0700
X-CSE-ConnectionGUID: 90RaMCh7QJycEu4yX+6o3w==
X-CSE-MsgGUID: s7YtVG3kT/OQSrVeRmRC9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80430826"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 08:21:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 347ED74C; Wed, 23 Oct 2024 18:21:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v1 12/13] iio: light: ltr501: Add LTER0303 to the supported devices
Date: Wed, 23 Oct 2024 18:17:35 +0300
Message-ID: <20241023152145.3564943-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
References: <20241023152145.3564943-1-andriy.shevchenko@linux.intel.com>
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


