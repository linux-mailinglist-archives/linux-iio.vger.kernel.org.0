Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE54872DE04
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jun 2023 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjFMJok (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jun 2023 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbjFMJoi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2023 05:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E9AC
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2023 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686649430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jemcAPPpKAt79EhDWT0yiBEs6heR+il/xktLqRxgoN8=;
        b=BkBUZDcAhQRNZyu2SG2F+LWShQzo8OsRZ4VbiU8DvDPPQLjSG6epczvuiFBg7eoV8tFUeO
        tMnR4XK677iu7yD8pJ/P2EvuiSSPDJbw6XWwfaLfNm7bFT4IFHL7zOgH4/R2JzKeXD36op
        X8lpWnwgdyGUpub1Zm0WqOguPkeJwe0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-NYYr-xzXPUqhLlkK96D73g-1; Tue, 13 Jun 2023 05:43:49 -0400
X-MC-Unique: NYYr-xzXPUqhLlkK96D73g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B109485A5B5;
        Tue, 13 Jun 2023 09:43:48 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 903691121314;
        Tue, 13 Jun 2023 09:43:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Juno Computers USA <usa@junocomputers.com>
Subject: [PATCH] iio: accel: da280: Add support for the DA217 accelerometer
Date:   Tue, 13 Jun 2023 11:43:46 +0200
Message-Id: <20230613094346.162551-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The DA217 accelerometer is another DA280 compatible accelerometer,
add its device-ids to the da280 driver.

Reported-by: Juno Computers USA <usa@junocomputers.com>
Tested-by: Juno Computers USA <usa@junocomputers.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note no Closes: for the Reported-by since this was reported by private email
---
 drivers/iio/accel/da280.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 38a7d811610e..a49c4f95fe7d 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * IIO driver for the MiraMEMS DA280 3-axis accelerometer and
+ * IIO driver for the MiraMEMS DA217 and DA280 3-axis accelerometer and
  * IIO driver for the MiraMEMS DA226 2-axis accelerometer
  *
  * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
@@ -23,7 +23,7 @@
 #define DA280_MODE_ENABLE		0x1e
 #define DA280_MODE_DISABLE		0x9e
 
-enum da280_chipset { da226, da280 };
+enum da280_chipset { da217, da226, da280 };
 
 /*
  * a value of + or -4096 corresponds to + or - 1G
@@ -134,7 +134,10 @@ static int da280_probe(struct i2c_client *client)
 		chip = id->driver_data;
 	}
 
-	if (chip == da226) {
+	if (chip == da217) {
+		indio_dev->name = "da217";
+		indio_dev->num_channels = 3;
+	} else if (chip == da226) {
 		indio_dev->name = "da226";
 		indio_dev->num_channels = 2;
 	} else {
@@ -166,12 +169,14 @@ static int da280_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
 
 static const struct acpi_device_id da280_acpi_match[] = {
+	{"NSA2513", da217},
 	{"MIRAACC", da280},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
 
 static const struct i2c_device_id da280_i2c_id[] = {
+	{ "da217", da217 },
 	{ "da226", da226 },
 	{ "da280", da280 },
 	{}
-- 
2.40.1

