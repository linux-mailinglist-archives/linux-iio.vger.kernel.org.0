Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41A3312587
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBGPuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhBGPuJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BE3264E4F;
        Sun,  7 Feb 2021 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712931;
        bh=KJLlKOtM0Yd/Y5jsIx5IECmw7rNVCC2Q6uZxW60aPls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkL9FZA+arCWzd4rwBkCiyRB/H8Zz5sxHEGqmNxksnKHSjEgPJEdGWF0fNRz3WgJO
         xGgXbCaXZgyKDHj9QHLSEmQiUEEnP/JY+bdFhO5AzDdEonQva71Xlg4AgjUzWhR5Vq
         xdDC81HxK1wgY+8CkoWzk/x3tjXS/etPlBLvf4ZlpF0JSy74gkzpvtNUnbVOKN7XQM
         5kr2xcL4VRavAu9L/NdavsGMEVmU5DnuAfV5MefcUwiCdCMj/HOpI0/Fi6i12bpcJu
         KSJvvD2rNkfNLQloHIjUeBjlorNjiiHZoxQOIuVPMBAwbGnnq+iOrcSbVojilUtu+h
         zygT0hiIpOS6g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/24] staging:iio:cdc:ad7150: Handle variation in chan_spec across device and irq present or not
Date:   Sun,  7 Feb 2021 15:46:05 +0000
Message-Id: <20210207154623.433442-7-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The driver supports devices with different numbers of channels and
also can function without provision of an IRQ (with reduced features),
so this patch handles this cleanly by having multiple chan_spec
arrays and iio_info structures to pick between depending on what we
have.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 71 ++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 7ad9105e6b46..539beed1a511 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -51,6 +51,12 @@
 
 #define AD7150_CH_TIMEOUT_RECEDING		GENMASK(3, 0)
 #define AD7150_CH_TIMEOUT_APPROACHING		GENMASK(7, 4)
+
+enum {
+	AD7150,
+	AD7151,
+};
+
 /**
  * struct ad7150_chip_info - instance specific chip data
  * @client: i2c client for this device
@@ -447,9 +453,30 @@ static const struct iio_event_spec ad7150_events[] = {
 		.num_event_specs = ARRAY_SIZE(ad7150_events),	\
 	}
 
+#define AD7150_CAPACITANCE_CHAN_NO_IRQ(_chan)	{		\
+		.type = IIO_CAPACITANCE,			\
+		.indexed = 1,					\
+		.channel = _chan,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
+	}
+
 static const struct iio_chan_spec ad7150_channels[] = {
 	AD7150_CAPACITANCE_CHAN(0),
-	AD7150_CAPACITANCE_CHAN(1)
+	AD7150_CAPACITANCE_CHAN(1),
+};
+
+static const struct iio_chan_spec ad7150_channels_no_irq[] = {
+	AD7150_CAPACITANCE_CHAN_NO_IRQ(0),
+	AD7150_CAPACITANCE_CHAN_NO_IRQ(1),
+};
+
+static const struct iio_chan_spec ad7151_channels[] = {
+	AD7150_CAPACITANCE_CHAN(0),
+};
+
+static const struct iio_chan_spec ad7151_channels_no_irq[] = {
+	AD7150_CAPACITANCE_CHAN_NO_IRQ(0),
 };
 
 static irqreturn_t ad7150_event_handler(int irq, void *private)
@@ -532,6 +559,10 @@ static const struct iio_info ad7150_info = {
 	.write_event_value = &ad7150_write_event_value,
 };
 
+static const struct iio_info ad7150_info_no_irq = {
+	.read_raw = &ad7150_read_raw,
+};
+
 static int ad7150_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -550,14 +581,24 @@ static int ad7150_probe(struct i2c_client *client,
 	chip->client = client;
 
 	indio_dev->name = id->name;
-	indio_dev->channels = ad7150_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad7150_channels);
-
-	indio_dev->info = &ad7150_info;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (client->irq) {
+		indio_dev->info = &ad7150_info;
+		switch (id->driver_data) {
+		case AD7150:
+			indio_dev->channels = ad7150_channels;
+			indio_dev->num_channels = ARRAY_SIZE(ad7150_channels);
+			break;
+		case AD7151:
+			indio_dev->channels = ad7151_channels;
+			indio_dev->num_channels = ARRAY_SIZE(ad7151_channels);
+			break;
+		default:
+			return -EINVAL;
+		}
+
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL,
 						&ad7150_event_handler,
@@ -568,6 +609,20 @@ static int ad7150_probe(struct i2c_client *client,
 						indio_dev);
 		if (ret)
 			return ret;
+	} else {
+		indio_dev->info = &ad7150_info_no_irq;
+		switch (id->driver_data) {
+		case AD7150:
+			indio_dev->channels = ad7150_channels_no_irq;
+			indio_dev->num_channels = ARRAY_SIZE(ad7150_channels_no_irq);
+			break;
+		case AD7151:
+			indio_dev->channels = ad7151_channels_no_irq;
+			indio_dev->num_channels = ARRAY_SIZE(ad7151_channels_no_irq);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
@@ -581,9 +636,9 @@ static int ad7150_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ad7150_id[] = {
-	{ "ad7150", 0 },
-	{ "ad7151", 0 },
-	{ "ad7156", 0 },
+	{ "ad7150", AD7150 },
+	{ "ad7151", AD7151 },
+	{ "ad7156", AD7150 },
 	{}
 };
 
-- 
2.30.0

