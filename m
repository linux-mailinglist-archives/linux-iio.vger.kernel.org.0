Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30843AFED
	for <lists+linux-iio@lfdr.de>; Tue, 26 Oct 2021 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhJZKUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Oct 2021 06:20:48 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:36289
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230467AbhJZKUq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Oct 2021 06:20:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3NxjzD4hG0VFa3WdJ+Ak7A7CmcZV8vw8Ifn4mJHyMP5VTO+8MKz72GCFkND0TQnBqLxALo5BACh/UBCSw8hFwDukPnIlLYgmLR55cYDLrEgsP2gaSraUUul1hPxmh/c+y0Kk3IQXX4EMOsbbyo2fMve3EMeTnpcZwwsu9erUuvoO8ylRoSgC7cWZCXWmWPzhNPpnetCwJ3iTlNR/n7QVITu4BKxyFFORX+zCNhPpsd0D0fVDOtEDklrl5rcylfv8NkyM7BaBKlJvZORtyydoGJIvz58mRhu+2y01j1ZcFMv53qdb4Wc6ur8s8pDJFF2uR9qWbasqJJ82lNtONhQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94/GuxMyqhWjNu9S4fXUr/9D+JlmOqJsiQTUspWOH1U=;
 b=Z9NPDDL9ICH0DxRhFXPnoZnTaGI7+1h1vaD9XPPzBuXrwBRPS0qoQUoSkbRdBlT/Lv/kM0PBb1f6s8I2Vp8WFPU7kZKquebhSpboT9soOY2xTy5AkdsyuzVDdb2ZZt6FfGGizT2TpQrlPV5N3P0l1dNUSU0pvK0POBvPspYiI3olwmYkUixWSgBcpMfHCL7kca2R/sx/yWB+v3fN3rHfo9U/pr77e7DiV0qZDpTjPp+Vh3d6xDpggXvrhi2bDaHXMywKGJWYvdFkS+uPspGtHUzezsR0uLywEs6EeHx5Nk7ch9Fmr0Jk1KSzs83YTTyxQcS06iK7nGsXSMuO1/y4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94/GuxMyqhWjNu9S4fXUr/9D+JlmOqJsiQTUspWOH1U=;
 b=JUQrH0c3bQrXwiUMIl/2Mdr2Cf08hDNbFJWVtrKCpI+fGozJRiYGcFBfqNLHLnruldSqGJmTGII2OjHbNfa3c9SeM8VdMPrAmthRUrUXne/3igFq4F6eA1sSC338IN8plU02yHJ+/PQtoBvJ7JbkbSwQqUrMnYGe+ujLtSYxbkc=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by BY5PR02MB6100.namprd02.prod.outlook.com (2603:10b6:a03:1f8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 10:18:18 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 10:18:18 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHXxPztLE/r+aVUT0W7KtDOJosftqvdTWcAgAfLT5A=
Date:   Tue, 26 Oct 2021 10:18:17 +0000
Message-ID: <BY5PR02MB6916B1D4F3FB8D88C222973CA9849@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
        <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
 <20211021120626.56cf1b8d@jic23-huawei>
In-Reply-To: <20211021120626.56cf1b8d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa15e727-19d8-4d05-360d-08d99869edf8
x-ms-traffictypediagnostic: BY5PR02MB6100:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BY5PR02MB6100C45A2536210E02593E0AA9849@BY5PR02MB6100.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oiWQiifHRftOrjIH+6TQnfSq3IulrLBmIgw4uq+BIYKflQE3ErstD0SNu+KGmKflLrykM0Mc9A5/nFEBG9309wKt4xcYbuIyzK8mojnn4XxduY1khG9stMOPVXV/Dl09WWYz+xmLHXchcXqD4oXEIGfkJZc9uTn9Mao0K7HR3BSWjKXuRsLQ2h5qEPvdITJ9ZEcaoxEU8G/DIw/aMBLvQ6JDso+SPhQb0vrDntHBWCiN+4C2g0p7xqGTxkvFw8BR26EjpVMjge38Ex1xEGL2Tz6ctfABEy8qwqdqTt4yEcpbwKpgeVIiXCRlDdQWrWM6EnNGPxNtiKS6h+Vwi3iWg0XuKeYTRIyRR45gB/HTzqm4vInUMhzZZhpMQRk33kNAgsgx9h37iS0arkk1uT2KV5BqBB9CRXL9QcIWAxyzK65jWA1jaUFnFchq6u4W3KW4VKr248XhkGtModS6BSl1mUaZJ3i5hUXjSQLNFakyQAguuJzn7fQsQr5QCGs5H5+kemg/RtJfKklEkEZAHxaM5KQ3d6f8sS01PJyE32rL23IrVxcqm8+OnGsjc826zrNBJY7tN5pc1oWDgLpJV4ZLyIW8ZmWRsCL+nuHcR4EV9pWjH0PPAMYr7SYx21Ayzbd7bJcmxe2Fux7YIBIYdxYWx+Okopg1MFFKGgU2zKTXqAVXqP+isJJvlhhNmRp0QE/sLnhyWSmKU5CbgzDtydGXsAWY+mAuseY5i8FMeUrOixsM/fpyDKVdM6gjEILdnJP7YB6PZShyghbpPVxQ1+UYhoLwzYAwAGdiTlll9Nn4Lz8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52536014)(26005)(55016002)(6506007)(64756008)(66446008)(66946007)(5660300002)(4326008)(2906002)(186003)(9686003)(107886003)(966005)(71200400001)(38100700002)(8936002)(54906003)(508600001)(86362001)(6916009)(83380400001)(122000001)(8676002)(33656002)(66476007)(38070700005)(316002)(7696005)(66556008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ndp+B9zjyh7CIT03aj+CJozljh/L31BtFQFaY4IIciJH3hvKRMCXAoPfflVl?=
 =?us-ascii?Q?C550vP1JrXAJ9bEAmEz2acSlRZmc8bLowvheCZ5TSCtoDd//cpTN4xIcCMbo?=
 =?us-ascii?Q?9duq7XPcz7/OCFnKTE7PKhowb1t0aqEQGDil0YML6nEobQxLWDG7HVZEOM9E?=
 =?us-ascii?Q?DV8jmwDRzGBObXFGzPZ1twQilZHpn8vgDmiKOwj5p1Pc2G0chSfXrl1ON0xm?=
 =?us-ascii?Q?362iyOiVx35e/nmyDZgJY8XaimDRHm2B9mDcOxLo2vt8tlm6QpMfbUOjINQF?=
 =?us-ascii?Q?1M7cedvGiwybnMtSDYgIHYP6/pDy5L9RELmy2xct2yRbs+pgfN1QSeu1ISfH?=
 =?us-ascii?Q?wrTwNbVKUhhline3ktKEsmoGmf40+3oJhFHgm9iGmTOAPi1JWD5MmtyeglAH?=
 =?us-ascii?Q?yOR0qMvtrL4ET35wrBOyr9EtpGJPyyreW3D6riaVGfMwwwXr2Lz2nghcp1QW?=
 =?us-ascii?Q?jOelGE+KxkoVMX9k4txK973f4N8fYgmP1fxC/hhSqSLtEg2pqsOhY74chnaQ?=
 =?us-ascii?Q?lSsGYICzq146ZBIxAKYINqJ9n6Zgc1quZdb4CHCn/dNPdGuAm+8SMEsqLh4Q?=
 =?us-ascii?Q?Vt72qvUA7jg3kjbQVSJqmqndf+R4wlhoEVRdrachuGuewoyXwMtUmEoL1Dl8?=
 =?us-ascii?Q?2BqHvTVWqxkrG4faAGANv37oHeTQ8jCU+0cFzW1HEhX87bP6/MvFR/DhPHJv?=
 =?us-ascii?Q?bp91qHJo9q8FM8W2vV6WbO555cfh0nNeJvN3TDl7WefnLXq/chGmpJ9aSeMa?=
 =?us-ascii?Q?kM1F68HVdCSw9KAxpruMGtULbrXhWNwKAc2YH6ZinObrxeZAkHH+QEEkejY4?=
 =?us-ascii?Q?I67a8hwCB/RqNdvYo6I436t+W1+3uQptwb9bwYr3UMNod52FNhrKXsEh7z7E?=
 =?us-ascii?Q?6fdklZeTFe6KhTD1WqAXLZUee7ESd8qcaALxbD65tirZI//6oglYZEiygXPq?=
 =?us-ascii?Q?PfUVxZjf+NLJoGulU9MGN+9nndzhbrWviUYbiNBbh/ivEzQhN8f2XzeJPlWL?=
 =?us-ascii?Q?xM2/m4eSo8c0PQKxRnUJl08LYaWo5+8tt1bh+AmkNgLCD+k0QeZ7v9mJCik4?=
 =?us-ascii?Q?ifiqQcrH23dSenEXWraLI3RwSJI3dn9Og2Bw31JQ4Sq/LnBOoeyVWr5URwJe?=
 =?us-ascii?Q?JRrgzXpiOfYEsi3c4TR1TlL5kdxwi88wsfQZJ8l0fpl7dKBYRCfDonOIqi+b?=
 =?us-ascii?Q?6BunKabIbLAH92x2VBWQ6rrTjCxOYD67aDURdw70OUnpBDH5m6g4T+Cs4HmH?=
 =?us-ascii?Q?u6mloMX7Qi9hWnKWhAwO+8eWqzGp4MwZ+Kje+nZjmjysMdsJIu7bnvZxWVhF?=
 =?us-ascii?Q?IxzS52R62ltNfEymWeajBC3qlPp0yFqluSrjmJThZkk/I1jdFgyFmK5tHZbj?=
 =?us-ascii?Q?/IpZhLCp1w6T4LtARjZSMrYM/JEOCPW+FSD1Z0LacuxJhun8nvMIufUmSGJZ?=
 =?us-ascii?Q?aK/1CJDAh//cK9NCOjqEjlKHHiuzfbpbwntLG1Daj7ucjwSGYAnI5T70Q+Lx?=
 =?us-ascii?Q?7itLo5Cm0A7dic1a4geXvlCZv8IRn/2443lmhGF8G6smsO44Ri6zqC3GHZuy?=
 =?us-ascii?Q?XOaRc1toISg80v+GTKRy69FDnqYWRTXireN7z1vl0xW9W+hjmppmdcFzwrpO?=
 =?us-ascii?Q?zA6ChWWpQNhk+jDvaIIsv9k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa15e727-19d8-4d05-360d-08d99869edf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 10:18:17.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JEgvzTgZGESGbT1dtwPhjX893pPar/krDEGZHe1W6Ie3GQBhoqQd5XjKKOH1/8XDCVLAZwS3SerCZ4pby58qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6100
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey Jonathan,

Thanks for the review.=20

> On Tue, 19 Oct 2021 16:20:46 +0100
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
>=20
> It would be good at some point to move away from of specific firmware
> property reading, but on a platform like this I guess you can be fairly s=
ure no
> one will be using ACPI or other firmware description options so I'm not g=
oing
> to insist on it for an initial merge.
>=20
> Other comment I have are fairly minor but we need to leave some time for
> other reviews and in particular DT binding review.

Sure. I will wait for the DT binding review before I send my fixes.

>=20
> > ---
> >  drivers/iio/adc/Kconfig      |   13 +
> >  drivers/iio/adc/Makefile     |    1 +
> >  drivers/iio/adc/xilinx-ams.c | 1341
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 1355 insertions(+)
> >  create mode 100644 drivers/iio/adc/xilinx-ams.c
>=20
> ...
>=20
> > diff --git a/drivers/iio/adc/xilinx-ams.c
> > b/drivers/iio/adc/xilinx-ams.c new file mode 100644 index
> > 000000000000..597cdda8a618
> > --- /dev/null
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -0,0 +1,1341 @@
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
> #include <linux/mod_devicetable.h> for the of_device_id structure
> defintion.
>=20
Will add it in the next series.

> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
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
> > + * @masked_alarm: currently masked due to alarm
> > + * @alarm_mask: alarm configuration
> > + * @interrupt_mask: interrupt configuration
> > + * @irq: interrupt number of the sysmon
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
> > +	/* check kernel doc above */
> > +	struct mutex lock;
> > +	/* check kernel doc above */
> > +	spinlock_t intr_lock;
> > +	unsigned int alarm_mask;
> Docs should be same order as the fields.
> > +	unsigned int masked_alarm;
> > +	u64 intr_mask;
>=20
> That's not the name in the docs.  Run kernel-doc script over this and fix=
 all the
> errors / warnings.
>=20
Will do it before I send next series.
Will fix the error.

> > +	int irq;
> > +	struct delayed_work ams_unmask_work; };
> > +
>=20
> ...
>=20
> > +
> > +static irqreturn_t ams_irq(int irq, void *data) {
> > +	struct iio_dev *indio_dev =3D data;
> > +	struct ams *ams =3D iio_priv(indio_dev);
> > +	u32 isr0;
> > +
> > +	spin_lock(&ams->intr_lock);
> > +
> > +	isr0 =3D readl(ams->base + AMS_ISR_0);
> > +
> > +	/* only process alarms that are not masked */
> > +	isr0 &=3D ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) |
> > +ams->masked_alarm);
> > +
> > +	if (!isr0)
>=20
> lock held.

Will fix.

>=20
> > +		return IRQ_NONE;
> > +
> > +	/* clear interrupt */
> > +	writel(isr0, ams->base + AMS_ISR_0);
> > +
> > +	/* Mask the alarm interrupts until cleared */
> > +	ams->masked_alarm |=3D isr0;
> > +	ams_update_intrmask(ams, 0, 0);
> > +
> > +	ams_handle_events(indio_dev, isr0);
> > +
> > +	schedule_delayed_work(&ams->ams_unmask_work,
> > +			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
> > +
> > +	spin_unlock(&ams->intr_lock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
>=20
> ...
>=20
> > +
> > +static int ams_parse_dt(struct iio_dev *indio_dev, struct
> > +platform_device *pdev) {
> > +	struct ams *ams =3D iio_priv(indio_dev);
> > +	struct iio_chan_spec *ams_channels, *dev_channels;
> > +	struct device_node *child_node =3D NULL, *np =3D pdev->dev.of_node;
> > +	int ret, vol_ch_cnt =3D 0, temp_ch_cnt =3D 0, i, rising_off, falling_=
off;
> > +	unsigned int num_channels =3D 0;
> > +
> > +	/* Initialize buffer for channel specification */
> > +	ams_channels =3D kzalloc(sizeof(ams_ps_channels) +
> > +			       sizeof(ams_pl_channels) +
> > +			       sizeof(ams_ctrl_channels), GFP_KERNEL);
> > +	if (!ams_channels)
> > +		return -ENOMEM;
> > +
> > +	if (of_device_is_available(np)) {
> > +		ret =3D ams_init_module(indio_dev, np, ams_channels);
> > +		if (ret < 0)
> > +			goto err;
> > +
> > +		num_channels +=3D ret;
> > +	}
> > +
> > +	for_each_child_of_node(np, child_node) {
> > +		if (of_device_is_available(child_node)) {
> > +			ret =3D ams_init_module(indio_dev, child_node,
> > +					      ams_channels + num_channels);
> > +			if (ret < 0)
> > +				goto err;
>=20
> for_each_child_of_node() holds a reference if we jump out of the loop
> before it terminates.
> https://elixir.bootlin.com/linux/latest/source/drivers/of/base.c#L715
> is where it ultimately releases that reference when the loop is terminati=
ng.
> Her you need to do it manually with an of_node_put() call
>=20
Correct. Will fix this.=20
> > +
> > +			num_channels +=3D ret;
> > +		}
> > +	}
> > +
> > +	for (i =3D 0; i < num_channels; i++) {
> > +		if (ams_channels[i].type =3D=3D IIO_VOLTAGE)
> > +			ams_channels[i].channel =3D vol_ch_cnt++;
> > +		else
> > +			ams_channels[i].channel =3D temp_ch_cnt++;
> > +
> > +		if (ams_channels[i].scan_index < (AMS_PS_SEQ_MAX * 3)) {
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
>=20
> We now have the option of devm_krealloc()   If you used that in conjuncti=
on
> with devm_kzalloc to replace the kzalloc above, you could avoid this need=
 to
> copy.  Not important though if you prefer doing this manual version.
>=20
For now I will leave this as is. But will update after initial check-in.

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
>=20
> ...
>=20
> > +static int ams_probe(struct platform_device *pdev) {
> > +	struct iio_dev *indio_dev;
> > +	struct ams *ams;
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
> > +	spin_lock_init(&ams->intr_lock);
> > +
> > +	indio_dev->name =3D "xilinx-ams";
> > +
> > +	indio_dev->info =3D &iio_ams_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	ams->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(ams->base))
> > +		return PTR_ERR(ams->base);
> > +
> > +	ams->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(ams->clk))
> > +		return PTR_ERR(ams->clk);
> > +	clk_prepare_enable(ams->clk);
> > +	devm_add_action_or_reset(&pdev->dev,
> ams_clk_disable_unprepare,
> > +				 ams->clk);
> > +
> > +	INIT_DELAYED_WORK(&ams->ams_unmask_work,
> ams_unmask_worker);
> > +	devm_add_action_or_reset(&pdev->dev,
> ams_cancel_delayed_work,
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
> > +	if (ams->irq =3D=3D -EPROBE_DEFER) {
> > +		ret =3D -EPROBE_DEFER;
> > +		return ret;
> > +	}
> > +
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
> > +	ret =3D devm_iio_device_register(&pdev->dev, indio_dev);
> > +
>=20
> return devm_...
>=20
Will do.

> > +	return ret;
> > +}
> > +
>=20

Thanks,
Anand
