Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC436AF83
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhDZILq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 04:11:46 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:10563
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232496AbhDZILo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 04:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oK3i8w3c3qrh942vblb+dQxA5icCq4pcXvpTYZZamGIovpeOHzX+kiaRMlkCPKr7cRBoBBQ4OIgwJcfw5YHhJ2BVsoqU3l40Mcsp96aY4oEbSK6CUDsoK6G4jvUbaBjHr0406/caT5QRlS/Zz28YZcfQrUWu/YH+kP3ONYjw4UoqmsY7IZhbJLHsOEC08oRlxyCK9gAAcqoB9J/x9jKpg0yzh0DQRqvdWozd5NAJfWG9LWg6evf4SB3/2LyD7ZrAWNZVo+KEuMyaqPN6Y08Ahg/kCmNDYAQ24JEfDcbG811GZhGuC6t2QtpOfgYUEfO+Zl6Ow52/D7R6HfxT6EbPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPs4hMW0fkM6dexE7OfKhAaMsne9YinjZxVIDUAi8LE=;
 b=OR4gI8AMIDyTkIHO2G1zyybDwabMb32gCUQbn6OtMUPxtoZhnvWQSpZmgtEJ8EHCeETL8wfrnyyh+i2xStSU7/lDKjc+qodXfS4K8kaSBOWm5WGQ/qxh/UaJh2XcdgGjOumaC49sUOCEzIYZG16WzOVN5s+uBQ/BTc1cl3ASxme8qSJNC6srFX8XYC8KNIF3oKLWGimfx9JyB2/xNXGb+iAN8o4vpVuxPAZLx4v4ndRMTfTWHG4/m9CRYp3zlmmmR8UYC/P0E2gX/BBYH6lcNUd0+ZZRosi9OesVVW92lDDTH3M1gB9Sbf96Y0iD2AnXwM4eEomLulfZpZiohT9sQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPs4hMW0fkM6dexE7OfKhAaMsne9YinjZxVIDUAi8LE=;
 b=EWftlCIhLLZxZHp6E+2DXyp6rjyEBnM0eSymBBnbxLzCO9xNSER59RBw4bCKKpoLct6hYd0KqgE7YpxPKr8/qXStw5QN3R5RdGtVbc6Oyn1tljLr3AK7pgiWHtoZ30SD/NocTJk0JmXY6qtaQTzH/0SwLjDYMrps4TfUZF2+ZETHosYgcoxBUczCVNRhIXhPVI4sofqtsxtGX+gmELlo0pbFgNDeeJKe6+vGmKu5ybw/yLW2J2rJF5KTZ1fycdqakwX2eikekOn/yufYERPmUcmpeObXlYwf1jBRMdTduFhOoDAKqolhjs7MVeOqmIj7sSHtlyv0H6nm5/BIejwTvw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5888.eurprd06.prod.outlook.com
 (2603:10a6:803:d8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 08:10:59 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 08:10:59 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v5 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
Date:   Mon, 26 Apr 2021 11:10:41 +0300
Message-Id: <20210426081041.59807-3-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210426081041.59807-1-tomas.melin@vaisala.com>
References: <20210426081041.59807-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:7:66::11) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:7:66::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Mon, 26 Apr 2021 08:10:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dffac6c2-4858-4a4a-7541-08d9088ad360
X-MS-TrafficTypeDiagnostic: VI1PR06MB5888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB58880578BE09E100AE10193FFD429@VI1PR06MB5888.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbi1r4DJBlQP20hCJyyb5+0ixIIOtOoozlUGf5timt48aOLPDkR7TPoID1OAqSeJGntNKUmxdnbkY0hUgsVGVNrkEQESnps8iYf9C78ikftOQsq6Ey67mFHHfA2ZyX/SGTTwHdjQMzaf+qLoHzhIWc+R3ufDJYR0I1KoZlcb6hh2JJauEl0bcuOFdI9bYx7HrRHT0rsTV/HYJ7cMjFeucpcT5RKgoEoKyZymdSLEOGm3VAPSt4e7Uf8mvb33CcwRmF0lVAH4Z8KDgQ4Xu8dpcu+TOMJR/R3a1K4/qyGp8MdctDqf7k33iRvUqdjU0x0pbU1wAm0tI2iqhGD6vj7jBf3zVk5Gy4wQW+HKT6luyrxKCUziG0nNMdqohOSPTsG7zUhW1T0exH78LjCIYQNnQxbv3brKFSKq60YO0xz7l9pn/jJjHH7o+h0i3DgYEMltxKrQOI3ASy9hBqmtf0Nui/V94PnKO5sNUdCakUITkS68+bkCruZnyAm7rv6oSRmJf4gH7ZAijrzwaOabf6Dce0c5cN0axXUkuQQ/1zUdHUPUmkTrep3kx7pNvSaa8nfpxiHz6zQ7DO83VqhpInW+hX27DDDKeADOQi6h1/8c6zbbPD9W/JBE2frMOGG6RtdHjhsVOiH3G788AcTFMrFzxOM7lkCK3xUlGv6aqfixQRZZ6Vf4T0sN+zx6rslj+Y+oAZWROFMJi+bfCV6Mg1UAl9FklBxINp+sMUVmvS1JcdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(346002)(366004)(396003)(1076003)(966005)(6666004)(956004)(2616005)(86362001)(2906002)(16526019)(26005)(186003)(30864003)(66476007)(4326008)(8676002)(478600001)(66556008)(66946007)(6486002)(83380400001)(8936002)(44832011)(5660300002)(107886003)(38100700002)(38350700002)(52116002)(7696005)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gw8Uloc5iTOs2RdAE8ONsdKMlHlUvP5+wb5yt6IEQfNlD9NX5Q+kVZla/s41?=
 =?us-ascii?Q?3JuZxb6KnZ958YiFalhSZaXgXnCWRwub3UZJf2IBvZcZezuvX/fhMKjS+ygO?=
 =?us-ascii?Q?GvgDeSX4P8+DWHqEP4Da4SJbY/BbVERLA06K6L5bvhmRyyxvcbSskxIqgmpS?=
 =?us-ascii?Q?o9Ahh6vNrdCtQ2hTBJ5194ZGSYQ3clMUzyN7ujKjnWMdIM5aIeQq5snWLeLO?=
 =?us-ascii?Q?7IXohbAEFlboEu7hHMpVOQjRTxYbQaD/70qs63EWYWHdLVAMUcO6dJVpgljE?=
 =?us-ascii?Q?GdEnXG8dgYQnkV/uXh5Z5NWKAiFHHxHWg/MYshyMw86+yca3qU/2w6Wdo2uv?=
 =?us-ascii?Q?L13/Vww3fg6RFH2RLrN1oaX+T8opsNOkcLEukS673JYVvXYxE4mEZ3QkOGa6?=
 =?us-ascii?Q?m5U46brX55GXWMmFmh/aXLrZkw21Sv7UIz6Pm4mP4dYun39Wie2AOawdT9J0?=
 =?us-ascii?Q?ldvrhDtFGenTW+TMoxYMYavaZs6ZH8LI56lleQuYxw2O2E6kAXkZOYNP5GRu?=
 =?us-ascii?Q?3lKx7TGBaI9nEwHa/0W5saJiNqlG/q07OSioZxmTDIof0CrrcHyf/heMtNmN?=
 =?us-ascii?Q?qLy7xU69xyBjLJ3EvTEaNp5BSo6mEpMMNaH6N8AQn1CcP8nF00BI0gVhrOix?=
 =?us-ascii?Q?qG5BvFXv2/CVJyCwg3I4HAhFCAZSegv+srzIi1wtCFlmuigLd4fs+QEQ4sbF?=
 =?us-ascii?Q?1FbzHkKKyO1d9ndAauYdvZNOWx68y5RZw0IzXmrHKK+WnIKor1Z2EZu9V/c2?=
 =?us-ascii?Q?vcUtrn+/HorAeYcGIIs9BCHmmtRerD/PGHdkqR+qiiVKcmuncTnH4k9m+Y+p?=
 =?us-ascii?Q?3F6Ftc4Y2MuWo9EPxqLrSnMJ+2FyqJ8eeZf+e6WOMB8kn4tpSEsAq+4rdV2w?=
 =?us-ascii?Q?jrvtfSdy2bET2O8d/Mb1cmgcO4Xyzx+eDsCdB0bTdVeRwsYCOdY3VNBYYhJt?=
 =?us-ascii?Q?pIHwuX/PD4vcZm5axH9FkIhuDUYRkPVaWfu+v7wAv4lq6AQ1v2XRhU6VlCyS?=
 =?us-ascii?Q?c8gyQ2N9PqZhO9AG+3zAjbQ7slUHZvfSl/EWses6vDQW5XRIEkvKBk61Sxpj?=
 =?us-ascii?Q?jVcz9oKtSHEqjAodcPmAplEQMBs90AR5J7Ee1pHQtffk3MVsxXZVOg/y69zG?=
 =?us-ascii?Q?RYtZ1XvZpB0kN463TRZyqk7sJALt0b6LSC8KurXfnTTCJwqyiRp8NVYCY4M6?=
 =?us-ascii?Q?eg8B3RaWtBJJlUClEzJShkNr9a03wv35GCz93BWpBoySFfnjcQj1XI0e1Flg?=
 =?us-ascii?Q?ajElcifK/lA7C53xPAEhV0ETFzlbtlezaOBnfsNcaBop3IYsciSD/VtpAd3L?=
 =?us-ascii?Q?58aioEFDNyou5/y6usHvX7jw?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffac6c2-4858-4a4a-7541-08d9088ad360
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 08:10:59.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZs/cRJpEUVU66LKaVyyBLX23FQNX0KdIN2M/+73TVa0UBPQbbEesFmXoJWGYtIYZv4g4WgTT8y3YWuRlv0ZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5888
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial support for Murata SCA3300 3-axis industrial
accelerometer with digital SPI interface. This device also
provides a temperature measurement.

Datasheet: https://www.murata.com/en-global/products/sensor/accel/sca3300
Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/accel/Kconfig   |  13 +
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/sca3300.c | 472 ++++++++++++++++++++++++++++++++++++
 3 files changed, 486 insertions(+)
 create mode 100644 drivers/iio/accel/sca3300.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index cceda3cecbcf..0dbf7b648e8a 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -450,6 +450,19 @@ config SCA3000
 	  To compile this driver as a module, say M here: the module will be
 	  called sca3000.
 
+config SCA3300
+	tristate "Murata SCA3300 3-Axis Accelerometer Driver"
+	depends on SPI
+	select CRC8
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Murata SCA3300 3-Axis
+	  accelerometer.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called sca3300.
+
 config STK8312
 	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 32cd1342a31a..4b56527a2b97 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_MXC4005)		+= mxc4005.o
 obj-$(CONFIG_MXC6255)		+= mxc6255.o
 
 obj-$(CONFIG_SCA3000)		+= sca3000.o
+obj-$(CONFIG_SCA3300)		+= sca3300.o
 
 obj-$(CONFIG_STK8312)		+= stk8312.o
 obj-$(CONFIG_STK8BA50)		+= stk8ba50.o
diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
new file mode 100644
index 000000000000..f7ef8ecfd34a
--- /dev/null
+++ b/drivers/iio/accel/sca3300.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Murata SCA3300 3-axis industrial accelerometer
+ *
+ * Copyright (c) 2021 Vaisala Oyj. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define SCA3300_ALIAS "sca3300"
+
+#define SCA3300_CRC8_POLYNOMIAL 0x1d
+
+/* Device mode register */
+#define SCA3300_REG_MODE	0xd
+#define SCA3300_MODE_SW_RESET	0x20
+
+/* Last register in map */
+#define SCA3300_REG_SELBANK	0x1f
+
+/* Device status and mask */
+#define SCA3300_REG_STATUS	0x6
+#define SCA3300_STATUS_MASK	GENMASK(8, 0)
+
+/* Device ID */
+#define SCA3300_REG_WHOAMI	0x10
+#define SCA3300_WHOAMI_ID	0x51
+
+/* Device return status and mask */
+#define SCA3300_VALUE_RS_ERROR	0x3
+#define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
+
+enum sca3300_scan_indexes {
+	SCA3300_ACC_X = 0,
+	SCA3300_ACC_Y,
+	SCA3300_ACC_Z,
+	SCA3300_TEMP,
+	SCA3300_TIMESTAMP,
+};
+
+#define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =					\
+	BIT(IIO_CHAN_INFO_SCALE) |					\
+	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
+	.info_mask_shared_by_type_available =				\
+	BIT(IIO_CHAN_INFO_SCALE) |					\
+	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
+static const struct iio_chan_spec sca3300_channels[] = {
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
+	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
+	{
+		.type = IIO_TEMP,
+		.address = 0x5,
+		.scan_index = SCA3300_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const int sca3300_lp_freq[] = {70, 70, 70, 10};
+static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
+
+static const unsigned long sca3300_scan_masks[] = {
+	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
+	BIT(SCA3300_TEMP),
+	0
+};
+
+/**
+ * struct sca3300_data - device data
+ * @spi: SPI device structure
+ * @lock: Data buffer lock
+ * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
+ * @txbuf: Transmit buffer
+ * @rxbuf: Receive buffer
+ */
+struct sca3300_data {
+	struct spi_device *spi;
+	struct mutex lock;
+	struct {
+		s16 channels[4];
+		s64 ts __aligned(sizeof(s64));
+	} scan;
+	u8 txbuf[4] ____cacheline_aligned;
+	u8 rxbuf[4];
+};
+
+DECLARE_CRC8_TABLE(sca3300_crc_table);
+
+static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
+{
+	/* Consecutive requests min. 10 us delay (Datasheet section 5.1.2) */
+	struct spi_delay delay = { .value = 10, .unit = SPI_DELAY_UNIT_USECS };
+	int32_t ret;
+	int rs;
+	u8 crc;
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = sca_data->txbuf,
+			.len = ARRAY_SIZE(sca_data->txbuf),
+			.delay = delay,
+			.cs_change = 1,
+		},
+		{
+			.rx_buf = sca_data->rxbuf,
+			.len = ARRAY_SIZE(sca_data->rxbuf),
+			.delay = delay,
+		}
+	};
+
+	/* inverted crc value as described in device data sheet */
+	crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3, CRC8_INIT_VALUE);
+	sca_data->txbuf[3] = crc;
+
+	ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret) {
+		dev_err(&sca_data->spi->dev,
+			"transfer error, error: %d\n", ret);
+		return -EIO;
+	}
+
+	crc = ~crc8(sca3300_crc_table, &sca_data->rxbuf[0], 3, CRC8_INIT_VALUE);
+	if (sca_data->rxbuf[3] != crc) {
+		dev_err(&sca_data->spi->dev, "CRC checksum mismatch");
+		return -EIO;
+	}
+
+	/* get return status */
+	rs = sca_data->rxbuf[0] & SCA3300_MASK_RS_STATUS;
+	if (rs == SCA3300_VALUE_RS_ERROR)
+		ret = -EINVAL;
+
+	*val = sign_extend32(get_unaligned_be16(&sca_data->rxbuf[1]), 15);
+
+	return ret;
+}
+
+static int sca3300_error_handler(struct sca3300_data *sca_data)
+{
+	int ret;
+	int val;
+
+	mutex_lock(&sca_data->lock);
+	sca_data->txbuf[0] = SCA3300_REG_STATUS << 2;
+	ret = sca3300_transfer(sca_data, &val);
+	mutex_unlock(&sca_data->lock);
+	/*
+	 * Return status error is cleared after reading status register once,
+	 * expect EINVAL here.
+	 */
+	if (ret != -EINVAL) {
+		dev_err(&sca_data->spi->dev,
+			"error reading device status: %d\n", ret);
+		return ret;
+	}
+
+	dev_err(&sca_data->spi->dev, "device status: 0x%lx\n",
+		val & SCA3300_STATUS_MASK);
+
+	return 0;
+}
+
+static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
+{
+	int ret;
+
+	mutex_lock(&sca_data->lock);
+	sca_data->txbuf[0] = reg << 2;
+	ret = sca3300_transfer(sca_data, val);
+	mutex_unlock(&sca_data->lock);
+	if (ret != -EINVAL)
+		return ret;
+
+	return sca3300_error_handler(sca_data);
+}
+
+static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
+{
+	int reg_val = 0;
+	int ret;
+
+	mutex_lock(&sca_data->lock);
+	/* BIT(7) for write operation */
+	sca_data->txbuf[0] = BIT(7) | (reg << 2);
+	put_unaligned_be16(val, &sca_data->txbuf[1]);
+	ret = sca3300_transfer(sca_data, &reg_val);
+	mutex_unlock(&sca_data->lock);
+	if (ret != -EINVAL)
+		return ret;
+
+	return sca3300_error_handler(sca_data);
+}
+
+static int sca3300_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct sca3300_data *data = iio_priv(indio_dev);
+	int reg_val;
+	int ret;
+	int i;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val)
+			return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
+			if (val2 == sca3300_accel_scale[i][1])
+				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
+		}
+		return -EINVAL;
+
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		if (ret)
+			return ret;
+		/* freq. change is possible only for mode 3 and 4 */
+		if (reg_val == 2 && val == sca3300_lp_freq[3])
+			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
+		if (reg_val == 3 && val == sca3300_lp_freq[2])
+			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sca3300_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct sca3300_data *data = iio_priv(indio_dev);
+	int ret;
+	int reg_val;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = sca3300_read_reg(data, chan->address, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		if (ret)
+			return ret;
+		*val = 0;
+		*val2 = sca3300_accel_scale[reg_val][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		if (ret)
+			return ret;
+		*val = sca3300_lp_freq[reg_val];
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t sca3300_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct sca3300_data *data = iio_priv(indio_dev);
+	int bit, ret, val, i = 0;
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		ret = sca3300_read_reg(data, sca3300_channels[bit].address,
+				       &val);
+		if (ret) {
+			dev_err_ratelimited(&data->spi->dev,
+				"failed to read register, error: %d\n", ret);
+			/* handled, but bailing out due to errors */
+			goto out;
+		}
+		data->scan.channels[i++] = val;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   iio_get_time_ns(indio_dev));
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * sca3300_init - Device init sequence. See datasheet rev 2 section
+ * 4.2 Start-Up Sequence for details.
+ */
+static int sca3300_init(struct sca3300_data *sca_data,
+			struct iio_dev *indio_dev)
+{
+	int value = 0;
+	int ret;
+
+	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
+				SCA3300_MODE_SW_RESET);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait 1ms after SW-reset command.
+	 * Wait 15ms for settling of signal paths.
+	 */
+	usleep_range(16e3, 50e3);
+
+	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
+	if (ret)
+		return ret;
+
+	if (value != SCA3300_WHOAMI_ID) {
+		dev_err(&sca_data->spi->dev,
+			"device id not expected value, %d != %u\n",
+			value, SCA3300_WHOAMI_ID);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int sca3300_debugfs_reg_access(struct iio_dev *indio_dev,
+				      unsigned int reg, unsigned int writeval,
+				      unsigned int *readval)
+{
+	struct sca3300_data *data = iio_priv(indio_dev);
+	int value;
+	int ret;
+
+	if (reg > SCA3300_REG_SELBANK)
+		return -EINVAL;
+
+	if (!readval)
+		return sca3300_write_reg(data, reg, writeval);
+
+	ret = sca3300_read_reg(data, reg, &value);
+	if (ret)
+		return ret;
+
+	*readval = value;
+
+	return 0;
+}
+
+static int sca3300_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)sca3300_accel_scale;
+		*length = ARRAY_SIZE(sca3300_accel_scale) * 2 - 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = &sca3300_lp_freq[2];
+		*length = 2;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info sca3300_info = {
+	.read_raw = sca3300_read_raw,
+	.write_raw = sca3300_write_raw,
+	.debugfs_reg_access = &sca3300_debugfs_reg_access,
+	.read_avail = sca3300_read_avail,
+};
+
+static int sca3300_probe(struct spi_device *spi)
+{
+	struct sca3300_data *sca_data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sca_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sca_data = iio_priv(indio_dev);
+	mutex_init(&sca_data->lock);
+	sca_data->spi = spi;
+
+	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
+
+	indio_dev->info = &sca3300_info;
+	indio_dev->name = SCA3300_ALIAS;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sca3300_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
+	indio_dev->available_scan_masks = sca3300_scan_masks;
+
+	ret = sca3300_init(sca_data, indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "failed to init device, error: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      sca3300_trigger_handler, NULL);
+	if (ret) {
+		dev_err(&spi->dev,
+			"iio triggered buffer setup failed, error: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "iio device register failed, error: %d\n",
+			ret);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id sca3300_dt_ids[] = {
+	{ .compatible = "murata,sca3300"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
+
+static struct spi_driver sca3300_driver = {
+	.driver = {
+		.name		= SCA3300_ALIAS,
+		.of_match_table = sca3300_dt_ids,
+	},
+	.probe	= sca3300_probe,
+};
+module_spi_driver(sca3300_driver);
+
+MODULE_AUTHOR("Tomas Melin <tomas.melin@vaisala.com>");
+MODULE_DESCRIPTION("Murata SCA3300 SPI Accelerometer");
+MODULE_LICENSE("GPL v2");
-- 
2.21.3

