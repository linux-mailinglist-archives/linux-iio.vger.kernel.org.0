Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC238DC02
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhEWRCu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhEWRCt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bpDjPZzJmG0yjWSYBc2dSlkklF3Fe5sZH9/l6z7/r7I=;
        b=bEgV/3iGZqX8iTAU+CyIH52Wp3w9iASE5jflRSeE/b224I1QqN9vcec83OG0N1AvSBwcU8
        iaa18i39Zoigt50CCLXHno8Jn9iZi7XLe8dol0Xl6iFkKHOPzOxtU+QZ39fVfF6fiH0re0
        evUUaJoCAmHdCdrTpgcEh0AgdzgRHpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-tjWiT-QyM3-Z7ESb1Gi6hQ-1; Sun, 23 May 2021 13:01:21 -0400
X-MC-Unique: tjWiT-QyM3-Z7ESb1Gi6hQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 021881854E27;
        Sun, 23 May 2021 17:01:20 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A30C05D9F2;
        Sun, 23 May 2021 17:01:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 8/9] iio: accel: bmc150: Refactor bmc150_apply_acpi_orientation()
Date:   Sun, 23 May 2021 19:01:02 +0200
Message-Id: <20210523170103.176958-9-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Factor the BOSC0200 ACPI HID handling out into a new
bmc150_apply_bosc0200_acpi_orientation() function and make
bmc150_apply_acpi_orientation() call that when dealing with
a BOSC0200 ACPI device (and make it return false otherwise).

This is a preparation patch for adding special handling for other
ACPI HIDs (the "DUAL250E" HID).

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- This is a new patch in v2 of this patch-set
---
 drivers/iio/accel/bmc150-accel-core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 932007895f18..f685ed617424 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -386,8 +386,8 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
  * Onda V80 plus
  * Predia Basic Tablet
  */
-static bool bmc150_apply_acpi_orientation(struct device *dev,
-					  struct iio_mount_matrix *orientation)
+static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
+						   struct iio_mount_matrix *orientation)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -397,9 +397,6 @@ static bool bmc150_apply_acpi_orientation(struct device *dev,
 	acpi_status status;
 	int i, j, val[3];
 
-	if (!adev || !acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
-		return false;
-
 	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0) {
 		alt_name = "ROMK";
 		label = "accel-base";
@@ -455,6 +452,17 @@ static bool bmc150_apply_acpi_orientation(struct device *dev,
 	kfree(buffer.pointer);
 	return false;
 }
+
+static bool bmc150_apply_acpi_orientation(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev && acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
+		return bmc150_apply_bosc0200_acpi_orientation(dev, orientation);
+
+	return false;
+}
 #else
 static bool bmc150_apply_acpi_orientation(struct device *dev,
 					  struct iio_mount_matrix *orientation)
-- 
2.31.1

