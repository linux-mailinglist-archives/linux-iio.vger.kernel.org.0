Return-Path: <linux-iio+bounces-11102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545389AE584
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064331F239E5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329741D514C;
	Thu, 24 Oct 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/op8nph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940114A0AA;
	Thu, 24 Oct 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775071; cv=none; b=Z0HznUnKke7L6eLwiWncbNWs8FhO0mOJZm6F6I+UUFBhE+rmuHRMe6M2JIdfKCYBSC7nPyAOY7sb9LPLQwUS87S4orb1MhHNqscaK/VBi12SxQQw8Gfr8/8axhbVR4YmO7Q+oXU+07pvMWejH5/z5iLbbyGIvam8dtJb5+b1L8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775071; c=relaxed/simple;
	bh=RXqBs1ZDcv8ZDhVWYR7M44eyFiTQlcvJ6ELtyY0S4yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ7/qngB/pAqaclgQgknKs3/JyUNe8rYxSN0yAYvD9HjLLLa8LDckuFZJYApIc2e3NsUANurSbTVyAq8UdvxefY+CJgjl/3LpVFYzqv9HHrwhQ48kXqVQqBuhD2JVqavrKRhyDn6+PeHAk0WzPsLFvSqeDBOroD6EvFw/R1h/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/op8nph; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775069; x=1761311069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXqBs1ZDcv8ZDhVWYR7M44eyFiTQlcvJ6ELtyY0S4yI=;
  b=l/op8nphGCO3ymlKr/IWKADHcFtDaZpGzdJape6CG9XTOR8V4pVGK6X5
   Ax6NGdfh6T3o85weJ6FJ/wmO6xNbnwZPHyvofXEnQehjPUoWM5ZNs0VpH
   4h4JMr8IsiDIhi8sT4CgH+e6OniZ5P9MK+jK4TTnOKqxUJZaBlQC09o0L
   wK19xfmOwTXEp+EGhGy5pIrE+hdAdKJUwg9lLUbijtvXOpH9TUdjq8Li3
   PTPzY29HuVNuzp7TIsfjdeXYBlWsvP0Ap29YI2HBQU9S0XSJUqD2ykTPa
   CegsgC4Yy+kFrbo6PByvHhf+dqu4JF1RYdEy+W+FE2x6sKfyESVuely0q
   w==;
X-CSE-ConnectionGUID: HMmTbkokTzqmcMoSgwzhzg==
X-CSE-MsgGUID: jLgiDtw4RHWq1x2ryauCag==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40795211"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40795211"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:28 -0700
X-CSE-ConnectionGUID: HtrfL2T/T/ulFparics6ZQ==
X-CSE-MsgGUID: ZU0T93xIQEeDAcvXWIu/2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="103898624"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 24 Oct 2024 06:04:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CDB7A41D; Thu, 24 Oct 2024 16:04:24 +0300 (EEST)
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
Subject: [PATCH v2 02/13] iio: adc: pac1934: Replace strange way of checking type of enumeration
Date: Thu, 24 Oct 2024 15:36:07 +0300
Message-ID: <20241024130424.3818291-3-andriy.shevchenko@linux.intel.com>
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

When device is enumerated via ACPI the respective device node is of
ACPI device type. Use that to check for ACPI enumeration, rather than
calling for full match which is O(n) vs. O(1) for the regular check.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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


