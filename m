Return-Path: <linux-iio+bounces-11216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325C29AF253
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABF328950D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EBB219CA1;
	Thu, 24 Oct 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aR01xi6P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603662170D5;
	Thu, 24 Oct 2024 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729797130; cv=none; b=SW4hmDA/zfU54MiXJ2Jb5+8jjU/02/gubiYjivdv8VpQwuYBsYEx042ynj/aeGG6Wnl/WAEEJNMHo/a0Lq3PgSq41g0N20WJXRIxK1U4i6Uqln9BWk8z5+S8DSIW76bCHsVLGOvyyUPr2UeXQf2mN9DwHkpsvW1dYI1rf79Fjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729797130; c=relaxed/simple;
	bh=2NpSf0hOT+YNC2NtcTsGYEN7hUnqCBnO3iQXTMJmrUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr+76NGubLoTkLxQBiqrPCq6aEUvCphLYyMU9cd5g2EjUxRjbNpl2Q+R/6mxnNrAj5yRTvbzlkCJ+h+eO+zFB1lskABf4XadqMObpKbrlgCAqG+46+ib2pVrhGhXh0/XdztrqCFueL/Yk+T0Y8OWyZ8pwYL7MZTUDKVVolaA4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aR01xi6P; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729797128; x=1761333128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2NpSf0hOT+YNC2NtcTsGYEN7hUnqCBnO3iQXTMJmrUQ=;
  b=aR01xi6PiEgkPmS/NP5qyblm1JMCia88rD67zDAMnE51ABhXD1a8m7qc
   SNdPL0N/y+NcXyzRPlTfsveP8z4EyjhG3X3Jb6NjF5D56k+0XoNvUVGvx
   CNqG2lA451HqFoR2UfxqAKy5l7lwUy4s3e/l+jUaV7vQuL2jPWrzKr9qa
   HhXhqTpaJEnIRKUbqt/XCtPqcu8XCV96XswT89AyNhbEAjaYcZOSHS09C
   NPmVpi6G+bTFP5O7/3rdz5+SUt46zBDykd5RIDMHkcckAoa01wXIeiFon
   6XIFH/fyrG7GcWooOewcDIVFL/fo2IZ0JAS3HbbSjDlXIzC23MFK6gtkM
   A==;
X-CSE-ConnectionGUID: A3bhE4yBQsKhwjXDXzt66Q==
X-CSE-MsgGUID: 03IoktG6TJmCcsGT7byOWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46934407"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="46934407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 12:12:05 -0700
X-CSE-ConnectionGUID: 9Lvooc3KQpmN6pvlR8lgxg==
X-CSE-MsgGUID: u14i1OLMR6OK5ehArj3vuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="80266646"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 12:12:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 37D6C2E9; Thu, 24 Oct 2024 22:12:01 +0300 (EEST)
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
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 04/24] iio: acpi: Improve iio_read_acpi_mount_matrix()
Date: Thu, 24 Oct 2024 22:04:53 +0300
Message-ID: <20241024191200.229894-5-andriy.shevchenko@linux.intel.com>
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

From: Andy Shevchenko <andy.shevchenko@gmail.com>

By using ACPI_HANDLE() the handler argument can be retrieved directly.
Replace ACPI_COMPANION() + dereference with ACPI_HANDLE().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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


