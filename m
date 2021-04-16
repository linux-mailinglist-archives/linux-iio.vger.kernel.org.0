Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF536215B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbhDPNrD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbhDPNrC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 09:47:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A7C061574;
        Fri, 16 Apr 2021 06:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKWMwD5uxr3rPxILGCQUMKWKcSG26gXXnzeKB4HPfg4gtrdMyXgfvBaY4XnsqKRWigccswBjKBBQ7z7HU1SLvEK0Oqu5HBNS2PlYW7YaGiC447453R3M8bXIMrKcyXWr4g+XnKkdTaXxsy9E7H8qTQqyrs1Ey6L/LhEqQBxy6TScDxBhPvwV9oalIyIzYKwm2Dk2hMjkf7MYUHOvVZtNnvImOetiLfEy/qK/Ql0qRs64FWrSCQMMSddeZtKnsFmDIFofO5BnntDv8Or8kHS44U0sw2/ilReRWIs6EuidkXkipDnaqlVNX+ZLV/QnhvISrhfB2NP4mHDuZA5qBsQhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dIVm2k58ky4jKhQAio4MJM0fzG8jGGEmOjC148owMA=;
 b=HDXl7Jgxipha6jGVMoXkMc70J4PYBVy9AGyWc0TyAy6a9SJVLRfUL/XKv1hd8LoQTdFpLQhQI2OnwGfEHqziZLQIDyfF81Cd7eAiye2QrQn0s8rSHZGpbHb0eycOqxV0R7Ru7LfQ2M2JJKV22e+j3upoolE6UnDKyK4NriSUFXOqCder1dsrG9GMUtXush5BvWE3cr4UN5THUG3XXHIl9dCwSLOAC1LLtv36lzW3kXVJ24NYTQyqCWj3yBw29oUCIq21OVkz+ZqzKsfQfzQlUdUEjabR2Bq3gXXinqWHOx4o1atpUFL/4VrZczGNoWKIg0si8TM+PX9q37hgydUzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dIVm2k58ky4jKhQAio4MJM0fzG8jGGEmOjC148owMA=;
 b=sZnvz+pjJl9MjH0r0vJArmen6WHZBsMARcOF0uA0laevowLVa7Re3AUl3+dlDqLadh0nw/rJBObrIo++7DdlV7snw8vKMiDADNl31ydJ2BRMsUq8E2+J5+SwI4sqB2qnHLcdnDenNDeuH51BA5nLj2dyEIo35UaK+CV65XUGKfLPngfX1eRRQARm9LHPKohZcn1sUdHSIE6DDUSRIVTTHuKtnUqXUSusYKJ/esTau0SO8+THuQYckdHruOiKv6/xgvbxLFwxdjvu4PYe2cWUiT/gARfSzJA6AB2HgOU65jg4IVP8CNLCHffPlUYI6bCQADMuWYG5p5rWSWe0+mwTxg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5568.eurprd06.prod.outlook.com
 (2603:10a6:803:da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 13:46:33 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.016; Fri, 16 Apr 2021
 13:46:33 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v2 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
Date:   Fri, 16 Apr 2021 16:45:46 +0300
Message-Id: <20210416134546.38475-3-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210416134546.38475-1-tomas.melin@vaisala.com>
References: <20210416134546.38475-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR05CA0269.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::21) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.localdomain (85.156.166.106) by HE1PR05CA0269.eurprd05.prod.outlook.com (2603:10a6:3:fc::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 16 Apr 2021 13:46:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89d6f130-b9b3-4e16-fc47-08d900de0bfc
X-MS-TrafficTypeDiagnostic: VI1PR06MB5568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB5568C4AEE899A960CE7BE489FD4C9@VI1PR06MB5568.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdK2xmCqwCz1xTUHDdJd80+ntNJ6hhCZjlMWK64eaiLJvEQ38VCptX8gvd69bKX152XruOhuMw0jjl6heT1qUMzdiJ5/qrJfzlH5iDMzAIIO73mSVjWRFQbypm+2wnpj09j/4eT7N6EegGe3ygGS3hIdZXcJEjMzvFw+P0Nk0kLUboq8nuLGai5yr+3w2LHjQSsvvxo5T5mmkOHozn1ecms/aJL7/8fWjVw6CFkx1NhKe/CYm9SMGEmkkKsKbLYbzczghW2aV9+YTwKpfJkTpAYy3ZHXzUDvN306qjpZDcLE/IPKq2uFDGeMXf9hIbh9lfb8UmPUT2cDFKn3n8GmAbEr12Qf7iqidHmVyOui1Vd05beCl4+zGaqJSTgaTHUHLUvXGD1/wb1ODC8dMoYLSo8le/UAsBOACn7hjbUQFG4ZgrhmSoHXFMDybwtrorp5762Cy5gKBwwL4nIFyAbgwDPG2hz1fIUCmd/+eJsoa6Ze9yzQm1DNHAFdvzIvl8GiXAWhrLxrT79ycOclBch2JEnmbwyKdomjBsDd7yTIlRCTdNdL3XXEdp2uH+ex0MMvGNBLYwYEOs7I71qST0hJMtKnLCeEjG3aj4TalCTGvE3LZNVotWxnVF07y+Ur+07vA29ImSzdM9as/2g8ecHAeWCME6enpb9Hhvx/VWyLfUwKLqg95q4bWQJ+VblDSube3NpfMBFirdPhF8Tb/GuYfW/JtgHnhW3S6q54OF4RvZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(366004)(5660300002)(6486002)(30864003)(66946007)(186003)(66476007)(956004)(66556008)(316002)(86362001)(6506007)(36756003)(6666004)(107886003)(1076003)(38100700002)(38350700002)(16526019)(478600001)(52116002)(8936002)(2906002)(83380400001)(966005)(26005)(44832011)(8676002)(2616005)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6rF+Q3qJFIZnlxwbI8GaduT8PWW4g4mkVKURoOw4wszZDJpIcm7+Co8bRE8Z?=
 =?us-ascii?Q?TaKqUt9l6E1Jn0oFYz8lzZE3Khk6wOp572798e00Fmwfv5WGlvjUwOPC9GTy?=
 =?us-ascii?Q?6ZXXgAGruMqmjBUudnl0dYurt/7dMcwh394ooQD+pvpOSZyC4eb21P5sTR9G?=
 =?us-ascii?Q?L5AR9YglSd6nurPgl+UVQau6b8J2FP8XuYwA/9OeYJrjTt/et1p7GSc+JrX3?=
 =?us-ascii?Q?OWTDKtmzYEQhZ3gOpdeHxBKi23Tc6AkqgqhYB9SBYK/IE8QiAefR4qj+vr/E?=
 =?us-ascii?Q?yrasXKSwB/+4Ekkv0mLyokePlxHJLa++kPqCc8EX5tk/1xaJVtWRsc0uGvGi?=
 =?us-ascii?Q?dZrP2Sh7hCyKIecsQu8z2r+1mRrw0uLEwMXEBvli80Ifx6pnJkLqat5kZpJ8?=
 =?us-ascii?Q?WjJa1STCAwKyCpTF827gITHhc8I0Ha7/dMUtHoyY9WmI2J7sC5uAEJ8VVBP0?=
 =?us-ascii?Q?JU3IOdmgbWskpfMwgfqssIiBEheKx8rwAV0ejjdDJWsk4uihTKQocVHH34bI?=
 =?us-ascii?Q?8IuXS5Sq0QzFrCEjfmvROo8Gp8lpDBC3/0YCgUxGGfdtdZysmVW5jkCl5T5U?=
 =?us-ascii?Q?CXhycMXn6XD8ryXkZpHtLxMr2TUAJHN8QkEvSQnCi4n27iHpoGMmyI9+Tntr?=
 =?us-ascii?Q?exVc0ruKO++R/3Yc2liDvAMb9lnv7Ja8m7HscPixzWbSXeGNna036+gHfU8O?=
 =?us-ascii?Q?uhiXj+wRg69Sfpn2hkzn/htb58YPIoD5TQC4Mbyej+1GsdjNZUdWP5CanRLf?=
 =?us-ascii?Q?fQ44pQe+y63BUKqIEmgf6hJMVc2YlgastLp4EvQLXdsEmdq8gyognFcFmPBR?=
 =?us-ascii?Q?XQvGZYHBytdI4pSkt1RschScSnOC9cYHxu0RSbGEzjPlQVjDh2OzTGxqzR6t?=
 =?us-ascii?Q?jca0Sf8WWdttlHSfgHBA7WnO7CIbHxj4Zu3nXbFWQ7KixZIA/+LOgVkfytmL?=
 =?us-ascii?Q?9oZk3rXpYay5shr5OBIOaMBfL6Cl1ghoeM6hxVa6xuY7il80qbgiOHRFCoSv?=
 =?us-ascii?Q?VuyBSUKWB9D8gL8PSa8LEqE2rNzUeDUGFmfQEfibZjwij1XP2CNgVU7YJEgA?=
 =?us-ascii?Q?F5fg3FVm/Ag3DIb36rmsy199fBLBYrKbNeKvqKxpp3RoANvnbE2wC1+gCo3t?=
 =?us-ascii?Q?rIPIM9QeXWPyjGEb+S6Y05nzv9+8GxtbTAvi+rRr8r5V6fxHUjjlJSjssN2j?=
 =?us-ascii?Q?VIDCj2SQ4oRe/AZqx4VzOw/HoZWo2C4rvr8RdNsFI6O9zZnQ3LAdbxp3VBRr?=
 =?us-ascii?Q?oPAACDNNJvk/Q/cxmS4N4pzj7PPGmHbY7N82no5SEvTUUsWvjfSrQE3PDyxu?=
 =?us-ascii?Q?SJNqyvAIzcmnJBbSUHV3/JJz?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d6f130-b9b3-4e16-fc47-08d900de0bfc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 13:46:33.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Dp8ia3DxTH/GYf34IECORA+BlVoNZKz8yVw83AXE1CjFew/Nt5ucqe0Ej/2iSXNwdrKDini05Ge/Gr19wfPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5568
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial support for Murata SCA3300 3-axis industrial
accelerometer with digital SPI interface. This device also
provides a temperature measurement.

Device product page including datasheet can be found at:
https://www.murata.com/en-global/products/sensor/accel/sca3300

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
---
 drivers/iio/accel/Kconfig   |  13 +
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/sca3300.c | 468 ++++++++++++++++++++++++++++++++++++
 3 files changed, 482 insertions(+)
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
index 000000000000..79c3c60f9fab
--- /dev/null
+++ b/drivers/iio/accel/sca3300.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 Vaisala Oyj. All rights reserved.
+ */
+#include <asm/unaligned.h>
+#include <linux/bitops.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#define SCA3300_ALIAS "sca3300"
+
+#define SCA3300_REG_STATUS 0x6
+#define SCA3300_REG_MODE 0xd
+#define SCA3300_REG_WHOAMI 0x10
+#define SCA3300_VALUE_SW_RESET 0x20
+#define SCA3300_CRC8_POLYNOMIAL 0x1d
+#define SCA3300_DEVICE_ID 0x51
+#define SCA3300_RS_ERROR 0x3
+#define SCA3300_SELBANK 0x1f
+#define SCA3300_STATUS_MASK 0x1ff
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
+		.type = IIO_ACCEL,					\
+			.address = reg,					\
+			.modified = 1,					\
+			.channel2 = IIO_MOD_##axis,			\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+			.info_mask_shared_by_type = \
+			BIT(IIO_CHAN_INFO_SCALE) |			\
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+			.info_mask_shared_by_type_available = \
+			BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY), \
+			.scan_index = index,				\
+			.scan_type = {					\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.shift = 0,					\
+			.endianness = IIO_CPU,				\
+		},							\
+			}
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
+			.shift = 0,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const int sca3300_lp_freq[] = {70, 70, 70, 10};
+static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185},
+					    {0, 185}};
+
+static const unsigned long sca3300_scan_masks[] = {
+	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
+	BIT(SCA3300_TEMP),
+	0};
+
+/**
+ * struct sca3300_data - device data
+ * @spi: SPI device structure
+ * @lock: Data buffer lock
+ * @txbuf: Transmit buffer
+ * @rxbuf: Receive buffer
+ * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
+ */
+struct sca3300_data {
+	struct spi_device *spi;
+	struct mutex lock;
+	u8 txbuf[4];
+	u8 rxbuf[4];
+	struct {
+		s16 channels[4];
+		s64 ts __aligned(sizeof(s64));
+	} scan;
+};
+
+DECLARE_CRC8_TABLE(sca3300_crc_table);
+
+static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
+{
+	struct spi_delay delay = {.value = 10, .unit = SPI_DELAY_UNIT_USECS};
+	int32_t ret;
+	int rs;
+	u8 crc;
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = sca_data->txbuf,
+			.rx_buf = NULL,
+			.len = ARRAY_SIZE(sca_data->txbuf),
+			.delay = delay,
+			.cs_change = 1,
+		},
+		{
+			.tx_buf = NULL,
+			.rx_buf = sca_data->rxbuf,
+			.len = ARRAY_SIZE(sca_data->rxbuf),
+			.delay = delay,
+			.cs_change = 0,
+		}
+	};
+
+	/* inverted crc value as described in device data sheet */
+	crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3, CRC8_INIT_VALUE);
+	sca_data->txbuf[3] = crc;
+
+	ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret < 0) {
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
+	rs = sca_data->rxbuf[0] & 0x03;
+	if (rs == SCA3300_RS_ERROR)
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
+	sca_data->txbuf[0] = 0x0 | (SCA3300_REG_STATUS << 2);
+	ret = sca3300_transfer(sca_data, &val);
+	mutex_unlock(&sca_data->lock);
+	/* return status is cleared after reading status register */
+	if (ret != -EINVAL) {
+		dev_err(&sca_data->spi->dev,
+			"error reading device status: %d\n", ret);
+		return ret;
+	}
+
+	dev_err(&sca_data->spi->dev, "device status: 0x%x\n",
+		(u16)(val & SCA3300_STATUS_MASK));
+	return 0;
+}
+
+static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
+{
+	int ret;
+
+	mutex_lock(&sca_data->lock);
+	sca_data->txbuf[0] = 0x0 | (reg << 2);
+	ret = sca3300_transfer(sca_data, val);
+	mutex_unlock(&sca_data->lock);
+	if (ret == -EINVAL)
+		ret  = sca3300_error_handler(sca_data);
+
+	return ret;
+}
+
+static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
+{
+	int reg_val = 0;
+	int ret;
+
+	mutex_lock(&sca_data->lock);
+	sca_data->txbuf[0] = BIT(7) | (reg << 2);
+	put_unaligned_be16(val, &sca_data->txbuf[1]);
+	ret = sca3300_transfer(sca_data, &reg_val);
+	mutex_unlock(&sca_data->lock);
+	if (ret == -EINVAL)
+		ret  = sca3300_error_handler(sca_data);
+
+	return ret;
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
+	int idx = -1;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val)
+			return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
+			if (val2 == sca3300_accel_scale[i][1]) {
+				idx = i;
+				break;
+			}
+		}
+		if (idx == -1)
+			return -EINVAL;
+
+		return sca3300_write_reg(data, SCA3300_REG_MODE, idx);
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		if (ret < 0)
+			return ret;
+		/* freq. change is possible only for mode 3 and 4 */
+		if (reg_val == 2 && val == sca3300_lp_freq[3])
+			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
+		else if (reg_val == 3 && val == sca3300_lp_freq[2])
+			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
+		else
+			return -EINVAL;
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
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		if (ret < 0)
+			return ret;
+		*val = 0;
+		*val2 = sca3300_accel_scale[reg_val][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		if (ret < 0)
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
+		if (ret < 0) {
+			dev_err(&data->spi->dev,
+				"failed to read register, error: %d\n", ret);
+			goto out;
+		}
+		((s16 *)data->scan.channels)[i++] = val;
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
+	int ret;
+	int value = 0;
+
+	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
+				SCA3300_VALUE_SW_RESET);
+	if (ret != 0)
+		return ret;
+	/* wait at least 1ms after SW-reset command */
+	usleep_range(1e3, 10e3);
+
+	/* wait 15ms for settling of signal paths */
+	usleep_range(15e3, 50e3);
+	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
+	if (ret != 0)
+		return ret;
+
+	if (value != SCA3300_DEVICE_ID) {
+		dev_err(&sca_data->spi->dev,
+			"device id not expected value, %d != %u\n",
+			value, SCA3300_DEVICE_ID);
+		return -EIO;
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
+	if (reg > SCA3300_SELBANK)
+		return -EINVAL;
+
+	if (!readval)
+		return sca3300_write_reg(data, reg, writeval);
+
+	ret = sca3300_read_reg(data, reg, &value);
+	if (ret < 0)
+		return ret;
+
+	*readval = (unsigned int)value;
+
+	return 0;
+}
+
+static int sca3300_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals,
+			      int *type,
+			      int *length,
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
+	if (!indio_dev) {
+		dev_err(&spi->dev,
+			"failed to allocate memory for iio device\n");
+		return -ENOMEM;
+	}
+
+	sca_data = iio_priv(indio_dev);
+	mutex_init(&sca_data->lock);
+	sca_data->spi = spi;
+
+	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &sca3300_info;
+	indio_dev->name = SCA3300_ALIAS;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = sca3300_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
+	indio_dev->available_scan_masks = sca3300_scan_masks;
+
+	ret = sca3300_init(sca_data, indio_dev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to init device, error: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      sca3300_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev,
+			"iio triggered buffer setup failed, error: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "iio device register failed, error: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id sca3300_dt_ids[] = {
+	{ .compatible = "murata,sca3300"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
+
+static struct spi_driver sca3300_driver = {
+	.driver = {
+		.name		= SCA3300_ALIAS,
+		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(sca3300_dt_ids),
+	},
+
+	.probe	= sca3300_probe,
+};
+
+module_spi_driver(sca3300_driver);
+
+MODULE_AUTHOR("Tomas Melin <tomas.melin@vaisala.com>");
+MODULE_DESCRIPTION("Murata SCA3300 SPI Accelerometer");
+MODULE_LICENSE("GPL v2");
-- 
2.21.3

