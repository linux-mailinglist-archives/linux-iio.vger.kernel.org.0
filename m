Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED7C2D8A9F
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 00:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbgLLXXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Dec 2020 18:23:22 -0500
Received: from mail-eopbgr80102.outbound.protection.outlook.com ([40.107.8.102]:5583
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbgLLXXM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Dec 2020 18:23:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5zSQn62jVSv2lRkO8zIn6NSjGwaX99JIc+etsyP5wthgLMdi3TLbT2mOfHVYCmLk6f3osT1lCXozdYVXwOZIGeedxrMSlb17d+EkZaFZmZf5x61tjSejNVZXCFnTl8EOTkgt6MTbvv1x2fObiHMvEc0mG4X1wry7m+RUYwLPSCxQlD2sTATH1QVmV0IH5qHhK3JVZLV3TvRXP1y9z55NUQSXtr2yfrjTEkFfj0KxFERMcW9Jne7ZU+rRndGxpjDQ2Sis3JLeUvu62QV8uYi7GM0rQd5jon/dJb5lB2CQTKaSGeeqVyENPDpilKICYLcwkuCk9SUZLfODzrGOeRlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMSzFNa9IKD9P75VwMdr1dQsEdXbcSIdTvNV62DyVB4=;
 b=exG3Bg7/PB3vs5847ChoCfsaYrVTd5oZa1OXzI74lSQPjp8BlSvS2smIQyUuoGZ5SuAbXk3LFRiFb+AdUpWeEVtWfelWyYmhp82cWiMwTQSnCjT1/ZVr3BLvKA+jTMcDgsKpDSHGekj+J0WWIwsIsbWX196nnocoq+4pygEUL6+0dd0AWjYtKz/q7V2NsTu2YG/gFUUGHXIzIwYlR/ll48SWfm3gNSgEyGoYJJweCyGjhiBp/ELnsifkF/t5If5YRDybdyEEczq5MpmDhPE5XPYe/G0JrFCMF+XB4/GcYi94rfT9fHuNYde46SVku+uXKXPjr7pOTgZlZyVbogyhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMSzFNa9IKD9P75VwMdr1dQsEdXbcSIdTvNV62DyVB4=;
 b=TRWqJWLqvugAqXAK4Hy5CiOQ85/Q/Cs6RvF1ca3MPsYLzHJpPCGLkW4jSqqOadFOZnQCqmuJ4W7BkrS9Qx6mUQhbudUbhqgZwPtEk2ZMJg/lZ00TR1YRyPVszxdAAvn4ZDUhPHH+fHdzUD8Ar3/WdmPh3NKRn7UByFYwGk5R0M8=
Authentication-Results: pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4476.eurprd02.prod.outlook.com (2603:10a6:10:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 23:22:22 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f%6]) with mapi id 15.20.3654.018; Sat, 12 Dec 2020
 23:22:22 +0000
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
 <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
Date:   Sun, 13 Dec 2020 00:22:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0102CA0005.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Sat, 12 Dec 2020 23:22:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1b3c41-1ce9-420e-983a-08d89ef4c701
X-MS-TrafficTypeDiagnostic: DB7PR02MB4476:
X-Microsoft-Antispam-PRVS: <DB7PR02MB447639DE0FE92034BFD201BDBCC90@DB7PR02MB4476.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UPJx6lu+7tbTthIp8hADY4k3PTV4+ppa7OESt3JQL/exmeCzuwqAXvLrLjcokU1MiPADNddojFX0ade+62+bTgtYSPkGPOmV951KOoZRzOP/nNjJPJCG9cgkpzQ/NjpJI0uhSeQtN6ffMM8KFWWNK8/TtMI2O/L3D9/0Q2yWUrBqHkHpSmm2p1tpiJaO9mWh8HNUsAXPHbJKPZf6F3ncaESdjcasprC9JQVvbrYf/zznIWMHbZAXSCwccMgtCHUCfeVMaVGy6o2IhKprGjyzx5f5aKnqVwX6HbSY4FpIp4L6Kc1AzI91hqSlP86yUM8Sdjzme6o9jAWN/trwp3SGKq7lRbEoj2zKMvH6v9DtdvMRbWC6QNFuePRQDEJD/J5VsK2ovQIRCnQTVStSV+sGwp5gDOSuuZbzMVK0bbW/1cmBQGfPG2qTPLXKzrJ8g7RSbZaN871V2CL8hk/DCWhXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(2906002)(86362001)(31696002)(66946007)(186003)(4001150100001)(36916002)(8936002)(966005)(316002)(66556008)(16576012)(31686004)(26005)(4326008)(110136005)(6486002)(36756003)(2616005)(54906003)(956004)(8676002)(478600001)(16526019)(83380400001)(6666004)(5660300002)(53546011)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2ZCeDlZbzhILzZSb3J3Q2tqZUN0MmJjWDNxNmxCdzBQNWRCT1ppb1hMT2tM?=
 =?utf-8?B?QW9UM1FQS1AwbGhJdmhlUEMrVC8zWFEycFdxb09WQkFmaFJOWmhNUWZHMUd2?=
 =?utf-8?B?akprT3N5SlpaYmttVzdVcVF1VnVFbXBIaWNQZE1PZUdQa1h0emgwR3hBTlBh?=
 =?utf-8?B?MVlFbmI1UU5aa2NkNHkyVGFNRG9RYTRzc1RxWk5CalAwVFFOZUNDdi9JYlh5?=
 =?utf-8?B?dm5zVS9yOEZSVGVQRXFIekpTSE5PS3dhSG9iVjdsdzY4QTRjYVdzSG5MQm9V?=
 =?utf-8?B?UnBRNWVkaWNRT0FIaTVoSG9UMXJzQVcwb2l0emNOOGVaSUhTelA0WEp4dSto?=
 =?utf-8?B?VGJTMHJRcGVMemh2NHkyRENwZEFGaVFBSDlqZDNUUGFhVTJGU2VweVNwejl3?=
 =?utf-8?B?WUk5SzZxR2E4VFN5ZkZOWnlEU3lybzI0U2FvdkJGN3l1SmVmSXhGMmhKSFFs?=
 =?utf-8?B?WXR4ZUJ4U2RncjJYV1ljZ2NPeHBsV0F3WXhrbVpESEFMUlpRU0lReGxRUjNr?=
 =?utf-8?B?T1ovNnhaVDFlRU5GNWxIaW9yU24wYWZNS3c1cXVmdjhINERPVVd5Z2YyNHJH?=
 =?utf-8?B?a3E0WjVjR3hZS01NUDl6K2FRNDdKbG1DY3FqOWFHai84RXdsbXFsSHN5QkNz?=
 =?utf-8?B?aHdMOGUxYzNYVGpDRmJzamYweXNzYThXQlpLWGtOTHZyc0JVaFNnU1pjUlJX?=
 =?utf-8?B?M3hlaTFCL3hCQjAzL0ozOG13c3V1aGJlOWplaGprZFZ0b041K1l6dTMwemlm?=
 =?utf-8?B?UDBrQXNEU01oMFJoZVcyUEdUK0FuVzV6MUt5azJEdjhGdHc0VE1zdk1FMG5J?=
 =?utf-8?B?OEorUjNoZ1pQSW5iSW80cFR6cG10RWlZcUhNK2dVS1U1UlY4bi9LREYxYkx5?=
 =?utf-8?B?dkN4VVMvbUdBdjRRb0ZmLzdwaWNWMmt0RURKVU13NGVXSG1QMG8zNVFkU2Zh?=
 =?utf-8?B?aHF3ZjlpSlRuYkdpblJFMDR0Z2tMalVnSzlKWksySnIvbUhOSE54c3B1S0hK?=
 =?utf-8?B?am1JV05RYTBZVUNqeFJvaXdYV2hoZE9DUmI2OVByZUZKaEk4SnhmWm5GK1Mx?=
 =?utf-8?B?SytTaWFoZmxkMWYzdTZGS3Q0NStYWVdsWURkM3lxdTMrRmlBS3lZVEl5QU1y?=
 =?utf-8?B?eFVkVXpTMTBYM1ZGN1JrSk9kVEVQKzNFSU9DeUJCT3hMVElXSXM3YXJpRDRO?=
 =?utf-8?B?NXg3cFhHWGRGczkwRzVWdUxKUUhNT2VFb05TWHNhU0pHSGhFT0Y3d0gzc2Y0?=
 =?utf-8?B?aFB2czEway9vUHhwK1ZEYWdIMW1KL2J3WGtSWndOeG8xU1pmbGlsK1lTbWZE?=
 =?utf-8?Q?mwO5poJnWmbDlz7GSrW/6NBCvx2yaE7NTT?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 23:22:21.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1b3c41-1ce9-420e-983a-08d89ef4c701
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blPtw18I6O9wO1nUa5z6A5gvrUHfyIBbVwUdT/8atX4OFlV0zvgsTgDy3H8kwcmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4476
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-12-12 13:26, Linus Walleij wrote:
> On Mon, Nov 2, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> It happens that an ADC will only provide raw or processed
>> voltage conversion channels. (adc/ab8500-gpadc.c).
>> On the Samsung GT-I9070 this is used for a light sensor
>> and current sense amplifier so we need to think of something.
>>
>> The idea is to allow processed channels and scale them
>> with 1/1 and then the rescaler can modify the result
>> on top.
>>
>> Cc: Peter Rosin <peda@axentia.se>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Did we reach any conclusion on this? I really need to use
> the rescaler on an ADC that only handles processed channels...
> 
> I'm sorry that I can't make this ADC disappear :D

Hi!

My conclusion was that the patch is buggy since it presents inconsistent
information. That needs to be fixed one way or the other. If the offending
information cannot be filtered out for some reason, I don't know what to
do. Details in my previous comment [1]. BTW, I still do not know the answer
to the .read_avail question at the end of that message, and I don't have
time to dig into it. Sorry.

Cheers,
Peter

[1] https://lore.kernel.org/linux-iio/320464d8-659c-01de-0e08-34e4c744ef16@axentia.se/
