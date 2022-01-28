Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC7149FC66
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jan 2022 16:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348929AbiA1PEy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jan 2022 10:04:54 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51625 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiA1PEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jan 2022 10:04:49 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 58A0FC0015;
        Fri, 28 Jan 2022 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643382286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnFjquidjCHGW2Zdf/Lw32ZTEjmoWsuxrAf7yoFxRH8=;
        b=dLCinhAHQ4lr53KxKZmATrNRwAdWiTHPqgv3+SSN3Gwu95Eu7hyqMeoILnk0Cllw23r/NX
        DRjxG6jI6DKsM4yk3s6ijUZVdDvv33NJ1aS6DHURQQWw6ubuDPWlAErpf/UHzH2iIcemyV
        6BwdhsyvvGvk7hWwdKSMTp/9f7V1k1I/WFCx3//RQ1hVRluVzCOY2f0fHGE96hM6KgXiH/
        K/vK5DUzl9zjMTdVycKKZMpmjG7dIIL2iYGfvRyP7Y1V9rCZkDxv3zVf5+yJiAfD6vHH7i
        SM+1gb0ch7ypPfit0ED9ehzoWb31Nfe1MHmH3m/qhiKj2YvdXdQ8INMsuRoFRA==
Date:   Fri, 28 Jan 2022 16:04:43 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 04/10] iio: adc: stm32-dfsdm: Avoid dereferencing
 ->currentmode
Message-ID: <20220128160443.44016830@xps13>
In-Reply-To: <20220115160619.746a9246@jic23-huawei>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-5-miquel.raynal@bootlin.com>
        <CA+U=DspvsLxYyhrvNfEBGPKuJ1a6-L=WjnQE-hvjMVp2g-9nxQ@mail.gmail.com>
        <20211216092235.56e69441@xps13>
        <20220115160619.746a9246@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 15 Jan 2022 16:06:19 +0000:

> On Thu, 16 Dec 2021 09:22:35 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > Hi Alexandru,
> >=20
> > ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:47:02 +0200:
> >  =20
> > > On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
> > > <miquel.raynal@bootlin.com> wrote:   =20
> > > >
> > > > This is an internal variable of the core, let's use the
> > > > iio_buffer_enabled() helper which is exported for the following pur=
pose:
> > > > telling if the current mode is a buffered mode, which is precisely =
what
> > > > this driver looks for.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/st=
m32-dfsdm-adc.c
> > > > index 1cfefb3b5e56..a3b8827d3bbf 100644
> > > > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > > > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > > > @@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struc=
t iio_dev *indio_dev,
> > > >          * In continuous mode, use fast mode configuration,
> > > >          * if it provides a better resolution.
> > > >          */
> > > > -       if (adc->nconv =3D=3D 1 && !trig &&
> > > > -           (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
> > > > +       if (adc->nconv =3D=3D 1 && !trig && iio_buffer_enabled(indi=
o_dev)) {     =20
> > >=20
> > > This may become tricky if other modes get added later.
> > > STM does a relatively good job in updating and re-using their drivers
> > > (even if some of them do look quirky sometimes). =20
>=20
> Their hardware is crazy/complicated so tends to push the limits!
>=20
> > >=20
> > > So, the question here would be: is "iio_buffer_enabled(indio_dev)"
> > > going to be valid [in this place] once INDIO_BUFFER_TRIGGERED or
> > > INDIO_BUFFER_HARDWARE get added?   =20
> >=20
> > I would argue, is this a real problem? Today iio_buffer_enabled() seem
> > to handle well what this driver is expecting. If tomorrow someone adds
> > another mode, that is his/her responsibility to state "okay, this
> > section is not common to all buffer styles *anymore*, so we need to do
> > a more fine grained check against ->currentmodes than
> > iio_buffer_enabled() does". In that case using the ->currentmodes
> > getter would be the right way to go, but only at that particular
> > moment, not today. =20
>=20
> It should be isolated to this driver, so I think it is fine to use
> the broader check today, but I'll leave this to the st folks as
> it's their driver and I don't feel that strongly about it.
>=20
> >  =20
> > >=20
> > > I'd also ping some STM people for some feedback, acks or testing. =20
>=20
> Definitely on this - they are an active bunch who do a great job of looki=
ng
> after these drivers.  I've cc'd Fabrice. Make sure he (and possibly some
> others are on v2 cc list).
>=20

I'll add Olivier Moysan as well in the next version who has been quite
active on this driver as well according to git log.

>=20
> > >    =20
> > > >                 if (fl->flo[1].res >=3D fl->flo[0].res) {
> > > >                         fl->fast =3D 1;
> > > >                         flo =3D &fl->flo[1];
> > > > @@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct =
iio_dev *indio_dev,
> > > >                 cr1 =3D DFSDM_CR1_RCH(chan->channel);
> > > >
> > > >                 /* Continuous conversions triggered by SPI clk in b=
uffer mode */
> > > > -               if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
> > > > +               if (iio_buffer_enabled(indio_dev))
> > > >                         cr1 |=3D DFSDM_CR1_RCONT(1);
> > > >
> > > >                 cr1 |=3D DFSDM_CR1_RSYNC(fl->sync_mode);
> > > > --
> > > > 2.27.0
> > > >     =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20


Thanks,
Miqu=C3=A8l
