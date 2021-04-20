Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0575A365491
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhDTIvN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 04:51:13 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:41664
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230168AbhDTIvN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Apr 2021 04:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOgFgFlGAwZhTduBbZacmD+YoGWTnHg6ZY/ccsv4MF7tVwWHFWwqXAwlgC9/gADsC6cH2up/xJeshrot0vDbBTFU4gX+52jD2yhT5gzOE9uMRHrNOsW9Y+AcPw1eenWgQXxOyZF5CjOYnxe0kQxLtnXh4xM2vz3XW069dL33Jn+C7Mnv8+Hw8S3Un42zob6viZ4tz5EdosRK8EkVk6cL+w4sNgHdbnb9h0wt9DO3vfYkfObrCEp2ajyDTsvULemSIvWxksagz9THpC+dKtTpZW36DzTMCpdACGZuiNiuC94QjBxWqlE/MTYcswhTCBOztPfWfZYRZXRgcsb76fHsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE0wEbJH0OkVRVaIcrDZzZjwu7FHjokmgO2050PQJ9A=;
 b=HQDoXFrkvnlafuB0AjQrfc17EkwlzaNqQ/yaq7SrRS3zmDaxmTtHi99Ut439PDHJhUuF6NCMG681qn7ccH+giMuxjevHGP/iBHnvpRDwUJniypyFb3fInFekw2MyFivbi0wA+8jgcf0QxEUTKykz2mmxRBNiS8APzj/rxdmhWdceaGa61dHGcuY03PU5OrPkSQbSoCKN07jvxS8qrv6Y06IPyOKmTgPBH5bL01WoHAbpwUHEQJ0rReJhui8iMZwNZNnRjyLizUCpGs3lepBFjN8bPFvC9n2atxhBZvo8+HAaqqr9pudHd0Pnovj70q3lcbG6r4nG7V2QqrfITPrw6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE0wEbJH0OkVRVaIcrDZzZjwu7FHjokmgO2050PQJ9A=;
 b=T5nJ5fJO6tSz05XvwnqQRu34PtQB28eO2aGzYQBONuA8Y7UzsiHfpNTl5h0KaKeij7UK9vZjKyW8XsMm5WvxaQySqDCg2zJwAJkSFo5z0DMV9b6nSoDqfk2ROQVQ0JLV4OhKBVi6MkuY1XedAYQzROq0SG/qEhCGHygKl2eyLqkMifFttyC/IlstnUZysRlA8BCZLeE36HXr5rZeZ5bQrNWD2Q05kGNdGvQ0jJb/oI4af638mR+o6ALQr1GPda5kyI+LFHhvlLcNUq+SdKNxdPHmKyqeIwaNnj3nWBt7IusI6rHaERRcQKHH5tN91o2jC4/hdYCrJNQhXlk/uiHNrQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB6800.eurprd06.prod.outlook.com
 (2603:10a6:800:18c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 08:50:40 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:50:40 +0000
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
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <bea4dc56-b860-431c-a820-a482ce87743c@vaisala.com>
Date:   Tue, 20 Apr 2021 11:50:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <CAHp75VdApCk_Ydt2W_WWJ_wme4d1ocrrnvo+TjZcQ62RG6uOUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::15)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.132] (85.156.166.106) by HE1P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 08:50:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5834f194-f502-4fce-fec1-08d903d95fa4
X-MS-TrafficTypeDiagnostic: VI1PR06MB6800:
X-Microsoft-Antispam-PRVS: <VI1PR06MB6800514ACBBE439C12FD8671FD489@VI1PR06MB6800.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaIhEIrQn37/Cz8FtLko+PcW8lLAsDtaYPTbhnbsoc3App172uGt3pdwsjPsmTZQ8ga+Dc9MggvkC8+dLaRPz+nNxn7ZXbRnDqsHdbInM9MvKgfzUzS8o0pjDQOmzjWivyfomRebxRnPfLshkdPuHnFFnfrFipgx5whlZPXhC19vJr1RDXW9/IZkVPiABCc8jCgTsExBIjXf0hBM70UADKg66cnaUnBQ3BjoZkDdJngmopLxE5WTMJJzE1J4hMfAmc+4s3Nbc1mm4aezrw6gxx9zqBw4wZycORUO4o48TTXOnYsbl5t03aE5vNvU3MDAaJUONw1FNErROhOi/c8TV2IqAMtU3vhPlHldo36Vq7K5K4m/UgFaQf1g8l7vgfLAey9Bm8ZBi9gwXvekWyjc1czXaDJv92cjno3ocwRaCzy8k094n4oG140LRF2s3KyKoau7c7rKEePxfl+hmkFx1EODeJAFUAXpLv5Fa0IpEGpY3c23grwluDYTaM+CnoWm7R/TRzPScqVlla1g062tXzhnk+w0sv5Wj+WLN0wX/xBBQEJ2SCwcORRji6s3aCzEM6qa9fT5N2RzPoZeIV8AHQQfRggYLusXsHGBRkDgL7I10ZPTapgpQg9Tk0cnJTl0fR2Br3u3rrgLwubImWi4n/wTzRbszjzyLk6RTNihacSEa0iBFrmC12A8Emb2VxrJ+VQaMheCvPo4+UjMOPNtUbmjehVk8N9NGRLcRlUiHIN5jnxUkuT5IC8IyS93mgxz06EoRe96hw9jGknQOU3TyxET4EtJd+A1jjuAZam2XGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(26005)(54906003)(16526019)(5660300002)(8676002)(956004)(186003)(2906002)(6916009)(16576012)(86362001)(316002)(4326008)(31696002)(45080400002)(66556008)(53546011)(8936002)(478600001)(2616005)(66476007)(966005)(66946007)(44832011)(31686004)(6486002)(38350700002)(36756003)(38100700002)(52116002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGJsejlDb21Sd08wdW5BSktPRnNBUElZVFhkbkc5eVJWa1Jtb2s4SHJMZzdz?=
 =?utf-8?B?dEZPbHlsVHJVQ2sxRDdqUVIvaVUyelp1NXMyVzRhVlhzT2RRbVRhNnkzdGE4?=
 =?utf-8?B?ajIvTHh4ZmxWcy9TUUlOSzNNYVBMMGZlcG4xR0tDOWRnWnM1ZXFhUzhwSSt2?=
 =?utf-8?B?NlNnc1dXdnVabG8xa1RTcWpGZW1ZNUhFRzhNK0VvS2E1YWpMMHVxS2dIM01Y?=
 =?utf-8?B?VE1GZXRlRkJ3dGp1R25LRWZuMTdDV1hUOU9FS0FRR2drb0w3RzVKZ3lYcy82?=
 =?utf-8?B?Y3BGQmprVmFCWFRDR1B1V1VUU1c3TjVjUlp6N0dla3psTHRwQ051ZTNLanZq?=
 =?utf-8?B?K2UxM2o1NVFGWG16dTRFSFE3c0dmR04rczVlOWpzZlRObFhvbWlLTzZzdHVm?=
 =?utf-8?B?RUxoNnhKY0UzMEdoVS9wZUt2ejU1TzZhS3VzcHBaU2pBaXBKUStZeitxQ1NO?=
 =?utf-8?B?d1RGd1c1SXJzYVhBcWpEaW44RW1RWmtzbEJpaGw5NG1jbHJOeHpNT21Pd093?=
 =?utf-8?B?MlpKYlZZTDZ4Zy8zS0RQamJrcU9pNjY4VlFFSWllMDdGZmVxNVpNaExySTcv?=
 =?utf-8?B?cGRhRys4cGsyV3FYK0N6WVU0a2U0R1ZyNGR2a0h0QzczT1RGei9IMnBoWWdj?=
 =?utf-8?B?bVpmYUQ2STA0d1pZNmFVMXpNZ2c2RU82L1VLSkh5OXdPckd1Rkw1SGJURFUy?=
 =?utf-8?B?Z1F0MmRHcnJkbHlMZXdGTmJua2phTXBsWjk3SXU3aHpBamNEZURTVzl1YmU2?=
 =?utf-8?B?R3ZzY2lDTnJqWFN2a0RNL0pXVXZ1Q2ZWeVJNYkVBMkFhbzI2eW5NUW9ka3Bx?=
 =?utf-8?B?MmtGdDdsZ1BMUTlnTXdvbVl1Rzcra3pNU002M3JEcnhoSzVicldxcStQbHkx?=
 =?utf-8?B?MUNlUDYzN3BoeGc2MUxkaG1XVXdmQ3pEOWc2REdpTWZ5c2pwVXIzV3psNFF1?=
 =?utf-8?B?elY1VGZNdDBhWW9ZbWo1LzJFOU1rM1pwQ3oycllVUUdKMWV6d2dIMFlHVWdV?=
 =?utf-8?B?QklBMXFvc2RIY0ZpaXY4ZXNBTDhEMk4xT1VpNEI4TTBTK0J4TlZVdmEwbW1v?=
 =?utf-8?B?TUZua2kxcTFsK2pFOXJzQ3hvcnNqTUxzYzJjdEpIeERDR0lRQ3ZNVG1IMkcv?=
 =?utf-8?B?QTdEWmlXakx5NHY5Tnc1cUZrQVl4bDIzdTJoM3UzUE1US2RsUmhwbGVjS25Q?=
 =?utf-8?B?SlBkZW9CdTl1bUkweUdtbXBrTHVHNndrdUIwSXRoWjJJQ0NxZnpxMHFVWjNr?=
 =?utf-8?B?MHV2L3dZcTB5cDVMVHBQanpZM1c0TEFxMmlablBsK01KN2FuL0djeFFoc09R?=
 =?utf-8?B?b1RyYW9BaDJ5UmdodlVVbnp1MXk2aUppWU1tWkhoNFBwV0xpVU54cjBiM0J0?=
 =?utf-8?B?d1NFVUZiYVdEZUNmRkZDeFo5a1ZqQnAyRnA2Z05oSVRkcXBsb1NqZittTmto?=
 =?utf-8?B?YWlMM0MxWms4NjA4OU9lZytWYkxDdGdPa3ppdEsyRmpESm5uVUFlL29yUDBz?=
 =?utf-8?B?VWhZYWsxTlZHa3NpS3Jiamd5SXlMdnQ5RWJVVHlYOTJNUDcxZDJXU1EvYk9L?=
 =?utf-8?B?Rkk1Vk9XN0RoOEtncWFPS29iUGI5WFFsNWQ2Vm1WQjFneVFhSFZpZUN4QXNK?=
 =?utf-8?B?Y01mWWY1YVhpWW1WOHlQVjJhVGhHZnZkSDByemtqQVlpWTBERVpFZzZOZGIy?=
 =?utf-8?B?amxmWmJJRTAxK2V4T1NTS01BVmEveTZSQjBiVDdqTlJXdlJwMlNZS1JFUngx?=
 =?utf-8?Q?HWM7xrz0Fj0dQ68WeW2+fYuXHuFNqLuFlcKa6Qv?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5834f194-f502-4fce-fec1-08d903d95fa4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:50:39.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6JtVOHxin3tX8nA6XkJVATvHPROxxAhmK0Uz3Tu+PXIyto0Qgmq8Up2uexaItEzexbW1CRIdIZ6yNKzNi8oTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6800
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Thanks for further comments, see some answers/questions below.

thanks,

Tomas


On 4/19/21 4:55 PM, Andy Shevchenko wrote:
> On Mon, Apr 19, 2021 at 4:26 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>
> Thanks for an update, it's getting better! My comments below.
>
>> Add initial support for Murata SCA3300 3-axis industrial
>> accelerometer with digital SPI interface. This device also
>> provides a temperature measurement.
> First of all, you forgot Cc reviewer(s).

Ok, thanks for pointing this out, will add you as cc next round.


>
>> Datasheet: https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.murata.com%2Fen-global%2Fproducts%2Fsensor%2Faccel%2Fsca3300&amp;data=04%7C01%7Ctomas.melin%40vaisala.com%7C5259ef3cd4b645f3a7d208d9033acdc5%7C6d7393e041f54c2e9b124c2be5da5c57%7C0%7C0%7C637544373362508656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BZue5RQjrHWtRzEOGZAw1Avb35QKLYu0ZOnXbyj9EE8%3D&amp;reserved=0
> No blank line in the tag block.
>
>> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
>
> ...
>
>> +/*
>> + * Copyright (c) 2021 Vaisala Oyj. All rights reserved.
>> + */
> One line.

Opted for adding Description line to this header, thus planning to keep 
as multi line.


>
> ...
>
>> +#define SCA3300_MASK_STATUS    GENMASK(8, 0)
>> +#define SCA3300_MASK_RS_STATUS GENMASK(1, 0)
> This feels like an orphan. Shouldn't you move it closer to the group
> of corresponding register / etc definition?

Tried to group these in alphabetical order, but IIUC preference would be 
towards grouping

according to how they are used? Would this be clearer and acceptable?

1)

/* Device mode register */
#define SCA3300_REG_MODE    0xd
#define SCA3300_VALUE_SW_RESET    0x20

/* Last register in map */
#define SCA3300_REG_SELBANK    0x1f

/* Device status and related mask */
#define SCA3300_REG_STATUS    0x6
#define SCA3300_MASK_STATUS    GENMASK(8, 0)

/* Device ID */
#define SCA3300_REG_WHOAMI    0x10
#define SCA3300_VALUE_DEVICE_ID    0x51

/* Device return status and mask */
#define SCA3300_VALUE_RS_ERROR    0x3
#define SCA3300_MASK_RS_STATUS    GENMASK(1, 0)

or then only adjusting current sorting with comments, like:

2)

/* Register mask values */
#define SCA3300_MASK_STATUS    GENMASK(8, 0)
#define SCA3300_MASK_RS_STATUS    GENMASK(1, 0)

/* Register index values */
#define SCA3300_REG_MODE    0xd
#define SCA3300_REG_SELBANK    0x1f
#define SCA3300_REG_STATUS    0x6
#define SCA3300_REG_WHOAMI    0x10

/* Register read/write values */
#define SCA3300_VALUE_DEVICE_ID    0x51
#define SCA3300_VALUE_RS_ERROR    0x3
#define SCA3300_VALUE_SW_RESET    0x20


>
>> +#define SCA3300_REG_MODE       0xd
>> +#define SCA3300_REG_SELBANK    0x1f
>> +#define SCA3300_REG_STATUS     0x6
>> +#define SCA3300_REG_WHOAMI     0x10
>> +
>> +#define SCA3300_VALUE_DEVICE_ID        0x51
>> +#define SCA3300_VALUE_RS_ERROR 0x3
>> +#define SCA3300_VALUE_SW_RESET 0x20
> As above it doesn't shed a light for the relationship between
> registers and these fields (?). I.o.w the names w/o properly grouped
> (and probably commented) are confusing.
>
> ...
>
>> +/**
>> + * struct sca3300_data - device data
>> + * @spi: SPI device structure
>> + * @lock: Data buffer lock
>> + * @txbuf: Transmit buffer
>> + * @rxbuf: Receive buffer
> Are the buffers subject to DMA? Shouldn't they have the proper alignment?
Good point, I will add alignment.
>
>> + * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
>> + */
>> +struct sca3300_data {
>> +       struct spi_device *spi;
>> +       struct mutex lock;
>> +       u8 txbuf[4];
>> +       u8 rxbuf[4];
>> +       struct {
>> +               s16 channels[4];
>> +               s64 ts __aligned(sizeof(s64));
>> +       } scan;
>> +};
> ...
>
>> +       struct spi_delay delay = {.value = 10, .unit = SPI_DELAY_UNIT_USECS};
> Missed space.
>
> ...
>
>> +       sca_data->txbuf[0] = 0x0 | (SCA3300_REG_STATUS << 2);
> Seems you ignored my comment. What is this 0x0? What is the meaning of it?
> Same for all the rest magic numbers in the code.

Sorry, not ignored but will remove this redundant 0x0 for next round.

>
>> +       /*
>> +        * return status error is cleared after reading status register once,
>> +        * expect EINVAL here
> /*
>   * Fix the style of all your multi-line comments.
>   * You may follow this example.
>   */
Ok, will captialize sentence and add punctuation.
>> +        */
>> +       if (ret != -EINVAL) {
>> +               dev_err(&sca_data->spi->dev,
>> +                       "error reading device status: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       dev_err(&sca_data->spi->dev, "device status: 0x%lx\n",
>> +               (val & SCA3300_MASK_STATUS));
> Too many parentheses.
>
>> +       return 0;
>> +}
> ...
>
>> +static irqreturn_t sca3300_trigger_handler(int irq, void *p)
>> +{
>> +       struct iio_poll_func *pf = p;
>> +       struct iio_dev *indio_dev = pf->indio_dev;
>> +       struct sca3300_data *data = iio_priv(indio_dev);
>> +       int bit, ret, val, i = 0;
>> +
>> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
>> +                        indio_dev->masklength) {
>> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
>> +                                      &val);
>> +               if (ret) {
>> +                       dev_err(&data->spi->dev,
>> +                               "failed to read register, error: %d\n", ret);
>> +                       goto out;
> Does it mean interrupt is handled in this case?
> Perhaps a comment why it's okay to consider so?

IRQ_HANDLED seemed more correct than IRQ_NONE. Or did You have some 
other option in mind?

How about something like:

     /* handled with errors */

     goto out;


>
>> +               }
>> +               data->scan.channels[i++] = val;
>> +       }
>> +
>> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>> +                                          iio_get_time_ns(indio_dev));
>> +out:
>> +       iio_trigger_notify_done(indio_dev->trig);
>> +
>> +       return IRQ_HANDLED;
>> +}
>
