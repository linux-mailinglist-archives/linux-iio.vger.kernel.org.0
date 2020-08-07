Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459C523EEEA
	for <lists+linux-iio@lfdr.de>; Fri,  7 Aug 2020 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgHGOSD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Aug 2020 10:18:03 -0400
Received: from mail-eopbgr60107.outbound.protection.outlook.com ([40.107.6.107]:27790
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgHGOSD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Aug 2020 10:18:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/S2V0/ZacFQlCPJ10p2KGVbmk2b/z5yOe22M7fq2kzEfNVfiHWnh7Ac+SsL9THA+e0oeXznfHt2uQt9gtWM7l7isgo16hKXlJONVq1tTnx5Rfo2TcYeXcbj4SsGTdpTTmr2+XGvoTc7calqgYSqkY88VMdDHeWH0nhsszOQklbY2BN5NqZ3PnbMfpegjZEoqfuo4E1iYntTmmCqgkhkshtzblSe4GAQPraj7u24BZiuVsVeroMC0Lp2WrHAzu0acXApQ2dUMqfFw2tgGgcN435F4o1TME0/ZeJJldmcV4h2oZ/quOr01h4OE8om3G7hW0TYwezl2gArteHQQ3XvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfLjByAxJMQqHQzyeqkkJfNu8kyi+HgZtkalql5sXRQ=;
 b=J0lFUviWGYA7YWkJ1egF+uyMVHlmoVCJwxl6nw3BArBuG8H6weFQazhTAamgKJ7mz6HupNmevcmIJ9Zie8Qx/HbpWoWgFUHrRdbdFfS6NFDj9g/GPtI55B7TJBgPVmw18h7pXZ9SL+Kvj9P+SV/bZJIKbY8O82tXsk7Migh+CItGB2eSxJYGAX2xdvCAYjdsdMWTPbUqKlKM3w/zHlsgvxg1ISOyH5ZvFZdJ2S2I5sqbTxh/kMDyVak0btOZuTOGhUj/80c8eRZVLg+yrOfA2KfmEcAE/c3/2i2DXL1IE2yQx0m7+EpbPkSxOFje8Hz1cV826IfBoe+v1qMUKIdMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfLjByAxJMQqHQzyeqkkJfNu8kyi+HgZtkalql5sXRQ=;
 b=p068Tpno8ZHLv6llyEcJKJglx9vCtLmgPOjwTyG6IQqKgAl8Ccm0G1BlbjdiX1tKyWmCx8XCd4booXo5I1bCNM7nFr2MwsE8rdaBHoYqzKn6yw48CrNaz4Xdd8DLNkYNIaP9+W3jkHbH8SitRvTyLra5c/eKAVvSzJsoXsu57CQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB5431.eurprd06.prod.outlook.com (2603:10a6:20b:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 14:17:57 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::3c50:d581:638e:fe8d%6]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 14:17:57 +0000
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     development@norphonic.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v10 1/2] iio: humidity: Add TI HDC20x0 support
Date:   Fri, 07 Aug 2020 16:17:55 +0200
Message-ID: <86imdu35gs.fsf@norphonic.com>
Content-Type: text/plain
X-ClientProxiedBy: SV0P279CA0030.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:f10:12::17) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by SV0P279CA0030.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Fri, 7 Aug 2020 14:17:56 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b3a1498-18fa-4106-cb4d-08d83adcaeaa
X-MS-TrafficTypeDiagnostic: AM6PR06MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB5431714E61210F0674E173B6CA490@AM6PR06MB5431.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11PaNZm1rd/ywBOk8tZjAbJwgCbi02HjNW8M7ClXjfQRDCYYfJl9IdZ8SUh+Owo9wPF23C5wNaF/N9RFAWzqp9O7kPY4pgYjJfIC+Yv1XildzLwveqUKYAscScnnHnZwPM/VBGx4nL0wzTuKcBtfGj7DztHBzvFT3es59lsDG2Zv1Y4vYQxqDwuBHjJm5YCTuSrtmuiqihRdCBygs89vDgOC0i6YIztIvbRqs/FHiA/Gy2QIlkQahJ8HhFCZ41ERSvLH8TVq3icc0TfAcAlwuE+MzH8z0Nb2SINAgcx1/yLilm/z8oT96Qp3pRfUZ/LXRmZCHJex8G6gtvTpG87bq4ay9l5N5C1OWvKR+xBzXWmrHlSenBZITwbm1UnAku+eUfpxrgsnkNtNHlYtSuYgVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39830400003)(366004)(396003)(6486002)(2906002)(66946007)(8936002)(7696005)(2616005)(4001150100001)(956004)(66556008)(66476007)(52116002)(30864003)(54906003)(83380400001)(8676002)(6916009)(508600001)(36756003)(316002)(4326008)(26005)(86362001)(186003)(16526019)(5660300002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YMCYjPaIZGdjH59XquPlnX+V5uGiuJcw/HfqeoHsoSwT+ZdFtWgTuGeUf/29D3vQNBfQdrkd0n1Ypah8/0NnBap8yps80jv6FKEVCRuks40mqG6fg94iLuJre15DkZK4odLlJWpEB8lHjkIR8O6xbD9zDS4cxUJnIqtrFZiNT7AlSLPHcnC+viQOq3+yj7i3uR617V6YSNR751LFssO8er2G91zgI2G53RrN3nxfURCOGLQRR6qHBShRmkgdOlKSVjaXG8ef3QUO5sLPotulQ9WQ5GfBJXds71TrbgkMqihfbN9baWeRot06wD4kC4fxcW5Jhjt9/e0p6h+EcYLXBd5NRDMABd0ynNCx72k1SF89NuuwHXD8e1JvNZg9cZ8ft5hSwIYffZBznqvKiPbAas53ji9uDWHzOxzlKyVpPE3HXM5UuELCmgF0yw19g7Be1QYeiZI7uOlNCLxB+TGw28gOanG6CPJOKldYCF1iT2bnZzulqTxXj63h5IzQJfQFk2IewdaVIE6fIHwNjrqBBZZbbTxsqD9AUp0s7VSINxnY4zfJ8LHAA1TeC8nGw0KX34Ic9lgFl62XMoOeuioIIz6RWMRF5CWGYtLRKRa0FyR6w4WAo4ZtouO/KZ02QLGS4G42IR6Ma0g3XkmX3/Rf4A==
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3a1498-18fa-4106-cb4d-08d83adcaeaa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 14:17:57.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVu7ZGYa7mHohGO2sDmjCxEl6mZ76qsfdIGn38oQ2CpWKp/IHrtLZetnZbvDcijYAEO1al9/UI7t2gHVuC7oNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5431
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver support for HDC2010/2080 series devices and sysfs
documentation for their heater element.

HDC2010 is an integrated high-accuracy humidity and temperature sensor
with very low power consumption. The device includes a resistive heating
element. The temperature range is -40C to 125C with 0.2C
accuracy. Humidity measurement is 0 to 100% with 2% RH accuracy.

Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>

---

Heater capabilities are kept as IIO_CONST_ATTR for backwards
compatibility (subject to further change).

Changes since v9:
 - style and formatting changes after the feedback

diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 linux-5.3.8_hdc2010/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
--- linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_hdc2010/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	2019-12-02 11:09:25.803326999 +0100
@@ -0,0 +1,9 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
+KernelVersion:	5.3.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Controls the heater device within the humidity sensor to get
+		rid of excess condensation.
+
+		Valid control values are 0 = OFF, and 1 = ON.
diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
--- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-08-07 14:59:31.930027709 +0200
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hdc2010.c - Support for the TI HDC2010 and HDC2080
+ * temperature + relative humidity sensors
+ *
+ * Copyright (C) 2020 Norphonic AS
+ * Author: Eugene Zaikonnikov <ez@norphonic.com>
+ *
+ * Datasheet: https://www.ti.com/product/HDC2010/datasheet
+ * Datasheet: https://www.ti.com/product/HDC2080/datasheet
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/bitops.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define HDC2010_REG_TEMP_LOW			0x00
+#define HDC2010_REG_TEMP_HIGH			0x01
+#define HDC2010_REG_HUMIDITY_LOW		0x02
+#define HDC2010_REG_HUMIDITY_HIGH		0x03
+#define HDC2010_REG_INTERRUPT_DRDY		0x04
+#define HDC2010_REG_TEMP_MAX			0x05
+#define HDC2010_REG_HUMIDITY_MAX		0x06
+#define HDC2010_REG_INTERRUPT_EN		0x07
+#define HDC2010_REG_TEMP_OFFSET_ADJ		0x08
+#define HDC2010_REG_HUMIDITY_OFFSET_ADJ		0x09
+#define HDC2010_REG_TEMP_THR_L			0x0a
+#define HDC2010_REG_TEMP_THR_H			0x0b
+#define HDC2010_REG_RH_THR_L			0x0c
+#define HDC2010_REG_RH_THR_H			0x0d
+#define HDC2010_REG_RESET_DRDY_INT_CONF		0x0e
+#define HDC2010_REG_MEASUREMENT_CONF		0x0f
+
+#define HDC2010_MEAS_CONF			GENMASK(2, 1)
+#define HDC2010_MEAS_TRIG			BIT(0)
+#define HDC2010_HEATER_EN			BIT(3)
+#define HDC2010_AMM				GENMASK(6, 4)
+
+struct hdc2010_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u8 measurement_config;
+	u8 interrupt_config;
+	u8 drdy_config;
+};
+
+enum hdc2010_addr_groups {
+	HDC2010_GROUP_TEMP = 0,
+	HDC2010_GROUP_HUMIDITY,
+};
+
+struct hdc2010_reg_record {
+	unsigned long primary;
+	unsigned long peak;
+};
+
+static const struct hdc2010_reg_record hdc2010_reg_translation[] = {
+	[HDC2010_GROUP_TEMP] = {
+		.primary = HDC2010_REG_TEMP_LOW,
+		.peak = HDC2010_REG_TEMP_MAX,
+	},
+	[HDC2010_GROUP_HUMIDITY] = {
+		.primary = HDC2010_REG_HUMIDITY_LOW,
+		.peak = HDC2010_REG_HUMIDITY_MAX,
+	},
+};
+
+static IIO_CONST_ATTR(out_current_heater_raw_available, "0 1");
+
+static struct attribute *hdc2010_attributes[] = {
+	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group hdc2010_attribute_group = {
+	.attrs = hdc2010_attributes,
+};
+
+static const struct iio_chan_spec hdc2010_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.address = HDC2010_GROUP_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_PEAK) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.address = HDC2010_GROUP_HUMIDITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_PEAK) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.extend_name = "heater",
+		.output = 1,
+	},
+};
+
+static int hdc2010_update_drdy_config(struct hdc2010_data *data,
+					     char mask, char val)
+{
+	u8 tmp = (~mask & data->drdy_config) | val;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					HDC2010_REG_RESET_DRDY_INT_CONF, tmp);
+	if (ret)
+		return ret;
+
+	data->drdy_config = tmp;
+
+	return 0;
+}
+
+static int hdc2010_get_prim_measurement_word(struct hdc2010_data *data,
+					     struct iio_chan_spec const *chan)
+{
+	struct i2c_client *client = data->client;
+	s32 ret;
+
+	ret = i2c_smbus_read_word_data(client,
+			hdc2010_reg_translation[chan->address].primary);
+
+	if (ret < 0)
+		dev_err(&client->dev, "Could not read sensor measurement word\n");
+
+	return ret;
+}
+
+static int hdc2010_get_peak_measurement_byte(struct hdc2010_data *data,
+					     struct iio_chan_spec const *chan)
+{
+	struct i2c_client *client = data->client;
+	s32 ret;
+
+	ret = i2c_smbus_read_byte_data(client,
+			hdc2010_reg_translation[chan->address].peak);
+
+	if (ret < 0)
+		dev_err(&client->dev, "Could not read sensor measurement byte\n");
+
+	return ret;
+}
+
+static int hdc2010_get_heater_status(struct hdc2010_data *data)
+{
+	return !!(data->drdy_config & HDC2010_HEATER_EN);
+}
+
+static int hdc2010_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct hdc2010_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		int ret;
+
+		if (chan->type == IIO_CURRENT) {
+			*val = hdc2010_get_heater_status(data);
+			return IIO_VAL_INT;
+		}
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		mutex_lock(&data->lock);
+		ret = hdc2010_get_prim_measurement_word(data, chan);
+		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_PEAK: {
+		int ret;
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		mutex_lock(&data->lock);
+		ret = hdc2010_get_peak_measurement_byte(data, chan);
+		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
+		/* Scaling up the value so we can use same offset as RAW */
+		*val = ret * 256;
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val2 = 65536;
+		if (chan->type == IIO_TEMP)
+			*val = 165000;
+		else
+			*val = 100000;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -15887;
+		*val2 = 515151;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hdc2010_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct hdc2010_data *data = iio_priv(indio_dev);
+	int new, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT || val2 != 0)
+			return -EINVAL;
+
+		switch (val) {
+		case 1:
+			new = HDC2010_HEATER_EN;
+			break;
+		case 0:
+			new = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mutex_lock(&data->lock);
+		ret = hdc2010_update_drdy_config(data, HDC2010_HEATER_EN, new);
+		mutex_unlock(&data->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info hdc2010_info = {
+	.read_raw = hdc2010_read_raw,
+	.write_raw = hdc2010_write_raw,
+	.attrs = &hdc2010_attribute_group,
+};
+
+static int hdc2010_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct hdc2010_data *data;
+	u8 tmp;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter,
+	    I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	/*
+	 * As DEVICE ID register does not differentiate between
+	 * HDC2010 and HDC2080, we have the name hardcoded
+	 */
+	indio_dev->name = "hdc2010";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &hdc2010_info;
+
+	indio_dev->channels = hdc2010_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hdc2010_channels);
+
+	/* Enable Automatic Measurement Mode at 5Hz */
+	ret = hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);
+	if (ret)
+		return ret;
+
+	/*
+	 * We enable both temp and humidity measurement.
+	 * However the measurement won't start even in AMM until triggered.
+	 */
+	tmp = (data->measurement_config & ~HDC2010_MEAS_CONF) |
+		HDC2010_MEAS_TRIG;
+
+	ret = i2c_smbus_write_byte_data(client, HDC2010_REG_MEASUREMENT_CONF, tmp);
+	if (ret) {
+		dev_warn(&client->dev, "Unable to set up measurement\n");
+		if (hdc2010_update_drdy_config(data, HDC2010_AMM, 0))
+			dev_warn(&client->dev, "Unable to restore default AMM\n");
+		return ret;
+	};
+
+	data->measurement_config = tmp;
+
+	return iio_device_register(indio_dev);
+}
+
+static int hdc2010_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct hdc2010_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	/* Disable Automatic Measurement Mode */
+	if (hdc2010_update_drdy_config(data, HDC2010_AMM, 0))
+		dev_warn(&client->dev, "Unable to restore default AMM\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id hdc2010_id[] = {
+	{ "hdc2010" },
+	{ "hdc2080" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hdc2010_id);
+
+static const struct of_device_id hdc2010_dt_ids[] = {
+	{ .compatible = "ti,hdc2010" },
+	{ .compatible = "ti,hdc2080" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hdc2010_dt_ids);
+
+static struct i2c_driver hdc2010_driver = {
+	.driver = {
+		.name	= "hdc2010",
+		.of_match_table = hdc2010_dt_ids,
+	},
+	.probe = hdc2010_probe,
+	.remove = hdc2010_remove,
+	.id_table = hdc2010_id,
+};
+module_i2c_driver(hdc2010_driver);
+
+MODULE_AUTHOR("Eugene Zaikonnikov <ez@norphonic.com>");
+MODULE_DESCRIPTION("TI HDC2010 humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/Kconfig linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig
--- linux-5.3.8/drivers/iio/humidity/Kconfig	2019-10-29 09:22:48.000000000 +0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig	2019-11-28 14:31:27.794242693 +0100
@@ -38,6 +38,16 @@ config HDC100X
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc100x.

+config HDC2010
+	tristate "TI HDC2010 relative humidity and temperature sensor"
+	depends on I2C
+	help
+	  Say yes here to build support for the Texas Instruments
+	  HDC2010 and HDC2080 relative humidity and temperature sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hdc2010.
+
 config HID_SENSOR_HUMIDITY
 	tristate "HID Environmental humidity sensor"
 	depends on HID_SENSOR_HUB
diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/Makefile linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile
--- linux-5.3.8/drivers/iio/humidity/Makefile	2019-10-29 09:22:48.000000000 +0100
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile	2019-11-28 14:30:40.609892061 +0100
@@ -6,6 +6,7 @@
 obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
+obj-$(CONFIG_HDC2010) += hdc2010.o
 obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o

 hts221-y := hts221_core.o \
