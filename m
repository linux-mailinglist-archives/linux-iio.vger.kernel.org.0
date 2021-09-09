Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63D4404E18
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbhIIMIT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 08:08:19 -0400
Received: from mail-db8eur05on2094.outbound.protection.outlook.com ([40.107.20.94]:38182
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350278AbhIIMFq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Sep 2021 08:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj8jjhafIOrlYLZWtwxM6QWDHR7xGMENK5sGT+nQAzYat8JDdJpHL5YQDBR0+d6axcWzAIwurX0ojKyMOapoIs2DQGcn/3nKBHFElRbEOV1Z+26OkCUvWezN/n4auC0zaggzp8st3XUwDCbJ7pjr4zL5CJdMs+SJXhCQxRO4BZwylYUrfniI3TA/TJqdqnj8eO/Lbt8MB4ewWTBIG3HsOPZKfkBZbnGp/kA2WK+DnfIypem2+bIlyPbNHWnINDvann2FI+MS/r6xCBj9JgvODfKPBf2yAxW169p+o6gk/9lCt7AGrjMIGMfg6Hslq2xp3ljhKXpVvjMKmukNYEM8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0i1Ci0J/nI208hKHeCTsVAMMMp2tdHe8XoBYdqcp6no=;
 b=mni/wwyG2xbajkIJd53ryU+aFsGgSdJgr3HsRt4IdvGPLULKnRshAgiuxhbP4nxxu0Tu26cSpXSz5i2D6Hf3/SLZzXrzbPEKgonk0eN5o2AdrLaD9dCSZjjPr+vAEw5B6qKjvELsAdlt/WPPTn6VcrSc1FByRVvy8P20LSU+c27EGzob62+B66RyO7BlLdwjbGB4WiuEA0s+1kEUY/g4Argzz7Lo+3JyUTuMNvZrP2bvpvzrl6LCdzryYeEYTUCjL6K9yGIYhEb3WG6xzpDiewl8P0bM+VUZKrZxAWQox4jOVO+Llk93kDk1hsh81QlIPT9Jp0Uzmp+YlwfO2OmW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i1Ci0J/nI208hKHeCTsVAMMMp2tdHe8XoBYdqcp6no=;
 b=YUtsCWbLns7JE5+Y809rM03jNPUr7IGj5tIYepHwc+p8T99TC2622Z5WwMskJzIK4/EdZGK/+BLa65qfyXeYTwphxXo57mFC1FoMcBbOr/cHhhRVwXXcsfIMZ9FgvTxFo7niNXT9apELYdlUx44jl/Hc7Khr/hqf+m19yNfsuak=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3418.eurprd02.prod.outlook.com (2603:10a6:8:d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 12:04:34 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 12:04:34 +0000
Subject: Re: [PATCH v5 3/4] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-iio@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
References: <20210909094537.218064-1-jacopo@jmondi.org>
 <20210909094537.218064-4-jacopo@jmondi.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4a393fb1-1123-a95c-dd6b-8cff4cf0f1db@axentia.se>
Date:   Thu, 9 Sep 2021 14:04:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210909094537.218064-4-jacopo@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0101CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::23) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0101CA0013.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 12:04:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e0c2dbc-a4dc-484c-f874-08d97389fcde
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3418:
X-Microsoft-Antispam-PRVS: <DB3PR0202MB34186C4BA0CFAFBA8B79168BBCD59@DB3PR0202MB3418.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJcLwm1Tf4aNiF0mIrZwWrKm+seuD30FtwOluhCH1d5PjjfW8SbOL/+dAwd0xiHFXTthZ9yAwaaC00zbyMqVYYAjWg+8eHopKU4/ZHv1YfbFzqxE1vmuxXc4CxYZ+alhwXYTtbRovSGN6Z9XJFe1jIOFIetJk37yp6s5CSrOWBXffy7XfjQ1VnmYxqSOcYuJLJPnY42j6AjgiXN92i3DluBhoEPBvZMhGGBCsIdWetsOE+z3FH+9qxp7L8jSTRBW3V/30wAzPNiO/psCV3cy8R8+Ls/AqQwpKtYODzQ6qp8A6m+gLcVPqEQTsou5SscHsVT3PBGoFPdAZaPi9Pr3Tqu6o51lmPqjV3E8QFD8mgmSWv/WCF0rVabxCQqWdD7C22QyIfgDZY5pLMy5RQl8btCnfx9MllUwOH55v8HLKh2axVwf2/oO2IEgRLnCstoLr3gxoJdbputSvRhjO+D2IouXGxUW197GCT4jjMlI4KDxdhfOUBrnp3XBN7n13u38MhI+sunVJDz78IFMAv5A6TEhAtZRxczWNIo8NaG1HzS1nXLpIFbS0FQgh1WYZUeLXX8FHCSPbkpnf+avYhHlOtt5zOHDn/gIVzCh4VU0xZ0nKj+wBHXBFCwNDKhpolYJexwXP+QJgPFDDALXFFTf/VyrNA06DgVh1hy3+ZWM1Fbdr5H7hVFBll2RM6lVzWMQELLx3WfAL3IUjJcCNWgd2pC8TA80Ttlse98iP9sWmaJJLfFd3W3/5wddqNS/MzQdOm0ELJj5iZ7g/HsyL1E7QRMdUHiVvtCPJlaa1MiyUQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(39830400003)(376002)(2616005)(86362001)(966005)(316002)(83380400001)(110136005)(956004)(6486002)(53546011)(31696002)(478600001)(16576012)(31686004)(5660300002)(36756003)(2906002)(38100700002)(4326008)(186003)(36916002)(66556008)(66946007)(8676002)(26005)(8936002)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEpIQXFFM0tuMk9kYTJBaml1L3hPNUNQTXRMdG9oeUNhYkNmbmlwbHVlc3hB?=
 =?utf-8?B?RG9Uc2c5Ky9ERDUwd1ZYYjFTMmlnQnhESHRJUllodHV6aWd4KzhEazdjSGZ1?=
 =?utf-8?B?ZzMwRDdUQ2dQWC9rMm1UMDRwdEdhcDdmUDNMK0tVR3ZpMGVxL2tzTE43cXoz?=
 =?utf-8?B?eDlUUU1HMUdQTnlEOWdESXVlcGRuMExQTTA2VmZmSWJRZ1Y3UiswTURncFpq?=
 =?utf-8?B?cVZNNmRoYWZOUGF4ZUVkOFNkZkxOWEhlRVdNTGVMdnE2UFFIbEttNktBbzhp?=
 =?utf-8?B?ZFhieWQyZEI3TEdrRnZQNUZ2ODNHWURnT2EyQ2JmZmhvYU9LVmNVQ3ZKQVFw?=
 =?utf-8?B?MmlPbk9HZEg5RjljaE5YR1lZYk9pK3hadkczUm9jYUNOczlBc3c0c1pPemt2?=
 =?utf-8?B?T1pqZENsRlpXYTNnVkZMUXRrR1QyeDRJTXJTZkd6Uk5JZ2FabWtKNW1DSFJs?=
 =?utf-8?B?ZHhLYnZyQTkzUDQ1c0lzOUVnT0pmUjA2S1Bwak1aZ0pPeFZOall5YTNMZWYv?=
 =?utf-8?B?SUx6cEFkSHBIa2l1Ri96ejFrdlYrMHpmdGF6bVcrekRPL1MwdDZuREd6MWlj?=
 =?utf-8?B?dGlBYkJSSEt5WEtnUmdKOCtLR013eEZqbFc0ZTgwRFFWKzRYTFJ6NTEzZnp4?=
 =?utf-8?B?NXZuTU1lOTVqV3kwbG9mYXVoWGtLOXRxYjZYdForemtDdHJQYi82L2grT2hB?=
 =?utf-8?B?ampIYU5zTnhobVNSK1JHMWdMbXJiY2ZtZFNGaUJpQUlDK3VTR29zK0hhQWYy?=
 =?utf-8?B?K3VhVkNIUjAyZWZxaGh1bHEzL2E0TlRVVzgvS3lWNGdBK0VMRVFDVzQwWERG?=
 =?utf-8?B?azNqSmE3WmJjOGlPanZSUXloN3hFY2NnNlhoL042N2hZUmw5ZU5aUi9uZkFk?=
 =?utf-8?B?WWFoNmQzVHdBRW44bm9EVzlkZ1FyKy8rc2xaRDRzNkZvZEZuWXJiVU12ajdZ?=
 =?utf-8?B?UWN6bFVmVExCeGM2UnZZYmV1Qk1SZ00rdzhpT3FBMndRU3RRdm9oTFB2R3hY?=
 =?utf-8?B?d1Z4YlhmSmZzZ0hmelRaQkFyZ0NCRWYyMmtzaHZ0YWVENVNGOEpNNWx2RnNq?=
 =?utf-8?B?WnhockJOaHpEMHpJbmJiODlCbG8rUWRzREQxMmZzY3BsVnBXQVNEMG1hMitE?=
 =?utf-8?B?cnlwdS9HSE5oa21Qd296M2I2N0JEWGphdmpwOFdwZG1hb0NQclBzMnVkdGVY?=
 =?utf-8?B?cHhpNmVtL0JJVU84Y0p5ajJYRmRJT2VHQ0EzU2NwZlhidXE1LzM3bkJ4VXZV?=
 =?utf-8?B?M2s2aTlaaUE0K0RFem9RM0tzYjRmUGhvOVdtVXdnUU1Wc2pka0hCRzdtNzhQ?=
 =?utf-8?B?UUJNdkVrUlFEbWZxSGNmWG1GU1JCZVU3NFlsVER3U0NDbnNvNVVOYlpKcWVT?=
 =?utf-8?B?bXJ1U3BVZllld05nOTY2M29PZTdEd0R0TmhJMTlPSnhsN1BhOG5XSDg4djNa?=
 =?utf-8?B?cHpJNkF0NVZKNmhXMUFNeE1heWo5dXU5RzF1K0VyYlJRdkErYm9ybHR0VXhI?=
 =?utf-8?B?dWJsVkVMYXhSMXd3dHdwbE9uY2gvTzlqZ0RpcDFPMWkyQ0VxNXFuaWhlc2Ex?=
 =?utf-8?B?TkNuNmJxQTNsNFhSWHlWdUVqVjF1YWFvSlVkOFZMZ3hKc2I3M1RhWGhjcE5i?=
 =?utf-8?B?V2laSitpMWQxVWVQaENubUNaa3RaQS9WbSs5bEJ6bGxtRGhZVllyQ0VCYk9N?=
 =?utf-8?B?VTAxeFpmNkVscmZGSGQ4dS9aNEJ2SHc1Sjd6WWtsTU81WlpBTVUrVjJ3YWtn?=
 =?utf-8?Q?oIntHlx4ZVhLcdbR0UFUaPNdgz3nsSMU59ISgnt?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0c2dbc-a4dc-484c-f874-08d97389fcde
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 12:04:34.2359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Sn7M9tqbrS6nHmRjprUv9xGYzT8um6UDOvaehpujWV6P+hvuI4DDaSDeHwZ6TGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3418
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Subject looks wrong, shouldn't it be 006-0-0007?

On 2021-09-09 11:45, Jacopo Mondi wrote:
> Add support for the Senseair Sunrise 006-0-0007 driver through the
> IIO subsystem.
> 
> Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  MAINTAINERS                        |   7 +
>  drivers/iio/chemical/Kconfig       |  10 +
>  drivers/iio/chemical/Makefile      |   1 +
>  drivers/iio/chemical/sunrise_co2.c | 526 +++++++++++++++++++++++++++++
>  4 files changed, 544 insertions(+)
>  create mode 100644 drivers/iio/chemical/sunrise_co2.c
> 

*snip*

> + * the i2c bus.
> + */
> +static int sunrise_read_byte(struct sunrise_dev *sunrise, u8 reg)
> +{
> +	const struct i2c_client *client = sunrise->client;
> +	const struct device *dev = &client->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	ret = regmap_read(sunrise->regmap, reg, &val);
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	if (ret) {
> +		dev_err(dev, "Read byte failed: reg 0x%2x (%d)\n", reg, ret);

Nitpick, %02x looks better methinks ("reg 0x04" vs. "reg 0x 4").

[more instances below]

> +		return ret;
> +	}
> +
> +	return val;
> +}
> +
> +static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
> +{
> +	const struct i2c_client *client = sunrise->client;
> +	const struct device *dev = &client->dev;
> +	__be16 be_val;
> +	int ret;
> +
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, sizeof(be_val));
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	if (ret) {
> +		dev_err(dev, "Read word failed: reg 0x%2x (%d)\n", reg, ret);
> +		return ret;
> +	}
> +
> +	*val = be16_to_cpu(be_val);
> +
> +	return 0;
> +}
> +
> +static int sunrise_write_byte(struct sunrise_dev *sunrise, u8 reg, u8 val)
> +{
> +	const struct i2c_client *client = sunrise->client;
> +	const struct device *dev = &client->dev;
> +	int ret;
> +
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	ret = regmap_write(sunrise->regmap, reg, val);
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	if (ret)
> +		dev_err(dev, "Write byte failed: reg 0x%2x (%d)\n", reg, ret);
> +
> +	return ret;
> +}
> +
> +static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
> +{
> +	const struct i2c_client *client = sunrise->client;
> +	const struct device *dev = &client->dev;
> +	__be16 be_data = cpu_to_be16(data);
> +	int ret;
> +
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, sizeof(be_data));
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +	if (ret)
> +		dev_err(dev, "Write word failed: reg 0x%2x (%d)\n", reg, ret);
> +
> +	return ret;
> +}

*snip*

> +
> +static const struct regmap_bus sunrise_regmap_bus = {
> +	.read = sunrise_regmap_read,
> +	.write = sunrise_regmap_write,
> +};
> +
> +static const struct regmap_config sunrise_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int sunrise_probe(struct i2c_client *client)
> +{
> +	struct sunrise_dev *sunrise;
> +	struct iio_dev *iio_dev;
> +
> +	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	sunrise = iio_priv(iio_dev);
> +	sunrise->client = client;

You should check if the I2C adapter supports the needed operations.

	if (!i2c_check_functionality(client->adapter,
				     I2C_FUNC_SMBUS_BLOCK_DATA |
				     I2C_FUNC_SMBUS_BYTE_DATA |
				     I2C_FUNC_SMBUS_QUICK |
				     I2C_FUNC_PROTOCOL_MANGLING))
		...

And, I suspect that protocol mangling might not be the first thing simple
SMBus-only adapters support?? Maybe you don't lose all that many adapters
by not using the restart-after-wakeup method, when odd things are required
anyway? That is, if the device gets enough time to wake up properly using
that method? (see the message from Andy in the v3 discussion)

SMBus quick isn't universal either...

But hmmm, maybe you don't *really* need protocol mangling when you don't
check the return value of the wakeup call? At the same time, without
I2C_M_IGNORE_NAK, you'll perhaps end up with boring entries in the log
or the adapter doing retries or some other inconvenient crap?

You could perhaps set I2C_M_IGNORE_NAK only if the adapter supports
protocol mangling? Any maybe you don't care about losers who don't have
a nice enough adapter. :-)

Cheers,
Peter

> +	mutex_init(&sunrise->lock);
> +
> +	sunrise->regmap = devm_regmap_init(&client->dev, &sunrise_regmap_bus,
> +					   client, &sunrise_regmap_config);
> +	if (IS_ERR(sunrise->regmap)) {
> +		dev_err(&client->dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(sunrise->regmap);
> +	}
> +
> +	iio_dev->info = &sunrise_info;
> +	iio_dev->name = DRIVER_NAME;
> +	iio_dev->channels = sunrise_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, iio_dev);
> +}
> +
> +static const struct of_device_id sunrise_of_match[] = {
> +	{ .compatible = "senseair,sunrise-006-0-0007" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sunrise_of_match);
> +
> +static struct i2c_driver sunrise_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = sunrise_of_match,
> +	},
> +	.probe_new = sunrise_probe,
> +};
> +module_i2c_driver(sunrise_driver);
> +
> +MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
> +MODULE_DESCRIPTION("Senseair Sunrise 006-0-0007 CO2 sensor IIO driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.32.0
> 
