Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88A781258
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 19:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378954AbjHRRti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379309AbjHRRtT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 13:49:19 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6214826A8;
        Fri, 18 Aug 2023 10:49:18 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,183,1684767600"; 
   d="scan'208";a="173294995"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Aug 2023 02:49:17 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B6EA04006DEE;
        Sat, 19 Aug 2023 02:49:14 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/2] iio: dac: mcp4725: Use i2c_get_match_data()
Date:   Fri, 18 Aug 2023 18:49:05 +0100
Message-Id: <20230818174905.324623-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818174905.324623-1-biju.das.jz@bp.renesas.com>
References: <20230818174905.324623-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace local variable chip_id with struct iio_chan_spec for device data
and use its .ext_info for chip identification. After this replace
device_get_match_data() and id lookup for retrieving match data
by i2c_get_match_data() by converting enum->pointer for data in the
match table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/iio/dac/mcp4725.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 33a61f65bc25..f9ce01c4cc53 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -386,7 +386,7 @@ static int mcp4725_probe(struct i2c_client *client)
 	struct mcp4725_data *data;
 	struct iio_dev *indio_dev;
 	struct mcp4725_platform_data *pdata, pdata_dt;
-	int chip_id;
+	const struct iio_chan_spec *ch;
 	u8 inbuf[4];
 	u8 pd;
 	u8 ref;
@@ -398,10 +398,8 @@ static int mcp4725_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	if (dev_fwnode(&client->dev))
-		chip_id = (uintptr_t)device_get_match_data(&client->dev);
-	else
-		chip_id = id->driver_data;
+	ch = i2c_get_match_data(client);
+
 	pdata = dev_get_platdata(&client->dev);
 
 	if (!pdata) {
@@ -414,7 +412,7 @@ static int mcp4725_probe(struct i2c_client *client)
 		pdata = &pdata_dt;
 	}
 
-	if (chip_id == MCP4725 && pdata->use_vref) {
+	if (ch->ext_info == mcp4725_ext_info && pdata->use_vref) {
 		dev_err(&client->dev,
 			"external reference is unavailable on MCP4725");
 		return -EINVAL;
@@ -455,12 +453,12 @@ static int mcp4725_probe(struct i2c_client *client)
 
 	indio_dev->name = id->name;
 	indio_dev->info = &mcp4725_info;
-	indio_dev->channels = &mcp472x_channel[chip_id];
+	indio_dev->channels = ch;
 	indio_dev->num_channels = 1;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* read current DAC value and settings */
-	err = i2c_master_recv(client, inbuf, chip_id == MCP4725 ? 3 : 4);
+	err = i2c_master_recv(client, inbuf, ch->ext_info == mcp4725_ext_info ? 3 : 4);
 
 	if (err < 0) {
 		dev_err(&client->dev, "failed to read DAC value");
@@ -470,10 +468,10 @@ static int mcp4725_probe(struct i2c_client *client)
 	data->powerdown = pd > 0;
 	data->powerdown_mode = pd ? pd - 1 : 2; /* largest resistor to gnd */
 	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
-	if (chip_id == MCP4726)
+	if (ch->ext_info == mcp4726_ext_info)
 		ref = (inbuf[3] >> 3) & 0x3;
 
-	if (chip_id == MCP4726 && ref != data->ref_mode) {
+	if (ch->ext_info == mcp4726_ext_info && ref != data->ref_mode) {
 		dev_info(&client->dev,
 			"voltage reference mode differs (conf: %u, eeprom: %u), setting %u",
 			data->ref_mode, ref, data->ref_mode);
@@ -511,8 +509,8 @@ static void mcp4725_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp4725_id[] = {
-	{ "mcp4725", MCP4725 },
-	{ "mcp4726", MCP4726 },
+	{ "mcp4725", (kernel_ulong_t)&mcp472x_channel[MCP4725] },
+	{ "mcp4726", (kernel_ulong_t)&mcp472x_channel[MCP4726] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4725_id);
@@ -520,11 +518,11 @@ MODULE_DEVICE_TABLE(i2c, mcp4725_id);
 static const struct of_device_id mcp4725_of_match[] = {
 	{
 		.compatible = "microchip,mcp4725",
-		.data = (void *)MCP4725
+		.data = &mcp472x_channel[MCP4725]
 	},
 	{
 		.compatible = "microchip,mcp4726",
-		.data = (void *)MCP4726
+		.data = &mcp472x_channel[MCP4726]
 	},
 	{ }
 };
-- 
2.25.1

