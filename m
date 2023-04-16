Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0586E3C19
	for <lists+linux-iio@lfdr.de>; Sun, 16 Apr 2023 23:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDPVZD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Apr 2023 17:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPVZD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Apr 2023 17:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B31BE3
        for <linux-iio@vger.kernel.org>; Sun, 16 Apr 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681680255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TOvun/3stcpdVLe0tl49nNqMExJh804SpmZgnLpgV40=;
        b=i067tkh7a5GYxHAry6DBbjKJcMIV462832aT3ohy8IxDF+y2kxP5NDTiYZjNnNur/Ktw2u
        bFkKw43+URZ6Ym8/BkknidkXynn48OPdp5PeZodAvYys/kttouzcB9qS+Q4aIg35oXAWjx
        bI4cNnx/0yIavlc5n8zQyQW4e5IJrfA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-53QEQA0MOpycOF4gifUCaw-1; Sun, 16 Apr 2023 17:24:12 -0400
X-MC-Unique: 53QEQA0MOpycOF4gifUCaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1929101A54F;
        Sun, 16 Apr 2023 21:24:11 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FA292166B26;
        Sun, 16 Apr 2023 21:24:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marius Hoch <mail@mariushoch.de>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: st_accel: Fix invalid mount_matrix on devices without ACPI _ONT method
Date:   Sun, 16 Apr 2023 23:24:09 +0200
Message-Id: <20230416212409.310936-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When apply_acpi_orientation() fails, st_accel_common_probe() will fall back
to iio_read_mount_matrix(), which checks for a mount-matrix device property
and if that is not set falls back to the identity matrix.

But when a sensor has no ACPI companion fwnode, or when the ACPI fwnode
does not have a "_ONT" method apply_acpi_orientation() was returning 0,
causing iio_read_mount_matrix() to never get called resulting in an
invalid mount_matrix:

[root@fedora ~]# cat /sys/bus/iio/devices/iio\:device0/mount_matrix
(null), (null), (null); (null), (null), (null); (null), (null), (null)

Fix this by making apply_acpi_orientation() always return an error when
it did not set the mount_matrix.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/st_accel_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 1628b177d0ed..f7b823ebc96b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1291,12 +1291,12 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev)
 
 	adev = ACPI_COMPANION(indio_dev->dev.parent);
 	if (!adev)
-		return 0;
+		return -ENXIO;
 
 	/* Read _ONT data, which should be a package of 6 integers. */
 	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
 	if (status == AE_NOT_FOUND) {
-		return 0;
+		return -ENXIO;
 	} else if (ACPI_FAILURE(status)) {
 		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
 			 status);
-- 
2.39.2

