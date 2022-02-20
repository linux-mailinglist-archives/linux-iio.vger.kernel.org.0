Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D84BCBBF
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 03:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbiBTCrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Feb 2022 21:47:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243334AbiBTCrF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Feb 2022 21:47:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61571BC27;
        Sat, 19 Feb 2022 18:46:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gf13-20020a17090ac7cd00b001bbfb9d760eso2110462pjb.2;
        Sat, 19 Feb 2022 18:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udPMv+VfuCnMjB/kHyzLTWqno3DIHk+LRs09KfjMc5M=;
        b=PZc+xDICWto09udixdARaogVrIOXYXJiJo/aud0LZR2P7CSQAfI+JBniH8Ntrl/nos
         BVc1yFXr+wc6fn1qGObAgT7IFXsPY0mIRwHxhdxUgdOYpFTgpCsDHwOVNaVxAZo3B/5d
         MzAXpTSgh4mLvP64HvKzGm5wuY7ZtzdcknMOknqD7SWM6lamcRAR/L1rQcjuHkpZxqD0
         emgkHCeLLwPKSE1Dru5KVS1pn0OcL9P9nisi3e2DHF4UjqfWyuvU6OD2yNVCzgVtgcw0
         SWKyf2CrLfT4/sIJpkKOyi5qhT1uWCM3V6cpwX1tewdPqJAwle41iuGYcc9tdDNs2nNn
         zqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udPMv+VfuCnMjB/kHyzLTWqno3DIHk+LRs09KfjMc5M=;
        b=TbEGa7JPyG+YYX7OW8VCZQEyQMOw6/bkVPoP7V8sPcMxaXVfCcdmLILjtcgCJ65vS2
         5m+vBSLt6acSQjqajKaR7n2Ajhb1awv9ABB21pk/TLGKyX6wdNrBUsGGOAfegtdosa/T
         1y952cYpbuHFCNMYbldzkOkF/HLxwtXzB9+tth5sJI3kiK4q0ZsLuD3AG9W/j9o0bd7y
         u1aplZSpptuc2jAg3JsWlN0aY+Z0nH1X3+MkADkdvC3axs50liHj6Fmkv2sZrMk9qPQR
         IfEFbZXttu6alP95GPsWjdBU+Q0CHr6il9HqzXz/tbdBGBUo7Rh1Oq/hufOU0kKYMo3a
         rDJQ==
X-Gm-Message-State: AOAM533x5ws18aglL794wl+c9JheTFSjga5luoqtgHVgZhsF0fNh5piz
        qQ8nfqibOIZAW5hVyFVW1co=
X-Google-Smtp-Source: ABdhPJyNdx5E/hEt3f2mO+HKsovgFQnGWonopsKFVT7n5HjpGgxIUehBeGC9rbfWTLv/AyYnR7Bd6Q==
X-Received: by 2002:a17:902:db05:b0:14d:743f:5162 with SMTP id m5-20020a170902db0500b0014d743f5162mr13531374plx.12.1645325204809;
        Sat, 19 Feb 2022 18:46:44 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:44 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] iio: potentiometer: Add channel information in device data
Date:   Sun, 20 Feb 2022 08:16:28 +0530
Message-Id: <20220220024632.4183-4-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220220024632.4183-1-jagathjog1996@gmail.com>
References: <20220220024632.4183-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding each device wiper count and channel information into
device private data.
Utilizing addr member of struct iio_chan_spec to get the
wiper register address so that the value can be read or write
to the same address.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/potentiometer/ds1803.c | 33 ++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index c9cf7181cb7f..cf822e21284e 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -16,7 +16,8 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 
-#define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
+#define DS1803_WIPER_0         0xA9
+#define DS1803_WIPER_1         0xAA
 
 enum ds1803_type {
 	DS1803_010,
@@ -25,8 +26,11 @@ enum ds1803_type {
 };
 
 struct ds1803_cfg {
+	int wipers;
 	int avail[3];
 	int kohms;
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
 };
 
 struct ds1803_data {
@@ -34,25 +38,32 @@ struct ds1803_data {
 	const struct ds1803_cfg *cfg;
 };
 
-#define DS1803_CHANNEL(ch) {						\
+#define DS1803_CHANNEL(ch, addr) {					\
 	.type = IIO_RESISTANCE,						\
 	.indexed = 1,							\
 	.output = 1,							\
 	.channel = (ch),						\
+	.address = (addr),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),   \
 }
 
 static const struct iio_chan_spec ds1803_channels[] = {
-	DS1803_CHANNEL(0),
-	DS1803_CHANNEL(1),
+	DS1803_CHANNEL(0, DS1803_WIPER_0),
+	DS1803_CHANNEL(1, DS1803_WIPER_1),
 };
 
 static const struct ds1803_cfg ds1803_cfg[] = {
-	[DS1803_010] = { .avail = { 0, 1, 255 }, .kohms =  10, },
-	[DS1803_050] = { .avail = { 0, 1, 255 }, .kohms =  50, },
-	[DS1803_100] = { .avail = { 0, 1, 255 }, .kohms = 100, },
+	[DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
+	[DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
+			 .channels = ds1803_channels,
+			 .num_channels = ARRAY_SIZE(ds1803_channels) },
 };
 
 static int ds1803_read_raw(struct iio_dev *indio_dev,
@@ -88,7 +99,7 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
-	int pot = chan->channel;
+	u8 addr = chan->address;
 	int max_pos = data->cfg->avail[2];
 
 	if (val2 != 0)
@@ -103,7 +114,7 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
+	return i2c_smbus_write_byte_data(data->client, addr, val);
 }
 
 static int ds1803_read_avail(struct iio_dev *indio_dev,
@@ -146,8 +157,8 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
 	data->cfg = &ds1803_cfg[id->driver_data];
 
 	indio_dev->info = &ds1803_info;
-	indio_dev->channels = ds1803_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ds1803_channels);
+	indio_dev->channels = data->cfg->channels;
+	indio_dev->num_channels = data->cfg->num_channels;
 	indio_dev->name = client->name;
 
 	return devm_iio_device_register(dev, indio_dev);
-- 
2.17.1

