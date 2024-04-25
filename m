Return-Path: <linux-iio+bounces-4511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844B8B2210
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F6D2853B4
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEBE1494CD;
	Thu, 25 Apr 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iidU0Pns"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD885274
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049884; cv=none; b=m3kbepe1/F0GzHpx8zsBlpiVfljz4lRYAsjbKlXwS5UWVU42aRqt+sBCtiLICjysEFhX+UOLPbXQwNQ9GbqyG2S4Z4a5ooHDmhifEQIVbGry23NANjcxW+Djz46D/luWf4wcgjxzZLMhrvHc+SZfz0ZBTpt953hb5D639TCuCN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049884; c=relaxed/simple;
	bh=K+CR42DzJbuXgxAqdL/KHWtBN0knuTOiZH8sEelRP3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9mqGyY9bLueWC0/mYTUjLC+wQQ97M9ExEgj9jkc37uAK3NZ89IHMqKn2hd14m11RDSJazEV6LQ76KaHYVGMDiGrZFT09nkojcSeGpUg/u3y//f+hJeKjD2bfUpYG7wx9vcw1gjKfmCbindS9RkG5oSbG/sh9TQUuVc7qI2bF+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iidU0Pns; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714049881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KY9x2T5G0EDDFijGupqL45T20gcKCHCnrA9j49BOvuo=;
	b=iidU0Pns+pCjkKmNdj13coEza03f2mh94oaiy7REf/coxgvVdgQuJDAU95TGs4HgW3tUEu
	rmYHCJ9JaxQ6tN8r/ODukEeHQn3XbndViFCRON8mjtAKk1X/mqJJphyUFnzuKyGA0dEEUy
	2wMs9BYJxAT1IjZq5uwpXjZlOCtRBZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-jQEU2QMeNAer2rL_GiXidA-1; Thu, 25 Apr 2024 08:58:00 -0400
X-MC-Unique: jQEU2QMeNAer2rL_GiXidA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF52580021A;
	Thu, 25 Apr 2024 12:57:59 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DF5A1121306;
	Thu, 25 Apr 2024 12:57:57 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>,
	linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 1/4] iio: core: Add iio_read_acpi_mount_matrix() helper function
Date: Thu, 25 Apr 2024 14:57:51 +0200
Message-ID: <20240425125754.76010-2-hdegoede@redhat.com>
In-Reply-To: <20240425125754.76010-1-hdegoede@redhat.com>
References: <20240425125754.76010-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The ACPI "ROTM" rotation matrix parsing code atm is already duplicated
between bmc150-accel-core.c and kxcjk-1013.c and a third user of this
is coming.

Add an iio_read_acpi_mount_matrix() helper function for this.
The 2 existing copies of the code are identical, except that
the kxcjk-1013.c has slightly better error logging.

To new helper is a 1:1 copy of the kxcjk-1013.c version, the only change
is the addition of a "char *acpi_method" parameter since some bmc150
dual-accel setups (360° hinges with 1 accel in kbd/base + 1 in display)
declare both accels in a single ACPI device with 2 different method names
for the 2 matrices. This new acpi_method parameter is not "const char *"
because the pathname parameter to acpi_evaluate_object() is not const.

The 2 existing copies of this function will be removed in further patches
in this series.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- New patch in v3 of this series.
---
 drivers/iio/Makefile            |  1 +
 drivers/iio/industrialio-acpi.c | 85 +++++++++++++++++++++++++++++++++
 include/linux/iio/iio.h         | 13 +++++
 3 files changed, 99 insertions(+)
 create mode 100644 drivers/iio/industrialio-acpi.c

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 0ba0e1521ba4..cb80ef837e84 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
+industrialio-$(CONFIG_ACPI) += industrialio-acpi.o
 
 obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
 obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
new file mode 100644
index 000000000000..c47bf0c22e4f
--- /dev/null
+++ b/drivers/iio/industrialio-acpi.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* IIO ACPI helper functions */
+
+#include <linux/acpi.h>
+#include <linux/dev_printk.h>
+#include <linux/iio/iio.h>
+#include <linux/sprintf.h>
+
+/**
+ * iio_read_acpi_mount_matrix() - Read accelerometer mount matrix info from ACPI
+ * @dev:		Device structure
+ * @matrix: 		iio_mount_matrix struct to fill
+ * @method_name:	ACPI method name to read the matrix from, usually "ROTM"
+ *
+ * Try to read the mount-matrix by calling the specified method on the device's
+ * ACPI firmware-node. If the device has no ACPI firmware-node; or the method
+ * does not exist then this will fail silently. This expects the method to
+ * return data in the ACPI "ROTM" format defined by Microsoft:
+ * https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sensors-acpi-entries
+ * This is a Microsoft extension and not part of the official ACPI spec.
+ * The method name is configurable because some dual-accel setups define 2 mount
+ * matrices in a single ACPI device using separate "ROMK" and "ROMS" methods.
+ *
+ * Returns: true if the matrix was successfully, false otherwise.
+ */
+bool iio_read_acpi_mount_matrix(struct device *dev,
+				struct iio_mount_matrix *orientation,
+				char *acpi_method)
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
+EXPORT_SYMBOL_GPL(iio_read_acpi_mount_matrix);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e370a7bb3300..4ed41e70c86e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -788,6 +788,19 @@ static inline struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
 }
 #endif
 
+#ifdef CONFIG_ACPI
+bool iio_read_acpi_mount_matrix(struct device *dev,
+				struct iio_mount_matrix *matrix,
+				char *method_name);
+#else
+static inline bool iio_read_acpi_mount_matrix(struct device *dev,
+					      struct iio_mount_matrix *matrix,
+					      char *method_name)
+{
+	return false;
+}
+#endif
+
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
 
 int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
-- 
2.44.0


