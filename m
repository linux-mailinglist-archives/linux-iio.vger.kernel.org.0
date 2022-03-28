Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701584EA045
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344130AbiC1Tv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 15:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345662AbiC1TuF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 15:50:05 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DAE10D7
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 12:47:48 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F08B883F88;
        Mon, 28 Mar 2022 21:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648496865;
        bh=9jrh664qfiw72bIrsrVmq1NXWPiBuKVRN/VQgTvmpak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQM84J8QGWjLbgK76dePzdPsBrLJZgEmY2QQDPRssXSj8xNb0PrraWZEiXqWgaSTi
         7hPKahMv/CsiQRjslLyunT1VjcK55a9fYsW+Fs7FPyYtZpWYeepWbv0lfq/jCRUJbP
         s5qC/ULlXyJb7Ei2DvhEWhkXfTYyfSDemghPHXfxkLZtGq/oCZaz+uLMu7EXjd+ml7
         NrgI+u95zz8OI3uWuflo8VNDJbmoWBPe8476dl8qBWnTLoaoR7HrOjU5PVG/hVAJEE
         k295Cvhzs5U7BqLGdyZaRujsDEWgtTHVu3BuYbnA9hXcEFaR0Njnsulfj840ErTwDW
         xBCgsBO9mKuEw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 08/10] iio: adc: ti-ads1015: Convert to OF match data
Date:   Mon, 28 Mar 2022 21:47:23 +0200
Message-Id: <20220328194725.149150-8-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328194725.149150-1-marex@denx.de>
References: <20220328194725.149150-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace chip type enumeration in match data with pointer to static constant
structure which contains all the different chip properties in one place, and
then replace handling of chip type in probe() with simple copy of fields in
the new match data structure into struct iio_dev.

This reduces code and increases static data.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V3: New patch
V4: - Fix contains typo in commit message
    - Drop redundant cast of device_get_match_data()
    - Return dev_err_probe() if no valid chip data found
V5: Switch data_rate to signed int
---
 drivers/iio/adc/ti-ads1015.c | 110 +++++++++++++++++------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 73d848804a12d..5d9e9cdfe1c34 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -76,11 +76,12 @@
 #define ADS1015_DEFAULT_DATA_RATE	4
 #define ADS1015_DEFAULT_CHAN		0
 
-enum chip_ids {
-	ADSXXXX = 0,
-	ADS1015,
-	ADS1115,
-	TLA2024,
+struct ads1015_chip_data {
+	struct iio_chan_spec const	*channels;
+	int				num_channels;
+	const struct iio_info		*info;
+	const int			*data_rate;
+	bool				has_comparator;
 };
 
 enum ads1015_channels {
@@ -95,11 +96,11 @@ enum ads1015_channels {
 	ADS1015_TIMESTAMP,
 };
 
-static const unsigned int ads1015_data_rate[] = {
+static const int ads1015_data_rate[] = {
 	128, 250, 490, 920, 1600, 2400, 3300, 3300
 };
 
-static const unsigned int ads1115_data_rate[] = {
+static const int ads1115_data_rate[] = {
 	8, 16, 32, 64, 128, 250, 475, 860
 };
 
@@ -226,7 +227,7 @@ struct ads1015_data {
 	unsigned int comp_mode;
 	struct ads1015_thresh_data thresh_data[ADS1015_CHANNELS];
 
-	unsigned int *data_rate;
+	const int *data_rate;
 	/*
 	 * Set to true when the ADC is switched to the continuous-conversion
 	 * mode and exits from a power-down state.  This flag is used to avoid
@@ -961,12 +962,18 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
 static int ads1015_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	const struct ads1015_chip_data *chip;
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
 	int ret;
-	enum chip_ids chip;
 	int i;
 
+	chip = device_get_match_data(&client->dev);
+	if (!chip)
+		chip = (const struct ads1015_chip_data *)id->driver_data;
+	if (!chip)
+		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -979,34 +986,12 @@ static int ads1015_probe(struct i2c_client *client,
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	chip = (uintptr_t)device_get_match_data(&client->dev);
-	if (chip == ADSXXXX)
-		chip = id->driver_data;
-	switch (chip) {
-	case ADS1015:
-		indio_dev->channels = ads1015_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
-		indio_dev->info = &ads1015_info;
-		data->data_rate = (unsigned int *) &ads1015_data_rate;
-		break;
-	case ADS1115:
-		indio_dev->channels = ads1115_channels;
-		indio_dev->num_channels = ARRAY_SIZE(ads1115_channels);
-		indio_dev->info = &ads1115_info;
-		data->data_rate = (unsigned int *) &ads1115_data_rate;
-		break;
-	case TLA2024:
-		indio_dev->channels = tla2024_channels;
-		indio_dev->num_channels = ARRAY_SIZE(tla2024_channels);
-		indio_dev->info = &tla2024_info;
-		data->data_rate = (unsigned int *) &ads1015_data_rate;
-		break;
-	default:
-		dev_err(&client->dev, "Unknown chip %d\n", chip);
-		return -EINVAL;
-	}
-
+	indio_dev->channels = chip->channels;
+	indio_dev->num_channels = chip->num_channels;
+	indio_dev->info = chip->info;
+	data->data_rate = chip->data_rate;
 	data->event_channel = ADS1015_CHANNELS;
+
 	/*
 	 * Set default lower and upper threshold to min and max value
 	 * respectively.
@@ -1021,9 +1006,9 @@ static int ads1015_probe(struct i2c_client *client,
 	/* we need to keep this ABI the same as used by hwmon ADS1015 driver */
 	ads1015_get_channels_config(client);
 
-	data->regmap = devm_regmap_init_i2c(client, (chip == TLA2024) ?
-					    &tla2024_regmap_config :
-					    &ads1015_regmap_config);
+	data->regmap = devm_regmap_init_i2c(client, chip->has_comparator ?
+					    &ads1015_regmap_config :
+					    &tla2024_regmap_config);
 	if (IS_ERR(data->regmap)) {
 		dev_err(&client->dev, "Failed to allocate register map\n");
 		return PTR_ERR(data->regmap);
@@ -1037,7 +1022,7 @@ static int ads1015_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (client->irq && chip != TLA2024) {
+	if (client->irq && chip->has_comparator) {
 		unsigned long irq_trig =
 			irqd_get_trigger_type(irq_get_irq_data(client->irq));
 		unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
@@ -1136,27 +1121,42 @@ static const struct dev_pm_ops ads1015_pm_ops = {
 			   ads1015_runtime_resume, NULL)
 };
 
+static const struct ads1015_chip_data ads1015_data = {
+	.channels	= ads1015_channels,
+	.num_channels	= ARRAY_SIZE(ads1015_channels),
+	.info		= &ads1015_info,
+	.data_rate	= ads1015_data_rate,
+	.has_comparator	= true,
+};
+
+static const struct ads1015_chip_data ads1115_data = {
+	.channels	= ads1115_channels,
+	.num_channels	= ARRAY_SIZE(ads1115_channels),
+	.info		= &ads1115_info,
+	.data_rate	= ads1115_data_rate,
+	.has_comparator	= true,
+};
+
+static const struct ads1015_chip_data tla2024_data = {
+	.channels	= tla2024_channels,
+	.num_channels	= ARRAY_SIZE(tla2024_channels),
+	.info		= &tla2024_info,
+	.data_rate	= ads1015_data_rate,
+	.has_comparator	= false,
+};
+
 static const struct i2c_device_id ads1015_id[] = {
-	{"ads1015", ADS1015},
-	{"ads1115", ADS1115},
-	{"tla2024", TLA2024},
+	{ "ads1015", (kernel_ulong_t)&ads1015_data },
+	{ "ads1115", (kernel_ulong_t)&ads1115_data },
+	{ "tla2024", (kernel_ulong_t)&tla2024_data },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ads1015_id);
 
 static const struct of_device_id ads1015_of_match[] = {
-	{
-		.compatible = "ti,ads1015",
-		.data = (void *)ADS1015
-	},
-	{
-		.compatible = "ti,ads1115",
-		.data = (void *)ADS1115
-	},
-	{
-		.compatible = "ti,tla2024",
-		.data = (void *)TLA2024
-	},
+	{ .compatible = "ti,ads1015", .data = &ads1015_data },
+	{ .compatible = "ti,ads1115", .data = &ads1115_data },
+	{ .compatible = "ti,tla2024", .data = &tla2024_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ads1015_of_match);
-- 
2.35.1

