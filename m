Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA0F3659EC
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhDTNYl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 09:24:41 -0400
Received: from mail-vi1eur05on2079.outbound.protection.outlook.com ([40.107.21.79]:25344
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232359AbhDTNYk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Apr 2021 09:24:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/lPxClqs6MQ6tU8O3NnSix1ZCeVxJ9fSrl9jdtY4peWj3He40ZvQrqgbvgDiBxer89muObpCPLTtNFvdi8HT6tahKD86MG6+sm/Uxg3TU3L9b+YiCXwUGGuhI7UoQcMD6EHxlFnF02x2xCmiJEupdwuyoQ4MwrFWCZMqnF8h0s02ltfg0itv7juu+LdhR2h+zP3bKAlpFcVGfPUbelCS5vpP3OZE6naw73uXniLxrI1Tgczjevae6RtlGKWB7DALGj9o22VDYNlVUlW9di+tV3nM74Y54ZjqpOBrhSo+FDfSZ11sQkK5JSbTBjd21Rmmv74bpUp18sooiCSNJ2XuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly+1Zx5lNK03H/1mSJneMkF+7g0pwO2w8HpS/fRDZa4=;
 b=N+pBTprjteVISy7G9zwBzzScFePwB2kcqU/en68gYdIhDAlf95WD79aWngn/boJivTYIyD4HlmxiuHvZn/hIr6sK6ygm8H3I2PyzNc2XzENvlG6LTfMR+Pf2/MtVbIbYS1Eq5W7OAYGlseGzmyoY5C/GqyvmdDJ0cmTo50GH8GZt8yCQQHOdSY/9KM8GF77jgNqAjdyzn3xxTtKnen3BneiDYtvkHVNDW0aerNvmG9iPoUYRjB2aUWXVS7ytJCTM5vdpr5pAyY2U4G4Gb4aeRI989qaK1a1Zb0x/JFWXjpK7Aaqw/vIHFFCK/aa1lnU5bSEa5En0KoVqbbqZa8cNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly+1Zx5lNK03H/1mSJneMkF+7g0pwO2w8HpS/fRDZa4=;
 b=oBnEx223TdC/bmXl0YsMNTDPoGw9UGOM32M5BdUP6tftZfhzttxKpxmVbErdPUthjPF9d+du1c4GFuv58xKhjLQAFD3eTVStJw77r4JRblGYz9CWQUOPJumpt0LXwJ9nwB+5+u4aKvGP44xk3L03tEzvJ1vZ91AuuJLQHJkRtc8jVifASTXr+NiKMIbSPTJIB8yU2sf0Do/7VdRqKOHyr1z/eZGOiuMc/S4TfsshzDGTF9pQ1mwtpuA8ednqi4kdilexjXqlXSf2laItNJPjYiwohA0OzoKeHfpHXNWBItMY/9NjOsiZD5Vrm3iTpZyjVc1ywWk902YDdQxZLC4OgA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VE1PR06MB7088.eurprd06.prod.outlook.com
 (2603:10a6:800:1a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 13:24:05 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 13:24:05 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v4 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
Date:   Tue, 20 Apr 2021 16:23:33 +0300
Message-Id: <20210420132333.99886-3-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210420132333.99886-1-tomas.melin@vaisala.com>
References: <20210420132333.99886-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 13:24:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7694d2dc-d28d-4ed6-755b-08d903ff9212
X-MS-TrafficTypeDiagnostic: VE1PR06MB7088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR06MB70885E30D03D8C86D4E597FCFD489@VE1PR06MB7088.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+a+GT3og5FIyl4ZlOw6qPScmr6yoMcdCb66kN80WS6fD98BweORpr2i0YMMsjCdAeT1VIkGbbbjc0H2MUbMR2mjUK5bWBd6hi3gr4EI8AbmmemZzW7mfvX7lZpxnSTOEZ1+Ht/xgDpnZ7hTIqmgQ9a7nXoqU0N4w8/3scU1G4tdds4OZnz7z97pIJ/uZrbMRK8h5MGtNRsUZIPdiGfJuHiW158D/Co15nJ59Z1A6JozTslcMAubghNnO3lHRpEquqwQD5S1Sw5FYZoX3ax8TT3nmrmj5QAVU0L1IK+S/NjQKn1pq6FL8qIUT5M8enOmrdn8dk18FxS4Bw5TG+uiOELwYeK18hVuQgxiCxcvtvPejapLNDqTJtE77PPdU0HBRzluTzwsLJbo83Z3imTTzS/OKUA8FGW/JJbC+ldbbow+7dixhLyTU9TwuQE8ttIDluOVE/WjybpqvCklmZBQ/Mp/jt16kExZUMxfQXssMid44G2/Bg2J07rRF4DgjcKMaWkkf9uSZoQbi7QtER7JJ7GLlKDO1FnkBzPzpwedhiZJY+73++GtvAlXVfbW6e5H1csOakrgJJMmm7Pvh/fSnOkIkU2RzEF0rPjfNBEj+KcUNK3L6dxX6QSCnwo/JBMykscJx98ipNkmBuPno1iUYFiiX9yVZtwXdN64AUztaD4mFQ4kN2jOWpRV5tXUso5gEb4FkRlUBmgncTlEaC6sKDrROQF+h2BJgn06JeGK08k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(8936002)(66476007)(30864003)(26005)(86362001)(66946007)(66556008)(4326008)(498600001)(83380400001)(38100700002)(956004)(186003)(38350700002)(8676002)(966005)(7696005)(52116002)(2906002)(5660300002)(44832011)(6486002)(36756003)(6666004)(16526019)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KinTCxEJPkA7bOt2RnSALbw7XbpcDsB+/PqE4KS9aUfTF14AuqQkcQ0OcYAV?=
 =?us-ascii?Q?uRl98qR40/6fvJ3eWE1GHnN7PGu7/edl8KVJsGd9BpiIJczDtwD7D+dBfs1z?=
 =?us-ascii?Q?hrD2C9bIqDjt12qifWAqYbTIPbZlS6+UZYcQl+IaXTei7Qoe19uqVw4NsCjg?=
 =?us-ascii?Q?RZkrgkf5JgKQPNE2O93gThTTIUZ9UquE9odKdvgg9ECfslb7/Kkn0RgvV3yh?=
 =?us-ascii?Q?vSlfaUsB6lMlenXiEzvbCJhD06s2qIv7sOJ9lRIxaqvfaaAN3bZXrTpB1Oil?=
 =?us-ascii?Q?itrZMzYNrnktJBFQ40EkIzQ0iPdyRNvkKvnRkUEFGT0/5ItRpZwK/KtUtSyQ?=
 =?us-ascii?Q?whCgCVwFbc9QZV2sum17jQwd646/K6jer2qaYPc7RzGPLTk1YDJTEv6H8K8D?=
 =?us-ascii?Q?VmFv8Z/0Uk8WpqYT2Cz7TirhZiD+MKy6eXW5sUZkui716JZyLP6NZmnb/T4U?=
 =?us-ascii?Q?r8rO5H2MFeGfaIeRTtjxlezO1BjpZHwExHDRVkmPJEEMc+HkHnV0tlOaElZH?=
 =?us-ascii?Q?+DNldZ/G71tu7nCr9KeEy0liUIfGtQBRDbiFFEEiXQ2pRGu7am0kBLfgdmCq?=
 =?us-ascii?Q?T2JZ1D0yIfDUfOGZRHmszfgqt6bKruNYNHb+t/JRZt+5RAfZZzf2fsd+40Ji?=
 =?us-ascii?Q?TZnStbbe2EAWIZj8NUFsVWlahms+LqGNA4sxVQwRJzX3YGhI99ItbWFE5ju4?=
 =?us-ascii?Q?VTz5gnWKvbo764oFA4t8BjSqNDSrEnsm//teazhpMuBo22rX1Pwvnq8afLPA?=
 =?us-ascii?Q?CI9nC51ggGnsp3ga3ba/iqHuBoy3gnq/ZMV93rW/u9FP4vrDR7NawpgFP3bb?=
 =?us-ascii?Q?3XfIcr4HUwgijMjVMSRmwLuC3mSnc/JnQNF3Vshoup+7D1J4T5//yv4YBqdn?=
 =?us-ascii?Q?Qmqn5TKGHAXegfwtpPU9uxuGUsMywOQQZRRnzaaGgjxKXQcEy+rafnqMlz0j?=
 =?us-ascii?Q?9fndch7UN6d5HCays1+LaOwOUMX+lPgtu8BUK0S6dtNoNw0OXNuusxcGhklE?=
 =?us-ascii?Q?WLY7Orv7beTxmK43KXyIFdpZeq63vTtPuDrDZgc07R5YmRzyY5MUJmMd2jFS?=
 =?us-ascii?Q?5phYZssUf00dMYlww4Nh8q89Fgs212ABKtnVHYrvM5QxhGwR8D25yTecfNvE?=
 =?us-ascii?Q?QPRsgfjpi+8XHk1auSnnQ7Z2CG0rSx4hf9SdUU2COO1fcB+WjEA1lS/JZFZ3?=
 =?us-ascii?Q?T02AdIH08wTfa/K4sPbmVzeTPhfsa4qMPcAVITv5mIKV+EDSxuchIstJTZjr?=
 =?us-ascii?Q?mStqi84aFKBlE+T0o/tS8o9rH7RS6HCLr33SlAew0eW73nHqLHc2inSrxmHx?=
 =?us-ascii?Q?DbwKpYgRJwlkBjixYQ+nJqft?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7694d2dc-d28d-4ed6-755b-08d903ff9212
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 13:24:05.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJvp1VzbgAYTSj6WxE5dI9huWnGoerNvFdgRehwpbIWXo3c8uxxuxc4UCXwNWekCd4P8sFBYwg0y0R6i1SAqRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7088
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
 drivers/iio/accel/sca3300.c | 470 ++++++++++++++++++++++++++++++++++++
 3 files changed, 484 insertions(+)
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
index 000000000000..2be0012471cc
--- /dev/null
+++ b/drivers/iio/accel/sca3300.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Murata SCA3300 3-axis industrial accelerometer
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
+	int ret;
+	int value = 0;
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

