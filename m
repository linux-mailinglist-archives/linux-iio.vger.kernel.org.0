Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1432F3125DE
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBGQKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 11:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhBGQKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2021 11:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612714149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZQXVkMqxp7XBFbeCA9Aa6LBCxZeB/3DymTyc75y28c=;
        b=ASkDx02l49o95YnIzF8lARFyEC7ZFX54Bg+MDlFi5UGy/sZVfhXtvjVHxzeV0TouxOOp0A
        Fe07tQnaJ9mfQ0cCWj1kS6/lZcwcUiLcs4iRYZr75krJWawFYVNIJ59Dw9WlCfBxi+2In2
        CZTRAX0s0cuoTq5TVAg8DT6zMg0TWNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-VOgOg6P3Mb2k_UvKGgPvhQ-1; Sun, 07 Feb 2021 11:09:08 -0500
X-MC-Unique: VOgOg6P3Mb2k_UvKGgPvhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDCB58030CC;
        Sun,  7 Feb 2021 16:09:06 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B45E36F7E6;
        Sun,  7 Feb 2021 16:09:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 2/3] iio: accel: bmc150: Set label based on accel-location on 2-accel yoga-style 2-in-1s
Date:   Sun,  7 Feb 2021 17:09:00 +0100
Message-Id: <20210207160901.110643-3-hdegoede@redhat.com>
In-Reply-To: <20210207160901.110643-1-hdegoede@redhat.com>
References: <20210207160901.110643-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some 2-in-1 laptops / convertibles with 360° (yoga-style) hinges,
use 2 bmc150 accelerometers, defined by a single BOSC0200 ACPI
device node (1 in their base and 1 in their display).

Since in this case we know the location of each accelerometer,
set the label for the accelerometers to the standardized
"accel-display" resp. "accel-base" labels. This way userspace
can use the labels to get the location.

This was tested on a Lenovo ThinkPad Yoga 11e 4th gen (N3450 CPU).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 7e425ebcd7ea..b0dbd12cbf42 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -443,26 +443,32 @@ static bool bmc150_apply_acpi_orientation(struct device *dev,
 					  struct iio_mount_matrix *orientation)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct acpi_device *adev = ACPI_COMPANION(dev);
+	char *name, *alt_name, *label, *str;
 	union acpi_object *obj, *elements;
-	char *name, *alt_name, *str;
 	acpi_status status;
 	int i, j, val[3];
 
 	if (!adev || !acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
 		return false;
 
-	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0)
+	if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0) {
 		alt_name = "ROMK";
-	else
+		label = "accel-base";
+	} else {
 		alt_name = "ROMS";
+		label = "accel-display";
+	}
 
-	if (acpi_has_method(adev->handle, "ROTM"))
+	if (acpi_has_method(adev->handle, "ROTM")) {
 		name = "ROTM";
-	else if (acpi_has_method(adev->handle, alt_name))
+	} else if (acpi_has_method(adev->handle, alt_name)) {
 		name = alt_name;
-	else
+		indio_dev->label = label;
+	} else {
 		return false;
+	}
 
 	status = acpi_evaluate_object(adev->handle, name, NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-- 
2.30.0

