Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AB11D6312
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 19:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEPRas (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 13:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgEPRar (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 13:30:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA81E2065C;
        Sat, 16 May 2020 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589650247;
        bh=sy/ZwK4XLIWwnJ1X2r/NS7nH5MIkDalgPGtw2Za22Cg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZAO9rW0QLWqZYrooCxJIjDBdwAhuUHzT/l6jU1YUon2n+JAYT+1laLXlRkfEiA4S4
         IXt7UXY2xcvrGd58Yhy0+D3c9jcLumHvktP2IGjxC6jn9gDUZmouB6T9clhXwxEUOJ
         mgf3FuBHRk+5c5ZtQEV9PeLGxJd24EpNWYJKnppc=
Date:   Sat, 16 May 2020 18:30:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 7/8] iio: core: simplify alloc alignment code
Message-ID: <20200516183041.79b4dd74@archlinux>
In-Reply-To: <BN6PR03MB3347D0598B1700D1A5C6974C99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
        <20200514131710.84201-8-alexandru.ardelean@analog.com>
        <BN6PR03MB33472A1B559F98E3BDCAB40B99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
        <1d89df334b08486e73ca181cf9035d9af8fbccf2.camel@analog.com>
        <BN6PR03MB3347D0598B1700D1A5C6974C99BD0@BN6PR03MB3347.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 May 2020 12:37:28 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
> > Sent: Freitag, 15. Mai 2020 13:48
> > To: linux-arm-kernel@lists.infradead.org; linux-stm32@st-md-
> > mailman.stormreply.com; Sa, Nuno <Nuno.Sa@analog.com>; linux-
> > kernel@vger.kernel.org; linux-iio@vger.kernel.org
> > Cc: ludovic.desroches@microchip.com; nicolas.ferre@microchip.com;
> > alexandre.torgue@st.com; ak@it-klinger.de; jic23@kernel.org;
> > eugen.hristev@microchip.com; mcoquelin.stm32@gmail.com;
> > alexandre.belloni@bootlin.com
> > Subject: Re: [PATCH v2 7/8] iio: core: simplify alloc alignment code
> >=20
> > On Fri, 2020-05-15 at 07:12 +0000, Sa, Nuno wrote: =20
> > > Hey Alex,
> > >
> > > Just a small question...
> > > =20
> > > > From: linux-iio-owner@vger.kernel.org <linux-iio- =20
> > owner@vger.kernel.org> =20
> > > > On Behalf Of Alexandru Ardelean
> > > > Sent: Donnerstag, 14. Mai 2020 15:17
> > > > To: linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org=
; =20
> > linux- =20
> > > > stm32@st-md-mailman.stormreply.com; linux-kernel@vger.kernel.org
> > > > Cc: ludovic.desroches@microchip.com; eugen.hristev@microchip.com;
> > > > jic23@kernel.org; nicolas.ferre@microchip.com;
> > > > alexandre.belloni@bootlin.com; alexandre.torgue@st.com;
> > > > mcoquelin.stm32@gmail.com; ak@it-klinger.de; Ardelean, Alexandru
> > > > <alexandru.Ardelean@analog.com>
> > > > Subject: [PATCH v2 7/8] iio: core: simplify alloc alignment code
> > > >
> > > > There was a recent discussion about this code:
> > > >   https://urldefense.com/v3/__https://lore.kernel.org/linux-
> > > > =20
> > iio/20200322165317.0b1f0674@archlinux/__;!!A3Ni8CS0y2Y!pgdUSayJCfxMiE =
=20
> > > > w8Fpv0LkEZurCSkX0sEcLnXeDSCLmhpu1xont6-vBQj3ZbCw$
> > > >
> > > > This looks like a good time to rework this, since any issues about =
it
> > > > should pop-up under testing, because the iio_dev is having a bit of=
 an
> > > > overhaul and stuff being moved to iio_dev_priv.
> > > >
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > ---
> > > >  drivers/iio/industrialio-core.c | 10 +++-------
> > > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industri=
alio-
> > > > core.c
> > > > index a1b29e0f8fd6..7671d36efae7 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -1514,13 +1514,9 @@ struct iio_dev *iio_device_alloc(int =20
> > sizeof_priv) =20
> > > >  	struct iio_dev *dev;
> > > >  	size_t alloc_size;
> > > >
> > > > -	alloc_size =3D sizeof(struct iio_dev_opaque);
> > > > -	if (sizeof_priv) {
> > > > -		alloc_size =3D ALIGN(alloc_size, IIO_ALIGN);
> > > > -		alloc_size +=3D sizeof_priv;
> > > > -	}
> > > > -	/* ensure 32-byte alignment of whole construct ? */
> > > > -	alloc_size +=3D IIO_ALIGN - 1;
> > > > +	alloc_size =3D ALIGN(sizeof(struct iio_dev_opaque), IIO_ALIGN);
> > > > +	if (sizeof_priv)
> > > > +		alloc_size +=3D ALIGN(sizeof_priv, IIO_ALIGN); =20
> > >
> > > Do we actually need to do the `ALIGN` again? It seems to me that =20
> > `alloc_size =20
> > > +=3D sizeof_priv`
> > > would be enough or am I missing something obvious? =20
> >=20
> > Well, it's not always clear what value 'sizeof_priv' has, and whether i=
t is
> > provided already aligned.
> > The requirement is usually that this data be cacheline aligned.
> >=20
> > So, sizeof(struct iio_dev_opaque) is aligned already a few lines above,=
 but
> > the
> > private information should also be aligned [given that it's an unknown =
value
> > provided by the driver].
> > I think this is mostly important, if we need to do DMA access to buffers
> > allocated on the driver's state-struct, which is allocated here, and wh=
ich is
> > usually provided as sizeof_priv. =20
>=20
> Yes, AFAIU this is to guarantee that the priv struct will start at an add=
ress that is=20
> DMA safe (cacheline-aligned). Hence, if there is any data in 'priv' that =
needs to be DMA
> safe, we are fine...
>=20
> Well, I was also misreading the code. Still, I think it should look somet=
hing like:
>=20
> ````
> alloc_size =3D sizeof(struct iio_dev_opaque)
> if (sizeof_priv)
> 	alloc_size +=3D ALIGN(alloc_size, IIO_ALIGN);
> ````
>=20
> If there is no priv, I think we don't need the padding bytes...
Agreed - no need to guarantee alignment of something that doesn't exist :)

>=20
> - Nuno S=C3=A1
>=20

