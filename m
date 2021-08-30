Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457FA3FB852
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbhH3Oby (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:31:54 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com ([40.107.8.121]:8824
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237180AbhH3Obx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFIRbnn2ywxqKZuK2D4BTlKxuqAKWqjjV2dZX7cWgWVOlXwKvSqiEdywSr89n+ILqt/AbvJXPJBSAeB19bq+pptZYanbhFfzyecWLJueC2XJLCNeXyXLG6sw0wVR3dDZgfscwK6r7kGxQnI19LsXJUGCA7ENVWVZeWWxioZT3enEnjrA4F0DJsbWbCV5eSSKVEpzObojK2y1h+1AULSFjZ7brgMr1dRwvgPf/IhuiFu5vP3K7Fd1Jm+3f7gD1sT01Uj9u2EXOLdVo4m58zVrv+lTrlkvA7XCpkdq+4dM8uS/7eUfjgYAm7eO9/P8H2luzA8+FwtCQW9Arl/M7N+6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vJyOT1o7e+71QaQoKmkYwipzw96fRznQbhEL9s+JY0=;
 b=oQqPL9Tl3CttM4FJ8lDdXh2xo2YLco/3AdmyC7CtXs8NIGnGf85YgXMAboZTOOY+uxT97cxWD5smOBD8/PDIClp0QLRIBorSnvCaoYWmPS/cJViCP5T59kx5zYTv7dTWPbh+pJks88YTxZnczg6AZlykke+B3DWpzNZkgObtXHd9vJjCQxNb8bRN9Oqe3ePEEtLY2BdQ13F8tNWkywuho8N60QO/8D5OH6j9YNu5dmb71hu//DgzXRLi5xUAx7oyaRo20xIw7Z4vwBd7nDtnLzcOt3gNZVsxm6vdCM3jy/Q/1IyfMvfsaqozSfjHtvxon6bASlBlKjtApET3jwRb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vJyOT1o7e+71QaQoKmkYwipzw96fRznQbhEL9s+JY0=;
 b=M33NI5yQtODFCljz6oAV2lGt1Z4HYM6a4ghDYbncoBGMWDYvYgkw5r6J5HmmDUNIh7TrmqkBavSXoz/PabdYSw8VB1Ymrj4Rwc5Pi3jetSdcfS9fqVu3W8wMtP0aPzlA1mFhO85S8qR/b05SaCMdaTzM8iOk9sen97ltGX2z+Pw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6508.eurprd02.prod.outlook.com (2603:10a6:10:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Mon, 30 Aug
 2021 14:30:56 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 14:30:56 +0000
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-10-liambeguin@gmail.com>
 <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
 <20210830122224.3efc5a63@jic23-huawei>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e1542f14-f271-a0a3-eaa1-092e12c3ed6c@axentia.se>
Date:   Mon, 30 Aug 2021 16:30:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210830122224.3efc5a63@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0901CA0057.eurprd09.prod.outlook.com
 (2603:10a6:3:45::25) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0901CA0057.eurprd09.prod.outlook.com (2603:10a6:3:45::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 14:30:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82f4be5a-53d5-47f6-cc6c-08d96bc2c775
X-MS-TrafficTypeDiagnostic: DB9PR02MB6508:
X-Microsoft-Antispam-PRVS: <DB9PR02MB65081648B79B209F010248AFBCCB9@DB9PR02MB6508.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJzKRcGofsi+DucdS9+0j6uRHJ+OGjVxZiRICfnW513FC4HhNYmzMXwzsm37Ki8Zm5oPRkwTEiQo19V0ayniN7Mi1e2U5XXx0aCvJA84RlqOZweftQ+D1nszq2zaG8muNFW/WGB1Cvqf9VS1W9KICEEnYIW2etfVzc/jXqVxCxPnd30P8R2U6pQZ4Sc9CdW9w74sOd3p1EfJWZk8QgQ6578BU1o+9Oo4325g18sD0JPRZzjwAK2Ulkli8xwfsOhKhCMMBZ0TFMEmBW87MEZT3KYfFHMXtxoYG8yDNrV5WCr6wKaxN7V3JfvdJkHlDah+imVshdgusVfaIHPreT7vCd2MKl3hhDedMxYB+NeRcqHAa+IJho1n1KegMGYluEHgdw9MfjpU9ls+Fc6YTjswjOznAKbh5JahEaUgoAUDJlgZXdgk+KnEKYn/QX08QAq8RK1+HFgmftG7Ar0ea6ffNrs7RgD2ffwWhfIvf5UG4XkEJlhY9wdVhXEQPh1MxqSHUMhLcuPgXWMY6n+2oMtfh3vjAQ4kMzS+3dsMijaQdivS9PDCf2yYQ4v4uhTxZuwKFNE8+/X7o52JAI/xaDXKt2K/MpQbrhnr710p9zjkRMPgH4Z9/Kli2fxUZyUVMU0CMMar6K59pGlF5C/8LEEpDFnK1qjDdM0MB/qEjIhMBBh2XK5QnzzQud+6nMI/XguMC7+Io9hLXc4ZnI5uA/BB7mmxbSYOHLFwf5PT1eKzf8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(31696002)(38100700002)(66476007)(66556008)(16576012)(316002)(86362001)(956004)(66946007)(6486002)(2616005)(8676002)(6916009)(5660300002)(26005)(8936002)(186003)(478600001)(2906002)(83380400001)(36756003)(53546011)(36916002)(4326008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEQzRVhEQXF5K1dDcnBvcVhJSVdXK2ZDZVNJSEpkZjlZc0RJSk4vOFcxSnVL?=
 =?utf-8?B?Z3NrS1ZYcE42TWhncUxvQUJ0dnVhcU1wVjJXTHRGREFqYW5LL1BVYzVSNkdD?=
 =?utf-8?B?dU8zdzVYU2FtSXZyU2NOdVcxaHY0MytXV0RvTEFzemV0Y3ZDQXp6QnRkN09i?=
 =?utf-8?B?dFo5QzRZbVk5K1lJMTQrMzdUS1dBUVppak9QZy9jbndieXJ5dkplM3Z4Mjlm?=
 =?utf-8?B?NTBGdzRZTktsL3I5Q1huV25Wd1JHdGd0RVprcUxlSmlWUWZDcEo5SjN5U2Zq?=
 =?utf-8?B?cjh1SXdzU2tKOVlMK1NsU2FlVHlmM1FPam53V2lQUmJKVERveXZ6Mklvdisz?=
 =?utf-8?B?YXF2b3drNVRUSzRBQ0c3MnB1OXBFTEpnK3oyTDByS3BYSTMwSFdldHdlbW1i?=
 =?utf-8?B?d1ltMXhYb0E2VjlHTDY2SGx5amxNR2gwVWpFVE9NOUFvb2t6ZnloeGRWem83?=
 =?utf-8?B?dmd6azh6YmRFdlFGWDl3ZzR3c2tOYkFkOTBPUjNEb2NGOGtUR3VDd2sxUVJ3?=
 =?utf-8?B?RWNiYmMvV0p6eldmWDJZUnNPTkFQZjVnbUdmdCtaQXEyUDNyQlFFV2hnYmpH?=
 =?utf-8?B?M21iNlprY1JpaC9mMjlDQ2RSelNxOFdOT01pVEl6M2JUWnh5d20vMTlZZm1Y?=
 =?utf-8?B?akg4Mm9JM2RtU09FYnBlaVJCaFVXZGNOR3gyTldNREF1Q1ZPeStsWVpIbCt1?=
 =?utf-8?B?dVFjS3RoMVhVck8vazdseU1QNHUra2VtOVpHOEI5UTk2cGRYSkVWOEtTL1Zs?=
 =?utf-8?B?emx4ZzhSTmtmMHRqbmlsVEF1OGNaa3pjN3FDREdHV3hMcDNUSmttQXVEUmhW?=
 =?utf-8?B?ZWVQeTdPcFpYY3B6R01CVVRkNjZpNHNZeHp6MlhFemY3bklpczRoY3R4c0lX?=
 =?utf-8?B?T3dJaFZhRkkxNC9yV2tzTFRuZ1UvRFpYUmZGaG0zVFhiWU84NjErb2pZNnpx?=
 =?utf-8?B?NU9lbDNFbVYxU3pqVjhxaWZFZEF0Q0s2cGNrN3B6K0dDMTF0YldoNVczaXpi?=
 =?utf-8?B?NlMwT0ZtdDI4d3FrVWRKTVN4OUtSRFJWYXB1N0dGNUYxNWIrYmRLckJKMmhi?=
 =?utf-8?B?dkJSSXlNdEhZYUlxV090KzhLaFl6TEJySThhN3hkL0krbWxVMnRyS1lpUm5p?=
 =?utf-8?B?V04xY3hlZVFtTzA2dmxYN2RFNXMvNjJ0bnN2dVkxYUYvWUZnNC9yNGFQbm5V?=
 =?utf-8?B?YlpuSlhKNUgxdWI4RUdoVTRtdkl1TDdJZStHTDhjc1p2aXBPVWh0WjlhWnRa?=
 =?utf-8?B?bmpWVExUbTZlOUZETHVGQ3V1bG1vaUM4TCtjK0RWWmd1WXo3a2c5VjV6NEVk?=
 =?utf-8?B?Y0ltTHR6eVJBVHRnRytIdVFlU05obWxLVlZXNlVUVVdzYURPekNGRXFOcFVx?=
 =?utf-8?B?d2dKMGJZeFdFODdoaDlKdGVXOG95L2tIZEg4RHhuRW1NMGhFQkFTYmFScXVO?=
 =?utf-8?B?dXlsTlYwSG0zU2dXVTc4L1BLeXNwV2lKMEJneEpRMzc3NStETmVveTRSd0Ns?=
 =?utf-8?B?Qm1Ya29uWWNrUEI1cmRRSCs3N0dYc0k3UmlhZVYzUjNnSTJXUE4xQTJCdVY2?=
 =?utf-8?B?anNWUzdxSWV6eXBFZkpGaG8xYVJBbnlBUE1GdUVEaTdOazNqb0h2NlRLSlhG?=
 =?utf-8?B?bTFiVXI2NzBtbmNlS2oxVWtTNGl6OFV4eFF4a002d3lWZVNub0VVdHh4dFhT?=
 =?utf-8?B?M0s3K1hzREZ6bnQwbmRFZldRTGJ0SitTRE9sRWtZeGViUG1BeEpWb2JlQ3hm?=
 =?utf-8?Q?zbrE/mixS+EbwaghXuZpj+GGspHNIGOVCvBqdDx?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f4be5a-53d5-47f6-cc6c-08d96bc2c775
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 14:30:56.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fliwnuynKdJa11urdxdUXn6WKivyiWByRSdaYxNV2u3vr6snGOJjaueKbnns9ZRB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6508
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-08-30 13:22, Jonathan Cameron wrote:
> On Mon, 23 Aug 2021 00:18:55 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
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
>> The conversion to int-plus-nano may also carry a cost of accuracy.
>>
>> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
>> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
>> digits). So, in this case you lose precision with the new code.
>>
>> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
>> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
>>
>> I'm also wondering if it is wise to not always return the same scale type?
>> What happens if we want to extend this driver to scale a buffered channel?
>> Honest question! I don't know, but I fear that this patch may make that
>> step more difficult to take??
>>
>> Jonathan, do you have any input on that?
> 
> I'm a bit lost.  As things currently stand IIO buffered data flows all use
> _RAW.  It's either up to userspace or the inkernel user to query scale
> and use that to compute the appropriate _processed values.  There have been
> various discussions over the years on how to add metadata but it's tricky
> without adding significant complexity and for vast majority of usecases not
> necessary.  Given the rescaler copes with _raw and _processed inputs, we
> would only support buffered flows if using the _raw ones.
> 
> If nothing changes in configuration of the rescaler, the scale should be
> static for a given device.  What format that 'scale' takes is something
> that userspace code or inkernel users should cope fine with given they
> need to do that anyway for different devices.

Ok, if 'scale' (and 'offset') of the source channel is to be considered
static, then it is much safer to ignore the "island problem" and rescale
each value independently on a case-by-case basis. We should add an
explicit comment somewhere that we make this assumption.

Sorry for wasting time and effort by not realizing by myself (and earlier).

Maybe something like this?

/*
 * The rescaler assumes that the 'scale' and 'offset' properties of
 * the source channel are static. If they are not, there exist some
 * corner cases where rounding/truncating might cause confusing
 * mathematical properties (non-linearity).
 */

I then propose that we rescale IIO_VAL_FRACTIONAL as before if that works,
thus preserving any previous exact rescaling, but if there is an overflow
while doing that, then we fall back to new code that rescales to a
IIO_VAL_INT_PLUS_NANO value. Trying the gcd-thing as it ended up in v7 still
seems expensive to me, but maybe I overestimate the cost of gcd? Anyway, my
guts vote for completely skipping gcd and that we aim directly for
IIO_VAL_INT_PLUS_NANO in case of overflow while doing the old thing.

Having said that, if 'scale' and 'offset' indeed are static, then the gcd
cost can be mitigated by caching the result. Exact rescaling is always
nice...

If IIO_VAL_INT overflows while rescaling, we are SOL whichever way we turn,
so ignore doing anything about that.

Liam, was it IIO_VAL_FRACTIONAL or IIO_VAL_FRACTIONAL_LOG2 that was your
real use case? Anyway, your 100 ppm threshold is probably as good a
compromise as any for this case. However, that threshold does nothing for
the case where the conversion to IIO_VAL_INT_PLUS_NANO throws away way
more precision than the existing operations. It would probably be good
to somehow stay with the old method for the really tiny values, if there
is a viable test/threshold for when to do what.

Cheers,
Peter
