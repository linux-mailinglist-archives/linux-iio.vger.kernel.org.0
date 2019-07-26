Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF576043
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 10:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfGZIDE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 04:03:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44294 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIDD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 04:03:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so24092253pfe.11;
        Fri, 26 Jul 2019 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMe5uKhvczAsGIczBY6wv4d6jpwWM+g7rT71u8zhUT8=;
        b=ZGn5V/hhVXThkYc5+9ypEko++Dco1vB3j9OjCjRLUdJ1d/XqtgKtbV4ASenScK8CJN
         2qX1brclvxlxaqEkcjLQn6PJaP/jgCUeDF5PnW5G28u9WD/zY7HGwWATDAH4tGrTav61
         99GSSVYz4SghGSD+PobiyTmggY0L14+5lO8s9saHK0XuD2Svo7c5QzLNQvCtkmv5UDxU
         EAj8EcDQJamYBqavlWA2Ik7ILSVYmubZSA5dKAYjYhd8rZmYT93+BfIO/4zqgnZaPEdH
         H3zEyKk2tN9X4eiI+HDR0iJbt5QSjAMQpE6rjxT/dwavOerXo2LZt8txPCmErvrak1CR
         S3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMe5uKhvczAsGIczBY6wv4d6jpwWM+g7rT71u8zhUT8=;
        b=UCz9upHf/55CDiHLqp9a+LWnYtcsaIEkv4clw4/XbCJC3pbH5vVITP1REd8bXQezpq
         mphutmAcuVsTTzWEgnE9oEsSFQO1RsTRUCT0Z21ZCj0Cgoq0z2tyn7DBrJGozcnRSkdP
         rH5/yQB7kqF4bfqKfDMBP1aHK+bZK3FCR8oc5vTwEez9X+dhg5R+aXH3KXEf43lhs9qS
         mmAD2gKVSgrpNJm0CyGzJ1EjQKMy5zBYgS8zuUwd0VTHWrKsGBblDJLLHfIc8w90ChOL
         zyvNFCDkvw9ANJbOz8Msg7dcKsBqB1GUJkE8zehd3dcrdrNWPm3wF8bVWdftfGt/qAd8
         /8CA==
X-Gm-Message-State: APjAAAUo3ecGYKX6O8WuazDuIZOMyLqAshO5QiyaJs6Ty46IaUmESj5N
        VCmzQnhw5tBUcFaJMVSOZug=
X-Google-Smtp-Source: APXvYqyBULFpTkd0szfg14Xa/0UeiQd1hq5s+NS3x16Cm1gNDiIsCqzIj/gaA/sQbk0UTXpxo5xnaQ==
X-Received: by 2002:a17:90a:cb81:: with SMTP id a1mr94386101pju.81.1564128183115;
        Fri, 26 Jul 2019 01:03:03 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id y10sm53028132pfm.66.2019.07.26.01.03.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 01:03:02 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] iio: humidity: Use device-managed APIs
Date:   Fri, 26 Jul 2019 16:02:55 +0800
Message-Id: <20190726080255.13226-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device-managed APIs to simplify the code.
The remove functions are redundant now and can
be deleted.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/iio/humidity/am2315.c  | 21 ++++-----------------
 drivers/iio/humidity/hdc100x.c | 18 ++++--------------
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index f18da7859229..038638e92f4a 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -240,32 +240,20 @@ static int am2315_probe(struct i2c_client *client,
 	indio_dev->channels = am2315_channels;
 	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
 
-	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(&client->dev,
+					indio_dev, iio_pollfunc_store_time,
 					 am2315_trigger_handler, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0)
-		goto err_buffer_cleanup;
+		return ret;
 
 	return 0;
 
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
-}
-
-static int am2315_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
 }
 
 static const struct i2c_device_id am2315_i2c_id[] = {
@@ -287,7 +275,6 @@ static struct i2c_driver am2315_driver = {
 		.acpi_match_table = ACPI_PTR(am2315_acpi_id),
 	},
 	.probe =            am2315_probe,
-	.remove =	    am2315_remove,
 	.id_table =         am2315_i2c_id,
 };
 
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 066e05f92081..5186fd9bfdc5 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -385,26 +385,17 @@ static int hdc100x_probe(struct i2c_client *client,
 	hdc100x_set_it_time(data, 1, hdc100x_int_time[1][0]);
 	hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&client->dev,
+					 indio_dev, NULL,
 					 hdc100x_trigger_handler,
 					 &hdc_buffer_setup_ops);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0)
-		iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static int hdc100x_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
+		return ret;
 
 	return 0;
 }
@@ -436,7 +427,6 @@ static struct i2c_driver hdc100x_driver = {
 		.of_match_table = of_match_ptr(hdc100x_dt_ids),
 	},
 	.probe = hdc100x_probe,
-	.remove = hdc100x_remove,
 	.id_table = hdc100x_id,
 };
 module_i2c_driver(hdc100x_driver);
-- 
2.20.1

