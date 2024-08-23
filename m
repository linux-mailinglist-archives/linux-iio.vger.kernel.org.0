Return-Path: <linux-iio+bounces-8742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9F995D972
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 01:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E0C1F23C48
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22C1C9452;
	Fri, 23 Aug 2024 23:01:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D595695
	for <linux-iio@vger.kernel.org>; Fri, 23 Aug 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454074; cv=none; b=CuLf/48bIwlhEuUeFBrzg1Z4/di/StbThxKO/6gXH0bwZWMjNa2MBoUXfLTNA0hmDpiRUC3RzwOkYu8jHaBE86S0KYt4fVp7dKXFDlA7z6t3uJoOo3vOdn/FLel7G8BQ3fU4U2BxOyDoNCxoQGI8CSqA8kWCXvokcjWDSflWg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454074; c=relaxed/simple;
	bh=yJaFCLUseZJ+UMqQU3DIqu/jfdw1TQ24lhPHFYbZllc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwWGM/FBzxjJ3E9KDKa7uTABCxDFSPIz7r+cL17ie9CYxaRliBmHj280nlVyne2PaGAlREt+QuEbzCY5Zh36yNMdad+7RbEG1uAAFF1V18eEWrusB5heBRWEttATvmJ4lFt1FDb6OOwJXC5Zp1KCDWAy2CXzof9fGQMzN0zfb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 9661658c-61a3-11ef-8e42-005056bd6ce9;
	Sat, 24 Aug 2024 02:01:10 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: accel: bmc150: Improve bmc150_apply_bosc0200_acpi_orientation()
Date: Sat, 24 Aug 2024 02:01:07 +0300
Message-ID: <20240823230107.745900-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By using ACPI_HANDLE() the handler argument can be retrieved directly.
Replace ACPI_COMPANION() + dereference with ACPI_HANDLE().

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 14ce03c70ab5..0f32c1e92b4d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -387,7 +387,7 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 						   struct iio_mount_matrix *orientation)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_handle handle = ACPI_HANDLE(dev);
 	char *name, *alt_name, *label;
 
 	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0) {
@@ -398,9 +398,9 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 		label = "accel-display";
 	}
 
-	if (acpi_has_method(adev->handle, "ROTM")) {
+	if (acpi_has_method(handle, "ROTM")) {
 		name = "ROTM";
-	} else if (acpi_has_method(adev->handle, alt_name)) {
+	} else if (acpi_has_method(handle, alt_name)) {
 		name = alt_name;
 		indio_dev->label = label;
 	} else {
-- 
2.46.0


