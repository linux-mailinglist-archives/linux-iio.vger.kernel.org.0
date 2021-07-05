Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C13BB79C
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhGEHRv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 03:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhGEHRu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 03:17:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6CC061760
        for <linux-iio@vger.kernel.org>; Mon,  5 Jul 2021 00:15:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c17so27620027ejk.13
        for <linux-iio@vger.kernel.org>; Mon, 05 Jul 2021 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTNWzt+bQ/3KJXR2+DVpG8lU0JhxqInwNEwj4YwSjD0=;
        b=uT16I0y0ncZWGPFh9B7NsTiY8jactbBVJVZdrJYHvlehbyxOXT4Dw7zNkF7Y9CnIds
         +jmVwrGHlRk056xLoayucTKW575VR/KM97zS92ym4H+2uFzmeS1NXJAWEqUaid2o/pFb
         dTxey9zcvM3cdr0vLXfWAUt8q5JJnb9elSED15IK5nD2WUFkB1jFm1S5r1R9dR80FQo8
         oM4rYM5LaNBiiu1TVP6r4JKH+jnbaZE4qUU1G96VYfUSdpEFVyxEndk2T4r/B54ed86E
         7nAjGbNaPKxTpZ9aJelAGeF46UVtyFR1tjdJu2HIfgcxEbWJ77bKC5MwaTqIv4/eeKrD
         QvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTNWzt+bQ/3KJXR2+DVpG8lU0JhxqInwNEwj4YwSjD0=;
        b=UISTkOdIUBQhNByTjJAnqiE4tCm4eX67EaDa0tlU/X+ZyfINd/IYEJ/C0Q3Kf2zHFk
         ZIdnNOYZqcPsXwtTI+naDTPyN1TDKtSQxYab/tG/6nRKsaeUtsgUB/Kga4nK4z9lGn6n
         KldK6YEbYH9/ZNqSkfhYapnYRKL0rmg3sIb57NjL2v4edoZaN3/OOyYKu287ep6NMSNl
         NE4KlOzLZ8pqXTNzRSdggtiJcOAfxBZBz2PAK6a26vs1PquJVcLtC0Hhrg2aZ3EgPx9g
         QG1BcfB3mJqxXB+GFadqK5cF5lKVg2XR9pGOwLc1Vp2h/HjOFwIEYve96W2RotqVX+qG
         GB/Q==
X-Gm-Message-State: AOAM533THXug/MB8AI1/XJEf1VFfz7uEHxMWKAYsEP+2dITrAjCdOnPb
        Jx2R6MQuVlHSBJgx/vD7dAGh0LMI0+RM4JpQ
X-Google-Smtp-Source: ABdhPJyDVhhrY75NoLigaGDKjjBgPTxA5/C6r+ftvolFLfq5Vp7p/UM6UecuZPCT6GUluH74E2mIxA==
X-Received: by 2002:a17:907:97c7:: with SMTP id js7mr12091009ejc.59.1625469309929;
        Mon, 05 Jul 2021 00:15:09 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id n22sm3973823eje.3.2021.07.05.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:15:09 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v2 2/2] iio: light: adjd_s311: convert probe to device-managed functions
Date:   Mon,  5 Jul 2021 10:14:56 +0300
Message-Id: <20210705071456.649659-2-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705071456.649659-1-aardelean@deviqon.com>
References: <20210705071456.649659-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Now that the driver's buffer is stored on the adjd_s311_data private
object, the driver is a simple conversion to use only device-managed
functions in the probe.

The iio_triggered_buffer_setup() and iio_device_register() functions are
the only ones needing conversion.
And i2c_set_clientdata() is no longer required.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/light/adjd_s311.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index caf852554897..6b33975c8d73 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -245,7 +245,6 @@ static int adjd_s311_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
 	indio_dev->info = &adjd_s311_info;
@@ -254,32 +253,12 @@ static int adjd_s311_probe(struct i2c_client *client,
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
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
 static const struct i2c_device_id adjd_s311_id[] = {
@@ -293,7 +272,6 @@ static struct i2c_driver adjd_s311_driver = {
 		.name	= ADJD_S311_DRV_NAME,
 	},
 	.probe		= adjd_s311_probe,
-	.remove		= adjd_s311_remove,
 	.id_table	= adjd_s311_id,
 };
 module_i2c_driver(adjd_s311_driver);
-- 
2.31.1

