Return-Path: <linux-iio+bounces-11001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419799ACE97
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C151C2430E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A91C9EAF;
	Wed, 23 Oct 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVjDfeEy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B721C9B80;
	Wed, 23 Oct 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696954; cv=none; b=FlF4/YnyCtNc1jV5ZLRsE1ohljhl9CID70Zumyd+2rKTs786XDV/XG9Yk6x79vB+ykojs34VcjCIbQshiAyn2A8vFWM+NsoG7GKsLjYPcWvpPUsAOmebxctR3ofvGwLqv+V/x8w9y8/QV5jt/NbcvqdA59c/mtoQ+Ax85f6hVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696954; c=relaxed/simple;
	bh=RF5+mrIcKaB42Sfsuzez/O8IYdODrDQIqAH82hA23Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkwQp0zIMJYDDGhU6Jbqqe15f49hjSBILcAGEIdFI7GJw6aRDTisXRxcGeLrZFOJkPGhlK5fg5hCzd4krIeTqsmp52CPoqKr+G+LvtjVScK/krgjNmi4e9Mfs8S7fIGspF0Qu9hry5OUBcpOJH9ctaURT0Qb0PKfxqd5LsBTGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVjDfeEy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729696953; x=1761232953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RF5+mrIcKaB42Sfsuzez/O8IYdODrDQIqAH82hA23Qs=;
  b=fVjDfeEyam0rrkeevUa8GjTngFQtoFfw1jxNYSUpKiZFTxcxJYtbIGIM
   jLQUnvpzCbb07Bb83XTuS6uGWKLKvfuFiZcjTFyEEYcG+3QhGYwfc+UAy
   WKbU05n39OivwFtH488Pg0kpUtqHAhKRmtZq2gmS7Q4xJRpYaHe7Cm/9T
   I6KYZjp9DUrnK2mPlD7t+ZogW4KSRXRtJ64Z3Qd94xtMOoH1YqSXGVIEr
   3NkBVh6GADJcNnHQfCFcyUCRYFnlH0GfXxvxuMwGeEcT1ZqjHlDM6Xe1X
   nk8D8pDcuuCYkrc19Tj1fAzXdwIRTfBfmG9lH8EPIfH25/daT3I2BOsN9
   A==;
X-CSE-ConnectionGUID: /jA+W34HSY6hHwbm7mU8Ow==
X-CSE-MsgGUID: P7AXTL98SsGHdJklDkWtIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39841476"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39841476"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 08:21:53 -0700
X-CSE-ConnectionGUID: 3RcXvmPjRTCFSFJOLbrH5g==
X-CSE-MsgGUID: r61uQNu3QFClhbDcVRZpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80430764"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 08:21:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C129741D; Wed, 23 Oct 2024 18:21:48 +0300 (EEST)
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
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 04/13] iio: acpi: Improve iio_read_acpi_mount_matrix()
Date: Wed, 23 Oct 2024 18:17:27 +0300
Message-ID: <20241023152145.3564943-5-andriy.shevchenko@linux.intel.com>
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

From: Andy Shevchenko <andy.shevchenko@gmail.com>

By using ACPI_HANDLE() the handler argument can be retrieved directly.
Replace ACPI_COMPANION() + dereference with ACPI_HANDLE().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-acpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
index 981b75d40780..1e46908f9534 100644
--- a/drivers/iio/industrialio-acpi.c
+++ b/drivers/iio/industrialio-acpi.c
@@ -28,17 +28,21 @@ bool iio_read_acpi_mount_matrix(struct device *dev,
 				char *acpi_method)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	char *str;
 	union acpi_object *obj, *elements;
+	acpi_handle handle;
 	acpi_status status;
 	int i, j, val[3];
 	bool ret = false;
 
-	if (!adev || !acpi_has_method(adev->handle, acpi_method))
+	handle = ACPI_HANDLE(dev);
+	if (!handle)
 		return false;
 
-	status = acpi_evaluate_object(adev->handle, acpi_method, NULL, &buffer);
+	if (!acpi_has_method(handle, acpi_method))
+		return false;
+
+	status = acpi_evaluate_object(handle, acpi_method, NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
 		return false;
-- 
2.43.0.rc1.1336.g36b5255a03ac


