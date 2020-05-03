Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAA1C2E54
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgECRWp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:22:45 -0400
Received: from mail-co1nam11olkn2023.outbound.protection.outlook.com ([40.92.18.23]:5344
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729034AbgECRWo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:22:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAjj+TuaxCM5FW0RhJM2aVH6SOH1iIRovSnxVb4iQ+wspPMrTtubSFbeH/wR7BWh64kOPpQ53rnnOmArxAjyJDAHjHK6hjvMIKcI4tr6VEqM5reV/Dm3MwZv5UVzhi1gBrdv+jFCMXkHis7rjUEkQDaLp1cOgE4tWIcxogQJRIlthJ4VzuM+3aXDqYn3lpLU23UAUeBvaCUnd15R1sUE+okx7s3/GLGxQdj5OHuFlJQ/X4fJbGcFngwdt3qGPKonpNGEHil5eu8NtndnF+Zf3kRIUAvlIPuSeu7PkeADwgKX1ar5MqwpK8QwG121XUMi37Olm/X7HvePpT7z/VWcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/MmYOPjg/1mqAt/4g5mblgPnyuJfrphEqjq3uD8EZ4=;
 b=gZtk58OeWAxvpXyBUKlKwbkr+J24HhzZbaKkzpcLI3D1QgOXu3KFqlFin61Tax8zw0jrX6NWkrsoj8EMOdIpChm/zTYTHbdxWBVIgO1Bz/KnhGJ+sOp8zAUpoJCOUjtAi5Thl6uxeOs7Afel+HjYPVNfxjMzwBkXA2i+aGC1mNP+0Re25HwIs+4CvjR0p5v4Gi5kYRK3bb+y/YP6DS30SWO4M/15TAesRnPTb2TOujhH+yky0PtCFNqDLYW4ZD0KWMmeFNcezEKIcyOoSEfCwZfwQqQ8imSsuUHNL079bxQFXi7Cxmt5Agc9Hjm1843Sr7TFoVR5QijsYrQk5bvZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::50) by
 BN8NAM11HT193.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::377)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sun, 3 May
 2020 17:22:40 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::42) by BN8NAM11FT054.mail.protection.outlook.com
 (2a01:111:e400:fc4b::358) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sun, 3 May 2020 17:22:40 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D2239007F86E46457BEF9BBC2D387467E9F4266C299FB20647FB256916119525;UpperCasedChecksum:05B4ECECBBE3DF41BE2A2F588B333F9EFBBFE54EA0A936305870A3197A774360;SizeAsReceived:8002;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Sun, 3 May 2020
 17:22:40 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-input@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 5/5] iio: accel: bma180: Add support for bma023
Date:   Sun,  3 May 2020 10:22:06 -0700
Message-ID: <BN6PR04MB0660C583D9538853C8296398A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200503172206.13782-1-xc-racer2@live.ca>
References: <20200503172206.13782-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200503172206.13782-6-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0047.namprd14.prod.outlook.com (2603:10b6:300:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Sun, 3 May 2020 17:22:38 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200503172206.13782-6-xc-racer2@live.ca>
X-TMN:  [9Gw8yqnRbLq4Ijkx+rI4zEJGhtzHfOnHAbhn0iNMf3v0D3KhQGKQb0LXxYKaJUXc]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4103f88c-8019-4c35-eae8-08d7ef86950c
X-MS-TrafficTypeDiagnostic: BN8NAM11HT193:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98574t5Wt+Kkl3T4/67J4WpR1vewEY+iv0UlroZvRZX19sUC+iAdYuv8ANXnieToIM+0kZicbYx91AOABruhex4gxY1MdEJJopvxxCWv2Fk/5dnCL0oP4Fn/zWz/MKBQeumjv31oKuUhvOOGGLZC3hKSttGec1LXNepNVmfmrRh19pHb+UPbXI1l5C64WdlOfMwHmDUXJvTJV3v2EGJqjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: faaY1zTEENQ71EsLYt/fqufX+uFJ5H6WmiJv1LIEAMvhso5dyAeAyUyrxi72FYTp4EXaZRCxGmZux7t+bG5aw1htsOjLrQoun8cP2/Go6J3ZsRBMe8Yi4YbNiWPlFgibibWz1qwqP0sbvLaAAb4reSz0emjtnZqPlTBEc9spJFBOMp77JW65p2q/wypTuv7NEn2u8wJBOtj7yeOEJm+TiQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4103f88c-8019-4c35-eae8-08d7ef86950c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2020 17:22:40.6690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT193
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma023 chip is similar enough to the bma180 and bma25x that the
same driver can support all of them.  The biggest differences are
the lack of a temperature channel and no low power but still working
mode.

The bma150 is a close relative of the bma023, but it does have a
temperature channel so support is not added for it.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/iio/accel/Kconfig  |   6 +-
 drivers/iio/accel/bma180.c | 123 +++++++++++++++++++++++++++++++++++--
 2 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 5d91a6dda894..4699113f19d9 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -89,13 +89,13 @@ config ADXL372_I2C
 	  module will be called adxl372_i2c.
 
 config BMA180
-	tristate "Bosch BMA180/BMA25x 3-Axis Accelerometer Driver"
+	tristate "Bosch BMA023/BMA180/BMA25x 3-Axis Accelerometer Driver"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say Y here if you want to build a driver for the Bosch BMA180 or
-	  BMA25x triaxial acceleration sensor.
+	  Say Y here if you want to build a driver for the Bosch BMA023, BMA180
+	  or BMA25x triaxial acceleration sensor.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma180.
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 75440dd83ec4..19d4f174a890 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -7,6 +7,7 @@
  * Support for BMA250 (c) Peter Meerwald <pmeerw@pmeerw.net>
  *
  * SPI is not supported by driver
+ * BMA023: 7-bit I2C slave address 0x38
  * BMA180: 7-bit I2C slave address 0x40 or 0x41
  * BMA250: 7-bit I2C slave address 0x18 or 0x19
  * BMA254: 7-bit I2C slave address 0x18 or 0x19
@@ -33,6 +34,7 @@
 #define BMA180_IRQ_NAME "bma180_event"
 
 enum chip_ids {
+	BMA023,
 	BMA180,
 	BMA250,
 	BMA254,
@@ -64,6 +66,18 @@ struct bma180_part_info {
 };
 
 /* Register set */
+#define BMA023_CTRL_REG0	0x0a
+#define BMA023_CTRL_REG1	0x0b
+#define BMA023_CTRL_REG2	0x14
+#define BMA023_CTRL_REG3	0x15
+
+#define BMA023_RANGE_MASK	GENMASK(4, 3) /* Range of accel values */
+#define BMA023_BW_MASK		GENMASK(2, 0) /* Accel bandwidth */
+#define BMA023_SLEEP		BIT(0)
+#define BMA023_INT_RESET_MASK	BIT(6)
+#define BMA023_NEW_DATA_INT	BIT(5) /* Intr every new accel data is ready */
+#define BMA023_RESET_VAL	BIT(1)
+
 #define BMA180_CHIP_ID		0x00 /* Need to distinguish BMA180 from other */
 #define BMA180_ACC_X_LSB	0x02 /* First of 6 registers of accel data */
 #define BMA180_TEMP		0x08
@@ -94,6 +108,7 @@ struct bma180_part_info {
 /* We have to write this value in reset register to do soft reset */
 #define BMA180_RESET_VAL	0xb6
 
+#define BMA023_ID_REG_VAL	0x02
 #define BMA180_ID_REG_VAL	0x03
 #define BMA250_ID_REG_VAL	0x03
 #define BMA254_ID_REG_VAL	0xfa /* 250 decimal */
@@ -156,6 +171,9 @@ enum bma180_chan {
 	TEMP
 };
 
+static int bma023_bw_table[] = { 25, 50, 100, 190, 375, 750, 1500 }; /* Hz */
+static int bma023_scale_table[] = { 2452, 4903, 9709, };
+
 static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
 static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
@@ -350,17 +368,37 @@ static int bma180_chip_init(struct bma180_data *data)
 	 */
 	msleep(20);
 
-	ret = bma180_set_new_data_intr_state(data, false);
+	return bma180_set_new_data_intr_state(data, false);
+}
+
+static int bma023_chip_config(struct bma180_data *data)
+{
+	int ret = bma180_chip_init(data);
+
 	if (ret)
-		return ret;
+		goto err;
+
+	ret = bma180_set_bw(data, 50); /* 50 Hz */
+	if (ret)
+		goto err;
+	ret = bma180_set_scale(data, 2452); /* 2 G */
+	if (ret)
+		goto err;
 
-	return bma180_set_pmode(data, false);
+	return 0;
+
+err:
+	dev_err(&data->client->dev, "failed to config the chip\n");
+	return ret;
 }
 
 static int bma180_chip_config(struct bma180_data *data)
 {
 	int ret = bma180_chip_init(data);
 
+	if (ret)
+		goto err;
+	ret = bma180_set_pmode(data, false);
 	if (ret)
 		goto err;
 	ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_DIS_WAKE_UP, 1);
@@ -390,6 +428,9 @@ static int bma25x_chip_config(struct bma180_data *data)
 {
 	int ret = bma180_chip_init(data);
 
+	if (ret)
+		goto err;
+	ret = bma180_set_pmode(data, false);
 	if (ret)
 		goto err;
 	ret = bma180_set_bw(data, 16); /* 16 Hz */
@@ -414,6 +455,17 @@ static int bma25x_chip_config(struct bma180_data *data)
 	return ret;
 }
 
+static void bma023_chip_disable(struct bma180_data *data)
+{
+	if (bma180_set_sleep_state(data, true))
+		goto err;
+
+	return;
+
+err:
+	dev_err(&data->client->dev, "failed to disable the chip\n");
+}
+
 static void bma180_chip_disable(struct bma180_data *data)
 {
 	if (bma180_set_new_data_intr_state(data, false))
@@ -610,6 +662,11 @@ static const struct iio_enum bma180_power_mode_enum = {
 	.set = bma180_set_power_mode,
 };
 
+static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
+	{ }
+};
+
 static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
 	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
@@ -617,6 +674,23 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	{ }
 };
 
+#define BMA023_ACC_CHANNEL(_axis, _bits) {				\
+	.type = IIO_ACCEL,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.scan_index = AXIS_##_axis,					\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = _bits,					\
+		.storagebits = 16,					\
+		.shift = 16 - _bits,					\
+	},								\
+	.ext_info = bma023_ext_info,					\
+}
+
 #define BMA180_ACC_CHANNEL(_axis, _bits) {				\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -646,6 +720,13 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	},								\
 }
 
+static const struct iio_chan_spec bma023_channels[] = {
+	BMA023_ACC_CHANNEL(X, 10),
+	BMA023_ACC_CHANNEL(Y, 10),
+	BMA023_ACC_CHANNEL(Z, 10),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
 static const struct iio_chan_spec bma180_channels[] = {
 	BMA180_ACC_CHANNEL(X, 14),
 	BMA180_ACC_CHANNEL(Y, 14),
@@ -671,6 +752,35 @@ static const struct iio_chan_spec bma254_channels[] = {
 };
 
 static const struct bma180_part_info bma180_part_info[] = {
+	[BMA023] = {
+		.chip_id = BMA023_ID_REG_VAL,
+		.channels = bma023_channels,
+		.num_channels = ARRAY_SIZE(bma023_channels),
+		.scale_table = bma023_scale_table,
+		.num_scales = ARRAY_SIZE(bma023_scale_table),
+		.bw_table = bma023_bw_table,
+		.num_bw = ARRAY_SIZE(bma023_bw_table),
+		/* No temperature channel */
+		.center_temp = 0,
+		.int_reset_reg = BMA023_CTRL_REG0,
+		.int_reset_mask = BMA023_INT_RESET_MASK,
+		.sleep_reg = BMA023_CTRL_REG0,
+		.sleep_mask = BMA023_SLEEP,
+		.bw_reg = BMA023_CTRL_REG2,
+		.bw_mask = BMA023_BW_MASK,
+		.scale_reg = BMA023_CTRL_REG2,
+		.scale_mask = BMA023_RANGE_MASK,
+		/* No power mode on bma023 */
+		.power_reg = 0,
+		.power_mask = 0,
+		.lowpower_val = 0,
+		.int_enable_reg = BMA023_CTRL_REG3,
+		.int_enable_mask = BMA023_NEW_DATA_INT,
+		.softreset_reg = BMA023_CTRL_REG0,
+		.softreset_val = BMA023_RESET_VAL,
+		.chip_config = bma023_chip_config,
+		.chip_disable = bma023_chip_disable,
+	},
 	[BMA180] = {
 		.chip_id = BMA180_ID_REG_VAL,
 		.channels = bma180_channels,
@@ -994,6 +1104,7 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 #endif
 
 static const struct i2c_device_id bma180_ids[] = {
+	{ "bma023", BMA023 },
 	{ "bma180", BMA180 },
 	{ "bma250", BMA250 },
 	{ "bma254", BMA254 },
@@ -1003,6 +1114,10 @@ static const struct i2c_device_id bma180_ids[] = {
 MODULE_DEVICE_TABLE(i2c, bma180_ids);
 
 static const struct of_device_id bma180_of_match[] = {
+	{
+		.compatible = "bosch,bma023",
+		.data = (void *)BMA023
+	},
 	{
 		.compatible = "bosch,bma180",
 		.data = (void *)BMA180
@@ -1034,5 +1149,5 @@ module_i2c_driver(bma180_driver);
 
 MODULE_AUTHOR("Kravchenko Oleksandr <x0199363@ti.com>");
 MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("Bosch BMA180/BMA25x triaxial acceleration sensor");
+MODULE_DESCRIPTION("Bosch BMA023/BMA180/BMA25x triaxial acceleration sensor");
 MODULE_LICENSE("GPL");
-- 
2.20.1

