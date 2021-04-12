Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AA35BB4F
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhDLHv5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 03:51:57 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:63973
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237006AbhDLHv5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Apr 2021 03:51:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goFGJGlzK26Mralm29FSdRE5lHM2qKOgGpk9pH276FCrJk/oa/LY+r3wsKr0eCh3gc45g4zb3bo/mpUniXLZx/SFZkJZR7ik0jiTHbBNJtYXOzjx4foTr6u/mV7la9jtkdK7LLBVHi/J3AYmrzWY4xAUoRk4SSAbd9d/MLydUd/NkU71pi/rzAnx+ieTnWIvVLcCQi6ZhWIItgRMwXT/tgsQ5KZdeAlJyFZzqfxvCUsaWbwWSp9guxTYX5P3KdupjUKAW5WQhxWLLxp1tYOjK/3AFYtSPCcp+RITESUQw4ixQqKw3be+Oaj9kFGjzYM6BbiJc6MdL8udk2A/5Pzgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXvczROeyOv1kjtBmCwWniaDtcDE77UL5IpLHZSa1xs=;
 b=BTq+/ijg3BFm5FfpJEgCrFBTso3nvsXcOAGZ/ZwxEooz31BekkeT5ZVslWWYQPAj+Bkdjw3MVAnU3bCdSPJ0g2sI45JYp9ga51BxXn1eyYQh8tUdLy6VE6XXwYBJsoPOlx01C6EAhzOKweZDnxNjxm19Xs9HJhu40QcjNiFWLpiQDWNwCvCjMYzTwGJoRIp9AWDZcqk/YqPHabymv+kfk9fXiaW3C+PNFFI4gIzcBRvEq64h/JIXo9EFOxE03Z/ZwESg0S2qIqskiCn2wI+EnIK7At8n+8hxYS1CKzP00oajVX3BnNNjIOPkH2lWXKSHYLin6twXPdWDc29MxneWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXvczROeyOv1kjtBmCwWniaDtcDE77UL5IpLHZSa1xs=;
 b=wrQ2xemID86icOaJX9tLR4cjEDJZqLCxKGHW2RqpBO+d5UHj4mpPD7pJgrfgu93EBW45WUCX1FxlnjrKaJvu1ollGH2a1xsKBeGB5i75RW0zmP3ajLTOCJkX5/xOXbdyhP/tUWyupf+nQ1MXYMKVeouiksQUAZ6nH6Tn9VWMYzq637eRjTor8SqDKD1JkFskZyJ9LptN2orddlJuWMmKZK+vPMwAvdGAky39hycmpazvIUVC3ORh9ULFi5UwNVMesJBOIWbIBRsWfAphyfdIvyTTlWAEmDuGzlHl+R7ZRSfWqeE40eZN4iJI+VeIMwPkj904clwIg3O1FGgZJYu+LA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB6800.eurprd06.prod.outlook.com
 (2603:10a6:800:18c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 07:51:36 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 07:51:36 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
Date:   Mon, 12 Apr 2021 10:50:56 +0300
Message-Id: <20210412075056.56301-3-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210412075056.56301-1-tomas.melin@vaisala.com>
References: <20210412075056.56301-1-tomas.melin@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0901CA0054.eurprd09.prod.outlook.com
 (2603:10a6:3:45::22) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1PR0901CA0054.eurprd09.prod.outlook.com (2603:10a6:3:45::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 07:51:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cec2714-7b9c-4f4c-8c5a-08d8fd87cc08
X-MS-TrafficTypeDiagnostic: VI1PR06MB6800:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB68003BDB9500347749F942B6FD709@VI1PR06MB6800.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlwdvkyfBI1Nm1bGv4gFV3MR5WUpl8fBFL4WPapkzO0/G/yvy0zdviMamYCsKYprhZMHIF9yF3wzKeivYFwLX9RfENF1LDnoQZfOzKyEhh9euuGLnCiJ6iGdiRQi96KyOdjNhhCeWC2ovDzSOl8cjlWd5EqBA+y/Wx3XvaoQ0G0n5sMnDNWNevAFZxOEaXjPRDU055NdWUbiBOx9foBK8A7j4wJCOhxHnus86zHkHP4QTMiqXneFKjzYCCJwEhOT+VJ+rmhmnPlRK8CPLK9n32WliJyYZOKa3QOy1+Eh2DYUyxlcTZmfzx6BL0jVcMJHIzdQyCZG47nbOXKRUkeuj6ApMC2fhA0GdWim8tzBnWfa2R1NaqvC84R/GVLc5ardUO19kNh4iyOdSHXXNBoK67PxzmPnsftSajsNPaZq9R/QyfZfjMtmpwl3z2gFta0nGY9U+1zVxg2kLfJc3s6jhVptivo/SMTy3hNkGWXkRoubZl1wOYEUYiWW3QpukQ9H2Vre5FnpJK4rD55KuPiHdry2hKK4K9BHLsgz/xZi0dOUBw200AydjpSYuTEzWxzpTDecmqbK8o7fnHoehRnIZASkTZ/HgmBOBgHAl+x+LkQGZSs+ZlsdtkIk8JVvriGKZr+0mL4T8aIRW1acrLknjPKbRDZf+zywFKEH08x9G6ahs2bMGMbd8rDf1B+fCnoiNzfFAkJBTCIiimJQ7DXe4uLw22ie09ZesZv6ISZED2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39850400004)(36756003)(8676002)(478600001)(8936002)(6666004)(5660300002)(1076003)(38100700002)(26005)(30864003)(38350700002)(86362001)(6486002)(966005)(316002)(4326008)(66946007)(83380400001)(66556008)(2906002)(956004)(2616005)(186003)(7696005)(44832011)(16526019)(52116002)(66476007)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rDVMQOZX9cuyjtweYrgOH3SP5TJmBZnNvPRucJ4ifIxlUCnd+RUcOKxLfo3V?=
 =?us-ascii?Q?hsOyr5vKp+go90RU61jg6VKEvMWNHXjXsiBPynGAXp354s4CPrafCyq8cfTG?=
 =?us-ascii?Q?whJHSdaJB3XhET6hUuq1p0y2tOXVMPeKqDnXeg+fiD+ldwK21lmKRVl4lTP/?=
 =?us-ascii?Q?Tv/aUMa+ptDRE7MSndAJO6SXiGEKjd8CO1yu9NN6pWRaWyDGkqVzy0aO+6UP?=
 =?us-ascii?Q?+jHubrBEZwehHw0CkkJ27z0liw2sOWL8eLY0DysDbEH42lRKLVRI3IZDu6hd?=
 =?us-ascii?Q?p9gWDaYBKB+OXVsxYEV1Xa1guY35wzcS/sxV8BfJ6hfg/ZyD6UwzqDlGOqKK?=
 =?us-ascii?Q?6ZGiyPQq3eAHV7zgIqJVoN0duElaF4Ieau44k67cWnHLdOYlSe8a4PUdGQDi?=
 =?us-ascii?Q?/4Nzppcy06+3hSN4SjYd3jHgay8daQPsS+lb26DgNr/WKoj89M1rwk+R1Ih1?=
 =?us-ascii?Q?9u6R5IE9TQLS7TqeywJk8jWOPGuNIUnTjI3nrJNlBExoyJ5M15rL3ge2GBN2?=
 =?us-ascii?Q?+IVUBt20SZFQGtwJhIu86csICuT11NmwwPw7c96v6W+0wdgMzXq5AfdgpCf3?=
 =?us-ascii?Q?ImduoR7zyqWywzTNl3GUA76QV3Et4IVbcALNmZpC7GE/F9zRInWG3uoGY99d?=
 =?us-ascii?Q?wHLVhyMJNNz2oqFoDYY6vJsYodaGL4Q+JccA+CXhZi2tPupAKznxtom8gPYJ?=
 =?us-ascii?Q?KLNx2xj1irr55kr6JMeovd2dBotovDXCLKvKTQhSc4MCbvILLe/eUW3rzvj7?=
 =?us-ascii?Q?9d4PGFZW5W7gCLuSMf7bg3lWIKqWkh9ugQHxFlD4x4d+OlpjYxYzhNSLa1q9?=
 =?us-ascii?Q?ywpsTz9HvxwzUrvv0QJQtJyzMtw6Q+1lu3gLU3oaCWbXJJxV50+gip8s2u43?=
 =?us-ascii?Q?gjn1XYEIMVY57bVKtR1SPTvpiSdEfZMvHr2dSAo7OKf64mJAM+FL0v4TmoiD?=
 =?us-ascii?Q?YrEh6Cwgj8CMkZmBtD/c1bB0GIL8PRVwp8hiJ2MY40VqqE3abjvFTQVzosAv?=
 =?us-ascii?Q?jgAu/jA9rZofBYd5O4WqkAb6r8My1wY4dlQ1Wox3CC1lgnFOrQEjq5IA1mfZ?=
 =?us-ascii?Q?dFN8dYroH7QCI89TCmGuDImvBlso5RTWEbMY4li25VULLjDfuc5g5k38Hzv6?=
 =?us-ascii?Q?2Pr7jrajleTBXFJbYk46YaolXnKB6d5uBkIBLDhEFh4tMNkgyehJO/+y3izC?=
 =?us-ascii?Q?Z/uGOpV1oUVj76yIiV7CZVNTC3AYsRNnvKffUA6HvNRMMtpmZrCjGgCgL4mA?=
 =?us-ascii?Q?WrTgM0mULCkbeQ/j7GlRUTmNMYjwtJ09XqTq63MzSfgkMWQoss2Zcfl0YF0F?=
 =?us-ascii?Q?VXE8cBucGV5+ESEdzEoHfaFt?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cec2714-7b9c-4f4c-8c5a-08d8fd87cc08
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 07:51:36.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Og+XKvFcPiUOFpfPNoz0jwZJiSRZ9RVUOlO2MMm4KLMyknCxxNAStlY578pFkqXQx9K+K64SMF89cuvLqPQNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6800
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
 drivers/iio/accel/Kconfig   |  13 ++
 drivers/iio/accel/Makefile  |   1 +
 drivers/iio/accel/sca3300.c | 434 ++++++++++++++++++++++++++++++++++++
 3 files changed, 448 insertions(+)
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
index 000000000000..112fb88ecd3a
--- /dev/null
+++ b/drivers/iio/accel/sca3300.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Vaisala Oyj. All rights reserved.
+ */
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
+#define SCA3300_X_READ 0
+#define SCA3300_X_WRITE BIT(7)
+#define SCA3300_DEVICE_ID 0x51
+#define SCA3300_RS_ERROR 0x3
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
+		.address = reg,						\
+		.modified = 1,						\
+		.channel2 = IIO_MOD_##axis,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_PROCESSED),	\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.scan_index = index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.shift = 0,					\
+			.endianness = IIO_CPU,				\
+		},							\
+	}
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
+static const int sca3300_accel_scale[] = {2700, 1350, 5400, 5400};
+
+static const unsigned long sca3300_scan_masks[] = {
+	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
+	BIT(SCA3300_TEMP),
+	0};
+
+/**
+ * SCA3300 device data
+ *
+ * @spi SPI device structure
+ * @opmode Device operation mode
+ * @lock Data buffer lock
+ * @txbuf Transmit buffer
+ * @rxbuf Receive buffer
+ * @scan Triggered buffer. Four channel 16-bit data + 64-bit timestamp
+ */
+struct sca3300_data {
+	struct spi_device *spi;
+	u32 opmode;
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
+	ret = spi_sync_transfer(sca_data->spi, xfers, 2);
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
+		return rs;
+
+	*val = (s16)(sca_data->rxbuf[2] | (sca_data->rxbuf[1] << 8));
+
+	return 0;
+}
+
+static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
+{
+	int ret;
+
+	mutex_lock(&sca_data->lock);
+	sca_data->txbuf[0] = SCA3300_X_READ | (reg << 2);
+	ret = sca3300_transfer(sca_data, val);
+	if (ret > 0) {
+		sca_data->txbuf[0] = SCA3300_X_READ | (SCA3300_REG_STATUS << 2);
+		ret = sca3300_transfer(sca_data, val);
+		/* status 0 = startup, 0x2 = mode change */
+		if (ret > 0 && *val != 0 && *val != 0x2) {
+			dev_err_ratelimited(&sca_data->spi->dev,
+					    "device status: %x\n",
+					    (u16)*val);
+			mutex_unlock(&sca_data->lock);
+			return -EIO;
+		}
+		if (ret > 0)
+			ret = 0;
+	}
+	mutex_unlock(&sca_data->lock);
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
+	sca_data->txbuf[0] = SCA3300_X_WRITE | (reg << 2);
+	sca_data->txbuf[1] = val >> 8;
+	sca_data->txbuf[2] = val & 0xFF;
+	ret = sca3300_transfer(sca_data, &reg_val);
+	if (ret > 0) {
+		sca_data->txbuf[0] = SCA3300_X_READ | (SCA3300_REG_STATUS << 2);
+		ret = sca3300_transfer(sca_data, &reg_val);
+		/* status 0 = startup, 0x2 = mode change */
+		if (ret > 0 && reg_val != 0 && reg_val != 0x2) {
+			dev_err_ratelimited(&sca_data->spi->dev,
+					    "device status: %x\n",
+					    (u16)reg_val);
+			mutex_unlock(&sca_data->lock);
+			return -EIO;
+		}
+		if (ret > 0)
+			ret = 0;
+	}
+	mutex_unlock(&sca_data->lock);
+
+	return ret;
+}
+
+static int sca3300_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct sca3300_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val < 0 || val > 3)
+			return -EINVAL;
+		return sca3300_write_reg(data, SCA3300_REG_MODE, val);
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
+		*val = sca3300_accel_scale[reg_val];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
+		if (ret < 0)
+			return ret;
+		*val2 = sca3300_accel_scale[reg_val];
+		ret = sca3300_read_reg(data, chan->address, val);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_FRACTIONAL;
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
+	s64 time_ns = iio_get_time_ns(indio_dev);
+	int bit, ret, val, i = 0;
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		ret = sca3300_read_reg(data, sca3300_channels[bit].address,
+				       &val);
+		if (ret < 0)
+			goto out;
+		if (ARRAY_SIZE(data->scan.channels) > i)
+			((s16 *)data->scan.channels)[i++] = val;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int sca3300_init(struct sca3300_data *sca_data,
+			struct iio_dev *indio_dev)
+{
+	int ret;
+	int value = 0;
+
+	if (sca_data->opmode < 1 || sca_data->opmode > 4)
+		return -EINVAL;
+
+	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
+				SCA3300_VALUE_SW_RESET);
+	if (ret != 0)
+		return ret;
+	usleep_range(2e3, 10e3);
+
+	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
+				sca_data->opmode - 1);
+	if (ret != 0)
+		return ret;
+	msleep(100);
+	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
+	if (ret != 0)
+		return ret;
+
+	if (value != SCA3300_DEVICE_ID) {
+		dev_err(&sca_data->spi->dev, "device id not expected value\n");
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
+	if (reg > 0x1f)
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
+static const struct iio_info sca3300_info = {
+	.read_raw = sca3300_read_raw,
+	.write_raw = sca3300_write_raw,
+	.debugfs_reg_access = &sca3300_debugfs_reg_access,
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
+	spi_set_drvdata(spi, indio_dev);
+
+	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &sca3300_info;
+	indio_dev->name = SCA3300_ALIAS;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
+	indio_dev->channels = sca3300_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
+	indio_dev->available_scan_masks = sca3300_scan_masks;
+
+	if (spi->dev.of_node) {
+		ret = of_property_read_u32(spi->dev.of_node, "murata,opmode",
+					   &sca_data->opmode);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = sca3300_init(sca_data, indio_dev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to init device, error: %d\n", ret);
+		return ret;
+	}
+
+	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
+					 sca3300_trigger_handler, NULL);
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
+		iio_triggered_buffer_cleanup(indio_dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sca3300_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	iio_triggered_buffer_cleanup(indio_dev);
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
+	.remove	= sca3300_remove,
+};
+
+module_spi_driver(sca3300_driver);
+
+MODULE_AUTHOR("Tomas Melin <tomas.melin@vaisala.com>");
+MODULE_DESCRIPTION("Murata SCA3300 SPI Accelerometer");
+MODULE_LICENSE("GPL v2");
-- 
2.21.3

