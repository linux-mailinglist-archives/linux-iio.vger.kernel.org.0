Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4634C3F8400
	for <lists+linux-iio@lfdr.de>; Thu, 26 Aug 2021 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbhHZI5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 04:57:04 -0400
Received: from mail-eopbgr130092.outbound.protection.outlook.com ([40.107.13.92]:63502
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229785AbhHZI5E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Aug 2021 04:57:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR34n4o687PcRzUQYukCTaqY5pNilmSAlbqsIpqhhNJNUDdEQg7OtJEBUfFxdyIP5DlKkkDYQpQmxNOYvg5xp7/E6veJI24pZiGfzjMS42n4ID2w5vevH9sSn988FjnUYHvFQ8+Y2d5jLbCHZr6Ch4hkckrQteCmqTOSr1zPwyKzpmXSeos5bC4Ss8c3Bh4n2yJA31QL50Wl2n7BKH0J+XZ+QFGDACeWqtfTAH0drblV8CxKvnelBqCV0m3TR47oXaMZMZl11kNNj/DfFw1vnc0deZJS6p4iEPJ4hSn72GTbsR+cnLr+IZENsgIsylvr0Sla+ODCvJAbG2FmvcLeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJf52XOd8g7yVe3zMkC0lysgEZoCJBDwRktvRBE9zr4=;
 b=oDZ9sx8nIgEqpEctkUpQ/ml1xrqHfr+wiFOv8Zvb6aL4jgvMYe0QENEkMW4OwUEzC3+yyZodZFMerICkFhN1GzAOWB01znkLKcLnlttaifYOCsMMUur+lQlng/nH8dtAMTm7jd3TaMBq65bHD9NWYNHA46Usd/EXkZoC50OYHyYY427RKSYp7YLiLZNKJQLzf+lYqi41NshN/8mLwKbfzObDLPII47vfePYVaZSuNdkhOiNQCz/q+0MThxHi3+mjy1oNDPAeJHzoDlsrgKNdKjIjd+QIC4Wwhmf+k2qkDLisHXZZVMpHcHwD+QTOGCJbKh6aE/+y1/pGb3/krPtmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJf52XOd8g7yVe3zMkC0lysgEZoCJBDwRktvRBE9zr4=;
 b=jx0KsQwrDlveXG2VOcU7jt8SF6P3Gg6qu78VOYZcOZURJDcvKcE1DjNxxWzTQGKgSQfHcdrFJxhcNkVOXmaHLg7TNYhVBciFsZidIjrkXnX00kE2OiTTN46oz0lldK/1iiP3qhZqZEUdWig2iL7CChLLGBncHY3OqFRbGeMoPVI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5962.eurprd02.prod.outlook.com (2603:10a6:10:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 08:56:14 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4457.020; Thu, 26 Aug 2021
 08:56:14 +0000
Subject: Re: [PATCH v8 12/14] iio: afe: rescale: add temperature transducers
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-13-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e6815e85-2b0e-cb24-e677-c3324a299b3a@axentia.se>
Date:   Thu, 26 Aug 2021 10:56:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210820191714.69898-13-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR05CA0170.eurprd05.prod.outlook.com (2603:10a6:3:f8::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Thu, 26 Aug 2021 08:56:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eaaeea0-a715-4ac5-e3ea-08d9686f5c04
X-MS-TrafficTypeDiagnostic: DB8PR02MB5962:
X-Microsoft-Antispam-PRVS: <DB8PR02MB59629E3D1879C04C153DE9D2BCC79@DB8PR02MB5962.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUPMU6BRJh0MKEI2ZAXcnV/n4dNtUXJTxrBM0B6gPVL8ym7AkJ/5z4k7OyDbm3aYFBi4wqO+x87YBbotExpAx8f77C42+y8yhvWcdXyV0ZKvDeHc8yEXudoPLqcKDd5IuNmMhdMy53x57OJ2wdhHHV8kM65ltA9RssKDxMoEZcQyUlCjnx9Fkj8MimYOvBkwEEexAIjB2MuMP2qwAFFQLgVXLj8Tmt9T2BuhRWYF5waM+sj4uDLux5dj4VoTbX6kgaQ/DYz/zbz+po2iWo80czHdy1fpDMGM4QoY80FnqA+JR0I5LclRrqe/hHWGhSpkgQ5aUlM/K4mBUvoUdOM5jkPDYCyT7jmF2PhnIUMmVJAGB8bKgvXPu/e4QYdFg8beXNKbB7YWvGOpvDNVdITkFmBXIJhgljHQ2anIlEnLsSegesocH0VcwdFSVYg+E7xWijMFBH+GzkS9uzKjpSarjM26mAy/8POuqe/luczUqQRtHm3f4E9QiwJgHscaB1zs1ofBDcz5h5M26wgMHE8xd+q9sBC9LvGCMwYaSWS4lhwl/lO6nmScELwqFEFt0i2tYp1PTvsTXQPahddSJzlkkzH+A7tUV37clFcfjskfpzarNVeG8FPrdgeHNW1X94jYLPEI86F9qyvP5Y17KKnd7c/F4u+uvXqQ9hsCbyB/AlNjHTJe35ZBSqbNTCdcuOWebfziafylEDZ5N3Ay47QDGd+Sfrbh4+O9UvlSwUA3A9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39830400003)(366004)(396003)(16576012)(36916002)(8936002)(8676002)(316002)(6486002)(36756003)(31686004)(38100700002)(5660300002)(66556008)(66946007)(26005)(66476007)(186003)(86362001)(53546011)(2906002)(31696002)(2616005)(508600001)(956004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlBWkk3RjBLNUVCRktrdEJLVzVmNjlRQWQwdVMreDRITTN1c1VyMSs2cjI3?=
 =?utf-8?B?aks3QVUxWTFudVhNSjdnR1dPaDJ3VUlYVGQ2dzJBQ0ZQWXFabVM2WnYwT21t?=
 =?utf-8?B?cTYySmQ0amsvdmhjT1ZKNHJXVWFrWVVTb0xCeVQ5M2xsVHRSalZiVHlzQVFR?=
 =?utf-8?B?NXk5TXk2RlJiZTBrdkRPZ1JIaEVDMFFFbHhwU1RLTzlrUkF5dkc1Zi95cjZE?=
 =?utf-8?B?cTlqYnBUNm1BeFRrZTlxZVM3dVI3SUZJNElTb2xFbVJRYmhSQTBuRHFVaDZa?=
 =?utf-8?B?U25mWDVYMTJVdnFaTEh5OCtCY3NzSGRlOGtmVGdLRFNzakVoTzFkTWl4TTBM?=
 =?utf-8?B?b3JqSnI4RlNmNHNudHFZU2Fjb3Fnblc0YlJPUE5COU04R1pmUlJ4T2hLNkhK?=
 =?utf-8?B?TU1na2prQ1ZzbE5jWjNrVFVvc1c2YmIvTm1UUVVCcnRyWWxjd3VodzhYaU0y?=
 =?utf-8?B?N290UXpOWXhMeE5UNEJ0cjN5ajI0eWdFZGJFRmZIUExXVC9mK2h3aW9HblZm?=
 =?utf-8?B?a0s1RUxqR0NzeTdYYXUxWENJWUtING5rdlFON2Y5SGdCWmE1TzZJMnBlS0Ey?=
 =?utf-8?B?alZJUHRDVmsrTTBqeFFleTZjaHVFMTQrMGZFZHB6K0g4ZFV2SUVwQ2o4SjEr?=
 =?utf-8?B?YTU2S1luWStrZU16WkQ4Y0hVcVQ1RFkwcVAwTXR0Q01VcVk0Y1hMRURQT0xJ?=
 =?utf-8?B?K29YTkdPUkxlUmFjZkxGUHptVENRRkw2L1hnMEx5NnhpMDJUWE16WWtka2Rn?=
 =?utf-8?B?YzYvekVjZStFRHNRRHdGRDRIT2NVOXF3UW9Db0txZGo0M1cwREZXaFNBc1Nw?=
 =?utf-8?B?WGhSU2tLdzZGVnJ5Nit6QWl6N2hiY2NRRGxScVhRZzZzQWhjejBFWnV4YU1P?=
 =?utf-8?B?T0pLQlphMjRZSWRBWS95RXFoNTZFTTFFWlpZMUQ4MWpodnFYSUFzcHB2QUsw?=
 =?utf-8?B?N0duMWM5WitDaWFqYkU5UlRzRnJrSXdOWTlkMXp4MUFGNWZKaGh6NGpvVjV3?=
 =?utf-8?B?YUtvbGxuQWZKb3FKSGk2cFp0YzcwNHVwTWo2Ylh4VWhDaGpHZ0Mza05tK2Jt?=
 =?utf-8?B?akpXZVkycmY3V1ByaFYxZzZOUnU2U0dYSTZIY0doZmY1eGZOaGJlanl2VHF4?=
 =?utf-8?B?T0gvRnI4R0xrcUlYL0hGREtwSHlCQnFidng5cjJwd3BueXlncHF1Z0hrVDNa?=
 =?utf-8?B?ZVNQa3pENFMxOVZhVm14dit6c2FkZDNBcTIrWmR2ajg2aUFXbnRXVWxxZ0Vh?=
 =?utf-8?B?djB4dVluU1lWMUFZVFFCREY2QzVuUGVuVXY1WXhYS0RFR0hCV2NpTVh4TVpJ?=
 =?utf-8?B?YWdLemdNY3VSVWoxbHJVTzBMUnlsYmFjdkxPNmlOM1MrVFRsaDE0VW9wQXNK?=
 =?utf-8?B?c1k2YVJ3WVVZTzFkOVpGcG84Yi9ZS3UyblU5eVBFcXl3cm91cmZmVUVab1VD?=
 =?utf-8?B?ZW5URHBieEEwSVByQTNEdEpvMm1ka3FaeERsVTl2SDZLdTBINGhMM25Vb1Bq?=
 =?utf-8?B?S29vMHMxRHhhcFY4UUh1MVh5OTNSR2ViRkVER29UdElLR1ZZZStIRTI5Tm1I?=
 =?utf-8?B?L1FIWVhNOEVQY0hNM3J3TXBMSGJjclY0Zk1NdjdJMW9NcHlrbklIaHB1cGdZ?=
 =?utf-8?B?UHFnQjhzVUlzQ1VIVXQxVFViMDFHMTBKdlJnaDNSWGg2Unl1elQ1Wk8zenZM?=
 =?utf-8?B?RDN6Y1E1MnVVSDR1S2NqQy93VUt4Z1RWMlllRE5kcTZVU1dSUW9OTkhOeTNH?=
 =?utf-8?Q?IYCNg8sWZfF6K01Gw7S93pSxqcCtGMfOmih4/3t?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaaeea0-a715-4ac5-e3ea-08d9686f5c04
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:56:14.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oXSmR51XTRPj0SfeJhHR84lvG8eVHNG16UTyOgJEqAKR4w4P7GqT/78i1/oB7tb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5962
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-08-20 21:17, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> A temperature transducer is a device that converts a thermal quantity
> into any other physical quantity. This patch add support for temperature
> to voltage (like the LTC2997) and temperature to current (like the
> AD590) linear transducers.
> In both cases these are assumed to be connected to a voltage ADC.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 8cdcb6ffb563..12de44058bea 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -427,11 +427,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
>  	return 0;
>  }
>  
> +static int rescale_temp_transducer_props(struct device *dev,
> +					 struct rescale *rescale)
> +{
> +	s32 offset = 0;
> +	s32 sense = 1;
> +	s32 alpha;
> +	s64 tmp;
> +	int ret;
> +
> +	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
> +	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
> +	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
> +	if (ret) {
> +		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
> +		return ret;
> +	}
> +
> +	rescale->numerator = 1000000;
> +	rescale->denominator = alpha * sense;
> +
> +	tmp = (s64)offset * (s64)alpha * (s64)sense;
> +	rescale->offset = div_s64(tmp, (s32)1000000);

Error: Too many casts :-)

I think it would make sense to lose tmp, and just spell it out in one
statement?

	rescale->offset = div_s64((s64)offset * rescale->denominator,
				  rescale->numerator);

Because you are prepping the offset so that it will survive a later rescaler
multiplication, and all the "random" multiplications and divisions don't
make that very clear.

Cheers,
Peter

> +
> +	return 0;
> +}
> +
>  enum rescale_variant {
>  	CURRENT_SENSE_AMPLIFIER,
>  	CURRENT_SENSE_SHUNT,
>  	VOLTAGE_DIVIDER,
>  	TEMP_SENSE_RTD,
> +	TEMP_TRANSDUCER,
>  };
>  
>  static const struct rescale_cfg rescale_cfg[] = {
> @@ -451,6 +478,10 @@ static const struct rescale_cfg rescale_cfg[] = {
>  		.type = IIO_TEMP,
>  		.props = rescale_temp_sense_rtd_props,
>  	},
> +	[TEMP_TRANSDUCER] = {
> +		.type = IIO_TEMP,
> +		.props = rescale_temp_transducer_props,
> +	},
>  };
>  
>  static const struct of_device_id rescale_match[] = {
> @@ -462,6 +493,8 @@ static const struct of_device_id rescale_match[] = {
>  	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
>  	{ .compatible = "temperature-sense-rtd",
>  	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
> +	{ .compatible = "temperature-transducer",
> +	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rescale_match);
> 
