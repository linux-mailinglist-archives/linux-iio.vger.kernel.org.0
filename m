Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845B44AB8F4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 11:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiBGKoF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 05:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiBGKeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 05:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 201FBC043189
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644230068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mt0kWAaOiV6B2Df2y8mWKQRZyhcrEoomyGQcX6ARqqg=;
        b=iaiAOLjdXeaevFWTc3ICz1cjewoKN+5Bbym7p6aP1soEO2LOvTpQXSChemY6yKMiySByN8
        PilGZ8evCw13RQ+c+i5/mi2Atd10iLs5LzX/rgGPHdjSpQgeoV+HSLOvOmFa+F9qmNMTRh
        addo4aT+7xlfe4WIUmP/cYfGYvIyX8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-YFZ-tMOFNHevo4trVAicvA-1; Mon, 07 Feb 2022 05:34:25 -0500
X-MC-Unique: YFZ-tMOFNHevo4trVAicvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D65962F45;
        Mon,  7 Feb 2022 10:34:23 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 645E96D033;
        Mon,  7 Feb 2022 10:34:22 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] iio: mma8452: Add support for the "mount-matrix" device property
Date:   Mon,  7 Feb 2022 11:34:19 +0100
Message-Id: <20220207103419.309032-2-hdegoede@redhat.com>
In-Reply-To: <20220207103419.309032-1-hdegoede@redhat.com>
References: <20220207103419.309032-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index eaa236cfbabb..3b9a0ef410ad 100644
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
@@ -1189,6 +1190,20 @@ static const struct attribute_group mma8452_event_attribute_group = {
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
@@ -1227,6 +1242,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
 	}, \
 	.event_spec = mma8452_transient_event, \
 	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
+	.ext_info = mma8452_ext_info, \
 }
 
 #define MMA8652_CHANNEL(axis, idx, bits) { \
@@ -1248,6 +1264,7 @@ static const struct attribute_group mma8452_event_attribute_group = {
 	}, \
 	.event_spec = mma8452_motion_event, \
 	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
+	.ext_info = mma8452_ext_info, \
 }
 
 static const struct iio_chan_spec mma8451_channels[] = {
@@ -1546,6 +1563,10 @@ static int mma8452_probe(struct i2c_client *client,
 		data->chip_info = match->data;
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

