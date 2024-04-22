Return-Path: <linux-iio+bounces-4427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF48ACA2C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 12:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7401F22C1C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886A13B7A0;
	Mon, 22 Apr 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XohEoy2f"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D64317E
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713780154; cv=none; b=sE9fo0gVPHi/HWdfu/NqjGTFkEKykNYrsOItrUf9NZDWI6LYMhkLQdNOPKwM+RnoFihg0VbgLD6u37WkF5KaVYYPEy3/spD1AqhNBLbfCY6gmBd8Yk88RWA0SZ2XKV8/S8ZU1MqrXDbQtrz1fCyggx/pu4ka1wzAzEziWdBq01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713780154; c=relaxed/simple;
	bh=9kUyuMnjqgdNDwjPdjTqg1cwKvTHrScMKg9fPccBo6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1Ft0X4IEVk/5HRYCSLyc4UoCNsB3Vt4YPrqOpNswpH7mtxyvNjsNBLwoogREgcsq8h0LD8woQkfip5YV/2+idJ1Q2jW5+B8gPEf7ekKCOeYpnE1ViM3gcpAGkurXxj8PGa6dEnLbGvEigljtTvdL/vTmQptJjIL1aqN9LAWUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XohEoy2f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713780148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+XSlsyQMatYjAz3opgp+/gxGpa9C5+SxOH6wUV0pJE=;
	b=XohEoy2f2a340B1dPJyAJi9T4IaZe3AYRr346K409e5I/S/gYCIPmqj447e7m0edZbarwP
	cQjyjhyLb/97akDRViLLXyUpRBULLrpsR/Z5Je04ZsDSDBunIuGtwa+C6m6pnzwIpDTMg+
	CQ9M1Of110gLAuY9k+aANHE2q1HAHZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-KugJMuASMTGCrmfIBr1VQA-1; Mon, 22 Apr 2024 06:02:25 -0400
X-MC-Unique: KugJMuASMTGCrmfIBr1VQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07378812C5A;
	Mon, 22 Apr 2024 10:02:25 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.177])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C130A43FAD;
	Mon, 22 Apr 2024 10:02:23 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/4] iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new acpi-helpers.h
Date: Mon, 22 Apr 2024 12:02:16 +0200
Message-ID: <20240422100218.7693-3-hdegoede@redhat.com>
In-Reply-To: <20240422100218.7693-1-hdegoede@redhat.com>
References: <20240422100218.7693-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The ACPI "ROTM" rotation matrix parsing code atm is already duplicated
between bmc150-accel-core.c and kxcjk-1013.c and a third user of this is
coming.

Move the ROTM parsing from kxcjk-1013.c, which has slightly better error
logging (and otherwise is 100% identical), into a new acpi-helpers.h file
so that it can be shared.

Other then moving the code the only 2 other changes are:

1. Rename the function to acpi_read_mount_matrix() to make clear this
   is a generic ACPI mount matrix read function.
2. Add a "char *acpi_method" parameter since some bmc150 dual-accel setups
   (360° hinges with 1 accel in kbd/base + 1 in display half) declare both
   accels in a single ACPI device with 2 different method names for
   the 2 matrices.

Cc: Sean Rhodes <sean@starlabs.systems>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add comment about the Microsoft specification for the "ROTM" ACPI method
---
 drivers/iio/accel/acpi-helpers.h | 83 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/kxcjk-1013.c   | 71 ++-------------------------
 2 files changed, 86 insertions(+), 68 deletions(-)
 create mode 100644 drivers/iio/accel/acpi-helpers.h

diff --git a/drivers/iio/accel/acpi-helpers.h b/drivers/iio/accel/acpi-helpers.h
new file mode 100644
index 000000000000..fcdffed34785
--- /dev/null
+++ b/drivers/iio/accel/acpi-helpers.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* ACPI helper functions for parsing ACPI rotation matrices */
+
+#include <linux/acpi.h>
+#include <linux/dev_printk.h>
+#include <linux/iio/iio.h>
+#include <linux/sprintf.h>
+
+#ifdef CONFIG_ACPI
+/*
+ * Parse mount matrices defined in the ACPI "ROTM" format from:
+ * https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
+ * This is a Microsoft extension and not part of the official ACPI spec.
+ * The method name is configurable because some dual-accel setups define 2 mount
+ * matrices in a single ACPI device using separate "ROMK" and "ROMS" methods.
+ */
+static inline bool acpi_read_mount_matrix(struct device *dev,
+					  struct iio_mount_matrix *orientation,
+					  char *acpi_method)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	char *str;
+	union acpi_object *obj, *elements;
+	acpi_status status;
+	int i, j, val[3];
+	bool ret = false;
+
+	if (!adev || !acpi_has_method(adev->handle, acpi_method))
+		return false;
+
+	status = acpi_evaluate_object(adev->handle, acpi_method, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		return false;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3) {
+		dev_err(dev, "Unknown ACPI mount matrix package format\n");
+		goto out_free_buffer;
+	}
+
+	elements = obj->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_STRING) {
+			dev_err(dev, "Unknown ACPI mount matrix element format\n");
+			goto out_free_buffer;
+		}
+
+		str = elements[i].string.pointer;
+		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3) {
+			dev_err(dev, "Incorrect ACPI mount matrix string format\n");
+			goto out_free_buffer;
+		}
+
+		for (j = 0; j < 3; j++) {
+			switch (val[j]) {
+			case -1: str = "-1"; break;
+			case 0:  str = "0";  break;
+			case 1:  str = "1";  break;
+			default:
+				dev_err(dev, "Invalid value in ACPI mount matrix: %d\n", val[j]);
+				goto out_free_buffer;
+			}
+			orientation->rotation[i * 3 + j] = str;
+		}
+	}
+
+	ret = true;
+
+out_free_buffer:
+	kfree(buffer.pointer);
+	return ret;
+}
+#else
+static inline bool acpi_read_mount_matrix(struct device *dev,
+					  struct iio_mount_matrix *orientation,
+					  char *acpi_method)
+{
+	return false;
+}
+#endif
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index bb1660667bb0..7e19278491dc 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -24,6 +24,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/accel/kxcjk_1013.h>
 
+#include "acpi-helpers.h"
+
 #define KXCJK1013_DRV_NAME "kxcjk1013"
 #define KXCJK1013_IRQ_NAME "kxcjk1013_event"
 
@@ -636,73 +638,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool kxj1009_apply_acpi_orientation(struct device *dev,
-					   struct iio_mount_matrix *orientation)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = ACPI_COMPANION(dev);
-	char *str;
-	union acpi_object *obj, *elements;
-	acpi_status status;
-	int i, j, val[3];
-	bool ret = false;
-
-	if (!adev || !acpi_has_method(adev->handle, "ROTM"))
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
@@ -1533,7 +1468,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	} else {
 		data->active_high_intr = true; /* default polarity */
 
-		if (!kxj1009_apply_acpi_orientation(&client->dev, &data->orientation)) {
+		if (!acpi_read_mount_matrix(&client->dev, &data->orientation, "ROTM")) {
 			ret = iio_read_mount_matrix(&client->dev, &data->orientation);
 			if (ret)
 				return ret;
-- 
2.44.0


