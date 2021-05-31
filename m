Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8158D395784
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 10:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhEaIxv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 04:53:51 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com ([40.107.0.96]:38468
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231184AbhEaIxt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 04:53:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCrqwkqyCOlBVbQ/p9ByXmK7slNvaiLVHqHTvi12562hAAJPczuxzdSBZem3TvDx5YBlQDDkrrPMkchl7KvF9GE/w1CNmyvFlam9KwAP11let42R9sg30xBzOpiwSGlRokn1ft1/lLxo/rSHA5docZIePTScbF8zCTMyC2v3IWLFipB7n4xlP2y5K4XijjCf96oanyA00RSsIYy4pfhMEZ1Pq0BOJzeSf3Fq6guf439Na7ci5oLyOk3LG6BYSgtUypSoHRROcTuM0ybyIsu0I3KEq8Y5OgHvkNkHdVjWP1sNTTtB8kOwv9813TME2rQI5qfFmdFR3DP9YyGNF3QVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y60V0No7t75zS4Vly25IvePzf6MQ2Fd1yAUhZ+kMis4=;
 b=BLdvftz++f1r+XG4s6XjAR01AP0rlPKLrdvZHhsdnPjuxJiLcBPpMJFDYlPlWqMgV+FHCF5v3w6R25Nlycxwpg+6jUpRZ4/R1JBNpQiwhUfi6fen3XrcKkYGXO9lO3dKGTuHCgJtWIEhAoguF/aAZ1N+gEpxv/mlJ45VQk8L9eqC/GNs2J4WGzC0qECQHY9O+hQJg03Chxrc7C28hp6Hy4zDvqrMnZ2ue/0zYNoNEDfln0TZGp5xGozDqDL6/ggm9pZFRxM5SS2iIxzVHG2NfBDgLD17Z5q+BBzwUN/BSN0LO/I0rcwnag5uBqxeOyzPlalPBuGxidF/QlQjpToBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y60V0No7t75zS4Vly25IvePzf6MQ2Fd1yAUhZ+kMis4=;
 b=DLAnKa16lOUlL4KmbXpdqMBcPvFSTQ1o1T0Iy+CwNogdc0lud5DekPZ7+Vb7SJHzNz6VfWQYZok0oNdzQmEWNVmEJXRae1vyzcnverYSg3V1qJ7jWgG6Jyoeq7e39Kl0zQ0uyH4bTOanHGa+mGo1VoYiEEcQhN4RJ7d427lQVSo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4789.eurprd02.prod.outlook.com (2603:10a6:10:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 08:52:07 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 08:52:07 +0000
Subject: Re: [PATCH v1 4/9] iio: afe: rescale: add offset support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-5-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0769aaae-8925-d943-e57d-c787d560a8dc@axentia.se>
Date:   Mon, 31 May 2021 10:52:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210530005917.20953-5-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::22) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Mon, 31 May 2021 08:52:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7fd6b0-71e8-431e-a9cb-08d924115f0f
X-MS-TrafficTypeDiagnostic: DB7PR02MB4789:
X-Microsoft-Antispam-PRVS: <DB7PR02MB478905F90E887414526B9CBDBC3F9@DB7PR02MB4789.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDuaxYGrIGYlt+P5gNgb/I6GHltrwDx4yroo67YyKab0h0Xb/erIFFSeyLI3pCz2x1p/QwD2iuYwMJYbPYS5+j6wRVZ7Pj4eQ9bGzio1jqWkG2ylJvrFbUWFrcR8dTZBR1lyOU+A2Gc6gx3a2LyiLio74J4DOsegkilz9DRcpZhQqA+Ror2Vpdj4Ada48byFAxJfxMmWrF3KhQ1cV9Oo8x1++UWHenlSPHMfXVNWSfBs23YKUEYW+8H3RW9FJ5lkkXL+lpbM0sY3LXarHq3E2QHmIlvi90DFLL9osh78/uDS1LnqNy/lB6Xyh8EhTe0FEFrqjfCCwGrPDZFxYs8tbcu4yqp9WEkP6t8S/IIVHPUhGRfcyPmWlpK5ugL6JQ+8kSpZRoQBhSWtExXK5JT41TMW5tXqDG45llQHIA/0nxzO/dPl8nAtUY4IKk5hHjKwahkA0pJXcJ2WRzwVy9kzjWCj79XOgUdIDiCRFBdeO2x+F8tEkMhCMa+a85vgzou9ae8xZwxL03RdvI2oZSgtagN98mV4F8auKLIglgW2pAd4B9cpugRAzeXjFied780Y43h9MMTH0wtPQipqeM/eu2Z2MGM96FiBeZTesu946P/NF3c8bWvwu9G2j0nQIzmj2QEVXyJ4n6vl0vIjdW0rrWHSEOV7DAFBdsCMXQDEXraxVHYDK6YIGS72wF384ATv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(136003)(396003)(376002)(346002)(38100700002)(31686004)(66946007)(2616005)(83380400001)(4326008)(316002)(26005)(36756003)(86362001)(478600001)(66556008)(16576012)(956004)(31696002)(2906002)(53546011)(8936002)(6486002)(16526019)(186003)(8676002)(66476007)(5660300002)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUQxbTR6ZlNRQ21kTzErMjVabC8xMWpvdnIvRFlZbmhPNEZnR2hCR013dTZZ?=
 =?utf-8?B?VWlZK005K2NiTWtnZ0VSakY0b1QxTEJJQU1RU1RTUjJOcTNWaWZMRW9tclUz?=
 =?utf-8?B?TEZyYU5JQThGbGRhMjJqS1JKaVluS0hpaGdOL1RZTVFHcGdWZjlPa3F5VGVy?=
 =?utf-8?B?WU00RHExV0JnalRjenhoQVZ1bFBwcDV5YWFFYllPQzgyd0NrQ1FKSW1EU3Jo?=
 =?utf-8?B?NjkzWDR2aUNSaXFXOXFhRWdPSzloMUR0dTl1QmJUMnVVVkNZZ2xTemx4eUNa?=
 =?utf-8?B?ZGRLdGhpQ3BRQVdodzRyaUpxRFFFOGo1R1VEbjlyUXMrdFp3dkFNTnhtYi9M?=
 =?utf-8?B?S240RzM3MjFCNXB3YkpPRGluYXlnTnNnV3YrbVAyb3YzUlJCbnR0cnFDRzQ1?=
 =?utf-8?B?d016Lys5OXp2UytkUVF4ZS9nZ0ZkcEdIaGxyaWt4RGpKcHdEdk5XRFIreXBs?=
 =?utf-8?B?NnNDTlNITnMwc2FXOXRBQThiKzVSZ3FrZmcxSHhQLytwVHhBMGhGQlFZUHBM?=
 =?utf-8?B?WHNnSXU4QitWWWtlSVlldkJPUG8zVGlLajJBUTN6bU9hc09ab1p4V2hLMVNI?=
 =?utf-8?B?WTB4YUlwZkhIMUV6WmJieDd3clV6V1g1S3ZaUll0S1hDWXY3aURXazJKVHF5?=
 =?utf-8?B?MmhSd29LSWMwWm8zc3l4Zkt6VUVmYUtVTjhvTGd5NDd1TWZ4NHFPM3k4bnBJ?=
 =?utf-8?B?c0FJbGI5dFdtSUsvOXorUHdPdm1YTnhZM1RjbmxaQjcwWUg1Z2Z2M2xmTlBU?=
 =?utf-8?B?YzFmYmNvY3N4cGxEejE4ckl5UitNQWVQWkFNSkwwNEVtZ0crNXBkVDYrQ2Nx?=
 =?utf-8?B?SVo2YUZWQ1lpdEd4ZERYRWlobWNzeTlNc3ozUXpTeUpaVFNhUk9BT3d4NVpY?=
 =?utf-8?B?Q1JqOXNOd0hCcWdFeXVlQU1UU1U1bVp5UnY5NFBvZnRsemI2eVJPcmJ6N1ps?=
 =?utf-8?B?S3gvd3YrZS80RGM0bUVjdDlkYWpramVLbHQ1eHZZM3RnYWtmUUFRaENYVVF6?=
 =?utf-8?B?VERCdHR4bWdHdzFCSmdrTXo0U09MdVZCYlNIVW10M0tmN3ExUU15aDRJY004?=
 =?utf-8?B?RU03M3RPbTlybUdNekgySytvMDZ0cGFyU0xvSzhqUTFIWHNZUnBtbUpCOVpP?=
 =?utf-8?B?azJLNTZSd01VRjJTc2FSZmlxeUlzVDcvYng0eWlCOWZSZ092c1pRb3RvRW4y?=
 =?utf-8?B?d0FxaE9zdXFUQ201ME5jZCtRSzZwQ253ZmVjQ2VwMVo2Y2RvU3dKUnVRUVdO?=
 =?utf-8?B?emw1cVB4UjEyT01EZkpjdlZwcEhhd2VDeGNCOFR5S24yV09hdHlTMjg3TFhP?=
 =?utf-8?Q?CiGKkKJfeP?=
X-MS-Exchange-AntiSpam-MessageData-1: 39j/cjmc0bV/j5atOHo6rqLmTOHF8rGmCZ7XgFaM03Q/3CcjGItrB0QrjzwRjQpyxfDWzti0yDKV7zBPG0bFawxQOZGt/5UlxNPBTgvedk0Lb9NnC4UJUf9LEYf4AHE2lJ71uS/coO3TnRGBL6ZHRLoPEUFybsMMvCbmgxBZMtYHKeTWUx6O9NWRnwPETiSJNYvHoUJ13Gr2y3vVcA4mvSCx8i7JohD1FZoTieY4XwB+uoTd/Jg8YwFLLqL2pT37nrSH5ewws7CPbfrLqjYGqjWDzBjLtZT1c/TJ2UImLY3Nv9iJm0f0q3cpy3yZcVJDehjN8RX+nD9di0+1MZZqLjG3
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7fd6b0-71e8-431e-a9cb-08d924115f0f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 08:52:07.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LkWWzK3u5V2AeklksD2eG65miGZ0Nuyx35BVCbwxs7rcCKWrHA+aDCXn04BnIzs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4789
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Thanks for the patch!

On 2021-05-30 02:59, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> This is a preparatory change required for the addition of temperature
> sensing front ends.

I think this is too simplistic. I think that if the upstream iio-dev has
an offset, it should be dealt with (i.e. be rescaled). The rescale driver
cannot ignore such an upstream offset and then throw in some other
unrelated offset of its own. That would be thoroughly confusing.

Also, I see no reason of expose an offset channel if there is no offset.

Cheers,
Peter

> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 4d0813b274d1..3bd1f11f21db 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -31,6 +31,7 @@ struct rescale {
>  	struct iio_chan_spec_ext_info *ext_info;
>  	s32 numerator;
>  	s32 denominator;
> +	s32 offset;
>  };
>  
>  static int rescale_read_raw(struct iio_dev *indio_dev,
> @@ -52,6 +53,10 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  		*val2 = rescale->denominator;
>  
>  		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = rescale->offset;
> +
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -119,8 +124,10 @@ static int rescale_configure_channel(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_SCALE);
> +	chan->info_mask_separate =
> +		BIT(IIO_CHAN_INFO_RAW) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_OFFSET);
>  
>  	if (iio_channel_has_available(schan, IIO_CHAN_INFO_RAW))
>  		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> @@ -280,6 +287,7 @@ static int rescale_probe(struct platform_device *pdev)
>  	rescale->cfg = of_device_get_match_data(dev);
>  	rescale->numerator = 1;
>  	rescale->denominator = 1;
> +	rescale->offset = 0;
>  
>  	ret = rescale->cfg->props(dev, rescale);
>  	if (ret)
> 
