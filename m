Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C243C4AD90F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Feb 2022 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbiBHNQQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Feb 2022 08:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359446AbiBHMnp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Feb 2022 07:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FE1FC03FECA
        for <linux-iio@vger.kernel.org>; Tue,  8 Feb 2022 04:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644324224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quo3BzHVQjsh1xOU/QiF0frha66U0VSidDHwGe8aSow=;
        b=FDZU6FZ+n98j6097bXDRHpeVo5y+IzcIrlmLjA9kOor93IvFyergpeSry0iXge2btp6yLu
        61L44f8acu0Lk+WMygJfQlA6QGWmGUH0QOBoZbX6zLsb4safbYZiFCiC7G6TkWntyalBck
        HGwveoTEsWnPDrBx4Ta1P799+Y/JTC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444--27T70DoMDKQ82TUwNcYig-1; Tue, 08 Feb 2022 07:43:41 -0500
X-MC-Unique: -27T70DoMDKQ82TUwNcYig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BF1E1966320;
        Tue,  8 Feb 2022 12:43:40 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7DA8F6C7;
        Tue,  8 Feb 2022 12:43:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 2/2] iio: mma8452: Add support for the "mount-matrix" device property
Date:   Tue,  8 Feb 2022 13:43:36 +0100
Message-Id: <20220208124336.511884-2-hdegoede@redhat.com>
In-Reply-To: <20220208124336.511884-1-hdegoede@redhat.com>
References: <20220208124336.511884-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the standard "mount-matrix" device property to
the mma8452 driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this applies on top of the following recent patch from me:
"iio: mma8452: Fix probe failing when an i2c_device_id is used"
---
 drivers/iio/accel/mma8452.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 0528717d9f44..590d9431e1bd 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -104,6 +104,7 @@
 struct mma8452_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	struct iio_mount_matrix orientation;
 	u8 ctrl_reg1;
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
@@ -1190,6 +1191,20 @@ static const struct attribute_group mma8452_event_attribute_group = {
 	.attrs = mma8452_event_attributes,
 };
 
+static const struct iio_mount_matrix *
+mma8452_get_mount_matrix(const struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan)
+{
+	struct mma8452_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mma8452_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, mma8452_get_mount_matrix),
+	{ }
+};
+
 #define MMA8452_FREEFALL_CHANNEL(modifier) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
@@ -1228,6 +1243,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
 	}, \
 	.event_spec = mma8452_transient_event, \
 	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
+	.ext_info = mma8452_ext_info, \
 }
 
 #define MMA8652_CHANNEL(axis, idx, bits) { \
@@ -1249,6 +1265,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
 	}, \
 	.event_spec = mma8452_motion_event, \
 	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
+	.ext_info = mma8452_ext_info, \
 }
 
 static const struct iio_chan_spec mma8451_channels[] = {
@@ -1546,6 +1563,10 @@ static int mma8452_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
+
 	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->vdd_reg))
 		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
-- 
2.33.1

