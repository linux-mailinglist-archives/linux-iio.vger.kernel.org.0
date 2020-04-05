Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A3B19EA32
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDEJ3u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 05:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgDEJ3u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 05:29:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4740B20672;
        Sun,  5 Apr 2020 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586078989;
        bh=MjC92rt0E5l5W5t5bknkFQpDqRFmsGXr/XiP7FEyRnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANdgQ1IlKPeaeP/UytsafnLFyaKFe4sOwigg/u5QrYmJJa+OIda9LoCwhMDL14Nxv
         BZBVt6Nr44kJtnK53DkJ0pjs7O/MKIJaKILuKldI5RPiWyja6nOh1hSYrVygl2T0TK
         sTWsyONTO4eGptXCELaIsRF835tYvTjTYsc/BXvA=
Date:   Sun, 5 Apr 2020 10:29:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh@kernel.org>, Tomas Novotny <tomas@novotny.cz>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: light: vcnl4000: Add
 near-level
Message-ID: <20200405102944.41589d98@archlinux>
In-Reply-To: <20200404174521.GA24709@bogon.m.sigxcpu.org>
References: <cover.1585134362.git.agx@sigxcpu.org>
        <f0ad40351d7ab12f79d2c29f738443514ae0fb76.1585134362.git.agx@sigxcpu.org>
        <20200329102526.1ee85e96@archlinux>
        <20200331214517.GA24128@bogus>
        <20200404160127.1ef9d1ac@archlinux>
        <20200404174521.GA24709@bogon.m.sigxcpu.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 Apr 2020 19:45:21 +0200
Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> Hi,
> On Sat, Apr 04, 2020 at 04:01:27PM +0100, Jonathan Cameron wrote:
> > On Tue, 31 Mar 2020 15:45:17 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >  =20
> > > On Sun, Mar 29, 2020 at 10:25:26AM +0100, Jonathan Cameron wrote: =20
> > > > On Wed, 25 Mar 2020 12:09:06 +0100
> > > > Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
> > > >    =20
> > > > > This value indicates when userspace should consider an object
> > > > > near to the sensor/device.
> > > > >=20
> > > > > Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>   =20
> > > >=20
> > > > I'm fine with this.  Note for Rob or other DT people.
> > > >=20
> > > > This is a new generic binding hence no vendor prefix.   =20
> > >=20
> > > Then document in a common place. =20
> >=20
> > Ok.=20
> >=20
> > I guess we need to create a proximity specific binding file.
> >=20
> > Documentation/devicetree/bindings/iio/proximity.yaml
> >=20
> > Guido, could you do a v4 adding such a file.  For now I think
> > this is pretty much all that is proximity specific. =20
>=20
> I did a Documentation/devicetree/bindings/iio/common.yaml:
>=20
> https://source.puri.sm/guido.gunther/linux-imx8/commit/8b91f0b7fa76ca4b2f=
3cdc251411829f71f8d810
>=20
> so we can add new properties there and move iio-bindings.txt over.
>=20
> Does that work as well? If so I'll send out a v4.

I can't find any real precedence for naming of such files.
So I guess this is still evolving. Send it out and we'll see what Rob think=
s.

Jonathan


> Cheers,
>  -- Guido
>=20
>=20
> >=20
> > At somepoint we should convert the subsystem wide iio-bindings.txt
> > but not today!
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > >  =20
> > > >=20
> > > > I will ideally want review of both the dt patches though
> > > > before applying.  As we've missed the merge window anyway
> > > > there is no particular rush.
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Jonathan
> > > >    =20
> > > > > ---
> > > > >  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml    | 8 ++=
++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/light/vishay,v=
cnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.=
yaml
> > > > > index 21ef2eb7a205..ac9e3bb6a505 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000=
.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000=
.yaml
> > > > > @@ -25,6 +25,13 @@ properties:
> > > > >    reg:
> > > > >      maxItems: 1
> > > > > =20
> > > > > +  near-level:   =20
> > >=20
> > > Perhaps proximity-near-level instead. =20
> >=20
> > Makes sense.
> >  =20
> > >  =20
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    description:
> > > > > +      Raw proximity values equal or above this level should be
> > > > > +      considered 'near' to the device (an object is near to the
> > > > > +      sensor).
> > > > > +
> > > > >  required:
> > > > >    - compatible
> > > > >    - reg
> > > > > @@ -40,6 +47,7 @@ examples:
> > > > >        light-sensor@51 {
> > > > >                compatible =3D "vishay,vcnl4200";
> > > > >                reg =3D <0x51>;
> > > > > +              near-level =3D <220>;
> > > > >        };
> > > > >    };
> > > > >  ...   =20
> > > >    =20
> >  =20

