Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BAC4C18BC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Feb 2022 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbiBWQgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Feb 2022 11:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiBWQgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Feb 2022 11:36:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A1254BCE;
        Wed, 23 Feb 2022 08:35:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w2so3625599pfu.11;
        Wed, 23 Feb 2022 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=An4kRmIkXBZ2c6ClQNkLaUl2i0QTZVDwlsSpiNK0iJg=;
        b=ipp6RsDospPHUs7/0gvlkaW8uvB30RVtz5zdDeDloh4ZjTeIWNrmRmXL1RG85ipSsR
         0Hjy36WY0xL00nJUaXHLRtD5YC9h3PgalSuXh6bWTPzA2iz3/FJZBJFXWQWvDghzzLHO
         7do20Zcy3+F/0Ir2UWks9YI2BFYeddUItTiqWSB6YOBcKhg3nDX/IgHgEn86tyYlLDhh
         wVDylvCcAtgiDAPl+Y1v7qY+Vl86Vq5mmjy3LXll1VHOv3R54WB0IhiBl6oS3eyWF6mV
         QlOjyk99CiPHOa/Kdz7gYYddSXzOopbW1P/tILx9qGvoWkvqEnoRebkVXl+srZJK7LgQ
         3g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=An4kRmIkXBZ2c6ClQNkLaUl2i0QTZVDwlsSpiNK0iJg=;
        b=YEzMTDcPSjHQAsggzdLyAlzaWSk9QyVt/kAklkS2VpyiPGGK8jZkxcKQU6hoGOjG+Z
         nE9rp3PPYsLLIFvPcrPcX82+2ry8ZSmWywZgYP3R18Oj7Iq/IgEhyZkBFpDyCWdHODwU
         NJ8YBg9UbDZa8t0iXk1ivpaCIfxJeAh3c4eBp/hK544NkZFujNtRA51y8GssJqIG3pk/
         0+a0nOhyNJFBSydtBpwU8wuleKo9KTehCDGyhSwHMmvpcEQDzO2oyguIYPQACJGtY/lY
         iZyDEaV+f7qyG7e6NUeA0cWS3GPkovg7klraGhuDHVx6Nyvkz3TM6aiJCHavzEvbktJF
         djSQ==
X-Gm-Message-State: AOAM533ws53rv8VNIQoOls2KNNNy4dJefjV8hwXXf8Sx4yGHNvU5+pig
        DyzVMY9Nd0yKFIs7xx+JGu5JsOJUV1PXg4Jb
X-Google-Smtp-Source: ABdhPJzHV+NtemqyrTfpHJCDSBbpqSQQ/yLKVONEmrko3Nbua5k81GSMttZM4+S/y96f4/FTyiqDjQ==
X-Received: by 2002:aa7:8f33:0:b0:4cb:95a7:928c with SMTP id y19-20020aa78f33000000b004cb95a7928cmr203680pfr.42.1645634142180;
        Wed, 23 Feb 2022 08:35:42 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:41 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/7] iio: potentiometer: Add channel information in device data
Date:   Wed, 23 Feb 2022 22:05:21 +0530
Message-Id: <20220223163525.13399-4-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163525.13399-1-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
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
 drivers/iio/potentiometer/ds1803.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index 9610269bed7f..f93cd342e09a 100644
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
@@ -34,33 +38,43 @@ struct ds1803_data {
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
 	[DS1803_010] = {
+	  .wipers = 2,
 	  .avail = { 0, 1, 255 },
 	  .kohms =  10,
+	  .channels = ds1803_channels,
+	  .num_channels = ARRAY_SIZE(ds1803_channels),
 	},
 	[DS1803_050] = {
+	  .wipers = 2,
 	  .avail = { 0, 1, 255 },
 	  .kohms =  50,
+	  .channels = ds1803_channels,
+	  .num_channels = ARRAY_SIZE(ds1803_channels),
 	},
 	[DS1803_100] = {
+	  .wipers = 2,
 	  .avail = { 0, 1, 255 },
 	  .kohms = 100,
+	  .channels = ds1803_channels,
+	  .num_channels = ARRAY_SIZE(ds1803_channels),
 	},
 };
 
@@ -97,7 +111,7 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct ds1803_data *data = iio_priv(indio_dev);
-	int pot = chan->channel;
+	u8 addr = chan->address;
 	int max_pos = data->cfg->avail[2];
 
 	if (val2 != 0)
@@ -112,7 +126,7 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
+	return i2c_smbus_write_byte_data(data->client, addr, val);
 }
 
 static int ds1803_read_avail(struct iio_dev *indio_dev,
@@ -155,8 +169,8 @@ static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *i
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

