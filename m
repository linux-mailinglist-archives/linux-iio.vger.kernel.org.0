Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13343DB428
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhG3HCI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 03:02:08 -0400
Received: from mail-vi1eur05on2132.outbound.protection.outlook.com ([40.107.21.132]:17345
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237598AbhG3HCI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Jul 2021 03:02:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4o3ENdmHQGMJtpP1w7ypLciN2G2v6QrntL3zIpX3HsPlqt9UOIw06ajqN+EaO/MwANjyfthw4QxymUlCuIAanG+d1hWpFkKczhg1DfFFRwr/DTQD8l22OEJ7vK4yD72AaYNJZlpW3xtSf7uE4iIoXWcXbhB9f8Mse1wrV+ZvHgyl0aR2cfW2xdjaFOXTI+GbbyNSQKDianp3FXebWyIaXX2kAbBoV7drNwfY9OLZVd9nq55GX/Qcl9zzCdOqWy5gNTEEDu2HFJgffOGqs4I7pNYu5VK43yv3XE57P8lKSwiRiMwkjftwolx6SeVFCH2hrDEhBvXDdnh+7jzDUTyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opJEfooEsNOy/14bWJZ6IiMAgebqXK7B7at4IrMX/wE=;
 b=bG+9oyqcwEei20qPVTgYBB15jkPGxMMon9p0zI9kJSNVcDyjVjOaDLjFKJR5xxM8EEb86FV4LK24nrF6sQTNbU29FAB7axbL/MrcTXmHT5X/dGA0VFtL0TCvyJjxrp9wZh+/Eyw7+WoF+UH/EovC5276S7KG3uD/SKkz3QeLckhDq6mV34HBpwDQXGGRb8YzIPVB8+ZufDij9wfGouLMlesnyrsUj/dIbS5sgK4y/YzKg6ru8SNxSgxrNocDX2RYK2+ChZ8noyzf4vW54xTveYbF+RzMNX5BPK/jWW6bsK3b452L0cPqILovQfYhsX0IFLBYCtM2g6hwv4+3KpW1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opJEfooEsNOy/14bWJZ6IiMAgebqXK7B7at4IrMX/wE=;
 b=LX9l4tPPMN75IFNt08+2VrUFUCQcEwuyFHvYOfkbrKW3FpPG6vV/CTAX0/zO1oW6wTabN8esz/QReNjYtu/bvS++YO8fPSKznghhwtq6YxHIymT/m3auX3J/uVNeTqF00yzAqRUVD4E7a7BU6knkB9G5QN9/IqHlrRIM2JgMys8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3930.eurprd02.prod.outlook.com (2603:10a6:10:40::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 07:02:00 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 07:02:00 +0000
Subject: Re: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
From:   Peter Rosin <peda@axentia.se>
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-6-liambeguin@gmail.com>
 <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
 <CD4CE5OQT5TJ.2BFPBRYK7FCOW@shaak>
 <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
 <CD5QWB9MW1H5.3SSPWGD5DR6J5@shaak>
 <a77e7a18-67dc-5bc5-427b-89d6b1e82b85@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8448cecb-16b3-96ff-dfa8-3933325ef946@axentia.se>
Date:   Fri, 30 Jul 2021 09:01:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <a77e7a18-67dc-5bc5-427b-89d6b1e82b85@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0602CA0018.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM5PR0602CA0018.eurprd06.prod.outlook.com (2603:10a6:203:a3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Fri, 30 Jul 2021 07:01:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5cc2fd-e244-4bcc-fd39-08d95327ed8b
X-MS-TrafficTypeDiagnostic: DB7PR02MB3930:
X-Microsoft-Antispam-PRVS: <DB7PR02MB3930BB0A6A182EA29F98567BBCEC9@DB7PR02MB3930.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdGtxRBSXsIO8bLscj2jXMnhGsFlFA8iNJEZqjmtPGRM2+bnvyGp1UboXg53GACyR2XvVaOyg8/nXLBf6EwBER03jmNVYEL2Th8EauBNhZ4wLBNoMzAN7M20Xel3XAX3iDLraTnc+YOtKls4V/FymN/XaaAfsz6Mezx+tTv0ZeoMLoaOtXqaQ5H2xeTPLKDcmkHxEjIKvLaKdaoN8IByu9iaryB+NGZG6QIoic6OsbcUh+YbPRc1FYK/cti0KFCsmsuXaMifEk/8irXdzf0HSqnF4YlqBs1K9KndpVaDiperm1VGUfyJ6jK4j2g+jQ+hShLiXnd4OLr2vyMt+boBeHY4znw9D3XJVGaYZDRUfJIUPqUz/AkYu7NYT8M/TBDy7eJnTCkpvn65c3hcr4tsYS1f3qye3Jfzz+PpsHvbGPODSjGL+rIjO8Q60COm4yg9jd+A4upiURA2TTEPE+zx1Lqhr3cbHxsQ4xIYqM0SQNiIpB15I2zKzSn+p89EORKNzNNIH3cdDfkIizONCNfSC29AZxUH3kZqnrW2D1iHyKnMnKTiMbnyRcr6X+PV2BX7lIAawRf815lbZYdrhoKAQnx+tAPo8ChpCURN0vdwCCuHtLLknkOcNY46Dg8dzwlfjIeeYc8QA0ud8teHCIClnZC/vUeWo9fUxKF4iZorSPJaWWNkC4tSPQ6xhdejeq2VzE8H/RZofl1a11sJs+6AUS1/xzGwLc36E7T3lA80GH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(346002)(376002)(136003)(36916002)(31686004)(86362001)(36756003)(26005)(66556008)(8676002)(6486002)(66476007)(53546011)(31696002)(66946007)(2906002)(8936002)(186003)(956004)(316002)(2616005)(16576012)(5660300002)(478600001)(38100700002)(6666004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDAzZEFPOUhQN0hvZEFSY2xhdFhGOE1qOWNkZmtTUkJSZzVaU1RxUUNqWldx?=
 =?utf-8?B?LzNma1o0NXdmTkpFaVZ0c2p5cS9TdUw0MG9UY2tyUXdQNElrWUNpbGRabWhj?=
 =?utf-8?B?TFBnbzA5bmVDbWVaenoxSDQwNExMMmNiTVNSaENNTnVGNlZES0k3TU5USFEw?=
 =?utf-8?B?bWVIa29Vc0V1TnBxTXBhK0kyejJYaCtHWjBZUFJpbmM0MjRkcllPSllpK1Bi?=
 =?utf-8?B?ZjQ0c053dFBLOVdVNWNZaEFURUdQdFdmaElsZHIvQy9aY1dRWXQ4cCtDb2JD?=
 =?utf-8?B?WXRrRlNaSGpqNWMvMWYySWh2L2tGR09tcEc1a3ZOTVhjcDM0M0NHQWNYWVl0?=
 =?utf-8?B?ajBsTnVYMVJ2eHc4RExIWEpxbW5DVDVIbDJUa0RHbERudnV4c2kzZEN4dWcw?=
 =?utf-8?B?UCtiSHp5Z291bUZUcGxkL3NOWjJzeVVKZmcrYXVJMTMzU0lWZmdqbjhEVFdv?=
 =?utf-8?B?Q1NXcXpqZjhyN0M4QXdDNUxoWmJXRlA1ZGMwVkFjc3MvaTlGcEVqNERxTHZQ?=
 =?utf-8?B?anlYMzhpbDhCSzh5OXpNZFdRNkVoK2dZRnJpdkdDbE1LaVFUQVZGR3Fwc2JL?=
 =?utf-8?B?akx2dHR3dTc3MnVrd3lPVzZ2L1Q5VVlMeGtFVVZtOVZxb3ZNc2pMbjByVkxV?=
 =?utf-8?B?cmJGMzlTdUxYQzdjb2JabEgyQWFDRnJNZEtZVUhZQWhMZ2J5SzlQZ1JKaDl4?=
 =?utf-8?B?Vi85NzF4ZGMzQ2lvVmFqMmdIcVFrbytiSnRqRUtYYVlDMU9vc3lENi9XVm1X?=
 =?utf-8?B?YUF1VUVxVldGYVJqb1RrVlNXdyt0MUpUaUk2ZWFjbTA5QUJENFJlRWhPb3U2?=
 =?utf-8?B?b3pNSkV0OEV6Qzg5czN2T2V6VWJ0bnZyZlRXbU9hWVRwQi9GUFNPMEpnRzh5?=
 =?utf-8?B?RTNNWVJUekUwY3lPMjlEaWc0UUxFNTdMbk5vOTR2ems5eDBuVG0xNWhVcXl1?=
 =?utf-8?B?WGlEeXJVejhmdUovQXRRRDR2eHFUNFVkSFQ4OGRUOUpPMkY0Z1NML01Cd3lU?=
 =?utf-8?B?K2lSNmhMUTR6aEU3bjNqTmtuZkxJcVhLVTlHTUVpTmFCSnE0WmRFa1ArcjRG?=
 =?utf-8?B?TWd3cWhHOWtZMWVITzV0dm9LSEZjQUx6Y2RoVE5Uam84dHNEc1ljU05wMjJz?=
 =?utf-8?B?N0dkMWc0cGIyQ1YvTmVVcGJpVXB6NTMwamVtaDVNVWJXZTJZNGJKdXBkUmUv?=
 =?utf-8?B?ZW0wUVBZSW1KVmQxTVNlRDIwUHprb1N0a3RoSlUrOWg4MkhXZjdpV2RDL2dD?=
 =?utf-8?B?cVNOUmM4eDNwdmxOa0s4am9Nekh5WkFYRk1ucW9yKzVtK1VVVk16czFwYnBk?=
 =?utf-8?B?MGlKTTJZYm1BSjV2Z29hRkFHb0xPUmRCZWoyWWdqdGVENDg5V1pJYXY5OFJJ?=
 =?utf-8?B?bUExVWM4YU5kZU94WU54NjhLWHBkK0FvRk1tL3BVT1lsRzRuTW1xMlh0Sis2?=
 =?utf-8?B?TkhSbExVdmRyVm8rZlJiSWtYMEY3UFNwdURITnlOK3ZBOXVKSWhTeFJ3TUpW?=
 =?utf-8?B?WDZaVktUbE9tbm1BV2Y3SXNLRHdHYzRZdEI1aUZLdStSeTM2RzkvWkEwVlY2?=
 =?utf-8?B?bnJPL2F4TFdDT2N4OG5SanVtMUd4RXJROWt0UExvb0tsT0tLeE10TFlrMnlO?=
 =?utf-8?B?aVdPSlpqSFJzVlBkMFV4TzVJUnJ0aXpwV1E0UkJOVVErMFBCa25MZ2VsWFVW?=
 =?utf-8?B?d01LMXo1eXdSUTUyMEhRTWVMays4bGRHcWFJOTVLd1hqKzNuODRvL2hUdTdK?=
 =?utf-8?Q?mhR+RLrZ8/zjWyoMRgrbjoJ4/bA0kRwMlm1nBYO?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5cc2fd-e244-4bcc-fd39-08d95327ed8b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 07:02:00.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja/q2l7TUp4+GtMOQ3gn7BAfcQi6BcK5uTG32NqT7hbQLyKQNNPrLrEj7pBFM8iA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3930
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-30 08:49, Peter Rosin wrote:
> On 2021-07-29 17:56, Liam Beguin wrote:
>> On Wed Jul 28, 2021 at 3:19 AM EDT, Peter Rosin wrote:
>>> On 2021-07-28 02:21, Liam Beguin wrote:
>>>> On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:
>>>>> On 2021-07-21 05:06, Liam Beguin wrote:
>>>>>> From: Liam Beguin <lvb@xiphos.com>
>>>>>>
>>>>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
>>>>>> Add support for these to allow using the iio-rescaler with them.
>>>>>>
>>>>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>>>>> ---
>>>>>>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
>>>>>>  1 file changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>>>>> index d0669fd8eac5..2b73047365cc 100644
>>>>>> --- a/drivers/iio/afe/iio-rescale.c
>>>>>> +++ b/drivers/iio/afe/iio-rescale.c
>>>>>> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>>>>>>  		do_div(tmp, 1000000000LL);
>>>>>>  		*val = tmp;
>>>>>>  		return scale_type;
>>>>>> +	case IIO_VAL_INT_PLUS_NANO:
>>>>>> +		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
>>>>>> +		tmp = div_s64(tmp, rescale->denominator);
>>>>>> +
>>>>>> +		*val = div_s64(tmp, 1000000000LL);
>>>>>> +		*val2 = tmp - *val * 1000000000LL;
>>>>>> +		return scale_type;
>>>>
>>>> Hi Peter,
>>>>
>>>>>
>>>>> Hi!
>>>>>
>>>>> My objection from v5 still stands. Did you forget or did you simply send
>>>>> the
>>>>> wrong patch?
>>>>
>>>> Apologies, again I didn't mean to make it seem like I ignored your comments.
>>>> I tried your suggestion, but had issues when *val2 would overflow into
>>>> the integer part.
>>
>> Hi Peter,
>>
>>>
>>> Not saying anything about it not working does indeed make it seem like
>>> you
>>> ignored it :-) Or did I just miss where you said this? Anyway, no
>>> problem,
>>> it can be a mess dealing with a string of commits when there are
>>> numerous
>>> things to take care of between each iteration. And it's very easy to
>>> burn
>>> out and just back away. Please don't do that!
>>
>> It was my mistake. Thanks for the encouragement :-)
>>
>>>
>>>> Even though what I has was more prone to integer overflow with the first
>>>> multiplication, I thought it was still a valid solution as it passed the
>>>> tests.
>>>
>>> I did state that you'd need to add overflow handling from the fraction
>>> calculation and handling for negative values, so it was no surprise that
>>> my original sketchy suggestion didn't work as-is.
>>>
>>>>
>>>>>
>>>>> Untested suggestion, this time handling negative values and
>>>>> canonicalizing any
>>>>> overflow from the fraction calculation.
>>>>>
>>>>> neg = *val < 0 || *val2 < 0;
>>>>> tmp = (s64)abs(*val) * rescale->numerator;
>>>>> rem = do_div(tmp, rescale->denominator);
>>>>> *val = tmp;
>>>>> tmp = rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
>>>>> do_div(tmp, rescale->denominator);
>>>>> *val2 = do_div(tmp, 1000000000LL);
>>>>> *val += tmp;
>>>>> if (neg) {
>>>>> if (*val < 0)
>>>>> *val = -*val;
>>>>> else
>>>>> *val2 = -*val;
>>>
>>> This last line should of course be *val2 = -*val2;
>>> Sorry.
>>>
>>>>
>>>> I'll look into this suggestion.
>>>
>>> Thanks!
>>>
>>
>> Starting from what you suggested, here's what I came up with.
>> I also added a few test cases to cover corner cases.
>>
>> 	if (scale_type == IIO_VAL_INT_PLUS_NANO)
>> 		mult = 1000000000LL;
>> 	else
>> 		mult = 1000000LL;
>> 	/*
>> 	 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
>> 	 * *val2 is negative the schan scale is negative
>> 	 */
>> 	neg = *val < 0 || *val2 < 0;
>>
>> 	tmp = (s64)abs(*val) * (s32)abs(rescale->numerator);
> 
> Small nit, but I think abs() returns a signed type compatible
> with the argument type. I.e. (s32)abs(rescale->...) where both
> numerator and denominator are already s32 could just as well
> be written without the cast as plain old abs(rescale->...)
> 
> 
>> 	*val = div_s64_rem(tmp, (s32)abs(rescale->denominator), &rem);
>>
>> 	tmp = (s64)rem * mult +
>> 		(s64)abs(*val2) * (s32)abs(rescale->numerator);
>> 	tmp = div_s64(tmp, (s32)abs(rescale->denominator));
>>
>> 	*val += div_s64_rem(tmp, mult, val2);
>>
>> 	/*
>> 	 * If the schan scale or only one of the rescaler elements is
>> 	 * negative, the combined scale is negative.
>> 	 */
>> 	if (neg || ((rescale->numerator < 0) ^ (rescale->denominator < 0)))

Hang on, that's not right. If the value and only one of the rescaler
elements is negative, the result is positive. || is not the correct
logical operation.

>> 		*val = -*val;
> 
> Unconditionally negating *val doesn't negate the combined value when
> *val is zero and *val2 isn't. My test "if (*val < 0)" above attempting
> to take care of this case is clearly not right. It should of course be
> "if (*val > 0)" since *val is not yet negated. Duh!
> 
> In fact, I think a few tests scaling to/from the [-1,1] interval
> would be benefitial for this exact reason.

So, with both these issues taken care of:

 	if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
		if (*val > 0)
			*val = -*val;
		else
			*val2 = -*val2;
	}

(bitwise ^ is safe since all operands come from logical operations, i.e.
they are either zero or one and nothing else)

Cheers,
Peter

