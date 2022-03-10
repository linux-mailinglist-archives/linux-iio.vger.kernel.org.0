Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACADE4D3E37
	for <lists+linux-iio@lfdr.de>; Thu, 10 Mar 2022 01:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiCJAf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Mar 2022 19:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiCJAfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2022 19:35:25 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD875710D2
        for <linux-iio@vger.kernel.org>; Wed,  9 Mar 2022 16:34:25 -0800 (PST)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CBF6D839B8;
        Thu, 10 Mar 2022 01:34:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1646872462;
        bh=TKf3nwEYL0GDhiFVQ0QRriE30KX2aOKeMvJgh5HSnuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhShN3pHZTFHzoz+5N2gc4e8fUuC4apyv63jYVgU0VNiD9NXXLyiLo5zr+WPrD5ph
         0Pt4VFCpf3UcMxUklUpcHuZ/KItK20ZgcTXPDKJ9Aax6ZLA0qiXKta79KxHMYA6qeF
         xX9ZLrKph9EFpUwYmeE0N81tx5/mhZUvTWZVSFUn513iOaqOpqioNEOTCDa6NShca7
         3pg4lLbh1tEtpaqKWz7JrD4gZ03InOc/pg9bJ9c7/pjXGa+iDBx0QnmFzijERsh5Hq
         Znc16iwmKGrjf7dWNWim9XNwz+ViuvHmJ25I/ainSVkxEl1cZToSZNj+FQ5lGn98aE
         mfbJZYk9GUqzw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/6] iio: adc: ti-ads1015: Add TLA2024 support
Date:   Thu, 10 Mar 2022 01:34:02 +0100
Message-Id: <20220310003402.490478-6-marex@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310003402.490478-1-marex@denx.de>
References: <20220310003402.490478-1-marex@denx.de>
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

Add support for TI TLA2024 ADC. This chip is compatible with ADS1015
except it has no comparator in it, hence the comparator configuration
bits are missing in Configuration Register and the Hi_Thresh/Lo_Thresh
registers are missing as well and so is event support.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1015.c | 53 ++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 7d0c0552f425c..dd36fe0a45cba 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -80,6 +80,7 @@ enum chip_ids {
 	ADSXXXX = 0,
 	ADS1015,
 	ADS1115,
+	TLA2024,
 };
 
 enum ads1015_channels {
@@ -247,6 +248,22 @@ static const struct regmap_config ads1015_regmap_config = {
 	.wr_table = &ads1015_writeable_table,
 };
 
+static const struct regmap_range tla2024_writeable_ranges[] = {
+	regmap_reg_range(ADS1015_CFG_REG, ADS1015_CFG_REG),
+};
+
+static const struct regmap_access_table tla2024_writeable_table = {
+	.yes_ranges = tla2024_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(tla2024_writeable_ranges),
+};
+
+static const struct regmap_config tla2024_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = ADS1015_CFG_REG,
+	.wr_table = &tla2024_writeable_table,
+};
+
 static const struct iio_chan_spec ads1015_channels[] = {
 	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 12, 4,
 			    ads1015_events, ARRAY_SIZE(ads1015_events)),
@@ -287,6 +304,19 @@ static const struct iio_chan_spec ads1115_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
+static const struct iio_chan_spec tla2024_channels[] = {
+	ADS1015_V_DIFF_CHAN(0, 1, ADS1015_AIN0_AIN1, 12, 4, NULL, 0),
+	ADS1015_V_DIFF_CHAN(0, 3, ADS1015_AIN0_AIN3, 12, 4, NULL, 0),
+	ADS1015_V_DIFF_CHAN(1, 3, ADS1015_AIN1_AIN3, 12, 4, NULL, 0),
+	ADS1015_V_DIFF_CHAN(2, 3, ADS1015_AIN2_AIN3, 12, 4, NULL, 0),
+	ADS1015_V_CHAN(0, ADS1015_AIN0, 12, 4, NULL, 0),
+	ADS1015_V_CHAN(1, ADS1015_AIN1, 12, 4, NULL, 0),
+	ADS1015_V_CHAN(2, ADS1015_AIN2, 12, 4, NULL, 0),
+	ADS1015_V_CHAN(3, ADS1015_AIN3, 12, 4, NULL, 0),
+	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
+};
+
+
 #ifdef CONFIG_PM
 static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 {
@@ -823,6 +853,12 @@ static const struct iio_info ads1115_info = {
 	.attrs          = &ads1115_attribute_group,
 };
 
+static const struct iio_info tla2024_info = {
+	.read_raw	= ads1015_read_raw,
+	.write_raw	= ads1015_write_raw,
+	.attrs          = &ads1115_attribute_group,
+};
+
 static int ads1015_client_get_channels_config(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
@@ -937,6 +973,12 @@ static int ads1015_probe(struct i2c_client *client,
 		indio_dev->info = &ads1115_info;
 		data->data_rate = (unsigned int *) &ads1115_data_rate;
 		break;
+	case TLA2024:
+		indio_dev->channels = tla2024_channels;
+		indio_dev->num_channels = ARRAY_SIZE(tla2024_channels);
+		indio_dev->info = &tla2024_info;
+		data->data_rate = (unsigned int *) &ads1015_data_rate;
+		break;
 	default:
 		dev_err(&client->dev, "Unknown chip %d\n", chip);
 		return -EINVAL;
@@ -957,7 +999,9 @@ static int ads1015_probe(struct i2c_client *client,
 	/* we need to keep this ABI the same as used by hwmon ADS1015 driver */
 	ads1015_get_channels_config(client);
 
-	data->regmap = devm_regmap_init_i2c(client, &ads1015_regmap_config);
+	data->regmap = devm_regmap_init_i2c(client, (chip == TLA2024) ?
+					    &tla2024_regmap_config :
+					    &ads1015_regmap_config);
 	if (IS_ERR(data->regmap)) {
 		dev_err(&client->dev, "Failed to allocate register map\n");
 		return PTR_ERR(data->regmap);
@@ -971,7 +1015,7 @@ static int ads1015_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (client->irq) {
+	if (client->irq && chip != TLA2024) {
 		unsigned long irq_trig =
 			irqd_get_trigger_type(irq_get_irq_data(client->irq));
 		unsigned int cfg_comp_mask = ADS1015_CFG_COMP_QUE_MASK |
@@ -1073,6 +1117,7 @@ static const struct dev_pm_ops ads1015_pm_ops = {
 static const struct i2c_device_id ads1015_id[] = {
 	{"ads1015", ADS1015},
 	{"ads1115", ADS1115},
+	{"tla2024", TLA2024},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ads1015_id);
@@ -1086,6 +1131,10 @@ static const struct of_device_id ads1015_of_match[] = {
 		.compatible = "ti,ads1115",
 		.data = (void *)ADS1115
 	},
+	{
+		.compatible = "ti,tla2024",
+		.data = (void *)TLA2024
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, ads1015_of_match);
-- 
2.34.1

