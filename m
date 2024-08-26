Return-Path: <linux-iio+bounces-8817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C498F95FB96
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 23:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD641F22368
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280D19ADAC;
	Mon, 26 Aug 2024 21:23:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A52199242
	for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707430; cv=none; b=aqQBzv1LTLq5usDVghlbDdRU38A8s++GY4cUeq74HMFFYEXK5Q52LNktjJEWZkchYUPOePCvHuJpDAhQcta+yRQ0iaUnJ8xPkGQqdMDt7Z4WmT/6j3R/kDpyPLDE+gJqiBHZJ/JeJhTzSaW9VSejbX/DgkA6rxbueEFO1fD29uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707430; c=relaxed/simple;
	bh=8jEIzp8M2NzJT78cB0VUuBQOotiLpFGx13bHnhY1gvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoVjJMKIN1ohBrbyOn8lW1Rb0uvvGknrBgUklbQ/tZW5EOY+AuQrON1pEbc4Dc3kEC3XNdQt14CL4Mzdw+/QfYKSYq3hwcHkAZCqwQfKBJTbYrmTtH5Os3mXGrqtqyKy9gnYFSpJliI+/CQjsTMOB6JFjqVGt9hEsHpBnHDNXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 7a19f78f-63f1-11ef-823f-005056bdfda7;
	Tue, 27 Aug 2024 00:23:45 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/2] iio: imu: st_lsm6dsx: Use iio_read_acpi_mount_matrix() helper
Date: Tue, 27 Aug 2024 00:22:39 +0300
Message-ID: <20240826212344.866928-2-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826212344.866928-1-andy.shevchenko@gmail.com>
References: <20240826212344.866928-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the duplicate ACPI "ROTM" data parsing code with the new
shared iio_read_acpi_mount_matrix() helper.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 +-------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 937ff9c5a74c..722b43f9203b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2646,73 +2646,6 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-
-static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
-					 struct iio_mount_matrix *orientation)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	union acpi_object *obj, *elements;
-	acpi_status status;
-	int i, j, val[3];
-	char *str;
-
-	if (!has_acpi_companion(dev))
-		return -EINVAL;
-
-	if (!acpi_has_method(adev->handle, "ROTM"))
-		return -EINVAL;
-
-	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
-		return -EINVAL;
-	}
-
-	obj = buffer.pointer;
-	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
-		goto unknown_format;
-
-	elements = obj->package.elements;
-	for (i = 0; i < 3; i++) {
-		if (elements[i].type != ACPI_TYPE_STRING)
-			goto unknown_format;
-
-		str = elements[i].string.pointer;
-		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
-			goto unknown_format;
-
-		for (j = 0; j < 3; j++) {
-			switch (val[j]) {
-			case -1: str = "-1"; break;
-			case 0:  str = "0";  break;
-			case 1:  str = "1";  break;
-			default: goto unknown_format;
-			}
-			orientation->rotation[i * 3 + j] = str;
-		}
-	}
-
-	kfree(buffer.pointer);
-	return 0;
-
-unknown_format:
-	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
-	kfree(buffer.pointer);
-	return -EINVAL;
-}
-
-#else
-
-static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
-					  struct iio_mount_matrix *orientation)
-{
-	return -EOPNOTSUPP;
-}
-
-#endif
-
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
@@ -2787,8 +2720,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
-	err = lsm6dsx_get_acpi_mount_matrix(hw->dev, &hw->orientation);
-	if (err) {
+	if (!iio_read_acpi_mount_matrix(hw->dev, &hw->orientation, "ROTM")) {
 		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
 		if (err)
 			return err;
-- 
2.46.0


