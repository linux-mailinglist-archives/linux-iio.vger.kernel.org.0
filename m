Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6347E396547
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhEaQaZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 12:30:25 -0400
Received: from mail-eopbgr70104.outbound.protection.outlook.com ([40.107.7.104]:14053
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233475AbhEaQ1m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 12:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvFxRNDmvQF/HVyJTIo8CXYNtcf1isOTSkIMrrRnfZL2xC5AUD3sizhh9unrFqA82sa5Or73UE53fH/oc7AfScHkEEPuXhAzT3b6/dSz9uXaxYmU4bTAF7QHsRm8XeNv8uXkv5Qsgdf35VTz+BzOK+nmL35Z1MlE/zT7YeFnUb1uuY2Jrx9SPCJ4QKQrIdwvo64nixBAC9BFy/24QrEAxrqQ2++bKzdqAM1Z1f/9IPT53XmjY83bdClk7UOb6JVbN/OTUd4xh5PLbWesFLQB1+cQNAx+MLeGov4FnedjbsmV0/Cj7x8h0pJ7emrT6yqAYwv55R8+MdoLgccTJHzudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJA2CgQRgfqGf6dAbToOLo09G1NkQXNzw/UidDpj9D4=;
 b=jnIMPWXK+o5T26mqlBYmOU7hLNJYI8QPHUVNhQsM9nOqQ+kFqnWIEPHJ+KeRNJKB8QtGnbYcekus9daKnc6q/Pg81rhH+6UulC39BztV9PumXKNfVwEA0i/iC6i7CJr56jVdxMQCwCH1DuEIRAUnvf+2LZ0cKzuU8LjEIfiV8C7gsvOkeqHoOH492Pqit6MnCdaPsP/e0Gxyk3WXE0Qk8IT3LA1SwMz5AB9+e/nVkk/t+KMvqk11p3Gz2T1Iy4utQtLrZnRGbFw/mHc27n3KjQhgizN0RVDR3EFDlSw7PrRlMPCuuR618B/8HY8oI34nuPeHETKBPTE5lCZLmmqUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJA2CgQRgfqGf6dAbToOLo09G1NkQXNzw/UidDpj9D4=;
 b=JosBv2bsERmNA3nk9O8YWK/i3JnyO8r7GqmeY0ro3CPlF1iSTXcnbFqrV1DXI3q4amJL5XKJ85ywE/5kJY0MVIVgHglRiCgZwC67R+nBgNwzuRPmlqO1jF4cTr2fEmtNIiZkJDRc1/NijJ5+zXGi5fz6ZF4ps0GvKgaRzxXTfHs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5004.eurprd02.prod.outlook.com (2603:10a6:10:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 16:25:58 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 16:25:58 +0000
Subject: Re: [PATCH v1 4/9] iio: afe: rescale: add offset support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-5-liambeguin@gmail.com>
 <0769aaae-8925-d943-e57d-c787d560a8dc@axentia.se>
 <CBRGZCQWCG6S.676W3VCPMMUH@shaak>
 <01f8d320-05ae-1178-151a-d0d11a23bb55@axentia.se>
 <CBRIK3PI2AMD.3KUD7EI7NJ2EB@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ca30e3d2-7d9a-1c9d-9ae5-beefa2cd6492@axentia.se>
Date:   Mon, 31 May 2021 18:25:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <CBRIK3PI2AMD.3KUD7EI7NJ2EB@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR05CA0240.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::16) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR05CA0240.eurprd05.prod.outlook.com (2603:10a6:3:fb::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Mon, 31 May 2021 16:25:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063df627-2c81-4073-f522-08d92450c5da
X-MS-TrafficTypeDiagnostic: DB7PR02MB5004:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5004EA1D332365003F34649DBC3F9@DB7PR02MB5004.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22xMo9kf02FvemTZhgdM3lJzJ4fE/cfEnzMqor2VlXZ6BzBbmMAwqf4f3yBHSk7GATZ3OCYDVwYcBVX0xc6izDdfgR1hyNJ+tH3RS5v+Shz9OnCpSOgy2eOM1/4ueey5XUz6F9x5yYTbOTD547c7neFrUpHTMfBykFeUlDWSEeP9n63qktKj1JYumy/+vsv65NkCHbPF25JUGfmqfB/Q4F1qNRtV52FftuJ9xJ3MDGUrI13vUBniVrcZZGicjTDTRsZZHjrynXzM3HVKlE7167Uiz/axMbF35EA7SnsJYdHj1j2fgKixR75zdCTdw1KzUIuelOMGctnbEMggOvCmMuSCE8cByLahjndI3Untm1JikWj8CiwR5ut8gBONgl1sohGKo+0+ZiqCqrHbrqJBJeut9VdkX4kNxKEi8PHW49TQ5f6J8KNKHya7Mp95xc5WqrdqQyTOSTR36UYMgH/xNIxwJehPFfHy1jfEmnQiEfn/qh3gRCJf8BBcfv8DVnwYuydzJMLng0Zk19nUmkmi01ScwNMxTAWZPe0E4Q4Mwg+HR5sNnuPSatjheN4Jx7KgRGKfnhzJU+KlbgbiM1BGLiCgkAP1hfYsi/4OgV7jzLYak1yh3WCN00D1aUD1pZSy8Qpo/xcwAzSSCDXialRb2zBzmgU1ROV3ytTa6CaQQ8xWicnoFLD2RdeLoZfseOpj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39830400003)(136003)(366004)(66476007)(66946007)(86362001)(956004)(66556008)(83380400001)(53546011)(2616005)(8676002)(36756003)(31686004)(316002)(38100700002)(2906002)(4326008)(8936002)(16576012)(5660300002)(36916002)(186003)(16526019)(26005)(478600001)(6486002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmtCdXZWS3JsSXF3QlVyUXI1d3JHelN5NUJ5MVVHSWNRQlBLT200U1lWNUVn?=
 =?utf-8?B?U3lTcjdvN3U1RzdSdGcxQ0lJbFBUZVBLV2k4dTFXOWpvR1pLWE9UWmx0dFI5?=
 =?utf-8?B?YndZQnBQRUJocmRrRE90eFNGRVBtYTJxbko3Q3gzdVpUTTZQNmJabjh0V0hh?=
 =?utf-8?B?TEJxUmo0OG5iUGtFbWwveG1neGVSU2xsbGdLQmxmK2ZHV3NPb1JYS2pwNUpZ?=
 =?utf-8?B?WkJwZXVWZ3pSV29OT1pWdXJ6YXgrNDYrWE9pYyt3cFN2QkxNNzAyaWU2Sm5u?=
 =?utf-8?B?dnp6QTNRUWVjY3FnSGJMU3A4Z2ltcWkzWDZ3K2NLQ1VNcFFrazFBVTBwWis5?=
 =?utf-8?B?dEU4bXNPTFNZU0wrRWVzbFFBNGRyc2xxaDJZbGRsT3JmbW0yYTlVak1Ub2kx?=
 =?utf-8?B?ZjcyQXA0aWk1bDMxTzVxbjdYdlpsMy8wYUhjdEVwelNzZm15b29WQUU0eG1z?=
 =?utf-8?B?WEt1NVlMbS81VmlCaDQ3cDdsS3hRdFVyOTRsNm16R0xaZ0NhWFhvbm02bVhE?=
 =?utf-8?B?S1BVeG1UdWUydmVmMFhra3crQ3VnSDd4azdLanNTbzVqc2NBM1E0akthNDBP?=
 =?utf-8?B?bjlxMmtKQWM2VGx2dEFaeWZuSm9zNzU0RjNIQWpyeUlxNWhiZ0FXeW9CREVk?=
 =?utf-8?B?d2xkV0lPd1Y3Y0xJQTBNek1aS3dFTUViblhZMmErMnJTYU9zcU9adnhIZG9S?=
 =?utf-8?B?cGhDNXQwTGJ5aWFhYk1DSGJreks1MzlRUVdYelMxUjlnOXFUVVZFeWRNbUlP?=
 =?utf-8?B?NHNycDM0N2gzRmFnNzMrbUdwTXhxdXBSR0ZDOUE4OFVQZjVjQkpGSEN3NUZx?=
 =?utf-8?B?WFlKTlV1ekpER2xRV3Q3WGdhcldJMitWSjdHOFUxUUROaGVGQkJQdExwdmFQ?=
 =?utf-8?B?R0ZXYWJUankrZEE2U1RjaXpnRndFWlpiT1pVOC9qQVlUdGU5dkl1dmRQbFBi?=
 =?utf-8?B?Z3RacnpNZ2NHOUkrOGw3d3crNDE4KytNUGN0K3BWSUlCMHNmU0dBVFgxcUY1?=
 =?utf-8?B?cEJrMmZFM29XdnU0d2dxajlBVEl4aWx0NlViS2hGQk5LcVdySnlLM2dKR2hR?=
 =?utf-8?B?YUlLbWhKVkNhWXB1TWZKNndibGlydnRjTVlCQysrMktWdk4xTkN2TjZ0Zmhp?=
 =?utf-8?B?ek5DaXR5SGdTanNsQjdEamkzVTJsZWZDL09YMTd1M2hwMUg2WVdmZFcwY0Rt?=
 =?utf-8?B?V3A4SXhRYXI1YVhCNDc2UlhBR0JuWVlwYTh6bklMOXkxMzBRTzllalpncHBO?=
 =?utf-8?B?Mm1jRXVKMWdxQjRIb0hIOEJLaWFRVzJrUitqeWFUYVo0djBTRWh2VDFyakdJ?=
 =?utf-8?Q?TSHV6tolG+?=
X-MS-Exchange-AntiSpam-MessageData-1: nsgl15mz9oVZ4X8IKBBV4k91GSu2y71SrISLMOpLwGM8nDwDVSPbnAUe8rhZwincZlvKA5+/2dexjoAICLRTkZJp6K//D2xIgKeRGSlmRrP1IBJ/na02iwFTfvGBq5n7zEvpUy+TMi+Nmh5yBjzRrWymdGo5B2LdtuntoloCHlbPMDhn3j005+ktpyB5Ze0CKeOJfRurUXTdkqCBrVEGoCczwv7ulaidUvy99/tYLBIqp+m1RL3fQvM+hkVyBRnjEtglkN30BLAAerJ7p5KeEEepaa4h3QzSW585cseVbpSk974RSSWgGYEmXjj5MI4nHUKyHp/Ou8ihuxTgs3vB7teK
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 063df627-2c81-4073-f522-08d92450c5da
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 16:25:58.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctita+x9d/jZqjRwdDLVLmmhSIxkIAtuJITMARrnkeTAZmjLLIkNXiiJpyP9OIu5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5004
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-05-31 16:51, Liam Beguin wrote:
> On Mon May 31, 2021 at 10:08 AM EDT, Peter Rosin wrote:
>> On 2021-05-31 15:36, Liam Beguin wrote:
>>> Hi Peter,
>>>
>>> On Mon May 31, 2021 at 4:52 AM EDT, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> Thanks for the patch!
>>>>
>>>> On 2021-05-30 02:59, Liam Beguin wrote:
>>>>> From: Liam Beguin <lvb@xiphos.com>
>>>>>
>>>>> This is a preparatory change required for the addition of temperature
>>>>> sensing front ends.
>>>>
>>>> I think this is too simplistic. I think that if the upstream iio-dev has
>>>> an offset, it should be dealt with (i.e. be rescaled). The rescale
>>>> driver
>>>> cannot ignore such an upstream offset and then throw in some other
>>>> unrelated offset of its own. That would be thoroughly confusing.
>>>
>>> I'm not sure I fully understand. The upstream offset should be dealt
>>> with when calling iio_read_channel_processed().  That was my main
>>> motivation behind using the IIO core to get a processed value.
>>
>> You can rescale a channel with an offset, but without using processed
>> values. I.e. the upstream channel provides raw values, a scale and an
>> offset. The current rescale code ignores the upstream offset. I did not
>> need that when I created the driver, and at a glace it felt "difficult".
>> So I punted.
> 
> I understand what you meant now.
> 
> At first, I tried to apply the upstream offset from inside the rescaler.
> As you said it felt difficult and it felt like this must've been
> implemented somewhere else before.
> 
> After looking around, I noticed that the code to do that was already
> part of inkern.c and exposed through iio_read_channel_processed().
> If the upstream channel doesn't provide a processed value, the upstream
> offset and scale are automatically applied.
> 
> So with the changes in [3/9] the rescaler's raw value becomes the
> upstream channel's processed value.
> 
> This seems like an easier and probably cleaner way of adding offset
> support in the rescaler.
> 
> Does that make sense?

Yes, it does. Doing generic calculations like this efficiently with
integer math without losing precision is ... difficult.

I think that perhaps IF the upstream channel has an offset, the
rescaler could revert to always use the upstream processed channel in
preference of the raw channel. That would fix the missing support for
upstream offset and still not penalize the sweet case of no upstream
offset. Because the processed channel costs processing for each and
every sample and I think it should be avoided as much as possible.

Does that make sense?

Or are a bunch of drivers adding an explicit zero offset "just because"?
That would be a nuisance.

Cheers,
Peter
