Return-Path: <linux-iio+bounces-4513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAE8B2212
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2D1F2454F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D211494C8;
	Thu, 25 Apr 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4oiu88o"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7B139D16
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049890; cv=none; b=e4ALe0CB+Ozuz9kE+wI6K3uoKLUjSDU058LbHQbTUXqP8YzQfa0lMld0ZMLqci8mbzBElQAXHgiQ14KC8tQBW7an/wK7kYMRpcA9IGtF0lu03xERndnWP3mhcXqkVs0SfHwO4TYDDC4aTPZ6ybsFkb7bowtt6+0ljQB4oHavOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049890; c=relaxed/simple;
	bh=1WBPjbGLvmJNIu33C15B+uif+mRsWr8Ak3MJWbo4RwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzaJgx0gywX6ipSR5Onwt0HhOh1Btv3a4Bk6zKqjuYy1FjZ2ujBkBgiFENgES6+tWGaWNQr+i9YQMUdkOR2Y4m0DXJmv0gV7isFaqzPr6XpTyLJavX8ql/1XjqD5fjUSopeCDCWEgNajkLHQBnbvSpUfPbYGOYYU3ucoPhKFq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4oiu88o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714049888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nukKDBBUazm2QcoRnZo+cWlrKd5NGv+hTxdZ+Dqdko=;
	b=a4oiu88oReZ2Yw2o3vcRCqjQuL7mIJWZC+PtYp59hD8g3gHMLxkJrC4lXeRgHEkh1mxySc
	cFZRhdl//J+Z5UmUoVKxtQYWINkpfh/SsJ2SxF9G4qWF/8B18AgaB8CwqjmJOqJTAsLiz+
	0RyKA30rRYhASyTV/1VJ6aE4AC2Wy7I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-vdtTNWcTNYy5p-UjFUXUPQ-1; Thu,
 25 Apr 2024 08:58:03 -0400
X-MC-Unique: vdtTNWcTNYy5p-UjFUXUPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4888F1C0C650;
	Thu, 25 Apr 2024 12:58:03 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CFABC1121313;
	Thu, 25 Apr 2024 12:58:01 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 3/4] iio: bmc150-accel-core: Use iio_read_acpi_mount_matrix() helper
Date: Thu, 25 Apr 2024 14:57:53 +0200
Message-ID: <20240425125754.76010-4-hdegoede@redhat.com>
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

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 44 ++-------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 110591804b4c..ae0cd48a3e29 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -386,13 +386,9 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 						   struct iio_mount_matrix *orientation)
 {
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	char *name, *alt_name, *label, *str;
-	union acpi_object *obj, *elements;
-	acpi_status status;
-	int i, j, val[3];
+	char *name, *alt_name, *label;
 
 	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0) {
 		alt_name = "ROMK";
@@ -411,43 +407,7 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 		return false;
 	}
 
-	status = acpi_evaluate_object(adev->handle, name, NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
-		return false;
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
-	return true;
-
-unknown_format:
-	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
-	kfree(buffer.pointer);
-	return false;
+	return iio_read_acpi_mount_matrix(dev, orientation, name);
 }
 
 static bool bmc150_apply_dual250e_acpi_orientation(struct device *dev,
-- 
2.44.0


