Return-Path: <linux-iio+bounces-11227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F192E9AF26A
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC421C25FC3
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8178E3DABF6;
	Thu, 24 Oct 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge+bvsQk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87821BAFF;
	Thu, 24 Oct 2024 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797136; cv=none; b=Oz01LxjP8jTU022+qUS4UKPRldN5vLe5e1ER9K5WMmXQZp09DjcFC2OVoVawZVw5IH4dW5ul5TzzqOjh5e+4gl4oVPy3Xaa83IPsZRRgMOKdsc01IoqKLllP7I4O/0D9z+6disZD2ue2z+IeCFB6cyt/ZRLHBRIud4wdAGVZbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797136; c=relaxed/simple;
	bh=AWgXQc8EDdykL8LmbZfim+vs8EntyMpDtukZzMtpKUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8SYKMoNEu+qKXCRBO7X+6UZ2M2HFY05I66xFDd/QCVmQXu0FB8Ttq722jd0684Isx52tm8r80Trpqx2fgq6Sqgjm6/Ip39lZczfunQs+Byv/ONnPyKrQdgx3tm6fcjFqMEMTa185g3Dcf10m2GTpTANkxzSFHkQ27q+nwXl+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge+bvsQk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797134; x=1761333134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AWgXQc8EDdykL8LmbZfim+vs8EntyMpDtukZzMtpKUs=;
  b=ge+bvsQklTFhf3j/FSRFabSF3GeT407JnPdLLjDFtDTFfKkBdhHV/Uxu
   DeJ55l56NkW6qyZmxjpGFpbEEwzgGLRcSKL3yjLgtJcYo7HIf0rL3V58M
   CUkHDr4YZ51MJxVIPBT9qhpOSezxCtYKreQpmmGgTlBuiBhSoTXgtZcLn
   w6IcUvPDGsIeBHYMg2x70jQJu/S9BZNFWgdIVjZve+rEBSRQ2ur4uZhf6
   jYVVz1fGTm2QedWE7ugm4kjBohCoj9Pg0d1iXgqmjStWFw0/d6FqNssj6
   NthP11V5F27NNjs/rqKzCPWYYqyCRTY+4LczfUyoGfKMJbtquuW8AHUFV
   g==;
X-CSE-ConnectionGUID: D8HBJ4fnRTWK5DhhbpTjHQ==
X-CSE-MsgGUID: W2iP/38OSWy/R8BWT9QtgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934465"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934465"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:08 -0700
X-CSE-ConnectionGUID: oFXVPg6NTP6TTs+xF3sKtg==
X-CSE-MsgGUID: HC5mXl3uRXGZKHyJH5zRkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266684"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 92294644; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
Subject: [PATCH v3 10/24] iio: accel: kxcjk-1013: Rename kxcjk1013_info
Date: Thu, 24 Oct 2024 22:04:59 +0300
Message-ID: <20241024191200.229894-11-andriy.shevchenko@linux.intel.com>
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

Rename kxcjk1013_info to kxcjk1013_iio_info in preparatory of
further cleaning up changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a5411d920025..f97bdbbe71ed 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1211,7 +1211,7 @@ static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
 	.postdisable		= kxcjk1013_buffer_postdisable,
 };
 
-static const struct iio_info kxcjk1013_info = {
+static const struct iio_info kxcjk1013_iio_info = {
 	.attrs			= &kxcjk1013_attrs_group,
 	.read_raw		= kxcjk1013_read_raw,
 	.write_raw		= kxcjk1013_write_raw,
@@ -1533,7 +1533,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &kxcjk1013_info;
+	indio_dev->info = &kxcjk1013_iio_info;
 
 	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
-- 
2.43.0.rc1.1336.g36b5255a03ac


