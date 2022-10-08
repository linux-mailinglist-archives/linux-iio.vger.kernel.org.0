Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCDF5F847E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Oct 2022 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJHJBf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Oct 2022 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJHJBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2022 05:01:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF825B75;
        Sat,  8 Oct 2022 02:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbr6lITAaNsrt3+IN0DkanncIY3Ak0rcm9kAPxlwFRXdsQfXi6GfhAgwUeyjPdPmWdCiuhJ2rRiohcI4tP6Zw23aICMgc0chL8huISrZNoCtwXwREEw46MSL1a2iRm2iVqrhXpnMfYUQA3EkNdFlhGvc7MfIoJ8x8rz8ogAe7/J0PcTpSWOcfKC8HE+SMcTclPri8GUSAiL3aIZQo6ll6LpSBD0BDgAu8F1yXy25PDJsD7Z/TvqACwPkT9JoW1Ho1hYPQSZXA3mB3d8O5NqwqFIr5mbTM/sSjtmKvYq9ENyNqStXw1uajtdOaodSubmnXnt9L70GYyehgmozszLlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IH32litZc73lJEodEIBnWMivoILTnxzb1CSDS4Z0NcI=;
 b=Y5aLUU6b+cH/i3/VgvEg/fRjypewBINPhDpi9gewxSVZfAtFtwH25qsA3m31+2rQqTX/BpLvBREoD51awEpctOFQV3Hq6g0HunXqE4/C4vWEkvVRuPIi0ZuLMOVOL9kMZzQ0Kk6WaKUQRySq3Uxi5QQOVn2rceuYyt+bLQlAPLMrQbPAoDQ9oVTDiECqxxMR6RpJZqK/N7mR2nfod3NsN/JpCwTNtmox8KlmHxuItHJSf1FIvz7pGeqgnGATHres8IvwnJ7nwzOHfmimpGcrt444x/xoS7PZhnoxkDA3UWfNg6WWb6aMgT9K2cE0ZeYIhj1Uwszm/+y0eMRd4BYoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IH32litZc73lJEodEIBnWMivoILTnxzb1CSDS4Z0NcI=;
 b=j7Oj1o8/l742Qjk5RG7oboWouCDcjDp9v/bkxwTp5EIHEqx2oWwwg2e2uEbzWesce5ut74bzAoIRFTNmJQ109Wk3TAfAYD1HK5LjMaIO0T1bzzM4lU5QxLnlMf7Sl/E5NkinvVoI0Fe76t1yX4SM2iYA41FXGu+DvOEN+JsLe0M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6042.jpnprd01.prod.outlook.com (2603:1096:402:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sat, 8 Oct
 2022 09:01:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.015; Sat, 8 Oct 2022
 09:01:21 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Topic: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Thread-Index: AQHY2YuZOjF5ExCDW0e8KGUbGYk53a4DudqAgABULJA=
Date:   Sat, 8 Oct 2022 09:01:21 +0000
Message-ID: <OS0PR01MB5922B6980F38873D494B3937865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
 <Y0DUQTMd2TpFTnZS@fedora>
In-Reply-To: <Y0DUQTMd2TpFTnZS@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6042:EE_
x-ms-office365-filtering-correlation-id: 88c47f5e-d269-46e9-a298-08daa90babd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXCGoH9WLot3a4rCEpHYJhBFYanXRPDvqildWbYEANDuTpGdJA0G4REacojT/hO5r1L/h/UsecpCx0eUAtcjKcDHDudmqjS6e/5NCIwN7LEdKy1ZxzXchhyiimOe38Ba7f4ejIlK42csaww8Q594Sk+d0qpvWt6tDwo+2t9Ne9j0RG0ywVhDy/T/240oJQwFZS0/YYqwAnCAbgQCcPiEY2XycL/jG+dtBM11rm2PS6Ul7IYFQUY4gXBuDjYg65YkhS8O3DuVqlqmtdro7Z2d30MaZ6EXKfplEzasyZoJ7WkCjSjrz0SUqnUpXoz7+ni8GPGDdHAmbSxOpS174xyDDJTJ3mdDcz1GIhOloChlSGYc9mRi7iH89aYIJTETzVb+rHiuwgZs5cAGNvD0eBru2cD6cL8R20OgLx4ezsGbNB42BIdd28wvJpYsolBWv+wek3A7cLWFRRiYSvt0cS+IxsWeKIUze0O9Y+C7cEeGlA9ZeJv0JQoESPMigCZM/s9DY1jNbQ+17nNcZWKak9Fcb5A/OFg3LPnN8AHMw2BKQV1RzX91TXUuW1G+NuzwppV+ozN3eScJE1H6gcpXEl2xfCcCaUQ0fogC0/ndt/aMVqqxgxRyo+jVT/hfuEsTbm05c1TPZDK+8c+SPeprgEQ3LiET94+nIvjM80FLa2IWcgkMDg+SpCsPnhM+6MKmvmv/6hwvzd8BVAk+F9Xj7ZKM6duG+fLvo7wL+apmokeIFW2JzYoPaRXUslWZQRFuh/MwIydnxpjuaXcA55Ay3lhdb02K8XI+X/CtDQYMqEaRp8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(33656002)(110136005)(5660300002)(83380400001)(54906003)(316002)(52536014)(8936002)(186003)(122000001)(41300700001)(38100700002)(478600001)(966005)(2906002)(38070700005)(71200400001)(86362001)(55016003)(30864003)(9686003)(8676002)(26005)(66446008)(66476007)(76116006)(6506007)(66946007)(66556008)(64756008)(7696005)(4326008)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?muPoBBUspHxs7v9TkJrZmT9WKYZfnaJJXtPPPiMShtLs9axur7MVX88dlj/R?=
 =?us-ascii?Q?sQ+GmcfpEIaus/LzVSW4MsG7GqkROu/4eUeYOjQZYAORvC8bppZ/6QWKAhwO?=
 =?us-ascii?Q?gPPoSXnFbx/JiwpJZEjkrCqciSMm9FLlFbAOkoSyQPYZcMur8XPm1BVBu7TV?=
 =?us-ascii?Q?QQ3UNlZmAFg4X21yBxYoqVFGP6FWscMwCMINSt7P5ozOpdGorLhJRkvXdbuY?=
 =?us-ascii?Q?5WbkLJtk9o1tsnOfIK6zNOZQmQQm3ne/safPSN8HeJ4bGoOVZ362vC43Ceqz?=
 =?us-ascii?Q?fdQskTu2Wt21sKWV2tud1YLTOXZqerl/yvO1Fsqa6jb+h2dd6kxvIcUp+hc4?=
 =?us-ascii?Q?E95velB75rndCVOi25yOXAjlTsf+mTw9yubBR/WM+KF+UE+czDK6wUYA3Lvp?=
 =?us-ascii?Q?B5K090wQBuKvZrJ1CSFE99vWGpPXvHj/ahqjXpIjYyV4LdN4/U+EI+vHJNsa?=
 =?us-ascii?Q?38yCMKhnLdQr7Vd+AFXkuJpRqd/fh1rgpZAHKLmVXEucKUtpojCeUFyxSz96?=
 =?us-ascii?Q?lY6DE1nVYqHHvSxcfqRAZ2JD0e943kY72F/tsQeARizNfIqZtlsQeitP0a70?=
 =?us-ascii?Q?htVSld3cH0OwnKhFCfrenD3EbQI1mnN8Yay70xovzfYD7Mg+ePsX+DxlwGgQ?=
 =?us-ascii?Q?zoMdMwDuQl7bqmJUTJl3F9rQYBhRk7pT8U15d5ekdz37I+udnNA5PuTCGntC?=
 =?us-ascii?Q?2R0QZFNHZQLH1eQCLJpo6hjEdUKc1UPsg7667V5rs9F3w50ulKrj/Pk0bJUv?=
 =?us-ascii?Q?iau92DRpNZhDboSSi9vpJkWOb8DQgZNTF4l7naVY0+bcd3jWYmkw06B70Ovr?=
 =?us-ascii?Q?jDXBLDX577BcVVhUyAr5q3fmeugFYXoB7j67CRn6nGeKf8oJUZn1eO/iGy8g?=
 =?us-ascii?Q?Wu92AMG/wlx1aEGq62sRtxc1TpF1g1YWD/6Fa0m+MUYntT+yy64g0zCPf2uB?=
 =?us-ascii?Q?Y9BIut8A9bHAVQay5KGaMMAI93xbSx7v06VlKBxmGay9P7jlHUm1a6UdTcqu?=
 =?us-ascii?Q?g93qSvm5uBCGglHFGU6t9lftvhy5ryaSlhgtj8e0lZ7/4/7gvG65fa+fcTI7?=
 =?us-ascii?Q?4YJX4NQ8iHofn8T3AerpOl8P395PnqOfG6s4w1lJoi+t9QrOYJFqe8pEUlFq?=
 =?us-ascii?Q?uIcwZwyTqzHkL0//vQLvH7UoGSBE79SeOqQjW6dPk3GObdo0yN8n1LB3f7Sb?=
 =?us-ascii?Q?vxGdWL4ujKi3hEE+l/aHNX3gVWUK8VXz1BJMcgJrEZWcQlDOUxOhyvUY9e8D?=
 =?us-ascii?Q?BUk5olcCEWE0HmhHg+dykfM3x4ISX5NMYXNywPt5ZPVPGSPuwcgt4fdkqYV/?=
 =?us-ascii?Q?O59osoC6OiqiB7uU+D7MUBkaLhm6/ZWOcGiRd1WKmTZRGlvvqMkVSr/l0jTT?=
 =?us-ascii?Q?6NwQ2C+3gpboT0o9X3TbRIG0wup7+atU5NVuC5Y4pZufNE3/81Kby9kZIQrJ?=
 =?us-ascii?Q?xJvB02sc5LLtPV66ppmIXAJkmDAinzldsi27P5b9mrhl/OHxqd47dRW4xZve?=
 =?us-ascii?Q?IxAO1G5rDkbsJy1MNA+vK7KnDa9D/xQJ8zAMZrfzNPHeGSihEjCAt7stViCD?=
 =?us-ascii?Q?lSA7l54O5Yc5U6QfJpdUBcKNvrHyAa7sqkh2eCHQQU5nQIhPEDfZFHg/mjl+?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c47f5e-d269-46e9-a298-08daa90babd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2022 09:01:21.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDWhCQ1+HE7SpTZxou2jR4msjVWiqwG5BTKcxFNFXC/mUK8JzBa6w8Z8leg5JgG9WfD6pQiFhm5DXOy3ARxFIAmZA64okRJ0aSse5dHQBfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> Subject: Re: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
>=20
> On Thu, Oct 06, 2022 at 02:57:17PM +0100, Biju Das wrote:
> > Add RZ/G2L MTU3 counter driver.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi Biju,
>=20
> This commit message is rather brief for an introduction of a new
> driver.
> Provide a description of the functionality provided (e.g. two 16-bit
> Counts or one 32-bit Count) as well as the hardware this driver
> supports for context (e.g. what does MTU3 mean; is this a SoC; etc.).

OK Will do. MTU3- Multi-Function Timer Pulse Unit 3 (MTU3a). It is
an on-chip module on RZ/G2L SoC

>=20
> > ---
> > v1->v3:
> >  * Modelled as a counter device supporting 3 counters(2 16-bit and
> >    32-bit)
> >  * Add kernel-doc comments to document struct rz_mtu3_cnt
> >  * Removed mmio variable from struct rz_mtu3_cnt
> >  * Removed cnt local variable from rz_mtu3_count_read()
> >  * Replaced -EINVAL->-ERANGE for out of range error conditions.
> >  * Removed explicit cast from write functions.
> >  * Removed local variable val from rz_mtu3_count_ceiling_read()
> >  * Added lock for RMW for counter/ceiling updates.
> >  * Added different synapses for counter0 and counter{1,2}
> >  * Used ARRAY for assigning num_counts.
> >  * Added PM runtime for managing clocks.
> >  * Add MODULE_IMPORT_NS(COUNTER) to import the COUNTER namespace.
> > ---
> >  drivers/counter/Kconfig       |   9 +
> >  drivers/counter/Makefile      |   1 +
> >  drivers/counter/rz-mtu3-cnt.c | 568
> > ++++++++++++++++++++++++++++++++++
> >  3 files changed, 578 insertions(+)
> >  create mode 100644 drivers/counter/rz-mtu3-cnt.c
> >
> > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig index
> > d388bf26f4dc..531b187e4630 100644
> > --- a/drivers/counter/Kconfig
> > +++ b/drivers/counter/Kconfig
> > @@ -39,6 +39,15 @@ config INTERRUPT_CNT
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called interrupt-cnt.
> >
> > +config RZ_MTU3_CNT
> > +	tristate "RZ/G2L MTU3 counter driver"
> > +	depends on MFD_RZ_MTU3 || COMPILE_TEST
> > +	help
> > +	  Select this option to enable RZ/G2L MTU3 counter driver.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called rz-mtu3-cnt.
> > +
>=20
> Provide a bit more description of the hardware here; you should at
> least mention this is a Renesas RZ/G2L as opposed to some other
> manufacturer.

OK.

>=20
> >  config STM32_TIMER_CNT
> >  	tristate "STM32 Timer encoder counter driver"
> >  	depends on MFD_STM32_TIMERS || COMPILE_TEST diff --git
> > a/drivers/counter/Makefile b/drivers/counter/Makefile index
> > b9a369e0d4fc..933fdd50b3e4 100644
> > --- a/drivers/counter/Makefile
> > +++ b/drivers/counter/Makefile
> > @@ -8,6 +8,7 @@ counter-y :=3D counter-core.o counter-sysfs.o
> > counter-chrdev.o
> >
> >  obj-$(CONFIG_104_QUAD_8)	+=3D 104-quad-8.o
> >  obj-$(CONFIG_INTERRUPT_CNT)		+=3D interrupt-cnt.o
> > +obj-$(CONFIG_RZ_MTU3_CNT)	+=3D rz-mtu3-cnt.o
> >  obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
> >  obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
> >  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
> > diff --git a/drivers/counter/rz-mtu3-cnt.c
> > b/drivers/counter/rz-mtu3-cnt.c new file mode 100644 index
> > 000000000000..26b5ea3852f8
> > --- /dev/null
> > +++ b/drivers/counter/rz-mtu3-cnt.c
> > @@ -0,0 +1,568 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L MTU3a Counter driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation  */ #include
> > +<linux/counter.h> #include <linux/mfd/rz-mtu3.h> #include
> > +<linux/module.h> #include <linux/of.h> #include
> > +<linux/platform_device.h> #include <linux/pm_runtime.h> #include
> > +<linux/types.h>
> > +
> > +#define RZ_MTU3_TSR_TCFD	BIT(7)
> > +#define RZ_MTU3_MAX_HW_CNTR_CHANNELS	(2)
> > +
> > +#define RZ_MTU3_TMDR1_PH_CNT_MODE_1	(4)
> > +#define RZ_MTU3_TMDR1_PH_CNT_MODE_2	(5)
> > +#define RZ_MTU3_TMDR1_PH_CNT_MODE_3	(6)
> > +#define RZ_MTU3_TMDR1_PH_CNT_MODE_4	(7)
> > +#define RZ_MTU3_TMDR1_PH_CNT_MODE_5	(9)
> > +#define RZ_MTU3_TMDR1_PH_CNT_MODE_MASK	(0xf)
> > +
> > +#define RZ_MTU3_TCR_CCLR	GENMASK(7, 5)
> > +#define RZ_MTU3_TCR_CCLR_NONE	FIELD_PREP(RZ_MTU3_TCR_CCLR, 0)
> > +
> > +#define RZ_MTU3_TMDR3_LWA	BIT(0)
> > +#define RZ_MTU3_32_BIT_CH	(2)
>=20
> Providing a define to identify the 32-bit channel is a good idea.
> Defines for the other two 16-bit channels would also be good.

OK, will do.

>=20
> > +
> > +#define RZ_MTU3_TIOR_IC_BOTH	(10)
> > +
> > +/**
> > + * struct rz_mtu3_cnt - MTU3 counter private data
> > + *
> > + * @clk: MTU3 module clock
> > + * @lock: Lock to prevent concurrent access for ceiling and count
> > + * @rz_mtu3_channel: HW channels for the counters  */ struct
> > +rz_mtu3_cnt {
> > +	struct clk *clk;
> > +	struct mutex lock;
> > +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
>=20
> Does this need to be a pointer to an array of struct rz_mtu3_channel?

Yes, HW has MTU{0..8} channels and MTU{1,2} supports counters
At probe time this array is filled with *ch[0]=3D MTU1 and *ch[1]=3D MTU2

> You can avoid the double dereferences in your code if you leave it as
> a simple pointer to struct rz_mtu3_channel and use subscripts directly
> as you would an array. Or is there something I'm missing?

Please see above.

>=20
> > +};
> > +
> > +static const enum counter_function rz_mtu3_count_functions[] =3D {
> > +	COUNTER_FUNCTION_QUADRATURE_X4,
> > +	COUNTER_FUNCTION_PULSE_DIRECTION,
> > +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> > +};
> > +
> > +static bool rz_mtu3_is_16_bit_cnt_mode(struct rz_mtu3_cnt *const
> > +priv) {
> > +	return (priv->ch[0]->function =3D=3D RZ_MTU3_16BIT_PHASE_COUNTING ||
> > +		priv->ch[1]->function =3D=3D RZ_MTU3_16BIT_PHASE_COUNTING);
>=20
> Is there ever a situation where one channel is equal to
> RZ_MTU3_16BIT_PHASE_COUNTING while the other channel is equal to
> RZ_MTU3_32BIT_PHASE_COUNTING?

No that will never happen

The check is to detect runtime conditions. For eg:- user enables ch0 and th=
en tries
to enable Ch2=20

or=20

ch1 and then tries ch2.

>=20
> > +}
> > +
> > +static bool rz_mtu3_is_32_bit_cnt_mode(struct rz_mtu3_cnt *const
> > +priv) {
> > +	return (priv->ch[0]->function =3D=3D RZ_MTU3_32BIT_PHASE_COUNTING &&
> > +		priv->ch[1]->function =3D=3D RZ_MTU3_32BIT_PHASE_COUNTING); }
> > +
> > +static int rz_mtu3_count_read(struct counter_device *counter,
> > +			      struct counter_count *count, u64 *val) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 id =3D count->id & 1;
>=20
> It is not immediately clear why you are ANDing the Count id here.
> After looking at the rest of the code in this function I realized it's
> because you want to call rz_mtu3_32bit_ch_read() with id =3D 0 when you
> have
> count->id =3D RZ_MTU3_32_BIT_CH.
>=20
> I wouldn't even bother with the local id variable in this function and
> instead just hardcode priv->ch[0] in the rz_mtu3_32bit_ch_read() call
> below directly.

OK. Will do.

>=20
> > +
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		*val =3D rz_mtu3_32bit_ch_read(priv->ch[id], RZ_MTU3_TCNTLW);
> > +	else
> > +		*val =3D rz_mtu3_16bit_ch_read(priv->ch[id], RZ_MTU3_TCNT);
>=20
> Is there a risk of these read calls returning an error code?

There is no risk. as the calls with these macros{RZ_MTU3_TCNTLW,RZ_MTU3_TCN=
T}
It never return error.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_write(struct counter_device *counter,
> > +			       struct counter_count *count, const u64 val) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 id =3D count->id & 1;
>=20
> Same comment about local id variable as in rz_mtu3_count_read().
OK. Agreed.

>=20
> > +	u32 ceiling;
> > +
> > +	mutex_lock(&priv->lock);
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		ceiling =3D rz_mtu3_32bit_ch_read(priv->ch[id],
> RZ_MTU3_TGRALW);
> > +	else
> > +		ceiling =3D rz_mtu3_16bit_ch_read(priv->ch[id],
> RZ_MTU3_TGRA);
>=20
> The ceiling value isn't expected to change unless the user executes
> your
> ceiling_write() function, right? It might make sense to cache the
> current ceiling value in your rz_mtu3_cnt structure so that you don't
> have to read it out from the device every time you check it.

OK. will add channel specific array to cache these values.

>=20
> > +
> > +	if (val > ceiling) {
> > +		mutex_unlock(&priv->lock);
> > +		return -ERANGE;
> > +	}
> > +
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		rz_mtu3_32bit_ch_write(priv->ch[id], RZ_MTU3_TCNTLW, val);
> > +	else
> > +		rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TCNT, val);
> > +
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_function_read(struct counter_device
> *counter,
> > +				       struct counter_count *count,
> > +				       enum counter_function *function) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 id =3D count->id & 1;
>=20
> As mentioned before, this AND operation obscures the intention of your
> code. Instead, rename this variable and account for RZ_MTU3_32_BIT_CH
> explicitly with something like this:
>=20
>     const size_t ch_id =3D (count->id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : cou=
nt-
> >id;

OK.

>=20
> You could wrap this into a preprocessor macro to reuse again in your
> code, but I'll leave it up to you if you want.

OK.

>=20
> > +	u8 val;
> > +
> > +	val =3D rz_mtu3_8bit_ch_read(priv->ch[id], RZ_MTU3_TMDR1);
> > +
> > +	switch (val & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
> > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
> > +		*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
> > +		break;
> > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_2:
> > +		*function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
> > +		break;
> > +	case RZ_MTU3_TMDR1_PH_CNT_MODE_4:
> > +		*function =3D COUNTER_FUNCTION_QUADRATURE_X2_B;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_function_write(struct counter_device
> *counter,
> > +					struct counter_count *count,
> > +					enum counter_function function)
> > +{
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 id =3D count->id & 1;
>=20
> Same comment as in rz_mtu3_count_function_read().

OK.

>=20
> > +	u8 mode;
> > +
> > +	switch (function) {
> > +	case COUNTER_FUNCTION_QUADRATURE_X4:
> > +		mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_1;
> > +		break;
> > +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> > +		mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_2;
> > +		break;
> > +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> > +		mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_4;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TMDR1, mode);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_direction_read(struct counter_device
> *counter,
> > +					struct counter_count *count,
> > +					enum counter_count_direction *direction)
> {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 id =3D count->id & 1;
>=20
> Same comment as in rz_mtu3_count_function_read().
OK.
>=20
> > +	u8 cnt;
> > +
> > +	cnt =3D rz_mtu3_8bit_ch_read(priv->ch[id], RZ_MTU3_TSR);
>=20
> This is the timer status register, right? A variable name of 'cnt'
> seems a bit strange to me; would 'tsr' be a better name here?

Yes, it is timer status register. Will change it to tsr.

>=20
> > +
> > +	if (cnt & RZ_MTU3_TSR_TCFD)
> > +		*direction =3D COUNTER_COUNT_DIRECTION_FORWARD;
> > +	else
> > +		*direction =3D COUNTER_COUNT_DIRECTION_BACKWARD;
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_ceiling_read(struct counter_device
> *counter,
> > +				      struct counter_count *count,
> > +				      u64 *ceiling)
> > +{
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 id =3D count->id & 1;
>=20
> Same comment about local id variable as in rz_mtu3_count_read().

OK.
>=20
> > +
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		*ceiling =3D rz_mtu3_32bit_ch_read(priv->ch[id],
> RZ_MTU3_TGRALW);
> > +	else
> > +		*ceiling =3D rz_mtu3_16bit_ch_read(priv->ch[id],
> RZ_MTU3_TGRA);
>=20
> Assuming you're able to cache the ceiling value, you can set it here
> directly and avoid the reads out to the device.

OK.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_ceiling_write(struct counter_device
> *counter,
> > +				       struct counter_count *count,
> > +				       u64 ceiling)
> > +{
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	u32 id =3D count->id & 1;
>=20
> Same comment as in rz_mtu3_count_function_read().
OK.
>=20
> > +	if (ceiling > U16_MAX && rz_mtu3_is_16_bit_cnt_mode(priv))
> > +		return -ERANGE;
> > +
> > +	if (ceiling > U32_MAX && rz_mtu3_is_32_bit_cnt_mode(priv))
> > +		return -ERANGE;
>=20
> You can determine which maximum to consider by checking the count->id.
> Instead of those two conditional statments, try this instead:
>=20
>     switch (count->id) {
>     case 0:
>     case 1:
>             if (ceiling > U16_MAX)
>                     return -ERANGE;
>             break;
>     case RZ_MTU3_32_BIT_CH:
>             if (ceiling > U32_MAX)
>                     return -ERANGE;
>             break;
>     }
>=20
OK.

> If you need to check whether you're in 32-bit phase mode before
> setting the ceiling for the RZ_MTU3_32_BIT_CH Count (and similarly for
> the 16-bit Counts), check that separately and return -EBUSY as
> appropriate.

OK.
>=20
> > +	mutex_lock(&priv->lock);
> > +	if (ceiling =3D=3D 0) {
> > +		rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_NONE);
>=20
> Looks like something different is done when ceiling is set to 0. Would
> you explain what's happening in this case and why it's different that
> then else case below; in other words, what's the difference between
> RZ_MTU3_TCR_CCLR_NONE and RZ_MTU3_TCR_CCLR_TGRA?

RZ_MTU3_TCR_CCLR_TGRA --> for triggering counter count using Z-Phase signal=
.
RZ_MTU3_TCR_CCLR_NONE --> No clearing.

>=20
> > +
>=20
> You can remove this empty line.
OK.
>=20
> > +	} else {
> > +		if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +			rz_mtu3_32bit_ch_write(priv->ch[id], RZ_MTU3_TGRALW,
> ceiling);
> > +		else
> > +			rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TGRA,
> ceiling);
> > +
> > +		rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
> > +				      RZ_MTU3_TCR_CCLR_TGRA);
> > +	}
> > +	mutex_unlock(&priv->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_32bit_cnt_setting(struct counter_device
> *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +
> > +	/*
> > +	 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit
> cascade
> > +	 * counter.
> > +	 */
> > +	priv->ch[0]->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> > +	priv->ch[1]->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> > +
> > +	rz_mtu3_shared_reg_write(priv->ch[0], RZ_MTU3_TMDR3,
> > +RZ_MTU3_TMDR3_LWA);
> > +
> > +	/* Phase counting mode 1 is used as default in initialization. */
> > +	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TMDR1,
> > +			      RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> > +
> > +	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TCR,
> RZ_MTU3_TCR_CCLR_TGRA);
> > +	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TIOR,
> > +RZ_MTU3_TIOR_IC_BOTH);
> > +
> > +	rz_mtu3_enable(priv->ch[0]);
> > +	rz_mtu3_enable(priv->ch[1]);
> > +}
> > +
> > +static void rz_mtu3_16bit_cnt_setting(struct counter_device
> *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +
> > +	priv->ch[id]->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;
>=20
> If 16-bit phase counting is selected for one 16-bit counter, does the
> other 16-bit counter need to be configured as well?

Not required I guess, as it is run time decision.

After this, if user tries to enable 16-bit on other channel,
we will configure that channel. otherwise, we will return error,
if user tries to enable 32-bit channel.

Are you ok with this?=20


>=20
> > +
> > +	/* Phase counting mode 1 is used as default in initialization. */
> > +	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TMDR1,
> > +			      RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> > +
> > +	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
> RZ_MTU3_TCR_CCLR_TGRA);
> > +	rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TGRA, U16_MAX);
> > +
> > +	rz_mtu3_enable(priv->ch[id]);
> > +}
> > +
> > +static int rz_mtu3_initialize_counter(struct counter_device
> *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +
> > +	if (id =3D=3D RZ_MTU3_32_BIT_CH && rz_mtu3_is_16_bit_cnt_mode(priv))
> > +		return -EBUSY;
> > +
> > +	if (id !=3D RZ_MTU3_32_BIT_CH && rz_mtu3_is_32_bit_cnt_mode(priv))
> > +		return -EBUSY;
> > +
> > +	if (id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		rz_mtu3_32bit_cnt_setting(counter, id);
> > +	else
> > +		rz_mtu3_16bit_cnt_setting(counter, id);
>=20
> I think this code would flow better using a switch statement like
> this:
>=20
>     switch (id) {
>     case 0:
>     case 1:
>             if (rz_mtu3_is_32_bit_cnt_mode(priv))
>                     return -EBUSY;
>             rz_mtu3_16bit_cnt_setting(counter, id);
>             break;
>     case RZ_MTU3_32_BIT_CH:
>             if (rz_mtu3_is_16_bit_cnt_mode(priv))
>                     return -EBUSY;
>             rz_mtu3_32bit_cnt_setting(counter, id);
>             break;
>     }
>=20
> You should also protect this with a lock to prevent any races while
> you're accessing and modifying the settings.

OK.

>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static void rz_mtu3_terminate_counter(struct counter_device
> *counter,
> > +int id) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +
> > +	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
> > +		priv->ch[0]->function =3D RZ_MTU3_NORMAL;
> > +		priv->ch[1]->function =3D RZ_MTU3_NORMAL;
> > +		rz_mtu3_shared_reg_write(priv->ch[0], RZ_MTU3_TMDR3, 0);
> > +		rz_mtu3_disable(priv->ch[1]);
> > +		rz_mtu3_disable(priv->ch[0]);
> > +	} else {
> > +		priv->ch[id]->function =3D RZ_MTU3_NORMAL;
> > +		rz_mtu3_disable(priv->ch[id]);
> > +	}
>=20
> You probably need a lock in this function to prevent races.

OK.

>=20
> > +}
> > +
> > +static int rz_mtu3_count_enable_read(struct counter_device
> *counter,
> > +				     struct counter_count *count, u8 *enable) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +
> > +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> > +		*enable =3D rz_mtu3_is_enabled(priv->ch[0]) &&
> > +			rz_mtu3_is_enabled(priv->ch[1]);
>=20
> There's a race between checking for channel 0 and channel 1, so use a
> lock to prevent that.

OK. Agreed.
>=20
> > +	else
> > +		*enable =3D rz_mtu3_is_enabled(priv->ch[count->id]);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rz_mtu3_count_enable_write(struct counter_device
> *counter,
> > +				      struct counter_count *count, u8 enable) {
> > +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> > +	struct rz_mtu3_channel *ch =3D priv->ch[count->id & 0x1];
>=20
> Same comment about the AND operation as mentioned before.

OK.
>=20
> > +	int ret =3D 0;
> > +
> > +	if (enable) {
> > +		pm_runtime_get_sync(ch->dev);
> > +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
>=20
> Are you using the Count's "enable" extension to switch between 16-bit
> and 32-bit phase modes?

No. But will use that for switching on the next version.


>=20
> > +	} else {
> > +		rz_mtu3_terminate_counter(counter, count->id);
> > +		pm_runtime_put(ch->dev);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static struct counter_comp rz_mtu3_count_ext[] =3D {
> > +	COUNTER_COMP_DIRECTION(rz_mtu3_count_direction_read),
> > +	COUNTER_COMP_ENABLE(rz_mtu3_count_enable_read,
> > +			    rz_mtu3_count_enable_write),
> > +	COUNTER_COMP_CEILING(rz_mtu3_count_ceiling_read,
> > +			     rz_mtu3_count_ceiling_write), };
> > +
> > +static const enum counter_synapse_action rz_mtu3_synapse_actions[]
> =3D {
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +};
> > +
> > +static int rz_mtu3_action_read(struct counter_device *counter,
> > +			       struct counter_count *count,
> > +			       struct counter_synapse *synapse,
> > +			       enum counter_synapse_action *action) {
> > +	const size_t signal_a_id =3D count->synapses[0].signal->id;
> > +	const size_t signal_b_id =3D count->synapses[1].signal->id;
>=20
> If this is "Channel 2" Count then you will have four Synapses for four
> possible Signals (MTCLKA, MTCLKB, MTCLKC, MTCLKD), so you'll need to
> account for those two other Signals as well.

OK.

>=20
> > +	enum counter_function function;
> > +	int err;
> > +
> > +	err =3D rz_mtu3_count_function_read(counter, count, &function);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Default action mode */
> > +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> > +
> > +	switch (function) {
> > +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> > +		/*
> > +		 * Rising edges on signal A updates the respective count.
> > +		 * The input level of signal B determines direction.
> > +		 */
> > +		if (synapse->signal->id =3D=3D signal_a_id)
> > +			*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> > +		break;
> > +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> > +		/*
> > +		 * Any state transition on quadrature pair signal B updates
> > +		 * the respective count.
> > +		 */
> > +		if (synapse->signal->id =3D=3D signal_b_id)
> > +			*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > +		break;
> > +	case COUNTER_FUNCTION_QUADRATURE_X4:
> > +		/* counts up/down on both edges of A and B signal*/
> > +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct counter_ops rz_mtu3_cnt_ops =3D {
> > +	.count_read =3D rz_mtu3_count_read,
> > +	.count_write =3D rz_mtu3_count_write,
> > +	.function_read =3D rz_mtu3_count_function_read,
> > +	.function_write =3D rz_mtu3_count_function_write,
> > +	.action_read =3D rz_mtu3_action_read,
> > +};
> > +
> > +#define RZ_MTU3_PHASE_SIGNAL(_id, _name) {		\
> > +	.id =3D (_id),				\
> > +	.name =3D (_name),			\
> > +}
> > +
> > +static struct counter_signal rz_mtu3_signals[] =3D {
> > +	RZ_MTU3_PHASE_SIGNAL(0, "MTU1 MTCLKA"),
> > +	RZ_MTU3_PHASE_SIGNAL(1, "MTU1 MTCLKB"),
> > +	RZ_MTU3_PHASE_SIGNAL(2, "MTU2 MTCLKC"),
> > +	RZ_MTU3_PHASE_SIGNAL(3, "MTU2 MTCLKD"), };
>=20
> These names can be in a human-readable form (e.g. "Multi-function
> Timer Clock A") if you think it's easier to understand, but I'll leave
> it up to you if you want to change it.

HW manual says MTCLK{A,B,C,D}. that is the reason.

>=20
> > +
> > +#define RZ_MTU3_COUNT_SYNAPSES(_id) {					\
> > +	{								\
> > +		.actions_list =3D rz_mtu3_synapse_actions,		\
> > +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),	\
> > +		.signal =3D rz_mtu3_signals + 2 * (_id)			\
> > +	},								\
> > +	{								\
> > +		.actions_list =3D rz_mtu3_synapse_actions,		\
> > +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),	\
> > +		.signal =3D rz_mtu3_signals + 2 * (_id) + 1		\
> > +	}								\
> > +}
> > +
> > +static struct counter_synapse rz_mtu3_count_synapses[][2] =3D {
> > +	RZ_MTU3_COUNT_SYNAPSES(0), RZ_MTU3_COUNT_SYNAPSES(1) };
>=20
> I know the 104-quad-8 module also creates a multidimensional array to
> represent the synapses, but I would advise against this pattern
> because it obscures the intention of the code.
>=20
> Instead, create a separate distinct array for each group of Synapses;
> I suppose there will be two arrays in this case judging from your
> existing code.

OK. Will do.

>=20
> > +
> > +static struct counter_count rz_mtu3_counts[] =3D {
> > +	{
> > +		.id =3D 0,
> > +		.name =3D "Channel 1 Count(16-bit)",
> > +		.functions_list =3D rz_mtu3_count_functions,
> > +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> > +		.synapses =3D rz_mtu3_count_synapses[0],
> > +		.num_synapses =3D 2,
>=20
> As mentioned in the comment above, refer to the distinct Synapse array
> for the particular Count and then use ARRAY_SIZE for that array to set
> num_synapses.

OK will do.
>=20
> > +		.ext =3D rz_mtu3_count_ext,
> > +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> > +	},
> > +	{
> > +		.id =3D 1,
> > +		.name =3D "Channel 2 Count(16-bit)",
> > +		.functions_list =3D rz_mtu3_count_functions,
> > +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> > +		.synapses =3D rz_mtu3_count_synapses[0],
> > +		.num_synapses =3D 4,
> > +		.ext =3D rz_mtu3_count_ext,
> > +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> > +	},
> > +	{
> > +		.id =3D 2,
>=20
> Set id =3D RZ_MTU3_32_BIT_CH to make it more obvious here.
>=20
> > +		.name =3D "Channel3 Count(32-bit)",
>=20
> We probably don't need the "(32-bit)" in the name when it's obvious
> already from the channel id and ceiling value.

OK will remove it.
>=20
> I wonder how this counter is described in the RZ/G2L user
> documentation; is it named "Channel 3" or "Channel 1 and 2"?

It is mentioned as MTU1 and MTU2 channels.

These channels can be used for phase counting and PWM operations.

>=20
> > +		.functions_list =3D rz_mtu3_count_functions,
> > +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> > +		.synapses =3D rz_mtu3_count_synapses[0],
> > +		.num_synapses =3D 4,
> > +		.ext =3D rz_mtu3_count_ext,
> > +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> > +	}
> > +};
> > +
> > +static int __maybe_unused rz_mtu3_cnt_pm_runtime_suspend(struct
> > +device *dev) {
> > +	struct rz_mtu3_cnt *const priv =3D dev_get_drvdata(dev);
> > +
> > +	clk_disable_unprepare(priv->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused rz_mtu3_cnt_pm_runtime_resume(struct
> device
> > +*dev) {
> > +	struct rz_mtu3_cnt *const priv =3D dev_get_drvdata(dev);
> > +
> > +	clk_prepare_enable(priv->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops rz_mtu3_cnt_pm_ops =3D {
> > +	SET_RUNTIME_PM_OPS(rz_mtu3_cnt_pm_runtime_suspend,
> > +rz_mtu3_cnt_pm_runtime_resume, NULL) };
> > +
> > +static void rz_mtu3_cnt_pm_disable(void *data) {
> > +	struct device *dev =3D data;
> > +
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_suspended(dev);
> > +}
> > +
> > +static int rz_mtu3_cnt_probe(struct platform_device *pdev) {
> > +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct device *dev =3D &pdev->dev;
> > +	struct counter_device *counter;
> > +	struct rz_mtu3_cnt *priv;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> > +	if (!counter)
> > +		return -ENOMEM;
> > +
> > +	priv =3D counter_priv(counter);
> > +	priv->clk =3D ddata->clk;
> > +
> > +	for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
> > +		priv->ch[i] =3D &ddata->channels[RZ_MTU1 + i];
> > +		priv->ch[i]->dev =3D dev;
> > +		if (priv->ch[i]->function !=3D RZ_MTU3_NORMAL)
> > +			return dev_err_probe(dev, -EINVAL,
> > +					     "channel '%u' is already claimed\n",
> i);
> > +	}
> > +
> > +	mutex_init(&priv->lock);
> > +	clk_prepare_enable(priv->clk);
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       rz_mtu3_cnt_pm_disable,
> > +				       dev);
> > +	if (ret < 0)
> > +		goto disable_clock;
> > +
> > +	counter->name =3D dev_name(dev);
> > +	counter->parent =3D dev;
> > +	counter->ops =3D &rz_mtu3_cnt_ops;
> > +	counter->counts =3D rz_mtu3_counts;
> > +	counter->num_counts =3D ARRAY_SIZE(rz_mtu3_counts);
> > +	counter->signals =3D rz_mtu3_signals;
> > +	counter->num_signals =3D ARRAY_SIZE(rz_mtu3_signals);
> > +	platform_set_drvdata(pdev, priv);
>=20
> It looks like you only ever use clk in your callbacks; how about
> setting your drvdata to clk instead and removing it from your
> rz_mtu3_cnt structure?

OK. Will do.=20

Note:
This change is based on feedback[1] on bindings.

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022100613=
5717.1748560-2-biju.das.jz@bp.renesas.com/

Cheers,
Biju

>=20
> > +
> > +	/* Register Counter device */
> > +	ret =3D devm_counter_add(dev, counter);
> > +	if (ret < 0) {
> > +		dev_err_probe(dev, ret, "Failed to add counter\n");
> > +		goto disable_clock;
> > +	}
> > +
> > +	return 0;
> > +
> > +disable_clock:
> > +	clk_disable_unprepare(priv->clk);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id rz_mtu3_cnt_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rz-mtu3-counter", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rz_mtu3_cnt_of_match);
> > +
> > +static struct platform_driver rz_mtu3_cnt_driver =3D {
> > +	.probe =3D rz_mtu3_cnt_probe,
> > +	.driver =3D {
> > +		.name =3D "rz-mtu3-counter",
> > +		.pm =3D &rz_mtu3_cnt_pm_ops,
> > +		.of_match_table =3D rz_mtu3_cnt_of_match,
> > +	},
> > +};
> > +module_platform_driver(rz_mtu3_cnt_driver);
> > +
> > +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> > +MODULE_ALIAS("platform:rz-mtu3-counter");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a counter driver");
> > +MODULE_LICENSE("GPL"); MODULE_IMPORT_NS(COUNTER);
> > --
> > 2.25.1
> >
