Return-Path: <linux-iio+bounces-4306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04648A8953
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5797B28252F
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701F117106F;
	Wed, 17 Apr 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkvldJ3i"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C1171078
	for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372396; cv=none; b=DaoOiShKIkmEzM6fObrubqYST/keJUi59ydwRQ/nWVh0oKYNATyM54qDjpOyR50aeUI7h4R7cafu8sNy4xqyzpx9/Cpxj3oLEm7+lkkJX0bha760hW1m002H9ylzRRJZt55IP/6L8vpYOfIrKNtybtbvPWFVQEFxtCrIVEIGer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372396; c=relaxed/simple;
	bh=vduD0yi6Cr5fHGRN7hsRvFdJHNoHsUqHEGrgwjg/2vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqmvKnlX/JwFfxIEAjkjN6zrn6PXSF7RLUe+JB5fCkhKrwmQA2WW/fTaBe5N75ShtdPyCFQU7sEXOJAbNZQgF3zj0HNUIEuv/IbJtfc1WiFmbvBYQB0Da/U/c2MMSTAtEwnMu/T8wgpZiZHXx0egnJ71U+YNZihtvarY8noAZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkvldJ3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713372393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXiTOwWf7QtT7cGme0wZnz+KOBJfI78QTu3yOuIzb1Y=;
	b=WkvldJ3i6Q9tOqJ3o5VrJFxIU4JvqF5PR4MrpXOFJ4PAw7Vq+Dq4xDUSIVf89qdWzkNPA1
	dCBLS/JtYfHXRoDuwSY7CJz25w1USOt50qy2x8Te7dASHZMiFAgjZWA/Q4IiflMzVReikE
	4BcADDPOGkBU0O7HO0mzy7852lWtnz4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-rOT5_K0SObCP_fhjE-R8-A-1; Wed,
 17 Apr 2024 12:46:29 -0400
X-MC-Unique: rOT5_K0SObCP_fhjE-R8-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FF423810D43;
	Wed, 17 Apr 2024 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB3642166B31;
	Wed, 17 Apr 2024 16:46:28 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/4] iio: accel: kxcjk-1013: Move ACPI ROTM parsing to new acpi-helpers.h
Date: Wed, 17 Apr 2024 18:46:14 +0200
Message-ID: <20240417164616.74651-3-hdegoede@redhat.com>
In-Reply-To: <20240417164616.74651-1-hdegoede@redhat.com>
References: <20240417164616.74651-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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
 drivers/iio/accel/acpi-helpers.h | 76 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/kxcjk-1013.c   | 71 ++---------------------------
 2 files changed, 79 insertions(+), 68 deletions(-)
 create mode 100644 drivers/iio/accel/acpi-helpers.h

diff --git a/drivers/iio/accel/acpi-helpers.h b/drivers/iio/accel/acpi-helpers.h
new file mode 100644
index 000000000000..a4357925bf07
--- /dev/null
+++ b/drivers/iio/accel/acpi-helpers.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* ACPI helper functions for parsing ACPI rotation matrices */
+
+#include <linux/acpi.h>
+#include <linux/dev_printk.h>
+#include <linux/iio/iio.h>
+#include <linux/sprintf.h>
+
+#ifdef CONFIG_ACPI
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


