Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1A23640A0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhDSLgx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 07:36:53 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:8974
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230272AbhDSLgw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Apr 2021 07:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPRhuof0jSAybjYrIcuxGATDEuPgVo0BHjQDJUBJTrxj79Y5n6/skFrfsQWA7CbIfCvp8egWJgAqnBxwuhnaI/E965CDGk34PCtoJ0dYEwDE+GNYjMoRttxXIiwZ4ZFKr54z+OW9jt/JsQkl3O1ch/lImE8Arhkoi1MHcLkNbXWJ+9MdWvjSeHmQOjQjooXzQRxyBjP1o06TZ8GsUdqLZtSyPjqudmZN6+vHi4TropNyqfcsQKwSDEYC/DpV4H7goqVwAS9G/kYPeqFs/Wd3spnHunkkvwvhdFTat7DIE/dTbgWBngoYWaejG8LUUgvg6Fqh1DtZl4QIjR6jNgKonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRDmjSFC9jIkxreywrXsCy27zmSZPCm3sCv+cYVDTcc=;
 b=FJivhnFsk3J4EVliE5R7HpFkYm9xgClCZwEQBLmg19Zpnz4eVvyljvrXls3WPm4WiU5mRBkDoQa3z0dy3HFDMwwZeDV1JLwqAr8VdTugKMF7OGB4jAQtkH6TJGVXDtP9Za1CNEswdYYrqLt9KlDtovEVEYLT0D7leUx+4yvVNoWiSw/MKMfrkEx9aXiL5l2PWALbJtvO7Y4gtESDIC0HTYtetCe7AoBn3NLOtsmRgZocHV7Ly7NUasJZdBd2n1Ttw6Mx580IGiwGwWAXFxhIL83lozpC+2j7oJ+nr03KwWCbm/fBWjQNf/azorGAxm/a4sRntp5ahY5y1+142AC3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRDmjSFC9jIkxreywrXsCy27zmSZPCm3sCv+cYVDTcc=;
 b=pGGcckxxu4ypbgyrbJDi4XaxAvzFk/OOvS7Q6TQHVM4/SsLp3igXciycLAuTQnFlOzhP7IhWF3mHpXqCCD2RDukYNW08BkyoHt6/maYFDvodOvFfAPhGOVUyEhcJqtFnC7/pEcOCfHJs2Srm+ji02kyBiptQtT5fLbv5qFxGT6loCMCjuMwalbjRS+xQBUMAFOdcHz4hDqXrdKy85seXDt+rtd3x755dJRqUa3Ym2A9rjC3df8Y18fZv8uyoWKJmih3Xm9K0o9OsB17alUc3oIIvNwPUM6pjgAbfk0i/XMi7njAey+E1RbWOMl+A0xpygRBcNhQy7ECoofVS3qiWng==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5421.eurprd06.prod.outlook.com
 (2603:10a6:803:b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 11:36:18 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 11:36:18 +0000
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
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <9d6e9205-6fcd-1112-46da-2062e12311e1@vaisala.com>
Date:   Mon, 19 Apr 2021 14:36:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CAHp75VcWu96EAjzYYwt_gqscvJp3s9Y+ZnaK2NQa_=L+S+r5zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR08CA0057.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::28) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.132] (85.156.166.106) by HE1PR08CA0057.eurprd08.prod.outlook.com (2603:10a6:7:2a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 11:36:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd2be332-d677-42fb-686e-08d9032758ed
X-MS-TrafficTypeDiagnostic: VI1PR06MB5421:
X-Microsoft-Antispam-PRVS: <VI1PR06MB542157555E881BEF4268CFCFFD499@VI1PR06MB5421.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Os72LZ90OQwRZhZ/P6hJGrVwP6P0jw3+mzIIXmSlGTdKL9SGm+pcQjeT4m6SPG/NfeTgJCcs72auHPOMyHQBAxKlBwiFa4Dt1FhNK2My7/tsHOXbtgsPlRfgdLo8C7CMQGOSAdRMjPvA8fMsP0JAyAU1JZQK8PPuPhjAsXRVCAE5BIKFD3miX89MIH5cBoZRsrYrgt8dAkGZLSj3+p04rtYE7qbh0Y2tScdY3Lahp9oTq+vEyZdlENPyUOGvrtuKRnFyaP+whmPW3FyoFCCr/AgfNHwa8UtLoSZGrv6fROWZBBz5LydWzJMEIMoXrdEDIpgs/ssflKVQvM26kd4v3l8rAUHy6yAWbxJGiP4AWB4AFkwq7IJG9440eBAcLB2nWy7gH6Myu/tCnn6nS2WuKJL6PITkclwy39GmKcn7nPQ5N+jygoEE/41wKmV1+XHVH8iCgTudqMkSN31grNrJ9xOeJHRWxjRFjTS/odF2t1zGj3joNxj8iE+QNTsFgccihqMtCR4FC9JdJAukv5fgnTH6sMEoic67gZhcI/4A8VhX60ymJkVVyckj6tPkVbz/xYslUoCg+Y0sBMmN7fZCZEK5Z/MtqyXbQiy8wvf5r4HTLzMo+hDFxOFwtKHQMco4MmzIZxJ+y4YLHR8GxQ9Bz4sCz4Xzg1N6ZcfGSen7rSNyu0vQQm6VG8qtTQ8DUWJne7PJ2aaiZ8EMn+6vZOZcU+mt9rDEYA+043PxvRlfHcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(366004)(136003)(31696002)(83380400001)(66556008)(16526019)(8936002)(38350700002)(956004)(66476007)(38100700002)(53546011)(54906003)(52116002)(66946007)(31686004)(186003)(2906002)(478600001)(36756003)(6486002)(8676002)(26005)(5660300002)(4326008)(16576012)(44832011)(86362001)(6916009)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T0c5K1Y1LzRjYjlEdkZ5dTNTTUQxWFlVNTBKUVM5UU9kazhtbDVOS3hsOENW?=
 =?utf-8?B?TkNWRmhTaCtTeWV3bVIwWlQ1Sjc2MlJZd1IrM1g5YTBCRmwveldQZ3Bld3A0?=
 =?utf-8?B?Tnp6WEw3RWdUY1labUUzVVJYUGd1NXR5UkpBYzUydWJ5RnBiTkd0R2xKZHli?=
 =?utf-8?B?WmRSYUdwbFh3SnZvL01sSVdJamZVa08xdmlYUkFxd2Z6OU9sdjBETGNGUWwr?=
 =?utf-8?B?UmswTEZKcGVUNnBKcU1vNExwSTkrdE8wejRBOXVudVFJVXNJNDdPY05qZFFV?=
 =?utf-8?B?a3YxV3FsUVljTGh1NDlyODRuOWpDc1dZOHhmU3QxbXgyTDdrV2VGNjNEeUlp?=
 =?utf-8?B?NjRUbVk1QXZTeFFid0p0Rms5TDgxVTJQVVZhMi9ZSjlYS20xYnR3U0t4Y2ZL?=
 =?utf-8?B?MkxpdWNyRUR1QitBb1ByS2RrR0xSTUNISHRtcGVRVGZ4NW8wbm5rMlk0WkpW?=
 =?utf-8?B?MzNvWmFTWnF6cWplWnY3UVdXTUV3NURtUWFsaDB5R3RVdnNxVGRvK0U2K2hs?=
 =?utf-8?B?azNDaHc1Y3RuZzJtTGJxMnJWaUdlbmtvUzNZRk9JQzBrMHZOV3ExSVRBQ2pS?=
 =?utf-8?B?ZFc2L3EwUEdIRGxpUmNWYlpHL2NsUTdESkRxeU9FTFFLdlZUMFFzM2NsWG9l?=
 =?utf-8?B?amRsMTA5c0UrcDFpRU1kME1jdlNyL3dNY3hwSFdFeUhtcmFOTlNxNjd3V0s0?=
 =?utf-8?B?VkJid1F2YXluZ1NuVGlBdGd6ekgvaXFQai8xU3pPQ2hpNTBXdW9JZThFa0Rj?=
 =?utf-8?B?VExHYTQzNW00NHhRUnRyUTdDc0dEdE5MMFFBNzdoRm5zOG1QWHdsSXl2N2Vj?=
 =?utf-8?B?RWtWN2pNcjRUUE13KzFFMWdWc3cweWYrL1FQdTVKdWFQdDZIVGVmN0E5SWhy?=
 =?utf-8?B?TFRCZ1FFZ2ExUmtaQ3dQUnN0SlVUME9Jc0Vkcm5GeE1RaXE1K3JlKzdpY2Vq?=
 =?utf-8?B?SkNJZVQvdGdqL201Q3JyK3V2VFNpc3UreE9wek9vWFUwNURZbXp3azdNUXds?=
 =?utf-8?B?aFZKTCtwWWlweThoV3FvaVpxYmRueEZ4STZoY2M4bjczenpCcVVLck52NG5o?=
 =?utf-8?B?SFJadjU3cVZIci9DUVRZSE5LTUZOUHVTZXVwOTJzaWp1bEJFbUZVam1aRCt4?=
 =?utf-8?B?SlorMmgreWdKMytXYWYzTXlYN2ZEVFJFcnJvRkVheWZ1ZjFhNDB1dklUVWc5?=
 =?utf-8?B?QldUOUtjWCthZEE0Q0RUcjFlYXBLVDNaK29oKzhMN2NnWS82aThtek9Fc1Iz?=
 =?utf-8?B?VGtLR1dyeUlQRXMxSWNiSWNYT2RIcWc5Vm45eDl4UFBXcHBheFpoWE1mYjgz?=
 =?utf-8?B?WUlqUlU4eExlYVFyU1pWSGFhUVlkRW1SajNyalVlM1p0VFpJOUQ5V3JFazN5?=
 =?utf-8?B?TDV2TENwU29UZmQweXgzejVXblJTbFYrOSt2U0M1alAzZUpmZjJzS3dicmIr?=
 =?utf-8?B?YXJYckpqc0tJV3pmcVR6dVVzT2UzZFQrcXE5TWdIT0J5a3k2aVlScVdPVFRZ?=
 =?utf-8?B?SUtDQjE4NEdmdm1hbGhScFEvS3htNFRobFJtWjVWRHpPYTlZdlVmVjg4Z2R0?=
 =?utf-8?B?djVmMXdLYllEbGZXUkU1TmhnSHhPdTY2STFQcys1NkpYNXpscnQvUlVFNEpV?=
 =?utf-8?B?bzlBd05WRk9WMTN1bzRBOGpvT0dBRUk4MUlyS0tRTm9zQ21idVJNb2hCUDBh?=
 =?utf-8?B?UVF5MXN1eVVZb1VOSmdEeXhCZWEwRVFwRkRVTWdwNmhRQ25hN1Q2Y0doU3Iy?=
 =?utf-8?Q?qrlvggEXzylMQoNSF3IY9aeyZ8ZghFA7skwKvR0?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2be332-d677-42fb-686e-08d9032758ed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 11:36:18.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPPajQaL3iR6Xn2N7UVhPjBidUCpUlCZ89QcRea6n8fQ09o/fbS3a9ZHMIE5FWOAdq7w8llzcCFaKlOxHjIZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5421
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/19/21 2:14 PM, Andy Shevchenko wrote:
> On Mon, Apr 19, 2021 at 1:29 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>> On 4/17/21 3:39 PM, Andy Shevchenko wrote:
>>> On Fri, Apr 16, 2021 at 5:21 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>>>> Add initial support for Murata SCA3300 3-axis industrial
>>>> accelerometer with digital SPI interface. This device also
>>>> provides a temperature measurement.
> ...
>
>>>> +       ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
>>>> +       if (ret < 0) {
>>>> +               dev_err(&sca_data->spi->dev,
>>>> +                       "transfer error, error: %d\n", ret);
>>>> +               return -EIO;
>>> Why shadowing error code?
>> Returning EIO here to have full control over the return value from this
>> function. As return value of this is used for testing
> Care to show what kind of testing requires this?
> Also why can't it be refactored to accept all error codes?

I was referring to this:

+static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
+{
+	int ret;
+
+	mutex_lock(&sca_data->lock);
+	sca_data->txbuf[0] = 0x0 | (reg << 2);
+	ret = sca3300_transfer(sca_data, val);
+	mutex_unlock(&sca_data->lock);
+	if (ret == -EINVAL)
+		ret  = sca3300_error_handler(sca_data);
+
+	return ret;
+}
+
+static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
+{
+	int reg_val = 0;
+	int ret;
+
+	mutex_lock(&sca_data->lock);
+	sca_data->txbuf[0] = BIT(7) | (reg << 2);
+	put_unaligned_be16(val, &sca_data->txbuf[1]);
+	ret = sca3300_transfer(sca_data, &reg_val);
+	mutex_unlock(&sca_data->lock);
+	if (ret == -EINVAL)
+		ret  = sca3300_error_handler(sca_data);
+
+	return ret;
+}

So this goes into error handling only when transfer indicates EINVAL 
(which happens when

transfer otherwise is good, but device return status has error flags set 
i message).

Thanks,

Tomas


>
>> for possible status error (EINVAL), feels more confident to have it like
>> this to avoid any confusion. And atleast spi_sync_transfer() return value
>>
>> would be visible in error message.
>>>> +       }
>
>
