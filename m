Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B7A2D9B05
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgLNPbZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 10:31:25 -0500
Received: from mail-eopbgr00117.outbound.protection.outlook.com ([40.107.0.117]:23022
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438730AbgLNPbR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Dec 2020 10:31:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+eaFbd51f3Q/6J1RFkiCapuy3nhwAW+YVu5inw3N7YzjRQPC5WjD4M4Q2dBXe0BH7QpoggmpIrPnZWWuI86sBNkZYe6xYA7nU6pUCGnvgOGYc3ev5Wui9Pfa/pZ7lBL/sRpND/TpopfNpb+EAcXE05atWe2yJTYLJ0TgqErlTcOT8kKM/NW86bITIMUfFZSDu2yyh/D8dhzLREK/qloU+DQUyQitIuZN2wqiQALKpWeO0+MwsFoFR9+v514LKjezpg5LM1cM+JhY+RwNsZLUOBS5DWpFo3GEpXMtkQmuzTbdgs/FMmbHbaIkMFYO2TpURZnyqNs9GsDt9+wu28f/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDKtusoctnw28kEx/8ur+ZuK2MujghB56ZLh5Ao8dYg=;
 b=d0US7oZCOdtDUOuzqLg0AyVOvq8buv543g+aRIU12Xx8O3TWGmrcHIJdfi7NdR5llE3reCCj+jNkRio1FZhIXA45wVyIuTmnvbJhYQ2VDeFHgbctt/tLmpkM0TfBaKQFG22G/yVTy5zEEnqcvSM+XTO/FoAVjI9Cv18uU/PzodXZ91iED7/kv3QAP7wtA3bXZxgQ0a9iyM03dlOkpdzzY8pwQnmaDIpt8Um3krVw2xButh7kGSBF1/imZVaPrBpZBIuHclMhOSG5wsa6/0VWj9EYURPcLVoFDtJ1ZTC1M0zLD3JUhT8CNTCnUFzsRjM2W96KaVD5VBsXo+SGfUIQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDKtusoctnw28kEx/8ur+ZuK2MujghB56ZLh5Ao8dYg=;
 b=b5sv8xslSIJxW1afZCfaReoHdCIQWgIlSDQaWvDCaq6sxucMH1SO1Mj0CHe0WTptvY6cGA4EGznhgMmYIPLfS6F0MHdHbySAKHYPPVPGVto7vmzLaIIM1+0r3mA9+Hy4afRSbkIzOJB5GBosNTT1d8IXuVihR77rZxQcHUwYwBQ=
Authentication-Results: pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2792.eurprd02.prod.outlook.com (2603:10a6:4:b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Mon, 14 Dec
 2020 15:30:26 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f%6]) with mapi id 15.20.3654.024; Mon, 14 Dec 2020
 15:30:26 +0000
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
 <CACRpkdZc=qGasbsL7DWbbRGyvxaX8hh2iU-QfLpkYGCD3UrqOw@mail.gmail.com>
 <435ebb1b-431c-fdeb-023e-39c6f6102e22@axentia.se>
 <20201213121615.55a86f77@archlinux>
 <c34cc481-0244-a68e-8ae4-75e8e62b18bb@axentia.se>
 <20201214150728.00001fa7@Huawei.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e755c671-a212-e93c-427c-66ab031289c3@axentia.se>
Date:   Mon, 14 Dec 2020 16:30:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201214150728.00001fa7@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 15:30:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5e2e0e-196c-422a-f1d1-08d8a0452e56
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2792:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB279268B591D936D52590DE5BBCC70@DB6PR0202MB2792.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSR6UuhcRH2OmdSpvMZ4PpwZF8W8OPhDXj3upKyNRXuOBULoa+MQXMBWslhe2gCC9Bg0v58OsXO+WvSSBREhk1KpPCzZ/gNmfFlNZCb0zAzTfpPN8okkoR4EgmmcEXtyaR1AgKAK31/IdqigzZfBPU5WZ1BRuTcJpt/tfN9M4b6NhBYJXMAyw4GOzvYwcuebtHZtb+7umzhmyLo0FjLB3g1UrsZL968mO75HtOBjmB2dA/fhTYwQl9DSva1TGRhWgqDw5YwRU2GpoabwY129no9rgDDnCNINi+z+5jHNVdJpNEv9N19v5WsI1PJGKj9uxDC2JVuPz4fEKvYpW9MuJW3LbldQjPv2IguT/CWBj7cUrhhkgXcID2QujgAyi7pBV/lvRecLGTLUPpIrm2IPmkvS2vOYZK2BwqnRa3boO+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(346002)(136003)(376002)(2616005)(2906002)(16576012)(66556008)(66476007)(8676002)(5660300002)(54906003)(53546011)(36916002)(6666004)(956004)(316002)(83380400001)(6486002)(26005)(31686004)(16526019)(36756003)(478600001)(6916009)(8936002)(66946007)(31696002)(86362001)(4326008)(4001150100001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ty9abXJId3gwamFpZU1RYjZRblpDcEFtOUMrQU1sY2xnMHUzUmF3L1FpRmdJ?=
 =?utf-8?B?ZDVjTnY2RVdpSFFRSllmcEZXeVJnK0tFeURseDdGYXhjRnU4Z3dlOW9kQXVo?=
 =?utf-8?B?ZUFYU0xrSEVkT2MzckltVjVBZFd5bXhucnV0TURFOWlUanpyZmRPekJvQ2N4?=
 =?utf-8?B?MlhiMGF1ZlpzejJhNExKaWRjeVZxYVJnZ1ljWmphYUQ2dW9tRnVEd1I1akRK?=
 =?utf-8?B?ZVJmcW10bEpxa3QyY3lXMWNva0YvRmJtQnZWcklDRjE2clNkanN0Q3cwRWg4?=
 =?utf-8?B?c3ZJa3BaMlg1NWN4NjdsWnBJTUxUdllvRzBaWUVWbnVOOUtIdi9ZUlRHMUZ3?=
 =?utf-8?B?SFpWbHdCdzhKVTVvSzVGSnEyMk4yZis1aW1GVTN4MFFsQlR5YzJZZEdTK2Jm?=
 =?utf-8?B?Qjg5bFZCZDlETTNVRHFSQk9rdTgwb0hIa1BEZkFWNGJPelZsTVZwaGZHM1ZF?=
 =?utf-8?B?dEN3Q01kZ1YxaTIxTWtOV2FNZDl4cW9vZWlOdnF3TVNVd291S2ZDNG5jaTZR?=
 =?utf-8?B?SEJMU2RGNEhMNmY0MDQ0eWNQRmhKWGgxdDRlcklpLytuOEZ3RE15Zk5sczNE?=
 =?utf-8?B?V1RvWmpzSGpZN3pNZk03ZXFEb0ZQckFkZ21TMTV2czk3dE5sOUZLcy9ibjNW?=
 =?utf-8?B?Wmp3eEU4aWhXVXlaSWhFT2FacHQ0cklkalF2SW5icXptekg4OURUZWVnTGlr?=
 =?utf-8?B?dGdxeGNSbk82ak81NHNGdTZKd2RUMVArK3drYlJhRXZVeUI3VCt0bHNtOTNC?=
 =?utf-8?B?bmRVak1WSzFnMXVBZ3YyYjZhVXcxeTRXVFVibUVKcGh3bFc2bWllRkU0NjJI?=
 =?utf-8?B?TjlLZ1RSVTZlZVNkZEVsK0NWTUQrejlZeUR4UWdueUxYVjd2Q1JsMjBvUzRM?=
 =?utf-8?B?MnBGVTN3ckhiMDEvMzhsWjNOZ1IvVmpacXJwTUVJekhLOU93K3VkQ3BxS0Nn?=
 =?utf-8?B?ZnRGRllRUTRSQ0UyOFRPR1NVb2hKYWxZT2VoSS9IMWFtcU1HTDNRaFNENmlS?=
 =?utf-8?B?ekFsb3B1ckxsb2pDSk1kZTBCWG1WWU5XQTFkckZEb0xCbVZ6dHZjUmJYekcv?=
 =?utf-8?B?S0F6WThjelBhZmRiYXg5U1dvcVlSdzIwR3ZadTFmT05JMDVqMnVvZnA4L1Fa?=
 =?utf-8?B?NjRLNW4xYjFDTDFRa0c3aGwzdkdiN1VldW0zU0hleDV4UmVFQklYU1p6QitU?=
 =?utf-8?B?N1pxUjJmWWIwcTkrcmZaclJCUXNZSjZGVkpsSUJrSGYwcEFBMG9hNXNFSFFm?=
 =?utf-8?B?d05VRXpSVFh0RVFJOU1rRXIvYkx3d3Z0QTFKYkxpYTlSSDNORUZ3aDlUcm84?=
 =?utf-8?Q?stdmPM82jD5CqsArV4nZaWx0YvkTkvxzfu?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 15:30:26.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5e2e0e-196c-422a-f1d1-08d8a0452e56
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gx9DPn1t9RLV17dkvsyIKG5XSW6lIuegxDtitTl3tfXAy3Uf90ztvwE+jYd+aeX6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2792
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2020-12-14 16:07, Jonathan Cameron wrote:
> On Mon, 14 Dec 2020 09:34:40 +0100
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2020-12-13 13:16, Jonathan Cameron wrote:
>>> On Sun, 13 Dec 2020 00:22:17 +0100
>>> Peter Rosin <peda@axentia.se> wrote:
>>>   
>>>> On 2020-12-12 13:26, Linus Walleij wrote:  
>>>>> On Mon, Nov 2, 2020 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>     
>>>>>> It happens that an ADC will only provide raw or processed
>>>>>> voltage conversion channels. (adc/ab8500-gpadc.c).
>>>>>> On the Samsung GT-I9070 this is used for a light sensor
>>>>>> and current sense amplifier so we need to think of something.
>>>>>>
>>>>>> The idea is to allow processed channels and scale them
>>>>>> with 1/1 and then the rescaler can modify the result
>>>>>> on top.
>>>>>>
>>>>>> Cc: Peter Rosin <peda@axentia.se>
>>>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>    
>>>>>
>>>>> Did we reach any conclusion on this? I really need to use
>>>>> the rescaler on an ADC that only handles processed channels...
>>>>>
>>>>> I'm sorry that I can't make this ADC disappear :D    
>>>>
>>>> Hi!
>>>>
>>>> My conclusion was that the patch is buggy since it presents inconsistent
>>>> information. That needs to be fixed one way or the other. If the offending
>>>> information cannot be filtered out for some reason, I don't know what to
>>>> do. Details in my previous comment [1]. BTW, I still do not know the answer
>>>> to the .read_avail question at the end of that message, and I don't have
>>>> time to dig into it. Sorry.  
>>>
>>> Unless I'm missing something, I think it presents no information unless
>>> we strangely have a driver providing read_avail for _RAW but only
>>> _PROCESSED channels which is a bug.  I'm not that bothered about
>>> missing information in this particular, somewhat obscure, corner case.
>>>
>>> So I think we should take the patch as it stands.  It's missed the
>>> merge window now anyway unfortunately.  So Peter, I would suggest we
>>> take this and perhaps revisit to tidy up loose corners when we all have
>>> more time.  
>>
>> My concern was a driver with a raw channel, including read_avail, providing
>> raw sample values but that no easy conversion existed to get from that to
>> the processed values. One option for the driver in that case would be to
>> provide these raw values, but then have no scaling info.
> 
> Generally I resist this a lot. The reason is that it is impossible to write
> generic userspace software against it. The one time we did let this happen
> was with some of the heart rate sensors (pulse oximeters) where the algorithm
> to derive the eventual value is both complex - based on published literature,
> and proprietary (what was actually readily usable). What the measurement being
> provided to userspace was is well documented, but not how on earth you get from
> that to something useable for what the sensor is designed to measure.
> 
>> I.e. the way I see
>> it, it is perfectly reasonable for a driver to provide raw with read_avail,
>> no scaling but also processed values.
> 
> Why?  What use would the raw values actually be?  There are a couple of historical
> drivers where they evolved to this state, but it is not one we would normally accept.
> We go to a lot of effort to try and avoid this.

Drivers that have eveloved over time is exactly one such reason. E.g. a driver
starts out by not caring about wrong measurements at one end of the spectrum
because it is "linear enough" for the first use, someone comes along and fixes
that. But by that time it's impossible to completely remove the raw channel
because that would be a regression for some reason. And there you are. A
driver with raw plus read_avail, no scaling but a processed channel. Or
something like that...

>> And that gets transformed by the
>> rescaler into the processed values being presented as raw, with rescaling
>> added on top, but with the read_avail info for this new raw channel being
>> completely wrong.
>>
>> For the intended driver (ab8500-gpadc) this is not the case (it has no
>> read_avail for its raw channel). But it does have a raw channel, so adding
>> read_avail seems easy and I can easily see other drivers already doing it.
>> Haven't checked that though...
> 
> Drat. I'd failed to register this is one of those corner cases.

I'm not sure, I just browsed the code. Maybe I misread it?

Cheers,
Peter

>> But if you say that this never happens, fine. Otherwise, since it's too
>> late for the merge window anyway, the patch might as well be updated such
>> that the rescaler blocks the read_avail channel in this situation, if it
>> exists.
> 
> That's fair enough.  A sanity check and then suitable warning message to explain
> why it is blocked makes sense.

