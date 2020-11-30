Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A12C868A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgK3OVb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 09:21:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbgK3OVb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 09:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606746004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A1N8dDvmK4YpTMS/4NWS7JMXBe/6ZVSPaQwnCNnqx2A=;
        b=J/xcmdRDAW09jLWKEOX2Xfvp0JTRPIW0wFM6QoVdklqCFncdgHSPnAGc0c+pF0BEtPts0p
        LAPg+8S+wI/tCBm3VO4ssa+QYnVneqjrl4+LyMP1UpfECOcLlo9W3oHZfET7tnVHRaJhSD
        RPO0ux1RIPRkcMsspjTuF3cSVgmuU30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-L0UV2aFDOtOAivsL5ORY2w-1; Mon, 30 Nov 2020 09:20:02 -0500
X-MC-Unique: L0UV2aFDOtOAivsL5ORY2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D751C8735DA;
        Mon, 30 Nov 2020 14:20:00 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-181.ams2.redhat.com [10.36.115.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7285E60C69;
        Mon, 30 Nov 2020 14:19:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 3/3] iio: accel: bmc150: Get mount-matrix from ACPI
Date:   Mon, 30 Nov 2020 15:19:54 +0100
Message-Id: <20201130141954.339805-3-hdegoede@redhat.com>
In-Reply-To: <20201130141954.339805-1-hdegoede@redhat.com>
References: <20201130141954.339805-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

bmc150 accelerometers with an ACPI hardware-id of BOSC0200 have an ACPI
method providing their mount-matrix, add support for retrieving this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add a big comment adding some more info about when which ACPI object is
  used to get the mount-matrix and an (incomplete) list of devices known to
  use this
---
 drivers/iio/accel/bmc150-accel-core.c | 107 +++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 2976aefad89b..d61cc0ec4cfd 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -410,6 +410,103 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 }
 #endif
 
+#ifdef CONFIG_ACPI
+/*
+ * Support for getting accelerometer information from BOSC0200 ACPI nodes.
+ *
+ * There are 2 variants of the BOSC0200 ACPI node. Some 2-in-1s with 360 degree
+ * hinges declare 2 I2C ACPI-resources for 2 accelerometers, 1 in the display
+ * and 1 in the base of the 2-in-1. On these 2-in-1s the ROMS ACPI object
+ * contains the mount-matrix for the sensor in the display and ROMK contains
+ * the mount-matrix for the sensor in the base. On devices using a single
+ * sensor there is a ROTM ACPI object which contains the mount-matrix.
+ *
+ * Here is an incomplete list of devices known to use 1 of these setups:
+ *
+ * Yoga devices with 2 accelerometers using ROMS + ROMK for the mount-matrices:
+ * Lenovo Thinkpad Yoga 11e 3th gen
+ * Lenovo Thinkpad Yoga 11e 4th gen
+ *
+ * Tablets using a single accelerometer using ROTM for the mount-matrix:
+ * Chuwi Hi8 Pro (CWI513)
+ * Chuwi Vi8 Plus (CWI519)
+ * Chuwi Hi13
+ * Irbis TW90
+ * Jumper EZpad mini 3
+ * Onda V80 plus
+ * Predia Basic Tablet
+ */
+static bool bmc150_apply_acpi_orientation(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	union acpi_object *obj, *elements;
+	char *name, *alt_name, *str;
+	acpi_status status;
+	int i, j, val[3];
+
+	if (!adev || !acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
+		return false;
+
+	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0)
+		alt_name = "ROMK";
+	else
+		alt_name = "ROMS";
+
+	if (acpi_has_method(adev->handle, "ROTM"))
+		name = "ROTM";
+	else if (acpi_has_method(adev->handle, alt_name))
+		name = alt_name;
+	else
+		return false;
+
+	status = acpi_evaluate_object(adev->handle, name, NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		return false;
+	}
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 3)
+		goto unknown_format;
+
+	elements = obj->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_STRING)
+			goto unknown_format;
+
+		str = elements[i].string.pointer;
+		if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
+			goto unknown_format;
+
+		for (j = 0; j < 3; j++) {
+			switch (val[j]) {
+			case -1: str = "-1"; break;
+			case 0:  str = "0";  break;
+			case 1:  str = "1";  break;
+			default: goto unknown_format;
+			}
+			orientation->rotation[i * 3 + j] = str;
+		}
+	}
+
+	kfree(buffer.pointer);
+	return true;
+
+unknown_format:
+	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
+	kfree(buffer.pointer);
+	return false;
+}
+#else
+static bool bmc150_apply_acpi_orientation(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	return false;
+}
+#endif
+
 static const struct bmc150_accel_interrupt_info {
 	u8 map_reg;
 	u8 map_bitmask;
@@ -1571,10 +1668,12 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	data->regmap = regmap;
 
-	ret = iio_read_mount_matrix(dev, "mount-matrix",
-				     &data->orientation);
-	if (ret)
-		return ret;
+	if (!bmc150_apply_acpi_orientation(dev, &data->orientation)) {
+		ret = iio_read_mount_matrix(dev, "mount-matrix",
+					     &data->orientation);
+		if (ret)
+			return ret;
+	}
 
 	ret = bmc150_accel_chip_init(data);
 	if (ret < 0)
-- 
2.28.0

