Return-Path: <linux-iio+bounces-11110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB69AE598
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A35C2857A5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C141D8DFD;
	Thu, 24 Oct 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNO182yn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B57B1DD86F;
	Thu, 24 Oct 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775086; cv=none; b=mVhNrTRFmUvFPNTSOqspLuLl03csDmYpPu1IaUSYeRYeCtyKPQifTgR41cMqufkTBApz0Z21RwMsegw7r16GF3ZPj/KJTZU1uUN8FwbhoNBMjwBPectk8lepGBhxIrVRpU4ewaSWauEM2sZTh4S6JmgrkLRBMgCpz9u2RF7Ps7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775086; c=relaxed/simple;
	bh=2NpSf0hOT+YNC2NtcTsGYEN7hUnqCBnO3iQXTMJmrUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbB4SPhmZvQc7DuRWH7n9dHbiWEMt939PpbFswngO3/hGrUq2VKD4tn0ObbU/jgkfKraLNTuZdT6cth1vI7npyz/BCHTOP+SPoe6W37GG2xLRQHwUD5wpEt4X7cccuPpDbh8odwdrrqpZerigMdtmdqar/w6CF9RHLLURDPTJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNO182yn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729775085; x=1761311085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2NpSf0hOT+YNC2NtcTsGYEN7hUnqCBnO3iQXTMJmrUQ=;
  b=hNO182yntKojIiVdE8u3SHiNkvoit4M+ayMMXFAZZjLM126DHF2LMdVR
   JGms9DDr7Nt2jYgGIz0y3//ocmnn50HLwpjtAMPwXRjwVN6THG++0tZXb
   swRi+Aoq7+7CLfYpj6Qeu3DuBeK1ocpOqRxCtUUSJ3MSqcuiDaSJsTFB0
   xmATp4DOtcLOe+XY8F3yMuAB8Hx7FlHPTCRxTy2kZ7cvB1WjQ0wx/onVM
   9KT3IzJoKnPaoRdh6bsnw3EeYcfNcr117H7mynKtAdGvvz0hBPO8ugHbd
   tmlHQeCbYLB34JFoFBcQXE/eZ919x0q7JuyHPsean2UU+StYJJ3sOqiwp
   Q==;
X-CSE-ConnectionGUID: wf9wPQTfQMaoDUmG5tUBiA==
X-CSE-MsgGUID: RrF6gzsCT16nY9joZleaaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="54802797"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="54802797"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:04:28 -0700
X-CSE-ConnectionGUID: tM2rEMvxRwC7aDcKtoCdUg==
X-CSE-MsgGUID: gxV/AsKjQLO+szkePiU7jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80238762"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 24 Oct 2024 06:04:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DF2E14E3; Thu, 24 Oct 2024 16:04:24 +0300 (EEST)
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
Subject: [PATCH v2 04/13] iio: acpi: Improve iio_read_acpi_mount_matrix()
Date: Thu, 24 Oct 2024 15:36:09 +0300
Message-ID: <20241024130424.3818291-5-andriy.shevchenko@linux.intel.com>
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


