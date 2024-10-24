Return-Path: <linux-iio+bounces-11214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4A9AF24F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009C51C24D10
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150321948F;
	Thu, 24 Oct 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbe5QhkI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F12178F3;
	Thu, 24 Oct 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797129; cv=none; b=rbvzkJ34s3ooG4Mz/cbcxnpkXL9hWItIY0ir8b4L9kxa9RgiYtdQo69fedmKBTvtqbQe/edi/lBv/uI8Ftzb59ya+19Xd5Q/k+WyPZnrrVpzosNo5Gb09wfunyuPA579XypUsjPbRxEHV7B25W77tWWqwNk/y2qOEfy/1kK239o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797129; c=relaxed/simple;
	bh=FJZD8ym3u/Af6dcoDZY1FR7xEzBmn/SkkJlcKEIdmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJMX0mSVXDBPn+rYIpAFU/HxOZ+YBzwFCCFQ8k43haqKdkXiyrqWuxCpRjD2ciChgY9yoD1g/p7PkJBr9uTYm2mudUvEth7QD6EewT3JqdpI2mg7gGjVrt5VMf0hvRdRveZJu/pl4xpbbk71XuiLsWvJTVRaoVnZHr0I1+E+I0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbe5QhkI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797128; x=1761333128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJZD8ym3u/Af6dcoDZY1FR7xEzBmn/SkkJlcKEIdmqI=;
  b=gbe5QhkI/iBVzUwUPUMyYFc/wNLKSnqoEIxsIfIOhVbentbme6KQ5fpB
   foOoC5ZKYrzuPMPOuqvbOv1BLM9MH5JeBbDZFpCFQWbq3CQIcQjNEj4o7
   l0w5FQvFPp7tExVGioVzNzz2ER9hI1dqHaYbRPKzNPyNxDuITJCZMZKzf
   bbyezv44W2ReO821oFII1bJoIaByp0HJkMQYcT/HV4Z1vwWAb2Fez6V/C
   +cB8X9X1TpswqxntU36z6VO6eUHwK4d2oD01wZX0Rty/+BTCpxMfA/zD/
   DltnR6oJxzKjjT+9RwFEFoWM4WFh6vCSbq/Il7HkMYnhqeiig2LEGxTBX
   A==;
X-CSE-ConnectionGUID: mJdGolgdTz+aADUDv9dAsA==
X-CSE-MsgGUID: llkOnS4tQqSfWb3GxQzsIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934391"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934391"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:04 -0700
X-CSE-ConnectionGUID: +FRckgYZScSFpy3jcaJhUA==
X-CSE-MsgGUID: ZdRK2zxET3+oxv24nkj0mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266647"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1DFCA331; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 02/24] iio: adc: pac1934: Replace strange way of checking type of enumeration
Date: Thu, 24 Oct 2024 22:04:51 +0300
Message-ID: <20241024191200.229894-3-andriy.shevchenko@linux.intel.com>
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

When device is enumerated via ACPI the respective device node is of
ACPI device type. Use that to check for ACPI enumeration, rather than
calling for full match which is O(n) vs. O(1) for the regular check.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Marius Cristea <marius.cristea@microchip.com>
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


