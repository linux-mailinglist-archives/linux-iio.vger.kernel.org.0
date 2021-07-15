Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248B53C99D9
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 09:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbhGOHvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 03:51:25 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:10976
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231785AbhGOHvY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Jul 2021 03:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU/QE9KGg8IsMaVzJ7U31cxYN76xsC9U3z82VzY7Oqbkn75cZXOsSiXVukGOg1xMz6v7C7vZR+L+Rt4FJN8VcRmcsvJS6Nbd/5hZbYw2J8wHYgSiNlQnVZI2QElCOV0GAsbPdg6NInRnmqvPQlmYeiDhmU4I0XUZfWPQku4zKRnCgB6ZvGFf2ITgUHGo4MxVLlrVwQsIvqpOEuCgTKiY9L/0UPt2Uuh8qFKkk9udjWhBrNzGyxzqxfY8Ck7tZ66qY9A+D8B535x3GHsXI7BTDZChhmnBHGSLQmdruRAMfFtkgrst13m6+kwiBipRQ6ew9zBqLQNvKXsfSJ7mRy7d+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBL1iCAwVsGQL7bQt91aqNXaOvqZuqlHJ3C02j/cn6w=;
 b=BZCG3GZuGxo6mF1aXzY8SLIi80JhS1RxVt8k35ABOfrIm7qW9oEkgh/Ze1OmggxRJ3h8H4q7VntEg2B7tFr82rgX61Q1HjqiJFBIoijcWRb3POhjUrng4QoB7rU58uTV05MaAl8tiBgJKkfhveArkKQzZVBtnhCYxttPGkFFAIAiJqOslQpnQXeqnEjrs6qpihQ8vJgd31HtDUtgZkPqxGUGzSnboPwYjA4FsJpfxeEmumhqooW9zSwslWTzmQbzEtLwRCWJ/z08+6N62zkTGMpG+soAUWCGxoUBHE/NTKOhpe1z6V+lUQu8C5oSRoOmKkQDvQg0oW/ZiqpdKRAEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBL1iCAwVsGQL7bQt91aqNXaOvqZuqlHJ3C02j/cn6w=;
 b=jIPfRtcmq1GR1Q5eUDJuSmc/HijgydFSsxJP3Otftu3OCcTNQw6hHy0hLm5QWPryOuBkAVaOymb4MuROxWp5Koo89uBFCOF/d3B0gttLt85BIlfOg7ybI1nAXSAgKDJhEoRphK2Lr2m9vBjKoqAdcit+kRDUFlbMdBeRbkq8LtU=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BYAPR02MB5461.namprd02.prod.outlook.com (2603:10b6:a03:a3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 07:48:25 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::38e3:990b:4d03:fd06]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::38e3:990b:4d03:fd06%9]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 07:48:25 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git-dev <git-dev@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHXaSbtDGFAxFZ6nESrsiS8rtP1uaszMzUAgBCU7UA=
Date:   Thu, 15 Jul 2021 07:48:25 +0000
Message-ID: <BY5PR02MB69165A85F14243048187870BA9129@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20210624182939.12881-1-anand.ashok.dumbre@xilinx.com>
        <20210624182939.12881-3-anand.ashok.dumbre@xilinx.com>
 <20210704193108.20e19692@jic23-huawei>
In-Reply-To: <20210704193108.20e19692@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f45beb6-e90e-4452-4cc6-08d94764ed58
x-ms-traffictypediagnostic: BYAPR02MB5461:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5461EBBF440AB58813860E72A9129@BYAPR02MB5461.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/2f9jEOEsclcDVktP6yveI/UiwciYEtcsxkTSqmFv/i8OGOZZnph1plSmM36nC+sHdrWEx3sRC6zED7YMl3wqlmWZvE71KW25KdkiUXfffg4kJUtXwsGzKZJNRgicwgZqlsOHkwX/2oypYJqKkV2/RiD0kXqgPTBRZuz12BttKX+tfXqWpptdzIeirEzdK2MWWU7Ad4UEfok0xPKONIl5k1gmDJCPwNlk3msBkbMiJprk4waOCldxgHVcvBEsfO1ybe9Wxrd9YEPWSW3XjWNlY9Xskvina5VKW/hvyMVX6CU+aKMg6yir4YGm9aoKep+1+Z4rK/VdN5636lPAaRJJsc3xZvEic89cqb/JtpCZv7l/stFmdwZ7w2oIWL8NBrdCzaTiaCb7H/OK/9/DlcynL+ryb2oBJK4ICp02feVdjfNLA+CQx/FWBkbrUfJQx1aq/sLNZE76rz8/lq2C7i2dAssVjwEEaDf1B8UOcKoS7RZ2N51+UUFxT5es8gVQmx7fn4PGtSqMiql22hCrPpkFbxVhFZTyvwFNEl4QEW/V4F1NTtBEDmmieAm/TOtSVWK3KsDGTwOgTouBEcp8R5fS0ZnTBT49bvedtRdAQ9vT+jF5l54hEevZzbLZL+r4bju2o7VkyfU+kiU0H8E1iouQ1zkLRmyrJ5UAsh+RKsor6+Aqft+iTlJX7y2z58DnXCUh4HtqOJ1MO8Ixevv1eyFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(66556008)(66476007)(7696005)(478600001)(6916009)(8936002)(71200400001)(52536014)(64756008)(4326008)(9686003)(55016002)(53546011)(8676002)(30864003)(26005)(66946007)(316002)(186003)(5660300002)(86362001)(107886003)(66446008)(6506007)(2906002)(76116006)(38100700002)(122000001)(33656002)(54906003)(83380400001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u13unTtO6XpzoVmofFbOTEytxROVVeVjybBVyoImnNwojzEqPk1sOBJOb2ze?=
 =?us-ascii?Q?hKIak0JpkqVnDQpQS57aKNmWGu7N7Mk8zMd0BxGNs3FFzfau5JHLkPhj11sQ?=
 =?us-ascii?Q?aepKB4PO/fnUuLFEXMGog5FPhPGP1HR+UzFkCNk7kv3pWM9eKmJTRpMIuy6C?=
 =?us-ascii?Q?O2zVFDSbsNtAHyUwYMor+zb+7L8Dp2jfIELahOaWSsvi5n/00wOGOQlJNlKb?=
 =?us-ascii?Q?oA9BgFfo2spM3tLQKY0aN1MIGX4rQWnYCnbQyZM5XNBK7CYWJZ5dhIblKYgi?=
 =?us-ascii?Q?nNYaWpVOAl6ptkiuk1jYDbDBQR28VSrINC6HYDLrLk4q11rUj1d4LLTDA4sP?=
 =?us-ascii?Q?xxhd3T3tfpUhAvQA55BHZvZ3qQ5mltZ44XMt/byf4ZZ7ygrpn9UuNEDfJDEh?=
 =?us-ascii?Q?1ps4eBJuvJO2z9oawWevoLtcMWBLhNRR5ehJ5+8Hrp41LpgTmvs3NTGW7SMT?=
 =?us-ascii?Q?Hz7zA3BFeFjL4fcb/dw7mrF3pms/VVRrohXJz57b7xvbDaiu/D1gs1Qiawq9?=
 =?us-ascii?Q?ldNkaGr8g0unWUEirdDD8PWb/roZFYwkCMP58Ru5rzboYarl+StJtC/Nr8Dm?=
 =?us-ascii?Q?PntM0CqNgCSgWJKomuHApS3WVr3y8Aob+8TNb+5p4Ba/UEVbGkQdPkScf8Mf?=
 =?us-ascii?Q?QLTFdA4jsQ+lEuF+vL3rTLgYM4Q18ov5N9sBb0XaxbRfKON+hZUo+D1Cokfm?=
 =?us-ascii?Q?gQVnAGYeAZ0gupVE77oA2NRRDgjvPq5ARq9GynHx6md7mTaaynRbzUYC5O24?=
 =?us-ascii?Q?KPWn7xpjaU1WBXB3k/Gno/63GdKDz2z4Z4r5uswzUGmCmWzctjm/iTKHTwdG?=
 =?us-ascii?Q?qJ7ZMpXXeUwqNL38zsa8KUIbNo5nIREyAkiSUkREzCiZpypkiwnAi/X+b2WZ?=
 =?us-ascii?Q?8ik0tYZM7Qlerp9RtJ4izAZ8kbPQ8jagZTYIm/bCoX/hcxuakJJEfS9i7MTY?=
 =?us-ascii?Q?UrhF/sbfmniiCHVoMm3MZ0ugZJfxgPov9XMQ3h8eeGGCua5xPGfEgtCaKUq/?=
 =?us-ascii?Q?ChbytVdk2zKeEDAgmJV9IhY39JoJSM4o9pXXbQsKcTdQM2IzjsQZlt/gMsYX?=
 =?us-ascii?Q?42SqpItCjgscG0Cwsyf4M87QEY7OVf0PVaKiANtsc1TlKnNW2En8yLZA9KCt?=
 =?us-ascii?Q?cjbx1RKeTwqDM/xvbEhZoB9wdLfWPOYv1qo43KOA8j9qn+TMXWNNBDHwo45W?=
 =?us-ascii?Q?CKGPo1i0NSNOtzjA+avGlfwah/wtRsgzIfe6dXIdfrDBkZ4Ke2GlNxQt81km?=
 =?us-ascii?Q?6iBbpzlTXRWA4Ib+r5Bygen6e3hvWRtfs6eY6WzS/6ovPCBPk8/g2MN1bRdq?=
 =?us-ascii?Q?1ySO5tup9DH1Go5crQpz3wut?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f45beb6-e90e-4452-4cc6-08d94764ed58
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 07:48:25.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bp/h3Mz+SE4g54LJBesNrBMr+Q5o+4pZAmWAphyvwcPLY11Nfd+5jOGULsxBUucNyouw2HonC+Mr+GDeYpkvuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5461
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday 4 July 2021 7:31 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: lars@metafoo.de; linux-iio@vger.kernel.org; git-dev <git-
> dev@xilinx.com>; Michal Simek <michals@xilinx.com>;
> pmeerw@pmeerw.net; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Manish Narani <MNARANI@xilinx.com>
> Subject: Re: [PATCH v6 2/4] iio: adc: Add Xilinx AMS driver
>=20
> On Thu, 24 Jun 2021 19:29:37 +0100
> Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:
>=20
> > The AMS includes an ADC as well as on-chip sensors that can be used to
> > sample external voltages and monitor on-die operating conditions, such
> > as temperature and supply voltage levels. The AMS has two SYSMON
> blocks.
> > PL-SYSMON block is capable of monitoring off chip voltage and
> > temperature.
> > PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> > from external master. Out of these interface currently only DRP is
> > supported.
> > Other block PS-SYSMON is memory mapped to PS.
> > The AMS can use internal channels to monitor voltage and temperature
> > as well as one primary and up to 16 auxiliary channels for measuring
> > external voltages.
> > The voltage and temperature monitoring channels also have event
> > capability which allows to generate an interrupt when their value
> > falls below or raises above a set threshold.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>

Hi Jonathan,

Thank you for the review.

My comments inline.

Thanks,
Anand
>=20
> Hi Anand,
>=20
> A few comments inline from a fresh read.
> Only significant one is that the use of separate masks and shifts differs=
 from
> how they are normally done in the kernel these days.
> FIELD_PREP() and FIELD_GET() allow a single mask definition to be cleanly
> used for both the shift and masking in a nice clean way.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/adc/Kconfig      |   13 +
> >  drivers/iio/adc/Makefile     |    1 +
> >  drivers/iio/adc/xilinx-ams.c | 1342
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 1356 insertions(+)
> >  create mode 100644 drivers/iio/adc/xilinx-ams.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index
> > c7946c439612..c011ab30ec9a 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1256,4 +1256,17 @@ config XILINX_XADC
> >  	  The driver can also be build as a module. If so, the module will be
> called
> >  	  xilinx-xadc.
> >
> > +config XILINX_AMS
> > +	tristate "Xilinx AMS driver"
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	help
> > +	  Say yes here to have support for the Xilinx AMS.
> > +
> > +	  The driver supports Voltage and Temperature monitoring on Xilinx
> Ultrascale
> > +	  devices.
> > +
> > +	  The driver can also be built as a module. If so, the module will be
> called
> > +	  xilinx-ams.
> > +
> >  endmenu
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile index
> > a226657d19c0..99e031f44479 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -112,4 +112,5 @@ obj-$(CONFIG_VF610_ADC) +=3D vf610_adc.o
> >  obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o  xilinx-xadc-y :=3D
> > xilinx-xadc-core.o xilinx-xadc-events.o
> >  obj-$(CONFIG_XILINX_XADC) +=3D xilinx-xadc.o
> > +obj-$(CONFIG_XILINX_AMS) +=3D xilinx-ams.o
> >  obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o diff --git
> > a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c new file
> > mode 100644 index 000000000000..463e3162726c
> > --- /dev/null
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -0,0 +1,1342 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx AMS driver
> > + *
> > + *  Copyright (C) 2021 Xilinx, Inc.
> > + *
> > + *  Manish Narani <mnarani@xilinx.com>
> > + *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>  */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +static const unsigned int AMS_UNMASK_TIMEOUT_MS =3D 500;
> > +
> > +/* AMS registers definitions */
> > +#define AMS_ISR_0			0x010
> > +#define AMS_ISR_1			0x014
> > +#define AMS_IER_0			0x020
> > +#define AMS_IER_1			0x024
> > +#define AMS_IDR_0			0x028
> > +#define AMS_IDR_1			0x02c
> > +#define AMS_PS_CSTS			0x040
> > +#define AMS_PL_CSTS			0x044
> > +
> > +#define AMS_VCC_PSPLL0			0x060
> > +#define AMS_VCC_PSPLL3			0x06C
> > +#define AMS_VCCINT			0x078
> > +#define AMS_VCCBRAM			0x07C
> > +#define AMS_VCCAUX			0x080
> > +#define AMS_PSDDRPLL			0x084
> > +#define AMS_PSINTFPDDR			0x09C
> > +
> > +#define AMS_VCC_PSPLL0_CH		48
> > +#define AMS_VCC_PSPLL3_CH		51
> > +#define AMS_VCCINT_CH			54
> > +#define AMS_VCCBRAM_CH			55
> > +#define AMS_VCCAUX_CH			56
> > +#define AMS_PSDDRPLL_CH			57
> > +#define AMS_PSINTFPDDR_CH		63
> > +
> > +#define AMS_REG_CONFIG0			0x100
> > +#define AMS_REG_CONFIG1			0x104
> > +#define AMS_REG_CONFIG3			0x10C
> > +#define AMS_REG_SEQ_CH0			0x120
> > +#define AMS_REG_SEQ_CH1			0x124
> > +#define AMS_REG_SEQ_CH2			0x118
> > +
> > +#define AMS_TEMP			0x000
> > +#define AMS_SUPPLY1			0x004
> > +#define AMS_SUPPLY2			0x008
> > +#define AMS_VP_VN			0x00c
> > +#define AMS_VREFP			0x010
> > +#define AMS_VREFN			0x014
> > +#define AMS_SUPPLY3			0x018
> > +#define AMS_SUPPLY4			0x034
> > +#define AMS_SUPPLY5			0x038
> > +#define AMS_SUPPLY6			0x03c
> > +#define AMS_SUPPLY7			0x200
> > +#define AMS_SUPPLY8			0x204
> > +#define AMS_SUPPLY9			0x208
> > +#define AMS_SUPPLY10			0x20c
> > +#define AMS_VCCAMS			0x210
> > +#define AMS_TEMP_REMOTE			0x214
> > +
> > +#define AMS_REG_VAUX(x)			(0x40 + 4 * (x))
> > +
> > +#define AMS_PS_RESET_VALUE		0xFFFF
> > +#define AMS_PL_RESET_VALUE		0xFFFF
> > +
> > +#define AMS_CONF0_CHANNEL_NUM_MASK	GENMASK(6, 0)
> > +
> > +#define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
> > +#define AMS_CONF1_SEQ_DEFAULT		(0 << 12)
> > +#define AMS_CONF1_SEQ_CONTINUOUS	(2 << 12)
> > +#define AMS_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)
>=20
> FIELD_PREP(AMS_CONFG1_SEQ_MASK, 0) or even better, define the values
> as not shifted and have
>=20
> FIELD_PREP(AMS_CONFIG1_SEQ_MASK, AMS_CONF1_SEQ_DEFAULT) etc in
> the relevant places inline.
>=20
Will fix this in next series.
>=20
> > +
> > +#define AMS_REG_SEQ0_MASK		0xFFFF
> > +#define AMS_REG_SEQ2_MASK		0x003F
> > +#define AMS_REG_SEQ1_MASK		0xFFFF
> > +#define AMS_REG_SEQ2_MASK_SHIFT		16
> > +#define AMS_REG_SEQ1_MASK_SHIFT		22
>=20
> As below, combine mask and shift into a shifted mask then you can use
> FIELD_PREP() to do the magic for you.

Will fix this in next series.
>=20
> > +
> > +#define AMS_REGCFG1_ALARM_MASK		0xF0F
> > +#define AMS_REGCFG3_ALARM_MASK		0x3F
> > +
> > +#define AMS_ALARM_TEMP			0x140
> > +#define AMS_ALARM_SUPPLY1		0x144
> > +#define AMS_ALARM_SUPPLY2		0x148
> > +#define AMS_ALARM_SUPPLY3		0x160
> > +#define AMS_ALARM_SUPPLY4		0x164
> > +#define AMS_ALARM_SUPPLY5		0x168
> > +#define AMS_ALARM_SUPPLY6		0x16c
> > +#define AMS_ALARM_SUPPLY7		0x180
> > +#define AMS_ALARM_SUPPLY8		0x184
> > +#define AMS_ALARM_SUPPLY9		0x188
> > +#define AMS_ALARM_SUPPLY10		0x18c
> > +#define AMS_ALARM_VCCAMS		0x190
> > +#define AMS_ALARM_TEMP_REMOTE		0x194
> > +#define AMS_ALARM_THRESHOLD_OFF_10	0x10
> > +#define AMS_ALARM_THRESHOLD_OFF_20	0x20
> > +
> > +#define AMS_ALARM_THR_DIRECT_MASK	0x01
> > +#define AMS_ALARM_THR_MIN		0x0000
> > +#define AMS_ALARM_THR_MAX		0xffff
> > +
> > +#define AMS_NO_OF_ALARMS		32
> > +#define AMS_PL_ALARM_START		16
> > +#define AMS_ISR0_ALARM_MASK		0xFFFFFFFFU
> > +#define AMS_ISR1_ALARM_MASK		0xE000001FU
> > +#define AMS_ISR1_EOC_MASK		0x00000008U
> > +#define AMS_ISR1_INTR_MASK_SHIFT	32
> > +#define AMS_ISR0_ALARM_2_TO_0_MASK	0x07
> > +#define AMS_ISR0_ALARM_6_TO_3_MASK	0x78
> > +#define AMS_ISR0_ALARM_12_TO_7_MASK	0x3F
> > +#define AMS_CONF1_ALARM_2_TO_0_SHIFT	1
>=20
> Can we handle these via a single mask that includes the shift and
> FIELD_PREP() etc?  That tends to make it easier to review by ensuring we
> don't have multiple defines to deal with.
>=20

Will fix this in next series.

> > +#define AMS_CONF1_ALARM_6_TO_3_SHIFT	5
> > +#define AMS_CONF3_ALARM_12_TO_7_SHIFT	8
>=20
>=20
> > +
> > +#define AMS_PS_CSTS_PS_READY		0x08010000U
> > +#define AMS_PL_CSTS_ACCESS_MASK		0x00000001U
> > +
> > +#define AMS_PL_MAX_FIXED_CHANNEL	10
> > +#define AMS_PL_MAX_EXT_CHANNEL		20
> > +
> > +#define AMS_INIT_TIMEOUT_US		10000
> > +
> > +/*
> > + * Following scale and offset value is derived from
> > + * UG580 (v1.7) December 20, 2016
> > + */
> > +#define AMS_SUPPLY_SCALE_1VOLT		1000
> > +#define AMS_SUPPLY_SCALE_3VOLT		3000
> > +#define AMS_SUPPLY_SCALE_6VOLT		6000
> > +#define AMS_SUPPLY_SCALE_DIV_BIT	16
> > +
> > +#define AMS_TEMP_SCALE			509314
> > +#define AMS_TEMP_SCALE_DIV_BIT		16
> > +#define AMS_TEMP_OFFSET			-((280230L << 16) /
> 509314)
> > +
> > +enum ams_alarm_bit {
> > +	AMS_ALARM_BIT_TEMP,
> > +	AMS_ALARM_BIT_SUPPLY1,
> > +	AMS_ALARM_BIT_SUPPLY2,
> > +	AMS_ALARM_BIT_SUPPLY3,
> > +	AMS_ALARM_BIT_SUPPLY4,
> > +	AMS_ALARM_BIT_SUPPLY5,
> > +	AMS_ALARM_BIT_SUPPLY6,
> > +	AMS_ALARM_BIT_RESERVED,
> > +	AMS_ALARM_BIT_SUPPLY7,
> > +	AMS_ALARM_BIT_SUPPLY8,
> > +	AMS_ALARM_BIT_SUPPLY9,
> > +	AMS_ALARM_BIT_SUPPLY10,
> > +	AMS_ALARM_BIT_VCCAMS,
> > +	AMS_ALARM_BIT_TEMP_REMOTE
> > +};
> > +
> > +enum ams_seq {
> > +	AMS_SEQ_VCC_PSPLL,
> > +	AMS_SEQ_VCC_PSBATT,
> > +	AMS_SEQ_VCCINT,
> > +	AMS_SEQ_VCCBRAM,
> > +	AMS_SEQ_VCCAUX,
> > +	AMS_SEQ_PSDDRPLL,
> > +	AMS_SEQ_INTDDR
> > +};
> > +
> > +enum ams_ps_pl_seq {
> > +	AMS_SEQ_CALIB,
> > +	AMS_SEQ_RSVD_1,
> > +	AMS_SEQ_RSVD_2,
> > +	AMS_SEQ_TEST,
> > +	AMS_SEQ_RSVD_4,
> > +	AMS_SEQ_SUPPLY4,
> > +	AMS_SEQ_SUPPLY5,
> > +	AMS_SEQ_SUPPLY6,
> > +	AMS_SEQ_TEMP,
> > +	AMS_SEQ_SUPPLY2,
> > +	AMS_SEQ_SUPPLY1,
> > +	AMS_SEQ_VP_VN,
> > +	AMS_SEQ_VREFP,
> > +	AMS_SEQ_VREFN,
> > +	AMS_SEQ_SUPPLY3,
> > +	AMS_SEQ_CURRENT_MON,
> > +	AMS_SEQ_SUPPLY7,
> > +	AMS_SEQ_SUPPLY8,
> > +	AMS_SEQ_SUPPLY9,
> > +	AMS_SEQ_SUPPLY10,
> > +	AMS_SEQ_VCCAMS,
> > +	AMS_SEQ_TEMP_REMOTE,
> > +	AMS_SEQ_MAX
> > +};
> > +
> > +#define AMS_SEQ(x)		(AMS_SEQ_MAX + (x))
> > +#define AMS_VAUX_SEQ(x)		(AMS_SEQ_MAX + (x))
> > +
> > +#define AMS_PS_SEQ_MAX		AMS_SEQ_MAX
> > +#define PS_SEQ(x)		(x)
> > +#define PL_SEQ(x)		(AMS_PS_SEQ_MAX + (x))
> > +
> > +#define AMS_CHAN_TEMP(_scan_index, _addr) { \
> > +	.type =3D IIO_TEMP, \
> > +	.indexed =3D 1, \
> > +	.address =3D (_addr), \
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> > +		BIT(IIO_CHAN_INFO_SCALE) | \
> > +		BIT(IIO_CHAN_INFO_OFFSET), \
> > +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > +	.event_spec =3D ams_temp_events, \
> > +	.num_event_specs =3D ARRAY_SIZE(ams_temp_events), \
> > +	.scan_index =3D (_scan_index), \
> > +	.scan_type =3D { \
> > +		.sign =3D 'u', \
> > +		.realbits =3D 12, \
> > +		.storagebits =3D 16, \
> > +		.shift =3D 4, \
> > +		.endianness =3D IIO_CPU, \
>=20
> Currently these are only documentation i think as no support for using th=
em
> in this driver (buffered modes).  You could drop them until you need them=
 in
> some future patch.

Makes sense, will remove the scan_type part, but will retain the scan index=
, since it=20
is used in some logic inside the rest of the code.

>=20
> > +	}, \
> > +}
> > +
>=20
> ...
>=20
> > +static int ams_enable_single_channel(struct ams *ams, unsigned int
> > +offset) {
> > +	u8 channel_num =3D 0;
> > +
> > +	switch (offset) {
> > +	case AMS_VCC_PSPLL0:
> > +		channel_num =3D AMS_VCC_PSPLL0_CH;
> > +		break;
> > +	case AMS_VCC_PSPLL3:
> > +		channel_num =3D AMS_VCC_PSPLL3_CH;
> > +		break;
> > +	case AMS_VCCINT:
> > +		channel_num =3D AMS_VCCINT_CH;
> > +		break;
> > +	case AMS_VCCBRAM:
> > +		channel_num =3D AMS_VCCBRAM_CH;
> > +		break;
> > +	case AMS_VCCAUX:
> > +		channel_num =3D AMS_VCCAUX_CH;
> > +		break;
> > +	case AMS_PSDDRPLL:
> > +		channel_num =3D AMS_PSDDRPLL_CH;
> > +		break;
> > +	case AMS_PSINTFPDDR:
> > +		channel_num =3D AMS_PSINTFPDDR_CH;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* set single channel, sequencer off mode */
> > +	ams_ps_update_reg(ams, AMS_REG_CONFIG1,
> AMS_CONF1_SEQ_MASK,
> > +			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
> > +
> > +	/* write the channel number */
> > +	ams_ps_update_reg(ams, AMS_REG_CONFIG0,
> AMS_CONF0_CHANNEL_NUM_MASK,
> > +			  channel_num);
>=20
> nitpick: Blank line here.

Will fix this in next series.

>=20
> > +	return 0;
> > +}
> > +
>=20
> ...
>=20
> > +static int ams_get_ext_chan(struct device_node *chan_node,
> > +			    struct iio_chan_spec *channels, int num_channels)
> {
> > +	struct device_node *child;
> > +	unsigned int reg;
> > +	int ret;
> > +
> > +	for_each_child_of_node(chan_node, child) {
> > +		ret =3D of_property_read_u32(child, "reg", &reg);
> > +		if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))
> > +			continue;
> > +
> > +		memcpy(&channels[num_channels], &ams_pl_channels[reg
> +
> > +		       AMS_PL_MAX_FIXED_CHANNEL - 30], sizeof(*channels));
> > +
> > +		if (of_property_read_bool(child,
> > +					  "xlnx,bipolar"))
>=20
> Above fits on one line easily.

Will fix this in next series.

>=20
> > +			channels[num_channels].scan_type.sign =3D	's';
> > +
> > +		num_channels++;
> > +	}
> > +
> > +	return num_channels;
> > +}
> > +
>=20
> ...
>=20
> > +
> > +static int ams_probe(struct platform_device *pdev) {
> > +	struct iio_dev *indio_dev;
> > +	struct ams *ams;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	if (!pdev->dev.of_node)
> > +		return -ENODEV;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*ams));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	ams =3D iio_priv(indio_dev);
> > +	mutex_init(&ams->lock);
> > +
> > +	indio_dev->name =3D "xilinx-ams";
> > +
> > +	indio_dev->info =3D &iio_ams_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	ams->base =3D devm_ioremap_resource(&pdev->dev, res);
>=20
> devm_platform_ioremap_resource()
> Slight reduction in boilerplate.

Will fix this in next series.

>=20
> > +	if (IS_ERR(ams->base))
> > +		return PTR_ERR(ams->base);
> > +
> > +	ams->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(ams->clk))
> > +		return PTR_ERR(ams->clk);
> > +	clk_prepare_enable(ams->clk);
> > +	devm_add_action_or_reset(&pdev->dev, (void
> *)clk_disable_unprepare,
> > +				 ams->clk);
> > +
> > +	INIT_DELAYED_WORK(&ams->ams_unmask_work,
> ams_unmask_worker);
> > +	devm_add_action_or_reset(&pdev->dev, (void
> *)cancel_delayed_work,
>=20
> I'm not keen on casting away the function pointer type.  Normally we'd ju=
st
> wrap it in a local function, to make it clear it was deliberate and avoid
> potential nasty problems if the signature of the function ever changes.
>=20
> It's 3 lines of boilerplate, but will give me warm fuzzy feelings!
> Same for the other case above.  The fact this isn't done in exising kerne=
l code
> make this particularly risky.

Makes sense. I will revert the code back to its original and handle the cas=
es using goto
and inside remove()

>=20
> > +				 &ams->ams_unmask_work);
> > +
> > +	ret =3D ams_init_device(ams);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D ams_parse_dt(indio_dev, pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failure in parsing DT\n");
> > +		return ret;
> > +	}
> > +
> > +	ams_enable_channel_sequence(indio_dev);
> > +
> > +	ams->irq =3D platform_get_irq(pdev, 0);
>=20
> platform_get_irq () can return errors, in particular -EPROBE_DEFER so I'd
> check that and return before you call devm_request_irq() I'm not sure
> devm_request_irq() will not eat that error code.
>=20

Will fix this in next series.

>=20
> > +	ret =3D devm_request_irq(&pdev->dev, ams->irq, &ams_irq, 0, "ams-
> irq",
> > +			       indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to register interrupt\n");
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, indio_dev);
> > +
> > +	return iio_device_register(indio_dev); }
> > +
> > +static int ams_remove(struct platform_device *pdev) {
> > +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > +
> > +	iio_device_unregister(indio_dev);
>=20
> If this is all you have in remove, then you can use devm_iio_device_regis=
ter()
> in probe() and not need an remove() callback at all.

I think remove will have more functions since I am getting rid of devm_add_=
action_or_reset()

>=20
> > +
> > +	return 0;
> > +}
> > +
>=20
> ...
