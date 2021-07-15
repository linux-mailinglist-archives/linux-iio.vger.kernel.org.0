Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A033C9C98
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbhGOK0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 06:26:16 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:32654
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232502AbhGOK0N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Jul 2021 06:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbQipzHkCc/r58vX1uVrcyf9qiV5qfjiVWbpyQuNv/JixDlY/jQ02zUZdrwhnyED+pOn6zu1W84kdQtQAMzqXKqzy85pltx/l5Tn3HIp2KQP1D4d9jP3RxgdS8ke4EDRXGtDng9czG9iOoVwUU940M1zzCjjDZH8UEkCjF0+sNqdRgL1nVgGHHpTWmTxZs70CxkYBPGHFLl4Agz8q6MQnI+PMPpxssRFKIP1Q/RledMQpGjtix9N8FqXqduQmWBbX3fYbOmJmukHk1+IWX4xtzZ5nc7t9gNGAqVj6wpw8Gw5oaLgDZyUB+03O5EJM462fRzQ1EkBTx/ZSU5s5TdDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR+7046mkzF8m7n7yprf/tHMlgnMevKqOvDGJ1xAYfo=;
 b=PvjXNj3fMZiOVNLe1jJ1qYyONGzPPjb33WO3WzevAwafB7D+BEwL1yzk7+VpGFDIIOnUm6n8pbm1InlytRQZZC2WIYN3wTPNgH3UXw0hWDOMI3snm/Wy6eBlWfAQXZZgu463mJ/HPh2zZt0gQbH358Lnksqt1qkf7idJOSXA7hTM5roFjnA0jkLPeB88zrxrwJ3sEPi33K7uASiH62UpUwleVrsamElWO+eNyrg6pttJ5JAbbcGmLlBrnHw098v0kq81/eE8tnJTcpeN1rW2p+GY52/mBOutIAE7cMm1RPF9Xy1rk58l6DzHB6GQQE4QHttrdD4Na05+/VOjj1uDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR+7046mkzF8m7n7yprf/tHMlgnMevKqOvDGJ1xAYfo=;
 b=BnXRt5PoJEanksO4qnQd0Qm3eNYDXdZOVlGox6/7x+U1NDYdhEuPHd9C9imyMs4P9upkQNS/BEsKf9qoJM6EVOXl0WbpO8Ff4DOiKZMRaroVh9xEoxm5MMRTkDwJ0DIl4jHRP2qlBGe1stffXo2IU1ZpDa3IcMuh9iDBHtnD4go=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6423.eurprd02.prod.outlook.com (2603:10a6:10:199::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Thu, 15 Jul
 2021 10:23:17 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4308.026; Thu, 15 Jul 2021
 10:23:17 +0000
Subject: Re: [PATCH v5 04/10] iio: afe: rescale: reduce risk of integer
 overflow
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-5-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e83ee306-2421-c327-7627-18ae2a7928a8@axentia.se>
Date:   Thu, 15 Jul 2021 12:23:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715031215.1534938-5-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0090.eurprd04.prod.outlook.com
 (2603:10a6:7:54::19) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0401CA0090.eurprd04.prod.outlook.com (2603:10a6:7:54::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 10:23:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f15d8eb-f38e-4d57-31c9-08d9477a8fc1
X-MS-TrafficTypeDiagnostic: DBAPR02MB6423:
X-Microsoft-Antispam-PRVS: <DBAPR02MB6423353B7CEC3726FEC91711BC129@DBAPR02MB6423.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BdSD/Hrd6Kbd0k/74u+Gt8g0I8ggVkLgvVc6tzs3PnWiCGxKGB9WGUuBqC3dK013LvMC2KlDXis0zcv9+Iv9JIqcyO7yYhL3afAa9vuKJq7GvN5pCItQVzJEI7D5abRFUWrOuWZRkRqfyJjpqKxAiVFAvhb1X/Mq32t1k9JdQX2WB4RucG04HJZmoohs2yE/CMCXuqljiL74kZEp6hhS4e+lsQyaUfDec9WJBb8NUB6s/A2Lo/AO3lIplnyR38wl+RXHiS+EfCSrn2UmINJ27/LjVeRLpc8Pq3khUKrmUM8wEm2L4JQgDYAI/lAmw7+FgDVjIsO5Cx4CzIhOtUz3WmFMhrxHoclxs8CVOIHdtUfAkor22SQ+6zP4+QBVtNaHlX6DEb3Lu/sOH4mIHyVd2T5xNutYPHmMumc9CZhJ7Y2Dqi7B8qkvuUkqaPyeyLSqTXpH7thKHZUEeUh4w+JyWOnUqBxCH7NZvouL/ye02nsihkSaGRs++3nsVtuhRyQ0OEQA+STy1mlZLr5xnq/RTBioZJywUDoevKwppv1JZ5FCDh8yFpR1bT3lREpWQ/Yj0K9CMeXMZf0x8uCaaJm9iNU4DPssiJZfrZ1l+Dtcb55hT7xLBg6IUvaRe2gXyB+1OU/OyUOy6hWGKk2gqOtp5PFlURewQQq1UOQZXC0Csoq26wy7k0GMMTLtqLMjIwlQ1EIFruLuszW5oG2GfRXwRhGv51D3hYOufV1SnCM12k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(136003)(366004)(376002)(8936002)(2616005)(53546011)(956004)(2906002)(5660300002)(6486002)(316002)(16576012)(26005)(478600001)(8676002)(86362001)(31696002)(83380400001)(36756003)(186003)(38100700002)(31686004)(4326008)(66476007)(36916002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0gzMm9YTlhNM0tkbEp1MnBpdTdySWRoZHEzWmJOVWE1MVBydlhNZ2dwMmla?=
 =?utf-8?B?WnByakJPL2h5aHJJN3l6NDB1MnF5REdQYWZrRmdZU0xwcWRrb0l0RkUrWlpX?=
 =?utf-8?B?MHNiTTFnQmUrdXlFOXMrRk9LeUZ3VEtQZTcxbXNJc3libGZ2VmJIRDJmMHN4?=
 =?utf-8?B?UkJRdWFQdUQvQmlDUWlqcWlBZXppKzVqeU13V1pnQ0h4WE9GQnRMU1Nwdktu?=
 =?utf-8?B?YWllcUlOT3htK3ZYMGZQc2tqKzg2Y2hOZDZyQkQvd3M0WDZoMkVpODNleUZa?=
 =?utf-8?B?YzBaTGRrUDhEYjlxclNxcU1sQ0J1WUtDN09WN3ptUHFCYm0rM2EwWGtNUjJL?=
 =?utf-8?B?L0pCM0szdG9SWng3b29kWWxDK0R0OFg1eTJac000dDlKOU5kU0lObGJDenJx?=
 =?utf-8?B?MUNwMUcyem9vamNWcnlrSDdnVEFteTdKQ0dRK0VjUUc1aDF1SXpmZ0RwaTE5?=
 =?utf-8?B?UFlqQVAvTE5XNkRQZ0ovS3ptT2xBYWVkc3NQTHVKSFM3VTlFeFhNeW1sdHlG?=
 =?utf-8?B?dnZjWHFMaTRYRW9QdTRWVkZhdVNaRDJIVEtLWmZ4U2Ywb1pCR3NPWXhZRWhV?=
 =?utf-8?B?dHV2eUpuMm5tZGNBcW0rVWdtazdMaUorYkZzd3RoNWV6VzNVK0ZDdThtalZ3?=
 =?utf-8?B?NnpjY21oTE5uYkx1dUtVejRlcUFHUitHSHI4b0FIeURVRm1wcm9sNFIvaytO?=
 =?utf-8?B?WFlEODdrZG5JZVdYSTdNaUppZ0hzRzR5R0s2bDlXQW5pZ3llaHZJTzZWOWJD?=
 =?utf-8?B?Y3dyc2RoUmI2UVVEKzZNSGJXLzFOcit6Z1pmdXVSUkRnRUcyeUEzblp4QVZR?=
 =?utf-8?B?Z2VnWlE0TUx4Z0tMc280Sk83cjB0WVhmcFJiTVhsOTF3Y1BwSGNCbUUrbSti?=
 =?utf-8?B?V2E1RzVMK3NJeTFaM3dDWW8zZXJRb2dmd2FXaWdPcTdYVC9peXRHNFRXa3lC?=
 =?utf-8?B?ZVhleXZXdzVzV3E4Y0JLV0FQblVhSGRoVHdVb0ZxS3pMQzNYRC94KzlTY2lz?=
 =?utf-8?B?djdzTThHYWpBbGlBSzRHbmFNOVY2aEQ5Zmo4RHBubFBlSEZhbVlQcHM0d0Y2?=
 =?utf-8?B?SUVzUTdNZkJoT0owSFJRU05LNkZJWlFqc1Y0cmVsL3l2VEppWDdUTkJ5NzFi?=
 =?utf-8?B?bzFlRmRkSmZxVE43ZU1ZK2JGQ08vL2ZRQzRJaUFycTM2d3FpTi8vOFBDTklQ?=
 =?utf-8?B?UHVRcytsRGVPNEVVT2g0NXJkdFJtZTNORk9lS0p5VHJINDB1Nk95VmdJS0lx?=
 =?utf-8?B?RGtVNmZoRDFBUnczc0ErNmJjRDZOZ0Zuc29yOVM1MHdjMFl5UGoyRUZCY3hS?=
 =?utf-8?B?U0UwbzMrSnM4bGFXUEcyUzVHU1Vjck1KUDdSN3QwOHlPRVN1dG94aFlmcnZj?=
 =?utf-8?B?N1BGd1UrQWJoYWpJaWY0WWVlc3phWDJ1WGxpdTh2YUt3Q0lmTE42WWJ3K2Yw?=
 =?utf-8?B?a2dCeVI2U1VrTkluejk3VlRsN05TSk1jNk1DdTVPWGdhd0lKUm9ramZhZ3VM?=
 =?utf-8?B?SmhEL2NSb1hSelE5bmRtaXZ3bTVSam0wOFEwUDR3U3VsYlpFRmptZCtCbHJi?=
 =?utf-8?B?SFJiYWl1UXczcXBFdys3ZHFTUjFZZFYvYzBOeFdUS2lTNzl4enlrdjlsZllP?=
 =?utf-8?B?QUdUUGVqL3psOTRjT3lOVitadmlhc2VBTEF0WnYwSVQxbG1VZWlUNEJRcG50?=
 =?utf-8?B?ZzI5S3pJbEZ0ckl2UCtkcjdodlhRbHJwQVhGckdUZFpTcWEyMGFla3VodmRN?=
 =?utf-8?Q?ZB84Kqmv3Q42UTI7UYE37JwxDoyl/brnnpQ3AYy?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f15d8eb-f38e-4d57-31c9-08d9477a8fc1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 10:23:17.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wngtr3gc0yHUBjf46grA+8HURR4fV1+fYzS3IZ6VpgxZStN/6b4fFrVbShr+aJj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6423
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-15 05:12, Liam Beguin wrote:
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
> index 774eb3044edd..4c3cfd4d5181 100644
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
> @@ -67,8 +68,16 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  		}
>  		switch (ret) {
>  		case IIO_VAL_FRACTIONAL:
> -			*val *= rescale->numerator;
> -			*val2 *= rescale->denominator;
> +			tmp = (s64)*val * rescale->numerator;
> +			tmp2 = (s64)*val2 * rescale->denominator;
> +			if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> +			check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {

The white space should be like this, methinks.

			if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
			    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2))
			{

> +				factor = gcd(tmp, tmp2);

And I just realized, gcd() works on unsigned values which is a bit safer for the
scale factor. But here, for the actual values, more care is needed.

> +				do_div(tmp, factor);
> +				do_div(tmp2, factor);
> +			}
> +			*val = tmp;
> +			*val2 = tmp2;

And beside the above points, the whole mechanism seems broken. The returned value
in the third argument to check_mul_overflow isn't useful if there is an overflow.
Yet, the code continues to use tmp and tmp2 in case of overflow. And why do you
first multiply tmp and tmp2 without checks, only to then do the same mul again
but with checks? Or have I completely misunderstood how check_mul_overflow
works?

Cheers,
Peter

>  			return ret;
>  		case IIO_VAL_INT:
>  			*val *= rescale->numerator;
> 
