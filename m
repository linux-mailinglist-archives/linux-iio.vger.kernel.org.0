Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951732F044C
	for <lists+linux-iio@lfdr.de>; Sun, 10 Jan 2021 00:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbhAIXNY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 18:13:24 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46633 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbhAIXNX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2021 18:13:23 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7D8DE1C0003;
        Sat,  9 Jan 2021 23:12:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/6] iio:pressure:ms5637: introduce hardware differentiation
Date:   Sun, 10 Jan 2021 00:11:44 +0100
Message-Id: <20210109231148.1168104-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
References: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some sensors in the ms58xx family have a different PROM length and a
different number of available resolution. introduce struct ms_tp_hw_data to
handle those differences.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
Changes in v2:
 - handle the i2c_device_table

 .../iio/common/ms_sensors/ms_sensors_i2c.h    | 11 ++++
 drivers/iio/pressure/ms5637.c                 | 50 +++++++++++++++----
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
index bad09c80e47a..f4a88148c113 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
@@ -25,6 +25,16 @@ struct ms_ht_dev {
 	u8 res_index;
 };
 
+/**
+ * struct ms_hw_data - Temperature/Pressure sensor hardware data
+ * @prom_len:		number of words in the PROM
+ * @max_res_index:	maximum sensor resolution index
+ */
+struct ms_tp_hw_data {
+	u8 prom_len;
+	u8 max_res_index;
+};
+
 /**
  * struct ms_tp_dev - Temperature/Pressure sensor device structure
  * @client:	i2c client
@@ -36,6 +46,7 @@ struct ms_ht_dev {
 struct ms_tp_dev {
 	struct i2c_client *client;
 	struct mutex lock;
+	const struct ms_tp_hw_data *hw;
 	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB + 1];
 	u8 res_index;
 };
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 5b59a4137d32..fdd557ac71a3 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -30,6 +30,11 @@
 
 #include "../common/ms_sensors/ms_sensors_i2c.h"
 
+struct ms_tp_data {
+	const char *name;
+	const struct ms_tp_hw_data *hw;
+};
+
 static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
 /* String copy of the above const for readability purpose */
 static const char ms5637_show_samp_freq[] = "960 480 240 120 60 30";
@@ -129,6 +134,7 @@ static const struct iio_info ms5637_info = {
 static int ms5637_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	const struct ms_tp_data *data;
 	struct ms_tp_dev *dev_data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -142,17 +148,25 @@ static int ms5637_probe(struct i2c_client *client,
 		return -EOPNOTSUPP;
 	}
 
+	if (id)
+		data = (const struct ms_tp_data *)id->driver_data;
+	else
+		data = device_get_match_data(&client->dev);
+	if (!data)
+		return -EINVAL;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	dev_data = iio_priv(indio_dev);
 	dev_data->client = client;
-	dev_data->res_index = 5;
+	dev_data->res_index = data->hw->max_res_index;
+	dev_data->hw = data->hw;
 	mutex_init(&dev_data->lock);
 
 	indio_dev->info = &ms5637_info;
-	indio_dev->name = id->name;
+	indio_dev->name = data->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ms5637_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ms5637_channels);
@@ -170,20 +184,36 @@ static int ms5637_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct ms_tp_hw_data ms5637_hw_data  = {
+	.prom_len = 7,
+	.max_res_index = 5
+};
+
+static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
+
+static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
+
+static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
+
+static const struct ms_tp_data ms8607_data = {
+	.name = "ms8607-temppressure",
+	.hw = &ms5637_hw_data,
+};
+
 static const struct i2c_device_id ms5637_id[] = {
-	{"ms5637", 0},
-	{"ms5805", 0},
-	{"ms5837", 0},
-	{"ms8607-temppressure", 0},
+	{"ms5637", (kernel_ulong_t)&ms5637_data },
+	{"ms5805", (kernel_ulong_t)&ms5805_data },
+	{"ms5837", (kernel_ulong_t)&ms5837_data },
+	{"ms8607-temppressure", (kernel_ulong_t)&ms8607_data },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ms5637_id);
 
 static const struct of_device_id ms5637_of_match[] = {
-	{ .compatible = "meas,ms5637", },
-	{ .compatible = "meas,ms5805", },
-	{ .compatible = "meas,ms5837", },
-	{ .compatible = "meas,ms8607-temppressure", },
+	{ .compatible = "meas,ms5637", .data = &ms5637_data },
+	{ .compatible = "meas,ms5805", .data = &ms5805_data },
+	{ .compatible = "meas,ms5837", .data = &ms5837_data },
+	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ms5637_of_match);
-- 
2.29.2

