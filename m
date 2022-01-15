Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8039948F7B1
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiAOQAW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 11:00:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37262 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAOQAV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 11:00:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D675B8006F
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C9C36AE7;
        Sat, 15 Jan 2022 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642262419;
        bh=TKAuM9giM/b9GInKwXWZoJp01kR88xFdITWTaHjz5XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jQSqBDRLQKyflRdRg9+2usdjC2s7XpCRTRhl05BTUaZbF5mpvtDi4z1DKeSNxl10r
         dc9cJq4/63OQJo984gDIdK2y0rImA++wBE3/2sVeB9ke/Po8q1H0xyBxTVbzqzr+n5
         4b81lOrC3leefp3gNM10rCCrxVULrVeElM+VQzeXudWDaqk+yucXYtJ4HepQuhf2t9
         mDzZP98TFQN+RN+kqom4rmnTDF8lmdSZ4wcJgxATMUoXUETS9p+asY29tR93GeJ/w8
         qfu8/kthgQY1lSFxpla20vmf9H0QlZ1f+DacOW1xnNwsebM8wPBV8j1/dJ4NMv3HuM
         88/DQWAoRaJ+w==
Date:   Sat, 15 Jan 2022 16:06:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 04/10] iio: adc: stm32-dfsdm: Avoid dereferencing
 ->currentmode
Message-ID: <20220115160619.746a9246@jic23-huawei>
In-Reply-To: <20211216092235.56e69441@xps13>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-5-miquel.raynal@bootlin.com>
        <CA+U=DspvsLxYyhrvNfEBGPKuJ1a6-L=WjnQE-hvjMVp2g-9nxQ@mail.gmail.com>
        <20211216092235.56e69441@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 09:22:35 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Alexandru,
>=20
> ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 08:47:02 +0200:
>=20
> > On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote: =20
> > >
> > > This is an internal variable of the core, let's use the
> > > iio_buffer_enabled() helper which is exported for the following purpo=
se:
> > > telling if the current mode is a buffered mode, which is precisely wh=
at
> > > this driver looks for.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm3=
2-dfsdm-adc.c
> > > index 1cfefb3b5e56..a3b8827d3bbf 100644
> > > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > > @@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struct =
iio_dev *indio_dev,
> > >          * In continuous mode, use fast mode configuration,
> > >          * if it provides a better resolution.
> > >          */
> > > -       if (adc->nconv =3D=3D 1 && !trig &&
> > > -           (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
> > > +       if (adc->nconv =3D=3D 1 && !trig && iio_buffer_enabled(indio_=
dev)) {   =20
> >=20
> > This may become tricky if other modes get added later.
> > STM does a relatively good job in updating and re-using their drivers
> > (even if some of them do look quirky sometimes).

Their hardware is crazy/complicated so tends to push the limits!

> >=20
> > So, the question here would be: is "iio_buffer_enabled(indio_dev)"
> > going to be valid [in this place] once INDIO_BUFFER_TRIGGERED or
> > INDIO_BUFFER_HARDWARE get added? =20
>=20
> I would argue, is this a real problem? Today iio_buffer_enabled() seem
> to handle well what this driver is expecting. If tomorrow someone adds
> another mode, that is his/her responsibility to state "okay, this
> section is not common to all buffer styles *anymore*, so we need to do
> a more fine grained check against ->currentmodes than
> iio_buffer_enabled() does". In that case using the ->currentmodes
> getter would be the right way to go, but only at that particular
> moment, not today.

It should be isolated to this driver, so I think it is fine to use
the broader check today, but I'll leave this to the st folks as
it's their driver and I don't feel that strongly about it.

>=20
> >=20
> > I'd also ping some STM people for some feedback, acks or testing.

Definitely on this - they are an active bunch who do a great job of looking
after these drivers.  I've cc'd Fabrice. Make sure he (and possibly some
others are on v2 cc list).


> >  =20
> > >                 if (fl->flo[1].res >=3D fl->flo[0].res) {
> > >                         fl->fast =3D 1;
> > >                         flo =3D &fl->flo[1];
> > > @@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct ii=
o_dev *indio_dev,
> > >                 cr1 =3D DFSDM_CR1_RCH(chan->channel);
> > >
> > >                 /* Continuous conversions triggered by SPI clk in buf=
fer mode */
> > > -               if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
> > > +               if (iio_buffer_enabled(indio_dev))
> > >                         cr1 |=3D DFSDM_CR1_RCONT(1);
> > >
> > >                 cr1 |=3D DFSDM_CR1_RSYNC(fl->sync_mode);
> > > --
> > > 2.27.0
> > >   =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

