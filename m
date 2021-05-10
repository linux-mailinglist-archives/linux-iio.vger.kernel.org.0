Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ABF377DB9
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEJILY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 04:11:24 -0400
Received: from mail-eopbgr70132.outbound.protection.outlook.com ([40.107.7.132]:4021
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230170AbhEJILY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 04:11:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM/o474o8IGarS9TmrlzAGLj1Ym3JK1US397wm/xo9zoIJQ3DHUjzl4NnaIzDCh0n3+9AabnEmQAvSib4wLCNjMn8AGlDU1xE6g7B20DYymzTrPPVTaBj3OOgzteOI5pMQ+6NoPHz9gT8d/WgH5HNLHKq1CoPaKPIf79oSc06WnomDL/Xd0eeXlYuPlhFBFmYN0NUNiGdepxO7VnWfBmOf3jDPZ/D0DtALPD2P2AKoj04Tcs+la+wwiFEnend/zFLsthBGWgan0Yo4+5G9BRqraCIEpf4+jB4swEBMjm/SbmIlFtP+95ZvnnNqznSAYQHi8enZ/fYOA3Cn+rsXaKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeJZzS3bvcLqoRb8/h2e4QNlVmKXQNRIixD+IT98bpI=;
 b=j1GATSA1Mb/nPBWEpxZ1MM5/S60MoHqgPRvzLwTSmW2kSSqUUqsGoVM0mKcW076tQoLEJoYWCAJR5nZo+h09cFD3US7bv4VYhlmnudTHuZDU8sEQDeP+vpNF+gQXo5aRO8ANk/at8+AqqxkXO49VpkvoT84P5WaiJ3pc3JwIDfIgwblih1P+QCkqdGk/5mchfH7fvfoD5bA3S1VyqsqhsbEXE/Fcw7z6n68Rq6uB8dHayFSHzErUo11rsKvpwCs9H93vMnQnJakq4mlrX2z5YcEZpI3esi4Tj/dyy6NZCMRO2Y4WYFGDwkSFpltsKziBrj0eYh/MJL7mmCQHaa3SdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeJZzS3bvcLqoRb8/h2e4QNlVmKXQNRIixD+IT98bpI=;
 b=XGtEN6e+pbPkKggYYG9dl030tuiZcjKHVczxo9vwR8CJypqnuFGSFBZsMmsCvqpTk8DXrRBcuB+QHFawUUSAD5ggLnIm2++cp9U5WFldKqyGtsWrzYPE9TEbUsaEgxKbehbd06kIXaXEREj9fvrXthEde9YHejNHkV1FECnGkwQ=
Authentication-Results: pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5612.eurprd02.prod.outlook.com (2603:10a6:10:e7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28; Mon, 10 May
 2021 08:10:16 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 08:10:16 +0000
Subject: Re: [PATCH v2] iio: afe: iio-rescale: Support processed channels
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20210509225907.351562-1-linus.walleij@linaro.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c8e7964f-6dc8-291e-2d50-0eab4ce3f3c3@axentia.se>
Date:   Mon, 10 May 2021 10:10:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210509225907.351562-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0202CA0029.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::15) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0202CA0029.eurprd02.prod.outlook.com (2603:10a6:3:e4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 08:10:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a12b815-1004-44e0-6a8e-08d9138b0b5b
X-MS-TrafficTypeDiagnostic: DB8PR02MB5612:
X-Microsoft-Antispam-PRVS: <DB8PR02MB561212B3E5AC1BCE08ED1F10BC549@DB8PR02MB5612.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uaHoQWe2OByIY8gUmrwWXf0zgb774MxrZpHXQAv8OOkys9QeqrE9U5E3kO/VfJwTBVZgzM6VaC3mndOGzEo1ggtkiiPAQxRQ05iFKUZKka73U9bBgQD0zBaf6Yf8mN1vvQ/xGUIvYlgBrqTBFoM8VOUblVmpqSeP3JiRcmVyPh2Ql0+7l56uv6N4pwV0jllirGpe3abkpiXP05NLbAwTSGtcxZX7ucw3E7cEpckNAQA3y5vpvVwn1hsfrxrLq1xqMa0SxMFQXxBLYyMqvgIBoBt9XmRoL7+8raOps1wtfrbRddx0AdXvHqhw2G1z1x+eKqb2D0UYmxXjk0Fu0AL13/0lcfnYi0EiQ/4Y8zehugczb00oyJCvylPnJuDpxJ9EX1ot+hkJY+OzJzAdMDIUD0iw4wb1qNO1M57RFTLl+5ToPWFUJM5iUYEJmxnZFJQOP8dH0N80XFt/7eCz2ILTPRERL5ocS7nvwQZroycKTKAAGsvFX9JSbC8dkn8fuul8imUvxtgu8dfBAhFOnY+mmEieP8slCjMWbH5eKCQk+/VNjMMfLGa5Njd18eP07pjUP5d08LLLhIPLfJFi7d76INWIJc+T6OlSvwZD39cLmCmDkDJI6M7pfnezkJb2HJVgXNUGjCzIy2KU0pwIa7vd8jBrQJOZj5S4EMfm+P6foIthIeJm6WZPchsKV/bpdTA2ioK+tG00Kr3EBe9bfIfBwIILSeynCnoIZYybRpltgyJ5txebw0yLOk+c4bZMKY+BsnTBer2H70vsJIca5hLnNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39830400003)(16526019)(186003)(5660300002)(66556008)(478600001)(36756003)(31686004)(38100700002)(966005)(2906002)(4326008)(6486002)(66946007)(8676002)(83380400001)(54906003)(110136005)(66476007)(31696002)(26005)(36916002)(8936002)(16576012)(2616005)(956004)(316002)(86362001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNuelJLNXRhbStiT1RNcnhkelRVMUlDSWo1UTBldjNza2JtSldTWS9DSDBY?=
 =?utf-8?B?N1FWNUNPbWRPbkNOM2s5S3BOSTRiSXB5UkhGY2NVekErdlpqMVpzc05iTUt3?=
 =?utf-8?B?TG90dzNKU09LT0N6T2Y2eVhvbG81OFdNM1N1VEZ1SHpCMU1DK3AwUlYrc3Y2?=
 =?utf-8?B?a2hqcXRKUHJlTGFiWHZHNSs4Vm9uTjQyU01MbDJOUlJNOE80WEtNVjBQWklN?=
 =?utf-8?B?QzA5bzdDUFpybmlUdms5S3ZWN0ZRdnlkbHk0ZjA3dmR4c0RHdjluYmQweEpx?=
 =?utf-8?B?a2xGSjRYMUQ2TXFmVlIxRkIwL1NIL2QyaXpEV2tDeUU2d3RRUHNQdWE2S1lT?=
 =?utf-8?B?YjVRN3VzM05LeW1nb1dqRloyZmdLWHA0NGFmSllQWjFraVJCMytVOVFEMmln?=
 =?utf-8?B?T3o1QUZxNjVxTnhuandmWkswK3p1L0laWHM5V2kyTlM1VnJyZ1c0WjBtM1d6?=
 =?utf-8?B?NGRPaHduVi8zbHNLeWxlUEFqMVgreXZtMDVSMzVJT3QrQjMzd2h1aW1jRVhu?=
 =?utf-8?B?Nm5PMitIdHZuWEg2RlllR0V2WUhWbHRYOXpBdDgxTE45SFh5cExGQlViWCtF?=
 =?utf-8?B?Zk1iLzNIQ1V5d3VyaUptMWdXbm9nbmRwTDBUd3c4UXlyWUZlb1NIVEhNcDJI?=
 =?utf-8?B?RVpUdVNud004NmF6Tk83VGN1VU0yZnNiMGx1dU1Zc2tib1krT0ZOWDdRbU1T?=
 =?utf-8?B?TXVISUU0UWpjaDdhQ3dlR1RSWC9yZjFSaURoa0dxZXFtTStLY1dkUmxlTDls?=
 =?utf-8?B?WllIQ3pYTEtDNzBGOFFPamQ3ZkR6QU5Bb2YrbHJCMGw0T0dTVVVlZEZGdTJa?=
 =?utf-8?B?VllaQ1NmQ0pGVGMwOUY1UFNXNVREcGVBZ0VSNHBLYXMxUUZVTDZYYWYyZXRy?=
 =?utf-8?B?OGhVLzlYMjRXSHoxazVjWDIrT1pmZ0RWM1RYVmdvZFdxcVh6V3pScTVYN1J0?=
 =?utf-8?B?djM4dzFMRW5TTnhRSlNMdkFxc3ovc2hNcDFMbjJaL0NSVlBUTnhUbXEyUFpS?=
 =?utf-8?B?YzhLeHQzWDNTQUZwMnMzSW05TnRPTjlJdXZiVHJJN2ZjQVluVXhJRDVWQ0VX?=
 =?utf-8?B?VVIyQjZNUjVnTHVOZDhUQ3k2cktvRHUwMVFPV0ZKWnZsU09YZXpKTm9Bc1g2?=
 =?utf-8?B?M08rNlZLTS9vc28wZ3BYcm0rM21IOTNSZnpJNzlKTzc3MUwyNFd3c1laeTUz?=
 =?utf-8?B?eWFLdnB5M1QvSVY1akF0NFBEWDN3Tnl3QkR6K0k4dzNIaUJKL3ppOUlXa29i?=
 =?utf-8?B?V04rUzEzdkFLODl0SkRMUUt1SzFjVG1CQkQrUFNFY0lxUnBqUXhEQk1qMG80?=
 =?utf-8?B?NEszNFFTV056UnpxRFN2cHpwUWRoeFBaUEJvMUdvem1WSk8zSEwzaWFXQVF2?=
 =?utf-8?B?eldSd3lvZXpPSncyZjNrRGJQRHR0TUk1SU45UDRJQlJDUyt0eGsrRUNsNzIr?=
 =?utf-8?B?cGlEN01mbHllWTZSNXZmVXhDaFFUNHoxa0I4UGxLcWk4SUxUMVJiQ3N0VFE2?=
 =?utf-8?B?REZtRSsrTThRNEZ6Qmd1YmRtVUZNalJZUHNlRncwSStEaUc1alQ2NVFJczVW?=
 =?utf-8?B?RElKVmowdlBLMzV0RFo0UTFyQWpZNnNtd2JrVS9JdkQrT1N4SGV5Q1JDczlp?=
 =?utf-8?B?YU1DaGxlSXJEQTJaN1hUaitTZzR3UlZPSlFPU0N6eFBDekJETGYxZDZLVk1G?=
 =?utf-8?B?SzZJcjJOYWFoeS9Ya1JEQVRWUzlIWDIyazUxZ1ZBeWxGY1p4bkdZN1lkTFdR?=
 =?utf-8?Q?BqI/yYpQC7Vj55KaN8/7GYZ0G2XJDNpHPcMqZux?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a12b815-1004-44e0-6a8e-08d9138b0b5b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 08:10:16.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oXhVqxSBdrNjuhJa/4tGtQUDRuo5N6XHUePE8EbUt3Id/72HhS0RXaCwpMOxvxC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5612
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Thanks for the update!

On 2021-05-10 00:59, Linus Walleij wrote:
> It happens that an ADC will only provide raw or processed
> voltage conversion channels. (adc/ab8500-gpadc.c).
> On the Samsung GT-I9070 this is used for a light sensor
> and current sense amplifier so we need to think of something.
> 
> The idea is to allow processed channels and scale them
> with 1/1 and then the rescaler can modify the result
> on top.
> 
> Link: https://lore.kernel.org/linux-iio/20201101232211.1194304-1-linus.walleij@linaro.org/
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Deny calls to .read_avail() for processed channels, and
>   insert a comment.
> - Move an assignment of IIO_VAL_FRACTIONAL down to the end
>   of the block for better readability.
> ---
>  drivers/iio/afe/iio-rescale.c | 39 +++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index e42ea2b1707d..ddbb760ae8df 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -29,6 +29,7 @@ struct rescale {
>  	struct iio_channel *source;
>  	struct iio_chan_spec chan;
>  	struct iio_chan_spec_ext_info *ext_info;
> +	bool chan_processed;
>  	s32 numerator;
>  	s32 denominator;
>  };
> @@ -43,10 +44,27 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		return iio_read_channel_raw(rescale->source, val);
> +		if (rescale->chan_processed)
> +			/*
> +			 * When only processed channels are supported, we
> +			 * read the processed data and scale it by 1/1
> +			 * augmented with whatever the rescaler has calculated.
> +			 */
> +			return iio_read_channel_processed(rescale->source, val);
> +		else
> +			return iio_read_channel_raw(rescale->source, val);
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = iio_read_channel_scale(rescale->source, val, val2);
> +		if (rescale->chan_processed) {
> +			/*
> +			 * Processed channels are scaled 1-to-1
> +			 */
> +			*val = 1;
> +			*val2 = 1;
> +			ret = IIO_VAL_FRACTIONAL;
> +		} else {
> +			ret = iio_read_channel_scale(rescale->source, val, val2);
> +		}
>  		switch (ret) {
>  		case IIO_VAL_FRACTIONAL:
>  			*val *= rescale->numerator;
> @@ -82,6 +100,14 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Using .read_avail() is fringe to begin with and makes
> +		 * no sense whatsoever for processed channels, so if called
> +		 * on a processed channel, we just error out here.
> +		 */
> +		if (rescale->chan_processed)
> +			return -EINVAL;
> +

I believe this is not the correct place to block requests for .read_avail.
It's too late; the driver should not first promise that it is possible to
call .read_avail just to later return -EINVAL.

It's better to just avoid adding the IIO_CHAN_INFO_RAW bit to
chan->info_mask_separate_available in the rescale_configure_channel
function. See some suggested -++ below at the end...

>  		*type = IIO_VAL_INT;
>  		return iio_read_avail_channel_raw(rescale->source,
>  						  vals, length);
> @@ -132,8 +158,13 @@ static int rescale_configure_channel(struct device *dev,
>  
>  	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
>  	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> -		dev_err(dev, "source channel does not support raw/scale\n");
> -		return -EINVAL;
> +		if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
> +			dev_info(dev, "using processed channel\n");
> +			rescale->chan_processed = true;
> +		} else {
> +			dev_err(dev, "source channel does not support raw+scale or processed data\n");
> +			return -EINVAL;
> +		}
>  	}
I'd also rather have this logic reversed/flattened:

	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
		dev_info(dev, "using raw+scale source channel\n");
	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
		dev_info(dev, "using processed source channel\n");
		rescale->chan_processed = true;
	} else {
		dev_err(dev, "source channel is not supported\n");
		return -EINVAL;
	}

>  
>  	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
		BIT(IIO_CHAN_INFO_SCALE);
 
-	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
+	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW) &&
+	    !rescale->chan_processed)
 		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);

(disclaimer, all new code untested and written directly in the mail client)

CHeers,
Peter
