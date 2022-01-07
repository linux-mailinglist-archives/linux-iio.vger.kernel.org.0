Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68C0487F4D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jan 2022 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiAGXSi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jan 2022 18:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbiAGXSi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jan 2022 18:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641597517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+EOLEcB+y/O8Ny5DhlHWHpjY35P4wetKBI/FoQeHGWk=;
        b=SYL0FxAY0sEVGPVmWcNNlZDaP6d52BodoM9+W4AvoTxIHt2o3w0ZW4Efffsn7Bl9Hpz/dv
        SbvdRn+OAzolgYVuULgz0pC7zVYD9uCAyX+/dgqGBZq/n+IN4ZZRTOUyzBGt+hxwyxa/48
        WcmlvXDU4B1QPrvATsKxNp5yBtILVbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-wZ1xbIKUPrCaDCe8QXI6DA-1; Fri, 07 Jan 2022 18:18:36 -0500
X-MC-Unique: wZ1xbIKUPrCaDCe8QXI6DA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56CE21800D50;
        Fri,  7 Jan 2022 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 041B378DDD;
        Fri,  7 Jan 2022 23:18:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: mma8452: Add support for the "mount-matrix" device property
Date:   Sat,  8 Jan 2022 00:18:26 +0100
Message-Id: <20220107231826.130461-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index c82841c0a7b3..c03f65a061c8 100644
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

