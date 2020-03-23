Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 024DC18F1AA
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 10:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgCWJVS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 05:21:18 -0400
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:40119
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727721AbgCWJVS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 05:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m5KLbnLbQuil593ntfF//YEz54yTf/AepvqTwrUTLE=;
 b=kZCywn3ucWeC0ATcQOsw43V0iVSbF99M2ZexQLdewozb2MaUndk5vtg4uNQ7GG0bdyiLdTei3NhM8kydiBHsj/HKIRoS1/Ede2tMPhLxo6DKDt+KzSdf7iM3mGVVReCRrQQ2mhjRcQMNyE7TgFCxaM4n3lJ3uPZbT7icf4d5u+c=
Received: from DB8PR06CA0039.eurprd06.prod.outlook.com (2603:10a6:10:120::13)
 by AM0PR0402MB3761.eurprd04.prod.outlook.com (2603:10a6:208:4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 09:21:12 +0000
Received: from DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:120:cafe::87) by DB8PR06CA0039.outlook.office365.com
 (2603:10a6:10:120::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Mon, 23 Mar 2020 09:21:12 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 DB5EUR01FT032.mail.protection.outlook.com (10.152.4.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 23 Mar 2020 09:21:11 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 23 Mar 2020 09:21:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyUOueG11sSYast3L8Zhgj2Y/9iWMgTphfB1Fk4884+tCRm0dS9agkHCepY+oTfKHYcgBK0/cOVNiStFt2qg2JuJTHITV/A0wK/GWhOgXude1aUdSRoZssyJEQBevmnHIHDcIcb9KsGeVjZEb0OpqFFCZdeZf7Eoxjipc6DwYexLL7mYbDyaRkxi1JxayVW2/2rBjJaL+BvSSEEjJCdNefO3oC5pD8E57LF+W64kK3C0U7jsUaAyfrCeZK0BXDqV1ETolqN52xW+bi0H8o5CBCoUmc5cxPXVUxTCUJz0Q0O29x/X4sXRH5bHObE0f4YbJsJwIvyDbqJdXPiP8cQpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m5KLbnLbQuil593ntfF//YEz54yTf/AepvqTwrUTLE=;
 b=nw/4pjE/rdO57u43b0TBWK9ynzz/cF6rCcFmZq2JX8eS1I9N1uQj4pnDb4Uc8YJW8ZylaqY/f3admDX2RaShMNXIXEnVhN0c8N/hp7wJBPxHPzlnqGe7cmrVM+DNPy/QVSD30CdUDvkoKN0n0J/jrvnsVSCuVbbirUDezQ1nRm617ifpytIvr9DPyhGo7sdrc4PIQBmW33oriKlY1yqKYpvPUjOZWZ5i026osIH0qfQzaMBXubitmNveYzTBQzs4mlNTK/XY+jctRNpjhMF0+O07LC+vKQPOWkdVTgVsuK3RdLY0G5YTPSY+4iPzwfU1yt7kjguJJ8yQri9ui7Fxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m5KLbnLbQuil593ntfF//YEz54yTf/AepvqTwrUTLE=;
 b=r5BL3DmtCvadJNvJt0mlxQ2d0dLldkyef3cMj4fY0DSMxyC24s0z++jXTIQp1/7S1pK4CBS64mCRtt0RhSHlWZBCoyqA/9sS7bkaCoP6+J0imAvvKyCyO4oQV3nspW7m6LNOFuu5PRRTGumdIEQw7Kod53mmj9CW/LaJuNKLcgg=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Mon, 23 Mar 2020 09:21:09 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 09:21:09 +0000
Subject: Re: [PATCH v3] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <20200316073208.19715-1-mike.looijmans@topic.nl>
 <20200315120238.18c10af0@archlinux>
 <20200313140415.20266-1-mike.looijmans@topic.nl>
 <46bec9b8-28ee-6fd3-f615-2b8db43626aa@metafoo.de>
 <20200319154842.1950-1-mike.looijmans@topic.nl>
 <20200322001628.GA2824675@smile.fi.intel.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <826f5f78-6ce7-91f0-0ca2-880ac45c8df2@topic.nl>
Date:   Mon, 23 Mar 2020 10:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200322001628.GA2824675@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0075.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::16) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM6P191CA0075.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Mon, 23 Mar 2020 09:21:08 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83926f13-67f7-4b7e-e91f-08d7cf0b877e
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:|AM0PR0402MB3761:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB376147933BE42A48A5FCA13E96F00@AM0PR0402MB3761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39840400004)(199004)(16576012)(316002)(6486002)(31696002)(36756003)(5660300002)(956004)(2616005)(53546011)(44832011)(31686004)(52116002)(36916002)(4326008)(26005)(186003)(16526019)(66476007)(66946007)(66556008)(81166006)(8676002)(8936002)(81156014)(508600001)(42882007)(6916009)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: a5GOtOSMz6bBRqmeU3FE8QKh4GwBTXXDiDuA0rHWJVnWg7Ccn4mu3qM0Jmf8iVd+GZJ09mcu60+wWYyqftGWvZDv4W+EgJ7ukqW2ALYfLpIz3e7keSaB2cx8ctZ2B1Opur0YwCLoVbHiEn8qP/qWpSdOGUN1debSmQgfke4CiTf6yygR8jed/vaJcdsxs8e7jlqbfZUBwyvk99gpGTw5qsOFPv42QIJFx2rF03CZMC9BgimN1KteXxkbQgKBHk0hq3D09hYqfXAz5fll9GM00oYlHG1TNt7ozP7Q+JDOyDQ7DoHiAgDERd64UzaGcY8kxOkFdLL0aJrUyL9UIAnUV9DSGXrgrymcBw6mvCso5OHzvswPxY7faobgqdAxd1Q/M/V1s0+j6sfsgab4qSVHpYLnDHzJI6+wEaLZpTRllyzq0TFWeMctPJHYqGS92duP
X-MS-Exchange-AntiSpam-MessageData: idfkrJxgLIvmuDE1PNwyqN/yikc1ue8rjxwaje8J6KCRakW/YfVZf/U4vPkVxWTHrDExyFScgT/eVbm4CLVvXlClhcX/3YgKg9htU9gxtDlvhCcOkGwtejBd1Ul8HN3bQifMdZmWlSqfBIoF84BPWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
X-CodeTwo-MessageID: 06cf27f0-93f0-4602-8cfd-490e4fdd4e51.20200323092110@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39830400003)(136003)(199004)(46966005)(6486002)(7636002)(7596002)(508600001)(316002)(82310400001)(53546011)(356004)(16526019)(42882007)(336012)(47076004)(26005)(186003)(4326008)(6916009)(8936002)(246002)(44832011)(31686004)(2906002)(16576012)(70206006)(70586007)(8676002)(31696002)(36916002)(36756003)(5660300002)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3761;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e4801404-b25b-4826-b5ce-08d7cf0b8579
X-Forefront-PRVS: 0351D213B3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wjiKkrftQngpyNtJ77z70eqmxrjZwM4SkN8JVcbHJ8S2y6P1HPiSToPHApDXa0DGSDyLi1qMQ4lzSk3hY6rsz26qmLOK6RN6J9Hr/v5DHKufoSsTe/QPC0CCar1vgPs5C8m4N54/c+MwCcjNXmDaOTmm8BdMjz10wD1BLePW2S+3zIuzVzuE0oWzCSCVq5JkSGmuoVrXoKX3mg6JSXB0nDjbZ0NCxZ7ybOzueEmxRKsP+U02PcJ6ueqsgoZxPZqbMQ3r9pbA7eZREb/FFyiC/uyDI7gBN0imWBdEfZHVwpY9QgPi7bxoGKFRhMQUdxNyQhL+sA3YQOFxHCiUUEL0Ql//jPhahkPlmyg5rjia7iAS/ebjmkAvN3JK1RjU0QHsEKPv7Nlq2fdzaI8/WOUMQ9uSC5b9M9eDpFA8aXMdBYDz1/ECL64itp16XQjiZyFlFq9V+dD9GJ9ZZVwdI2Ajwl0mZFeCWBzxfnvYLGVlyRsteWDBTi3esd/JmEaYCCvXAUUdwe3cRZw11c7ERxZjEw==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 09:21:11.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83926f13-67f7-4b7e-e91f-08d7cf0b877e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3761
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I'll post a v4 with all requested changes below. Just one remark inline 
about the shared buffer and sizeof.


On 22-03-2020 01:16, Andy Shevchenko wrote:
> On Thu, Mar 19, 2020 at 04:48:42PM +0100, Mike Looijmans wrote:
>> The BMI088 is a combined module with both accelerometer and gyroscope.
>> This adds the accelerometer driver support for the SPI interface.
>> The gyroscope part is already supported by the BMG160 driver.
> 
> ...
> 
>> +#include <linux/acpi.h>
> 
> How this is being used?
> 
> ...
> 
>> +EXPORT_SYMBOL_GPL(bmi088_regmap_conf);
>> +
>> +
> 
> Too many blank lines
> 
> ...
> 
>> +#ifdef CONFIG_PM
> 
> Hmm... Why do you need this? Doesn't PM runtime have the stubs for !PM case?
> 
>> +#else
>> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
>> +	bool on)
>> +{
>> +	return 0;
>> +}
>> +#endif
> 
> ...
> 
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL,
>> +				on_off ? 0x4 : 0x0);
>> +	if (ret < 0) {
> 
> Why all these ' < 0'? I don't remember that regmap API returns positive numbers
> from this type of calls.
> 
> ...
> 
>> +
>> +static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
>> +{
>> +	unsigned int value = BMI088_ACCEL_MODE_ODR_1600;
>> +	unsigned int freq = 1600;
>> +	int ret;
>> +
>> +	if (val < 12 || val > 1600)
>> +		return -EINVAL;
> 
>> +	while (freq > val && value > BMI088_ACCEL_MODE_ODR_12_5) {
>> +		--value;
>> +		freq >>= 1;
>> +	}
> 
> You can use bit operations instead of loop.
> 
>> +	ret = regmap_update_bits(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
>> +				 0x0f, value);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
> 
> 	return regmap_...(...);
> 
>> +}
> 
> ...
> 
>> +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
>> +{
>> +	int ret;
>> +	__s16 temp;
>> +
>> +	mutex_lock(&data->mutex);
> 
>> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
>> +			       &data->buffer, 2);
> 
> sizeof() ?

The buffer is a shared buffer, it will grow to accommodate reading all 
axis and timestamp in a single read (9 bytes) and for FIFO reads in 
foreseeable future.

I could use sizeof(temp) here though, but that wouldn't that be more 
confusing?


> 
>> +	temp = get_unaligned_be16(data->buffer);
>> +
>> +	mutex_unlock(&data->mutex);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	*val = temp >> 5;
>> +
>> +	return IIO_VAL_INT;
>> +}
> 
> ...
> 
>> +static int bmi088_accel_get_axis(struct bmi088_accel_data *data,
>> +				 struct iio_chan_spec const *chan,
>> +				 int *val)
>> +{
>> +	int ret;
> 
>> +	__s16 raw_val;
> 
> s16 ?
> Also applies to the rest.
> 
>> +	return IIO_VAL_INT;
>> +}
> 
> ...
> 
>> +static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>> +				  struct iio_chan_spec const *chan,
>> +				  int val, int val2, long mask)
>> +{
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		mutex_lock(&data->mutex);
>> +		ret = bmi088_accel_set_sample_freq(data, val);
>> +		mutex_unlock(&data->mutex);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
> 
>> +	return ret;
> 
> Replace break with this?
> 
>> +}
> 
> ...
> 
>> +static struct attribute *bmi088_accel_attributes[] = {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> 
>> +	NULL,
> 
> Terminators are good w/o comma.
> 
>> +};
> 
> ...
> 
>> +static const unsigned long bmi088_accel_scan_masks[] = {
>> +				BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
>> +				0};
> 
> Indentation issues.
> 
>> +
>> +
> 
> Too many blank lines.
> 
> ...
> 
>> +	/* Validate chip ID */
>> +	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
>> +		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
>> +			data->chip_info = &bmi088_accel_chip_info_tbl[i];
>> +			break;
>> +		}
>> +	}
> 
>> +
> 
> No need for this blank line.
> 
>> +	if (!data->chip_info) {
> 
> More usual pattern to check loop counter against array size.
> 
>> +		dev_err(dev, "Invalid chip %x\n", val);
>> +		return -ENODEV;
>> +	}
> 
> ...
> 
>> +	/* Set Default Range */
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE,
>> +			   BMI088_ACCEL_RANGE_6G);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
> 
> 	return regmap_...();
> 
> ...
> 
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Unable to register iio device\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
> 
> 	if (ret)
> 		dev_err();
> 	return ret;
> 
> ...
> 
>> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
>> +	if (ret < 0)
>> +		return -EAGAIN;
> 
> Is this error code dictated by PM runtime API?
> Otherwise
> 	return bmi088_...();
> 
>> +
>> +	return 0;
> 


-- 
Mike Looijmans
