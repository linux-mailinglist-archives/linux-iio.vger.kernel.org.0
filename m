Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0A36AB4B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 05:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhDZDzh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 23:55:37 -0400
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:23058
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231852AbhDZDz3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Apr 2021 23:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdkDYgy70CfYdIA40GxZcAm8Dv9yiNFYsmHGljhauLmTc63S/OKqUn6ivwFZgfDEQSvbDlDjyJPqzgTeteXHsf+GWKAxNjMTmwaeMftuiqwVwD+9wnvkfHPOc/KmYAdIsugzLDjBX4rNHBYw2DD9AT/UOq7RJwdr+xCg6psgW2LhCPXntGFkxGmro/T0ghso7UPlaVtHAsNJ4x8Cbdw7j2McsW/CPwTrefW3rMBN7wwM6DxyS9YO+jEf7jbuIEkX5ZzTtjoS9f/2V5dJ8lEaQrRn5lo5lDDD2Y/sIiiBpiMQs0xK/W2zRHVFRTc5Ea/VRFTpKm6Gm2ovgtLqA7/BLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0SbPkM9Oj0J65oNUYSo8Vj+ve82UIgWOeDrd0EYQ44=;
 b=hTB4Cvkh3PEAMRtEUbY45W9OQQNyITfDT1oC9tVVcYnO4j/6YI1JCHkjSqDlamPQ5u1YHyfjmbnufuRgztABco6sC4QszyNdYWwQbxUyi0+b4uBxKGGKZhlKhGgISXVCs8+phM3J0uRWhZDx3DuzgtASMmCkDrtWG1MOi2Q2yCrawGk8jShLh+Pyn2c8tiRDpPQkvQqw2ZOvztTllYxe7O34XsfhWLYr74YnMRPRz0CUNgnET/j6Xsfy7JL7iC34WixsNu7k0re96uC8d7qY9b6eLTsaljU7hULJN5PAwGkYPDWqZWGK8Z+DOkCdTYB4rPgRVxiD/LuVUuo96cqJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0SbPkM9Oj0J65oNUYSo8Vj+ve82UIgWOeDrd0EYQ44=;
 b=QrSH5JRo/hxdfkyzVHa4nDmz2CIVQsA+YbgClZVvlH98Z2ein5aG0rd2HLL+pyCp1Gu49pmu80/ggRp+J/piGJpHoLKC2XLSqRFSTzk8cNeXfqAr8EIGEfAH+95ihC6WtpFAxg2TyuUhU3Er5znAQkOqgaR3o+VrSge6rRAEDGf70NpFqHw+0FDtWdbW+wg+6RLf3ivyOp+PkjUM2NKQ1jK995vrz+DGkRBvxEyGg82jzfRS8hhimaqI+9P65eY7UvhIvzg7t8f+GkL/1xpnMpE4cFnXcsVk3FMRylAzJipKJsEyB6AKaFOVv7o3GD4b5Kj5fWAzTZ+RrVEjtMrV7Q==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VE1PR06MB6960.eurprd06.prod.outlook.com
 (2603:10a6:800:1a3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 03:53:41 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 03:53:41 +0000
Subject: Re: [PATCH v4 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210420132333.99886-1-tomas.melin@vaisala.com>
 <20210420132333.99886-3-tomas.melin@vaisala.com>
 <CAHp75Ve2AEA8yPw5qN+R=K=ovaO8vX53hYU9=knjY_Z+EHDdww@mail.gmail.com>
 <20210424125309.426d675c@jic23-huawei>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <5c7278c2-1d56-7e5c-6f3b-e5b95c915ad0@vaisala.com>
Date:   Mon, 26 Apr 2021 06:53:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20210424125309.426d675c@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0402CA0035.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::24) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.137] (85.156.166.106) by HE1PR0402CA0035.eurprd04.prod.outlook.com (2603:10a6:7:7c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Mon, 26 Apr 2021 03:53:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02356726-e10a-4ff3-6c87-08d90866e17f
X-MS-TrafficTypeDiagnostic: VE1PR06MB6960:
X-Microsoft-Antispam-PRVS: <VE1PR06MB6960D941B6F721883ECD2C98FD429@VE1PR06MB6960.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hYRy+CGsZA5+cuQFo4e6RqVtnV5QcWpxAZrQ6Nubh875FA2tZtvoJmAy7a45pgzZVMzNPhzk9b2xgas3Xg6fjFhShgyNnukL32clO+J8Ojg1IaI7Ips0equsCcu/QFhI8LBYMgS7eE84tzjrOap4D/jQ2tPJZp2YNrPyPxaZu428SVGLBzexCfEqtOsnJ3yONTp9BUKLqZxl6WeW5hrE9M1kxcvUu3T8iSKFydKs118KQXsUx3CZpiOwRWywy5GgkLbTGvwAI+Ehglt81r9GpcVs7FKq9vWaLggL2kNQiKynP39xl1kEPfmRmUeu1uUkB9diNnX/Y10Uuw1cdQEnk1rHASClPs05l8MPFkJEJBBgK67MWNIGGZy0Z5Aq1USzQl3JQpXevCl4GgBr0nxeLZ/Hc+JSJ0r9cbu8qxhJuV0wmmvSPy62AYKiciht+07PNt+EV2areC7s2IJDyNxfX3ipr6xearwk/nS3PaNO46mMJp2g72oaJwjq+NyVFEgiOJwWgP+5l7mip5wb3dNK7zzjuhEdVysfFzPhaeIJNX/IaHL7G9IIz7ZAjK40eDMzvpqwMw9TW2Ql9mnyQlvcokrmKGwiMus88zTje8YZa5514nk3k1YsvIRGUctzuWJd/K0o7byqjQrRN52BfqWJyqPJkRffStQLC3xbIExbMVMGF3xPFT4/be7e2ykvSq270QhRoukBOiTv1jhY1lQlXBmyRjhbEAyeemPZBQbueilXvMzdcYIuGt428fzIG5eJ1EgMLNf8sapdM6ca+29lIY9fZykEi9Bdi+wf607DdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(376002)(366004)(346002)(16526019)(26005)(186003)(53546011)(6486002)(5660300002)(2906002)(956004)(2616005)(52116002)(66946007)(31686004)(66476007)(38100700002)(38350700002)(66556008)(44832011)(36756003)(86362001)(8676002)(110136005)(8936002)(54906003)(4326008)(16576012)(316002)(45080400002)(966005)(478600001)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZE1EY1JQUlh5U3B0eGFZVGNwbG5PVU9HcXlPVnhqSHZqQjhlYWI2YjgyUXR4?=
 =?utf-8?B?Y2ZRRGdRRHRtYTRGRzFsQXZ5aFIwMVhUcU9oV2RZWVM1RWZmczRWbkhDZXVL?=
 =?utf-8?B?MFJ0WXlCeXBQYk5laHNxdjc3U3FDN1FiWXozWCtXM0IxSkVjLzdpRldyQ2hB?=
 =?utf-8?B?UDZhdHFZR213aDFYTVVsRTQxTUFSak1HUVZvTndYNi9UZDc3R3Y1R3dYRWFs?=
 =?utf-8?B?L3d4MExwU3lLS3NIeEc5U2xCQkxqUmNDbTN5MitLN0VSc0ZNNi9ndDhqM3VY?=
 =?utf-8?B?bERXRnhqZ25QWDV3UzZDbnRWYnl5NzJpdlVHL2xjdEVicmVGc01tTTdRbUpN?=
 =?utf-8?B?TEVMSEtPMW16Q1JuUTgrQUQxVmN2YzNCbkJZaWZwMFo5WUxpdlgrM0lmZnZh?=
 =?utf-8?B?cVB5VzFxbjJ2SGNvZ3N2bjY2cGp4K3N0S2xxNzEzajFId1lMUUxjOG8zbnVH?=
 =?utf-8?B?QThmazhJTldpOHBOeW5ZOEVPWDJRS0hkMVcrcVpKUUtMTEllV0tVUDNUWGZE?=
 =?utf-8?B?MkdONldRN0k3eWNBZHVaVXdWQ1NoZzVCd1llMURWOS81NTA3d2Q4Z2wvSzBw?=
 =?utf-8?B?ZFVyczNETGZFbDM2QmVsRnpXZ1VteVAzeklkbVl6SStnTWxoc3E4aEZDaUIr?=
 =?utf-8?B?MUQrQUpFbU9EY1c2cjI5UE5ZU0lUL1NrK2pWWkJKTW9BZnZscW9aMGc0clF2?=
 =?utf-8?B?Q2w2QjdTYjhNM1p3cmJKcU1jaWRmbVQwcTRoc1BWMUFqaWVBQThSa0Y4ZmlU?=
 =?utf-8?B?cnF1ODRBZEJkN0lWSFpCalNIUkh1OExHZDRQSitRdXAwRms5OWVMUmc3Q0Zn?=
 =?utf-8?B?N3NKQUZmeUJqMTJVaVVyVVVaOEQvMWhkQzVRU0pOSWxiaWhRNFpoNFNQWDl3?=
 =?utf-8?B?U0FaTXFQdTA0aU5uYUZzNGJLeWY0cFNiWXptdTFmMzhXRGdwVEIvdTNDc01x?=
 =?utf-8?B?TkVKNXFKRGRTT291TnFmQWpZVHdxbTRWbUFNUWJsTkkwZGY4YktsMUVUL0hk?=
 =?utf-8?B?SzBNNlRlY202M3NTaVhnenFHSnNuVkZPa0txa2pMUjdzdmEzTWpVd2E4TG9z?=
 =?utf-8?B?cXFRRm1pZ2FOWXN5dXh2MGpYaGNuNlRlMzRGT002QVNNSHNXZDZoeGJZSnMx?=
 =?utf-8?B?SlN6V0ZyT0dIM2hQV1IyMncyZ1doZlhoTVdGSi9KQWIxbTZYNXhpeElrZXND?=
 =?utf-8?B?a2dkT1FTN3c5cWFuM3RibUIwdEFqTnl4UENUcVRrRTlRRWVoVXk5cFEyY2NO?=
 =?utf-8?B?aDN1cWpNbm8rNE93dDF3aGFiYmtZM2xxak0vV2dUZVpyQVRVbXlvTzVpb1hK?=
 =?utf-8?B?VlZXMCthQnpFU05VeUFvNGZFc2taK1p6Y09iYVJFQlFMSGVKR2piZG1KYjJp?=
 =?utf-8?B?NUxwMmxDMWZzVXpWV2pMV0xTNStLN3NNTHUxbGVVUlhqV3lHSy9ZT24wU25Z?=
 =?utf-8?B?SWFPVTZGcHlCSlFReitoaXJIQituLzNIWE1PYVZYSjdnaUhhSys3cUZPdXJh?=
 =?utf-8?B?bmR6eWhBOFF6c2NPZWc3ZzMrZzlzQkpZL0ViV3ZmZVBoRFhEMkpKSWkrWkM1?=
 =?utf-8?B?SjcwTzZTT1FpU0tNUVlSeEtUNjVCUVdlRzV4bHg0L05OQnRlMkVndEhOUTVr?=
 =?utf-8?B?cUdKK3A0NDlsZ3BoU2FadmNQYXU3bHVQcTcxYUZlV3dMMjhDOEJTM1Q1b3pE?=
 =?utf-8?B?SnA0TEZTV05WZSsvN2lXRll0Q3lsTHJ1NVdEWFJobkxTZTNJWjlQUCtVbnZC?=
 =?utf-8?Q?kLtWJ9sFsl5VK2/b1EFv8jRw0cqg7tn80iEOccZ?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02356726-e10a-4ff3-6c87-08d90866e17f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 03:53:41.4785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbbU508tWXIlgc8EZrFCMPtR2CVoqJl8YCT4rk0zIMaqxRkxEzrn2yxWh1+QnBosi1z04NlhwOm4f4Lwalj8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6960
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 4/24/21 2:53 PM, Jonathan Cameron wrote:
> On Fri, 23 Apr 2021 19:06:30 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Tue, Apr 20, 2021 at 4:24 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>>> Add initial support for Murata SCA3300 3-axis industrial
>>> accelerometer with digital SPI interface. This device also
>>> provides a temperature measurement.
>> Thanks for an update, my comments below.
>>
>> They can be addressed as followups, but I think regmap API can be
>> considered right now.
> It's not a totally clear cut case of regmap making sense for this particular
> device. I think you'd have do a custom regmap to support
> the cs_change = 1, needed for transfers and once you are going down that
> route the advantages of regmap have to be balanced against needing
> custom callbacks anyway.

Considered regmap, but given that it seems to require custom read/write

functions and that there is only SPI version of the device, I concluded 
that it did

not seem like a great fit for this driver.


I will implement the other changes suggested, and post a new version.

Thanks,

Tomas


>
> Without actually implementing it I'm not certain whether it would be
> a good thing here or not. It should be fairly easy to try though if
> Tomas wants to.
>
> Jonathan
>
>> ...
>>
>>> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
>>> +{
>>> +       int ret;
>>> +
>>> +       mutex_lock(&sca_data->lock);
>>> +       sca_data->txbuf[0] = reg << 2;
>>> +       ret = sca3300_transfer(sca_data, val);
>>> +       mutex_unlock(&sca_data->lock);
>>> +       if (ret != -EINVAL)
>>> +               return ret;
>>> +
>>> +       return sca3300_error_handler(sca_data);
>>> +}
>>> +
>>> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
>>> +{
>>> +       int reg_val = 0;
>>> +       int ret;
>>> +
>>> +       mutex_lock(&sca_data->lock);
>>> +       /* BIT(7) for write operation */
>>> +       sca_data->txbuf[0] = BIT(7) | (reg << 2);
>>> +       put_unaligned_be16(val, &sca_data->txbuf[1]);
>>> +       ret = sca3300_transfer(sca_data, &reg_val);
>>> +       mutex_unlock(&sca_data->lock);
>>> +       if (ret != -EINVAL)
>>> +               return ret;
>>> +
>>> +       return sca3300_error_handler(sca_data);
>>> +}
>> Okay, BIT(7) for write/read is pretty much standard stuff for such
>> sensors. If you transform your driver to use REGMAP_SPI, you will get
>> it thru regmap configuration. Also, you will get a locking there, in
>> case you don't need to have several I/O in a row atomically.
>>
>> ..
>>
>>> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
>>> +                        indio_dev->masklength) {
>> One line?
>>
>>> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
>>> +                                      &val);
>>> +               if (ret) {
>>> +                       dev_err_ratelimited(&data->spi->dev,
>>> +                               "failed to read register, error: %d\n", ret);
>>> +                       /* handled, but bailing out due to errors */
>>> +                       goto out;
>>> +               }
>>> +               data->scan.channels[i++] = val;
>>> +       }
>> ...
>>
>>> +       int ret;
>>> +       int value = 0;
>> Reversed xmas tree ordering?
>>
>> ...
>>
>>> +       /*
>>> +        * Wait 1ms after SW-reset command.
>>> +        * Wait 15ms for settling of signal paths.
>>> +        */
>>> +       usleep_range(16e3, 50e3);
>> Hmm... Perhaps re-use msleep_range()
>> https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fdrivers%2Fmedia%2Fi2c%2Fimx274.c%23L601&amp;data=04%7C01%7Ctomas.melin%40vaisala.com%7C3b7eaa3e7fd748ed89f408d9071771d9%7C6d7393e041f54c2e9b124c2be5da5c57%7C0%7C0%7C637548619567203976%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2aiEKH6Ua6NI2dIv9TfraxaiCbSP4FY%2BKEaPv4bsfwY%3D&amp;reserved=0?
>>
>> ...
>>
>>> +       .debugfs_reg_access = &sca3300_debugfs_reg_access,
>> Reading of the registers you will get as a bonus when switching over
>> to regmap SPI API.
>>
