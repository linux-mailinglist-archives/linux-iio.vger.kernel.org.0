Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DE921B44D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 13:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGJLyG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 07:54:06 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com ([40.107.20.134]:44960
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbgGJLyE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 10 Jul 2020 07:54:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3PCLSk9qM8+UoSqFX0zRiKUNfKiSIDH0r02rLT/Z1uEwGxL1ZSlcQFiA84lADlTax1LqIaVgAUTY9aGntoveTKgo6faANH/bmQlqU6UhbAKQqqJHry77tD3mGWQdWX5lFQ+aXkY1OdFWjYSA/lp3ux2F7Q3WxHfKlP34Wjw5RD9+5uXjOuZbQFY2TQjXr1MD/Hr/k+dkJ9wTx4wK5zNSwQD9Dbjcj3cOTmOUjrolfKFmuZltv/cIj3Ku+fZUSd3lWFtl1JN/NoWBjJRCq9wL9seVE8trcwCbZXL3W2qiWYWYvryBQx25OJ/g7CxmmVDn/CzaAKFLOHbuxn9rXh8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPRgo5mSjMIInqGdwrGk8yU/Yhr48+oH/265bzAsLkg=;
 b=b2CkBw1K3A4wFk7yLVxBtXrU3BFGagOHjh0EOyTMGzKXCYHUy5oqn6s9k5cak7O8/7YqBddPDk3F68hoV3rbUUZo/NJCGC4p/k7udTwwvG/Gah+hTm7ocLhskdUARjIhgYGMFLKp6amylfUt0YblKUSNONsV8eELashgguizl9dFLv0CCqSkQEoZIJcQ+ETEkJwuQPLRp4Biepi2+QWvxFkchWKkkrybqt/XdPaxJ2FD0vM0R5ElEMnnVMrpT+y4AE36TKiS+5gOmVoTWBQmWMLsCIRiH0pW3a/rUdJ2ARiLI4SZU7WBEtDFrofPB+7bJLP5EIJSASiv3LeZH//JLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPRgo5mSjMIInqGdwrGk8yU/Yhr48+oH/265bzAsLkg=;
 b=Lt9PW2/X5odtM7kk3HdNTLVV81IEaoUtp9J78IYYvmPmv0EUmAngMZHASMxULLkJzBmEIJoZKrwRRhRAwz+g7LGVz6V2uIm77YScbBgpQ/3V3SAog3GOmRx2aa/TjuNBvs9O+ViIawRk/pZ2wiwHuo3wc/N1WK9gHNwlUxa34m4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB4961.eurprd06.prod.outlook.com (2603:10a6:20b:5d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 11:53:59 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::98d7:2b02:1f27:e8e0%4]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 11:53:59 +0000
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Eugene Zaikonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     <development@norphonic.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
Date:   Fri, 10 Jul 2020 13:53:57 +0200
Message-ID: <86d053d1re.fsf@norphonic.com>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: OL1P279CA0002.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::7) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sta-eugenez.norphonic.com (62.97.226.122) by OL1P279CA0002.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Fri, 10 Jul 2020 11:53:58 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c9248f-37de-4dde-7c7c-08d824c7ee69
X-MS-TrafficTypeDiagnostic: AM6PR06MB4961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB4961647B62AB9BE82EE7C7B5CA650@AM6PR06MB4961.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKXjSX6WwJ7dbD7rMTvNEJjrvV+VJk1I5XkTvnWvAor/VTz03DPUt3TDOJSi2v+73a5btIoaeGYOqYA9D5aGzepWwWkZpEuvmItnQVStAgav7ZENIpPCGNoDaZJQbLwjtKiQIj8XZXcxxCLH8dLJhL7klogsvJK4dC4+d3nUuMuMBHXqsyNcGeLcfQmLrlEGAaaV9Xheh3EytXdI+zkcEzSu2lPp1QUmXTW8WY/rtUv/yfhetw0CYExJe/vCGxf1E2y4q0orb49JdLr0zhvhTx8999Q8YGro6I4ab4U8ZF8C1OnoXL4tSps5NMrvV22u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(396003)(39830400003)(316002)(54906003)(508600001)(6916009)(4326008)(66476007)(66556008)(66946007)(2906002)(66616009)(4001150100001)(956004)(83380400001)(2616005)(8936002)(6486002)(5660300002)(966005)(30864003)(86362001)(52116002)(7696005)(36756003)(26005)(16526019)(186003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /kN4w2hX3OG+KTjuOvG1xtJz1ieiDDjDApGKN/+HnNQVxZAMqt0yxXIUt/353ZzBdH3b2/MQ3b42pPBV14uis4SPFQ3gnUItQEyikz5jrEest0LY2lqVDSsr/GN7KHAtLSunDBZcGPR6DUPyMHOyy4Hkzswy10VBfIXzjlXOa2PFhzYUN917DbCsfqziSvIlPsbS621kWsHEeRpyV3Ix0RmlKn68ZudTRJ8PMbaZRDWDfR+D5MrV+NOkTeA2x64twi+6DMUImCeDYHZykLTs02FgdPWvOfivdfD/RXVO2FVr92BbY+rN6TbJSwevwprBMwnr/EgQX7N8w3dq0ploC+m8cobhiFZ5FdjalpPubhU0R9Y56TjV01v/+MfxqZF+ZhQhET6EeS8ET3jQME/dXPC7Bq9mFzYQXaN09BCbdt1UECehRik3lxTy+UQFC5cnJDONIWFFB/sqx1q9QVBIT0zyWKx8kUi4FEo0ezINUzg=
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c9248f-37de-4dde-7c7c-08d824c7ee69
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB5430.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 11:53:59.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e25rUSQKr3VORwdX82ilqzeBcZSM4dRPNSoW44fQ7hUHKEXm5q1ZvMGe0m56DOkUIsUDXxWZ8f56xHAyQYl6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4961
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-=-=
Content-Type: text/plain

Add support for HDC2010/2080 driver and sysfs documentation for its
heater element.

HDC2010 is an integrated high-accuracy humidity and temperature sensor
with very low power consumption. The device includes a resistive heating
element. The temperature range is -40C to 125C with 0.2C
accuracy. Humidity measurement is 0 to 100% with 2% RH accuracy.

Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=iio-hdc2010-driver.patch

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
+++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-07-01 16:14:46.670806646 +0200
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * hdc2010.c - Support for the TI HDC2010 and HDC2080
+ * temperature + relative humidity sensors
+ *
+ * Copyright (C) 2020 Norphonic AS
+ * Author: Eugene Zaikonnikov <ez@norphonic.com>
+ *
+ * Datasheets:
+ * http://www.ti.com/product/HDC2010/datasheet
+ * http://www.ti.com/product/HDC2080/datasheet
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
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
+	HDC2010_GROUP_HUMIDITY
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
+static IIO_CONST_ATTR(out_current_heater_raw_available,
+		"0 1");
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
+	if (!ret)
+		data->drdy_config = tmp;
+
+	return ret;
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
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
+				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
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
+	tmp = (u8)(data->measurement_config & ~HDC2010_MEAS_CONF) |
+		HDC2010_MEAS_TRIG;
+
+	ret = i2c_smbus_write_byte_data(client,
+					HDC2010_REG_MEASUREMENT_CONF, tmp);
+	if (ret) {
+		dev_warn(&client->dev, "Unable to set up measurement\n");
+		if (hdc2010_update_drdy_config(data, HDC2010_AMM, 0))
+			dev_warn(&client->dev,
+				 "Unable to restore default AMM\n");
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

--=-=-=--
