Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB936443D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhDSNZ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 09:25:57 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:25216
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241675AbhDSNY2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Apr 2021 09:24:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbNMEaWcFTutIVKyeyeMEBORA/C7pOKnytwicatgICi4khpBjL96XptMuoxwD7k+ntHkweKf5rMPcfWcomusta4Vvn3C0nhto+9Krb03ShaZQ7rF0ytkyFnJ5k6WLkQ9ALV2D2obVL7/pFqnQz4aBplNa9zqwgjORpYMTsXP7qZS5mV63SV6BaCFC6MCHLoTELDy1R4z7Fr/4KxxvyYblm0VLui4MJhXBQv/nU6rQbAP6uibelBz9U2tK8tzxBFBkdDb3fSJLZUbO3A6NZN8sr3kVdd9CZE/I7k3AofcA3th12BGZUd35Kdq6yVBd0qDyRHJ4hrHhVx+vTuZo9VQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0hzJ9AEPq+Y+82XL2oKKLlU96LxWRimRyIfHTT+rx0=;
 b=a2r4us6j6Eeg5bv1/B6o9Ddp1dumvQpKDxSfCwEspkbl4LQ0TKowMDfN58GQkEiwZ6Ab0Ar7ilRSE+HkOZqq6OCkwlyKzFWs5bQPrsK2AxnUs1GddhBAV28JXYzuabNXrML0FQnKkM4w2uaHmA6oLVdAjZve5mBKO/K+ytrNcXPbYm3EJ/wYIitJ6fJOCboLCUA1q8r50CUtsYXfQmzvBtmzkny8VHblm6DZJqu98AYHVfNs1Qf+Uv1OcAV6bqEXYVAsugFvjucQ/coewXjXV2aDb48YepNXGzH3FWjyKZfUtEHM3w3sJYlKXbua8bNIit+3kKU0AYhcZWtlUWm5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0hzJ9AEPq+Y+82XL2oKKLlU96LxWRimRyIfHTT+rx0=;
 b=ajDgWoGcjNovGZLxootsOsxxSjP8036w0p6hrBCJ3fbH+O+iGDE8axqtFAjgxjt9XpL+NRXYdEETlfNY7Gk+ZdSqDFLbADfIgy3omT19dFeO03rs5HkOOAGNFJ1zWyJb12OeXNT9JS4+dBsXyaY1l9hK1m2rfVCbdLG93AxajQsGSlAiA/qslKddP+iuMfoDQ7uW1eChk9COvaTKFfbfCiK6RKrVX+gld+SCvbPBeE3FFdWeayvlNPf4SA6+pGov8Tmt7wIHN3PzBC+W4eL70HtK2GppwYf4en5vbWCffRYp+PHlbgxoHEFtpxLOARSNU43Oyh1SVQ6ZExXlRi+7nQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR0601MB2109.eurprd06.prod.outlook.com
 (2603:10a6:800:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 13:22:46 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 13:22:46 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v3 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
Date:   Mon, 19 Apr 2021 16:21:59 +0300
Message-Id: <20210419132159.4450-3-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210419132159.4450-1-tomas.melin@vaisala.com>
References: <20210419132159.4450-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.localdomain (85.156.166.106) by HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 13:22:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc866781-a884-4fc4-8fc9-08d9033638dc
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0601MB21096516A9C52B8A7E557B27FD499@VI1PR0601MB2109.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVaPE7r/0yMNz1RV8VCR2goU0ZoxJeT7yCrSjWjryZEL6DPFjwtPCxl0kprG/w71V4nG9PmOAkH2pnsdFGLiF7XGvwF5vKBOp5690uDestCKsp0xBrVda2kWCU3jOi0Yvc92X9JP8681pDahpUCJ2+yrPiVmBA9bAI+Zo1XRGx5IPM7ndE4xJO6B2n3KYUyu7db33P9apwMKd1mDj8DYygCnqOX14se53CUvRUnpSTQat4oQDL7wMzO9c/06+LyDD5ScxWCVk/Bh/JH+ggAs/XF2OA5G8reY5pCiOycEw4Ut9VEsp0XBGNxIqTsaXlcWXLxo5H9Qkfb6N76p7YVaWzx0vUY+QRDdMNEi+FTmGwJGIeW6p2xhDjEe9pFBlinYkkU/AfKrGgQGH7hM2h00vhLzxyFn15e6W5tzmoz6DkBkJPpF0o6TMnLxYr/fVoq48+Hnkq0IJ2CaneHbN3nz/lmOghrZCGwqJuualoYHseyWbl97WPXaRvANS544I4mf8GfMzNMRAFUP/xOJdanVvb9pli0qJ6FNZ3LkbZDRbbtEMsULW17R8IMq+gRRII5hmxlzoj7WkKlUEBIpLNIM/i8ad9Q0XRhFVGmwUFTzXhHBCC+3GfBciA2B05/Ngy7tUATCusf+rDBrfqZtQDtdnVZ58XQ5VP28YRx6zpdn2x5ip4T5Ceq81e0o/LQfT49bIKli1HIda9H4+V9li/1FrwyvbtQBMSgK20YAUEVd3Kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39850400004)(956004)(83380400001)(2616005)(26005)(1076003)(86362001)(6506007)(44832011)(107886003)(966005)(6486002)(478600001)(36756003)(16526019)(5660300002)(186003)(52116002)(6666004)(66946007)(66556008)(8676002)(2906002)(6512007)(4326008)(38350700002)(66476007)(30864003)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZSeodbvWpnPNsTpf7g3VQ+Ac5OIhC0KUkYbIS2Vd8P6R50+7QJMa6IwYHa04?=
 =?us-ascii?Q?KHuOi6kQIVNIsahBmoYTS3OnzjpU6tjtuzQiAg/oYmCf9G6p+wUY9D5No2q4?=
 =?us-ascii?Q?QBfJfXMYgFX8b1oQaVKA9lNh8uhIh9fg0whA4zQnWfVz8Q3idDLkKnKt84sO?=
 =?us-ascii?Q?dWzc1vpkZIiI9XJVSV+CNee0IzqXnAvIDVla4DY/CLRzEBV6kDUQizwGOKr2?=
 =?us-ascii?Q?A5XVHiRa2JC3In/KC296OlJ3TT3N6pPKy3BdCIrxmTfdaRV1DaB2F49na2v7?=
 =?us-ascii?Q?7tyYTfvBvEsxaOqwy3S9iL3VYHcVjtuPY6HH2EPAQHwSIyf54319EMYWQ/Z7?=
 =?us-ascii?Q?hugI49b5TnOpY3CUq68p+MOlKDt+KLyw18FNH+ZYSTO1eORN4Fb0P9DySYXJ?=
 =?us-ascii?Q?jfHqgW5Y8UnYGeH6T5chTbzY79rhFskxMAut+Y3+uqswNmhV14qlAjSClSVI?=
 =?us-ascii?Q?i6pSud6reVv0+S9PDR709+tKyr+yFT4LVZqX1jgmOq9pC30tmdhanySNjyB9?=
 =?us-ascii?Q?YHI+yh6NZS2a2lxZ+hv0DwxVnLY3t/209u4rMr4FEC7Xf8qLsDLTZJSGOhcz?=
 =?us-ascii?Q?SxWx7SzzNEGH0cqnh7A4qbC3qD3KQ1pGhZM1Pfep3rpwJST1qeN4Ppw82kzN?=
 =?us-ascii?Q?UA+0eqLOErjauO9v97qfZR5oYwA4gf2AN0VYxau8VUKOiLerWeOi1mTE602r?=
 =?us-ascii?Q?RORfrBBah3w0ejTdRHQ1Wlzh31Cv/c3q0Q9Vk9hYLniXDVRFeOARQWnYadaE?=
 =?us-ascii?Q?Loy88W5RgEIAlpcL/gQhlfS7Iix6ePBqMzE9950tAdlJvHiPdvuRLfwcUaMs?=
 =?us-ascii?Q?PQcToWmSAUUhNG/zsXL3aBu6J6b3uPgAMUJwGUn4dWu40HdC0VaqAm/7pWMP?=
 =?us-ascii?Q?sWUy+ei+jb9JkeZSQB5qJ5dLQAiOB2Mk7ZdKamXhHB2atqtur3my9iY+oibo?=
 =?us-ascii?Q?hakieifscBsqMssp7gPjHMagR/ybArJSrA1Qd/W8c/KWo5nAeNzOegX30bt2?=
 =?us-ascii?Q?/JqIrJB/r7+tF2rFwwaYHOLlUPsLsZaJWfVl/au4YtREhhu3vROPe+tjjPDN?=
 =?us-ascii?Q?v6tuyr0WRSiyt67tQKdNIEDCmGfLW451CKkEPBnljG/wNTX6gcwnMjlW+ZPv?=
 =?us-ascii?Q?2bzyf+yg++XHraxEB5Yl/OYk/QBUt2ZQyI1muDc9BdtwZqJXGxB6/TSe+rFV?=
 =?us-ascii?Q?oAG5ztisZK12VEd7u0VHyTYSabxBDsX35sXdyDOPqZyCsHXReRupL07AD8oJ?=
 =?us-ascii?Q?q8XnLFU5PtymF1ueAY6MKnDIuIlyL7VGwGcb4D8ZHOlcNPe4ZTGdFk/MYUCO?=
 =?us-ascii?Q?IjemUVUUMvQCBl98uTd9whh8?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc866781-a884-4fc4-8fc9-08d9033638dc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 13:22:46.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxEqUPo96QiixONHVVXzNCI2mNGe2Rk/vvVDyAfXd91NKiTQT1KVme0Nfbf4tjtttfY5WxjAKu5XHbfAMPjhdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2109
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
 drivers/iio/accel/sca3300.c | 462 ++++++++++++++++++++++++++++++++++++
 3 files changed, 476 insertions(+)
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
index 000000000000..bd291ee6e2a4
--- /dev/null
+++ b/drivers/iio/accel/sca3300.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
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
+#define SCA3300_MASK_STATUS	GENMASK(8, 0)
+#define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
+
+#define SCA3300_REG_MODE	0xd
+#define SCA3300_REG_SELBANK	0x1f
+#define SCA3300_REG_STATUS	0x6
+#define SCA3300_REG_WHOAMI	0x10
+
+#define SCA3300_VALUE_DEVICE_ID	0x51
+#define SCA3300_VALUE_RS_ERROR	0x3
+#define SCA3300_VALUE_SW_RESET	0x20
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
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_CPU,				\
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
+	sca_data->txbuf[0] = 0x0 | (SCA3300_REG_STATUS << 2);
+	ret = sca3300_transfer(sca_data, &val);
+	mutex_unlock(&sca_data->lock);
+	/*
+	 * return status error is cleared after reading status register once,
+	 * expect EINVAL here
+	 */
+	if (ret != -EINVAL) {
+		dev_err(&sca_data->spi->dev,
+			"error reading device status: %d\n", ret);
+		return ret;
+	}
+
+	dev_err(&sca_data->spi->dev, "device status: 0x%lx\n",
+		(val & SCA3300_MASK_STATUS));
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
+			dev_err(&data->spi->dev,
+				"failed to read register, error: %d\n", ret);
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
+	int ret;
+	int value = 0;
+
+	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
+				SCA3300_VALUE_SW_RESET);
+	if (ret)
+		return ret;
+
+	/*
+	 * wait 1ms after SW-reset command
+	 * wait 15ms for settling of signal paths
+	 */
+	usleep_range(16e3, 50e3);
+	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
+	if (ret)
+		return ret;
+
+	if (value != SCA3300_VALUE_DEVICE_ID) {
+		dev_err(&sca_data->spi->dev,
+			"device id not expected value, %d != %u\n",
+			value, SCA3300_VALUE_DEVICE_ID);
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
+		return ret;
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

