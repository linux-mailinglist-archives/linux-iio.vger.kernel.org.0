Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3A03C277D
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhGIQ1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 12:27:09 -0400
Received: from mail-eopbgr00106.outbound.protection.outlook.com ([40.107.0.106]:1248
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhGIQ1I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 12:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqnrhV+UhSOo3ziBqSPkd1AQ+ZtoJ9kazjXn/x9Eg/3LEGt3zW5lwOcoVHgEhkpGiwd0ttif4YG8w09FyoS1wP/IHL21O3OpcKHHmlGc8NKS23yrwaAnLwzcKPj+FZjzaN20z5dL6X+EwQhVJEPaom/jOWQwpcLnCvhQtLGKT9u9ThzIgijA2ja1fgH5MxeUQ2O6Fp3rRanTOjf/zrG/iWT1+G9hBqVTvBpiec78JlSPF5XlXWhbZDYAs1gFiY4tqdLW3byLiKfMP9hlMySarfQSSFAQtzjIFmv0PojHEXZxpqrUH24SWA3j8xSzuujjacUPnMifFAQzy1Kr09yNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEz8GlVXGOfxqhxm6e/QkFiDH2qJ9OWMp5VYbZ6fHOU=;
 b=X21460WB09JeDnWV3ME7Zw+AVhjfvkzsIaARVz/Ol6tl8epfNAMQRw9FT6TFNHg6zyHRJbSyG6MbtWcaeD3q5+PiaAJS5CTEgDzK6v/D4H8+Sk8gtNSE4QbcA+ICpyzl0UsT29tchGEncgWAdPZdIUfd3pjVZdVR7UwegVRBwvBe4i7bkK9kEIL4A9aFqdKxTyqwc5Kh+A9sUV2dhUvAd35MBrtAPgLQ0b8vtnLvljkxjNNwmhoBamZvSxisMdzIjSVqyusSiqY8kOikMPjjAH9gQdqWug5KuhnLn4gI1RKSlrExAgtEBt3eXCPwyw9JAkIr9n1M/zwmNI82MSE5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEz8GlVXGOfxqhxm6e/QkFiDH2qJ9OWMp5VYbZ6fHOU=;
 b=cjhbGOP3CbIMeH8WNu9IgEnZWbBDhK85LLWf8jAKZCrz3q3/L6kqOxwX9VbGC/buROcM0Iv9kr+JLu3R82NheY2uqb9N/dIY2Jx8lsgnZ/4nsboUU+APRHugzHCiYB6k81AcnxDGCmWJZ4rqhpYD6SY62TW/i5UKgeRHtY3gzLI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3818.eurprd02.prod.outlook.com (2603:10a6:5:b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Fri, 9 Jul 2021 16:24:22 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4287.023; Fri, 9 Jul 2021
 16:24:22 +0000
Subject: Re: [PATCH v4 04/10] iio: afe: rescale: reduce risk of integer
 overflow
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-5-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <13409f37-ecd4-5afb-e1ca-59f1f1f805b8@axentia.se>
Date:   Fri, 9 Jul 2021 18:24:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210706160942.3181474-5-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P191CA0038.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::15) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6P191CA0038.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 16:24:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b3e6ab-e711-4875-1b0a-08d942f60267
X-MS-TrafficTypeDiagnostic: DB7PR02MB3818:
X-Microsoft-Antispam-PRVS: <DB7PR02MB3818650B0BD14B8325C3CACABC189@DB7PR02MB3818.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZqB1svluEiGR2u87WhG4g+eKUdu5Ex6XMUGN8I2PrQ9YUiM6YTEkJ1+MzP7d2MNxGUkaZtZHidZ7RjTkxjd5f7wNZ1QV0iPJ1uWtSDWkSpVpg6IgSmohcb30RcqqFFsP0+Dd6eL2+D4XQb+e7RBh43ISC4JaVxypGsD4BPH5+t5QJ2e4XcLTfPwP/0MWaRy4yGnVuElEqEZgSot2x1nHIpE5mZFlbCYPibnFWMgITaBO9Nk6oM1/Q5fUI5qhsDU4SXepJjr7LBodzuoEdu6Umzm1OPnTIgRCAz+B0lUQO8iqINLRcGnW1b+6gZhrRLFconKINBY7W6XVI6pRD/C9hxmqpoZdrHEbAEMXPh5IwEuBsKjVNA/5TYumVoeOOvbcaFoGyLSW220gkXWFN0TxqBIM0uqRAR/GD7uE8aa78lofBR3XHa+TEsT5Jo8goGEPhBhwjoA1EqUHwQkO+6TR0zGr4P8PKRsf/P7fx3/RoT1FXM1hq/aNgdquqo66C4xCTdqa/mLDDCG6fK4BOb7wXVqZ9+gbYOIUO9MZ5EMaf9Okf1R3rPblQm94faQa3pkuzBg+9qCQ7wt3eW+vugjG34GipGNZQ+konwvm4Nm1HJcp/eMyJtyt6QEvSVuIa4Z3w6zi/900fw+Wn61o86+n5e2zdQ2/IXBOjYovlkuj7pxEgfRXYbIMRtkJO9oeXvJWYpVvuMyv1DFg+maMoeEtrRt6xoa0mwr9otdoZ7JD9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39830400003)(346002)(366004)(31686004)(6486002)(86362001)(66946007)(316002)(26005)(31696002)(5660300002)(16576012)(478600001)(2906002)(36916002)(36756003)(38100700002)(53546011)(8676002)(186003)(66476007)(66556008)(4326008)(8936002)(83380400001)(2616005)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpDT2taUkRra3RoZTMzNVFOYkdja0g3a3BhUHIydVJYZ0FqbGd4RUtPNVYx?=
 =?utf-8?B?Q0JoSytxS0pkRDEwVHZmS1RrUzBySVlyRFFrYkVlbWRvblJjdGhXSlNXck5i?=
 =?utf-8?B?N0p3V0hYemlSSUd1TDBVVFRRcUtYa0tZYXNVWUMycTJwQnFHYlhHVllDS0RP?=
 =?utf-8?B?R1lrM0VjWmliUUZqQlVzcWI5UEJRRVdDUXJMS0lwdkRvUVZJN241MWZWeWJX?=
 =?utf-8?B?MFdOV1VQbTBmWEZmbVdKT1JjbGoxcmM2aTNPMlFLZEZDOWF1c3hCRVk4ZTRH?=
 =?utf-8?B?aW05NlJ2RFd1TjJVRm80dkVUQ3dOTzMwYnp1b0R3aHg5R3lzNTh0cERtQ2Ey?=
 =?utf-8?B?UUM5MjhEcU9WSHgyOVViN3hRM1dZdjk0ZlpyT090MnM3dWdnYmpZQm8xZnNo?=
 =?utf-8?B?V29QZmRvOTcwY3F2WFVQWTlhZVFtOEg0YjJ4NExpVkZoNTU0M2ltekdJWDNr?=
 =?utf-8?B?WGJBWjZUekE4UVlkeVBPa25ZdkNKWFFTbGVOOEhiQmxyR2tjYjVuMzV6WUxp?=
 =?utf-8?B?RU80THNaUnRMZW94YWFUNjVLZTZoWTZCeGJEYkhxR3ZrbmlhbUM1dzNJOW1t?=
 =?utf-8?B?V1VoMTAzaW5ka0F5c2lIT0oxVVdmTWQ2VWJyd0lkcWJ1MmorZ3dLdHhrVVVS?=
 =?utf-8?B?QU9OUDBoMUlFM1hNUitEOE1BZVYycE01OTBGZlAxQUJyRGZuYmpEc0VPczV0?=
 =?utf-8?B?dXBKZnAxYTZUaUQzQ1QxODloOTlLazR6Vmx5ckgvMHl4MXBDTW13VGNUTFBO?=
 =?utf-8?B?OEJYbm96TFh2Z3gxdjQvb2paYTQ1QTE2Q29UaFd2by9GSmRTSGlMV1ltMG4z?=
 =?utf-8?B?Qm9jaWwrMWNTcWl1SExwcFczM2ZwY3l5cUNiWlhVQlR3NzFRekJiZTRqY3Mv?=
 =?utf-8?B?aUNFSE4yOTY1TytSRVpTZkFxWHJaSGQ4MDRvcENNa2RDL2huVXQ1dHFtOHZ6?=
 =?utf-8?B?SWtGYUsvTTZCcmhYTFgxYXprN0R6ZzRFRlNDaytYL2xhcGlOTlQ3N1RvUy9O?=
 =?utf-8?B?SmRvZXNNcjNYMnR1TXFLY1d3OGV4bDRZMXlZU0RZeWR0N3pSMjZqRmdjQXRQ?=
 =?utf-8?B?Q0Vnc3htOS9DeU8yWlI4dUdBR2NEeEdCVFQ2ZVRuenFMMmF1OGE5c1VGR1lE?=
 =?utf-8?B?SmNxbFMzYUxzZEhzc3Exc3FHWXdQWEpFSHd6MUJ6eXVpTFQrK3k5NVBrZkgx?=
 =?utf-8?B?SDdGRzBHck5DRVpSRG5PN0NDYXRwMitrTW0zOHF1TWNOY2MxZkc0L2MvM0Za?=
 =?utf-8?B?Z3Z6VlgvUmM4UWx2WW84dlNLMHREK1VqQkQ3ZS90QlBsNWphVHdaOHNvSXQ5?=
 =?utf-8?B?K1JnY08rY253SnRXTzA0cUtXcVN6VTNLNEJGVHIwbW16Mkd4dERwZ1M1VTZh?=
 =?utf-8?B?bzExUG52Q0QvdjZ4U3gvMVBCd0xVR2RYaENzc2ZtOTVNZFZoUzlPYy9jNjdY?=
 =?utf-8?B?MXpJUHh3S2tVeit6dWtJcDZxb1JFYk80OXphR3RFeEN0WmhscUZpVkt6ZytZ?=
 =?utf-8?B?a0ZWaW1nRDJ4WkxTN2I1Y2xJaGI1NzkvZE5sRXhybktIb3Y1cTNyTHNmT2xH?=
 =?utf-8?B?QkNjWTNTY1RkMlVPV3VQRnBmRmtBK05BNHRTb1k1RkY1S1p1aytMRGpES2E3?=
 =?utf-8?B?WkwvL2xKN21iMzBENGUwa1A2UURWT011QkxjVFh3SzJTWE8xRGhzeVJtWkMz?=
 =?utf-8?B?Q1ZrK2J2NkU0SmNYQWZTSDluTEE4VGMyOGRPR1hialN5ci93MFJhckZCY2J4?=
 =?utf-8?Q?Buvf86fhB55zb+55OMBYjeasnbBglHx/zBXZVd4?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b3e6ab-e711-4875-1b0a-08d942f60267
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 16:24:22.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOn9mtNAXHMu/4AJy+cqJpnHFdMdC2h5m5EoZUJNDet0S/43+qQ4RwjiyRdeO2Og
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3818
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 2021-07-06 18:09, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Reduce the risk of integer overflow by doing the scale calculation with
> 64bit integers and looking for a Greatest Common Divider for both parts
> of the fractional value.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 774eb3044edd..ba3bdcc69b16 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct rescale *rescale = iio_priv(indio_dev);
> -	unsigned long long tmp;
> +	s64 tmp, tmp2;
> +	u32 factor;
>  	int ret;
>  
>  	switch (mask) {
> @@ -67,8 +68,13 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  		}
>  		switch (ret) {
>  		case IIO_VAL_FRACTIONAL:
> -			*val *= rescale->numerator;
> -			*val2 *= rescale->denominator;
> +			tmp = (s64)*val * rescale->numerator;
> +			tmp2 = (s64)*val2 * rescale->denominator;
> +			factor = gcd(tmp, tmp2);

Hi!

gcd() isn't exactly free. I do not think it is suitable to call it for each
and every value. So, if you really need it, then it should only be used
when there is an actual overflow (or if there is a high risk if that's
somehow easier).

Cheers,
Peter

> +			do_div(tmp, factor);
> +			*val = tmp;
> +			do_div(tmp2, factor);
> +			*val2 = tmp2;
>  			return ret;
>  		case IIO_VAL_INT:
>  			*val *= rescale->numerator;
> 
