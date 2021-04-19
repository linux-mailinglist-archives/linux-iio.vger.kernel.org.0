Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6DE363F9A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhDSKaQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 06:30:16 -0400
Received: from mail-db8eur05on2066.outbound.protection.outlook.com ([40.107.20.66]:19455
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232548AbhDSKaQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Apr 2021 06:30:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPQHbUGxcyiubBnqdhdGEmwS9O+aKs5XWvyAfalcRLmkwYtgICYRtzfQ16gkUWPg05+S57ITHGeXEWOJLTPo6/5fcflH+8SmnXp8skyyYwbg+WN9sOBGVADn516/yascvC74HwU444R9RCEXJAwqJcI5a/Xp2ondneoHiaTJeuM6HZdjLpLKfmfork6yqt96+Zmd02edIkVFx4tnVtxuAs1cVHy1vd1d6i5gqqmveW/1xI50w0Df7+V4oNznCeRtDAJ9Xsl1FO38nm0hfBJT6if6PtdR3m794hg5bHGuHBojX3IprXddQ4hMSCTitgV/nC9P6FFuO8078d0IF29eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPKWgZ3oNSAEnn0yDeGrwQtig2GPtBZ+so/speMwRtw=;
 b=EFA0gmDF7jE8wEM0FJekYwVdaGigPv9QdgRvmHnOMYNTt7+sOtxs8i1oaJ+NnsLzKkscCCUx4dIA1nZzC+1aDuec+Ve75/798gS7qEXlDwVxu3e1TzHvcds+3TNXy/HDqnzGi6UMk/nGqpH2UENNHyeoaLfG8O1u4SNo7jkhlkT/Iz2lX1qQMd/axaiH5uyeOARv19TGchdqrHq0xqNVPHpUJ0jXmX9rjlkbUdxHTZrvmWps3QcRLTsfwrGFVNqvRcSpArbrr36t+Lbo02pa1smvq79duq6DfWDffwHrR8Loq2olXPOUFc3IlXNOH7MNfa5FQDgqjZKRKtGvAfSQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPKWgZ3oNSAEnn0yDeGrwQtig2GPtBZ+so/speMwRtw=;
 b=qKVj7fVAmCRbKfcE2gNUYYKzYzx//nVCFlNv5mPMi8NfNoTNMsSSU6krkMlNUIkDRxBelyus+25Puf/eO5fe/drhlYxoIF+mtc4IBahUM/tFeG2HQTK1E73mFeifEHskJgAmqrDtddQJ6ixkAR1g0N96SQn4yThuQ7buwiJWQsPMIECRG84Jps9LVbZQBcTdwcOGaHlzxjZDlYOAFXi7BLcZw4jL3yDBB90aRnBCdToPVxPXClkIcpS4JHMPQIA0/WImERs+IY3HOnp4MUgZ/PN0/mr5SI8+rg/BJDo+jDDJ/iaG6enXv0TCs2kBCyvs2Q6VyY2xZlyQNzM0hY3e7w==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB4173.eurprd06.prod.outlook.com
 (2603:10a6:803:76::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Mon, 19 Apr
 2021 10:29:44 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 10:29:43 +0000
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
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <91ea3aba-854e-30f1-1236-733debfcf5dc@vaisala.com>
Date:   Mon, 19 Apr 2021 13:29:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CAHp75VcibWup79np=xeQpO2z+OGCFXPhL6vWL6aWRZ+G8+djwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: AM0PR02CA0181.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::18) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.132] (85.156.166.106) by AM0PR02CA0181.eurprd02.prod.outlook.com (2603:10a6:20b:28e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Mon, 19 Apr 2021 10:29:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df14890-5c53-4483-a8ba-08d9031e0c0a
X-MS-TrafficTypeDiagnostic: VI1PR06MB4173:
X-Microsoft-Antispam-PRVS: <VI1PR06MB4173F042D8962A324F44D7AEFD499@VI1PR06MB4173.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bWlNoe7HT+Oi4vBMsOtPotci1qnjeExnkSm5UHDnG8zdDmzYK84CiOJkurDG9QsKzvUyIwosagaSNQ/vUOoHM6PgVrMnUWN5wukOxlh5l6ubIlSHy+GzQExBfWYWnZWQFoYx8GlKeq1kxAOgzkeX3YSVxDFQGY9rHhFJLWNsDDcNe4Zr/7/Yy/uRSokfJOLzStcVHzvcxRJgElB3DHGbS7q0DXE4JMMDO8LD9qc0TyDqzlSIrdWAcN8+lMvEYIZhLay1Qq+ktKl2Nw03bKqMOjp0OAlJZ1U8wCy2kdMmSZJYJlSkhFgJdikW2qASqlXg59tRkFYspdZcqyQ3YPNQu2GCGv+M6XGYvLnKNvEgzPQEfXJ3mxWATsUSH6IfBwSZd4xO940XdwUoA1xjNVFYzxNJjADtYIv4JJ2SBCSZkZVkIcbUCgLoedunx6EAKHUjW+HeXQcKzsgcdjdSQO6WDIrhIiVbr8FZRTvsw+q19r/sJTi77DBZF2FgmBwgXWTlfcAX0TyerVMArHf3oe9skHVzuMUDsgP/pTn7PwKd9giqdfdoc/O5ZpwqaULFvlQbo6+pZ5ciGaL+YtsiavIXWmgjPlm/HYBDfUJTSZWHdqjwXvSY6suOp2pb9okqFQ7LlNF9K8JX5K6czYKyhGdOVh+brVlcC6TSoj2OnlkE53As7KagQolTRwfCSMV8/W6fx6D+f8sQYzZTzILd4Q281oYkiKvgVsDaa+0g7GkeDwv7Aj1bovC0hM2ZMGsply7OgKCcAeV/SQ5tslzRIiz3sM+NzI9X8IVAIEInxZB/vV3YyrNTPudA7a7OlkVaXNk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39850400004)(38100700002)(86362001)(38350700002)(52116002)(53546011)(44832011)(2616005)(8676002)(66476007)(66946007)(66556008)(31686004)(6916009)(31696002)(83380400001)(54906003)(36756003)(186003)(16526019)(26005)(6486002)(966005)(2906002)(316002)(4326008)(956004)(8936002)(478600001)(45080400002)(5660300002)(16576012)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVVtd2VVMXhsVFZhVFUvdDZzMEZUb3J4SkRHc09ZckJjTGloVDZVb2NxcjBs?=
 =?utf-8?B?YUZvQ3RtQUNPb0lwT1M2bFl6TTJBZjVycEhEaE1iSk9aVHhlUXY5OFFEVzRH?=
 =?utf-8?B?d2RwUnVVOWNMSzIwNEhmVlVLSFQxcU1HbDhPVjBYNFFZYmtFYVpGYW1ObFlX?=
 =?utf-8?B?N3Mzb0JXbTM0NDFERStNTE1JNTN6UUpwOGxyUkpidU1XNUkycTZ1RmIrVzdv?=
 =?utf-8?B?MnN0Nms3MXdSd0hFTE10NGlVdDZydFo2SHhqSVl1ZFBPeGQxOFVZR2ZhYTlS?=
 =?utf-8?B?L2dtZWJNK1I2eTBkRjlKUlhMa3l6MmNpYmRxMW12UUlTR1pMK3orenc2cEZq?=
 =?utf-8?B?VmszZ1hockhUV0lWblpBdytBMEdTdHg1RSszbStwdmNhUkI2Z2RydXJvMHFO?=
 =?utf-8?B?bVgyZlc5TmkwK0d0MHc4MnozRVJlUjEwQk1HZ3UzbWFHblcvTkVveXVIazh5?=
 =?utf-8?B?cVJycmtSaFdEWC80cHdzb2kweG9ucDFiLzNPZjVsYWVjUDU0SVR1cVZqa1Ra?=
 =?utf-8?B?ejBPOWx3d1gwOTBiemJBUEdiaEZNZUJVSXBOeHlFZ3pFOWtsMVlVdUJaa29p?=
 =?utf-8?B?S0R4MzdFLzlhei8rTU9XRDVYUnEyRW8wZGVjKy95ajczUlJIVDZpU0IwOCtv?=
 =?utf-8?B?ZkZBN1A1NkYyQmhDQm9WYVFCOXorL2lHM2ZSTmhRaXQ2V1NMWDZHSVp5L2h2?=
 =?utf-8?B?Uk9WTDQwQ2xGU0NaKzYzbEhaU0xVNVhLbDJIcVl2d29JQUdWdksybWhIWmVH?=
 =?utf-8?B?cERGWW1DWndDZEJEUkU1OEhQUDlkeWc4WURnc1dJRzZoZ3BvY0tuYUQ1eXRJ?=
 =?utf-8?B?dVVRbWJBS3gzSXdWY0xRRkZHWEtBT1ExYjQ5YWNBVzNVdEFodGdNTE5lbnJ6?=
 =?utf-8?B?WEtFVmxZa3VzSDZzWm5reEVPZlpaYUtJaTlpTmlBdzRQMFZtSnVocWdxTlcr?=
 =?utf-8?B?WDdXRGdVYlFWY24zcjkyT2J3SEpNdWEybEp6WkhnUW1MN1Z1aXNzM292VGU2?=
 =?utf-8?B?UXlCSFVkQ1piMjhtQnBmNzIzN0RGaHdZSTEyK0xEdFBZb05kcHpvVVBEaW9t?=
 =?utf-8?B?U1B5QVN3ZUxESnlGQW5kcnh2ZVdXWXZxTzM2YWx6TVlUYm80NnQ4ZmV6dmN1?=
 =?utf-8?B?R3g5R0VsTk1ZSGE5ZklMSEJFSDEzeWhKUCtVNEoyTTB4UnJkdEhNbFJ0eHlN?=
 =?utf-8?B?dzlsQk1yVHN3K1RjbGpDMnlOZUZhSDRWWlZHTjFCMGk5cjNKR1QwdElzeVNz?=
 =?utf-8?B?SUNXc240c2tDZkZmVmNWN2c5NTN2cXBsRmVzdk5YZS9SWklLd1BmMk5NdHVo?=
 =?utf-8?B?WGRRWjRQR0tlRDR5M0pKY2c4T0ZxK2tLNUFlV2NVMEVJT3RzWjNzb0tlWC9E?=
 =?utf-8?B?bkJmbVBBTWlRaGV1NHRQUjhoWmprNXd6WGRuTGU3OThQeTVTSjBZNUpDSVQr?=
 =?utf-8?B?N0xVYjZFNzBHNk41cEpBR3Y0WXNLbGJ0SzRHN0szMDdEQzhyZTlSYTBEbzlt?=
 =?utf-8?B?MFpUNFZ2eGFnZVVJMlZZNFRjY2RURWFPdnBsTy9YNDRJWjdMTVFRNmIzQTVa?=
 =?utf-8?B?NXljdy9NaTdTWEVrMVhVWU5nekEvY2owMis0eUphcWtnLzhmajVsSyt5MFVz?=
 =?utf-8?B?VGJFYWFkMlFLUHdQdUVzUFdTQm92NlNrcVRpdFBCdERoUzBVOHFLbytxN0RM?=
 =?utf-8?B?b2FyZVBKMDdrYktmVG5iRkp4STY2bHR3NHBDZG5tMFlhbXZ0VnpqSjM4a1pm?=
 =?utf-8?Q?IS/o0jJMtNwDYhowda6z0nYadKFuOLDUi3gzP04?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df14890-5c53-4483-a8ba-08d9031e0c0a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 10:29:43.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiREk+dWtsG3P3hBtKuZsycTj2CRHuERnp/4lNFUSBiIzGpEXvcSQLPC+9TU+B3B5FYe0p0j3S9bIeLymjSR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4173
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Thanks for the comments. One reply below, otherwise implementing these 
improvements

as suggested to next version.

Thanks.

Tomas


On 4/17/21 3:39 PM, Andy Shevchenko wrote:
> On Fri, Apr 16, 2021 at 5:21 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>> Add initial support for Murata SCA3300 3-axis industrial
>> accelerometer with digital SPI interface. This device also
>> provides a temperature measurement.
>>
>> Device product page including datasheet can be found at:
>> https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.murata.com%2Fen-global%2Fproducts%2Fsensor%2Faccel%2Fsca3300&amp;data=04%7C01%7Ctomas.melin%40vaisala.com%7C7b536921ec37446568bf08d9019dd944%7C6d7393e041f54c2e9b124c2be5da5c57%7C0%7C0%7C637542599730610545%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VulPc9WnmQMJJZpYZfHmAuFPeDhclwt%2F5uPw7iYx8fU%3D&amp;reserved=0
> ...
>> +static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
>> +{
>> +       struct spi_delay delay = {.value = 10, .unit = SPI_DELAY_UNIT_USECS};
>> +       int32_t ret;
>> +       int rs;
>> +       u8 crc;
>> +       struct spi_transfer xfers[2] = {
>> +               {
>> +                       .tx_buf = sca_data->txbuf,
>> +                       .rx_buf = NULL,
>> +                       .len = ARRAY_SIZE(sca_data->txbuf),
>> +                       .delay = delay,
>> +                       .cs_change = 1,
>> +               },
>> +               {
>> +                       .tx_buf = NULL,
>> +                       .rx_buf = sca_data->rxbuf,
>> +                       .len = ARRAY_SIZE(sca_data->rxbuf),
>> +                       .delay = delay,
>> +                       .cs_change = 0,
>> +               }
>> +       };
>> +
>> +       /* inverted crc value as described in device data sheet */
>> +       crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3, CRC8_INIT_VALUE);
>> +       sca_data->txbuf[3] = crc;
>> +
>> +       ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
>> +       if (ret < 0) {
>> +               dev_err(&sca_data->spi->dev,
>> +                       "transfer error, error: %d\n", ret);
>> +               return -EIO;
> Why shadowing error code?

Returning EIO here to have full control over the return value from this 
function. As return value of this is used for testing

for possible status error (EINVAL), feels more confident to have it like 
this to avoid any confusion. And atleast spi_sync_transfer() return value

would be visible in error message.


>
>> +       }
>> +
>> +       crc = ~crc8(sca3300_crc_table, &sca_data->rxbuf[0], 3, CRC8_INIT_VALUE);
>> +       if (sca_data->rxbuf[3] != crc) {
>> +               dev_err(&sca_data->spi->dev, "CRC checksum mismatch");
>> +               return -EIO;
>> +       }
>> +
>> +       /* get return status */
>
