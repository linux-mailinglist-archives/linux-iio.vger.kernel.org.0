Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502ED2D9431
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 09:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439254AbgLNIfd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 03:35:33 -0500
Received: from mail-eopbgr60121.outbound.protection.outlook.com ([40.107.6.121]:32835
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgLNIfd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Dec 2020 03:35:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4CXw56DetfBMdwMo4fafwTJYeESrPdWqM1C3tBK5yDhBr6EaHGHsnwKuGZcno4q4hqW3NRJy/fZO244P2Kdhahh9cPTGZ6Jum1mHpghUbbSu/FLl6QmGEjeioF6TBAz401S22sG/DPVBwBllmVq4oMFU/uM86me0xHGdLXhEFEsLmTht04Nwhg8AKMkH81ZPlnbH/RJf9x+LnP0oaxFbUr9A9mbiFnpZIEbFH0Hr0oWuxlBdwe1BwGonjikqGuMuWCXaXdes/E9PTlQmhSOuXIzHAAQ45ZuvhxAbfLMQ+jmdZyDgCZx/7vSdK6JJNnUswVS7qT0ld+VXMXHjhohww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFZeMfH6GTEDS8PC6bLq/72/KnaTFAmoAZxVeQnADA=;
 b=jQpw6BFbUIGk8G6+X4wzwtvtF2be8xh+QLllHj7KTvdUrBHo2wF+gZesod3/8xRAyNCmyleEiS0WEJv1F5/2D3ozrkOnXpZG6Nb1XGyJUttqvshE0pltCVyvxWj43HOEWVArFFOlBwZAnKLS9ovoq29O681Dp1C0rcByP2tm2SqPVj6CthLGJJVj1XHH4DuYdMZDAglB05AkAiKm1KeudfdNexgaKXDWT7cKc7U3xFkNAPRuUuCKEsFJcE+bNHzST/HbU4GAKFZ8hAmoJk5e68vobJq+RTLv3x90tfMemhHNxg4zJ0ulnBGFf9PbU3UAID9rhTRwnLLtYgKKiVbLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEFZeMfH6GTEDS8PC6bLq/72/KnaTFAmoAZxVeQnADA=;
 b=Iu0Fuya8Ep+hDWc2/Src6hUFTe7XoO+ObUYsyV/p92FbglTnFD4KACMZmG3nUE7dDpULvJuz04GanG5ubDI1JIM9S6vAhS8Ql6/XQ31Oq7NkKb7o38k/ynBOx8YTDkbC4jIkR9kXcBmRPj7K7wVaO6t/sw4HHnBK+brk2M5Ag7k=
Authentication-Results: pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3174.eurprd02.prod.outlook.com (2603:10a6:6:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Mon, 14 Dec
 2020 08:34:43 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f%6]) with mapi id 15.20.3654.024; Mon, 14 Dec 2020
 08:34:43 +0000
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
 <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
 <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
 <20201213121615.55a86f77@archlinux>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c34cc481-0244-a68e-8ae4-75e8e62b18bb@axentia.se>
Date:   Mon, 14 Dec 2020 09:34:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201213121615.55a86f77@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0802CA0008.eurprd08.prod.outlook.com (2603:10a6:3:bd::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 08:34:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9686ad70-1f2e-44c4-d405-08d8a00b1b34
X-MS-TrafficTypeDiagnostic: DB6PR02MB3174:
X-Microsoft-Antispam-PRVS: <DB6PR02MB3174C146AD9ECE30769E9877BCC70@DB6PR02MB3174.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ka4NvpUTUCop3aO/o84/PmhmDrCMmkLxCEpCG+wkV7OoKGWjTl/7Di7AmKK2aB4bPg2rnKrwxu2C10IjAQ990gTeNoS43ayxzMqwQ691ctl158Lw1i9rhD11PD6llxzvAIDsNhw7Rw6HNPA2CYotjjoXcxZivOxRTsiHpKz6nCmTQQS3J7smJfr2+3T6pnc9bzlid6jq40aloYy/ceTnDvugPDQUn7gkGrNlp0ZE3BOwKcs4f6d00tkaJycSHyElcJkdgcsu8lwA8fgvu8fRg4Y6n8bPQGbzh/T70MlyzN4kULWJNc0TY+5f7CSGY1yjJR3u/TbRx+Ys/abbVfVIOoPDH5IhwDEduDEm7si1/xKCThdGmhpyXngGb4Ax4VQ1JRNDjVmp8OVv2+MkweszGyQlrZyRiKOpi0Jitmdq6+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39830400003)(136003)(366004)(396003)(6486002)(956004)(16576012)(6916009)(316002)(31686004)(8936002)(31696002)(83380400001)(36916002)(4326008)(86362001)(53546011)(2906002)(8676002)(2616005)(54906003)(186003)(36756003)(4001150100001)(66476007)(66946007)(478600001)(66556008)(16526019)(26005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1lRSmVSS29aSk53Q1E0ODQ5YzFQczNFOGdSTUg2eDlNM2I2bHdTMjcwVldk?=
 =?utf-8?B?QW80MElxdzIzNkZBa0N0OXdkVW4rWEg3VUNSZ1hkekQ5dzk1Qi9vUStoa3FR?=
 =?utf-8?B?dXlVQUdaeGJKUXlGQ0syV25abE5qQXZuN3JZNTZscDV5WHM4YVFzMzIydjVF?=
 =?utf-8?B?UFgrNEQ5b2NKQVAreFNtajBkWUNGYTBpU1kvdEFBM1Z2QVhmSkVNdHcwV3Bq?=
 =?utf-8?B?UjNLWVRiV2ZESzdhR1pDOUpERWJXVFNZNGVaMitiUU1BaVdiQncrZlBpdzZs?=
 =?utf-8?B?N0hIUmNILzdyRXNsTGZqVGx0QzVtU3VWbFRCSERlSnZuLzE2UWxURXlzbC9j?=
 =?utf-8?B?cmFOM3pVbllqaE9BcVN6ckJzQXUzWGZValMvWXhXd2NlU3I5YVRYWTE4czBn?=
 =?utf-8?B?ZjgyQy84NXBIdHpjNXVQUmFyT2dFakFwT1VreGRlTjJmTVJnc0J3S1F3VFd5?=
 =?utf-8?B?WHRjUm5CTG1TVXh1c1lZUkVEZmdQY0lhQkUzT2JIcGdiUUhlN3FCd1cwNWxa?=
 =?utf-8?B?dTBMTTNVMjZ1aUZKRzlxUnRBSW5WOXlYUFppeDVueEs4RHl4RWFzbE1uREQ4?=
 =?utf-8?B?QTBEbnNnVHRxekM3Y2JYVWNFclRzRlZERHdEYmRCRDdOZEI4QnpsTkNSS2Ir?=
 =?utf-8?B?ZnpJR1h3UDdsdlFBcjJFeVR6Mm1uSHh5bEJrV0JxVlhVVWZmWEY5QjhWbDRs?=
 =?utf-8?B?MFpnelIrNGl3WXRjSnpMSk5TR0tzRXVsdU1vNlRWUlRDNUdtYWk2bTZBK0pY?=
 =?utf-8?B?L1FrNEdFNnBqeTI2NitKcnhsU01EYjhoczBiaHE2ZW9pQmVUZDg1UENBVmtN?=
 =?utf-8?B?ejREbG1zckdmVkowZXF4RTJEeFRKa09qaUkrN0lJMEVyTWtRNTZIcmRyQTBU?=
 =?utf-8?B?YkFrd2MxSytFMS9vcXZWVWVYRGIvaVJCR3k3YXQ4TUd2bE1MNGh5MFY3ejRj?=
 =?utf-8?B?cVV5bWM0dFd5dEF4QTBYMWJzekFEK1haVWZSUXRGZ1liZm5LZ3k5dTkrRkZU?=
 =?utf-8?B?OFg1bmFLMWlTN1k5d1d5Tnc3VERuaEZEaGFJeFhPZjIwWHNOSlNQSStFaHV0?=
 =?utf-8?B?Mnc2S0oxdlJYbTZCWUVpRWtPdVFEYmJ1dnkvZnA2aE9POHFTZXdTc1dxR01r?=
 =?utf-8?B?d3IvNVRrMHJ0Z0p0MGVsTUxUSURCcFJObzltWm5VYkQ3YlM1TTVOSGFoZGVV?=
 =?utf-8?B?YXhEb2tyYVcxVW03RnZrZnh4cmFTS2pxRWdaS2dBaXhDZ1FOdDNoK3lkRzVv?=
 =?utf-8?B?WEJadHAvdjdtOFYzM0NwTnJvQjRJSURPenhVZmJDMk1YcEE3TzBxQmdzcmRi?=
 =?utf-8?Q?LsUmCETX97fWw8Yl/YSkUxqmPM58L9dEbq?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 08:34:43.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-Network-Message-Id: 9686ad70-1f2e-44c4-d405-08d8a00b1b34
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QUy37gzKxtUEiaxz1986hH/u/Md4HHO7LALQJRNHercGYg3G55WxFttruMnVHEu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3174
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2020-12-13 13:16, Jonathan Cameron wrote:
> On Sun, 13 Dec 2020 00:22:17 +0100
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2020-12-12 13:26, Linus Walleij wrote:
>>> On Mon, Nov 2, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>   
>>>> It happens that an ADC will only provide raw or processed
>>>> voltage conversion channels. (adc/ab8500-gpadc.c).
>>>> On the Samsung GT-I9070 this is used for a light sensor
>>>> and current sense amplifier so we need to think of something.
>>>>
>>>> The idea is to allow processed channels and scale them
>>>> with 1/1 and then the rescaler can modify the result
>>>> on top.
>>>>
>>>> Cc: Peter Rosin <peda@axentia.se>
>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
>>>
>>> Did we reach any conclusion on this? I really need to use
>>> the rescaler on an ADC that only handles processed channels...
>>>
>>> I'm sorry that I can't make this ADC disappear :D  
>>
>> Hi!
>>
>> My conclusion was that the patch is buggy since it presents inconsistent
>> information. That needs to be fixed one way or the other. If the offending
>> information cannot be filtered out for some reason, I don't know what to
>> do. Details in my previous comment [1]. BTW, I still do not know the answer
>> to the .read_avail question at the end of that message, and I don't have
>> time to dig into it. Sorry.
> 
> Unless I'm missing something, I think it presents no information unless
> we strangely have a driver providing read_avail for _RAW but only
> _PROCESSED channels which is a bug.  I'm not that bothered about
> missing information in this particular, somewhat obscure, corner case.
> 
> So I think we should take the patch as it stands.  It's missed the
> merge window now anyway unfortunately.  So Peter, I would suggest we
> take this and perhaps revisit to tidy up loose corners when we all have
> more time.

My concern was a driver with a raw channel, including read_avail, providing
raw sample values but that no easy conversion existed to get from that to
the processed values. One option for the driver in that case would be to
provide these raw values, but then have no scaling info. I.e. the way I see
it, it is perfectly reasonable for a driver to provide raw with read_avail,
no scaling but also processed values. And that gets transformed by the
rescaler into the processed values being presented as raw, with rescaling
added on top, but with the read_avail info for this new raw channel being
completely wrong.

For the intended driver (ab8500-gpadc) this is not the case (it has no
read_avail for its raw channel). But it does have a raw channel, so adding
read_avail seems easy and I can easily see other drivers already doing it.
Haven't checked that though...

But if you say that this never happens, fine. Otherwise, since it's too
late for the merge window anyway, the patch might as well be updated such
that the rescaler blocks the read_avail channel in this situation, if it
exists.

Cheers,
Peter
