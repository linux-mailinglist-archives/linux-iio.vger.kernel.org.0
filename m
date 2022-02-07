Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F47E4AB8F1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 11:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiBGKne (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 05:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiBGKes (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 05:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F7C7C043181
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644230086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ibN6/eDkPg06FmKcOZnz2iN/4NPbggkjDC87Ud75vSU=;
        b=KDp2dPrynwOgpI14Gc0PtuCNnw/fhGgxzkV0HQwF3c7ATMPdvpuQyEabUJjD7GU86EpHpd
        MtYxan9E3e8Wziwo3tCfES8B5v5Hkcrmza+E8zhqEUcP+A158tRviE2nbI98PsusxvPLq/
        owVXuMv6UVm1KCu2rKwK3WdaxgUJX6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-2LwQpE5iP5SwIcEonMbkGQ-1; Mon, 07 Feb 2022 05:34:23 -0500
X-MC-Unique: 2LwQpE5iP5SwIcEonMbkGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2A22814243;
        Mon,  7 Feb 2022 10:34:21 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD6E4F867;
        Mon,  7 Feb 2022 10:34:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] iio: mma8452: Fix probe failing when an i2c_device_id is used
Date:   Mon,  7 Feb 2022 11:34:18 +0100
Message-Id: <20220207103419.309032-1-hdegoede@redhat.com>
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

The mma8452_driver declares both of_match_table and i2c_driver.id_table
match-tables, but its probe() function only checked for of matches.

Add support for i2c_device_id matches. This fixes the driver not loading
on some x86 tablets (e.g. the Nextbook Ares 8) where the i2c_client is
instantiated by platform code using an i2c_device_id.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Fix the following smatch warning:
  drivers/iio/accel/mma8452.c:1595 mma8452_probe() error: we previously assumed 'id' could be null (see line 1536)
  Reported-by: kernel test robot <lkp@intel.com>
  Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/accel/mma8452.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 64b82b4503ad..eaa236cfbabb 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1523,12 +1523,7 @@ static int mma8452_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
 	const struct of_device_id *match;
-
-	match = of_match_device(mma8452_dt_ids, &client->dev);
-	if (!match) {
-		dev_err(&client->dev, "unknown device model\n");
-		return -ENODEV;
-	}
+	const char *compatible;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -1537,7 +1532,19 @@ static int mma8452_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
-	data->chip_info = match->data;
+
+	if (id) {
+		compatible = id->name;
+		data->chip_info = &mma_chip_info_table[id->driver_data];
+	} else {
+		match = of_match_device(mma8452_dt_ids, &client->dev);
+		if (!match) {
+			dev_err(&client->dev, "unknown device model\n");
+			return -ENODEV;
+		}
+		compatible = match->compatible;
+		data->chip_info = match->data;
+	}
 
 	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
 	if (IS_ERR(data->vdd_reg))
@@ -1581,11 +1588,11 @@ static int mma8452_probe(struct i2c_client *client,
 	}
 
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
-		 match->compatible, data->chip_info->chip_id);
+		 compatible, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mma8452_info;
-	indio_dev->name = id->name;
+	indio_dev->name = compatible;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
-- 
2.33.1

