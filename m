Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897B13D892C
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhG1H6S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 03:58:18 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:38102
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233224AbhG1H6R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Jul 2021 03:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJx2cWfgtAhLoaZpV7xuTYUjyfi2Yn63fkozr1XTVTeRuMFB90rLdwUgGqF4mYs7I757OEFfeNoeYmtxLlp+bVZPrhIQG2N5Hiuk5Gs3W0QszI+wFdkHusiz/SODaKOcGv52sFaL7AYmYl2Zio3SUH3EU7bCWZngCLuHY0kFxaFFU1jtYhGBGkY4YhS8a51IHydRTccouK3dAkCULddzbsh4FLOvwSRhoGc1+5hLezyB2eF2GeGr2KDJve7lioeTcuHYnqoGmNSu0+F0LdzDibRGYSGygbIIUom6id9im9+HtlxLkXmIQuo1JLyK/IVijJYxVw69oPXrc/3RUQn+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5czFYLYff7stftJiMyJeDbus7+nfTqxHqYtVv1xPNk=;
 b=ckH27oXyiR9eer7wJMhG6eEYyKp/ucv+ZFfHYNmJhvCMsl6aUVlMtwz4XgTRnz0TfIqKpN/JZvj/tLqKuZEiqt1eaO09bMT1vjUdKIiCjdNtOpTkhi+ZDbge1Rqy/8mrMVbroh60dKNnSY8WMYMdVINuR5f/x3NQfSmSQX6oS91R/OXk83DADBjBiZE8Tcgeuwt1kEl+PUBDFYGzFwn+Le/zgTX0SGiRbSIpHzYmN74la5pY+I9V9+DH/R/8wj6WkcoExPHg13Wl8SBjIT3CX64GdAfQakwpaV6Um64LEuPuh0aqIj3BhlkWY4AimiVWz+eWvJ0Q4DJ5Q9PeNWqhPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5czFYLYff7stftJiMyJeDbus7+nfTqxHqYtVv1xPNk=;
 b=iNhIZO+oqnfMGENw1Qa1cR+TczIV9+19YrcpDWGypMV2vNRrYjczlHjei0OgV439SY9hhlF2IQTu3Nvl7NfXD/okgUREWICzorApB+0dnwj+7afkcCAxMH1Og557zhsuR+taKz1dmlBn4gzjLaJ3ZL4jfzC+Quv4NLlO7aNAoCo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2392.eurprd02.prod.outlook.com (2603:10a6:4:37::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.31; Wed, 28 Jul
 2021 07:58:13 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 07:58:13 +0000
Subject: Re: [PATCH v6 09/13] iio: afe: rescale: fix precision on fractional
 log scale
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-10-liambeguin@gmail.com>
 <d2dea8ea-5a31-0428-4eac-4e4315d07a42@axentia.se>
 <CD4CHX6R9QRI.2Q76MYJGTXNWK@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4e477a42-1cae-06f8-2778-fc734359d6f3@axentia.se>
Date:   Wed, 28 Jul 2021 09:58:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CD4CHX6R9QRI.2Q76MYJGTXNWK@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0095.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::36) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6P192CA0095.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 07:58:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa549de-6cfc-4b1b-cb26-08d9519d72d7
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2392:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2392DA9506E0937AFE62D288BCEA9@DB6PR0201MB2392.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CMSPvzw783VTEkS5sKw/bTuBQGltm4mOvM7rPsQ3ni/axxDdrbbGIZ+ILA9W0kvlQLVlL9/i/R75i7RWyJr919LnMN9ObiDRb6jwdgDBHKGoZNmO1DmVqUoEoU6v/ZI8CYaIOlJ+NivkilO1wTqztSTB/L4TgNOVQf7FsEDGDP4i+4//LY+jn7SztQlNl/HSRSBgUsTYb4HF9Yr9K7CSfwuI3rqRsG7ExG2xIXBA/SIow9eAYeA//cpcwKfDWG4bro0r6B0KqQ4Jfy5KAXZ33NpnB/AFTsdvlEioOU+P2j9hX9j7er3Hvzkt5UBM/f1AFprtElXqm5j5MDst/p7jmjq478uOsQUvjHlyqO5y1XzOmsZEc4aZN1x9LnXJneVJ4QU48tkS9Ee2ad3zIPne3YZsS6GVWtaT8MkpiCL4cS0se3wUoSZp3mqO+/BG6OI3+/AIHCs+sRIo6JNP2YjHPsrUJMHIQ3lzgzNovEcu/vQ1HUhx023NK+T72wS3oqeRBSyqX7wqNhCDycdMNWy+C+KARQXkkzixJfmd2rYsIDe0e2g5+QuujlQb0gsz7qSnx7mD4PZCpkOruDt8ppuFFjoBhB7ddtZPNhc9ciK43wjGOA63nij34VXPfCCzGPwZH7fqGgVnKVx0tj9EO1H1mxzVgUGSkBAhXI5xD/87c69ibyBpXhGUIsuFTHDpNsoY4PQGBSJj+5DAM+W1jXNUZZusHjOSvkOnPN1EiCyhhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(396003)(39830400003)(83380400001)(36916002)(8936002)(8676002)(4326008)(66556008)(6486002)(2906002)(66946007)(316002)(38100700002)(66476007)(5660300002)(956004)(36756003)(2616005)(16576012)(478600001)(186003)(26005)(53546011)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVOOGxhOFBXaVo3cjc0Z0RYd0ZJWE9kbjNoWGdXMzhTOFhTWkhvNzRMTGxv?=
 =?utf-8?B?ajcwNnRnbytQcDhxZUJzUkFTUnlzYVpmTGVLYjlqQTR1ZjFvbENaRmcycjl3?=
 =?utf-8?B?bm1jSVgwa1laZWxZZWNsOXgyR1YxbDVvd3NXOFhkcjVIVStMakR0Q0tnNTIr?=
 =?utf-8?B?TEpEZlVCNzhtMGdvM0FCcEgrS3p0MUt2QStmdWZ6VVRGQkU3QnNKdzV5RVVt?=
 =?utf-8?B?Zkx2QjZ1dGlxMUs0QWVDdUhLV1ZCS3lXelFubTdqMnRPRkRjSjBZTW1NMEpG?=
 =?utf-8?B?K2hMcVp0eW1SNlZpU2U5QldiU25iRlE1Z3RRSUNjUVV3MnlmNEtBUHVQZmhQ?=
 =?utf-8?B?anZRa3BHNmZhcSt2QlFZZ3d0MGxDdHMzWGZkUzJlcXdja2NOcDN2U1I5M3hm?=
 =?utf-8?B?eHJPQThuSXczclNYNWJ0THdxVnlLMGtnVDNocm1OUVJra3Z5MXVScUZ1YSt1?=
 =?utf-8?B?a0JMK2lkc0FlRkNaalF6b1B1a2ZEYVpKYXBScWRMTERyRmFETG1rUElvV1hJ?=
 =?utf-8?B?RnkxalVzMk1uTlY1eTMwOHRVSmZFdzhGZFFGMi9wZWRPMjJkVTJTNlNmeFpw?=
 =?utf-8?B?T1JnQ2NGNlU5WnRESnIyWTN5R0dCdGVUdHhVRzFOLzBiQjlnL2hub0c1TFhJ?=
 =?utf-8?B?c0Jaa3FEdU8zMDBaUGRxRWlBYm9uR0tJeWswN0c3RkZoeVZlRlZDekFiQ0xO?=
 =?utf-8?B?ekZ3MHNFUDVpYklIN3lYVytMVlYxazBTMmpZUmo4c1Q4bnpSQTR6Q2k0SmhN?=
 =?utf-8?B?SE9rSXJ6QmZSTTl4dUhhcURVZzRhVnFTZE53b2JIdVZubXdTRzU2aW1KZVBC?=
 =?utf-8?B?UTFpZ1V3Q0NUM29OUTYzNWJFRW9IQ3duTVZPUWFPTURaOEw4ZkZ0QVNPVnJp?=
 =?utf-8?B?bVc2TUZtY29xWC9KUGVobC8xRGlqbW9IbkU2NnpVQlVDeEtsMnQ3M0V6dDJx?=
 =?utf-8?B?SGRqUWxtT3h2bVZFK1lLcGZPYVVmRGVTb292WXBkKzJzcFFNcVlDQ1hlenFJ?=
 =?utf-8?B?dzlwaVlmVDNNeWMwVGpZd2ZzdlNSazJNSS9rRzF5bEhyTkRnV2ZHSUNIYTFY?=
 =?utf-8?B?WVlWejVOQVJrZVR4TGV6ekFSc0ZLTmZCb3AyemxLd2ZjSmFjSnNCdzlZSzNj?=
 =?utf-8?B?Tjd6K0F0UnBwM1FxZ1Z3cGhmbHkrYUVmTlFYTERYb1VuaTVGbVBtVjcwaWJh?=
 =?utf-8?B?UnVXZm0yM3FoOVRtOVNNYzFqR0dsQk1kc2FtRGxOT1ZFL0RPWmZIdFBKSDZ3?=
 =?utf-8?B?S3k2MWN3b0RLWFF0ak40VFpoQTRNYmp1OW93TG5IbzVQbTByRzdHWVJZVUxp?=
 =?utf-8?B?OWR2bTZiNjlmWGxNMnpPSkt3RE1RZXgxZVBjTTZRNkhHSS94ZUl5aTFPZm5P?=
 =?utf-8?B?NVRreHo5bWh2VU5NeVNaSExyUGFPdCtNTHN5Z2JDeWlkYm4yVnB2TFlYVENa?=
 =?utf-8?B?enZkZmlLZDFxdFFISHRTNHJubFBTUGpENXlLVnQvWXZCaG92elRFSXZwdTR6?=
 =?utf-8?B?ZnBhdFJiZy9saHpabEhGVnpDTWZET0J6SzVKM2VYcG03UGtXa2F0b2l4ZUhN?=
 =?utf-8?B?eVBxVk1MSFczV2kxaGxQczY3YWViS1EwVWg3VzI3bmJJbU5scStHdGFlTU1H?=
 =?utf-8?B?anJVRStoNVY3Uno1YjVwRFRKZThvWG1ETFRHbVY1eEZxZ3NScEFkYlR1UmJh?=
 =?utf-8?B?L2FwdWpTYVREaXZVRjNQSmUwY3JGMWE0L3RwRjUwYkZzQS9CbE50ZEkzZ3BD?=
 =?utf-8?Q?QAKLWdYhNEGwB14pgq3eRLAix7fhZJb/b7xRGvt?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa549de-6cfc-4b1b-cb26-08d9519d72d7
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 07:58:12.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9ZsifoP3yWof0/oz5JL2NBzT9Sj3ArSy1kqdnSeaAI1gnsaPniIqTF7VpZCKyG3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2392
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-28 02:26, Liam Beguin wrote:
> On Fri Jul 23, 2021 at 5:20 PM EDT, Peter Rosin wrote:
>> On 2021-07-21 05:06, Liam Beguin wrote:
>>> From: Liam Beguin <lvb@xiphos.com>
>>>
>>> The IIO_VAL_FRACTIONAL_LOG2 scale type doesn't return the expected
>>> scale. Update the case so that the rescaler returns a fractional type
>>> and a more precise scale.
>>>
>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>> ---
>>>  drivers/iio/afe/iio-rescale.c | 9 +++------
>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>> index 35fa3b4e53e0..47cd4a6d9aca 100644
>>> --- a/drivers/iio/afe/iio-rescale.c
>>> +++ b/drivers/iio/afe/iio-rescale.c
>>> @@ -44,12 +44,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>>>  		*val2 = rescale->denominator;
>>>  		return IIO_VAL_FRACTIONAL;
>>>  	case IIO_VAL_FRACTIONAL_LOG2:
>>> -		tmp = *val * 1000000000LL;
>>> -		do_div(tmp, rescale->denominator);
>>> -		tmp *= rescale->numerator;
>>> -		do_div(tmp, 1000000000LL);
>>> -		*val = tmp;
>>> -		return scale_type;
>>> +		*val = rescale->numerator * *val;
>>> +		*val2 = rescale->denominator * (1 << *val2);
>>> +		return IIO_VAL_FRACTIONAL;
>>
>> Hi!
> 
> Hi Peter,
> 
>>
>> I do not think this is an uncontested improvement. You have broken the
>> case
>> where *val2 is "large" before the scale factor is applied.
> 
> I was a little reluctant to add this change as I keep increasing the
> scope of this series, but since I added tests for all cases, I didn't
> want to leave this one out.

> Would you rather I drop this patch and the test cases associated to it?

Why drop the tests? Are they doing any harm? Or are they testing exactly
the problem situation that fail without this patch?

In that case, I guess fix the tests to pass and preferably add tests
for the *val2 is "large" situation (that this patch breaks) so that the
next person trying to improve precision is made aware of the overflow
problem. Does that make sense?

Cheers,
Peter

> Thanks,
> Liam
> 
>>
>> Cheers,
>> Peter
>>
>>>  	case IIO_VAL_INT_PLUS_NANO:
>>>  		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
>>>  		tmp = div_s64(tmp, rescale->denominator);
>>>
> 

