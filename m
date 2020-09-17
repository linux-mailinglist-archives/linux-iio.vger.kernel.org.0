Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3154A26D115
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 04:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIQCYl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 22:24:41 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:5574
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgIQCYl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 22:24:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y96hdvbBNPQrkM/hugcF0SyUBiLP+6QPB5ya1fawL0f6K/APhh9PLh5PEvbeI9T6Am9QGRw5/90Qf+XnWdZLMC62IsMQWTgM5NGXMpsYUoGCmQlZYl8SSMFEGjqr6oLYkKYWa/SjZ6loda1H5mo5TQrLIVi88EORUF8kuvfCPQdQhHI0mEaXYhVCqC8Kh590SHi7AlbPBLTm/g64Lg0DGLo3bsEGiPRrK3jVxV/0rInXuRAH6NnXGv/9w0UBijqvYTdvbM9S6AYYGS3UgUMeyjo39huO0Vs2xUBrKnBs8NUJES0HggHtkmPbgL54uUNN3fCSjADpZpEVCSz7WQUQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF0H+TQjARfEfK57TCOimyfXVGSPEn0Bl9bS/CTxB8g=;
 b=lmOClnh8I3HQK2pXKvdyvokJZ+WJa2pVrYlVDgz1uhWq4ltb5McDDbKEFLx4uYqlAMZh74FPFzWZFrBjfunc14sT7buqUSfDz+G6lKRVtgaNg1NV54bM2wUDQT3nYdfJTzVuQytG9znvkxc81x/FvuV1bNXMAq7D9OOsdMDyCyHq13rfd9UV8mPFyCg9a7r02DpEymTV+c3M3PvR+/ffSsv3zdFKHOzFhrm1Hr1qK5qWXHRRhrtfXeKW29ZSt8vzjYotTJyV5OkcNRnQOx+Jr6FS6Ov3+qvUohJfuXpNbjc5Q1QrucWA4Z169BBWuje+S3Vlnuv9qU4TxPL6UTLlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF0H+TQjARfEfK57TCOimyfXVGSPEn0Bl9bS/CTxB8g=;
 b=sa+XgjAS8TeHCtxF3v4eyFEDMPxUIpxok1Yi6255cCNE1W1V44OrDr/EsZZUgUc3F+CyLVJSl7Vo3pH0DWjJwezgIj0MRWxvMOIFVRWos00cUdO7RwfxvWUPbk4ZRWkFHxc54z0F+x6hShJgJhltBA2arHmFkcfUg4YnQ1evIg8=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR0402MB3636.eurprd04.prod.outlook.com (2603:10a6:208:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 17 Sep
 2020 02:24:36 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 02:24:36 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rob Herring <robh@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: RE: [PATCH v2 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion to
 yaml.
Thread-Topic: [PATCH v2 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion to
 yaml.
Thread-Index: AQHWjBUiWEi78ms8FEON5M75n4QP9KlsGqYA
Date:   Thu, 17 Sep 2020 02:24:36 +0000
Message-ID: <AM8PR04MB73155DCE23BC613898AD43FDFF3E0@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-2-jic23@kernel.org>
        <CAL_JsqJhBFqi8=gku8sv5=8MTB1uCTq=DkuoVzEaUMxO1QhBAg@mail.gmail.com>
 <20200916113401.00006d86@Huawei.com>
In-Reply-To: <20200916113401.00006d86@Huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b06238ca-5651-40fe-0dee-08d85ab0d2ac
x-ms-traffictypediagnostic: AM0PR0402MB3636:
x-microsoft-antispam-prvs: <AM0PR0402MB36364C058E78B24185954CDEFF3E0@AM0PR0402MB3636.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpQwWuuKYLtJ05A6vl1n1RT17zYVHm/54b4snalxs4tU/rCAS+xvkf5onZ++UZSxowfjvvp8LKL+dgBgQk61cD8W49mquIhKezmrx/W8+iPN2UJCLDAp54IVHAf/XPiVp0vNfuyqmECWgtZUJv0zlNdFUrZGmCWHSkXH3uVyMq1j96aAdwn7Kryx7zuBED76dfwQOM3vhV572r0bzg8hbWFMQsPNJ5lLbCfo6YSNY2eANRO4wgNOHBL3PmPhBokq8i55QY/3w55TqZBQVTmS9Aljkk0cTbdpIelBLz2Nxus5CgRxapbGcxPf5yhtBRM13Z3/6mqhDRsBTooffHKcdCIsDEj1wyKBQyRmkEKzVAEj4u0Wbw46uZZMKNwlDj3sCLqAMs0qeMS7em6z//ji/pcmIiOVYP78qi8ZFp4aSKPrppZgN32KHBzFj9VPJU6uE0klr5A7YVAVO1rJJNp9sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(8676002)(186003)(33656002)(83380400001)(26005)(7696005)(2906002)(86362001)(8936002)(6506007)(478600001)(45080400002)(53546011)(5660300002)(55016002)(83080400001)(52536014)(4326008)(54906003)(316002)(66446008)(76116006)(64756008)(66556008)(66476007)(110136005)(71200400001)(66946007)(9686003)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CBWRBLATp+Jpx3eEUEjm+DVr3OuuafD+yUUWdO5n1dfHfNcRIw87Gyk//0Ld/eYKFjFUgLrOzAC5SG5aQjQr1nPfDklG85U9e8oVKabcNnobWrtc/t+KNr2lwdZgqWu8IYKlAPu0qqi+Qx5DJwvwSHFX1kC1SpdCOBXAOk+A0wa0xLiZJshBGj44gXjo+xQDehbD35HMw8I4Itfxos5Ktbcqw8giU53U/OQ1vkXfY1J03u6+wkOW3+sKTz/NjdZJlb61uzc9tx04vTaWqULQfhZyo3MhWahuH2KDpLpSuEuQkzkeWdWyQDmebB6KPtU44ObCg5LoVJJYFnWNm5fPpNfVO8rkHcIeDcgttqj+HN1bfdytpJOoVanftR8ekS02xjJD3+M+lGgtXIamnH74dQlbUyeZmDv6QONEFr18CyAA5a9pIY3ViE1GNP9MCQDTy6KKCILEh2e/3xEn2nhHVlr2a2wYeh99UBAwSAuud6ob7yzHDLNeAcagTCMtFkrOLLbbHwoFgQyhiLP06VLM0i5oqNl5BDnPeDi+8uv03hq2Nzu7HUCoPxBxWi+IZgjb+fa2MwPT3D8gRXKiejJCyjXOPr0AGwQuqVRzHcSJWauUrSRxWY6qFulnzXYK/QRE0qUSLLQ43Gl5S0nyPmKwKQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06238ca-5651-40fe-0dee-08d85ab0d2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 02:24:36.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA8EfZrUz1zh2YHke9TueD6HzPUrhFZnOjjbcaumTJp9M/J7bfAx0Oi5K8JKxSYgXeLGZHOpYUYMFMcRXZFWXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3636
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@Huawei.com> Sent: Wednesday, Septe=
mber 16, 2020 6:34 PM
> On Tue, 15 Sep 2020 14:45:58 -0600
> Rob Herring <robh@kernel.org> wrote:
>=20
> > On Wed, Sep 9, 2020 at 12:02 PM Jonathan Cameron <jic23@kernel.org>
> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > A simple conversion of this freescale ADC binding from txt to yaml.
> > > For maintainer I went with Fugang Duan as the original author of the
> > > binding. Would be great to have confirmation of this.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Fugang Duan <B38611@freescale.com>
> > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  .../bindings/iio/adc/fsl,vf610-adc.yaml       | 81
> +++++++++++++++++++
> > >  .../devicetree/bindings/iio/adc/vf610-adc.txt | 36 ---------
> > >  2 files changed, 81 insertions(+), 36 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > > b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > > new file mode 100644
> > > index 000000000000..99b6b55fd0a3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> > > @@ -0,0 +1,81 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> > >
> +vicetree.org%2Fschemas%2Fiio%2Fadc%2Ffsl%2Cvf610-adc.yaml%23&amp;da
> > >
> +ta=3D02%7C01%7Cfugang.duan%40nxp.com%7C750fcd8ebdf34af6655308d85a2
> c41
> > >
> +8d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63735849344455
> 0580&
> > >
> +amp;sdata=3DSwRIWqN5caXEUZBTmnjKKHJKAZ1FQ03s1Gdpf%2FTyXzE%3D&am
> p;rese
> > > +rved=3D0
> > > +$schema:
> > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> > >
> +vicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cfug
> an
> > >
> +g.duan%40nxp.com%7C750fcd8ebdf34af6655308d85a2c418d%7C686ea1d3bc
> 2b4
> > >
> +c6fa92cd99c5c301635%7C0%7C0%7C637358493444550580&amp;sdata=3Dc4To
> ZCOG
> > > +iPM0XbxCnLGJEEXvnMvFKqSgg3gtLeDYACI%3D&amp;reserved=3D0
> > > +
> > > +title: ADC found on Freescale vf610 and similar SoCs
> > > +
> > > +maintainers:
> > > +  - Fugang Duan <B38611@freescale.com>
> >
> > I assume you got a bunch of bounces on this series, too? Looks like 1,
> > 4, 7, 9, 13, 16, 19, and 20 bounced. Please fix those addresses before
> > applying.
>=20
> Yup. I missed them on v1, but have saved the set for v2 to be able to fix=
 those I
> can.
>=20
> for some I can make a reasonable stab at a suitable maintainer as covered=
 by a
> catch all.  For the others if I can't find a newer address I'll cover the=
m myself
> until someone else steps up.
> I think that's just 9 and 13.  For 4 I didn't get a bounce but can add th=
at to my
> list!
>=20
> For this particular one looks like fugang duan is still active but now wi=
th an NXP
> address so I'll update that. I've changed the cc on this mail.
>=20
> Thanks,
>=20
> Jonathan

Thanks, Jonathan.

For the patch, it looks good.

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
>=20
>=20
> >
> > Rob
>=20

