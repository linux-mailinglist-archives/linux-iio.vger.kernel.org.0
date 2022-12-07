Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3256454E8
	for <lists+linux-iio@lfdr.de>; Wed,  7 Dec 2022 08:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLGHxB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Dec 2022 02:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLGHxA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2022 02:53:00 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A1EB4AE;
        Tue,  6 Dec 2022 23:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLxcglPtceteHgJSfQRhrW1em0v9t16O1NuP6NhNL8BVxPVP2d2lzTmkFKDx790f20pLjbBhA/X+AeKQaaqF7vsT81ctZ8QWDKTHyDWzXIePA1DNsc72a6nBTT2SXvNW4yzTvvkoyConOAzmocjpIZrqtLTyJvWBpf79sXfq9Omg/aTn9chuuLj9ghqGl64FWwzMG1Reh9zX8BDa0D7Hm3KKmsdhliNiSQfyD3Al6SeXC6tcoTmjrMED6KAcBybGlRUGBEAmKcp8LYBKsbOVaYWeM+MPLTTRclUFD9+ZF+s4UVC9mvR9WM4thm5FWJyBFGX08otdR1ZZMDGTYUKlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBgj3gHXSkkPJhWvF74DBXGWdVif+r1my8FU/KbXE8w=;
 b=AeXVEO5R/14H+L4sgDU21yAz39HYybcjB8LY6j8gxhrYJ4iS/gsexwgDd3uU88EmrUdy+t3hSbUSrmnH/oA5iJfHjG2v0NbRCsLvWaGOBiiRPW1C0Q3MYkT+l7aLeUqnaU/0BDIvICMOOdS7CmHGcRgE0P8p93W6S+lKMGh1WAfoJNDm9PAhXrerg37dQaeLkD0KpU8POI72Uab1m2anpiKZL9hWHIG1rZ3XOh0ix+o50lfXUaTiu53Xm5lBc9yeMNJT/gOXis/UlAn3LwexDeaB+KmxxXP/mEh2Z9ouYoHjME2B9JWQ+XkRUogyx/vb9d0Gjjwn+zSgQ2JLMRg2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBgj3gHXSkkPJhWvF74DBXGWdVif+r1my8FU/KbXE8w=;
 b=X0A7iLgy+cCJcxsACPqTe4BIxVcV0vJiZGA+IrCSWqfDD3FsBfuEPUZive9pbOapilRkRKWbxRvXhjhHZFw6bc5FVASeTiupxdAq3ggm4GFT+DXrr+++yE0CkldDnmLLbkb9z/dDMAPuCBRkNftvKHACMN2w8dlcj5zk2YEVUhg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6120.jpnprd01.prod.outlook.com (2603:1096:604:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 07:52:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 07:52:57 +0000
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
Thread-Index: AQHZCLpBadXv7d6jXkypwu+29R+sIq5f5owAgACX9uCAAAzJgIAABM+AgAFyA3A=
Date:   Wed, 7 Dec 2022 07:52:57 +0000
Message-ID: <OS0PR01MB59228CED6187C7B19776CE22861A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
 <20221205225042.GA2812115-robh@kernel.org>
 <OS0PR01MB592211AD4D0AE23DA7075DD5861B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdX2=AwerQZS2cqR4exq_QNtt=Fwp5KBcmPr1qmOBNOSAg@mail.gmail.com>
 <87sfhsgb9e.ffs@tglx>
In-Reply-To: <87sfhsgb9e.ffs@tglx>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6120:EE_
x-ms-office365-filtering-correlation-id: 389fbeb9-655e-4a24-5eed-08dad8280e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YydvaZMFHDUv1PQZC9VZ31h3zNhEfMnHoh50N19+I1iyuH1d6f2u3F+Kj7mY2s/z1MoCQM+5RbTjBmK+LpfseL2L29aKoHMAPtAzR5pdnu+dcfo72J43yiirv4wMf87x7WLruo1tVmONJDZy4qDquS2kXAPPOfn64K1tvINxeFC9L5vp8ZvfF2fwRDY522Xf+Y8s39LwE4rtGofBncjadxHJPcF2o4CHz/60ZESseau0VFnPtDDKX5rYIq/NSr+u0Yos9jt9ZsSLonTISU2mdWolPI9zSDjIFAb7aNuZkRTYtyyg+4//nlAYuNN/q7aHgn1ewZG1w882Z3KEqbvUqQK/I15/ERplORi1olISu/9lxA+TssYaaHH3MVOGEKlKNAGi2gak88t4ps+u2Ab6AJ9k1nnVp0r6/SniydC2EVRCvvaL5xKABZsjHZP6NQptXn65vXQe+3T0pn305EFq8oT5ldZ3KZ0MFQZLsYEjJItM9ZYstz+LISGbNl2EopIiui4gjhEpTcOo5I7HiyWgtyk3exB0W9GFsJrd8me+XxYqQIsh/kghvmnaY+ioIDM//ToGUdOfXufVDM2oTiE6q2te/pF+twsTiiL7ENq0Oky7oLp/yVWcksEGw/WZO8m/jYoqryFxcydPB+3xUmjJqAE6kyUwYhwR77edoGj6Sl+3PwFrQywDIO8/YhUFbKijya+ZjzZCFbqfbXlyKIJnBZQRarmPMXK6KUoY+Ba4fdwLijgtrsWQM2OzN9Lc9suo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(86362001)(71200400001)(2906002)(4326008)(55016003)(7416002)(8936002)(33656002)(52536014)(83380400001)(38070700005)(5660300002)(76116006)(66446008)(38100700002)(54906003)(478600001)(186003)(66946007)(316002)(66556008)(122000001)(110136005)(41300700001)(8676002)(66476007)(107886003)(7696005)(64756008)(26005)(9686003)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4ihWhyfCxlVY1dBjiiYvIcsmR/OHbwIiNN3839GuWUNHkNtVoE0Ah498I8bU?=
 =?us-ascii?Q?BaSnoEATwKxddl4WxWsW+VTWUnclOiOkjnyXLTei5APr3e/USwhGofOij1D/?=
 =?us-ascii?Q?3zp5aBPRLAUFrHAR3ohpJDtHE9yw00pWAfQSOjbvh/NO3j7D6yu1fRpWVtOk?=
 =?us-ascii?Q?4bWHn/AAw5QwyHNx+I1/fDFSVL0zROG1bp+cxqvaaQWQm7e4bILZm5Xuaaua?=
 =?us-ascii?Q?URE5YveR3bkhBhFai9oqB8lDr33jr20FEsFkEAXmYs3H2q2BbTOaWnsTOsWi?=
 =?us-ascii?Q?RyCLzUx7I29ae3VfpCm6HYw0szIR2a488VzWbRGONpUzZf1cjTxO50fCHSzc?=
 =?us-ascii?Q?tfYPpGA2RFKFP406HwWuLEuChJXghjmAwOMKs7cWltLc9WutIwoSVVx5fkMu?=
 =?us-ascii?Q?9+RQZcUVkrfali2KanJReweQN1R7KYyVreW+IP9lnLhuEWUJi1ednp5AP+fQ?=
 =?us-ascii?Q?6SRmoV6Bbg7pGKhILeqQ2FHpD85LkiBgnD4I8PvT4znWaFYfGCqKJcnHwuMn?=
 =?us-ascii?Q?EpxD1ZmyAzFOhhma5aBI/275IDI3ukYNUSerLGzg3zwSvAWFw+thwTdt3b/D?=
 =?us-ascii?Q?h+X3mtg2Wx9z+9fZoAu0/G+v8uVRt+b+3AcRKwQ0dgwSg6au1SDT0zSnDTLw?=
 =?us-ascii?Q?O1y6Cx5svRxts/FX8HEO6u08SKmOYJyk/AuXJVmqxMIQ/TOcrHuMISq3GNTi?=
 =?us-ascii?Q?sHloZh6bImm6TFi4QOdUsWmx/xIk8Tj9fsKG8+RbdnLHiKq4VUE50DVl4YwK?=
 =?us-ascii?Q?BowZhRyDxGdk+CfmmZU9aRXPNIw0TUD4OpJ+1CzMmvuCMpckrX1I35ihiBIK?=
 =?us-ascii?Q?oRr6+eJy7OqlYyH7kb/k6AQeYmVt/r0roraSx5BXG2AJp+kSTiL2DEcaOWhI?=
 =?us-ascii?Q?odVJNLf4mOTuH5fRWwjt8oEluGpkFEmQ+3qsbW6YjXkPArE2f4DI44/XFUVU?=
 =?us-ascii?Q?M8vPMv63IA2nAjzaxOFRkLHSrCcwB4ZCxdYDFA15TwfM60CH85ZECWsW6cFx?=
 =?us-ascii?Q?JCAC1y2/emhADwjhdogQx7B+IwiF9R1o2R7pvsWiFfudwlITh4oLX4BVGmxi?=
 =?us-ascii?Q?fYzZvwmbIZ84WxNIE8ZGncEp1lrd1EDsRcCUCVHTc7la8+PrqLRzhhSBUKHS?=
 =?us-ascii?Q?9BQ5nM9kLiyER8wujBWaGcyCXskh0LtsnJ1r/Y2R1VeUpSWu6c2949yMIIQg?=
 =?us-ascii?Q?7xQ951blpJKfmx3JAu6mtavF/eR3TxAMQmcceViwmK4NUxQQpKVvH/LVOEsy?=
 =?us-ascii?Q?C+IaZlAekHpLLARcJm17raZkIIT+GL1LNW5gPWt5HvcQQKYTpZ7YvoTcA0Q/?=
 =?us-ascii?Q?JFqreKS6R67NAGubc6Hr8KLoXm1OD0TQ1oDuS397oeMrf1B3W1DwgRQUE6RP?=
 =?us-ascii?Q?3FYjpXnHag6xmrsuSHuSisiV8JKz8CbEzJr430RbGqZBJo1Lc+zIxl/kFeIt?=
 =?us-ascii?Q?ET7LDHFoxOKYjVHpz495cltpm+oCeiAOdi6PMp3kHrwhEXybZY08GxHX1cFT?=
 =?us-ascii?Q?/99HXDlLsSP9Uv++m3KqPsAwPIBKT/wLL+ySECIPHIV1hT9SkJgHb2peeDmK?=
 =?us-ascii?Q?9B6W9az5rPXw8NsjdRKgJLeKHy2IwaoPYwuppTZc5dawhDYhOpvWcCq59ZDz?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389fbeb9-655e-4a24-5eed-08dad8280e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 07:52:57.1361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwaL0czJREJpyCDsH+jMtm0PtPtVFvtbIxeHS/8h0GHWZ0D4fiuZeQ8wDFzZ12CQ2EuMpV5FL9a1Uehed5gEemJ/C/q2ztFBaGXoEbD3G8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Thomas Gleixner and Geert,

> Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
>=20
> On Tue, Dec 06 2022 at 09:40, Geert Uytterhoeven wrote:
> > On Tue, Dec 6, 2022 at 9:13 AM Biju Das <biju.das.jz@bp.renesas.com>
> wrote:
> >> > Do you have any use case to really switch. Doing so disables the
> >> > vDSO access to the clocksource.
> >>
> >> Not really. Architecture timer should be sufficient for clocksource.
> >
> > When multiple clocksources are registered, the clocksource subsystems
> > picks the best one anyway, right?
>=20
> As it does for the clock event devices. If there is an architected timer
> then that should be always preferred.
>=20
> No idea why there is a need for the extra hardware and the drivers which
> are both never utilized.

I got feedback from BSP team for the actual usage of this timer.

Basically, this HW timer is used for measuring the processing time
of DRP-AI accurately compared to the CPU timer normally we use.

The example use cases,
Timer in FREERUN mode, Check the timer value after the restart(1usec)"
Timer in FREERUN mode, Check the timer value after the restart(10000000usec=
)"

What is the model to be used for this kind of HW usage? Counter or Timer?

I can think of one possible HW usage by using Counter model.
Not sure how timer model can be used for this kind of HW usage??

Eg: we can set ceiling values 1usec and 10000000usec using counter framewor=
k
  And that will trigger interrupt events corresponding to the ceiling value=
s
  to user space and user space app can accurately measure the DRP-AI proces=
sing time.

Also counter model exposes count values to user space from the counter HW.

Cheers,
Biju
