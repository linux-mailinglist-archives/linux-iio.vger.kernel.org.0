Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4738DC04
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEWRCw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30842 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231888AbhEWRCv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YtJzCJgZWMfuO1kxFZ73Mj+9PWllvnQ3EE9fVEJuvhA=;
        b=Q9kletCEz2j3bljan0a+dKIZ3XcGsuoZrBeIl0Ss7vNMjjjNdgq2PqF1MxmyGRpU5SdB1x
        HtoyG8qyEwzNhTipXBt600fZrRdOX1G1rUTzQFQk5/nq3jQ2+U7qpwNsXc/xVlrYLEFwTy
        Hik1kYUsAU/MQ9rbQXgMc43Gr2TNmp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-P_kmsn0POXC1osD-Jdx6kw-1; Sun, 23 May 2021 13:01:22 -0400
X-MC-Unique: P_kmsn0POXC1osD-Jdx6kw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B17E501E3;
        Sun, 23 May 2021 17:01:21 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 483C45D9F2;
        Sun, 23 May 2021 17:01:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 9/9] iio: accel: bmc150: Set label based on accel-location for ACPI DUAL250E fwnodes
Date:   Sun, 23 May 2021 19:01:03 +0200
Message-Id: <20210523170103.176958-10-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some Yoga laptops with 1 accelerometer in the display and 1 in the base,
use an ACPI HID of DUAL250E instead of BOSC0200.

Set the iio-device's label for DUAL250E devices to a value indicating which
sensor is which, mirroring how we do this for BOSC0200 dual sensor devices.

Note the DUAL250E fwnode unfortunately does not include a mount-matrix.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Rebase on top of the new "iio: accel: bmc150: Refactor
  bmc150_apply_acpi_orientation()" patch
---
 drivers/iio/accel/bmc150-accel-core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index f685ed617424..95a9ef2d333e 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -453,6 +453,19 @@ static bool bmc150_apply_bosc0200_acpi_orientation(struct device *dev,
 	return false;
 }
 
+static bool bmc150_apply_dual250e_acpi_orientation(struct device *dev,
+						   struct iio_mount_matrix *orientation)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	if (strcmp(dev_name(dev), "i2c-DUAL250E:base") == 0)
+		indio_dev->label = "accel-base";
+	else
+		indio_dev->label = "accel-display";
+
+	return false; /* DUAL250E fwnodes have no mount matrix info */
+}
+
 static bool bmc150_apply_acpi_orientation(struct device *dev,
 					  struct iio_mount_matrix *orientation)
 {
@@ -461,6 +474,9 @@ static bool bmc150_apply_acpi_orientation(struct device *dev,
 	if (adev && acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
 		return bmc150_apply_bosc0200_acpi_orientation(dev, orientation);
 
+	if (adev && acpi_dev_hid_uid_match(adev, "DUAL250E", NULL))
+		return bmc150_apply_dual250e_acpi_orientation(dev, orientation);
+
 	return false;
 }
 #else
-- 
2.31.1

