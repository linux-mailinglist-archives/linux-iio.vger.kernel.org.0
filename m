Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C71D8FF8
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 08:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgESGY2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 02:24:28 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com ([40.107.22.112]:34432
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726870AbgESGY2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 02:24:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce7x7+WDsqo45Jz5rKpBIxduR9eYjhlMYe8VpiPCM3TNtU2q64UKRfU9uoMkE859HSJTYy9YRRgnnbbuzjFunaLLL1oe9w5QCN2xACVReFkgCi2K1fE+Y09mDdxSDUkbP62YU5xu1DMQOc1YxfoI7mll1A7ELOuJsCu70lx6r5llzgf2b121PrQuwtvUB4K2I9FjcWCJclusa/M7bTgFw8Om++1QoPos9L66nWq0v3MtHRCZVS7uGvx0ZvFHUeWXJ6GAepWEnIile9TZBJE43V4HlEUNzHUcY63pt4/5arCumGLW6ksYOW6e69GCC0vXCGRzR5P8L/X2cONJjViXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwF3WcYTfo1r4sAL7QQyJYS92GXhs7IK7Xmqzlm2PgI=;
 b=e2jODFUJGL8uRnf6ToJqNlkXXyIuuQKREWJaHn07OX2NRXi7BLiSwXom56jgozn62HY2DzvD1Ms6iKWMq5i+UvW5kGgL89bmC23IjreC6jETXwNIOW89/ZGMgmhJx5rmdhVHgw2Yq6mXb5jTxHU8pRZ1GIlXFO2qqTdw6XYhQWCNFV7VFwqIUnk6a7+9u+ZT+8LtOTQISgXMKlRdRvGYw7LgdY5sLHxYnRi2MQ8u5mOB4JvDbMGWyKnTjhbQxNhnOvJUkk0aiFpd5DqQM4EHt0H6w+kHtg+WFAioO5CncO9yUwwTH0gZjLQdwXJ91Ax2nu1Pnpljmy/JHfKM6L+DNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwF3WcYTfo1r4sAL7QQyJYS92GXhs7IK7Xmqzlm2PgI=;
 b=mJc3BHjklGMUh48Tz5F99Sz5bE6ETkdBibDFN7TrYZlKTpHQpOlU3pDaZiCpInenqjX/FT26fGv8CwA5bLa1VY7LRp0pWBWa5lxqZv90Woh4cMrOq+ovkd5VhyIiwmeNNSffLF8OkEWv3ROqc7X9fq6VnmV0HqQzKi2jiqPkWYA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=norphonic.com;
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com (2603:10a6:20b:86::11)
 by AM6PR06MB5847.eurprd06.prod.outlook.com (2603:10a6:20b:90::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Tue, 19 May
 2020 06:24:21 +0000
Received: from AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::6505:f0e6:d0df:c1c0]) by AM6PR06MB5430.eurprd06.prod.outlook.com
 ([fe80::6505:f0e6:d0df:c1c0%5]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 06:24:21 +0000
Subject: Re: [PATCH v7 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
To:     Eugene Zalkonnikov <ez@norphonic.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <2A0D3CFF-796F-4DEC-8432-CFE52F8A22F7@norphonic.com>
From:   Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Message-ID: <109ec751-efef-0d7f-f19f-0433d3a7e1fa@norphonic.com>
Date:   Tue, 19 May 2020 08:24:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <2A0D3CFF-796F-4DEC-8432-CFE52F8A22F7@norphonic.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: OL1P279CA0012.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:12::17) To AM6PR06MB5430.eurprd06.prod.outlook.com
 (2603:10a6:20b:86::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.1.54] (62.97.226.122) by OL1P279CA0012.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Tue, 19 May 2020 06:24:21 +0000
X-Originating-IP: [62.97.226.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d35c3382-7290-4dbf-cd3f-08d7fbbd4497
X-MS-TrafficTypeDiagnostic: AM6PR06MB5847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR06MB58474515BB93CAF4703996E8CAB90@AM6PR06MB5847.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfdpRxbn9WW8iaB0dvMDrkHXjamy2/mqFm+rT8oMpC5lRT1P14jtJNDBnOACYw3FYmoN1HMJR4wEJPtrIdjnrNwCTgC5uY1XkLmIx/C50HNWJbXHNy2gpml5484miDsjeMvX4DGSFVJ2MaWkYHTP0opyOUuu89TrsoEpn1kRWSmtOcrnpjPZVMSomVk14OZF868JdnQGgzk0bZJvdsAR0WhnYdDetvBRBiZSMyJ66wTqmNs6Ms6xE0woTcNjxnZjQATsXVbIE+8M0nD8nQREk0HSzvwNH6ukGCO8EtBiqLmU5fJ6tl5fReRL0pa6rc5+9RTvZ9d+88cXBzlGDKVuz2c3LXz6jkCkyC5lfTt+qyALjP2KrIU9Bzx2+v3NS4VpMHvDYJle4gCw5Nrcbo15jejDvjWAR06WG0J1Rt30SY/J56hCHaxdHV8yfsaVDPJ7PJzrvvXYaRGKjLarChRU8MtzSD3kw8r8o53Q8tgiMqToJM5D57JpWWUpeDeo4GGCJPe4WsUNLVUxI+YLg5eCSISfWkdnNff3uS17Gt+8aT/6LEvSrBXjCtF8t5ulP8hoUm6vBSdiTY3JKv9mAxpR5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB5430.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(346002)(376002)(136003)(39830400003)(5660300002)(31686004)(36756003)(186003)(30864003)(26005)(110136005)(54906003)(8936002)(53546011)(52116002)(8676002)(16576012)(316002)(2906002)(31696002)(6486002)(66556008)(66476007)(66946007)(4326008)(16526019)(2616005)(44832011)(508600001)(956004)(4001150100001)(966005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +fGZ9rmooSFAm/tEoVaNLn2WQjGTzZSycJjK14oQjtqhhmdj5v6KszRglE3vHp2EpqNyA+ODiZ+I2kfj5YD9n6/02pYo8WLfjmIMhEkxa6gZsyYNWe61mL8vHQYDIJ0X/vhDbTXICHFOgfzn6RRBboRCD9xt0pJaAVTkD8NUWvhVxDEU5hDujDnj5awcfPMyHSNfOw2eaA7WmZ5K89dXKvkwskqmTlh0vJKVZof9Am6bJABjyJ81Sf0Ll/7ZgAkCy85u13REZ2Xw6GyRVSB+kuZmljmrHgYK3nwQfwxRfoqTWLkQ9Ay3mtDB700tr27QVjowwXHo31lyENolkh18xgAToKXYcaLS0K7a2wV+wkAdw+Xwv7F5a+XhhpTcnB5zHhX4R/hvw1pckykZ/fEOfQw04U3TNVvr+oBz3VD92xtL7B4/pmfuLY8aV1beWAYGeyJSyFlIAGiZOSpKU+liHwOm2KwGdjEfOa6ukE3d7laMODUcXVQGxqGUJxsMQon5
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35c3382-7290-4dbf-cd3f-08d7fbbd4497
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 06:24:21.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5E+2c9ozk5J+f6OE51234Yu/Z+t/VBIK6OBaNOWLGC+232S+UJLp1x1AoowZVtr/E13/JaXi43j7bRnAI8fEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5847
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Please disregard this.

On 18.05.2020 21:13, Eugene Zalkonnikov wrote:
> HDC2010/2080 driver and sysfs documentation for its heater element.
>
> Signed-off-by: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
>
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010 linux-5.3.8_hdc2010/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010
> --- linux-5.3.8/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_hdc2010/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010	2019-12-02 11:09:25.803326999 +0100
> @@ -0,0 +1,9 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
> +KernelVersion:	5.3.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Controls the heater device within the humidity sensor to get
> +		rid of excess condensation.
> +
> +		Valid control values are 0 = OFF, and 1 = ON.
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/hdc2010.c linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c
> --- linux-5.3.8/drivers/iio/humidity/hdc2010.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/hdc2010.c	2020-04-24 18:04:48.699251583 +0200
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * hdc2010.c - Support for the TI HDC2010 and HDC2080
> + * temperature + relative humidity sensors
> + *
> + * Copyright (C) 2020 Norphonic AS
> + * Author: Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
> + *
> + * Datasheets:
> + * http://www.ti.com/product/HDC2010/datasheet
> + * http://www.ti.com/product/HDC2080/datasheet
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define HDC2010_REG_TEMP_LOW			0x00
> +#define HDC2010_REG_TEMP_HIGH			0x01
> +#define HDC2010_REG_HUMIDITY_LOW		0x02
> +#define HDC2010_REG_HUMIDITY_HIGH		0x03
> +#define HDC2010_REG_INTERRUPT_DRDY		0x04
> +#define HDC2010_REG_TEMP_MAX			0x05
> +#define HDC2010_REG_HUMIDITY_MAX		0x06
> +#define HDC2010_REG_INTERRUPT_EN		0x07
> +#define HDC2010_REG_TEMP_OFFSET_ADJ		0x08
> +#define HDC2010_REG_HUMIDITY_OFFSET_ADJ		0x09
> +#define HDC2010_REG_TEMP_THR_L			0x0a
> +#define HDC2010_REG_TEMP_THR_H			0x0b
> +#define HDC2010_REG_RH_THR_L			0x0c
> +#define HDC2010_REG_RH_THR_H			0x0d
> +#define HDC2010_REG_RESET_DRDY_INT_CONF		0x0e
> +#define HDC2010_REG_MEASUREMENT_CONF		0x0f
> +
> +#define HDC2010_MEAS_CONF			GENMASK(2, 1)
> +#define HDC2010_MEAS_TRIG			BIT(0)
> +#define HDC2010_HEATER_EN			BIT(3)
> +#define HDC2010_AMM				GENMASK(6, 4)
> +
> +struct hdc2010_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	u8 measurement_config;
> +	u8 interrupt_config;
> +	u8 drdy_config;
> +};
> +
> +enum hdc2010_addr_groups {
> +	HDC2010_GROUP_TEMP = 0,
> +	HDC2010_GROUP_HUMIDITY
> +};
> +
> +struct hdc2010_reg_record {
> +	unsigned long primary;
> +	unsigned long peak;
> +};
> +
> +static const struct hdc2010_reg_record hdc2010_reg_translation[] = {
> +	[HDC2010_GROUP_TEMP] = {
> +		.primary = HDC2010_REG_TEMP_LOW,
> +		.peak = HDC2010_REG_TEMP_MAX,
> +	},
> +	[HDC2010_GROUP_HUMIDITY] = {
> +		.primary = HDC2010_REG_HUMIDITY_LOW,
> +		.peak = HDC2010_REG_HUMIDITY_MAX,
> +	},
> +};
> +
> +static IIO_CONST_ATTR(out_current_heater_raw_available,
> +		"0 1");
> +
> +static struct attribute *hdc2010_attributes[] = {
> +	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hdc2010_attribute_group = {
> +	.attrs = hdc2010_attributes,
> +};
> +
> +static const struct iio_chan_spec hdc2010_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = HDC2010_GROUP_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PEAK) |
> +			BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.address = HDC2010_GROUP_HUMIDITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PEAK) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.extend_name = "heater",
> +		.output = 1,
> +	},
> +};
> +
> +static int hdc2010_update_drdy_config(struct hdc2010_data *data,
> +					     char mask, char val)
> +{
> +	char tmp = (~mask & data->drdy_config) | val;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					HDC2010_REG_RESET_DRDY_INT_CONF, tmp);
> +	if (!ret)
> +		data->drdy_config = tmp;
> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_prim_measurement_word(struct hdc2010_data *data,
> +					     struct iio_chan_spec const *chan)
> +{
> +	struct i2c_client *client = data->client;
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_word_data(client,
> +			hdc2010_reg_translation[chan->address].primary);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_peak_measurement_byte(struct hdc2010_data *data,
> +					     struct iio_chan_spec const *chan)
> +{
> +	struct i2c_client *client = data->client;
> +	s32 ret;
> +
> +	ret = i2c_smbus_read_byte_data(client,
> +			hdc2010_reg_translation[chan->address].peak);
> +
> +	if (ret < 0)
> +		dev_err(&client->dev, "Could not read sensor data\n");
> +
> +	return ret;
> +}
> +
> +static int hdc2010_get_heater_status(struct hdc2010_data *data)
> +{
> +	return !!(data->drdy_config & HDC2010_HEATER_EN);
> +}
> +
> +static int hdc2010_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct hdc2010_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		int ret;
> +
> +		if (chan->type == IIO_CURRENT) {
> +			*val = hdc2010_get_heater_status(data);
> +			return IIO_VAL_INT;
> +		}
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = hdc2010_get_prim_measurement_word(data, chan);
> +		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_PEAK: {
> +		int ret;
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = hdc2010_get_peak_measurement_byte(data, chan);
> +		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +		/* Scaling up the value so we can use same offset as RAW */
> +		*val = ret * 256;
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val2 = 65536;
> +		if (chan->type == IIO_TEMP)
> +			*val = 165000;
> +		else
> +			*val = 100000;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -15887;
> +		*val2 = 515151;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int hdc2010_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct hdc2010_data *data = iio_priv(indio_dev);
> +	int new, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type != IIO_CURRENT || val2 != 0)
> +			return -EINVAL;
> +
> +		switch (val) {
> +		case 1:
> +			new = HDC2010_HEATER_EN;
> +			break;
> +		case 0:
> +			new = 0;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		mutex_lock(&data->lock);
> +		ret = hdc2010_update_drdy_config(data, HDC2010_HEATER_EN, new);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info hdc2010_info = {
> +	.read_raw = hdc2010_read_raw,
> +	.write_raw = hdc2010_write_raw,
> +	.attrs = &hdc2010_attribute_group,
> +};
> +
> +static int hdc2010_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct hdc2010_data *data;
> +	u8 tmp;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	/*
> +	 * As DEVICE ID register does not differentiate between
> +	 * HDC2010 and HDC2080, we have the name hardcoded
> +	 */
> +	indio_dev->name = "hdc2010";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &hdc2010_info;
> +
> +	indio_dev->channels = hdc2010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hdc2010_channels);
> +
> +	/* Enable Automatic Measurement Mode at 5Hz */
> +	ret = hdc2010_update_drdy_config(data, HDC2010_AMM, HDC2010_AMM);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * We enable both temp and humidity measurement.
> +	 * However the measurement won't start even in AMM until triggered.
> +	 */
> +	tmp = (u8)(data->measurement_config & ~HDC2010_MEAS_CONF) |
> +		HDC2010_MEAS_TRIG;
> +
> +	ret = i2c_smbus_write_byte_data(client,
> +					HDC2010_REG_MEASUREMENT_CONF, tmp);
> +	if (ret)
> +		return ret;
> +	data->measurement_config = tmp;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id hdc2010_id[] = {
> +	{ "hdc2010" },
> +	{ "hdc2080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, hdc2010_id);
> +
> +static const struct of_device_id hdc2010_dt_ids[] = {
> +	{ .compatible = "ti,hdc2010" },
> +	{ .compatible = "ti,hdc2080" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, hdc2010_dt_ids);
> +
> +static struct i2c_driver hdc2010_driver = {
> +	.driver = {
> +		.name	= "hdc2010",
> +		.of_match_table = hdc2010_dt_ids,
> +	},
> +	.probe = hdc2010_probe,
> +	.id_table = hdc2010_id,
> +};
> +module_i2c_driver(hdc2010_driver);
> +
> +MODULE_AUTHOR("Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>");
> +MODULE_DESCRIPTION("TI HDC2010 humidity and temperature sensor driver");
> +MODULE_LICENSE("GPL");
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/Kconfig linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig
> --- linux-5.3.8/drivers/iio/humidity/Kconfig	2019-10-29 09:22:48.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/Kconfig	2019-11-28 14:31:27.794242693 +0100
> @@ -38,6 +38,16 @@ config HDC100X
> 	  To compile this driver as a module, choose M here: the module
> 	  will be called hdc100x.
>
> +config HDC2010
> +	tristate "TI HDC2010 relative humidity and temperature sensor"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Texas Instruments
> +	  HDC2010 and HDC2080 relative humidity and temperature sensors.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called hdc2010.
> +
> config HID_SENSOR_HUMIDITY
> 	tristate "HID Environmental humidity sensor"
> 	depends on HID_SENSOR_HUB
> diff -uprN -X linux-5.3.8/Documentation/dontdiff linux-5.3.8/drivers/iio/humidity/Makefile linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile
> --- linux-5.3.8/drivers/iio/humidity/Makefile	2019-10-29 09:22:48.000000000 +0100
> +++ linux-5.3.8_hdc2010/drivers/iio/humidity/Makefile	2019-11-28 14:30:40.609892061 +0100
> @@ -6,6 +6,7 @@
> obj-$(CONFIG_AM2315) += am2315.o
> obj-$(CONFIG_DHT11) += dht11.o
> obj-$(CONFIG_HDC100X) += hdc100x.o
> +obj-$(CONFIG_HDC2010) += hdc2010.o
> obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
>
> hts221-y := hts221_core.o \
>
