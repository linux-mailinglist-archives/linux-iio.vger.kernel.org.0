Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9036AC05
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 08:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhDZGIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 02:08:41 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:44462
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhDZGIl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 02:08:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB0awVshJWE+ARdHRIeXdVFdTQ3NonkkNhLX+SY7dSvgM2PkJuLpxKk1JO+BO5PBvf3mJMy9gEvJFzKYtHt4jDIh0MLnLUmnfb8rA2P3CDl354r8a+uuAVjnK6Vpxw16Zcele0rc0Vgu/kNtGRtrv/AIaXHVtIEqaF0Ol7UZ2Lf6z2Vt9egJ+eccou9KeT2krmBpPmdfXA6AYChGVMdD9UYz30T7Hck2z8DnQConBvNJ5LZO2HCma6XDIn79OS+sUEpoEYMZg/gODUZD69HS04SX9ylQtTVShgzGbDvBvlXr/1aKejQEKqKaumE1KyHRw0NPln/rrY+BMwG9ha/E7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g8rY0qDYz7lqjDjAW/OVAHOX8iC16H8V/N/5dYxxsI=;
 b=io1qIjGsTThbLFKlakVynrDkA39jmjhO92qeWV18CTVNkTSJd13SjISa5aArnY3T5t0GYS/BVnqpWIQgSfFgSrNVdOT4FySmA83yY1M0jMUF+TAou0AWxHgh3fBuiQsqC4Y2jTmW2gYb4SMVxoLVs67Nh/Wz56CXuXBwD6xQaNeGMIP9R7OYH82imXgckSSrSs+nX56O6HXuQI60oE0Y5IoPwpz4I0rosWFWBFf+XqFplesjfTwGGYlQ5Gg/UGtmCD48Om10hPw2luIxA1TcJr7yPNDmH32H0eCD7cfCr9DsBMS2p5kMAypZ9aXKtqN/mW3ECjOA1wHMXY3JiaDeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9g8rY0qDYz7lqjDjAW/OVAHOX8iC16H8V/N/5dYxxsI=;
 b=wv+RNG/2N9Huimhol39lwKubCKcw8tgj0PP76one6UTPB/TBR2MzPB7kp9e2Lkicg7n7PgulPLhKvPAHC2Ywg1281f5YuP5VL11OAmj9kGcStNp3Jm7BuvN1yElcdgn51wDcTSq8bXoJeFmD4y9WjqFoDoG3aKVDlUwQFlWBWIqATY1lhTfR+UtDurJLGqNaOfbiNyVTFkkuJCDJIOn/o5tkU+zl75pNf2HLpuxSFiQljlyt5YSm8iThEwh5F2R2HunLMQCg0YopW8X5V+QjxDJ8jMwZcfJuRvyeF9gzPLjkSXT/1ncbvswt8dhPQuL2FtaEyqDOaWBK24BuuTKDRQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB6542.eurprd06.prod.outlook.com
 (2603:10a6:800:11d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 06:07:58 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 06:07:58 +0000
Subject: Re: [PATCH v4 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210420132333.99886-1-tomas.melin@vaisala.com>
 <20210420132333.99886-3-tomas.melin@vaisala.com>
 <CAHp75Ve2AEA8yPw5qN+R=K=ovaO8vX53hYU9=knjY_Z+EHDdww@mail.gmail.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <cc022230-1cce-9eca-baa3-b0a407a2ab7f@vaisala.com>
Date:   Mon, 26 Apr 2021 09:07:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CAHp75Ve2AEA8yPw5qN+R=K=ovaO8vX53hYU9=knjY_Z+EHDdww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::16) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.137] (85.156.166.106) by HE1PR0102CA0039.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Mon, 26 Apr 2021 06:07:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93d63aa9-f261-4e58-e48f-08d90879a395
X-MS-TrafficTypeDiagnostic: VI1PR06MB6542:
X-Microsoft-Antispam-PRVS: <VI1PR06MB654241B1B8298CED6B7FE2A9FD429@VI1PR06MB6542.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbOHSEtsxQXbai03XsjBT8NcBbuOYuCd3eO58X+DEa7ZiezV78FHFHaE8WzU0LucjfNjP7rFB6jaZkgVK9TSk7HRfnm4nNH+ATGwDMIHjTfr2Z99+bVItAL1gUMoj6G9GKAmag0Kx9QkKUzEFPRzgN70DpkXiIv3Fp5OIKj4AUtglFXlzWeFuBpv0qqcazNtvGjDkkAM/YBfQLeYZfbUggkjIS4faoSMnLV+5L9KSMNQimHGowBqEvAyahGa6pIZHeuWM6dNYssopb5szw2Pk7+VXjy0JjqqX0+eLipHyEHQcapHQmx9nkQp+zYNtYsU78SeKax5VeMXAt6vRaOM9lGRmmKDui7T7BBrurygHfPktpPJqArCzP7p5epyHoQslHWLJPCrlcDZ1Dud4kkcIDVWkWD4AM+hywmsrFPgC81S+MOlYUXghicSFd5VXWAkVOotWwXhk6WsypjQ8MjoWB8FazjhhuF8MYbhChl9Y8fwTuYTtyEzQMAQPpEjx1bSHu+ixqANM20N8ZumVV0NUXuFiyofpqADdcKsoaUWyEMO2nVq2rH3o2uQQLge0xO/pbqxK2I1O4rLaIiUTBlahEVrak0w+2IZ+aVFW8zrLE4RtrpT7YSVUAyL9PhspOnSRGVF0NaWUdlnHNzp5+v/O+L/upbZprWWeWyHp4xPZcai/Bfy+Y3SLqyCoXocaFwQ7UJ0814Mjz+LXScsyKaDZaylJkrDJd04elQeovvwf8sEyWH/3yi0K0rURguwLhJI0FydqbjXK2M3Uk75xsw5Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39840400004)(136003)(366004)(52116002)(66556008)(316002)(36756003)(16576012)(6916009)(54906003)(2906002)(8936002)(86362001)(16526019)(186003)(4326008)(478600001)(956004)(2616005)(66946007)(31686004)(53546011)(45080400002)(5660300002)(66476007)(8676002)(38100700002)(31696002)(44832011)(38350700002)(6486002)(83380400001)(966005)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OGlKV2RiNXR0VTEyRlc5R3IxelNHZXVaS1MrU01KRk9ySnRKSi9NUkczUmM5?=
 =?utf-8?B?alg3WXFaQ3dyVFFSUWtIZWlwTlpaT0ZXaGcxTzBaT0lxUWZ6ZkhnS1MwQ25M?=
 =?utf-8?B?RGlOL3lMaWxNYzdUcEx3RXFycGEzTE8rTjZBMTBGTVFIdUxPRkJQMlV6eHp4?=
 =?utf-8?B?OHJuTFo3REVwOS9nRU9WYnhLakFmdUpPZmp2Nzl5Mk5PcFVxM0xmK3lvTW9Z?=
 =?utf-8?B?RzQ5ZitUSGFzYXFwRkhkMGVobFBlNnZyejZhZVJIR3hTNmpxMnZQK09Ccmtj?=
 =?utf-8?B?bmpOQmQvNElHMW5ocDB2OFlTYkdTQjdadEdGWU9JV2l4Wnp6L1I3Nm5RVjdO?=
 =?utf-8?B?WnlsL05UOFdPZnZDK01iN1o3TFc0WG1OT2kvb1VaMndhSTBueCsvQ0JvZ1B3?=
 =?utf-8?B?TnJveXVhWkxCOStpWUF2cEJpajRpQmJZVmpWS3ZJYysrRktIUy9HUVk0OURx?=
 =?utf-8?B?L1RYZHNrQm5TOFl3ZFU3dDA0dWtvQVRsV0VIRnYzL2d5aXpQWnc4NHE0M3FJ?=
 =?utf-8?B?Q29XQUVMQ3AzSkR5TGhmcyt1WU5uSnVhS0h0QUxQMTl1R01BY013U2c0TGNv?=
 =?utf-8?B?SFdiYzNtNGp3azcxMHo5ZGRNMGxDdW1MdXVZVkNnL21BM1hBeW04ZDJIT0Rl?=
 =?utf-8?B?V09UT2QwQjlHVFA4VS8zc3VIekpPS0QwZUJFS3BibmVQT2hqY0MyVmpFbE9D?=
 =?utf-8?B?aFBPWEI4NjFwUFlGL2p4QUpCMk1vMFNvd1ZwZzZqWWNKZFVQaU4rT0tyczQv?=
 =?utf-8?B?dWliemNWV2xpUk5KS252NlVLaXV4R281WHlrdnJjSWxjVVV0VHg2Qk9mdEhl?=
 =?utf-8?B?dU9sNGcrcHpiVEJCSGdUempnZWVjZ3cyclYrQVFrT2RxT211ZkN1VkE1T1VF?=
 =?utf-8?B?NFJZMWFTelR2S1hGTHJmeC9DL3JhbjJSaS9PdXlua09kODd2WGE4MkcyV2Vw?=
 =?utf-8?B?SXVBam5HUHZIRElqUUYxNmhndllUUFJkbnFJLy9pM1lDcFA2eGxOY2R4azZi?=
 =?utf-8?B?bUNQZnZJN1ZTS25mSXV2N1VXNFJmZFIxQTltVll0RXJnMmVhL0k3dlB6YVNB?=
 =?utf-8?B?N0pUcENLMytBT2JWekp5NTBTN0RMRFVuWldUK2o0SG9iZExPY3RudFJpNXNG?=
 =?utf-8?B?UVM3VzN1bTV4RU5Ta24yd2ZPbkRTeUFyMVp6ZEFNMHp6cWt0UzVHMEFQKzlQ?=
 =?utf-8?B?RHQzNWtGbGo2am9wOEVlNjFPMFE1Q1VOMVFnNEwvQW9PTzBZNjdIeEdVSHVV?=
 =?utf-8?B?MVlaU0hjdEdteG12QjM1WmplU3kzb3dYMTd4WjRuakZtV3FiT0c1V0ZrQUxV?=
 =?utf-8?B?NVdYWGNZaVlNSGE2Z3llVlJEbUVwZE8wUVd5NEFtMUNPdWpWTGZwc3hmZUxT?=
 =?utf-8?B?ellIREJ3d205MmZnLzMwOUIzT3FTOHlhaVJJd01EeDdHdXB6QURyeXVDUW96?=
 =?utf-8?B?Vk9BL1N0RkxWYU9USlBKSEFrcGF0YVNzL0Z3TzhrUkJqZnd5ZEdPbWFwSDBq?=
 =?utf-8?B?WWpJVlNmRWo1WlJSSFZLQXhHRXhqbVp6M21PakJBN2NjdFg3T3JJVEdpanpL?=
 =?utf-8?B?bkVCRmt5OFZneVYyaXF5SU1XbDUyMWc1WU5iVHh2cEVmMUNPUHhITlc5bFNN?=
 =?utf-8?B?UmVXa2dNUVJFMWEzMjZoQWMvOWl0NlBhcmdiSlJRM3lZYzUxWTQ1RWFtMlBj?=
 =?utf-8?B?cmV1ZnpXd0FJcC8rdVBnc2VPZTQ4akQ1UWx5b1E1eFNRTGdUMmgrdGM5QlJw?=
 =?utf-8?Q?Cvnf9j0pH2lX75bTXLtpIuMpjCehEJs+rQuPlg9?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d63aa9-f261-4e58-e48f-08d90879a395
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 06:07:57.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuKlJQvhWET4SqWi5EfeZ/0Ob5kb253cl5Cjxaf0Djxd5XXzYFDtRD9eCv0kNklpnLvatR2SK+zZ1lekzI1ABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6542
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/23/21 7:06 PM, Andy Shevchenko wrote:
> On Tue, Apr 20, 2021 at 4:24 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>> Add initial support for Murata SCA3300 3-axis industrial
>> accelerometer with digital SPI interface. This device also
>> provides a temperature measurement.
>
> ..
>
>> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
>> +                        indio_dev->masklength) {
> One line?

 >80 if one line.


>
>> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
>> +                                      &val);
>> +               if (ret) {
>> +                       dev_err_ratelimited(&data->spi->dev,
>> +                               "failed to read register, error: %d\n", ret);
>> +                       /* handled, but bailing out due to errors */
>> +                       goto out;
>> +               }
>> +               data->scan.channels[i++] = val;
>> +       }
> ...
>
>> +       int ret;
>> +       int value = 0;
> Reversed xmas tree ordering?
ok.
>
> ...
>
>> +       /*
>> +        * Wait 1ms after SW-reset command.
>> +        * Wait 15ms for settling of signal paths.
>> +        */
>> +       usleep_range(16e3, 50e3);
> Hmm... Perhaps re-use msleep_range()
> https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fdrivers%2Fmedia%2Fi2c%2Fimx274.c%23L601&amp;data=04%7C01%7Ctomas.melin%40vaisala.com%7Ce224aae96fd14d09236408d90671cfb2%7C6d7393e041f54c2e9b124c2be5da5c57%7C0%7C0%7C637547908155668061%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=5ZrTdeWqw1YC6TFu2VTCt%2FT1B3UrPex4Vj6T2nYJtjg%3D&amp;reserved=0?
Checked that, but not sure if that would make this call any clearer? 
Delay is now only in this place and well documented. If you have some 
specific formatting in mind for this, please let me know. Otherwise 
keeping as is.

Thanks,

Tomas



