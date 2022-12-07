Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37B364591C
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 12:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLGLf3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 06:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGLf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 06:35:28 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2D49B45;
        Wed,  7 Dec 2022 03:35:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYgWjEE9Gtf1ws30PXgMmOwExcaDxZVekBz8FueUewhaddmgnh59zarGytMpmZZUx8B/wP8Da4PGsnDNOeUuOtWMVR46PzwwrccxPV7VU/EXnRvRUX2ibs+OPQ3z+tUQoRFeU2Y6n33ShfmOa4R9oE8Z+vOX266ekPVdYzaPrn3rAmj/RFfsF2gY7kJBfrLzbu/gOhSJRwnQXIyWBZ8tO55HVyifSSco3ruiN3sl6le9UZExS1p7hYbAMP1Zi5zSe+AEb/Czo7mI2JcToTAPwnEuQOgv0VM/5KmGAphQIuON3jQWsqhq9KBC5drBJIcIRVovSrnT31uFJwPVhFLYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3xim9rjqeiPkVPvi5zPZaezXF7hMix+qagWDqwO1BA=;
 b=jNARsTUfbbzORCVC7LbNnu4JYPC/2RDTLMvOLlXwCTYJgqJfqi1fMsg5CAHmQ0hx0Ctfk1Rs4JHelsaf0YM1HTEPG+ViIsNjXZag6rO/lnPpK0+Xp7iA9iHdc9Wi5n9shOMsfb/h4I8HSsN4IiBpveOtawYijSN5CGtl383PrFEdNa6CCdO3aMb0aizaEEWou75wenYTLeFwgJG1oWSAurzFDN7psUXx2mSrOkbme+PJju1QAp3LrFRG1vjlRw3MRBpoebumIVMcHTcyEb8VmMey3nAamaYr6b+aTN5u9OPFilJ+WdaWhdlNYmPtnx11uihjDZJBIsY8EExI7I5scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3xim9rjqeiPkVPvi5zPZaezXF7hMix+qagWDqwO1BA=;
 b=r0Crmn6UkYlADeFl1M9vIJlXzW8Uuci1fgv+I9rmdKO5X8nU44teU+j0mvG6GhIwdA+XFjqEwyc5KOuFCbV5wKCoNbVsL6hfAFaaDgSopowI9Ss0QtThcAK4T+XwPiotgCe9RVCZKgAXTi2ddB7S+kZnZoDO2WmfDtNHaMzBfIw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7846.jpnprd01.prod.outlook.com (2603:1096:400:183::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 11:35:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:35:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Thread-Topic: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Thread-Index: AQHZCLpBadXv7d6jXkypwu+29R+sIq5f5owAgACX9uCAAAzJgIAABM+AgAFyA3CAAEDVgIAAAqWA
Date:   Wed, 7 Dec 2022 11:35:24 +0000
Message-ID: <OS0PR01MB5922B590AB9791B9741E2A1D861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
 <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <878rjjfprw.ffs@tglx>
In-Reply-To: <878rjjfprw.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7846:EE_
x-ms-office365-filtering-correlation-id: 1063924c-6de7-4660-55f3-08dad847219d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pz1Em1kTH4db9mHwwfewbhC1GiGvrNtjZ17Qhk//vt2tcoz7cmPNeWirbx6SGjr6E3TJKe8PlY+NM1ACjyFnkPky/LoCnS5Ygk3Y+Q6gfNyTlAgxUXrjGTEVVBPyZ0W2dVKvUWzsVc5faD+euntzdpa6TUeOXwxF9m3vaxTuEByTVIVIFTMsF4uB/mDmUUDztwtIwtGJZqJmxdju0uBA/EQSyoAGDWFsRIx4iu72Dgcs9MlpptQwpnDyLOuMDlqhI63HAmsvrdYnT6fg1ULjZW0qjxwBfZnE93ubp3mkmc3cXcsQcaBAGHa6Lbvav+Ng9jojVDwO96oQ7032pZ87GnF2d4a/SHdx1hvN5WQeV5OfMmPCkHJIBrR8Glw9XMv3Oyz3/3tv4UcG7Xg1SzK3LOfr7RafSIMWYo3Vr906noSfTqebKAqbtMZQOyYOjr4x9N8KdVVBuuJpyE//u8Vx3MBlo+oh/mf77b1DeQOy/LyucxAO0yiMUNfL54OdJjfKHjI23qFhPZxuy1PW2FUjQCnx9dxm74rDNYOweM1myvO6M57c7iQQur9e5dbO+E8H5FuzArpy6SQp4HPM5k2S3rF//fr1wWz7CU7JMr483PRv3tJXdiB9fQRLhrrC90ssUYfw26rvB2qVjVRKTqB66eZ4xOp2x7UogdP1s1zBipQDvZRS5DBxw/OHYwoMI9fJPGMr622iHLYwsjrhIvbhJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(2906002)(33656002)(76116006)(41300700001)(86362001)(122000001)(38100700002)(26005)(186003)(110136005)(9686003)(38070700005)(7416002)(71200400001)(83380400001)(55016003)(54906003)(66476007)(8936002)(66446008)(107886003)(52536014)(66556008)(5660300002)(8676002)(4326008)(64756008)(478600001)(7696005)(316002)(6506007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3uveqm/Kj1UEL9wpJQjLs1+DroONL3/T/ON6N2iR6JGRi5mdKi+77cYvPId?=
 =?us-ascii?Q?xLmY/RKdsA8/k5c4yWLBKp01Z2vZ/H5G/FLerA5X6Uj7++Cdem3xShBiq5Pk?=
 =?us-ascii?Q?SU3dyz/6SHkMtl9ogiu20yUSvdKnBvD4gPVLLYVyycazRMIDedj+mVfqtVrG?=
 =?us-ascii?Q?8SZhcGOAv96TDf4zht51WdHpAfnqp9uX2u8AqKnDtiJ7bo6GdeKmunPbQ/Lz?=
 =?us-ascii?Q?1IVZzuLY0Drcuxn/rQ6dnZVav5Y6sL6luoCrGVNCMybLknmhy7SozIsm7/mx?=
 =?us-ascii?Q?VErOV2X/e0oRX8Vvk7i+tPckHYHL/E4PBbI5GpYTs96x94i6T3qGjJj9qEba?=
 =?us-ascii?Q?jmZQ++LLJQTr3aPnNM/Cbv6iK1q4XujgO3ssPZ41DVBJntxQb1qi8ghqWg2s?=
 =?us-ascii?Q?KFVAAZkq8JQ54exqyuXo1fCczGj/0tsdxmbR7x4sDCLqaRzuPCMzRij+9M9B?=
 =?us-ascii?Q?qzAgUxiRPR+m4wNzdHerBF86MWVLu0rHUz3FC8uyYn/JEJkPT8dUrFlCkXmb?=
 =?us-ascii?Q?teIkRxr6x0MSIvDG3mVWsMBSdXIu51pRfFVLZEroGkpf3Lr64mqAU9ZlsGXH?=
 =?us-ascii?Q?OjnZLtF4YLofr1WkZU/9u/wIZLSbHsmeAecQz4YjzyC8R/jMGCmFH17OR9Tn?=
 =?us-ascii?Q?CtzsNEwugOcfJqchLu+GnMhIwNj/ffFpXS5Ic8A8z278E1mw8pS1Nxr2RjiP?=
 =?us-ascii?Q?njJ1jDQ566kjmi/UZdukWzXxRd4ymWBw25BXqXQxK+Xe6FOPFP41ycWguKfR?=
 =?us-ascii?Q?f92s1jNQIMwFGVzJE+dgT7yDzcrePzGuwpUCU3RIS0+XBh9EgRJPqsOxTrv5?=
 =?us-ascii?Q?APJhVfPy8lYSV8JJGiZHAqUbiUKhSbqLJKKg1lxYr0rU3Ah1JFqRUYcj6pci?=
 =?us-ascii?Q?X9SW0Ik6nmdJaXlX3+jks5kb71oAESmT6woRPfZTlUHHuwqoKGEJXRhnQi9D?=
 =?us-ascii?Q?CKWA6GH2ohY4H10u+o6ejwSCBjxJN0ZF/6UzKJFnMp0sc3KO9cNRROCA4EAC?=
 =?us-ascii?Q?xNlm/S654F6s4MxDPH25wA3zJugK5dAvLHmrALP9gb02bFgBxAK6oY0h6QTm?=
 =?us-ascii?Q?8ZwD+WzUxr+ViOpQ+cEnbb2VewPHRq9KYnGhU9VRJbQlHo0OMipg4p1e8TK/?=
 =?us-ascii?Q?71qmjG2TblM0D/usv+BCHXfK2pG9ytlQNjm8iTzBIS/wg5Zl7twEbxHu5nEE?=
 =?us-ascii?Q?y0rf1yfpjfvDfQY4PQzDuQwoDyFF+9vIG5eBZgmE+9zJzHLYXtzlBzT7BWRT?=
 =?us-ascii?Q?U+2nJU9RnBoNRbTzryhm5FRBClG/Un/p3r43Uwje0HqLuxdeID1kPc+vCtob?=
 =?us-ascii?Q?worA6GW1edd+pt/Oa6HAU42ZeaHgFV+l/5/e3ZkpmJikQSXYw7dJyK8HXnZF?=
 =?us-ascii?Q?jINHXZkQt+ZoNHMge1NMnMJZeHQ1iFLnADlvpFG6+IYUnfqtLCOrWqisDULg?=
 =?us-ascii?Q?tIq2P2/Y26wZXUIGflJuw7egbq05rdYbH2/mQI9tsKp8q452Fiie4iFs2LhC?=
 =?us-ascii?Q?F+Q9tHqEaiCjpetyT9d3e3AnWybRH62W3hR/5VrG6nLhI54Ur32PsWoU6y8X?=
 =?us-ascii?Q?V+PfUsBV2ntSPXmuN3lJGXZxr05zx1XMNJ8jJ1cEhLfcNzn6TWn5K5d8qeo0?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1063924c-6de7-4660-55f3-08dad847219d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 11:35:24.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z891yXg5Q+AGZqi4VzXRaDXLAtgXQ6HXu1QGq5hTR8wUD37t4oH3VrowUyuJnwnEHdK6SQxcmFMpTnl9QyGNpOXV3DGMoa80/h6KIZ4WY4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7846
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Thomas Gleixner,

Thanks for the feedback.

> Subject: RE: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
>=20
> Biju!
>=20
> On Wed, Dec 07 2022 at 07:52, Biju Das wrote:
> >> On Tue, Dec 06 2022 at 09:40, Geert Uytterhoeven wrote:
> >> > When multiple clocksources are registered, the clocksource
> >> > subsystems picks the best one anyway, right?
> >>
> >> As it does for the clock event devices. If there is an architected
> >> timer then that should be always preferred.
> >>
> >> No idea why there is a need for the extra hardware and the drivers
> >> which are both never utilized.
> >
> > I got feedback from BSP team for the actual usage of this timer.
> >
> > Basically, this HW timer is used for measuring the processing time of
> > DRP-AI accurately compared to the CPU timer normally we use.
>=20
> How is a slow to access timer with a lower clock frequency more accurate?

But our tick frequency for arm64 defconfig is CONFIG_HZ_250=3Dy. So we get =
timer interrupt
at every 4 msec.=20

How do we get timer event interrupt, eg: for 1 microsec?

>=20
> > The example use cases,
> > Timer in FREERUN mode, Check the timer value after the restart(1usec)"
> > Timer in FREERUN mode, Check the timer value after the
> restart(10000000usec)"
> >
> > What is the model to be used for this kind of HW usage? Counter or
> Timer?
> >
> > I can think of one possible HW usage by using Counter model.
> > Not sure how timer model can be used for this kind of HW usage??
> >
> > Eg: we can set ceiling values 1usec and 10000000usec using counter
> framework
> >   And that will trigger interrupt events corresponding to the ceiling
> values
> >   to user space and user space app can accurately measure the DRP-AI
> processing time.
> >
> > Also counter model exposes count values to user space from the counter
> HW.
>=20
> Counter subsystem !=3D clocksource/event subsystem.
>=20
> We are debating a clocksource/clockevent driver and not a counter driver,
> right?

Yes, Rob pointed out we should not misuse the compatibles as I have both
Timer and counter bindings for a given HW timer.

Timer, It can be used as broadcast and highres timer for RT.

Counter, It can be used as measuring the processing time of DRP-AI.

What is the best way to use this hardware to take care of all this use case=
s?=20

So far all the Renesas timers used timer model. But for RZ/V2M the HW usage=
 is different.
The customer BSP mainly uses this timer for measuring the processing time o=
f DRP-AI,=20
so the expectation is we should at least have support for this use case.

Cheers,
Biju

