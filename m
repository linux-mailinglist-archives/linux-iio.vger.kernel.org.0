Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B973F84D4
	for <lists+linux-iio@lfdr.de>; Thu, 26 Aug 2021 11:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHZJyG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 05:54:06 -0400
Received: from mail-am6eur05on2103.outbound.protection.outlook.com ([40.107.22.103]:42449
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234666AbhHZJyG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Aug 2021 05:54:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC90CmvuVlDN8IpqGniGnMZMywpyhilL453bkKmifygEltvlumSHLWpaAyuwQgktjkiljl/zrlV+8U7MuncGNKi7KYKUjTGf+aMTBowPDPrBmWZVEjo+/m8KjGTTqFqchqpM9Kx4ZuiFyq3CiNUTJxCpgXgFojyGr5g6GNrcyL8etqTs0HR+CvL/E7HO3EccGO1QHqv08vqtP0ba/vC1SwGSqJZucVG/RJo0mK6DTY0VgT3kqp5mC5a1jUgunJxR6MLNyiHubPrKkU/wAuAeX1h8fMrAMFVrqHoUTkrK3afbvKHLHA3QbdixSgC0WPM4EsWvoQ5d9Q7xFdK2qB7e/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaaMbDAtcLpc2x8oRKjieZHpwVXdHcVF6Abikylo8YE=;
 b=Os/UZueSsQAg5oN3yPLsGIT65eDlsP98ZABJkDLq8tQ8ZAHPRx6ua43Bev+0JPUapY5AunCjR0B+CgpocCD3KITLvTTf5R81Ra2Dwu2WDn5Z8rFAHwSa2Z69ET9kBdQRN2KidG+A/+a6H5QJoniHnCKu9yxZ3mFr6ajSV6lVwZPfQmTruR+7VUfXyJlq9u4+sOcxArccBoCK8VEbygxmyc7xvi6MQ4/aEtczShohyD4r3gBbmKAuG7P2EQ2d8W249/Fff/S6VNjvuN8438INimf49piZO95VNsmBoraBz1bLeM6NmtdOsF324S/3Hg3pi9uJmQJRH+qzgU342hNgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaaMbDAtcLpc2x8oRKjieZHpwVXdHcVF6Abikylo8YE=;
 b=M+qQlHCdLTjm5yhBBZggRmFmnq0lAzFykI9dXUMCObZtrbaQCcahOwezqZZiTvPECWjQ/cNRDc/2uPPXnRwGAKKYDuvUtgMkwk32t8P4SAWKoxZyqsl+x1Iri6swmPreGa8BYZA1cWEeAK0GPTAcfpkUjGd9q0oLPmVoXfBpEOo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7259.eurprd02.prod.outlook.com (2603:10a6:10:24a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 09:53:17 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4457.020; Thu, 26 Aug 2021
 09:53:16 +0000
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <YSVWZcjW8QoDaSpN@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c63fb63f-884d-0ffb-b25c-bac591f169f7@axentia.se>
Date:   Thu, 26 Aug 2021 11:53:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSVWZcjW8QoDaSpN@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::17) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR1001CA0007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 09:53:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 853cdf4f-7f80-4b4e-7bd4-08d9687753db
X-MS-TrafficTypeDiagnostic: DB9PR02MB7259:
X-Microsoft-Antispam-PRVS: <DB9PR02MB7259885E1A055D42151563EDBCC79@DB9PR02MB7259.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ausx2M5nmiOFFls0NjcDNZrAmGGALh1OhjJLjxgStCYLj0KNCB8FstTcZBmIVdy15Ym1AYbLoInla8Cjg9TupGnd3t2Mqdade1W1wjy9KU3C4uxZV/xz/sL9D60zgIzQDMXIYAnEDLVD/cfScSPZ1mZ0oGNifbEpx42KxO5zz2I5h8xMJsU18OBo+nUuMjvOWhgk5xZyPckowzHDeu9/AfuAb6+F4OUTDefFLHlhnGVhuxm7u/5LPyZOhxxgg3GAP8eH5jcAQw8aEl2fc2AjhdFFvE5ldhyf4ECuiKenxOF90AEZh9NJiqAW4iVP9+qrhi9cjfSx6sIgOByZtMSouoO5dY/dtLTd0uMZF7SJ4zBKmMJVWHXQL3ZDgKWA7uXWGKcWKlUghDFoctkxZVELBmPRsRkwm9HM/G6ynuH3JEip4TNP9ex+jb0lceSRt+2nEquNuwaVKCC9vpwTwZZgV1LESNUDw/Bkb/dr8cPaqJCOYu7MhhBN4ghii5rOv4IgArPXptSVEvM6XaqARFCm3f9n33r98/XaZKJrg4OyD6sVo5tTRa8crV74Q4jYl2s2EdE0Ua8OCR0Kq+TpIfoCVsmuCxgT8FSie2gC0qt+Qa+yXGDVzgShtGCvH7+yP4qhljYe8jUpl2Be8a4HC/h0e4uY5MV9Z+zMHm2/uL0qpb2BqspnkWNUNxz8GthbezFqtUODnvfUrRntqn1SA+Ov3PqZT7WnayVpUXvych9Z6Og=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39830400003)(53546011)(66476007)(66556008)(66946007)(186003)(26005)(83380400001)(86362001)(316002)(31696002)(2906002)(6486002)(4326008)(36756003)(8676002)(36916002)(31686004)(956004)(2616005)(5660300002)(8936002)(38100700002)(16576012)(478600001)(30864003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE5BL1h5bnVFOXVBeUhOQWl1ejk2TlFJMVIvSitDbEgxZ2hjdU9uMCtNSkR5?=
 =?utf-8?B?ejVXVkQrY3R4bEo4b0tjbnVXZ2VTSUhKRjR0aS9iaXlCOVNSSnBKaTZjazZJ?=
 =?utf-8?B?U2I3MlU2MzV3NDJ6cG9GUlVuaCt5Z05Mb1RVdk9TalZJYnZwbkRJRW42Kzdu?=
 =?utf-8?B?RmROcWhxa1hFZTBBUjFRU3RhaklSL3dVdUYyb3BWM1Y0cDVFTkpkU054VHpD?=
 =?utf-8?B?YjJ2VGxZVkV0UGVLdUhzY3Fnc3NYQXdsT1BtWitHcjh1N2xOZG1TdTZiSXhp?=
 =?utf-8?B?TXFocWY1cSt5WkpEN21oeXRNeEF1R0RoUTQyTUMyWTRkV212Ui9Xc05PZ3B2?=
 =?utf-8?B?V3R3YXpQNFo3UGZmWjg4M011dy93aUFudFBrc2RDRVhGcDk3bTB5YnBSRTgz?=
 =?utf-8?B?cE5hYy9uekh1YldmNnFDbnRqejVHSU9FUDkwQk40bHlPNmJEbWwrYWszRVkv?=
 =?utf-8?B?NkZVbjYrQkkzeTNrS2tTMEtNeEEzM3NyaUR1MHZ5QWFvN2xxbFpOd0l6SVBW?=
 =?utf-8?B?eUxvbmkzVzJDK3lNOGE3cFFFcmxpeC9KSmU0U2F1T3JtV01pL3Zva21Kd2l1?=
 =?utf-8?B?UHBTVWlCc2pHK0tqVi91QlFEWFJQWVBLOUc3alVZenMxSlhmT3NLdEdTRmMy?=
 =?utf-8?B?eDROZE9CcDVnbldtRVgySlNrN29PMU02d0pwc1Y1ODhkdkN1TER3UXdGeXFF?=
 =?utf-8?B?OStVcElEMTJZQmJrS3V0RlFKUW5VRmJYVEFYc2RYdTQyZUJYWWNIcFJlZFB2?=
 =?utf-8?B?S3pKSVJqbFphRWZUVEhTMWVFL3dQc3RCVGVKVGpaN002a0taenFFM2txWHpv?=
 =?utf-8?B?M3NlNEw1aFVvZ0RtMGRYaWM3c1lmWllxQ0lXLzJvWGIwU0hHQlRsRUV3cklQ?=
 =?utf-8?B?RVQ0UkJrQmRMenpwLzNCQmdJZHhTbjRRVGlWTFBuYi9NMitLWEoyT2hMQ3NQ?=
 =?utf-8?B?OXNMOGpOTjJwK0FXR2ZHNWJRalNXaGt5RnJ6ZDVXbFZJQ2c4MTU2K1J6Rmd1?=
 =?utf-8?B?cVlZLzJjdjlxK0VET3RmSmNacWtvQ3VWUEQ2a3FQZ1NQa2VMeTNtV3l6WU43?=
 =?utf-8?B?Tk5MVm8zMS9tZE5jZGJDVmkzWityNnk3VTY0L0RqNG84YmFaODhMUmVBRGtV?=
 =?utf-8?B?dytMTlNhT3VUUkJUSldwaFQrb3l4VWlpM1RVTjh6R3hsbEJ2NHJTUlpvZ3Z1?=
 =?utf-8?B?OGloVHhodWxCMHJMZUVrNnZOVElSdk4vdmtIQ1VvVzJFeDZCNkc3aVUxdXRW?=
 =?utf-8?B?UFltYkVRdllDbTVHbjRtMDg0K2ZYZGFBeFM3N2RNaTAvbHlqeTZON0RvS0th?=
 =?utf-8?B?cDJaZ2Y5aVhyWUZyd1VFTWtxREJvM2EwSHc2U1g3SkJmdTZoWmdJbEU4S0Vz?=
 =?utf-8?B?VXNqb0p4bUtYV2NPNnM1TUVwSU02R3FDN1RvL0J1VmJxSExTelJvZURYREti?=
 =?utf-8?B?OGtTRWVhcElvaTNPOU40YTdPWXlPZEVGNmxwUHcreEdtbjIrdzJZeEgzV1Az?=
 =?utf-8?B?b3ZZQ0hWTWZiYkM1UlFVKzdtSVRkY0V0WEw3dWpPTVEwUWNHSjBxU0hLYWpm?=
 =?utf-8?B?NkRMVFJKNWRZeEMrUnNQYWJ3ME5Ic1FOUDMxdDErOWRYR1ZiZW5oVUc2c1Q5?=
 =?utf-8?B?LzBuMnQ3SWhVM0JoUGlwdFRRNUhYeXIweEEyM2tTWUZGYXk4UTdvSk1WUVlY?=
 =?utf-8?B?L0UrMzYremFsTGIxZ3RiNDFOa3Y5RXlYaEU1UkNpMVN6QWpPWjRRUnhCUUR6?=
 =?utf-8?Q?qV7uUx8Y62N+yEJzMM0bghq33oBit4Uk+ilognc?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 853cdf4f-7f80-4b4e-7bd4-08d9687753db
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 09:53:16.8344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3ovOBLMOq/CtJaqVAVdNGDI2XdKDee8uSH2KXBlo0q/PI9K3q5dnTqrT373TvnT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7259
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2021-08-24 22:28, Liam Beguin wrote:
> On Mon Aug 23, 2021 at 00:18:55 +0200, Peter Rosin wrote:
>> [I started to write an answer to your plans in the v7 thread, but didn't
>> have time to finish before v8 appeared...]
>>
>> On 2021-08-20 21:17, Liam Beguin wrote:
>>> From: Liam Beguin <lvb@xiphos.com>
>>>
>>> The approximation caused by integer divisions can be costly on smaller
>>> scale values since the decimal part is significant compared to the
>>> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
>>> cases to maintain accuracy.
>>
> 
> Hi Peter,
> 
> Thanks for taking time to look at this in detail again. I really
> appreciate all the feedback you've provided.
> 
>> The conversion to int-plus-nano may also carry a cost of accuracy.
>>
>> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
>> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
>> digits). So, in this case you lose precision with the new code.
>>
>> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
>> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
>>
> 
> I see what you mean here.
> I added test cases with these values to see exactly what we get.

Excellent!

> 
> Expected rel_ppm < 0, but
>     rel_ppm == 1000000
> 
>      real=0.000000000
>  expected=0.000000033594
> # iio_rescale_test_scale: not ok 42 - v8 - 90/1373754273 scaled by 261/509
> Expected rel_ppm < 0, but
>     rel_ppm == 1000000
> 
>      real=0.000000000
>  expected=0.000000050318
> # iio_rescale_test_scale: not ok 43 - v8 - 100/1073741824 scaled by 3782/7000
> 
> 
> The main issue is that the first two examples return 0 which night be worst
> that loosing a little precision.

They shouldn't return zero?

Here's the new code quoted from the test robot (and assuming
a 64-bit machine, thus ignoring the 32-bit problem on line 56).

    36		case IIO_VAL_FRACTIONAL:
    37		case IIO_VAL_FRACTIONAL_LOG2:
    38			tmp = (s64)*val * 1000000000LL;
    39			tmp = div_s64(tmp, rescale->denominator);
    40			tmp *= rescale->numerator;
    41	
    42			tmp = div_s64_rem(tmp, 1000000000LL, &rem);
    43			*val = tmp;
    44	
    45			/*
    46			 * For small values, the approximation can be costly,
    47			 * change scale type to maintain accuracy.
    48			 *
    49			 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
    50			 */
    51			if (scale_type == IIO_VAL_FRACTIONAL)
    52				tmp = *val2;
    53			else
    54				tmp = 1 << *val2;
    55	
  > 56			 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
    57				 *val = div_s64_rem(*val, tmp, &rem2);
    58	
    59				 *val2 = div_s64(rem, tmp);
    60				 if (rem2)
    61					 *val2 += div_s64(rem2 * 1000000000LL, tmp);
    62	
    63				 return IIO_VAL_INT_PLUS_NANO;
    64			 }
    65	
    66			return scale_type;

When I go through the above manually, I get:

line 
38: tmp = 90000000000    ; 90 * 1000000000
39: tmp = 176817288      ; 90000000000 / 509
40: tmp = 46149312168    ; 176817288 * 261
42: rem = 149312168      ; 46149312168 % 1000000000
    tmp = 46             ; 46149312168 / 1000000000
43: *val = 46
51: if (<fractional>) [yes]
52: tmp = 1373754273
56: if (149312168 > 10000000 && 46/1373754273 < 100) [yes && yes]
57: rem2 = 46            ; 46 % 1373754273
    *val = 0             ; 46 / 1373754273
59: *val2 = 0            ; 149312168 / 1373754273
60: if 46 [yes]
61: *val2 = 33           ; 0 + 46 * 1000000000 / 1373754273
63: return <int-plus-nano> [0.000000033]

and

line 
38: tmp = 100000000000   ; 100 * 1000000000
39: tmp = 14285714       ; 100000000000 / 7000
40: tmp = 54028570348    ; 176817288 * 3782
42: rem = 28570348       ; 54028570348 % 1000000000
    tmp = 54             ; 54028570348 / 1000000000
43: *val = 54
51: if (<fractional>) [no]
54: tmp = 1073741824     ; 1 << 30
56: if (28570348 > 10000000 && 54/1073741824 < 100) [yes && yes]
57: rem2 = 54            ; 54 % 1073741824
    *val = 0             ; 54 / 1073741824
59: *val2 = 0            ; 28570348 / 1073741824
60: if 46 [yes]
61: *val2 = 50           ; 0 + 54 * 1000000000 / 1073741824
63: return <int-plus-nano> [0.000000050]

Why do you get zero, what am I missing?

> At the same time, I wonder how "real" these values would be. Having such a
> small scale would mean having a large raw value. With 16-bits of resolution,
> that would still give about (1 << 16) * 3.3594e-08 = 0.002201616 mV.

If we cap at 16 bits it sounds as if we probably erase some precision
provided by 24-bit ADCs. We have drivers for those. I didn't really
dig that deep in the driver offerings, but I did find a AD7177 ADC
(but no driver) which is 32-bit. If we don't have any 32-bit ADC driver
yet, it's only a matter of time, methinks. I have personally worked
with 24-bit DACs, and needed every last bit...

> We could try to get more precision out of the first division
> 
> 	tmp = (s64)*val * 1000000000LL;
> 	tmp = div_s64(tmp, rescale->denominator);
> 	tmp *= rescale->numerator;
> 	tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> 
> But then, we'd be more likely to overflow. What would be a good middle
> ground?

I don't think we can settle for anything that makes any existing case
worse. That's a regression waiting to happen, and what to do then?

>> I'm also wondering if it is wise to not always return the same scale type?
>> What happens if we want to extend this driver to scale a buffered channel?
>> Honest question! I don't know, but I fear that this patch may make that
>> step more difficult to take??
> 
> That's a fair point, I didn't know it could be a problem to change
> scale.

I don't *know* either? But it would not be completely alien to me if
the buffered case assumes "raw" numbers, and that there is little room
for "meta-data" with each sample.

>>
>> Jonathan, do you have any input on that?
>>
>> Some more examples of problematic properties of this patch:
>>
>> 21837/24041 scaled by 427/24727 is 0.01568544672, you get 0.015685446. Ok.
>> But if you reduce the input number, gcd(21837, 24041) -> 29, you have:
>> 753/829 scaled by 427/24727 which still is 0.01568544672 of course, but in
>> this case you get 0.01568154403. Which is less precise. It is unfortunate
>> that input that should be easier to scale may yield worse results.
> 
> Expected rel_ppm < 0, but
>     rel_ppm == 0
> 
>      real=0.015685445
>  expected=0.015685446719
> # iio_rescale_test_scale: not ok 44 - v8 - 21837/24041 scaled by 427/24727
> Expected rel_ppm < 0, but
>     rel_ppm == 0
> 
>      real=0.015685445
>  expected=0.015685446719
> # iio_rescale_test_scale: not ok 45 - v8 - 753/829 scaled by 427/24727
> 
> It seems like both cases are rounded and give the same result. I do get
> your point though, values that could be simplified might loose more
> precision because of this change in scale type.

I aimed at this:

line
38: tmp = 21837000000000 ; 21837 * 1000000000
39: tmp = 883123710      ; 21837000000000 / 24727
40: tmp = 377093824170   ; 883123710 * 427
42: rem = 93824170       ; 377093824170 % 1000000000
    tmp = 377            ; 377093824170 / 1000000000
43: *val = 377
51: if (<fractional>) [yes]
52: tmp = 24041
56: if (149312168 > 10000000 && 377/24041 < 100) [yes && yes]
57: rem2 = 377           ; 377 % 24041
    *val = 0             ; 377 / 24041
59: *val2 = 3902         ; 93824170 / 24041
60: if 377 [yes]
61: *val2 = 15685446     ; 3902 + 377 * 1000000000 / 24041
63: return <int-plus-nano> [0.0015685446]

Why does the test output a 5 at the end and not a 6? It's all
integer arithmetic so there is no room for rounding issues.

and

line 
38: tmp = 753000000000   ; 753 * 1000000000
39: tmp = 30452541       ; 753000000000 / 24727
40: tmp = 13003235007    ; 30452541 * 427
42: rem = 3235007        ; 13003235007 % 1000000000
    tmp = 13             ; 13003235007 / 1000000000
43: *val = 13
51: if (<fractional>) [yes]
52: tmp = 829
56: if (3235007 > 10000000 && 13/829 < 100) [no && yes]
66: return <fractional> [13/829 ~= 0.015681544]

0.015681544 is pretty different from 0.015685446

Again, I don't understand what's going on.

>>
>> 760/1373754273 scaled by 427/2727 is 8.662580e-8, and 8.662393e-8 is
>> returned. Which is perhaps not great accuracy, but such is life. However.
>> 761/1373754273 scaled by 427/2727 is 8.673978e-8, which is of course
>> greater, but 8.6e-8 is returned. Which is less than what was returned for
>> the smaller 760/1373754273 value above.
> 
> Expected rel_ppm < 0, but
>     rel_ppm == 1000000
> 
>      real=0.000000000
>  expected=0.000000086626
> # iio_rescale_test_scale: not ok 46 - v8 - 760/1373754273 scaled by 427/2727
> Expected rel_ppm < 0, but
>     rel_ppm == 1000000
> 
>      real=0.000000000
>  expected=0.000000086740
> # iio_rescale_test_scale: not ok 47 - v8 - 761/1373754273 scaled by 427/2727
> 
> We fall into the same case as the first two examples where the real value is
> null.

I aimed at

line
38: tmp = 760000000000   ; 760 * 1000000000
39: tmp = 278694536      ; 760000000000 / 2727
40: tmp = 119002566872   ; 278694536 * 427
42: rem = 2566872        ; 119002566872 % 1000000000
    tmp = 119            ; 119002566872 / 1000000000
43: *val = 119
51: if (<fractional>) [yes]
52: tmp = 1373754273
56: if (2566872 > 10000000 && 119/1373754273 < 100) [no && yes]
66: return <fractional> [119/1373754273 ~= 0.000000086624]

and

line
38: tmp = 761000000000   ; 761 * 1000000000
39: tmp = 279061239      ; 761000000000 / 2727
40: tmp = 119159149053   ; 279061239 * 427
42: rem = 159149053      ; 119159149053 % 1000000000
    tmp = 119            ; 119159149053 / 1000000000
43: *val = 119
51: if (<fractional>) [yes]
52: tmp = 1373754273
56: if (159149053 > 10000000 && 119/1373754273 < 100) [yes && yes]
57: rem2 = 119           ; 119 % 1373754273
    *val = 0             ; 119 / 1373754273
59: *val2 = 0            ; 159149053 / 1373754273
60: if 119 [yes]
61: *val2 = 86           ; 0 + 119 * 1000000000 / 1373754273
63: return <int-plus-nano> [0.000000086]

> Considering these null values and the possible issue of not always having the
> same scale type, would it be better to always return an IIO_VAL_INT_PLUS_NANO
> scale?

No, that absolutely kills the precision for small values that are much
better off as-is. The closer you get to zero, the more the conversion
to int-plus-nano hurts, relatively speaking.

>>
>> Some of these objections are related to what I talked about in v7, i.e.:
>>
>>     Also, changing the calculation so that you get more precision whenever that is
>>     possible feels dangerous. I fear linearity breaks and that bigger input cause
>>     smaller output due to rounding if the bigger value has to be rounded down, but
>>     that this isn't done carefully enough. I.e. attempting to return an exact
>>     fraction and only falling back to the old code when that is not possible is
>>     still not safe since the old code isn't careful enough about rounding. I think
>>     it is really important that bigger input cause bigger (or equal) output.
>>     Otherwise you might trigger instability in feedback loops should a rescaler be
>>     involved in a some regulator function.
> 
> I think I didn't read this closely enought the first time around. I agree that
> bigger inputs should cause bigger outputs, especially with these rounding
> errors. My original indention was to have all scales withing a tight margin,
> that's why I ended up going with ppm for the test cases.
> 
>>
>> Sadly, I see no elegant solution to your problem.
>>
>> One way forward may be to somehow provide information on the expected
>> input range, and then determine the scaling method based on that
>> instead of the individual values. But, as indicated, there's no real
>> elegance in that. It can't be automated...
> 
> I guess the issue with that is that unless it's a user parameter, we're
> always going go have these little islands you mentioned in v7...
> 
> Would it be viable to guaranty a MICRO precision instead of NANO, and
> not have the range parameter?

I don't get what you mean here? Returning int-plus-micro can't be it,
since that would be completely pointless and only make it easier to
trigger accuracy problems of the conversion. However, I feel that any
attempt to shift digits but still having the same general approch will
just change the size and position of the islands, and thus not fix the
fundamental problematic border between land and water.

Cheers,
Peter

>>
>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>> ---
>>>  drivers/iio/afe/iio-rescale.c | 27 +++++++++++++++++++++++++--
>>>  1 file changed, 25 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>> index c408c4057c08..7304306c9806 100644
>>> --- a/drivers/iio/afe/iio-rescale.c
>>> +++ b/drivers/iio/afe/iio-rescale.c
>>> @@ -22,7 +22,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>>>  			  int *val, int *val2)
>>>  {
>>>  	s64 tmp;
>>> -	s32 rem;
>>> +	s32 rem, rem2;
>>>  	u32 mult;
>>>  	u32 neg;
>>>  
>>> @@ -38,8 +38,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>>>  		tmp = (s64)*val * 1000000000LL;
>>>  		tmp = div_s64(tmp, rescale->denominator);
>>>  		tmp *= rescale->numerator;
>>> -		tmp = div_s64(tmp, 1000000000LL);
>>> +
>>> +		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>>>  		*val = tmp;
>>> +
>>> +		/*
>>> +		 * For small values, the approximation can be costly,
>>> +		 * change scale type to maintain accuracy.
>>> +		 *
>>> +		 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
>>> +		 */
>>> +		if (scale_type == IIO_VAL_FRACTIONAL)
>>> +			tmp = *val2;
>>> +		else
>>> +			tmp = 1 << *val2;
>>> +
>>> +		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
>>> +			 *val = div_s64_rem(*val, tmp, &rem2);
>>> +
>>> +			 *val2 = div_s64(rem, tmp);
>>> +			 if (rem2)
>>> +				 *val2 += div_s64(rem2 * 1000000000LL, tmp);
>>
>> rem2 is 32-bit. Might 1000000000LL also be 32-bit on a small machine
>> where 64-bit arithmetic is really expensive? In that case, the above
>> is broken. The safe route is to do these things as in the existing
>> code with a cast to s64. But maybe that's just cargo cult crap?
> 
> You're right, this should be
> 
> 	div_s64((s64)rem2 * 1000000000LL, tmp);
> 
> I've been trying th get the kunit tests running on a 32-bit kernel image, but
> I'm still having issues with that...
> 
> Thanks,
> Liam
> 
>>
>> Cheers,
>> Peter
>>
>>> +
>>> +			 return IIO_VAL_INT_PLUS_NANO;
>>> +		 }
>>> +
>>>  		return scale_type;
>>>  	case IIO_VAL_INT_PLUS_NANO:
>>>  	case IIO_VAL_INT_PLUS_MICRO:
>>>
>>
