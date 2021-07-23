Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C3B3D4210
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 23:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhGWUhT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 16:37:19 -0400
Received: from mail-eopbgr40126.outbound.protection.outlook.com ([40.107.4.126]:36782
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231724AbhGWUhS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Jul 2021 16:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cROgM4HMV8JcFy0UCkrn7i2EHeuKjnRzK0HJPEwgBLFfnUDiF9JEWny8fy24ByRr1tZs6QHVvpgq7uzcD7gqIYhvLmpqmdi4+cn3LFRZHOfm+0Y5BLi7lm+hi5U/JS0sWzBM6HoGMts3nW4jJhb8iHSblWKVaLOMafhMzwX2ASh9tqwmXopAkD2xeYQN4ImKeOO068Ry7aUoeJcjq7sL8zhev24JdqOSaAVgK0uouuzDFBq4wmPp4dFFcnfb9RNF6tsMiZN12JoSH1kSKfQMeXT876ng/KXQzTy+o5QZB7Px46i4xxZOZ0+J+Zep3I1sBZ2qv0H2Vv5PYeKy6n+vWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LlUANIojcTWWwGLva36L4zsd6nNkRdghQzNNOWDuGo=;
 b=mxy+tDFjljDrJWGUkw4yUIPRHocCIAaxhOC9JOsdlzcJOeBcUrb33UtUBJapEi8sxTGJQc35FQsrpgcJqBOZlXdLjrQ6aYbn95sxbNdBewGXbwciFDDZ6vtUY2yhHDtfNEEltOog1iuC02LlbQzosvRy/l+iACSzksqURahtoUIS3j+y6ehFY+ZDwrEc2uJiFSLGS+KH0wo01PV5WKuuBOLShKuTFUTKwq7ju1M49RqeGhEukt2EFm2YlnJnGVP29SHhmgkYb0ac/Ge9qkaRrkPTUXCJT1D2A9txo/rXLpEzHJuItNUXVNdRMepS5ZllZljLfrwYfhQXN/nwLEZXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LlUANIojcTWWwGLva36L4zsd6nNkRdghQzNNOWDuGo=;
 b=cJU9E7rNUEt5Ct2Si3cQezLc6fv9U/1clo2nTUEbunPLnlMPl1uRYdVGwk2gI0mcdDg2hFdYAOm0k8kmiEg4ii3xdzcR8RMGmWzDdm2wO4mA+F/09CeC0eIb6LlCoT9y5ANDQqMgIa+ucRkxYt6faSnZRHTtKQl5y7TRTGKCpP4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6747.eurprd02.prod.outlook.com (2603:10a6:10:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 21:17:50 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 21:17:50 +0000
Subject: Re: [PATCH v6 08/13] iio: afe: rescale: reduce risk of integer
 overflow
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-9-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9e0e4398-873e-b5c0-0f0c-50a186ed2228@axentia.se>
Date:   Fri, 23 Jul 2021 23:17:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210721030613.3105327-9-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0067.eurprd07.prod.outlook.com
 (2603:10a6:3:64::11) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0701CA0067.eurprd07.prod.outlook.com (2603:10a6:3:64::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Fri, 23 Jul 2021 21:17:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2e33328-1f70-4e40-c7e0-08d94e1f5393
X-MS-TrafficTypeDiagnostic: DB9PR02MB6747:
X-Microsoft-Antispam-PRVS: <DB9PR02MB674700C59C591E6409018AF1BCE59@DB9PR02MB6747.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFetvBRP8eKlF11LDbEoleNbM/o3s5n4+BxNqjJAYm9rHvqXnK27dpXtrFTnxBPNt9dJecT1ZUxHi4kuyKsePojpPZIUiyUoQAtEoV1uWnP9JzqOcinXg9gpUZdqfAxlnGHaO/7OZX90/RFHunsU0k7ZRKUPKMffvUKqegLXG2hT7xxQhISy/1YOgbeMgWOAjm9MUTUiw5G6Bw1AAMw2RSOEgWg1NKuvx5hWaACR6psXMlMfyFnzjsmlUDYBRX5PXn8OFx/oZMwSHLqwX/EkkNW8FildGpy+yl34XAPIpJ0GTZjXqoJhxXGQHWuImTm7d1e6kWdQ2XZSbS+yBklCQK4r7zZewikbcT+8hPBFBfe+vqdoR9ydjWw9dfyu66soI9Ddjl58rhXVIpsfsv6yAu6W0I4HNT6BWyMWStcbRbYetkJVMoBPoAmO4popQ6jyNFuyn4vDeWkk9XVLXeTZnkGSkFx7yHaGMtmMh7woyaLwXAsrbymAFOCCyNawG9TzRm5FhACZXtPdL3j5znKKA3I2YitV5M14hr4YeXpqrpdYpRpsf5s0xcAst+2gDcwo4G3MW2mvcYyTdJLKJwpnHI51vsXdyfZCWNm1E0rM2pTxcmAXzjp6DzdpHP05LBy82Soyvvz58xMzd1oZhwcUDtyqlNTBkmd2tsUhF2RrynZDn1ikR0vvmUzfNdVWTrx6mvI46wvmwF9T87YoRhV+BZNNn5sZKKTC51005SlntUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(376002)(136003)(396003)(346002)(478600001)(956004)(83380400001)(16576012)(5660300002)(316002)(36756003)(2906002)(31686004)(53546011)(36916002)(8936002)(2616005)(4326008)(86362001)(8676002)(66476007)(66556008)(31696002)(66946007)(186003)(6486002)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzVHdVdpbTBqOFc5V0pnQzBRTXduQ3gvdWc1WEQ5SjEvcjMzR0hDQWxBdW1H?=
 =?utf-8?B?alZlRmcxa1ppdUF4K2UrMWRha0pEb2ZZTWFJY1RKakhqOHhLazBpeGF2U1pu?=
 =?utf-8?B?YVdtSTZXN3ZOU0FEenJCTnlaaXAvbWdtTWRFdmVkM2RnRXQ1MXhSemV4b3FW?=
 =?utf-8?B?RWxWSUppcUdzaFQrNURxUlBEQlNVZ1lkVVJBVlp0QWxGTEoraEYwRXkzTVpx?=
 =?utf-8?B?ZlRyN2ZJL0ZENVVyR3M4dWRyTjJLZ0RHQmY4UDdGV2J4S1hzTWFNQnB4OE43?=
 =?utf-8?B?V09ESEtNNjd4ampRalU1dVNaYzNaT3ozZDdvVWQ3NUMvWHpsZE9GY2RpaWRN?=
 =?utf-8?B?MFczTG5VTmlhTkFrNHFFbVRvY0VTazFmMUlxVnZzcW5lT1VDNmh4RHIrcHJT?=
 =?utf-8?B?RWpGTUdyT0g1Q1psUVhpa1VKK0dMQzZwLzBvMWFjamRPU1FOSkpkeC8vQk5B?=
 =?utf-8?B?OVF0c0pMSHZvc0hpQjZlRzFFUjNzNUZFcGpWcFZ2NmY4eWVVeE1uTllPQnZn?=
 =?utf-8?B?SGdvSUlGSmYweXlObTV0SC9uWTJ6RTNkUzlYMlI1eURFVzJaek5qU3dtL3ZD?=
 =?utf-8?B?Ukp3SUs0SkNueXNNTS9IclJTVDNzMTVzbTlza2NibExRS0w2SnU4L2IzVDR6?=
 =?utf-8?B?YlVjK0NNeThzd3dQV0JMaGJOTjR1L3RTS2tESVlNTm0vZmdtVjBESVRUYllC?=
 =?utf-8?B?L1hYQkliTW91dnBBZGd5NlVlT0ZwOFVScnhqVkpzeXJQN3dtMk9KZS9yRHl6?=
 =?utf-8?B?ZFBScWVyRWJpS3VJT3htTGZtMWw0azdrS1NtbTlqdUFiTTh4T3BzSE9KZGJZ?=
 =?utf-8?B?NVVuUk83dVJpdkpXbVp4Q1JIVUZqa2tqUXhVYmRyRDlodWZQemF0UmxkdjBL?=
 =?utf-8?B?VHl1dWF6UzRXK2JoM3oxYXUyVm5Ob1lONGNvTU9KYkk0RUhybUtWM1BldjFV?=
 =?utf-8?B?S3AyeFZxQ09mcU9pU1BVSWV6UjFsZEwvdHhDdlJFL0FkWkR5bSsrNUVRQ3Rr?=
 =?utf-8?B?eDNXcjNEUlI1ZkV5YmVnSmxxMDNTYW80VytCVTdqbms1Ujg5VzdPSXZRQXBU?=
 =?utf-8?B?RUViMzVPUitFd3RFaWtXMEZweEtuaWk1WW1EaG5BTVNQamRmL0Y2clBIaE9l?=
 =?utf-8?B?RHZmV0Z5U1Rja3FyWU10ekFrdlFqcGg2eWlCR0xqa1JPS0Z5WXhJdkRHVmx2?=
 =?utf-8?B?OEpiWklIazRlSVRGcHJKalFvTUg0OVRsSnhVenV0ZFF1REFzbGJBU3VwQnkx?=
 =?utf-8?B?Z201WXpEWjJuVE43MFEvNmYxV054YUlEVnBUeUh1RU5PUzhUalN4MjV6VkpV?=
 =?utf-8?B?SFYrMjZrTUhRQ1ozVXlBOXlBWlh4WnBaaVRCWCszVjM0M0tKTGpEbUppZzVx?=
 =?utf-8?B?MWh4NVF3Y2dwcEpVVHd5SnZDeUJYamQ5VHpneFg4R1AvVXBUME1VR3BFa2JX?=
 =?utf-8?B?eU40TUtOMXdsRi9GVDhoNHFhbi9JMk5aYlVicXJmdTUxOEU4NFJYUUx2TDFl?=
 =?utf-8?B?VkdoS3F4Q0RnaElyaDNCNFBnMWMreXg4NjQrYVI5eXJIUnhqdkpUMkVqM3NF?=
 =?utf-8?B?Q01ieDR3OC9Pa0lZUDdydjc4aDkwSTRINmUvNGJEMjdFYjJEM0NyU01VZDJM?=
 =?utf-8?B?TzFBcGN3V09HZDJvMlRzVzVwUklxYUI0bHVRNVZzRFIyMURBdzdIcVpRREt1?=
 =?utf-8?B?UWNobVNjdGNHelpUeVJTUnV4SzJZRXpNazRPUXVkSmVVbllOY3BIajFSQnN0?=
 =?utf-8?Q?xeAPNOwogjLrZT+ZMOmY+Qz1shxoR6tV/YCEv0w?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e33328-1f70-4e40-c7e0-08d94e1f5393
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 21:17:50.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC6CjcKAkOBF2do8mrC3j8VQCG0lo2S79cjHMSdBOqqUnrbYnzfg3nIFwm1X7lmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6747
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-21 05:06, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Reduce the risk of integer overflow by doing the scale calculation with
> 64bit integers and looking for a Greatest Common Divider for both parts
> of the fractional value when required.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 6f6a711ae3ae..35fa3b4e53e0 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -21,12 +21,21 @@
>  int rescale_process_scale(struct rescale *rescale, int scale_type,
>  			  int *val, int *val2)
>  {
> -	unsigned long long tmp;
> +	s64 tmp, tmp2;
> +	u32 factor;
>  
>  	switch (scale_type) {
>  	case IIO_VAL_FRACTIONAL:
> -		*val *= rescale->numerator;
> -		*val2 *= rescale->denominator;
> +		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> +		    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
> +			tmp = (s64)*val * rescale->numerator;
> +			tmp2 = (s64)*val2 * rescale->denominator;
> +			factor = gcd(tmp, tmp2);

Hi!

Reiterating that gcd() only works for unsigned operands, so this is broken for
negative values.

Cheers,
Peter

> +			tmp = div_s64(tmp, factor);
> +			tmp2 = div_s64(tmp2, factor);
> +		}
> +		*val = tmp;
> +		*val2 = tmp2;
>  		return scale_type;
>  	case IIO_VAL_INT:
>  		*val *= rescale->numerator;
> 
