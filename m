Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B9A4AD90B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Feb 2022 14:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350309AbiBHNQO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Feb 2022 08:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359441AbiBHMno (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Feb 2022 07:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D46FCC03FEC0
        for <linux-iio@vger.kernel.org>; Tue,  8 Feb 2022 04:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644324222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WHSdaGV7D6BVO7kqtGhJJi7bUe22481XQCQAgrnr4ag=;
        b=L712hIFjxlPda5Hto6GInGPUzDtr4J0jVii6QBXw88UWriniZk7czrfpZh53lrEZDIcrQS
        /Ria9IbwDjDDBjH6FQ5YkWIRH8+TeGxNkr+seBQdB/D+GfGvcwPWidCFvypbpvA6X/WAAv
        gw5F04/Xsy2LYgPMxwWqmSuxvIIxR98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-I39ZHvcBO3CNWiCt0s7w-A-1; Tue, 08 Feb 2022 07:43:39 -0500
X-MC-Unique: I39ZHvcBO3CNWiCt0s7w-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A152D83DD20;
        Tue,  8 Feb 2022 12:43:38 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 220D4F6C7;
        Tue,  8 Feb 2022 12:43:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] iio: mma8452: Fix probe failing when an i2c_device_id is used
Date:   Tue,  8 Feb 2022 13:43:35 +0100
Message-Id: <20220208124336.511884-1-hdegoede@redhat.com>
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

The mma8452_driver declares both of_match_table and i2c_driver.id_table
match-tables, but its probe() function only checked for of matches.

Add support for i2c_device_id matches. This fixes the driver not loading
on some x86 tablets (e.g. the Nextbook Ares 8) where the i2c_client is
instantiated by platform code using an i2c_device_id.

Fixes: c3cdd6e48e35 ("iio: mma8452: refactor for seperating chip specific data")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Store name in struct mma_chip_info and use that to set indio_dev->name
- Switch to using device_get_match_data() for (potentially) adding ACPI
  enumeration support in the future

Changes in v2:
- Fix the following smatch warning:
  drivers/iio/accel/mma8452.c:1595 mma8452_probe() error: we previously assumed 'id' could be null (see line 1536)
  Reported-by: kernel test robot <lkp@intel.com>
  Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/accel/mma8452.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 64b82b4503ad..0528717d9f44 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -176,6 +176,7 @@ static const struct mma8452_event_regs trans_ev_regs = {
  * @enabled_events:		event flags enabled and handled by this driver
  */
 struct mma_chip_info {
+	const char *name;
 	u8 chip_id;
 	const struct iio_chan_spec *channels;
 	int num_channels;
@@ -1301,6 +1302,7 @@ enum {
 
 static const struct mma_chip_info mma_chip_info_table[] = {
 	[mma8451] = {
+		.name = "mma8451",
 		.chip_id = MMA8451_DEVICE_ID,
 		.channels = mma8451_channels,
 		.num_channels = ARRAY_SIZE(mma8451_channels),
@@ -1325,6 +1327,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 					MMA8452_INT_FF_MT,
 	},
 	[mma8452] = {
+		.name = "mma8452",
 		.chip_id = MMA8452_DEVICE_ID,
 		.channels = mma8452_channels,
 		.num_channels = ARRAY_SIZE(mma8452_channels),
@@ -1341,6 +1344,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 					MMA8452_INT_FF_MT,
 	},
 	[mma8453] = {
+		.name = "mma8453",
 		.chip_id = MMA8453_DEVICE_ID,
 		.channels = mma8453_channels,
 		.num_channels = ARRAY_SIZE(mma8453_channels),
@@ -1357,6 +1361,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 					MMA8452_INT_FF_MT,
 	},
 	[mma8652] = {
+		.name = "mma8652",
 		.chip_id = MMA8652_DEVICE_ID,
 		.channels = mma8652_channels,
 		.num_channels = ARRAY_SIZE(mma8652_channels),
@@ -1366,6 +1371,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.enabled_events = MMA8452_INT_FF_MT,
 	},
 	[mma8653] = {
+		.name = "mma8653",
 		.chip_id = MMA8653_DEVICE_ID,
 		.channels = mma8653_channels,
 		.num_channels = ARRAY_SIZE(mma8653_channels),
@@ -1380,6 +1386,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		.enabled_events = MMA8452_INT_FF_MT,
 	},
 	[fxls8471] = {
+		.name = "fxls8471",
 		.chip_id = FXLS8471_DEVICE_ID,
 		.channels = mma8451_channels,
 		.num_channels = ARRAY_SIZE(mma8451_channels),
@@ -1522,13 +1529,6 @@ static int mma8452_probe(struct i2c_client *client,
 	struct mma8452_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
-	const struct of_device_id *match;
-
-	match = of_match_device(mma8452_dt_ids, &client->dev);
-	if (!match) {
-		dev_err(&client->dev, "unknown device model\n");
-		return -ENODEV;
-	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -1537,7 +1537,14 @@ static int mma8452_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
-	data->chip_info = match->data;
+
+	data->chip_info = device_get_match_data(&client->dev);
+	if (!data->chip_info && id) {
+		data->chip_info = &mma_chip_info_table[id->driver_data];
+	} else {
+		dev_err(&client->dev, "unknown device model\n");
+		return -ENODEV;
+	}
 
 	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->vdd_reg))
@@ -1581,11 +1588,11 @@ static int mma8452_probe(struct i2c_client *client,
 	}
 
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
-		 match->compatible, data->chip_info->chip_id);
+		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mma8452_info;
-	indio_dev->name = id->name;
+	indio_dev->name = data->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
-- 
2.33.1

