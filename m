Return-Path: <linux-iio+bounces-4512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C2A8B2211
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C5A1F24536
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8791494D2;
	Thu, 25 Apr 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvp8mBO2"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE9139D16
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049886; cv=none; b=aTpzQQx0NvXZTD8xQUUH+Tu0rPEcLsSvTTdnCvs+rq0Lo9IZvPz5RkX6XGiMX7nJoxYzFXLUjTSRFNjwDVk22csmvV1iMuWDCtomIUtXXHiICGOFpxrIRMuaDsBb4XL+v44jAq0nLvRk6vvBrTtRGT4KN1sbyRQxgjIPW9mdUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049886; c=relaxed/simple;
	bh=hQ0NrzsX9/kk5VFdPfk5G9sYfHImsCuMQ51hP4lxBAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q32FFIMryDMiokYz3l+ID/KodU6DYZdWpiPf7u894Q6FL14DGbJwke5Ju9I9onV3BVBUTAqxynl1tL1m+gjUUflbh81ZRqkFDVOGJd1YjGv5KWhu6qw8k9a1Tja1wde2j9bOM5RHkb6Vw3zSKb4vfL6uZExB1LCUWNOFsqU4hBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvp8mBO2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714049883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lBEfAmHU7v07hZr4ZrX7ZQDP9lEIce3vtDE9yrQqS8=;
	b=gvp8mBO2RNjnlTEBCRr7ckmmegbI0X+BHirYW3C+4OAxw13IjKWOIKTfE7FGq5E9F20M3J
	JaDX9r1cXkXa8qhCHAhZanxf7oIQwccAxZv2cEVUt9Ktk6Ue9BYaJCxv4DYQeSIbIlWqAl
	Ibxua8PbfFZdyQn4X5ILGofEBFY9NWo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-0QsfWPUaPyCMs3eVVxM3Kw-1; Thu,
 25 Apr 2024 08:58:01 -0400
X-MC-Unique: 0QsfWPUaPyCMs3eVVxM3Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F2BE3C025B0;
	Thu, 25 Apr 2024 12:58:01 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0E41121306;
	Thu, 25 Apr 2024 12:57:59 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 2/4] iio: accel: kxcjk-1013: Use new iio_read_acpi_mount_matrix() helper
Date: Thu, 25 Apr 2024 14:57:52 +0200
Message-ID: <20240425125754.76010-3-hdegoede@redhat.com>
In-Reply-To: <20240425125754.76010-1-hdegoede@redhat.com>
References: <20240425125754.76010-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Replace the duplicate ACPI "ROTM" data parsing code with the new
shared iio_read_acpi_mount_matrix() helper.

This also removes the limiting of the "ROTM" mount matrix to only ACPI
devices with an ACPI HID (Hardware-ID) of "KIOX000A". If kxcjk-1013 ACPI
devices with another HID have a ROTM method that should still be parsed
and if the method is not there then iio_read_acpi_mount_matrix() will
fail silently.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 80 +---------------------------------
 1 file changed, 1 insertion(+), 79 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 126e8bdd6d0e..8280d2bef0a3 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -636,84 +636,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool kxj_acpi_orientation(struct device *dev,
-				 struct iio_mount_matrix *orientation)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	char *str;
-	union acpi_object *obj, *elements;
-	acpi_status status;
-	int i, j, val[3];
-	bool ret = false;
-
-	if (!acpi_has_method(adev->handle, "ROTM"))
-		return false;
-
-	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
-		return false;
-	}
-
-	obj = buffer.pointer;
-	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
-		dev_err(dev, "Unknown ACPI mount matrix package format\n");
-		goto out_free_buffer;
-	}
-
-	elements = obj->package.elements;
-	for (i = 0; i < 3; i++) {
-		if (elements[i].type != ACPI_TYPE_STRING) {
-			dev_err(dev, "Unknown ACPI mount matrix element format\n");
-			goto out_free_buffer;
-		}
-
-		str = elements[i].string.pointer;
-		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
-			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
-			goto out_free_buffer;
-		}
-
-		for (j = 0; j < 3; j++) {
-			switch (val[j]) {
-			case -1: str = "-1"; break;
-			case 0:  str = "0";  break;
-			case 1:  str = "1";  break;
-			default:
-				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
-				goto out_free_buffer;
-			}
-			orientation->rotation[i * 3 + j] = str;
-		}
-	}
-
-	ret = true;
-
-out_free_buffer:
-	kfree(buffer.pointer);
-	return ret;
-}
-
-static bool kxj1009_apply_acpi_orientation(struct device *dev,
-					  struct iio_mount_matrix *orientation)
-{
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-
-	if (adev && acpi_dev_hid_uid_match(adev, "KIOX000A", NULL))
-		return kxj_acpi_orientation(dev, orientation);
-
-	return false;
-}
-#else
-static bool kxj1009_apply_acpi_orientation(struct device *dev,
-					  struct iio_mount_matrix *orientation)
-{
-	return false;
-}
-#endif
-
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
 	int ret;
@@ -1544,7 +1466,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	} else {
 		data->active_high_intr = true; /* default polarity */
 
-		if (!kxj1009_apply_acpi_orientation(&client->dev, &data->orientation)) {
+		if (!iio_read_acpi_mount_matrix(&client->dev, &data->orientation, "ROTM")) {
 			ret = iio_read_mount_matrix(&client->dev, &data->orientation);
 			if (ret)
 				return ret;
-- 
2.44.0


