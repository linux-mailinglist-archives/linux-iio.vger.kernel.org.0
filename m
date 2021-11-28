Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E446090D
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 19:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbhK1SuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 13:50:17 -0500
Received: from refb01.tmes.trendmicro.eu ([18.185.115.56]:55903 "EHLO
        refb01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbhK1SsQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 13:48:16 -0500
X-Greylist: delayed 1260 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2021 13:48:16 EST
Received: from 104.47.13.51_.trendmicro.com (unknown [172.21.19.72])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 0B364100741FD
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 18:24:01 +0000 (UTC)
Received: from 104.47.13.51_.trendmicro.com (unknown [172.21.182.53])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id A1529100004F3;
        Sun, 28 Nov 2021 18:23:59 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1638123839.152000
X-TM-MAIL-UUID: 46524abe-b797-4dff-ae14-1f0e3a3cc8ac
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.51])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 256AB10000303;
        Sun, 28 Nov 2021 18:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eREKJURSv5zZkKWALAeoMTmgob8mc2HmrC6Dz/ATzoUOk7U8lPf3Fl+AjIWp3WmyErBjipyfNbA8R45hpYm6HW3UHcSuwNQ4GfZ230dOxuEi+JCOjrnrG7lcxmgkY8RCMjwBOOC22LbPkOOW8y8EeIi/eCboRRP30IcSRTWwH0aoKcsHQUYpWn5mUvDwP+nRU8HFgVq/5nfvZwOepBM00bahvCGUpClqaFjehXlF06LuBcXKKjNLTadM8czBOckID2NzipiTzm4W1vAun4NCR4pI8HnUAF6LTQkhYCdWssdIrR6OSHEvlNN5daPfgndsVkM+2NSKX17hOWYJ8Pe6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNij5/mhQCD8IzsZ7ec4vr58eGUv/jC9ZCTWkIKfHkw=;
 b=fbmXt9bqhchNsCeTKlddxWStS4iv3AxkNzSBFicvJvVFdc6BCU4R5JGfbTus7bZ3qalvYj5TnCWTfWHtOCI0Kn8uw6RxfhgEtqsagVZI7ufinsGYtS0w/Bc2LJJvoC75yxoEBl08Y94jRuPQ4+0VKyBxp1e6kREWBg4Yo+3qUottqbrzr+MjAGVOI9j5FUMNYCv/d3jXofxzmidkSlXxpW93QPnr7M8ayCYMgJhs5Wx6qHeqKm0XKeupbyrXwR8G2sOgwNS0Ug62lDAtPTHQbJGLTo5I234njyVYT1WHPv551BbHHCh3g5We33J6fU5X07HlJO9oPsKmQMb5RMLDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <7340aacf-bd18-dfaa-a422-490b0a701020@opensynergy.com>
Date:   Sun, 28 Nov 2021 20:23:55 +0200
Subject: Re: [PATCH v1 1/2] iio: test: Add check against NULL for buffer in
 tests.
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     jbhayana@google.com, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vasyl.Vavrychuk@opensynergy.com
References: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
 <20211105100501.1904-2-andriy.tryshnivskyy@opensynergy.com>
 <CAHp75Ve7AoPaPUv699kEu3jMGRWTysLd932NZCfi8cjwuDmcOw@mail.gmail.com>
 <20211113165214.1e84a925@jic23-huawei> <20211127185300.23b4f0df@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211127185300.23b4f0df@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR04CA0019.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::29) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4775a243-8153-4fe7-2b11-08d9b29c3e08
X-MS-TrafficTypeDiagnostic: AM6PR04MB4822:
X-Microsoft-Antispam-PRVS: <AM6PR04MB48220385D83EC386F4A9DD32E6659@AM6PR04MB4822.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ikhNiSV8BNATv6ULOR3K17PvOO6bMpZtZNcl9nVJTInGAQPhnAOtTFOxwx/l9Ncy7Dj8esKfKwRF+nmpajCX0zv2f3qpVVk4fvCwmECam6juFcwdKa8sqrznBQV4R6vbAQzkalBZD5jZndSNZn0TnOuzMmXLy/lwyJf3PTzrKzfTiPNfnIcbUpxcVGSoYl/+5OLPkXQbG/LWjVq1R+7XTtGGp6WXJpteZZx9u/whGtP2hWx0mTtENu+t1H3s5V1RlUXXIxJfDmgdPqGjP35q4zWiqtHg4l+CF0jxUGMZ2dSm7jwApCDKDmxZx240xSmAEbRM6V8Fm1eu1nEwrn5X+nl0lP5+FnzFH64+/jGuBMyLcHZASjn8b2QAG8ipU9IvoXWho4h2kDncJ2pX07FfDUzSWqFCe5YxZhE9WS7yS5XS7WT04EYDowpZkKh4PL7SwStWTM8FB+sLQNnlcYTXPlI7ZsF5/QkPiA64yuq2AX7T16Tv3g1A79Q7AjYGpIDRhzLh6DLVx3FNuILGxxvsRTTlA46cAddC3mpdxjEco0gw3s0B9Z8wHXJF7ujKxzPaKL5hA3b6lGt3ZjtCF6THhOWYJ+TUNfsXcHGXUuYM2ZZZZ9pJ16Ha4yW88j14VbFCSD3Zl/uHag04KStmIBVrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39830400003)(366004)(396003)(31696002)(2616005)(107886003)(55236004)(30864003)(53546011)(8936002)(4326008)(110136005)(44832011)(54906003)(2906002)(316002)(42186006)(38100700002)(508600001)(5660300002)(83380400001)(26005)(186003)(36756003)(31686004)(86362001)(8676002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVhIdTFtT2I5dVQzSzRBYzV6VGM4RU9HNEpUcEIrNS92NFR6cVBzcGlxVk9o?=
 =?utf-8?B?a0Nsc29DZVQyb3JUalZTeFdGWTlLdlk3aUF2QW8rWkk1U1VieXpvY2hUSVJE?=
 =?utf-8?B?a2JDcVVWMkJ1RkQ5ZFkvWVhnd1liSVJtdVZvSXgrcCtIVmo4dytyM0p2d3h1?=
 =?utf-8?B?VnJNdi9DMTRmc21yZGdVeW1UaEtzVmt2YmFPcGFDamUxV3hpbllhV2hHVVVO?=
 =?utf-8?B?WU1DTjJYV0owUndVRkoyUWhKM3NtTHZNYlE2ZEQ1YWducnlocUd2V2FIWUFP?=
 =?utf-8?B?QTh1cTh5SXFsWE4vYi9UN2FmOU1DdEhvWnV6VXA2RXJQbmZpNEpaeUdCN1lQ?=
 =?utf-8?B?b3ExYWVyM0psTjdNck1jbDdaMnpkK3lRUktCSzR6VXJXZWlRNkl4QjFlUE1O?=
 =?utf-8?B?enJTN0JGdzlnL1FHcXd4N3laNWtxcHJ2WEZBQ3drTkk5SXBZUG02MlBySVVy?=
 =?utf-8?B?b3NyQ0xxWER1b0dSakN5eGFINE1YbUt4OVFhMGpCYWpScFVFVVNtYVFnZ2tR?=
 =?utf-8?B?NnJtdGVUWWwwcnlKV0VMakdtNE5EZE9VWWowU3pESjk1SklRVWNxcEpWd2Ey?=
 =?utf-8?B?c3RTaGcza3kwRXo4WHdOZDI1SnhNdU1tNjAzN21wbnJvV3M1WWxRdWJFcTFz?=
 =?utf-8?B?dUJSK0hxY01rOEl3NEF2VWx4QUdueFhKUlFCOXRtSklUdXArMU9OSDJHU3Z4?=
 =?utf-8?B?TVN1ODFQNTZiUXdtck5XKzdocUEyU0IrMEJSU3lJYS85TGdhUXgyV0p1SUxK?=
 =?utf-8?B?Y0xTVGZSR0NNbGZsWnpvSExwTEcybm5Ubk1GV05ubExVRlVBSG1CU0hjbTk0?=
 =?utf-8?B?bHpWb2phS0Fvc0REK1JpZUt5WU84RUlnUTFyVEx4djRBMnhSaUh1WWxTS2gz?=
 =?utf-8?B?Y1NZcjlLOFNLUDJRQnZMNjVUelFOS3BpaXp6NmN4bTB2TkZ1a3AxN1laTW5q?=
 =?utf-8?B?d3F6bU81d1NtbTRralpXdzRvMUVKVkhmMEJOVnRrVDJNZ2VwVmNwTU1YWlhi?=
 =?utf-8?B?b3ZIQ1lCd0M4eSs0QkZnWU8ybGxlV3RSYVRxYUMvbXNRNG5XOFBUalVJdXVY?=
 =?utf-8?B?NXE0elUwdnhoMWNzSlp6R3UrS3FpNjBWRDlQai9lYlg5anJNdHZ2YVhwNVl5?=
 =?utf-8?B?WVdxb0RaSzJrdEtVVXZOVXNuVG1obVpLOG9sR29jcGo1b0RFSytZVCt2eEpW?=
 =?utf-8?B?a1lXdy9ZaXRPS084WGtXaXk2SEQzQWVaZGVlNGpjaUhZZHlOQ091TmZmSmZp?=
 =?utf-8?B?RmpjSElPc2FZa3o1ZnZtclhmbUZSd1ltNTUwdEVRaFZBT0hiUE5waEpGSjUy?=
 =?utf-8?B?WHFXRVE0TVQxazh0a0oyWVc1ZmRVNTlpVDdHdnBKVFlHQVZaQ1p6ckhOdGtW?=
 =?utf-8?B?UDhveDExRFZCd1VIOXNCMmhMTkQvb3VpeUZ5N3hoa3N1UURsVzFsMUxuaHVr?=
 =?utf-8?B?blcrano2Z2UzR2FwbWl3NVNrUTVia0lueGZmaitJUFEzUGQ1V0REWEtMa2N5?=
 =?utf-8?B?YmQydTVCMlJacGZCbnN1eDBHREZVZ0JXTXNESUJDRG1XY0VmSThCRUVOZ255?=
 =?utf-8?B?ZFhrTHBEOXhlVmd2MXdSd0VxZ0FBOGg4aTMvWk5FMlpacWo1UzhkT0xrM093?=
 =?utf-8?B?Smo3VjFveWNjTzdUdFdjdkJTT3FGc0VrRlI5WFZ1YjY1aU5GT3pRcThyZ2t4?=
 =?utf-8?B?WmIrdjk2Z01POFlJOVlDRUs0ekNodEY0aVp3dEJXSUE0OHVwcVBQbjlmbnZn?=
 =?utf-8?B?eUpqTXdqSzJ5V0xnb1VCRjVMaVhDenA1MUZOdDZaSDlFakkxbkhNTGlEUERN?=
 =?utf-8?B?M29pTWVGNjB4ejQzTHZlTGNWMDk3QWgvR3NZRnhBVktxNWpXU3hwVitFNzBl?=
 =?utf-8?B?dksxc29YNGZXRDc3aXVxamZvUGl0d0s1ZExRU0J4ayt2c096WW9wOWl0YlJz?=
 =?utf-8?B?WjdpQmExaVR0amRsZDNybWNzalFhdzFZd2xsVzJWdFhLNjM2OU5aNzlOOVA5?=
 =?utf-8?B?NzBsN0xmSmxBRW9TWWNGbXRKZTlaNVFZdzgrNXpTclZjejR6Q3B0Wk53dndQ?=
 =?utf-8?B?aEtDT1dpUmdkYU9yZDFBUEpNUUdrUGE4Vjc4RU1GLzRCSWhCYTc3eUFJdzVl?=
 =?utf-8?B?em1mSDJwUzhVNWlVb2J2cG5MVDlXdlFpczI3bVk2YmpXdnUzUHkrKzJwS2d1?=
 =?utf-8?Q?yhU2XMidOyUNWOpx4BmuQYw=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4775a243-8153-4fe7-2b11-08d9b29c3e08
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 18:23:57.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to5PHMnlpqqKxuDjzs31/zGpWruHsRXnmxaY8YaeLgwlfFAw1X+BBPE1Vk0e96tNO9pa76tYp0bkSApKqoJiYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4822
X-TM-AS-ERS: 104.47.13.51-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26558.002
X-TMASE-Result: 10--13.346600-4.000000
X-TMASE-MatchedRID: xcONGPdDH5q8rRvefcjeTQEaayJtYZNt69aS+7/zbj9lEv6AItKWF1yU
        mJaR65D9ras+aOkF64zpOrzgQyHFOUpL4yZw08wqJdOcBmSEp+UV8rV6fVLsBFymazekyFPRNnF
        zONef5K74MbidcYpVuAvDMt4/Hk5hBAF1SBaD5qRusn2BWc6xncnlJe2gk8vIe3hrNe/ZbVkzUZ
        pf0G/nRxF0RFmTckrZWN++zBzuy0XszJZKcDFUUqJVTu7sjgg1DfWsIDrgpTBTbQ95zRbWVlEtM
        RGFGDWDi1HTBiM+pvTFtYuDam42i0fX0Ayg3UN3Jtgtn0dnvgeRgLeuORRdEhzTkVRa1gtOj+Pi
        AoOhWpmt2gtuWr1Lmtr+D80ZNbcyc3eYMKyaPyTuykw7cfAoIAvIQ54tVezoVptCZRwLvQH+zZm
        /F/psjegc6mX1lwNHkZOl7WKIImrvXOvQVlExsFZ0V5tYhzdWxEHRux+uk8h+ICquNi0WJA5ccm
        UtjtN3iFDAsA8A2qV4jvP90GjU0Zb4gd/PHgTPftwZ3X11IV0=
X-TMASE-XGENCLOUD: bd285c8e-cd71-4317-b43f-fb3559998778-0-0-200-0
X-TM-Deliver-Signature: F23F9371C093381E1CEEEA25345A6484
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1638123839;
        bh=F0DrxsSbQVuAng3l5sr3jA6+uRfFKrpnI7pknNDvqsY=; l=11431;
        h=Date:To:From;
        b=Vf2RQw6jqKdKOycrgy5EHZKODKXSgowGi7wxce/GN0wcOuEx1mSHxdEYfL66OAocp
         noyuKJ+RxKTCuKoF+SBT9UnX0NKl7xw9yb/QKAMBcrtVf5DdrwrgpNV0j/uqnMxOGN
         wP3g4KsUPJTR7K8o7lDANuZCuhyF0zBKPiHdLHxSlq4W99tLeWmBdoyECx9XYcDy6x
         2KCQFhLUkrTi/5T9fwO5tdvxT9jqJILntRLByPcpR72Jftth1Xmn8t3B9dT2wh1mRh
         w9BmU8ZEOPWK58C7Utoy3+/fSvl+gPlRHntKW4Cd0xK5G2lI26UCaWnsyiG7VU8D9a
         YcI7lhblc+4yA==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you very much!

Best regards,
Andriy

On 27.11.21 20:53, Jonathan Cameron wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Sat, 13 Nov 2021 16:52:14 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Fri, 5 Nov 2021 12:16:40 +0200
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>>> On Fri, Nov 5, 2021 at 12:05 PM Andriy Tryshnivskyy
>>> <andriy.tryshnivskyy@opensynergy.com> wrote:
>>>> Add KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf) for every test.
>>>> Also use ARRAY_SIZE(values) where it is possible.
>>> Strictly speaking 'also' and similar in the commit message means you
>>> have to split. Here are two patches in one. But these are test cases
>>> and I don't care so much about the rules. Up to maintainers.
>> Ideally I'd agree, but sometimes it's just not worth wasting anyones time
>> if both parts are mechanical as here.
>>
>> Given this is Lars' code I'll leave a bit longer for him to give any tags
>> he wishes before picking it up.
>>
>> Give me a poke if I seem to have lost it in a few weeks.  In theory I
>> shouldn't given I'm using patchwork as a backup tracker these days, but
>> meh - I've lost series before!
> Enough time I think. Applied to the togreg branch of iio.git and pushed out
> as testing for 0-day to have a quick sanity check.  I'll push it out so
> linux-next picks it up later in the week.
>
> Thanks,
>
> Jonathan
>
>> Thanks,
>>
>> Jonathan
>>
>>>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
>>>> ---
>>>>   drivers/iio/test/iio-test-format.c | 69 ++++++++++++++++++------------
>>>>   1 file changed, 42 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
>>>> index f1e951eddb43..b746d00bc0ea 100644
>>>> --- a/drivers/iio/test/iio-test-format.c
>>>> +++ b/drivers/iio/test/iio-test-format.c
>>>> @@ -14,10 +14,13 @@
>>>>
>>>>   static void iio_test_iio_format_value_integer(struct kunit *test)
>>>>   {
>>>> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>> +       char *buf;
>>>>          int val;
>>>>          int ret;
>>>>
>>>> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>>>> +
>>>>          val = 42;
>>>>          ret = iio_format_value(buf, IIO_VAL_INT, 1, &val);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "42\n");
>>>> @@ -41,142 +44,154 @@ static void iio_test_iio_format_value_integer(struct kunit *test)
>>>>
>>>>   static void iio_test_iio_format_value_fixedpoint(struct kunit *test)
>>>>   {
>>>> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>>          int values[2];
>>>> +       char *buf;
>>>>          int ret;
>>>>
>>>> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>>>> +
>>>>          /* positive >= 1 */
>>>>          values[0] = 1;
>>>>          values[1] = 10;
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000010 dB\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1.000000010\n");
>>>>
>>>>          /* positive < 1 */
>>>>          values[0] = 0;
>>>>          values[1] = 12;
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000012 dB\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000012\n");
>>>>
>>>>          /* negative <= -1 */
>>>>          values[0] = -1;
>>>>          values[1] = 10;
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000010 dB\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1.000000010\n");
>>>>
>>>>          /* negative > -1 */
>>>>          values[0] = 0;
>>>>          values[1] = -123;
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO_DB, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000123 dB\n");
>>>>
>>>> -       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_INT_PLUS_NANO, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000123\n");
>>>>   }
>>>>
>>>>   static void iio_test_iio_format_value_fractional(struct kunit *test)
>>>>   {
>>>> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>>          int values[2];
>>>> +       char *buf;
>>>>          int ret;
>>>>
>>>> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>>>> +
>>>>          /* positive < 1 */
>>>>          values[0] = 1;
>>>>          values[1] = 10;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.100000000\n");
>>>>
>>>>          /* positive >= 1 */
>>>>          values[0] = 100;
>>>>          values[1] = 3;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "33.333333333\n");
>>>>
>>>>          /* negative > -1 */
>>>>          values[0] = -1;
>>>>          values[1] = 1000000000;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.000000001\n");
>>>>
>>>>          /* negative <= -1 */
>>>>          values[0] = -200;
>>>>          values[1] = 3;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-66.666666666\n");
>>>>
>>>>          /* Zero */
>>>>          values[0] = 0;
>>>>          values[1] = -10;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
>>>>   }
>>>>
>>>>   static void iio_test_iio_format_value_fractional_log2(struct kunit *test)
>>>>   {
>>>> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>>          int values[2];
>>>> +       char *buf;
>>>>          int ret;
>>>>
>>>> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>>>> +
>>>>          /* positive < 1 */
>>>>          values[0] = 123;
>>>>          values[1] = 10;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.120117187\n");
>>>>
>>>>          /* positive >= 1 */
>>>>          values[0] = 1234567;
>>>>          values[1] = 10;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1205.631835937\n");
>>>>
>>>>          /* negative > -1 */
>>>>          values[0] = -123;
>>>>          values[1] = 10;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-0.120117187\n");
>>>>
>>>>          /* negative <= -1 */
>>>>          values[0] = -1234567;
>>>>          values[1] = 10;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-1205.631835937\n");
>>>>
>>>>          /* Zero */
>>>>          values[0] = 0;
>>>>          values[1] = 10;
>>>> -       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, 2, values);
>>>> +       ret = iio_format_value(buf, IIO_VAL_FRACTIONAL_LOG2, ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0.000000000\n");
>>>>   }
>>>>
>>>>   static void iio_test_iio_format_value_multiple(struct kunit *test)
>>>>   {
>>>> -       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>>          int values[] = {1, -2, 3, -4, 5};
>>>> +       char *buf;
>>>>          int ret;
>>>>
>>>> +       buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>>> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>>>> +
>>>>          ret = iio_format_value(buf, IIO_VAL_INT_MULTIPLE,
>>>>                                 ARRAY_SIZE(values), values);
>>>>          IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
>>>> --
>>>> 2.17.1
>>>>
>>>
>
