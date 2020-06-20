Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF5120254A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jun 2020 18:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFTQbV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Jun 2020 12:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgFTQbT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jun 2020 12:31:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2F322BEF;
        Sat, 20 Jun 2020 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592670677;
        bh=XsBoFmyqrI0X41bqzm0ulNWNIF8Mgq5K7ulJ5WzhloI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zTf24Yy1FRDP68roOTqWJlGbaJzMxuVEQpfd//1TapJ0mW/que23appWJ5DrsAFRP
         bxKlrjipFPaQNV65gI31+r6AX2NdJ49FaNt7v72rMiO+kXeN/D8KRV+TrqB8JNClvi
         LQ9VaQJXpC9D9fS0W7Oc4H8OC6fVKZnnuE+ZBOeU=
Date:   Sat, 20 Jun 2020 17:31:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Eugen.Hristev@microchip.com" <Eugen.Hristev@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
        "Ludovic.Desroches@microchip.com" <Ludovic.Desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] iio: at91-sama5d2_adc: remove usage of
 iio_priv_to_dev() helper
Message-ID: <20200620173112.1ae1e2dc@archlinux>
In-Reply-To: <a77eb94a5aaffd840b351c5d5e9125f38037fb1b.camel@analog.com>
References: <20200525105341.137945-1-alexandru.ardelean@analog.com>
        <20200531153908.47ccbc37@archlinux>
        <8caaa1f8-ebbe-50ab-a655-d5c487c9a751@microchip.com>
        <8c4c05458e32f56a5d8492482f9f5403feda1894.camel@analog.com>
        <272c7ba2-5d04-f241-de11-ab0512c25659@microchip.com>
        <a77eb94a5aaffd840b351c5d5e9125f38037fb1b.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jun 2020 13:34:13 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2020-06-18 at 12:47 +0000, Eugen.Hristev@microchip.com wrote:
> > [External]
> >=20
> > On 17.06.2020 17:02, Ardelean, Alexandru wrote: =20
> > > On Wed, 2020-06-17 at 13:25 +0000, Eugen.Hristev@microchip.com wrote:=
 =20
> > > > On 31.05.2020 17:39, Jonathan Cameron wrote:
> > > >  =20
> > > > > On Mon, 25 May 2020 13:53:41 +0300
> > > > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > > > >  =20
> > > > > > We may want to get rid of the iio_priv_to_dev() helper. The
> > > > > > reason is that
> > > > > > we will hide some of the members of the iio_dev structure (to
> > > > > > prevent
> > > > > > drivers from accessing them directly), and that will also mean
> > > > > > hiding the
> > > > > > implementation of the iio_priv_to_dev() helper inside the IIO
> > > > > > core.
> > > > > >=20
> > > > > > Hiding the implementation of iio_priv_to_dev() implies that some
> > > > > > fast-
> > > > > > paths
> > > > > > may not be fast anymore, so a general idea is to try to get rid
> > > > > > of the
> > > > > > iio_priv_to_dev() altogether.
> > > > > > The iio_priv() helper won't be affected by the rework, as the
> > > > > > iio_dev
> > > > > > struct will keep a reference to the private information.
> > > > > >=20
> > > > > > For this driver, not using iio_priv_to_dev(), means reworking
> > > > > > some paths
> > > > > > to
> > > > > > pass the iio device and using iio_priv() to access the private
> > > > > > information,
> > > > > > and also keeping a reference to the iio device for some quirky
> > > > > > paths.
> > > > > >=20
> > > > > > One [quirky] path is the at91_adc_workq_handler() which requires
> > > > > > the IIO
> > > > > > device & the state struct to push to buffers.
> > > > > > Since this requires the back-ref to the IIO device, the
> > > > > > at91_adc_touch_pos() also uses it. This simplifies the patch a
> > > > > > bit. The
> > > > > > information required in this function is mostly for debugging
> > > > > > purposes.
> > > > > > Replacing it with a reference to the IIO device would have been=
 a
> > > > > > slightly
> > > > > > bigger change, which may not be worth it (for just the debugging
> > > > > > purpose
> > > > > > and given that we need the back-ref to the IIO device anyway). =
=20
> > > > >=20
> > > > > That workq is indeed quirky.  This looks fine to me in general.
> > > > > I'll
> > > > > want an appropriate ack from the at91 side of things if possible =
so
> > > > > let's leave this on the list for a while longer. =20
> > > >=20
> > > > Hi,
> > > >=20
> > > > I am available to test this patch,
> > > > Can you tell me on which branch to apply it. On 5.8-rc1 it fails for
> > > > me
> > > > (or maybe it needs rebasing ?)
> > > >  =20
> > >=20
> > > Hmm, weird.
> > > I rebased the patches on Jonathan's iio/testing.
> > > It seemed to work.
> > > https://urldefense.com/v3/__https://github.com/commodo/linux/commits/=
iio-priv-to-dev__;!!A3Ni8CS0y2Y!oEVHsA6gf9ydBvAAjlhRV5QO1bMTZN2U_OXbor0gei7=
mWk14m64rilJ2WTAXvtWmGaisXQ$=20
> > >=20
> > > As for which branch to test/apply. Not sure.
> > > Maybe Jonathan's iio/testing as base?
> > > Looks like it's based on 5.8.
> > >  =20
> >=20
> > Tested-by: Eugen Hristev <eugen.hristev@microchip.com>
> >=20
> > I have tested the major features of the driver (including the resistive=
=20
> > touch) and it looks to be working fine.
> >=20
> > I did not fully understand the quirkyness of the workq . Something you=
=20
> > want to change to that ? =20
>=20
> Umm, not really.
> I did not follow that code too in-depth.
> And I would like not to.
> Mostly to avoid scaling myself in too many directions.
>=20
> There may be a slightly better approach to it, but =C2=AF\_(=E3=83=84)_/=
=C2=AF

I'm assuming no one minds me taking this as is.

Applied to the togreg branch of iio.git first pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

>=20
> >  =20
> > > > Eugen
> > > >  =20
> > > > > Poke me if no action in a few weeks.
> > > > >=20
> > > > > Thanks,
> > > > >=20
> > > > > Jonathan
> > > > >  =20
> > > > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.co=
m>
> > > > > > ---
> > > > > >    drivers/iio/adc/at91-sama5d2_adc.c | 30 +++++++++++++++++---=
--
> > > > > > --------
> > > > > >    1 file changed, 17 insertions(+), 13 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > b/drivers/iio/adc/at91-
> > > > > > sama5d2_adc.c
> > > > > > index 9abbbdcc7420..7bce18444430 100644
> > > > > > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > > > > > @@ -402,6 +402,7 @@ struct at91_adc_state {
> > > > > >         wait_queue_head_t               wq_data_available;
> > > > > >         struct at91_adc_dma             dma_st;
> > > > > >         struct at91_adc_touch           touch_st;
> > > > > > +     struct iio_dev                  *indio_dev;
> > > > > >         u16                             buffer[AT91_BUFFER_MAX_=
HW
> > > > > > ORDS];
> > > > > >         /*
> > > > > >          * lock to prevent concurrent 'single conversion'
> > > > > > requests through
> > > > > > @@ -642,13 +643,13 @@ static u16 at91_adc_touch_pos(struct
> > > > > > at91_adc_state
> > > > > > *st, int reg)
> > > > > >         /* first half of register is the x or y, second half is
> > > > > > the scale
> > > > > > */
> > > > > >         val =3D at91_adc_readl(st, reg);
> > > > > >         if (!val)
> > > > > > -             dev_dbg(&iio_priv_to_dev(st)->dev, "pos is 0\n");
> > > > > > +             dev_dbg(&st->indio_dev->dev, "pos is 0\n");
> > > > > >=20
> > > > > >         pos =3D val & AT91_SAMA5D2_XYZ_MASK;
> > > > > >         result =3D (pos << AT91_SAMA5D2_MAX_POS_BITS) - pos;
> > > > > >         scale =3D (val >> 16) & AT91_SAMA5D2_XYZ_MASK;
> > > > > >         if (scale =3D=3D 0) {
> > > > > > -             dev_err(&iio_priv_to_dev(st)->dev, "scale is 0\n"=
);
> > > > > > +             dev_err(&st->indio_dev->dev, "scale is 0\n");
> > > > > >                 return 0;
> > > > > >         }
> > > > > >         result /=3D scale;
> > > > > > @@ -1204,9 +1205,9 @@ static unsigned
> > > > > > at91_adc_startup_time(unsigned
> > > > > > startup_time_min,
> > > > > >         return i;
> > > > > >    }
> > > > > >=20
> > > > > > -static void at91_adc_setup_samp_freq(struct at91_adc_state *st,
> > > > > > unsigned
> > > > > > freq)
> > > > > > +static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev,
> > > > > > unsigned
> > > > > > freq)
> > > > > >    {
> > > > > > -     struct iio_dev *indio_dev =3D iio_priv_to_dev(st);
> > > > > > +     struct at91_adc_state *st =3D iio_priv(indio_dev);
> > > > > >         unsigned f_per, prescal, startup, mr;
> > > > > >=20
> > > > > >         f_per =3D clk_get_rate(st->per_clk);
> > > > > > @@ -1275,9 +1276,9 @@ static void
> > > > > > at91_adc_pen_detect_interrupt(struct
> > > > > > at91_adc_state *st)
> > > > > >         st->touch_st.touching =3D true;
> > > > > >    }
> > > > > >=20
> > > > > > -static void at91_adc_no_pen_detect_interrupt(struct
> > > > > > at91_adc_state *st)
> > > > > > +static void at91_adc_no_pen_detect_interrupt(struct iio_dev
> > > > > > *indio_dev)
> > > > > >    {
> > > > > > -     struct iio_dev *indio_dev =3D iio_priv_to_dev(st);
> > > > > > +     struct at91_adc_state *st =3D iio_priv(indio_dev);
> > > > > >=20
> > > > > >         at91_adc_writel(st, AT91_SAMA5D2_TRGR,
> > > > > >                         AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER);
> > > > > > @@ -1297,7 +1298,7 @@ static void at91_adc_workq_handler(struct
> > > > > > work_struct *workq)
> > > > > >                                         struct at91_adc_touch,
> > > > > > workq);
> > > > > >         struct at91_adc_state *st =3D container_of(touch_st,
> > > > > >                                         struct at91_adc_state,
> > > > > > touch_st);
> > > > > > -     struct iio_dev *indio_dev =3D iio_priv_to_dev(st);
> > > > > > +     struct iio_dev *indio_dev =3D st->indio_dev;
> > > > > >=20
> > > > > >         iio_push_to_buffers(indio_dev, st->buffer);
> > > > > >    }
> > > > > > @@ -1318,7 +1319,7 @@ static irqreturn_t at91_adc_interrupt(int
> > > > > > irq, void
> > > > > > *private)
> > > > > >                 at91_adc_pen_detect_interrupt(st);
> > > > > >         } else if ((status & AT91_SAMA5D2_IER_NOPEN)) {
> > > > > >                 /* nopen detected IRQ */
> > > > > > -             at91_adc_no_pen_detect_interrupt(st);
> > > > > > +             at91_adc_no_pen_detect_interrupt(indio);
> > > > > >         } else if ((status & AT91_SAMA5D2_ISR_PENS) &&
> > > > > >                    ((status & rdy_mask) =3D=3D rdy_mask)) {
> > > > > >                 /* periodic trigger IRQ - during pen sense */
> > > > > > @@ -1486,7 +1487,7 @@ static int at91_adc_write_raw(struct
> > > > > > iio_dev
> > > > > > *indio_dev,
> > > > > >                     val > st->soc_info.max_sample_rate)
> > > > > >                         return -EINVAL;
> > > > > >=20
> > > > > > -             at91_adc_setup_samp_freq(st, val);
> > > > > > +             at91_adc_setup_samp_freq(indio_dev, val);
> > > > > >                 return 0;
> > > > > >         default:
> > > > > >                 return -EINVAL;
> > > > > > @@ -1624,8 +1625,10 @@ static int
> > > > > > at91_adc_update_scan_mode(struct iio_dev
> > > > > > *indio_dev,
> > > > > >         return 0;
> > > > > >    }
> > > > > >=20
> > > > > > -static void at91_adc_hw_init(struct at91_adc_state *st)
> > > > > > +static void at91_adc_hw_init(struct iio_dev *indio_dev)
> > > > > >    {
> > > > > > +     struct at91_adc_state *st =3D iio_priv(indio_dev);
> > > > > > +
> > > > > >         at91_adc_writel(st, AT91_SAMA5D2_CR,
> > > > > > AT91_SAMA5D2_CR_SWRST);
> > > > > >         at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
> > > > > >         /*
> > > > > > @@ -1635,7 +1638,7 @@ static void at91_adc_hw_init(struct
> > > > > > at91_adc_state
> > > > > > *st)
> > > > > >         at91_adc_writel(st, AT91_SAMA5D2_MR,
> > > > > >                         AT91_SAMA5D2_MR_TRANSFER(2) |
> > > > > > AT91_SAMA5D2_MR_ANACH);
> > > > > >=20
> > > > > > -     at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate=
);
> > > > > > +     at91_adc_setup_samp_freq(indio_dev, st- =20
> > > > > > >soc_info.min_sample_rate); =20
> > > > > >=20
> > > > > >         /* configure extended mode register */
> > > > > >         at91_adc_config_emr(st);
> > > > > > @@ -1718,6 +1721,7 @@ static int at91_adc_probe(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >         indio_dev->num_channels =3D ARRAY_SIZE(at91_adc_channel=
s);
> > > > > >=20
> > > > > >         st =3D iio_priv(indio_dev);
> > > > > > +     st->indio_dev =3D indio_dev;
> > > > > >=20
> > > > > >         bitmap_set(&st->touch_st.channels_bitmask,
> > > > > >                    AT91_SAMA5D2_TOUCH_X_CHAN_IDX, 1);
> > > > > > @@ -1829,7 +1833,7 @@ static int at91_adc_probe(struct
> > > > > > platform_device
> > > > > > *pdev)
> > > > > >                 goto vref_disable;
> > > > > >         }
> > > > > >=20
> > > > > > -     at91_adc_hw_init(st);
> > > > > > +     at91_adc_hw_init(indio_dev);
> > > > > >=20
> > > > > >         ret =3D clk_prepare_enable(st->per_clk);
> > > > > >         if (ret)
> > > > > > @@ -1945,7 +1949,7 @@ static __maybe_unused int
> > > > > > at91_adc_resume(struct
> > > > > > device *dev)
> > > > > >         if (ret)
> > > > > >                 goto vref_disable_resume;
> > > > > >=20
> > > > > > -     at91_adc_hw_init(st);
> > > > > > +     at91_adc_hw_init(indio_dev);
> > > > > >=20
> > > > > >         /* reconfiguring trigger hardware state */
> > > > > >         if (!iio_buffer_enabled(indio_dev)) =20

