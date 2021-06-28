Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA243B5F6D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jun 2021 15:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhF1Nys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Jun 2021 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhF1Nys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jun 2021 09:54:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6014EC061760
        for <linux-iio@vger.kernel.org>; Mon, 28 Jun 2021 06:52:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l8so12610052wry.13
        for <linux-iio@vger.kernel.org>; Mon, 28 Jun 2021 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diap9fcYCkWKv/Qg6fT0+qsnz8jKwEg8akmh3ZI+4Wg=;
        b=G3jDBf5YwwFNJ7E6BmB1nhbQZYlznqZSI/avLRaRxOIigRWmqDK6OxUOAjkeUTyRsS
         x+aVl9FGNYILNu537NoKMXZ7i93oB9P+eF8OfUUDv23GPn0x36Y9FJzmmyeZugdNfzDk
         8+Ugkzj6Z5+uLuP3yh1ctb9kz9rCqy8SiHqcMFfOtkMYvxx5lfyoiWy0BDWipflaI6jP
         4YztLc0XC14CnxoSJPhSNGEwVKEm2d8Hof8AzphX4MrbbmdlLWjXPR0C/pPjfMF/YXcc
         pfpWRZA2kPXtGUlF3jEjm6dNGjroakgt7G6gYNFvR3IbOA5mpONsPVQUC4WDjptBiqHo
         pjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=diap9fcYCkWKv/Qg6fT0+qsnz8jKwEg8akmh3ZI+4Wg=;
        b=gj0T1xGkUNXBUR57lXGlhftqyvsvm2+64mh+v7Z6i5SgrIAc7DO9MV4j0zjwygwraP
         LREkuJbhnvdn2WiFwgffQt760+0h31NzaKNMhE7U6aNTtwBzaGdaw1Qh/KUNfdxCzGow
         n8AyISbYt6ORje3O1fQsdhAFt5tRS1MK/d8X0mPomczxXDQapKcNn35qV0p/pvAFQd9j
         hcRcAMkl+4f0AtI9MjK3btoLG7rseKH9ucLrPhu+dVJrKSuvGAuhprS9heqlXyOPy2Ux
         wrFdXwlkpLj07Z1PybBdBT0bh55mkODUvXbK2VhQCd/stD6XiiwZVFB+D3OK5OrNhn5l
         UuvA==
X-Gm-Message-State: AOAM530A2iTRqOhNJPxvIJqCYEEg+dAgnB+DDd5BEYPJPl8nKrwWc4ch
        OmKd/8UEPyOHXTcW2jk1fKWqzwVzfECu3VxOgsY=
X-Google-Smtp-Source: ABdhPJz4lXKAnVnpga+cU3Sooi5YlNaiEDbCmzBnzb8Rk/DQuoe4zNecRHOqu5815Yuw78Lon8wNgg==
X-Received: by 2002:a5d:4103:: with SMTP id l3mr9365465wrp.102.1624888340356;
        Mon, 28 Jun 2021 06:52:20 -0700 (PDT)
Received: from neptune.anevia.com (ip-149-62-159-73.naitways.net. [149.62.159.73])
        by smtp.gmail.com with ESMTPSA id m184sm13749911wmm.26.2021.06.28.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:52:19 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] iio: light: adjd_s311: convert to device-managed functions
Date:   Mon, 28 Jun 2021 16:51:32 +0300
Message-Id: <20210628135132.73682-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This one is a little easier to convert to device-managed, now with the
devm_krealloc() function.

The other iio_triggered_buffer_setup() and iio_device_register() can be
converted to their devm_ variants. And devm_krealloc() can be used to
(re)alloc the buffer. When the driver unloads, this will also be free'd.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/light/adjd_s311.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 17dac8d0e11d..19d60d6986a1 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -230,8 +230,8 @@ static int adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct adjd_s311_data *data = iio_priv(indio_dev);
 
-	kfree(data->buffer);
-	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	data->buffer = devm_krealloc(indio_dev->dev.parent, data->buffer,
+				     indio_dev->scan_bytes, GFP_KERNEL);
 	if (data->buffer == NULL)
 		return -ENOMEM;
 
@@ -256,7 +256,6 @@ static int adjd_s311_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
 	indio_dev->info = &adjd_s311_info;
@@ -265,34 +264,12 @@ static int adjd_s311_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(adjd_s311_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	err = iio_triggered_buffer_setup(indio_dev, NULL,
-		adjd_s311_trigger_handler, NULL);
+	err = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      adjd_s311_trigger_handler, NULL);
 	if (err < 0)
 		return err;
 
-	err = iio_device_register(indio_dev);
-	if (err)
-		goto exit_unreg_buffer;
-
-	dev_info(&client->dev, "ADJD-S311 color sensor registered\n");
-
-	return 0;
-
-exit_unreg_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return err;
-}
-
-static int adjd_s311_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct adjd_s311_data *data = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	kfree(data->buffer);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id adjd_s311_id[] = {
@@ -306,7 +283,6 @@ static struct i2c_driver adjd_s311_driver = {
 		.name	= ADJD_S311_DRV_NAME,
 	},
 	.probe		= adjd_s311_probe,
-	.remove		= adjd_s311_remove,
 	.id_table	= adjd_s311_id,
 };
 module_i2c_driver(adjd_s311_driver);
-- 
2.31.1

