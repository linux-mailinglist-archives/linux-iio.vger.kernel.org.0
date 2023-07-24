Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583D375ED0D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 10:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjGXIEP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 04:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjGXIEO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 04:04:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2125.outbound.protection.outlook.com [40.107.113.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F112E0;
        Mon, 24 Jul 2023 01:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcZ9EDdNl0jFdHtasP/0Oqfgd98toMr2WhvFP7xbsg0LsDot1ne87cSpaVO8pyIFfz7DOw4dc21rQzYLgxtbpdzJz3XjO6SSFffqIv9/wOF4u40tATvAzdNVgdkqtPH4TuYVjIfzhedKC4AqZM0Pd5v5gIb+eZa2sO4e8qmF28SO6DK7xcKGWaKg6tesC04xKEMefpLaK/SuqTy79EQBXWJ9RjNo8a6w/z2fWGIWQNoBosN6Zwqzoq1JyAzWR3GHJyr2viEknOfPqiAf/vOTdut4V6UwSNbOHcczzdV8u9ySMmo+5jSCxDs9ykgay3gUZoPLp5e8GMyaNf5EIYcB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkvj+7Oz7QNsc3wxxJ9mUVJiemCv7Y4Bb0XmmSGGrRw=;
 b=Tul5WVSHbLu98vYIuJSQkS4mP90sozTuYbW2Lb78j6QlzFAOWyvDz+Bn+PDVDCSG0toDXwF3yVzBweyou0BQt+TB7qyLhNqfyA9VRtmG+JRksZ5C06ZEWGpvMd0YUI+Qr65T2Jvlib7lfBC4YCkZyJZvH/AtsJI569OG8z56CyA4/fDzFW11RNO8bWuasxfWAztKlIktRwl46W5+ngxo5t7UYOiaLwoiY7TWiuo6gTiFkkOzQDIUS1/j8dMLBZQZzsC1dFeOc9kTjqLtpC0E7n1XYntTmjc9C90V+tyglHYT3rD4bfGymkrD/XxBR4Cz02UNf6Kjhqj61VbjwVxHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkvj+7Oz7QNsc3wxxJ9mUVJiemCv7Y4Bb0XmmSGGrRw=;
 b=c/5I5kNGKB1FpTEHsQSjSxNXkXnHe7BmgX35bs9EMm7LxYbIowUrzeicNaWFCNCSJXKZyrjQdF5TOa/2y15cm9y52HThI31v2c9ySbOUuA9WQUUwfQ1QRXXu7QAIvHWck6PjRItFac/iEo0zr7/gePd4aniUiHzDh/3Uu+o8xOU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10919.jpnprd01.prod.outlook.com (2603:1096:400:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 08:04:09 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 08:04:08 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Thread-Topic: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Thread-Index: AQHZuwuSpv3gkn/1J0+wg8hRJGO8+q/C5nkAgAAItVCAAAKbgIAFop4Q
Date:   Mon, 24 Jul 2023 08:04:08 +0000
Message-ID: <OS0PR01MB59223400A76E7D05BE0C00088602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
 <20230720131016.331793-3-biju.das.jz@bp.renesas.com>
 <20230720-clash-borax-b458480d1579@spud>
 <TYCPR01MB593325C0DF5169C0DC96A96F863EA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20230720-cognitive-identity-1d132ed09d2d@spud>
In-Reply-To: <20230720-cognitive-identity-1d132ed09d2d@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10919:EE_
x-ms-office365-filtering-correlation-id: 3eae58a5-107e-4dd8-f669-08db8c1c8ef3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/Z6sWlJ8wy6NSJXwDU0nOLm5sWJJ82eYIVhRCOUj6m4UqE4DAamcpZ2zzIPOIOZHCbgxZ5GxxgjU+3/sAsL1Odlw0Qkno9ySpMSMsgIe04wwckrWyhS6schfthwZ7QbWBEf34RY+N1Y/zLHB/N8ReQ19YfyFczQbX0349WAgS3gjsQU6dmgKK2LxwZBCr3FQE5Cg0Il/TQfRkA+Gwg1U9/7GSEIQx0wyCArlSPc9/1uTZqhVIGmWUr0trpnVRdscTCY2CDxibgNazYyQAe0gVuUzlstsvw9ua05eISo2SxgduXEn4Nz2ZbBt1V7pBqqBjPKzcVHeRSykkZNTaLVVi8RkXILfxA2ns1g8lA26y9qyFhCZY+ojWwKzkcQhWUsP5ptj8qs4Y+Q4dBQZlTMjKxb7uHOhXa6io2ISYZ5gFqQwv+j8Rr3lWWLBCWpH0p8pJ/R0bQ1+++WFGRf7Q4kvhOkjaWoY/FxPD6z3RGNER/NNqrbOMH/2nzD61dc4C6qWl1AfBelKLZ4ZY6dwssFI/obE2PDlZtKMyV7AX8iAi/VsGuPjfK5JLbfUgZpswgjpUlfbuGYRd2CVIXJI26InnY4G7Puu7KOkiJKh7gichhNBigBd80fXZW6Wz/SIRY0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(2906002)(55016003)(478600001)(38100700002)(8676002)(122000001)(9686003)(83380400001)(186003)(6506007)(26005)(53546011)(86362001)(52536014)(8936002)(5660300002)(33656002)(7416002)(6916009)(71200400001)(7696005)(66446008)(76116006)(38070700005)(66556008)(66476007)(66946007)(64756008)(316002)(54906003)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aazsy4g3iLAwTzPvx0wLXnOFprNEkLaD5mJdvo7bH4Q7ZylcjdplpUK6/5cR?=
 =?us-ascii?Q?AxctuZWi1TUABHznJWr7QnTsNbRtWSLG082K88RxlkkDmipA23fhxydVN6pj?=
 =?us-ascii?Q?uZQCy4OMOnlfsjKt+kzCL2sNfHXG4lf/fgVjOkKa9zRWjh2O+y3ZLCApjzTX?=
 =?us-ascii?Q?qGtZbji5FSnEuw16PJLpznlqzdZrjU+lO4llRRgwxZ0zJA0hipVRpzdVWdfp?=
 =?us-ascii?Q?sxMe1NlUJO4xe/TXSUJjC4ob7a3Vm1Vn5fgLnCIu+ZFfm7g687C79OreSyEc?=
 =?us-ascii?Q?1OkTt3Pf9AgzNrDqz0i09TDEApM06sX7SF06d2Oyx+1qvKXl2XFKUsI0jKl6?=
 =?us-ascii?Q?heGNHeNePq4gehGfk7OQkkXXXhhV1clG8FdAwznQNjcpDlhZ3Epcu4eLJ07v?=
 =?us-ascii?Q?y05vbePBFibuLYdk93/lIO3j9+Kyaouq3gEB9Gr7majJWxY5Qw0cIGtK845e?=
 =?us-ascii?Q?NR8o8PvGCBBRRSmeZfvsfJU+AQR2N+FfxcqDxud5aic2Q1Jh9mwQBFW7tLra?=
 =?us-ascii?Q?t9ieZvCJn9fmOsKikbYuOkltfv2/sQgw0rBggjLAcOGi2fbQkgv2zTPXMwId?=
 =?us-ascii?Q?oHBv//25K85xpKyrYKtqISJNtiqGddb5C5M8DcoDYXqLvqDl5H4ypihyvnVD?=
 =?us-ascii?Q?4l7/SkuYnW7Yp+JLutLXqcGBu4s3maoYp8dP3euESfv7IBEOknRTQisJUJR3?=
 =?us-ascii?Q?hNTRWImiSB2LgZz0g+pFjglbGxlzeera9Xu+SFLXT5OjBnGlO57+0FS5NNFR?=
 =?us-ascii?Q?kdS+AQGTDPTN7cc9Xotgw9ALHIqI8AuUAX+cJWaGeIQh8hVu1tfEreT+RIUO?=
 =?us-ascii?Q?gZSDazOILxj1tStcw7O8x+BHcLPzXSgYeALo+OrVB2/zq93KxI4F4JQCoEIJ?=
 =?us-ascii?Q?DbOrpbs8J4SevlA2PicPznnF9VIOA8528q6v43JLtlqQNKa0Azg/L4VK5Rvy?=
 =?us-ascii?Q?KlrbYf0VXIzGRrYHAYOxRm3XuiJF8hAHepHmiEcpYBlKUJLNwACorbBPjlgd?=
 =?us-ascii?Q?3YwMu6QCC7CmCy/dha9s/3vFE5RhFa/RsgQ2G8rkF/zChsdHaBmBikRG5OFh?=
 =?us-ascii?Q?sLQ7e3SriRywshwENrULKS4jlvOrnbuauAglx0fyCpLk0LrSL+Ai4w4v9JTG?=
 =?us-ascii?Q?lklw4bV6XpujIvBxHk4I4O+DHLAOkk/CjD1pfR/gR3nVKzDItdIGZcujTGbS?=
 =?us-ascii?Q?AuNEAhNNQvmAstGzEJ6F/p64rq+S+w7Lud710BEd1H4kDhdB4SbFFJmo+5GV?=
 =?us-ascii?Q?APePxe2+bf1JMrGKTwFNNsctiz+B+9ehd2OguG0o7aQKHflvtfn3gjabFn0Z?=
 =?us-ascii?Q?AqyD5P6ENk2RnmdeB5MWDkyfLKq90tyV7ju4GM9Zu0pLFk6NKnc+8Q6GrZ6W?=
 =?us-ascii?Q?ZAGuPMRtYZaxNgPIqQ3arXslvEe4dbd0tgbU0M0R2QDunPeWjtT2KmegiG+X?=
 =?us-ascii?Q?IBRtWOsg9ArG8QYfhA36i9IGw7uWkCoEhC3j1wKu7R0WjoragBpSk+FGSaGM?=
 =?us-ascii?Q?mwVSH/Vz8/Plq02m4a19Da2WLk6Rnx1Xbv18yLqfTQo/Jj9JIVuwQNPBKhzp?=
 =?us-ascii?Q?4M2D9MeDOm8PH37RybyfURty/E6VLx4dCKhXiasq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eae58a5-107e-4dd8-f669-08db8c1c8ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 08:04:08.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wic7lgVcryQldxJesuVJf1gmJjB9juZd01I19VNQd9/+TBs+RR0B0XsFYtfsYd15tfwjGc9nGYmzf4nNtyZUgS5knRGdwX+qaTltP95DJ5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10919
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Conor Dooley,=20

> Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
> overflow/underflow interrupt names
>=20
> On Thu, Jul 20, 2023 at 05:52:00PM +0000, Biju Das wrote:
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
>=20
> > > Sent: Thursday, July 20, 2023 6:19 PM
> > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>;
> > > Thomas Gleixner <tglx@linutronix.de>; Geert Uytterhoeven
> > > <geert+renesas@glider.be>; Magnus Damm <magnus.damm@gmail.com>; Lee
> > > Jones <lee@kernel.org>; linux- iio@vger.kernel.org;
> > > linux-renesas-soc@vger.kernel.org;
> > > devicetree@vger.kernel.org; Fabrizio Castro
> > > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>; stable@kernel.org
>=20
> btw, please trim this stuff :)

You mean trim the recipient list?

Cheers,
Biju

>=20
> > > Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
> > > overflow/underflow interrupt names
> > >
> > > On Thu, Jul 20, 2023 at 02:10:12PM +0100, Biju Das wrote:
> > > > As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3
> > > > overflow/underflow interrupt names starts with 'tci' instead of
> 'tgi'.
> > > >
> > > > Fix this documentation issue by replacing below overflow/underflow
> > > > interrupt names:
> > > >  - tgiv0->tciv0
> > > >  - tgiv1->tciv1
> > > >  - tgiu1->tciu1
> > > >  - tgiv2->tciv2
> > > >  - tgiu2->tciu2
> > > >  - tgiv3->tciv3
> > > >  - tgiv4->tciv4
> > > >  - tgiv6->tciv6
> > > >  - tgiv7->tciv7
> > > >  - tgiv8->tciv8
> > > >  - tgiu8->tciu8
> > > >
> > > > Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a
> > > > bindings")
> > > > Cc: stable@kernel.org
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > I assume this means that nothing is actually using these interrupt
> > > names?
> >
> > Yes, That is correct. Corresponding driver doesn't have interrupt
> support.
>=20
> Okay, if it is not being used anywhere:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks,
> Conor.
