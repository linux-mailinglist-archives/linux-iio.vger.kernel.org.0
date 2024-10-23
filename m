Return-Path: <linux-iio+bounces-10998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568009ACE8F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9671F24001
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C121CB326;
	Wed, 23 Oct 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BS++zzW8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3501C9DF0;
	Wed, 23 Oct 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696923; cv=none; b=aSYFzsu0KDzcMevGOwomek+E9py56yvXas8Uz26iFfjZ7cVzLwTYmJseZvJgRyUIenqmsr751jgb98PejTWUy/yHA9ROQhgW9vvdWCYDX0+Sl0eEe6gV/dvgQwSCFdlr2zaTSgxEtbwJFwOKjtIGLTYRLttzH6G2SW5nnaie69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696923; c=relaxed/simple;
	bh=g7gsiFyTFv7Za8SX5zX0SA6kCD+jSDqqfZf5G6BIMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjlOTgwUpJ3+2LR6+y7rjdz+wrKhHjx2ra/mZ0qENGbsm/j9k35yVNuQOmBY9cv/6EW2eMA4RiBEWVz2qycPnAqg6LkiRBdb05wZa772VUZUO7E8Sp2+ddzBYhaUsWd6YU/yNY/sf80D24OhIYQVatUMk5CuFw/WIneAl/Ke4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BS++zzW8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696922; x=1761232922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7gsiFyTFv7Za8SX5zX0SA6kCD+jSDqqfZf5G6BIMHs=;
  b=BS++zzW8wXZrTk4liatzV9z+cPhzeAMEd58tFKW6oCQ4qbH5BCW6KbJr
   1uUnczlT/XTtn8j8e2sQJxO3UsM3gC5dkoUr8UPbTcMvSH0FSyugqulKb
   4q1amfsu9jHsgbgn0tGVBJk2NFYSBvUcvpza7UH2fae6Am6nt3wapQO5p
   7THgS54x0BiGhPIgnBLfglAicYgZauehSCoJlUxh4IqzwG1aqMOY/SIjE
   6kmwlT1pT29xfiPmgTJuSZB21r03SsrlnLW/7t19VlKAIlRiWES5IsxJw
   ffc1cPBYTYZntlLkwOa34RrTsRHb2XfZPAfhx9u61AstLhy7/Cfv7r/fW
   Q==;
X-CSE-ConnectionGUID: ISX+A/DBQfO2mFiKfZwPqg==
X-CSE-MsgGUID: vUGb0bIuQFmRPuNOAjX/kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29449182"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29449182"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:58 -0700
X-CSE-ConnectionGUID: heKXpq+4SrKLCZ8arLsIew==
X-CSE-MsgGUID: u0EPhikiT26+dIhLeRmBZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80179592"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 23 Oct 2024 08:21:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A64BB331; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
Subject: [PATCH v1 02/13] iio: adc: pac1934: Replace strange way of checking type of enumeration
Date: Wed, 23 Oct 2024 18:17:25 +0300
Message-ID: <20241023152145.3564943-3-andriy.shevchenko@linux.intel.com>
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

When device is enumerated via ACPI the respective device node is of
ACPI device type. Use that to check for ACPI enumeration, rather than
calling for full match which is O(n) vs. O(1) for the regular check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/pac1934.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 7ef249d83286..20802b7f49ea 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1507,7 +1507,7 @@ static int pac1934_probe(struct i2c_client *client)
 		indio_dev->name = pac1934_chip_config[ret].name;
 	}
 
-	if (acpi_match_device(dev->driver->acpi_match_table, dev))
+	if (is_acpi_device_node(dev_fwnode(dev)))
 		ret = pac1934_acpi_parse_channel_config(client, info);
 	else
 		/*
-- 
2.43.0.rc1.1336.g36b5255a03ac


