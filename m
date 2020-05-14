Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E31D3F41
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgENUt4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 16:49:56 -0400
Received: from mail-dm6nam11olkn2104.outbound.protection.outlook.com ([40.92.19.104]:49984
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728223AbgENUtw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 May 2020 16:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1XUWmTjgtOtGog1hnVlBaPHK8LZ70AD8nQF0GC5sVevUP8Y9mC3aGSdPfU7+OxlC5GfFg61KkqTa2A9ilGsGohD20RwUAcucnf2XUH92pBzpQkMGuWYSIZdOSg0rz4x9Q1juQ1oZEUTX3KpZ4dZvzzu/T8aaFLKo3vfI8b/wUhgpdoSk+0n8BXlfngiInaMOYhYGkygG0E4uDhI5K8pg6MXqg4SXE0CUqVE7Fo29b5lfywKzEQLQ2Zx+AxmFKygMPr72Oh9K4w7M0YKXs1lI4kgF9Q9xsUr8YNqSZnKXT6iYZCaFvNMfDOjoItQItpAO31hl+ifz45whnh1B3reqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j9qJz4PM4ZSKlQ9ZzkDz0EpE+IxmCEECJ65foa+kDI=;
 b=NruFuZQLDAOYX8zuawQ4c8Wm0HbrFmOOZL4Uic5tPpwPgEX971Xj6KhLnsPThXnqU5GL/ZRzHMUJyhGDYikgPP0J6ZCnux2QR6EoNsVyx6EW+ukOs9tK7A2qaT25bdYPYikBMoqTW9N/mMDzrdrKR1q1RiyRLHoN9bIs7x9jcYsm2kkFPyxLP8x/nJ1mqJt9DwrJYi+nXX+pfXX5/dt9dz4fdRNEA7aY+5bX+JdGbgEdDlpTwJ/BekCY80VmEdi2DPoqLvtXD6nIk421PXrk/e3eF+W9R3LblXToQicK4YaU0GAtfEah7BA+vPcZXyFUUkbhKOLt3aV8m4qFdOwpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::47) by
 DM6NAM11HT098.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::342)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 14 May
 2020 20:49:49 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT024.mail.protection.outlook.com
 (2a01:111:e400:fc4d::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 20:49:49 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:BA8C6AF82B30B9DB9038A2ABB23D8EA3C59A23E0607A4A9F115369F0611DA563;UpperCasedChecksum:97CD823E61BC5BEA0C82221EF84D61D07DFF037AB672703A7669A3F2DD62567C;SizeAsReceived:7909;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:49:49 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 7/7] iio: accel: Add bma150/smb380 support to bma180
Date:   Thu, 14 May 2020 13:49:01 -0700
Message-ID: <BN6PR04MB0660C7BA4CE07978AEC884E1A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514204901.3199-1-xc-racer2@live.ca>
References: <20200514204901.3199-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514204901.3199-8-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1701CA0009.namprd17.prod.outlook.com (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 20:49:48 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514204901.3199-8-xc-racer2@live.ca>
X-TMN:  [ZRDDjGEj1+SdB0d0Vp8G+9BYUFgb1FI+zwjA3RDXfOyK0n6CQvdNo4ZYI6gXuoH6]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 760e60a7-27d7-4100-dc32-08d7f84857f6
X-MS-TrafficTypeDiagnostic: DM6NAM11HT098:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Y8gytcjjJj8skHfYM86rhusaAomWtq6909OZr7pWXlz5xfNOZzd0LQXVKeSj3uUxhLOrlZJ4Jwk5NgLUNBJG3jg76EqnXA7FBbKWPz0a9KaAPS9KlHzmtNGd80XyH7KccqV+6r441ELfbCMR3pr6NttkAmaeJo9ym9AWr+368uGBS2ShBEELpLxUP2MFlEQle4JiptLw7CSLp8GZLjZiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 2za/Lf335B7o3NCc2S0gKBnesmHMREZ2pmSdlnhz1XSi7nunS0ep8S+pWSAfYplE/N5wNKJqGY0ZMNScc1Bf39a8FSUDbUvi1itKEwRAvk392r5j/9j60JcCRrtWf8n2ezJsXhUSPTlmDQ6K9qfm74MSEENLt7MvPLAc6wfMeLkeTeBqIpx7GhA85M/r7LyB1VsgBQeh7on0cPbtraweDQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760e60a7-27d7-4100-dc32-08d7f84857f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:49:49.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma150/smb380 are very similar to the bma023 but have a temperature
channel as well.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/iio/accel/Kconfig  |  6 ++--
 drivers/iio/accel/bma180.c | 71 +++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 60d1be99f93b..109ae0c8b35d 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -89,13 +89,13 @@ config ADXL372_I2C
 	  module will be called adxl372_i2c.
 
 config BMA180
-	tristate "Bosch BMA023/BMA180/BMA25x 3-Axis Accelerometer Driver"
+	tristate "Bosch BMA023/BMA1x0/BMA25x 3-Axis Accelerometer Driver"
 	depends on I2C && INPUT_BMA150=n
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say Y here if you want to build a driver for the Bosch BMA023, BMA180
-	  or BMA25x triaxial acceleration sensor.
+	  Say Y here if you want to build a driver for the Bosch BMA023, BMA150
+	  BMA180, SMB380, or BMA25x triaxial acceleration sensor.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma180.
diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 23da0a79b0c4..265722e4b13f 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -7,7 +7,7 @@
  * Support for BMA250 (c) Peter Meerwald <pmeerw@pmeerw.net>
  *
  * SPI is not supported by driver
- * BMA023: 7-bit I2C slave address 0x38
+ * BMA023/BMA150/SMB380: 7-bit I2C slave address 0x38
  * BMA180: 7-bit I2C slave address 0x40 or 0x41
  * BMA250: 7-bit I2C slave address 0x18 or 0x19
  * BMA254: 7-bit I2C slave address 0x18 or 0x19
@@ -35,6 +35,7 @@
 
 enum chip_ids {
 	BMA023,
+	BMA150,
 	BMA180,
 	BMA250,
 	BMA254,
@@ -565,8 +566,12 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
-		*val = sign_extend32(ret >> chan->scan_type.shift,
-			chan->scan_type.realbits - 1);
+		if (chan->scan_type.sign == 's') {
+			*val = sign_extend32(ret >> chan->scan_type.shift,
+				chan->scan_type.realbits - 1);
+		} else {
+			*val = ret;
+		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*val = data->bw;
@@ -691,6 +696,18 @@ static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
 	.ext_info = bma023_ext_info,					\
 }
 
+#define BMA150_TEMP_CHANNEL {						\
+	.type = IIO_TEMP,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),	\
+	.scan_index = TEMP,						\
+	.scan_type = {							\
+		.sign = 'u',						\
+		.realbits = 8,						\
+		.storagebits = 16,					\
+	},								\
+}
+
 #define BMA180_ACC_CHANNEL(_axis, _bits) {				\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -727,6 +744,14 @@ static const struct iio_chan_spec bma023_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+static const struct iio_chan_spec bma150_channels[] = {
+	BMA023_ACC_CHANNEL(X, 10),
+	BMA023_ACC_CHANNEL(Y, 10),
+	BMA023_ACC_CHANNEL(Z, 10),
+	BMA150_TEMP_CHANNEL,
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
 static const struct iio_chan_spec bma180_channels[] = {
 	BMA180_ACC_CHANNEL(X, 14),
 	BMA180_ACC_CHANNEL(Y, 14),
@@ -781,6 +806,34 @@ static const struct bma180_part_info bma180_part_info[] = {
 		.chip_config = bma023_chip_config,
 		.chip_disable = bma023_chip_disable,
 	},
+	[BMA150] = {
+		.chip_id = BMA023_ID_REG_VAL,
+		.channels = bma150_channels,
+		.num_channels = ARRAY_SIZE(bma150_channels),
+		.scale_table = bma023_scale_table,
+		.num_scales = ARRAY_SIZE(bma023_scale_table),
+		.bw_table = bma023_bw_table,
+		.num_bw = ARRAY_SIZE(bma023_bw_table),
+		.temp_offset = -60, /* 0 LSB @ -30 degree C */
+		.int_reset_reg = BMA023_CTRL_REG0,
+		.int_reset_mask = BMA023_INT_RESET_MASK,
+		.sleep_reg = BMA023_CTRL_REG0,
+		.sleep_mask = BMA023_SLEEP,
+		.bw_reg = BMA023_CTRL_REG2,
+		.bw_mask = BMA023_BW_MASK,
+		.scale_reg = BMA023_CTRL_REG2,
+		.scale_mask = BMA023_RANGE_MASK,
+		/* No power mode on bma150 */
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
@@ -1105,9 +1158,11 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 
 static const struct i2c_device_id bma180_ids[] = {
 	{ "bma023", BMA023 },
+	{ "bma150", BMA150 },
 	{ "bma180", BMA180 },
 	{ "bma250", BMA250 },
 	{ "bma254", BMA254 },
+	{ "smb380", BMA150 },
 	{ }
 };
 
@@ -1118,6 +1173,10 @@ static const struct of_device_id bma180_of_match[] = {
 		.compatible = "bosch,bma023",
 		.data = (void *)BMA023
 	},
+	{
+		.compatible = "bosch,bma150",
+		.data = (void *)BMA150
+	},
 	{
 		.compatible = "bosch,bma180",
 		.data = (void *)BMA180
@@ -1130,6 +1189,10 @@ static const struct of_device_id bma180_of_match[] = {
 		.compatible = "bosch,bma254",
 		.data = (void *)BMA254
 	},
+	{
+		.compatible = "bosch,smb380",
+		.data = (void *)BMA150
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bma180_of_match);
@@ -1149,5 +1212,5 @@ module_i2c_driver(bma180_driver);
 
 MODULE_AUTHOR("Kravchenko Oleksandr <x0199363@ti.com>");
 MODULE_AUTHOR("Texas Instruments, Inc.");
-MODULE_DESCRIPTION("Bosch BMA023/BMA180/BMA25x triaxial acceleration sensor");
+MODULE_DESCRIPTION("Bosch BMA023/BMA1x0/BMA25x triaxial acceleration sensor");
 MODULE_LICENSE("GPL");
-- 
2.20.1

