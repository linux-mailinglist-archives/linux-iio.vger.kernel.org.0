Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91CF197630
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgC3IHO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 04:07:14 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:26341
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729546AbgC3IHO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Mar 2020 04:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dWAWunqJXMAKYOzXJtvNxQ5njtaZ/NFRtT61w2Y1Ug=;
 b=TjjxxzExSQL5EiNFS3vRcyCCiradOxRE42Wo5hYFBCUVyYBSp3jJu7aZSEjSqurCzP1pPE1k3CBzeBImWZd3hhvEr9GjaOf9SPn2tT8xPHQmBzwObTtcGLx4WLrUut9pTXnusqI5hF3Oai4t1vuFf3/AYh1H1BxDP562a43qBQc=
Received: from DB6PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::33)
 by AM6PR04MB6198.eurprd04.prod.outlook.com (2603:10a6:20b:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 08:07:07 +0000
Received: from DB5EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::b6) by DB6PR1001CA0023.outlook.office365.com
 (2603:10a6:4:b7::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 08:07:07 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; arm.com; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;arm.com; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 DB5EUR01FT020.mail.protection.outlook.com (10.152.4.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Mon, 30 Mar 2020 08:07:06 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.55) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 30 Mar 2020 08:07:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdSaT/l7if5sk82t901F/sPfUkPbuFwiDiuaPHnYUKq6Tq2yM+mJ4Uj0syJBSsUOc81ElDx/fVfr/CJsB/Pu6zIpDKCGO2sabdC6X7Sim10U8mLCHY4a/3A5u+MOUSeqECJb3gCeMH5UJ5n8Z5zw7NSqm85zhuEddu8xt5UDurCiD9Po2jS8KhgWw/myJleIZf2c1nB5FBkCkMZUP6Mnkxa+GqOpVw3g5s1m7yzeq9/zsRByD+8tb9fHJFuVY15S4M314j4jDxH4HNmwHhm6cnEJ93+K6o869zEQaPSzhMo5e4hmWbszPn7B/9lb8nVEwiVIfPZafPRwUWSCLgSuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dWAWunqJXMAKYOzXJtvNxQ5njtaZ/NFRtT61w2Y1Ug=;
 b=EznKnGMZLMMyYuY51lNTm4KqZD1iaAIXFFIwiTLT5NHjJlPfb5TdIXrAidYXmkZulD22oba9BztpLSR1SUQMPRznt40dQ5GT97rdvTghS/aWvPZLseQ4OQc2we5ih2VZRukCXZyAEn4h0sPoEzg+b3goXGeDmdhgzED5A0N7yxj7OvXpeUEQyE27/QHEIbm9Pgy8ZUpFMKUyLNQrsnOx7EB+3Egi2a4MJF++Jd/zSWKBNBLrYjA2Pgcq7Cgc45BkLHod1ws9W5OPXxP3AndWqtrE1A4rIyl2yXqRbKQx3RKqBpyfBMcxYj2bwlezxTmJEkmWyLENdqEoFm9TsOV5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dWAWunqJXMAKYOzXJtvNxQ5njtaZ/NFRtT61w2Y1Ug=;
 b=HPg4vTxbNugB/4k6FT8ps/po1OnFg9iNUn88wh7hgd1Sr+0hgN+nLS3KJap6vL/BQ/CHJHs9a3yij75crX/4NEmAyTp9b/Luqq6BBv6IiUWOMRqEgUl/GB0/EH1n3PpLPD6OCicJmril6OSz/GtkmvplqD+dHE3aaHgt9qrdC7c=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 08:07:01 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 08:07:01 +0000
Subject: Re: [PATCH v5 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
To:     Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
References: <20200324080309.12171-1-mike.looijmans@topic.nl>
 <20200324080309.12171-2-mike.looijmans@topic.nl>
 <20200328162044.7b9992c3@archlinux>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <51d63f6b-a561-88f3-3718-b04539a7b3be@topic.nl>
Date:   Mon, 30 Mar 2020 10:07:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200328162044.7b9992c3@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0201CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::16) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM5PR0201CA0006.eurprd02.prod.outlook.com (2603:10a6:203:3d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 08:07:00 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 821cd554-b5b7-4a31-03ea-08d7d48156c9
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3642:|AM6PR04MB6198:
X-Microsoft-Antispam-PRVS: <AM6PR04MB619808D88BC5D81CD9641F1496CB0@AM6PR04MB6198.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(376002)(346002)(39830400003)(396003)(8676002)(81156014)(8936002)(53546011)(2906002)(956004)(81166006)(6486002)(16526019)(186003)(26005)(42882007)(52116002)(36916002)(31696002)(508600001)(36756003)(6916009)(5660300002)(44832011)(316002)(31686004)(16576012)(2616005)(66556008)(66476007)(4326008)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: paIz9AQWAg6wMGOD1qDF/dZwTP5jPbHsEeeIpFmuBM3KWwEBQvSlbAZRRtxaW385raxX9L+/WeyxjpAPmttvoPPPYT9gh+/Gzf60CA/PA/mrIbxc6OupXjvC02gIAb2SwJP+FtFwoISbEHMzziCxkn/PeO9F3nr+IOvwf3y1tFVXwU5+DXnzZpsLkvUKE4/cWgUNFS7TvVp6jfWmhBNhZRLtcTO+x3wk/zekpVNVAd5y303cdhIqQRAejGQkAjuQCKza6jweMncegXBGspoEWWzhkBSXSFGAgieXuakh+uiUky3pm5DdFCbZ6mtlbnoK7KhOu4brGctOJ3aCiqD2Yhq6/Jelx4WSK1Fa0ejvoH1kCHR5x3tb20IvOmd0cwnwvy75/LheAnwrITqkD9XsBeDkY0Cg6QFO8ayWHux3i0F/nkyOff2FAY+qmT3W+Ayu
X-MS-Exchange-AntiSpam-MessageData: ydyJSOZN8g6Otk1WXMxxz20gxr/4/ikC10uJDo5acUJ6UD2mm7xZP6XAm2E8jV4n2l4YZdRbsKAaS52KV8+2g//fn+KJxLzbjkOPGc86QtFOWayHufLyfpQgeFGRTfxt/yjJxqabm/7jIzxaYctkng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
X-CodeTwo-MessageID: 5753793c-3286-4945-bff6-7439bd5835fc.20200330080703@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT020.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu13-emailsignatures-cloud.codetwo.com;PTR:westeu13-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(39830400003)(346002)(376002)(46966005)(36756003)(8676002)(7636002)(7596002)(356004)(246002)(508600001)(6916009)(4326008)(31696002)(47076004)(53546011)(6486002)(5660300002)(70206006)(70586007)(82310400001)(8936002)(186003)(31686004)(16576012)(42882007)(26005)(336012)(956004)(2616005)(2906002)(44832011)(36916002)(316002)(16526019);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d8f085de-9268-4788-f38a-08d7d4815375
X-Forefront-PRVS: 0358535363
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3m0Nv0A8/Vqizh3WKyxLX3Il05ya/w/Hs4W3h7YmAg6RDeAS67g1Dy97wlJqZ7RZ83gx0amVtVWAEU99SA/K5NMPtwl4nDvMOm4GUBSDUlz3zuvQ9IuWAKqa+YUKAYP6iMAeWXj2m8SpqT3ssi1upYMgd21v7ZlY3ISZ5hn81uiTUmpJIysfXBFZz3g/kjnV4cJoSHCUpsLc8H0e1nTbDq562knuuqTdx7yyEslXer/94bpZKdC7zRffUHo73zePXQX/Y14yWNhP9CJbrlNBV3ORFvjKDgBIUbEveN9y9zJ0ouY42L9Yfsmxdpygy7CCwbuQu4KwrsBlNQ07PFGjqJblBnrqr4DxB+9ynhE9gSwqn0qLCcp1Fq76m/vrXTAzIQe6Mq+ziI6ElIKV35z67Fi2ELOVTCb6OwcVmwN/qSgxrBzF1aKV306C0y2Mynxya2pyA//uHuqb8TSBh/dIOeB+89e9g+CXlbqr+dY6fMrngGxI7GZWjyusXDo3yL7CRiGDBA94HstS9gX+IsRug==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 08:07:06.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821cd554-b5b7-4a31-03ea-08d7d48156c9
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6198
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 28-03-2020 17:20, Jonathan Cameron wrote:
> On Tue, 24 Mar 2020 09:03:08 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
>> The BMI088 is a combined module with both accelerometer and gyroscope.
>> This adds the accelerometer driver support for the SPI interface.
>> The gyroscope part is already supported by the BMG160 driver.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> Hi Mike,
> 
> A few tiny things from me.
> 
> For the sampling frequency, I wonder if we are better off going back
> to the list of values, but then also using the read_avail infrastructure
> to avoid having to carry them as a string as well?

The frequency range is just a simple power-of-two formula, so my take 
was that a table would just be a waste of memory and resources.

A table lookup costs more resources and requires more code in this case.

> 
> Thanks,
> 
> Jonathan
> 
>>
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index 5d91a6dda894..7ed9c82b731b 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -151,6 +151,23 @@ config BMC150_ACCEL_SPI
>>   	tristate
>>   	select REGMAP_SPI
>>   
>> +config BMI088_ACCEL
>> +	tristate "Bosch BMI088 Accelerometer Driver"
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	select REGMAP
>> +	select BMI088_ACCEL_SPI
>> +	help
>> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
>> +
>> +	  This is a combo module with both accelerometer and gyroscope.
>> +	  This driver is only implementing accelerometer part, which has
>> +	  its own address and register map.
>> +
>> +config BMI088_ACCEL_SPI
>> +	tristate
>> +	select REGMAP_SPI
>> +
> 
> Hmm. So we list this driver even if SPI is disabled.  Generally we try
> not to do that, as it makes for lots of things to pick on devices that
> don't actually have an SPI bus.
> 
> Hence, please add a depends to the first Kconfig symbol so it's hidden
> if no SPI.  When I2C is added it can become at least one of the two.
> 

I'm okay with a depends on SPI. Adding the I2C support is not difficult, 
but I don't want to release something into the kernel that I cannot test.


> ...
> 
>> +
>> +static int bmi088_accel_get_sample_freq(struct bmi088_accel_data *data,
>> +					int *val, int *val2)
>> +{
>> +	unsigned int value;
>> +	int ret;
>> +
>> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
>> +			  &value);
>> +	if (ret)
>> +		return ret;
>> +
>> +	value &= BMI088_ACCEL_MODE_ODR_MASK;
>> +	if (value == BMI088_ACCEL_MODE_ODR_12_5) {
>> +		*val = 12;
>> +		*val2 = 500000;
>> +		ret = IIO_VAL_INT_PLUS_MICRO;
>> +	} else {
>> +		*val = 25 << (value - BMI088_ACCEL_MODE_ODR_25);
>> +		*val2 = 0;
>> +		ret = IIO_VAL_INT;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
>> +{
>> +	unsigned int value;
>> +
>> +	if (val < 12 || val > 1600)
>> +		return -EINVAL;
>> +
>> +	value = fls(val) + 1;
> 
> This leads to some 'novel' rounding to my mind.
> 
> (12,16] = 12.5
> (16,32] = 25
> (32,64] = 50
> (64,128] = 100
> 
> Generally we want to go faster if anything when talking about sampling frequencies,
> so I'd either like to see round up or precise value matching only.

I went for simplicity. The driver reports an "avail" range, so users 
should not expect other values like "70" to actually work. The above is 
the shortest inversion of the get_sample_freq function.

Just wanted to make it so that obvious things would work, and I feared 
that a range would require one to spec "100.000" in decimal format just 
because of the existence of the 12.5 value. So the driver is a bit 
forgiving in that specifying "12" or "13" will also work.

For a more exact match I could also add something like:

if (val > 13 && (25 << (value - BMI088_ACCEL_MODE_ODR_25 ) != val)
    return -EINVAL;

this would return -EINVAL for values like "26" or "1599".

> 
>> +
>> +	return regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
>> +				  BMI088_ACCEL_MODE_ODR_MASK, value);
>> +}
>> +
> 
> ...
> 
>> +
>> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>> +				 struct iio_chan_spec const *chan,
>> +				 int *val, int *val2, long mask)
>> +{
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			return bmi088_accel_get_temp(data, val);
>> +		case IIO_ACCEL:
>> +			ret = iio_device_claim_direct_mode(indio_dev);
>> +			if (ret)
>> +				return ret;
>> +
>> +			ret = bmi088_accel_get_axis(data, chan, val);
>> +			iio_device_release_direct_mode(indio_dev);
>> +			if (ret)
>> +				return ret;
>> +
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			/* Offset applies before scale */
>> +			*val = BMI088_ACCEL_TEMP_OFFSET/BMI088_ACCEL_TEMP_UNIT;
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 0;
> 
> Why?  In error paths it's not used, and it's set in the other two paths.

will remove

> 
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			/* 0.125 degrees per LSB */
>> +			*val = BMI088_ACCEL_TEMP_UNIT;
>> +			return IIO_VAL_INT;
>> +		case IIO_ACCEL:
>> +			ret = regmap_read(data->regmap,
>> +					  BMI088_ACCEL_REG_ACC_RANGE, val);
>> +			if (ret)
>> +				return ret;
>> +
>> +			*val2 = 15 - (*val & 0x3);
>> +			*val = 3 * 980;
>> +
>> +			return IIO_VAL_FRACTIONAL_LOG2;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		mutex_lock(&data->mutex);
>> +		ret = bmi088_accel_get_sample_freq(data, val, val2);
>> +		mutex_unlock(&data->mutex);
>> +		return ret;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
> ...
> 


-- 
Mike Looijmans
