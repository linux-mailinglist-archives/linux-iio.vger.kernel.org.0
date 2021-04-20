Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94B3657A6
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 13:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhDTLgr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 07:36:47 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:18150
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230290AbhDTLgr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Apr 2021 07:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOKkyJ2pIhc2hFeESHUnhKaON7y+Zsxpd7B1uT9iiDoAXbDoAHj7RdbwayU+0iw50NehtJ9gqY/oMc1za+F/wT0I59L1jmpPwYoYnBNUiLQXCAq8WhGghMjvFWOfDh8N1fPfPLuMxLXJz0U7DkBAo0wOMhdEnONlOZo0P7EDr5sA6adwja/Ku4Xhu56gunu2e3luVfmUv7LlET7ITrJ16m5ZpkgzruXpMbAAC229RP5srkynTOQJ3VRQOuHn672DfyCsWxshJLyD4Hr/z9tIfXqQjMSfrI2eqjiM0/h0gsdKd9zfm3aDPEODK/vE7KHKHWwvcZHvfI3JjCMA05hbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiO3Twyr49ldRYRVvhKkewlCHdxJCn/yu1wAYjKB3wE=;
 b=VnPIWIGnJarzxCAykrugTdHpmv1rmpCPbx6RJCxNx8p1WlbAvRuiKbWjErkPUZ66ujDkiVkGJEdoj26jzslI4atCeZe1Rz2PUGboCQRzEqlochmV5NwLIRL4nKymBr6kKKs++KBtSaC1Yu2MA4xWnBR4z2e73j8wKxcWLgcZsefZ2ho03SYNnQDXFxNM+Dihy1mpj+MXB9XLTr5BmencYg93hwOpDPrca3oj6/rcC+eh3nCsEzPrc6JY2EwOvV1UdkQSzUvvWwRT+jN8/GCMY4BcpYAflHBGqf5XkEz0TvFrd+ndck2DF3HDRf4eaomtgEV9YGbXHBKBT5u4rRXCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiO3Twyr49ldRYRVvhKkewlCHdxJCn/yu1wAYjKB3wE=;
 b=iiUHP97oQDCaiSfQsXYLWl3QxMR1sz7rwqqiVkp/Ar/fn1CiY8OvmCqb8VD25yN35KaQn+aNgCIPrCH+0u3pT2ymdloD0Bnp4//j6mqqxXXtytHuuedt9mhczUzOcl28dQiD+e+NLG/59NCWFeeIJHRXe5uK3Y5mrjsXxIUVknNXFA34HNrv+mT+WEnPWw7VVFDmqvXBGIxd8AB3Fb4l17cJJebFNhKsosN5JyMIGJY0vPsFnag8lgEX36DVqfU/hzAYBOBr/ohZVuDiuvYdtnav10++1/1ua2p3PPoTVMDIceqYyn2YMr+u2gBnJBGEOSBGZofntOLAKcL2QCmIdA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VE1PR06MB6960.eurprd06.prod.outlook.com
 (2603:10a6:800:1a3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Tue, 20 Apr
 2021 11:36:13 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 11:36:13 +0000
Subject: Re: [PATCH v3 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210419132159.4450-1-tomas.melin@vaisala.com>
 <20210419132159.4450-3-tomas.melin@vaisala.com>
 <CAHp75VdApCk_Ydt2W_WWJ_wme4d1ocrrnvo+TjZcQ62RG6uOUA@mail.gmail.com>
 <bea4dc56-b860-431c-a820-a482ce87743c@vaisala.com>
 <CAHp75VfM3xToHJ+J095pkoLz1YD5qq-MaZoN3Log+bj6ktWFkQ@mail.gmail.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <b9381886-35a8-8e5d-02b9-5d229439d11e@vaisala.com>
Date:   Tue, 20 Apr 2021 14:36:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CAHp75VfM3xToHJ+J095pkoLz1YD5qq-MaZoN3Log+bj6ktWFkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::25)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.132] (85.156.166.106) by HE1P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 11:36:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b5048e6-b97e-4268-9e4f-08d903f080a2
X-MS-TrafficTypeDiagnostic: VE1PR06MB6960:
X-Microsoft-Antispam-PRVS: <VE1PR06MB6960FD8A55CAE4476505A457FD489@VE1PR06MB6960.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGbdbWFu/GH6HQoWDmeRkAotUON8Y/TvMcZf00Skj06dfW11yQI75Tfmb7nHVs93nMEVaDnDS5f189qQL36SFTFVBmVZtZJl6Pf8VVIDHks0Kdom7ELJhYCazT4IfhSFWWIKwZdkb4g4Uviz2B9ftOpei9gn55ceRvIiEztTWE/Gyk3+QNqcXvrLOXkVuWXsL3ZgcIibv7fgFm7v6XBpl+buXcegItMzAOW3B41MW7zbcvnGUSDy65vCqog6qtb4bMlyMlTErQGD8bv9iW/ARUCnjQroFMy+jfMv0/DzbV7MLrgUSBZZcISBK7mhYfPGW1s1ipwP1upkobt/zAL66E5L3SmKHM/5CpjR2wHy3KdtTrwrr+4g9lnN3doNvKxj3lU7fGP+sY8Zl4ayvnqGgEHvX8GkZ7jh9ik/CzChIhiXocqQsxe6bfxRxeD85UHVkb7GKjYx6crb0XiV0gzAgD3YHIzfurqimsEBPSiQIldY8ABXPR+ycwcyCzJp4ndVsEdouRQAKCpkWE91u3PZV+7Icld5A2L4Ul4aTuJTZtF766ZL4+SqH00g8AlS+W9STHRFwv439N+6BNfUECqTlYUj5IjEJDMCyU1TYDq84k3tMPU4fma0MAaPftJovIOwlEN+H4JtXKdbSnCEKmcAVfk/mFLimF6YubobAjTiyR7aznWNlNCai8DspgH/LMG1XJvhiG7cnZEuVpgth524SSepmUDiXYn+KHWz9b5k8TU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(38350700002)(83380400001)(498600001)(86362001)(52116002)(8676002)(8936002)(31696002)(31686004)(6486002)(16526019)(66556008)(66476007)(53546011)(66946007)(5660300002)(956004)(4326008)(2906002)(6916009)(36756003)(44832011)(26005)(2616005)(16576012)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZVdxOEJ1QXo5MkpUbW5OUU50SUtlWE5HcHcyZnVSM1UyS25VVFYrbG0vaHIw?=
 =?utf-8?B?REhOUW5VdGJmU25ITk1iUjV6YW9ZYmhZOEdoVW9RMlQzN1pZWVk5L3gvUU5x?=
 =?utf-8?B?ZHJrckhSV0FIQmpMUWtSdDZlVUJ2RjlaK2tndUxGQWloenNTcHlaL1B6cEtL?=
 =?utf-8?B?aGU1MlB0dmxIQzJCT1JFeVByQks4anVyMzQrZnJBTFdIdkF0c2JhV2ZIcHh5?=
 =?utf-8?B?MFN0Y1JaSTV1L2c0ZlVlMHI0MDNRMmFjUElxWlBKRWNib3pxM0sydzEwNnV6?=
 =?utf-8?B?anBuL3dWVGg2ZFlBZnhMQ01VK3R5OVFuWTBWWTByNjQyYUQ3Q2YyeHB1eEph?=
 =?utf-8?B?ZjRESjJwS1BBUmxFOXo1b1BLOHJzcElBY2VmWHE2MVo3VXFVeEQ2RVFlZkdE?=
 =?utf-8?B?UlhUOHY2dVlDajE5S29ZSzYyYUxrMDBQa2JBa2lLZVBHRnRtendCSG1oU01W?=
 =?utf-8?B?bjZYZUYxQnJKK1lJZFlFc2I1TDFNZDh3bDBhcmk0cWUxaWZJMU4vSytFQWVL?=
 =?utf-8?B?NUJCdG1reE1DQVU1T1I3SkhyUXozby9PTlE5WFNRNXpaMThwWWswK1BxaFJp?=
 =?utf-8?B?bFl0UFBTV3hnN2RpeUxvUHZ5bGFycnk3cXJ2bEpkSUVKR1lYYkpjcHpONSta?=
 =?utf-8?B?aVhWaDN0aloveWNsTlkwQ0ZqaHBnVjY4Mm1NSmk1dURXWmFSYlRwRUN0bmRE?=
 =?utf-8?B?TEovdk9wZlYzVU9sTzFTNnowRE8zUVNYY0l2dlVjTGZLNnRkeTBmU0FLVzlw?=
 =?utf-8?B?MlFlM00xTm44cGI4Mm0rNlhVSFFiaFROZ3NsYk8yaEl4aTVFTXkwTFBkK1FX?=
 =?utf-8?B?WXNpaVYrRkNETzRYNmFURTVKUWQrb2JvM1MxcFlLWnJXMmw5QnJDdlk4VGNr?=
 =?utf-8?B?RkhVSmRXOWR6bmJ0TDExcUJkd0Z4V082ZDlUYUlaM3M0aVdhNklpbVRrMnlx?=
 =?utf-8?B?TlBENm5Qd0JqdFpkeGwrOUVkYXozd3R1NkJHRS9kVVNQTXY0MktXQzkvWUlv?=
 =?utf-8?B?RTJFRnVIdlZ4dXlGQlp3UXJVbkw5NHZaYWJsQk1uVWY1TDdZWUIyL2V4ZTRq?=
 =?utf-8?B?c1dmQWxHenltR1BvR3dWRGh2a0kzdUx1cTVTNW8yb0dxbWZHRkxLWTBFVFBU?=
 =?utf-8?B?STM5V1ZOd3VnU0JTdFJ0aUM3ZVlzTHJYRC9pYVRXcTM1bzFNMWNCNjhVWUxr?=
 =?utf-8?B?WDhibzM0Y05YU1JkUnZwK3VVa1FjZHRtaUgzTUpqMTJTM0NuQi9wZHZHcU1t?=
 =?utf-8?B?Z0FvM0Z2REhXbGI5a0lNTXVUSFVPb0psdDNYVC8ycUpveHhkeElaNyt0dFB2?=
 =?utf-8?B?NEFQTVlFTzZxQWt6ZTU4Lzd3bzJGU3hobG5VcXAvYUJ5bHV3a1lMNlpDVzBU?=
 =?utf-8?B?TWZIZlhtUDZsS2hnOW93U2h4UkNHdDVoYUZOZjhIV2l2SmNmci8xVkp2bkk2?=
 =?utf-8?B?dTJyaUJoQ0FkU1NVUXV5SUFwTmtqL3M5ZVBaRzY3eE5PeDdlS0FFaDVFUVln?=
 =?utf-8?B?UFFSRnZpMGFlV2MwQzRHNHpqRFdySDVSdlJiYXJqemNrT3RhUTdUTG1QU0lH?=
 =?utf-8?B?U2xUMEhBa3ErY1BYZVVpQndtNFpGQWluSml4eFdySzBaa0lURHBIM2RMdGJH?=
 =?utf-8?B?ZnVCdW5uK0JBMnN1ZUFqcFJJWnJYeFNaQlVMWlNRWFpTQ1RNMGRHOUtteDVk?=
 =?utf-8?B?czFDdlBtVVVuaWVxMUorR2NSMjE3UjRmRkVjNWEwRkRFYSszL3R1UlNJRURt?=
 =?utf-8?Q?wLLh9kZocLzcOd8si9234PkyMlsSvYuEeEtgTvT?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5048e6-b97e-4268-9e4f-08d903f080a2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 11:36:13.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEV32ejwy1IRff5q0bYe+qQ8zkS2mlxMAUA1NLstBg8yMaSzMphgYHA43tHOR262xuN92aW9wjnEYOzuKk9BfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6960
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 4/20/21 1:47 PM, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 11:50 AM Tomas Melin <tomas.melin@vaisala.com> wrote:
>
>>>> +       sca_data->txbuf[0] = 0x0 | (SCA3300_REG_STATUS << 2);
>>> Seems you ignored my comment. What is this 0x0? What is the meaning of it?
>>> Same for all the rest magic numbers in the code.
>> Sorry, not ignored but will remove this redundant 0x0 for next round.
> Maybe it's not redundant after all (I noticed other magic numbers in
> the same position)? Please, comment your intention case-by-case.

0x0 is for read operation, but since it's just or'd, end result should

be the same. It was there in v1 for clarity (also #defined). Basically

thinking perhaps it's cleaner to just leave it out.

Other magics should be cleaned up now.


> ...
>
>>>> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
>>>> +                        indio_dev->masklength) {
>>>> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
>>>> +                                      &val);
>>>> +               if (ret) {
>>>> +                       dev_err(&data->spi->dev,
>>>> +                               "failed to read register, error: %d\n", ret);
>>>> +                       goto out;
>>> Does it mean interrupt is handled in this case?
>>> Perhaps a comment why it's okay to consider so?
>> IRQ_HANDLED seemed more correct than IRQ_NONE.
> Why? Care to explain?

Thinking that IRQ was for the device and it was indeed handled. There 
were errors when handling

it, but it was handled as much as possible.

>
>>   Or did You have some
>> other option in mind?
>>
>> How about something like:
>>
>>       /* handled with errors */
> But what if this is the very first interrupt (bit in the loop) that
> failed? What about the rest?

Aah, right. Other option could be to simply continue loop and set 'val' 
to e.g. 0 for

readings with errors. But perhaps it is after all better to bail out, 
and only for cases

when _all_ data is reliable, it is pushed to buffers(?)

Comes to mind that perhaps better to have error message in this irq 
handler as

dev_err_ratelimited(), to avoid possible flooding.


So to conclude, proposing:

*change to dev_err_ratelimited()

* comment goto:

     /* handled, but bailing out this round due to errors */


Would this be OK?

Thanks,

Tomas




>
>>       goto out;
>>
>>>> +               }
>>>> +               data->scan.channels[i++] = val;
>>>> +       }
