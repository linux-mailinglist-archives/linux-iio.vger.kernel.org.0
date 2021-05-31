Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E04395D40
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhEaNnZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 09:43:25 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:64673
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232641AbhEaNl1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 09:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGwau/B+/IEJtbNoXbc/uCseMZgxCbJu0B4+hOLJN4n4nTFxlyNbT2b2QXL0bgxR2UBVcQVUVvq2Fz3TYUalRxyy4wVtG/Z4FjJfinrDsT8eUCtF9DQsltrDkGkJzVamenAAiXgCPrlFugmFS/GY6j20hP/wCLBSiruB20zRT6LcyUvXZERsXaT0EttOe1thHEaqm9SAaTC51ooHm7Q5pSLaV/DcH+L4M8kuuQ+aLIxZ9jQaA+bZ2s1YbCZwH8id1Jt0K7tMJWqfrr7NeYWdNNFs8ZsXPLxzepLczaPaFkvo1MfLJhfTcTOQ+6xHXmVp6C6fSQjjRac8JTAMdHoSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9DozSxuznmP/ieyOKWei5Ak+stFx6gcrL1mX/juuDY=;
 b=L1+OivQIkIKvlz6X2nDQgMYV7CcxpCDqhNucBMn+XX75OZMefD8tXFkooSi+wSezIMAmWT4UlqI1mXOcHNVvOevKEeDmRenl0oYurwciKJ5HMFI4rEwHQvfizxGeJ9vZnAHBaPnFb6+I7+3ooOijOosce10kbGYRYQFunmxEknwIqoQyNaI/asonoV+0LinOh7vV9sMkI9qXbyleTFqmK95A7xxMh1nDcIAsnvJXj9vnlhAkzVSdRUVtEc2I69COlz2g6tJ7z9y26uHcVQZE3OceYT9P6XRVWOLrOUiJd+jo8h/aoYFFD2zyuA2vuNTf4JY4z1h9Uq9hl+4QucN1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9DozSxuznmP/ieyOKWei5Ak+stFx6gcrL1mX/juuDY=;
 b=mXSQhL49JF7YIkPmSwU5LJdKz8yhEL8F+lfOmo2r7AuZ2GqRP0kLlFfDQQCISlSV02L3Cp06kt43fYvZ91E0qFukLqIUcuYCuFsKwE7fIrShxh+5q3YJ2a0OddgVGmf++y8ScR6jSoD1LrLEJVTLu3I2yMVyXX0ZRJJRMtUInso=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4476.eurprd02.prod.outlook.com (2603:10a6:10:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 13:39:43 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 13:39:43 +0000
Subject: Re: [PATCH v1 1/9] iio: inkern: always apply scale requested by
 consumer
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-2-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4c0628c1-765c-2544-66cc-d5ea5a7703fd@axentia.se>
Date:   Mon, 31 May 2021 15:39:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210530005917.20953-2-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0102CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::22) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0102CA0045.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 13:39:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32282497-0567-4a4e-1443-08d924398c02
X-MS-TrafficTypeDiagnostic: DB7PR02MB4476:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4476E804C9EDFA79AC3A8732BC3F9@DB7PR02MB4476.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XeeafPqgt8+qoifAF2Tc9fcDyuinh7ftXnoR1ffXLllBTNX02tlwjn8aufl1UFFU8xv0vQc8ql45xFLGNioWHajnnW/OIgG+4V7ufEMNZIQkOZVtdleaagGsHRzVfL7qFWzeqfvx1i0ftVR+kTSZFF0jbGdyvJX1QfFUGyGSYDMN1rDZSp/kVc7qpob2Zv2wadt1sdRRs7J6CjNV0FaXA4AJJt3bPOX5MDkVmVwHj6WNPASU3hB2B8E/KfvSj/+2iA7zvTkypTQ26udiDoqBumGpTKYbxOtyPtYGylTs+ffkGbx+9Yh+TdZ0KWy8q8Cj4XQXTw50n6shDORMokPbJkKjIzTB1NlAWWl1w6N1tlGMAgcKfHWa6eyKx6Ao/dLbEEBAaTCrc5qHGgTMSxveNQpCPLMuInYaweuLgvVZmpQFcIKfcfeBGecSFImNrt1tyImacejYF70irUpFfT+gE3sAJejdk4YvR2dFfn/59JYjdtP4SwDaHoYdmbGDcDZ3Qu1xHf6Ja5hJsLTRH5F3JgnyAle4SmiJFEnTvxXesQ3bTOAKTZRImCf6zPFG9Zws+UlqyOtw7Wm3OtoY7VOJ/4N4nLJBDUreIVnNkRw2az8FQk2PZh/ZfeQOz/vMa/caUySTLMiQlkyh2Uzl/MdPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39830400003)(38100700002)(31686004)(2616005)(83380400001)(66946007)(4326008)(316002)(26005)(36756003)(86362001)(66556008)(478600001)(16576012)(956004)(31696002)(2906002)(53546011)(8936002)(6486002)(186003)(16526019)(8676002)(36916002)(66476007)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWo2cGJyNHgxenRSV0kzOVZJbWNtQkEyUWlrcEJjWG5MdFhHQytkVFA1dS94?=
 =?utf-8?B?dEVvYW1XZXV5TlcxTi8zbFR2V3NjUlJ3M0lwcmJSM1oyMVNaUWcyVUpxc21N?=
 =?utf-8?B?c21WVXlTeHBCSHF6Q3JXczh2L0lNcGdNMUpLLzRYNHcxMk1FSUlJQnhMVUtL?=
 =?utf-8?B?OHZML1pPWVVjNW9hSGxHN3g5TldrcEdKeFlvMjVJL1ZLVG8xU2NXQWpsUkJF?=
 =?utf-8?B?N0NVbmNuVUdranpwa3UzZzYwRjdqOFUxd3poRFhDRGpGQUwwUGcrNVdxTURj?=
 =?utf-8?B?S2s1enNDSzVJMHBObGZxZ3lqU1htdjRjeGlxYmR5SU1qMWZyekY0SXNHQ0NB?=
 =?utf-8?B?YkxhckR4dHRvZ0svM1FjbVZmalZ4Yk56WXFLUWNtUFlKOUh3OFhsMDJiRzRu?=
 =?utf-8?B?WWZmWXgyR0FVZ2htNEtKb3ZKblI2WGpMMHl3TytlcStkVmJiUDFBMDNXSFp4?=
 =?utf-8?B?QlNHMGdtUndBNm1RQjQ3UTNUR1dlUUZqRU5Gd2ZqZ1BnYzN3aStrK2VDbS84?=
 =?utf-8?B?Sk9KT0RJS3ZuRVJzNmRodEEvYUZIZjJjWjFqUjg5VGcvU3BCR1FkbkFvOU9F?=
 =?utf-8?B?eDRlcUhRNW5la09qRmVrSXBKQlBjdGpBUlF3Q1Iyb3RSOWkvZ3N5bndGUGR1?=
 =?utf-8?B?aXFwMWpEbEtNMjZuenFNRDVZaktEd1JmanBSWndRQWltc2NsdmM2dEVjaGRw?=
 =?utf-8?B?S0FnVzkyRVAzU2tGU21GdHRqbWE4UFRzL01VOTJ1TGlwdXd1RmpzSnZuSzE5?=
 =?utf-8?B?NklrbXU1ekhsVkE2TVdxaC85Sk1CMVRXL3A0dnJlZlpUZzI2Tm54UTRObHox?=
 =?utf-8?B?c0NXNklLZHZjeUx1eTd6OFhlMjdPYk9NY21xOVIzd2gxZDhuaFRqNjZFQUd4?=
 =?utf-8?B?VDNsSHJwa2pSbjBENzhzTVZFOHA2WFF3TVZnd0haQXZSbE9vRk41UzhPSWhN?=
 =?utf-8?B?MWxGZWZhdEs4dXhZZTJ0NldNTEJTSU5kZkpmdWRUMGpGNjc1NlUzWEg5UzJu?=
 =?utf-8?B?VmhLc0pnZDQ5cExyL1h3ZmZDNXFtYlk3ekUzRXdPeEtZQVZDaFI4ZTB2ZEdD?=
 =?utf-8?B?Znl6dVUyeVlBNkRxVWhhMHZaZmtzcWlxMnhHQWo4V29xOG8ybjJnSnE3ZzIz?=
 =?utf-8?B?Yy9kTk95VlZxSHZvN3hLcEtQTUJEUWZVbFF0a2lIY3QwYWFKdUswbDFYNFYx?=
 =?utf-8?B?aFViK1loNVJLTWp0dVVULzZrSTBNRFN6d2JQemlUU2hRVnFKeGpDYXA1WnYv?=
 =?utf-8?B?RUVhcllJT1AwUDEzK0JZdlcwOGlSU2g4NTMzN09UVlFTUExocG5GSnl1TjhZ?=
 =?utf-8?Q?koPBwANzOp?=
X-MS-Exchange-AntiSpam-MessageData-1: 4Mv/U0Mg3ikWI+7AzIaQ24VDEyMssjFs7Xidro+Z+nRZcqECMo1FvPoYo72HOxYhpJCPHNkLrpmaGXq91qkiTFgmRGU6fWzlo66nXu19qc2CU3weVGfLuM0rSyYqSiPoPItdAmr2lOL+6OqMVnC8GH2hiy4bA2vV5wng/cLrnqCw/GGk+an/3PqjbLclkOkkmmdNow2xhQo7LfiXWME+IZMDvuZlfnahu/XBj0eoA9fcWWreKljrOIc5YObwaXl80bf1A93EpIFds41ZbJFWh/LkJ/dX4eUeeWMsg+tLcqUpf1oE6kfMMqYtxXXWB3y564+cZ2c6XCCstPKeQUwbSp8i
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 32282497-0567-4a4e-1443-08d924398c02
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 13:39:43.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/hPrgFg7EbX4dxvPFtD5XLWTMdN8FlwEsp6cWr/kmTIXhDPL8bWOw7Na2BpBgoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4476
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-05-30 02:59, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> When a consumer calls iio_read_channel_processed() and no scaling is
> available on the channel, it's assumed that the scale is one and the raw
> value is returned as expected.
> 
> On the other hand, if the consumer calls iio_convert_raw_to_processed()
> the scaling factor requested by the consumer is not applied.
> This for example causes the consumer to process mV when expecting uV.
> 
> Make sure to always apply the scaling factor requested by the consumer.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/inkern.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index db77a2d4a56b..4b6a8e11116a 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -601,11 +601,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
>  					IIO_CHAN_INFO_SCALE);
>  	if (scale_type < 0) {
> -		/*
> -		 * Just pass raw values as processed if no scaling is
> -		 * available.
> -		 */
> -		*processed = raw;
> +		*processed = raw * scale;

I would keep the comment. Sure, it's now completely confusing since it's from
before the function had a scale parameter. Perhaps reword it to talk about
"no channel scaling" instead of plain old "no scaling"?

Also, this looks like a bugfix, no more, no less, and should perhaps have a
fixes tag?

Cheers,
Peter

>  		return 0;
>  	}
>  
> 
