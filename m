Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BB19E5FC
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDDPBe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 11:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgDDPBe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 11:01:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32F8A206C3;
        Sat,  4 Apr 2020 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586012493;
        bh=2+OkZnOX6aKz/aqxQT7vTReb2mbwYBZHxLGB897/sIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sJ+gJGt7bKVvIMypf8n4UtxCGgpbiXT7Ut1AB6LiYBb9zVfRVGTahre/AzeO3ks2E
         V8SETT36BCtDVnC7OT1j3hhu6R4JiBDCYGaKEythyi3C3kL4iZYiNBErxFOag65hEH
         IwaFu6+FUy0msTf7kjbF7eRJktYMB9Fco+E25O0g=
Date:   Sat, 4 Apr 2020 16:01:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Guido =?UTF-8?B?R8O8bnRoZXI=?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>,
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
Message-ID: <20200404160127.1ef9d1ac@archlinux>
In-Reply-To: <20200331214517.GA24128@bogus>
References: <cover.1585134362.git.agx@sigxcpu.org>
        <f0ad40351d7ab12f79d2c29f738443514ae0fb76.1585134362.git.agx@sigxcpu.org>
        <20200329102526.1ee85e96@archlinux>
        <20200331214517.GA24128@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Mar 2020 15:45:17 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Mar 29, 2020 at 10:25:26AM +0100, Jonathan Cameron wrote:
> > On Wed, 25 Mar 2020 12:09:06 +0100
> > Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
> >  =20
> > > This value indicates when userspace should consider an object
> > > near to the sensor/device.
> > >=20
> > > Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org> =20
> >=20
> > I'm fine with this.  Note for Rob or other DT people.
> >=20
> > This is a new generic binding hence no vendor prefix. =20
>=20
> Then document in a common place.

Ok.=20

I guess we need to create a proximity specific binding file.

Documentation/devicetree/bindings/iio/proximity.yaml

Guido, could you do a v4 adding such a file.  For now I think
this is pretty much all that is proximity specific.

At somepoint we should convert the subsystem wide iio-bindings.txt
but not today!

Thanks,

Jonathan

>=20
> >=20
> > I will ideally want review of both the dt patches though
> > before applying.  As we've missed the merge window anyway
> > there is no particular rush.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml    | 8 ++++++=
++
> > >  1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4=
000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > > index 21ef2eb7a205..ac9e3bb6a505 100644
> > > --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > > @@ -25,6 +25,13 @@ properties:
> > >    reg:
> > >      maxItems: 1
> > > =20
> > > +  near-level: =20
>=20
> Perhaps proximity-near-level instead.

Makes sense.

>=20
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      Raw proximity values equal or above this level should be
> > > +      considered 'near' to the device (an object is near to the
> > > +      sensor).
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -40,6 +47,7 @@ examples:
> > >        light-sensor@51 {
> > >                compatible =3D "vishay,vcnl4200";
> > >                reg =3D <0x51>;
> > > +              near-level =3D <220>;
> > >        };
> > >    };
> > >  ... =20
> >  =20

