Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D363A48638C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jan 2022 12:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiAFLOU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jan 2022 06:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24852 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbiAFLOT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jan 2022 06:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SN1E5kv/VKzquiC8Tp4Kxo2nGRaKEqKDERBa+dt6YbU=;
        b=DTuFfEquuD7CgKxgwFA+FIQdlyw89B+z7M82Tl68WwLrCqg4ONF6M5Z3AABTlzQjsolQAC
        ZiWlMXYp2djk0LlFPRfMMIa0n0mUihLSwtCQZtL+TNiq7tWjBU4OY3yeMky/wI4WQVAacd
        GRIPYcfkZkMwJvWEv4mAs2YbgMd3Rc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-iK8ryBm0MhqMnljGxLRKgQ-1; Thu, 06 Jan 2022 06:14:17 -0500
X-MC-Unique: iK8ryBm0MhqMnljGxLRKgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1D40801962;
        Thu,  6 Jan 2022 11:14:16 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 899431F307;
        Thu,  6 Jan 2022 11:14:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: mma8452: Fix probe failing when an i2c_device_id is used
Date:   Thu,  6 Jan 2022 12:14:14 +0100
Message-Id: <20220106111414.66421-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
 drivers/iio/accel/mma8452.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 09c7f10fefb6..c82841c0a7b3 100644
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
@@ -1581,7 +1588,7 @@ static int mma8452_probe(struct i2c_client *client,
 	}
 
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
-		 match->compatible, data->chip_info->chip_id);
+		 compatible, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mma8452_info;
-- 
2.33.1

