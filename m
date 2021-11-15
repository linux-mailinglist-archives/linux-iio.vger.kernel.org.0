Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BE4502F8
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 12:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbhKOLDB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 06:03:01 -0500
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:31553
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237791AbhKOLB4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 06:01:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLLGPIGw7yuYyC8HzoP3woIpEzjk8Vkerbii4vihfemB8p7338au6QzaP1TTuFRTuhBPKwt6zMhGxzV6neIae5V+XuszCeSp94+1p8Ks8kLJt6TRCCIMCY+yACVF9nXx3onN53ICt1E5KXzPXn7Ne0jSnEgxRzLX9ObWvQfuUmGOblDQu/Rw9icGhWgsCifcButaINc6MXg+3VlgCon7AV4KpTAQVhKO60GHFUOjNmRQWS22FMjz6Zd06WCVaM5cQTGSZdqwMTTrqe+OqFi1KMNUhZjL/aaMQi4combO62GIdY0T5KtUkkdRzDY8LIk3TCwRMmtctuSwyRO37/nAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwS0WMxMslD59mNj3ZzT0eKfxASbOhlakrsybk0c2fo=;
 b=Xtw5nhhts9v6mn0LSxbPXoo9ML/fgTc5R4gSY2BCl9R87JP60HEKnhiTkxUIdPgZiKnxa+TCY6Whrdtr2eS6iFRPf8vqQ575PRbktuM3DEXb9PDGDcfvtYII9h5dRgagvM99maxVm2m8GgreLC8VBWQX7df99e9/mgpKoKL1dWUSPgWk+/J+t7jyjdkQFpfAI0iNPKkWxOw0KMZYSaXQwWKu6+Wyf5bupoPRNjElf+BnjBvSs8oAu9wLynAtD54v/1qDXS2i8JABNVf61kvUQO+folclEjD/22oVKeDZRQ/BnVg+SSSKweI9dXi3rCUKllndlCb9vX9sV7AbxAlqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwS0WMxMslD59mNj3ZzT0eKfxASbOhlakrsybk0c2fo=;
 b=MqnxZC6lv/gAKH8/TvD+7nT/wuLVIaIC4GwKAeXY25vVxTiLjgVDvgWr643/aCtxSTdvQVOtr8yTqBz8lyiZs+BpfH/0NL0raPsSvG8KmBsUCARfLaQklnESt45gSgC3ICTZLvsAu+t7shqfcw1e0O69m3pSvpYXxNmahc69GxE=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB8417.namprd02.prod.outlook.com (2603:10b6:a03:3f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 10:58:53 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%9]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 10:58:53 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHX1ORlUCJOSLcFoUKx28Qs+DOPj6wBqhkAgALJdqA=
Date:   Mon, 15 Nov 2021 10:58:53 +0000
Message-ID: <BY5PR02MB6916AEE6763017EAE19A3F13A9989@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
        <20211108210509.29870-3-anand.ashok.dumbre@xilinx.com>
 <20211113161724.371e4bcf@jic23-huawei>
In-Reply-To: <20211113161724.371e4bcf@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9872542d-fbaa-40ba-004a-08d9a826e9bc
x-ms-traffictypediagnostic: SJ0PR02MB8417:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB8417C57F6BB20ADE2068A988A9989@SJ0PR02MB8417.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xcIxOQttxKDvD7jyzKgI9btxCU6PLSZTgRTZsU/hguLdofiBOvpYvdb4RDvUpfG4kyOO50KUZuA3kXrYnwkAweg+jtQ8Aqh2XokCD7FwcLhh2Nq4Rd6xC2RSo0x6OWI+dG3NKuMyaEfm2q43msAIGcek+35sgaf/D+ZdrTeKB1JEnEKG3HtsARH9mAa/Jv3+ibI65k/IznEYczol/btFhFuYBnlf38be3tYJxg4tDQTQJkV+jg7STbP/NUVb4wKElAxhIkQa9lX418xhImR2niek9F5iMGUfOVLLvJ4NMBzgU0TVFryGZrG1kN7uS/sZTqH83u/f4afAuAkemmDHw/WS+YSTpRIYW49x23TWLOfZNhf7D6yqRpDOZP1/UmTGGVnpiMRG7grf/wjOL5rCHj7TtwxfWNVMnD0kPDgy0yymd40yHC9/LlHg+XLcsVIwGSE2Ow4Uy/4Kuh/6+BlMzMlwCziBBlArXOI1ylj6BfA1Vn+wHzk1TWtQG4WFgfjFsYYByKN5re3CEEA70TaRO5KAkYHCNeUa7C6C0wdaO7JLgWCHb+QRDCV2ItELdcyfad093Uq12b7ydW1J8t68PYH706cyQop3wwZsO2NfeWr6kcsaUPuu+dTul1jo8nM5p0/RvUyUbWpUJoxE8Vx4SSq6Ypcoi1QQk7WGfM/VsscYfKFflR5gJL2N0IXmjVyVQnJdXphuHX99xBE2MhK80w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(186003)(316002)(5660300002)(122000001)(6916009)(54906003)(8936002)(2906002)(83380400001)(86362001)(26005)(8676002)(71200400001)(30864003)(38100700002)(66946007)(508600001)(76116006)(7696005)(52536014)(55016002)(66556008)(64756008)(66446008)(66476007)(33656002)(9686003)(38070700005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AJHu3SfKNnmtt6b3/LKkSjKn5CNYu3GKSLGsU+jdJQf2dM5DFx38jXw4uYKz?=
 =?us-ascii?Q?t7+hQdYPyJnkjYk96Sx4k6OXP4atn01bWZGInzD66vI7AZ08QzDunMfrP7zy?=
 =?us-ascii?Q?HubwCAtVQexkJ5C686GrDCLa58qMCBywRCgQ3UR6A+QD8rEgLrEtGwNB0/Px?=
 =?us-ascii?Q?v3awrINVN+usyz3MIKWohPzjhk7jIblVpWny9W0HA8YRMRPUimqJ4qkOJ1er?=
 =?us-ascii?Q?5rSC/LVGiwFK+SgzxAMIk8fVyOtPE0WZuUJLWtdA+7yAoqekNhXEUfZe8ws7?=
 =?us-ascii?Q?vZSWEpXqEE7kB+9suJkPhMg5CeZ6yBqFbvw/3+Nf7CcnVl+j0OiyIe3AIuP8?=
 =?us-ascii?Q?Q4RbPQLCDm6mI1aehzx7rTkjtYfxIi656hL5j3yBziXXOQRbJofCbG+d7iqV?=
 =?us-ascii?Q?Oa9xq80+vHBJnR573P3CAcYdA/5bU1kCSTgsfawcUDF7tvXgqvqZKLkJlpwb?=
 =?us-ascii?Q?NgMRnAvKbod7OLgOXh2uf9zenXFRf/0m71i7u0q1CA7RYfMiZazVR3COgg/K?=
 =?us-ascii?Q?FgftTd64DqdbHMfENUKZVqn+dIxb9EIPqBsHWptm+GYLRPSxa7KaeMiwPbz/?=
 =?us-ascii?Q?oANYaKx2lqAKAc2aXfEZi3hl+EzxyKbsMbP23iqPgsbt2mkGFvrStf6FNn9c?=
 =?us-ascii?Q?q2LzvmuVX/QYZE9gwftqpgAjdYvumFrhaj6jxBxQ6p5SFvlHEswOX1QBrMQf?=
 =?us-ascii?Q?jbarxo8/H5yOEjEno6EqYoY+LmEm/XHW1Nk6PTpnTFa6Bd07SWnxM7LaljHW?=
 =?us-ascii?Q?02rCYfmkm85GYvE55Dc3Ioe55UiM6aNOGk5yDqK38ITpll3ubYbEvtaY60kk?=
 =?us-ascii?Q?0yLpH0E8qB/nD6nCfKbi1l02IRY2c4eE3hQrVt49G4kxpaHaAlWQh9qBY4hb?=
 =?us-ascii?Q?soZ2QeBKVUVFvV2IGFaMffLhxWY2SvgYNGnKQrI3VAGA1ElxB7LqQCDwWTBz?=
 =?us-ascii?Q?S5NJ4V9xF/TtyMiQBuHmHCu4rUjxJwBbumF7xsJle4IBfKUKy+Nz9fx/7SFN?=
 =?us-ascii?Q?eZ6Cf7LL0j40hNZgH2g6/Yp4tmQHSDYsW/Mi8i5JdeCNogzaniG0zbc9bd4M?=
 =?us-ascii?Q?ZqdO6vv3Hde8VEsLFP6AVceehgDqsax+SXCpEcQinfM+adg7W9GjATZSJoyG?=
 =?us-ascii?Q?hRaJu1yLNAVxvCcHn42XCx3rHm2DqwDccnloNLVwhSehi1A8ciTJ3C0jp71j?=
 =?us-ascii?Q?K82vTEvGikA2fuiPLKzGPML6qyaqsg1MoIwHi3onItProGvotfK1jNXTGn33?=
 =?us-ascii?Q?BK08FB78ydHPDS/MAtYhIcif0bgIlj/+mkaGV8gFFxmbA5oFmli9B0eBQk/+?=
 =?us-ascii?Q?WEQEP550HlIxWZj7AVxzUOc9QaH4ABqCLb2bf1JPcJoAn8swjPJBTr2DNdWz?=
 =?us-ascii?Q?q4HDEX9EkE3btZZZwYJoV4ixzS6x8/fXTrFH1ioowimfT8PJBLYZAQJz24zi?=
 =?us-ascii?Q?bTnJOfiABjIUAlDKzy+t8CjMqc0F9M2t9kBuYDI83Lb5iDI1P8Lm/hOAyK/L?=
 =?us-ascii?Q?2VlNTWSSVttpQwTdUGVohjt0xZ+HAz3OO2oyiV9ThQot5OF9mropzGiwcMDs?=
 =?us-ascii?Q?iTH/nDhbjQGnhDvlawoFpCd4zstbwt2/ulNDoiyyFFOOAzFgl+C7X/IAzWlK?=
 =?us-ascii?Q?80AvFHbbHhrj4+E7N+s1PVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9872542d-fbaa-40ba-004a-08d9a826e9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 10:58:53.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrVrucnv3IuxgQ3IR5cO5+FUHF4jj00HDs8kGpSfluZF8isjCmbcOoorV2V7vEMtpnHUADn6MCz5T+1mAB1gVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8417
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for reviewing my patch.

> Subject: Re: [PATCH v8 2/4] iio: adc: Add Xilinx AMS driver
>=20
> On Mon, 8 Nov 2021 21:05:07 +0000
> Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:
>=20
> > The AMS includes an ADC as well as on-chip sensors that can be used to
> > sample external voltages and monitor on-die operating conditions, such
> > as temperature and supply voltage levels. The AMS has two SYSMON
> blocks.
> > PL-SYSMON block is capable of monitoring off chip voltage and
> > temperature.
> > PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> > from an external master. Out of these interfaces currently only DRP is
> > supported.
> > Other block PS-SYSMON is memory mapped to PS.
> > The AMS can use internal channels to monitor voltage and temperature
> > as well as one primary and up to 16 auxiliary channels for measuring
> > external voltages.
> > The voltage and temperature monitoring channels also have event
> > capability which allows to generate an interrupt when their value
> > falls below or raises above a set threshold.
> >
> > Co-developed-by: Manish Narani <manish.narani@xilinx.com>
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Hi Anand,
>=20
> +Cc Andy for a question on of_iomap() and whether we should add
> +something similar
> to the generic firmware handling.  Personally I'd be happy with leaving i=
t for
> now on basis of it being something to come back and tidy up later, but wo=
uld
> like your opinion as you are more familiar with that stuff.
>=20
> Given you are going around again, I've picked out a few minor things on a
> final read through to clean up but subject to the above and review from
> others I'm happy with this now and hopefully can pick up v9.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > ---
> >  drivers/iio/adc/Kconfig      |   15 +
> >  drivers/iio/adc/Makefile     |    1 +
> >  drivers/iio/adc/xilinx-ams.c | 1452
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 1468 insertions(+)
> >  create mode 100644 drivers/iio/adc/xilinx-ams.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index
> > af168e1c9fdb..6d711f401326 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1278,4 +1278,19 @@ config XILINX_XADC
> >  	  The driver can also be build as a module. If so, the module will be
> called
> >  	  xilinx-xadc.
> >
> > +config XILINX_AMS
> > +	tristate "Xilinx AMS driver"
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	help
> > +	  Say yes here to have support for the Xilinx AMS for
> Ultrascale/Ultrascale+
> > +	  System Monitor. With this you can measure and monitor the
> Voltages and
> > +          Temperature values on the SOC.
>=20
> Already noted in other review thread
>=20
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
> > d68550f493e3..8ced2a3a153f 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -114,4 +114,5 @@ obj-$(CONFIG_VF610_ADC) +=3D vf610_adc.o
> >  obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o  xilinx-xadc-y :=3D
> > xilinx-xadc-core.o xilinx-xadc-events.o
> >  obj-$(CONFIG_XILINX_XADC) +=3D xilinx-xadc.o
> > +obj-$(CONFIG_XILINX_AMS) +=3D xilinx-ams.o
> >  obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o diff --git
> > a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c new file
> > mode 100644 index 000000000000..6e325c4f0a5d
> > --- /dev/null
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -0,0 +1,1452 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx AMS driver
> > + *
> > + *  Copyright (C) 2021 Xilinx, Inc.
> > + *
> > + *  Manish Narani <mnarani@xilinx.com>
> > + *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>  */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/of_address.h>
>=20
> So this is the last of specific header needed for of_iomap() and similar.
>=20
> > +#include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
>=20
> ...
>=20
> > +/**
> > + * struct ams - Driver data for xilinx-ams
> > + * @base: physical base address of device
> > + * @ps_base: physical base address of PS device
> > + * @pl_base: physical base address of PL device
> > + * @clk: clocks associated with the device
> > + * @dev: pointer to device struct
> > + * @lock: to handle multiple user interaction
> > + * @intr_lock: to protect interrupt mask values
> > + * @alarm_mask: alarm configuration
> > + * @masked_alarm: currently masked due to alarm
> > + * @intr_mask: interrupt configuration
> > + * @irq: interrupt number of the sysmon
>=20
> Run kernel-doc script over the file and fix the warnings.  Here you dropp=
ed
> the field in this version but missed the docs.

I will fix this. Not sure how I missed when I ran kernel doc.

>=20
> > + * @ams_unmask_work: re-enables event once the event condition
> > +disappears
> > + *
> > + * This structure contains necessary state for Sysmon driver to
> > +operate  */ struct ams {
> > +	void __iomem *base;
> > +	void __iomem *ps_base;
> > +	void __iomem *pl_base;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	struct mutex lock;
> > +	spinlock_t intr_lock;
> > +	unsigned int alarm_mask;
> > +	unsigned int masked_alarm;
> > +	u64 intr_mask;
> > +	struct delayed_work ams_unmask_work; };
> > +
>=20
> ...
>=20
>=20
> > +
> > +static int ams_init_module(struct iio_dev *indio_dev, struct
> fwnode_handle *np,
> > +			   struct iio_chan_spec *channels)
> > +{
> > +	struct ams *ams =3D iio_priv(indio_dev);
> > +	struct device *dev =3D indio_dev->dev.parent;
> > +	struct device_node *node;
> > +	int num_channels =3D 0;
> > +	int ret;
> > +
> > +	node =3D to_of_node(np);
> > +	if (fwnode_property_match_string(np, "compatible",
> > +					 "xlnx,zynqmp-ams-ps") =3D=3D 0) {
> > +		ams->ps_base =3D of_iomap(node, 0);
> > +		if (!ams->ps_base)
> > +			return -ENXIO;
> > +		ret =3D devm_add_action_or_reset(dev, ams_iounmap, ams-
> >ps_base);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* add PS channels to iio device channels */
> > +		memcpy(channels + num_channels, ams_ps_channels,
> > +		       sizeof(ams_ps_channels));
> > +		num_channels +=3D ARRAY_SIZE(ams_ps_channels);
> > +	} else if (fwnode_property_match_string(np, "compatible",
> > +						"xlnx,zynqmp-ams-pl") =3D=3D 0)
> {
> > +		ams->pl_base =3D of_iomap(node, 0);
>=20
> Hmm. So of_iomap() leaves us dependent on dt specific calls. Whilst it
> doesn't
> exactly look hard to create a generic version covering at least dt and ac=
pi
> I don' think there is an equivalent acpi function currently defined.

Correct. I tried finding it but couldn't find. This was sort of a workaroun=
d that I did.

>=20
> Andy, do you think this is a good thing to add to the generic firmware no=
de
> handling?  It's a bit specialist as most of the time this will be wrapped=
 up
> in the platform device handling or similar rather than being in a child n=
ode like
> this.
>=20
>=20
> > +		if (!ams->pl_base)
> > +			return -ENXIO;
> > +
> > +		ret =3D devm_add_action_or_reset(dev, ams_iounmap, ams-
> >pl_base);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* Copy only first 10 fix channels */
> > +		memcpy(channels + num_channels, ams_pl_channels,
> > +		       AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
> > +		num_channels +=3D AMS_PL_MAX_FIXED_CHANNEL;
> > +
> > +		num_channels =3D ams_get_ext_chan(np, channels,
> > +						num_channels);
> > +	} else if (fwnode_property_match_string(np, "compatible",
> > +						"xlnx,zynqmp-ams") =3D=3D 0) {
> > +		/* add AMS channels to iio device channels */
> > +		memcpy(channels + num_channels, ams_ctrl_channels,
> > +		       sizeof(ams_ctrl_channels));
> > +		num_channels +=3D ARRAY_SIZE(ams_ctrl_channels);
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	return num_channels;
> > +}
> > +
> > +static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_dev=
ice
> *pdev)
>=20
> Almost nothing in here is dt specific now, so you could rename it
> ams_parse_firmware()

Sure.

>=20
> > +{
> > +	struct ams *ams =3D iio_priv(indio_dev);
> > +	struct iio_chan_spec *ams_channels, *dev_channels;
> > +	struct fwnode_handle *child_node =3D NULL, *fwnode =3D
> dev_fwnode(&pdev->dev);
> > +	int ret, ch_cnt =3D 0, i, rising_off, falling_off;
> > +	unsigned int num_channels =3D 0;
> > +
> > +	/* Initialize buffer for channel specification */
> > +	ams_channels =3D kzalloc(sizeof(ams_ps_channels) +
> > +			       sizeof(ams_pl_channels) +
> > +			       sizeof(ams_ctrl_channels), GFP_KERNEL);
> > +	if (!ams_channels)
> > +		return -ENOMEM;
> > +
> > +	if (fwnode_device_is_available(fwnode)) {
> > +		ret =3D ams_init_module(indio_dev, fwnode, ams_channels);
> > +		if (ret < 0)
> > +			goto err;
> > +
> > +		num_channels +=3D ret;
> > +	}
> > +
> > +	fwnode_for_each_child_node(fwnode, child_node) {
> > +		if (fwnode_device_is_available(child_node)) {
> > +			ret =3D ams_init_module(indio_dev, child_node,
> > +					      ams_channels + num_channels);
> > +			if (ret < 0) {
> > +				fwnode_handle_put(child_node);
> > +				goto err;
> > +			}
> > +
> > +			num_channels +=3D ret;
> > +		}
> > +	}
> > +
> > +	for (i =3D 0; i < num_channels; i++) {
> > +		ams_channels[i].channel =3D ch_cnt++;
> > +
> > +		if (ams_channels[i].scan_index < AMS_CTRL_SEQ_BASE) {
> > +			/* set threshold to max and min for each channel */
> > +			falling_off =3D
> > +
> 	ams_get_alarm_offset(ams_channels[i].scan_index,
> > +						     IIO_EV_DIR_FALLING);
> > +			rising_off =3D
> > +
> 	ams_get_alarm_offset(ams_channels[i].scan_index,
> > +						     IIO_EV_DIR_RISING);
> > +			if (ams_channels[i].scan_index >=3D
> AMS_PS_SEQ_MAX) {
> > +				writel(AMS_ALARM_THR_MIN,
> > +				       ams->pl_base + falling_off);
> > +				writel(AMS_ALARM_THR_MAX,
> > +				       ams->pl_base + rising_off);
> > +			} else {
> > +				writel(AMS_ALARM_THR_MIN,
> > +				       ams->ps_base + falling_off);
> > +				writel(AMS_ALARM_THR_MAX,
> > +				       ams->ps_base + rising_off);
> > +			}
> > +		}
> > +	}
> > +
> > +	dev_channels =3D devm_kzalloc(&pdev->dev, sizeof(*dev_channels) *
> > +				    num_channels, GFP_KERNEL);
> > +	if (!dev_channels) {
> > +		ret =3D -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	memcpy(dev_channels, ams_channels,
> > +	       sizeof(*ams_channels) * num_channels);
> > +	indio_dev->channels =3D dev_channels;
> > +	indio_dev->num_channels =3D num_channels;
> > +
> > +	ret =3D 0;
> > +err:
> > +	kfree(ams_channels);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info iio_ams_info =3D {
> > +	.read_raw =3D &ams_read_raw,
> > +	.read_event_config =3D &ams_read_event_config,
> > +	.write_event_config =3D &ams_write_event_config,
> > +	.read_event_value =3D &ams_read_event_value,
> > +	.write_event_value =3D &ams_write_event_value,
> > +};
> > +
>=20
> ...
>=20
> > +static int __maybe_unused ams_resume(struct device *dev)
> > +{
> > +	struct ams *ams =3D iio_priv(dev_get_drvdata(dev));
> > +	int ret;
> > +
> > +	ret =3D clk_prepare_enable(ams->clk);
>=20
> Given clk_prepare_enable() uses if (ret) to check in all paths we
> it will not ever return a positive value so you can shorten this to
>=20
> 	return clk_prepare_enable(ams->clk);
>=20
> and drop the local variable ret.

Will do.

>=20
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> ...
>=20
> Jonathan
>=20

Thanks,
Anand
