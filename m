Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2140C648D84
	for <lists+linux-iio@lfdr.de>; Sat, 10 Dec 2022 08:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLJHwX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Dec 2022 02:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJHwW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2022 02:52:22 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C7B27CF7;
        Fri,  9 Dec 2022 23:52:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOfH/i0gX/W2o2zDF3gofnNjnZrP6fnGZRmVsmy2o/nPPZ6WHbPcwTxF/es9tno+/iTPgJCm80njeLPRgLiaURzJohk6m2SkHYjmpH73lImsZdzRJiqdDBMkM++f4oiiXT/J0DVYq6hprkZiOj/istIXI/qYtB6mRnjJFDfycSn8w/Z/x7o90FND2T5xFuOlSiVGT06MwQmwyIf4jbT94AR+8TwMaDJTOfR7mFg2esEngE3y3RMXTn7Gl4Kqja18yJ2gFLU9+PG1Q1O9vmEEQ8g2IW30JH6wrBEMoFqOyDvbj9EwgEduBDaBtcudyavX6p6I//yB8CF8xpEJ0+ntMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH2dBMi1F35D38J2NvQl2waSD2TbG3nF/4Tf+P0rYUU=;
 b=kSDTC6+2Zjup1XPQ6rcHEF/HuTtGe9Mv3HPLEqqXw2sZ0By++K7mt/PrBsYQD0fSwylHZI98P78Zsgc0Q3QoGNov3BMt0WeWbppELWuuonwJ8ZLMR9U/HD8KXfdJJmEMIejt7Um7Cfr6iI4yBMeE5Ic61ufFYbiIGIiF2E17+2etts+QpyHiWUzXVMuJKHjQ2QCRXRtPDDkKEGjVKDszOzNeq2IFOphVxT39iWAxsvH+sSouGWfJK8pgdp0UubMCLhZAHoa/lCCTfceiSgoWnivHBd6ujNcxlRISizwWqYFxMA4ttuFeVUwlW7lw1CDf6VGhKx0I4UZfpGe0I+U0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH2dBMi1F35D38J2NvQl2waSD2TbG3nF/4Tf+P0rYUU=;
 b=KXlKfAT0NJepkMyBB9kkBSMIElZp/rDmua76s1TCLy/Cd+n7zbOq4hAuBKKaBljRHoRK49S1btzRfx6uvDHtk/p7mPYJzBoE7t7uEIFMbPF9kAAGJLLg80LIZxL56dmE7rwktywzxHQahKgTIrzBp3Z+V5be+PAd31Lfu8k3wbQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6220.jpnprd01.prod.outlook.com (2603:1096:400:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 07:52:17 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 07:52:16 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
Thread-Index: AQHZCLpBadXv7d6jXkypwu+29R+sIq5f5owAgACX9uCAAAzJgIAABM+AgAFyA3CAAEDVgIAAAqWAgABgm4CAA4I7gIAAmdfw
Date:   Sat, 10 Dec 2022 07:52:16 +0000
Message-ID: <OS0PR01MB5922293733EFD0D4F3E6B270861F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
 <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <878rjjfprw.ffs@tglx>
 <OS0PR01MB5922B590AB9791B9741E2A1D861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87sfhrdure.ffs@tglx> <Y5O1g8/69tCfmdW6@fedora>
In-Reply-To: <Y5O1g8/69tCfmdW6@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6220:EE_
x-ms-office365-filtering-correlation-id: aabd00c4-dda5-435d-8935-08dada837519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cVZE4RGA08mYP+0+fRINI6jdqqOOJN9zU139x33iP0cFsuCB5/tmlJyEgu4xaB4q0l4zmHOYRmniLym67Y5C9LuKjP9jx54oK97Ovah9VHGWcqPOj4DGET0ULChXKtX/HvjLtZxEzHIJO/N/dZTOkHpnqaPg6vOTAMGFwA2ooeGmhXLOJGQRie5J2oLJ6Px7jOMVQeA8cwR0Ayrt4Q9Fid6uI4uCPfNffKLdpAHxqmvv1ZJvpTPPrRUL2pnt9ZEkl+aBhp8LP2P2/uEMV2MVSMZs2DmaTzXNpGriG9z5JpS+o6LQHMqKI1+5dY4mwNngYX+caakqLiWZlLYfHZ06dP4g1I7Rll7Bcg7oZRMJNJOLQ4PU9PGnjxYPib+VsEXfgAbQQc1VtXv0NNQ12sy6vJJfGwlsskrgvqHbWHLgjo0vNmaCdpYTPZGXKEc9Znt+ACJHuc+sYvfBOaBG0Zkpd1dfvBWcdWsdiBiLUWAlV3h3l7IIyW263pFkNgslnEkfcuCqdTT4H9XsTRzpfpiBzESIseSfD7BsIvN0keclF5odGC32tEdieeg/RZx6nbXiAHNDLcT7jgsDnzd04iHaN3Ft7BHe8Prch6FvStTigHV7Xjv+y9mL2NruGgfXej7sJ0AVyVWa6BoWl8Ko5WnmnpGDeRh08dD96z9eYp4a5EsZvOP+0tnLyUqzd725zPtkpjSuIjbuU5v3gtsKcBE9Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(71200400001)(478600001)(41300700001)(38100700002)(122000001)(86362001)(26005)(7696005)(6506007)(9686003)(107886003)(5660300002)(2906002)(66946007)(186003)(8676002)(64756008)(33656002)(76116006)(66446008)(66556008)(7416002)(66476007)(55016003)(316002)(38070700005)(6916009)(4326008)(54906003)(83380400001)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M5DE3JHzzMg1hTUFnpvUYgcNOAJINvnyql0pW4y/9sPYOcBGJDKHjSOwAI3e?=
 =?us-ascii?Q?R54DceBPR9t4/3KK2S+1Da75qWWV2oJTG2F7QYtFb8xaJQdSGXhmsFfH3TfY?=
 =?us-ascii?Q?ehpYmjiFsu485rE/4jmeiaqGeVMhoNg2enVd2zdde5iHauCrG3P9RrkhUHXQ?=
 =?us-ascii?Q?R5wjvdcmuasVoB2jEQMW2/0CgpuIw6rrcAWhWGhKgOld6lpzQTw1iQAtJ9W0?=
 =?us-ascii?Q?EsvB3yr6mTrU6fPf1n17gyS5SjVuOr1dOLumfbv2N4ipxVQSRbSk6Ochlz3S?=
 =?us-ascii?Q?bOEnzt/Bv3ziYjvWsj0Ithh80prz2tXy3p8dLVMBRdlSx4ADmBuRisvyXbso?=
 =?us-ascii?Q?k3tJ44t/D0gwVuWrgj0LMlC9pxGn75o/I+OPrAgq/lu4Gftpx1z0kwRRRfWj?=
 =?us-ascii?Q?CW3oelZ7U2YIqyFC180fao7Gw/j/bCsZBFHsEXyJLA9JLhN58P+2knTBlp8H?=
 =?us-ascii?Q?vnKUlJEyN/NNb/Rh8VnK5RH7zV25UoNcO+1IFIG/q3wMxe78zDOW5DYFJ6oY?=
 =?us-ascii?Q?06OdMgJAHiv/vg20QXuHQdCR93dDcbyKEe1s46VHIXKdUjsdv6acUGk8nNmJ?=
 =?us-ascii?Q?tLTiMzIT7lDZ+X3K4jiHygQfbCl7FUzv8v0pO2DJV2fnzMO9zjounqabu/Ae?=
 =?us-ascii?Q?+l42wo59uiQb/mMvR0001JhkLRtoFKbkMGG6vHM/1NC/gcoGRyXTcOvf4dUk?=
 =?us-ascii?Q?Z2cFA8EiMNcoacuQWBZwMJ45CfXfa9ajENKIwtpV+4CDrqpwoZP+VYqbzMuK?=
 =?us-ascii?Q?dbCuUwAVLY9Pp3pLTjoiOD6pu/zBmAMtPosmRrenov5d4+uEuNF3OIJEvGtf?=
 =?us-ascii?Q?52wZT2wE7Eyb99R4fVGNJxHOjX85k88KrlnwhaUNc8ecuvYJ9Dy3X/sq0a0N?=
 =?us-ascii?Q?cbt38V1BO9w9IIfv92i5W9TZg7e7eGvXUPsJmW6K0CS9Ii2Eg7vAJPT6Z0D8?=
 =?us-ascii?Q?J5staWNBMqntI+3CsFIwHZJxkn5hAcK+SAuAoqh+wiZ65+1JqCk0Hoh16s0k?=
 =?us-ascii?Q?T+2W0ubINtimA6RerDzdO99C6mA6jnDxfsw+lY0K4tbKVJRQIiGayBzf+9ak?=
 =?us-ascii?Q?vEl7LgPodib5BnUJCBrYYKIVORY1vVzW7PtpOge70tHip16eGdqUua4Xmo0d?=
 =?us-ascii?Q?7rJle/kTXccjZoKQe+YkZjlHp03X74NzWAWtw2hmSqN5xE8hy3u5z//2R9hM?=
 =?us-ascii?Q?DZG2kUcUSV6KhBV0fcwjU9u4qu2d9c28iauZsOI2gNnSQxG3G4MVbNoFX+3p?=
 =?us-ascii?Q?Sx8SAFLnXoG7C7o2BIlEnHB6uXQFj3bljcwz0Jd0dmj/eylIVWRgMMi69YvL?=
 =?us-ascii?Q?7KB8ZD7JsCDQFFbxwjEH5fewAg3Kw2kZL6uTX77tKsSwWHmHOfVmz9aCprtM?=
 =?us-ascii?Q?+2Pha9Lgzqw2j1+1BsXSRrdQ/T1ltS+mi1M9bSrH9RSGOnErokaU2CghAKrM?=
 =?us-ascii?Q?AgYVIpplCEnGHqvhSIC5GvyKf/fYyjEsk2tII95gcL9TCOFOMBIr6YzxcLcw?=
 =?us-ascii?Q?YHRZge9ebnVvwDpPuBBtllNVLRyxeJ/6UzTLXM8cyelkQVuoWY5N39/uvpRX?=
 =?us-ascii?Q?VMhIVLwZ9bItWQUaJ6RwAY0UoVIfFQJxwBmGBF7Ox6ITRJDWBdoxQfAfjYZt?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd00c4-dda5-435d-8935-08dada837519
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 07:52:16.6056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idtHu1nv3fONW8RBkSbAWuYE2Jxm+oqyxAeon3szqtE06Y5XOdnTsxSsyCqUU4QoxD5dzAbX55dp5uVcKs6QFWBsJdt1pjy1RhPXq+fhJ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220
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

> Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
>=20
> On Wed, Dec 07, 2022 at 05:49:09PM +0100, Thomas Gleixner wrote:
> > On Wed, Dec 07 2022 at 11:35, Biju Das wrote:
> > > Counter, It can be used as measuring the processing time of DRP-AI.
> >
> > Sigh. You can do that with the architected timer too, especially when
> > you are going to do the measurement in user space.
> >
> > clock_gettime(), which uses the VDSO with the architected timer is
> > fast to access and accurate.
> >
> > Thanks,
> >
> >         tglx
>=20
> Hi Biju,
>=20
> It's true that you could implement a Counter driver to achieve what you
> want here, but I don't think that's the most apt interface for this
> device. Your device is used to measure the processing time of DRP-AI, so
> modeling this as a clocksource seems like the right approach to take.
>=20
> Of course, if there is something missing from clocksource/clockevent that
> you need, then it should be added to the subsystem. So let's try to narro=
w
> down exactly what functionality you need.
>=20
> You gave a Counter use-case example earlier where you can configure the
> ceiling value of the timer (e.g. to 1usec or 10000000usec) and push
> Counter events on the interrupts that trigger off that that configuration=
;
> the Counter subsystem can logs the current system time everytime a Counte=
r
> event is pushed.
>=20
> Could the same thing be achieved using clockevents framework instead?

If I am correct, from this thread discussion, we can make use of architectu=
re timer
with hrtimer, which will give call back events to user space after time exp=
ires.=20
In the callback, we could call clock_gettime(), which uses the VDSO which i=
s fast
and accurate.

So there is no need to use any extra HW timer.

scheduling tick is 4millisec. so if we want callback at 1 microsec, then we=
 need to=20
use clock_nanosleep. Getting 1 microsec callback to user space is challengi=
ng as
the scheduling tick is only 4 millisec.

Cheers,
Biju

> With this approach you would register an event to fire in the future (e.g=
.
> 1usec or 10000000usec) and then call clock_gettime() to get the current
> system when you're notified of the event. Would this approach work for
> your use-case, or is something else missing here?
