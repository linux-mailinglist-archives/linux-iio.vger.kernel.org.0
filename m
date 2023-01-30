Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4A4681AEA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 20:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjA3T4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 14:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjA3T4g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 14:56:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5F2333B
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 11:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46C946123D
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 19:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94197C4339B;
        Mon, 30 Jan 2023 19:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675108594;
        bh=OpY+CzBbRFYjkV4wYgrapkdSJjaet8Nkmc9vBjzVy2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5jHtmj8t1ejJl5hfgYFvBuREAYflAaEzRN08RLU5Lqvpp/Qf872VClNPrExkGvOv
         dlHhgAxYyddYu84Obw4gHj0xZLf8wjMgfZGaTZPvBw9gH1R81kiV753V+XRKazvm8E
         LP/AnAZEQXZ3FcLpYSoifjf/MSWG1lIbP2vw8dI/orsstLF0VSllPf8acqNHTRKvNu
         kFFF9QZdJH3Nm79RvT2iUDVFEfypFrgZIsioOnMY8jzjgxP7a/dZGweEf3uh3tUXoR
         F78IuLle0rzmgOdkG/2fCrl7rOvzvuYzb3iBY+aM6kFDZcPl/tsM3bGDSIK3UZd9h6
         RLNTfi40wqHHA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Darrell Kavanagh <darrell.kavanagh@gmail.com>
Cc:     lorenzo@kernel.org, carnil@debian.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio: imu: lsm6dsx: Add ACPI mount matrix retrieval
Date:   Mon, 30 Jan 2023 20:10:18 +0000
Message-Id: <20230130201018.981024-3-jic23@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130201018.981024-1-jic23@kernel.org>
References: <20230130201018.981024-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

DSDT ROTM method seen in the wild with SMO8B30 _HID.
Making assumption it is similar to that used for bmc150 plus
information from Darrell that the rotation is out by 90 degrees at boot.

Method (ROTM, 0, NotSerialized)
{
    Name (RBUF, Package (0x03)
    {
        "0 -1 0",
        "1 0 0",
        "0 0 1"
    })
    Return (RBUF) /* \_SB_.PCI0.I2C5.DEV_.ROTM.RBUF */
}

Reported-by: Darrell Kavanagh <darrell.kavanagh@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
Untested.  Fingers crossed.

We could factor this out if it keeps turning up.  The bmc150 varient
is more complex as multiple method IDs exist depending on the configuration.

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 65 +++++++++++++++++++-
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 3f6060c64f32..3c2d67f8d9b7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -56,6 +56,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -2602,6 +2603,61 @@ static int st_lsm6dsx_init_regulators(struct device *dev)
 	return 0;
 }
 
+static bool lsm6dsx_get_acpi_mount_matrix(struct device *dev,
+					  struct iio_mount_matrix *orientation)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	union acpi_object *obj, *elements;
+	acpi_status status;
+	int i, j, val[3];
+	char *str;
+
+	if (!has_acpi_companion(dev))
+		return -EINVAL;
+
+	if (!acpi_has_method(adev->handle, "ROTM"))
+		return -EINVAL;
+
+	status = acpi_evaluate_object(adev->handle, "ROTM", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(dev, "Failed to get ACPI mount matrix: %d\n", status);
+		return -EINVAL;
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
+	return 0;
+
+unknown_format:
+	dev_warn(dev, "Unknown ACPI mount matrix format, ignoring\n");
+	kfree(buffer.pointer);
+	return -EINVAL;
+}
+
 int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		     struct regmap *regmap)
 {
@@ -2676,9 +2732,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
-	err = iio_read_mount_matrix(hw->dev, &hw->orientation);
-	if (err)
-		return err;
+	err = lsm6dsx_get_acpi_mount_matrix(hw->dev, &hw->orientation);
+	if (err) {
+		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
+		if (err)
+			return err;
+	}
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		if (!hw->iio_devs[i])
-- 
2.39.1

