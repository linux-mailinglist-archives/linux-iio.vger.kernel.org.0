Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCA1426D79
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 17:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhJHP3g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 11:29:36 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com ([40.107.5.123]:56422
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242956AbhJHP3g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 11:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGaQ61SH4BsPCYS2LSgxztjO/KykJEMxlRVywnLCh/oc1CU93fX31TAjlGIzqv5lFLhlICcsI/T83tnV8PxBt79F8cy0me424NFJdNUuNRWRXlNLuDRxtFnuTpMjBNIrVSYO/9q6WuMP01cy4DKkGaxOB6tP+RebJ1m0WRjvQcLbnLjCkUZ//dL0vXlnfSjj7ziOyNm1Gz/lNDXtG7m9YdBYx9clGGSPb2E9bVBDlj0XOeEPgP9FIv5AnMG4zQZwTnVZo7+HzJw5xWdR+ARcNjqmC/DCpt4yBoPoC95JZLvD5TC+t14XgzXN7TmhsfNUdsd8kl1ff9U55+PBJXIboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH22kTuSl6pCmkVwCuNC16O3qfcfUzqfYA//NRIigXA=;
 b=P5WMMhd6cgGHsFiCuKUkahdeYh6rwn4O+jnmKo8jS2uh6LFjx0wBhyz+weQYLj564GUuGYn9TlzJO4FIWDdoDKGPcFJFCHA6f6Q6U1OYZCtoyji/oX6BgyHVto6cn/bGXX1DB7DI+KMINw3bqXioUheuz2MRUUWkMpBfOY7RPYuoaefawV7pyrE5PLOWtLNBJqU1oiXjyFgoYZ228Od+w3QIqAuARAa+AM6JjM59qz4sjC1usmOksGbxXJdllFTRCN6nbEJfW5LcbTQcvMuVlHNbmL9ybM0JEKh7v3HBrxAbdtBEvzuKs7/6LTFH2s68INv3syBnPk7dKFgqJKy6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH22kTuSl6pCmkVwCuNC16O3qfcfUzqfYA//NRIigXA=;
 b=aGYC1jKqiq7jt1JVzDk2Bw6k0tq2mp8Y57gwy1QYQg6BOhLP0HzxgM5PmJQ7wJCLYImhoh6g0z2lgBcD7+KJ4S9Sdmqvi0HMy0PHN7+RJ6GTEMoKrwnnzLjPpMMT0g327x1QFBpB/ejWgJ9rPqzYcYcSx+UkSQCrdeW6s9Gq5ok=
Authentication-Results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3064.eurprd02.prod.outlook.com (2603:10a6:6:17::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 15:27:37 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 15:27:37 +0000
Message-ID: <d794e44d-e67a-e51e-93b0-9b23edba2e21@axentia.se>
Date:   Fri, 8 Oct 2021 17:27:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: io-channel-mux: Add property for
 settle time
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Rob Herring <robh@kernel.org>
Cc:     kernel <kernel@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com>
 <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
 <20211008135610.GA16402@axis.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211008135610.GA16402@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Fri, 8 Oct 2021 15:27:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea69a555-2635-420e-b797-08d98a7028c9
X-MS-TrafficTypeDiagnostic: DB6PR02MB3064:
X-Microsoft-Antispam-PRVS: <DB6PR02MB306457CD1AA0F44845A86105BCB29@DB6PR02MB3064.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP1yYMTeBgOh81nxoJFr+ELA9Eqab2GeLX7U+DMEjwzj2QBuNtV62LrDUKwBUGcwF4d2RTPz0G8QoSwVyCJr1JD3Vz3KIL6TaNLUiQmejZP4S+FCkbISBj35Hb4sY6mNhqCFRD2HMSDUTZBjBSkEHh/ORT+Wp3kPCQOPP56dHq1gTUAXgi5wQfFkLJ5b8WbHyEc7QDrr4KLWLD9SQ3suPZBWvFRKZ5Su1z0wLyHX3EdXCoBxB6IvlnQeqjGvIn3bR4bCGcFfvSOH0YbEppUH8t8byaEsvT47EKVtB+T/WlTHc1L2g/h1Qu7SkuXd/+R9UN0a8q6gvUfi3jyGrFeABaKJqCCpl9hEYSxJ7QaEQj2pPuZGGmJ9SUSnhQz4kEzfH5eyK23z5p4cVhEAaSzJ0LqctCX2bPPQb5ID9J8VP2MBAVGuxqm4go8TOHrAE6zgaQai+pS5AzojYMu2N2mybAiPJmQ2JA3mf5s2Jz1pf2iW25C6XggrEForkis5Vy/OnZvCYCbZmuqKmIm8fVdrxaABpBM4bdR7l53Eu2g7uJHerWXWSak6aFMNU6XqQeIbmyk3wcg1796gesUgf0OA+pSnFJmgH41dtDTYNQNcs/V/gEuzBodKoaSer+Pcb5PplNgfEQ/lByTPrg8PzZdQSZ7GCv0z0np2PIaYFlyQw49IhvxpwYD7esvt3agq5svt5GIwovJbsz9LcxMI9c0XBsy915v80QaKtsXjnVWoIBlyP8D02XlXXVaLl7vgsuksOla7vzS79wfgHIY9rlWFVha7wbbzPjDzra858MSYGOB9eotiEsUwi/SBLiYwsST4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39830400003)(376002)(346002)(956004)(508600001)(66476007)(36756003)(316002)(54906003)(16576012)(8936002)(110136005)(31696002)(2616005)(31686004)(8676002)(4326008)(5660300002)(26005)(66556008)(2906002)(6486002)(186003)(86362001)(966005)(36916002)(38100700002)(66946007)(53546011)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2V2a3IzUVdOVkRlK0FtRFd6OGg0VW5HTGpDR0NhenA4SHdiNHJuZkw3S2RZ?=
 =?utf-8?B?NFk4elFNb3pJYVhYR2c3eThxVmhON2xlUWR2TEMyR0dOZlk2R1M5NXBWWGox?=
 =?utf-8?B?c3h2ZkFiZTM4OXQwa2Z0U0s3dmVvd1Q5REhLWUZBMjVQT0ZGYUxPdHhpaWZu?=
 =?utf-8?B?TnhqNEZOZ0dQQk1JUzE0TWlLL3JoUWpPS25XcWR0N3JXV2orUEhnQnRIZ2ly?=
 =?utf-8?B?allHbmFobWZ0b0FDZHpOcTVGWitYSmdTZHFsbytLM3dCRUZndjNmdUFuTDNG?=
 =?utf-8?B?SExzeHhhcUFObjBxRTlaMHJTT1gvK0pJcENrREJ5aU8wbGR2SGFwQzErTS9O?=
 =?utf-8?B?S3FYZ28vd3hNN1BnRGthajJnSWd4Mk1OaXR2ODhSNUU3Qnd4UXBpTENQVm5u?=
 =?utf-8?B?eHVRWDN1bU5MTjBTWVJkZ2hiejBZck5na2JXWGQ2NUdnYmQ0dndTNVljUzE1?=
 =?utf-8?B?ZzdmK0VhRHczamRWL2xpYWhNbkZ4Zzk3WTY5V21nTE92WEx4aEZwdm4ySmVD?=
 =?utf-8?B?ODlrZjNwSHRUQ2tsZ0QybW1ld283Rjh1aGRCY1VoUUtaRVZkRmxwSGRoMWc4?=
 =?utf-8?B?TzBQZnlCMmxFL0lXQzFSYUlEVHJUZ1kvcGFhczZOM1dQb2Q3Lzg1T2tkNk1r?=
 =?utf-8?B?Q0gyRnl4dm95bnpTaElEL3ErNkNlbVdKNnAyWmdrbEdLTDVWY3cyRG9tSkwz?=
 =?utf-8?B?ZVpqYWFLdmR1aVZDVXdRblcwTUhISnEyQ3NjSFoyaktZRi9XeEZDQ1hUUjVN?=
 =?utf-8?B?ejJSOGZMOVRjb3ZDcm5DR0hMSncrY3BYVGpSM3dPVVp4NjluWHFZRWtPWVEx?=
 =?utf-8?B?TklCeWxTaDFNNHdCcmZSZzZIYXZyNHdueUJiTXZpTm9pSFNQZmF4Q3dJZ0Mx?=
 =?utf-8?B?MkVpQmR5NGkzMnB3c3M1Y0I1N3kyZjVpYnYyVjRibTloTStPbk01VVdONFlH?=
 =?utf-8?B?bE4xN2pWT0RxMkRhNUZpclEvN2hId2ZaUEh3NlJBZlpyUkdTWVVRQ2sveXUr?=
 =?utf-8?B?aUNyN0YzanMrOWVlRGJCVGM4MmZ2dmhjeFFoZUtmOHNQQVlGWU1ULzArOWZL?=
 =?utf-8?B?bkVHaUJ0L0dVeWhHcVJscjUyK3B3OUlLbzJzY1kyYmo1L2t5dmpZbTdwVmdQ?=
 =?utf-8?B?NXVRYjNuaS80dzlTYmU5R2V0TlA3TmxSb3FXOUZRU3BMK0ZIcnZjZ2JhVGU1?=
 =?utf-8?B?T1UxalhiVnh3WHdYVVdvaUVyRUk5WTVRcUlDdG5SNkpERzhOUDZuWVE0cWdu?=
 =?utf-8?B?eWYvSndnRmtvVnJmLzFPVFhRWUVITUJDQjJiQ1NuM1lvTWpPZGFhaFN0Umhu?=
 =?utf-8?B?MXNFd052aWxRc1h4MlN1eW8yU3lUaVRYZUc1S05ZbE5EUlhybXE2VGNCWlFT?=
 =?utf-8?B?b25XLzZ4cjRSUGM5UVhScGdnY1Z2VVZXYzFnZjhqbnhBTXczVkVhalRHMjNZ?=
 =?utf-8?B?RlBiNGdkVUlUTWo1dkJKZldpYU9ZUTRMZFhUNW9ndFYzOTVybGg3ZkM0NWtE?=
 =?utf-8?B?MUdYTjJMTGpBd1kwbUQ1WDlBTG9sRUVWUzBGNlkwZU9mZVZMaVc5OXl0TUdM?=
 =?utf-8?B?aW1FS0Irb2VCSUdENkdsRWtiem1BVmd4OXI3TTd4MG12UXVPRXJDV0NSQk5I?=
 =?utf-8?B?eFNHcUpSNDdJcGR0blpJa2QwcForQmhsUUduRXpiRlFJQURZekxyeklsVkw5?=
 =?utf-8?B?YWZvVHMxRlZYK0xWc095akFBeEEwM2VndXJUOGdPMmpxTXJBWG9HZjVkZGJr?=
 =?utf-8?Q?bl5YNmZqlTEDageifK5vpJ5wqC+bw8IPe+8uzYy?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ea69a555-2635-420e-b797-08d98a7028c9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 15:27:37.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsmsgYVyBv6MHAJGaD8G3PyFXBJl15+UGxNd50eitscU70ZUiZhAEr68GiuMg56d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-10-08 15:56, Vincent Whitchurch wrote:
> On Fri, Oct 08, 2021 at 04:46:12AM +0200, Rob Herring wrote:
>> On Thu, 07 Oct 2021 15:46:40 +0200, Vincent Whitchurch wrote:
>>> Hardware may require some time for the muxed analog signals to settle
>>> after the muxing is changed.  Allow this time to be specified in the
>>> devicetree.
>>>
>>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>>> ---
>>>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
> 
> Yes, these are not new warnings.
> 
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1537724
>>
>>
>> adc0mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>> 	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml
>>
>> adc10mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>> 	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml
> [...]
> 
> I think the fix for these is to add a "#io-channel-cells": const 1 to
> the schema.

Agreed.

>> envelope-detector-mux: channels: ['', '', 'sync-1', 'in', 'out', 'sync-2', 'sys-reg', 'ana-reg'] has non-unique elements
>> 	arch/arm/boot/dts/at91-tse850-3.dt.yaml
> 
> This one looks like an error in that particular devicetree.
> 
The double '' is intentional; this mux is 8-way but only 6 legs are
connected, with the first two unused. I don't know how or where to make
changes to dodge the warning. I don't want to put names on things that
do not exist, and the iio-mux driver is using empty names as a hint to
not configure any child channel for those indices that have empty names.
If e.g. channels 0-5 are in use, then this is not a problem since you
can just end early with 6 names instead of 8, but alas, channels 2-7
was what the hw-crowd fancied in this case.

Cheers,
Peter
