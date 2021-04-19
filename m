Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A995364206
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbhDSMt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 08:49:27 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:19460
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239248AbhDSMt1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Apr 2021 08:49:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxFQpuiUOA4FPL2UG6KXTjveQoqaFilbUh35rI6dVNlVyzoN61GSXKGKbwxEFW4FR7AZR9HVIA5f2PgnOb1pJCmfbSk2e/I7McSkeYT93vAlLP+fMKsttBNPg9kYU7zYWmjCWwfyhiU4Ineg9qmgek8Solr1Y3QBGY3aLB1QjXcD6N5TFtnVxu0QEvlsdlKAatbMEaABRXBNnAdl6Wv36hXCv8gS9csvCfUvgiOF2LrY/I8gtT5AUsb+ibDFfSVNKRLDrOKM5VMOmp+j4G+fRV2wS7A8luy0C0XYvKht1JiOEde5NIL3Koj+f6hkIDmVJNyBginsw7BS2uwmM3h7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROKjHgEUlusy+VMuf4laLTCubCY9F338iXsMTzguZXI=;
 b=ntbenZCciT34bBiTekK62GvBGCHxyTlc81FdW6Z2z/eXaPH5++QbtNQamvEvOfuwqj4xfzJ7jUicUv8ab2Y6p0PvqoeJh2mX5968oLinPI5ry9ri7UaT8lOn83CHz7pM/KGDEziXvjtAU0/33yzsA4Za9t5Fd2xX0BkQds96nHYcvPbcQAPjgzRjfCV+7RhuaUvkXiko4yQ8AnCFDeGL8wo4InyuGawxpsMQi53k9H5wzVOKC906/pHDuoNFGTbaeOoqFJ5VvxQYCBsKZhngZkuND0leKb4Yh1hBIU7y5l1tyeGQbVjeooWj/a6yFkQWQx3fYbfIplyiQY9aVv+0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROKjHgEUlusy+VMuf4laLTCubCY9F338iXsMTzguZXI=;
 b=CDBvAPW6BYyU75dzsGU1/xX4Dx6mBpsSJNweE2DUGNmRFuUPD3V+Smh6DCEYcnQnj6YXulluMBPjB3dTn28NrjG+WbP6A/v1Ht6ljvUQgrvi7zO6q/VXjJvKFRICNfwNqAazHWPx5G0Sn37/mTbNx3kS+StIIyxlAzFDBwBJoWenmsJRZdC4aSxNTRkkjutbRVfcViQzaq7V03GvyF+lg0QeWelHFconruSv0EUbZsv+hkO38JxXK64RoO28nTGcl3XK4FzjxxME7yAslPXyyNVIoLqcCmPuZskRfCkRQ8GmALdRQbaNlghWyQIUsEp7TIg+orVV398iumc0tr46Gg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VE1PR06MB6893.eurprd06.prod.outlook.com
 (2603:10a6:800:1a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 12:48:54 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 12:48:54 +0000
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210416134546.38475-1-tomas.melin@vaisala.com>
 <20210416134546.38475-3-tomas.melin@vaisala.com>
 <CAHp75VcibWup79np=xeQpO2z+OGCFXPhL6vWL6aWRZ+G8+djwQ@mail.gmail.com>
 <91ea3aba-854e-30f1-1236-733debfcf5dc@vaisala.com>
 <CAHp75VcWu96EAjzYYwt_gqscvJp3s9Y+ZnaK2NQa_=L+S+r5zQ@mail.gmail.com>
 <9d6e9205-6fcd-1112-46da-2062e12311e1@vaisala.com>
 <CAHp75Vd_bV63rQLfGHk8uxROt=br33sZ18E14uAsuYkcQiMx-Q@mail.gmail.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <8ca189e8-dc68-8438-ab3f-f468e839507a@vaisala.com>
Date:   Mon, 19 Apr 2021 15:48:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CAHp75Vd_bV63rQLfGHk8uxROt=br33sZ18E14uAsuYkcQiMx-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0701CA0064.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::32) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.132] (85.156.166.106) by HE1PR0701CA0064.eurprd07.prod.outlook.com (2603:10a6:3:9e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Mon, 19 Apr 2021 12:48:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04244ab0-1eeb-4af5-6f2a-08d903317d89
X-MS-TrafficTypeDiagnostic: VE1PR06MB6893:
X-Microsoft-Antispam-PRVS: <VE1PR06MB6893004F1364128B72FE9299FD499@VE1PR06MB6893.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iypMe+ARC8r5gB8OpaUVhVgVeEt0+tTM3nZ4rEfGaAI4vhzLtOnixpKI0o7TEJ3lNvf8ZNw6HeCi6d670lIwKr169L4nA5HeuYmiLa49xL2CTQ+0TPUul2Cn7F59Y6jHCSTjb4ay/6XXNiDRvVDGFRbHJ/OWYe8RqVr54NzEeXASa5bMeEt1yexw+fjnD7fbtEXGlhPrtRlYvXulgp4xnBoi5nqy2J2Q8T5U638F3VkB1nlOkePux0ck+7xCGSuN1LG9rsLSLdFRum8Wh8EQUGGe3L2KB19ZgyX1pn87pvQ0rlA4yrV5bpjZOlhRuA0b4BIDjgOfCfmjC99ooVNKmFQnQ4C582sVY1M2Vskfvzn1BsDWdEHKFY51XjcViyIpR0a7807T1Be9MrEcgcHzXixHg4UyxvSHk+boytfik4G8QsqrcNRHWrHNoM20OXJcDu2IkVvUvac4ei4hBYPwNkrX3isrFbiXXRhnbLVnnPcgv+2bxHZOH5Xpuq+LbmeA6ERws1Xf82SzYBuqhPf7LmwbYMBIc4oLVrXpPlxcK0yw2qJhx1aLO7ilfKXvQHDxKrU6HDlEst83f1zCD1dkKdVbpQtHXuznF5kUutvPp11BmH23JjbvairW4P00fk4NG6Fwm/C4hjEXCwWQdZKJqjl598ekF85dSG0K3H6BmVLzny8hXSB/pGlBF7z+uWnqBsgO2CuP99+H6xfHl2P6MD8rR7rVa56SegcKnQiYJ/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(36756003)(44832011)(956004)(54906003)(16576012)(316002)(2616005)(66476007)(53546011)(26005)(16526019)(8936002)(8676002)(186003)(6916009)(6486002)(478600001)(52116002)(66556008)(2906002)(4326008)(66946007)(5660300002)(83380400001)(31696002)(38100700002)(38350700002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T2wxQ0k5dElOWEF5dE43S1o4K0tkZmMvYkVraDRKWVRReThzUlFlQlBWeTcz?=
 =?utf-8?B?VkVFdDl5ajZlVFFVeDgrbGtqK0JLdjh3S21JRnI1bHFyeXdwTUt4cmtTNEFa?=
 =?utf-8?B?L1g0Z1poMEFGWG0zVWJQY1NuTHBKQlZ3YXZaaDB0b3NwazM5U3JORENkTzlR?=
 =?utf-8?B?ZFhVL0IwallYM09KUnk3N1UzQUxKTFFyTTVTS2dIZGtWNW5qM0xzVDZPdUtB?=
 =?utf-8?B?LzB4cWpRRXZ4Rk54Z3VoMHUzRWpveVFFbWNLTVpmUDRRdkUyOFhoWDdXQWNB?=
 =?utf-8?B?aGNJanpFekQvM0F1Y1RhS0wxM2lWdTRad2FCNVN0UmEyc29OUUM4V281YlFN?=
 =?utf-8?B?MkMxMWxzaEs0V0g0OHNBNTljM0hjeGQ5SVJ2VDV1VDkxUU5KbFltNi8zdFJw?=
 =?utf-8?B?ZjVscFpkUlJDQjFjY2l2a2NnS1ZDZ24rcVMzSC8yVUE0NStCckUva2RxUUhs?=
 =?utf-8?B?ckZPNFFUazBEdGJPdENOUVh6eDgvWkM1R0J1QmdrUEs1QTZETmUwVWR4YThi?=
 =?utf-8?B?QjFERXc2TmtOU1kvVDFrMTFaOThvY0xXUnVnNlRLMjZleWtLQXY1SUtQOEcz?=
 =?utf-8?B?ZjAxRnZPZVE1eElsNDJuRE1NYklCeitKM05ScWJ5S0IzeHF4OGpGcFRTNzc3?=
 =?utf-8?B?RmNpcFF4bGFaWlhIVksyVEI1clVrdmJST0xhZnhLNDlzQkFrOVRrNytOL3Ry?=
 =?utf-8?B?L3hvbWRQVTUrZnFzY0V6Q2c0QTU3a200ZUM3K2FpT3c2YmZWRHFLRU9yaHVT?=
 =?utf-8?B?R01qRktJQTRnVHRYVFFWVDhWRWN6VldMeW1LclFmWTVId3cxSWdVWkhCdmZJ?=
 =?utf-8?B?TlRMQ1UyN1J4U2o5TThLMlA3WW42bTRmbHVqZFYvUFBLUkdCOWFCL2JtM2x4?=
 =?utf-8?B?bXgxY3hBNWZ5QktzOWJjTVNtV2hHTTI1eXNjL3dWSjJpK2VvR3pIcTFWOCt3?=
 =?utf-8?B?TG1FSDZ0ZENFSjlPcklZL0xnaEppWm9zK2wyTE56OWRuTm5HNlZCNVplQkht?=
 =?utf-8?B?SGp6b1lFZFppSGZhUlBjZmtqUitxSXlxU1ZRMFltNG5vbzg2Ni9QRUZwSWMv?=
 =?utf-8?B?YThwbVl6cmJMVW5KemJzMXl2a1RuUTNXTWRJV2s1dkMwc0VNSjJ0ZVkvMTNz?=
 =?utf-8?B?ZDc3UXk4cjJWWmpmQ1prWG95dHQ3YnVqV2hURlNiOWtMbGF4VXN4MFdJQkpp?=
 =?utf-8?B?MThNVXI5QVNlQitIU3Q3UmRMTHhHQ0NqYmkvZmZIZ1FaTFRUVjc3Zm1mZ2Yw?=
 =?utf-8?B?YWhhcTlYWEdaNVp2Q0l0TDJ2YTdKbE42blFDS2xOSFdZRTR1OFR0eTJCcE1V?=
 =?utf-8?B?SktCWFhoS3VIUE9mL3dZWGEvTU5ZQmtmMzI3c2YzWDRiWU9vKy9UaXc5OWlB?=
 =?utf-8?B?Z09McnRaQWQrZnRCbVV3MnpTQXA3Y1hBRlNXQWc4eUJ4SWQ3NERJSHFyeE5x?=
 =?utf-8?B?ZEtRanMrZ2NtcWJ4ejA5VDNnSDk1dGtzOG1STmVPZmpnei9nQ3hMdlBLV0t6?=
 =?utf-8?B?UXN1eksrOFFBekhncVljc1JQWnpsSFphUzdxSCtYUUxOU2t0ZGdiSTA3clY0?=
 =?utf-8?B?VXdUNkxWSldER3VKL1V5TTRtd0huSDlId0FFSlFVS1ZBRmxRSVZhNVVjT2s3?=
 =?utf-8?B?b0NEekhuNllFSGwxQUZQY3dYdm9ld0VHUG04dFZTQ0dNazhvcURWZEt4d0JP?=
 =?utf-8?B?RHhCT0Z4ZWNJeXIxMDFwYys5WWxSOGxhejJCUGU1TUpZM2g4anM0bm1BZXZv?=
 =?utf-8?Q?CRIZtr66zoOXC3dWfJ3B7DdyLFXpX4xWnid3Wtp?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04244ab0-1eeb-4af5-6f2a-08d903317d89
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 12:48:54.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrKqgUjuLDAVoDc8En6WgWgjV4y1pBcFKwTf2nhWYRS34XhVoySpOq7IA3pZrdPMqSVbLFbPI/NMrni2QfW8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6893
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 4/19/21 3:29 PM, Andy Shevchenko wrote:
> On Mon, Apr 19, 2021 at 2:36 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>> On 4/19/21 2:14 PM, Andy Shevchenko wrote:
>>> On Mon, Apr 19, 2021 at 1:29 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>>>> On 4/17/21 3:39 PM, Andy Shevchenko wrote:
>>>>> On Fri, Apr 16, 2021 at 5:21 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>>>>>> Add initial support for Murata SCA3300 3-axis industrial
>>>>>> accelerometer with digital SPI interface. This device also
>>>>>> provides a temperature measurement.
>>> ...
>>>
>>>>>> +       ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
>>>>>> +       if (ret < 0) {
>>>>>> +               dev_err(&sca_data->spi->dev,
>>>>>> +                       "transfer error, error: %d\n", ret);
>>>>>> +               return -EIO;
>>>>> Why shadowing error code?
>>>> Returning EIO here to have full control over the return value from this
>>>> function. As return value of this is used for testing
>>> Care to show what kind of testing requires this?
>>> Also why can't it be refactored to accept all error codes?
>> I was referring to this:
>>
>> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
>> +{
>> +       int ret;
>> +
>> +       mutex_lock(&sca_data->lock);
>> +       sca_data->txbuf[0] = 0x0 | (reg << 2);
>> +       ret = sca3300_transfer(sca_data, val);
>> +       mutex_unlock(&sca_data->lock);
>> +       if (ret == -EINVAL)
>> +               ret  = sca3300_error_handler(sca_data);
>> +
>> +       return ret;
>> +}
>> +
>> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
>> +{
>> +       int reg_val = 0;
>> +       int ret;
>> +
>> +       mutex_lock(&sca_data->lock);
>> +       sca_data->txbuf[0] = BIT(7) | (reg << 2);
>> +       put_unaligned_be16(val, &sca_data->txbuf[1]);
>> +       ret = sca3300_transfer(sca_data, &reg_val);
>> +       mutex_unlock(&sca_data->lock);
>> +       if (ret == -EINVAL)
>> +               ret  = sca3300_error_handler(sca_data);
>> +
>> +       return ret;
>> +}
>>
>> So this goes into error handling only when transfer indicates EINVAL
>> (which happens when
>>
>> transfer otherwise is good, but device return status has error flags set
>> i message).
> In such cases I would recommend introducing your own error space (with
> positive numbers) or playing around with the number of transfers (but
> this usually works only if you anticipate several of them in a row).
>
> Something like
>
> #define SCA3300_ERROR_FLAGS 1
> ...
>
> if (ret > 0)
>    return error_handler(..., ret); // ret in case if you want to
> convert the code to something in Linux error code space.

In version 1 of this patchset, positive return values were used for 
indicating this situation.

One of the comments I got from Jonathan to that version was to change

to use appropriate standard error code rather than positive return value.

I would thus keep this as is, hopefully You are ok with current approach.

Thanks,

Tomas


>
>>>> for possible status error (EINVAL), feels more confident to have it like
>>>> this to avoid any confusion. And atleast spi_sync_transfer() return value
>>>>
>>>> would be visible in error message.
>>>>>> +       }
