Return-Path: <linux-iio+bounces-21194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90735AF01F3
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 19:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3361C05509
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995B27FB3A;
	Tue,  1 Jul 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjJ2p5NL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419BF27FB03;
	Tue,  1 Jul 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391297; cv=none; b=Uis+rwPCaSI2F+GtVbWIqkHVD5vlhhmZGDlNzEqI0w1gj6dHm4UQ5b44kU7dnDG7orDkeD8b43ajxqbxh2e+cNvoF6NlNJowD6kLEoljqL1dDb/1lExUFEgZFqk695+HG/ZzQ7zT+xjvggIhOSa7/PCHyhXmRiXFS7z5OyIp/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391297; c=relaxed/simple;
	bh=LiaSO/EgMxLm3lfnQVthr0wHsq+1QaRg5jN7d8fK5w8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGnTTHKTyzbedcEcrb9A7zZ09zvEr0VBnRxvlfw+PWd8OS6k5NTU7G5M86hOTaCM4kbMdZcEWD3I0mg/0RI4TfuFZuqynaOJVb/3rVlEK0Kvx6n3no/VaFg/U6Uu/KWt4bHEhMUFwN9YC5cMC9cPT/79XUoaRW2ce9EcVXn5eMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjJ2p5NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AC2C4CEEB;
	Tue,  1 Jul 2025 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751391296;
	bh=LiaSO/EgMxLm3lfnQVthr0wHsq+1QaRg5jN7d8fK5w8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjJ2p5NLU5BPLzUoVfF5mHhttWtKXI5cStAFbKI111+ICQXOH2J3axUMQWecrnVCM
	 nGnURwBvb2pklRC2HkGIDcdDYfvfJW9ByU/CctFUoQqTSv18HNxrJfX4FdK8Vp+Ioj
	 DEhmvSwKGtKkvDh2s0sNtDBcdZHF5b4fxleB+1mm2iwhaSPFOi20UOCCaLQzMVnR3r
	 Ey5hCZllloT2LOuuOOLCLG8ZKnqPnFND1agP3lgm3UoXbkyzuCExaFpwxPonpOFlnV
	 XkATHdsbQ0y15Z8ilMnv2aD0wg8qPWv57Ch8lWjcmgF44bVwGSuT9KzttqgP0MS+57
	 tBkM7FR5fUw7w==
Date: Tue, 1 Jul 2025 18:34:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] iio: accel: adxl313: add activity sensing
Message-ID: <20250701183419.6e31af13@jic23-huawei>
In-Reply-To: <CAFXKEHaYdwvi64+yBEiYuv62Vaa8exYFji2gBXQciJ=CWdhbsw@mail.gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
	<20250622122937.156930-5-l.rubusch@gmail.com>
	<20250628182706.2af83c1c@jic23-huawei>
	<CAFXKEHaYdwvi64+yBEiYuv62Vaa8exYFji2gBXQciJ=CWdhbsw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025 00:32:57 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Jun 28, 2025 at 7:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 22 Jun 2025 12:29:33 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add support for configuring an activity detection threshold. Extend t=
he
> > > interrupt handler to process activity-related interrupts, and provide
> > > functions to set the threshold as well as to enable or disable activi=
ty
> > > sensing. Additionally, introduce a virtual channel that represents the
> > > logical AND of the x, y, and z axes in the IIO channel.
> > >
> > > This patch serves as a preparatory step; some definitions and functio=
ns
> > > introduced here are intended to be extended later to support inactivi=
ty
> > > detection.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Hi Lothar.
> >
> > I think this is suffering from function naming evolution and we need
> > to rethink (slightly) what we ended up with.  See inline.
> > I walked into the same trap recently so was on the look out for it.
> > =20
> > > ---
> > >  drivers/iio/accel/adxl313_core.c | 326 +++++++++++++++++++++++++++++=
++
> > >  1 file changed, 326 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adx=
l313_core.c
> > > index ac4cc16399fc..d2c625f27555 100644
> > > --- a/drivers/iio/accel/adxl313_core.c
> > > +++ b/drivers/iio/accel/adxl313_core.c
> > > @@ -13,8 +13,10 @@ =20
> > =20
> > > +
> > > +static int _adxl313_read_mag_value(struct adxl313_data *data,
> > > +                                enum iio_event_direction dir,
> > > +                                enum adxl313_activity_type type_act,
> > > +                                int *val, int *val2)
> > > +{
> > > +     unsigned int threshold;
> > > +     int ret;
> > > +
> > > +     switch (dir) {
> > > +     case IIO_EV_DIR_RISING:
> > > +             ret =3D regmap_read(data->regmap,
> > > +                               adxl313_act_thresh_reg[type_act],
> > > +                               &threshold);
> > > +             if (ret)
> > > +                     return ret;
> > > +             *val =3D threshold * 15625;
> > > +             *val2 =3D MICRO;
> > > +             return IIO_VAL_FRACTIONAL;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static int _adxl313_write_mag_value(struct adxl313_data *data,
> > > +                                 enum iio_event_direction dir,
> > > +                                 enum adxl313_activity_type type_act,
> > > +                                 int val, int val2)
> > > +{
> > > +     unsigned int regval;
> > > +
> > > +     /* Scale factor 15.625 mg/LSB */
> > > +     regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> > > +     switch (dir) {
> > > +     case IIO_EV_DIR_RISING:
> > > +             return regmap_write(data->regmap,
> > > +                                 adxl313_act_thresh_reg[type_act],
> > > +                                 regval);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static int adxl313_read_mag_value(struct adxl313_data *data,
> > > +                               enum iio_event_direction dir,
> > > +                               enum iio_event_info info,
> > > +                               enum adxl313_activity_type type_act,
> > > +                               int *val, int *val2)
> > > +{
> > > +     switch (info) {
> > > +     case IIO_EV_INFO_VALUE:
> > > +             return _adxl313_read_mag_value(data, dir, =20
> >
> > Same issue as below for read functions.
> > =20
> > > +                                            type_act,
> > > +                                            val, val2);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static int adxl313_write_mag_value(struct adxl313_data *data, =20
> >
> > This has me a little confused. It's called
> > adxl313_write_mag_value() which seems pretty specific but
> > then calls another level of _adxl313_write_mag_value.
> >
> > In the next patch (assuming diff isn't leading me astray) we have
> >
> > @@ -600,13 +687,17 @@ static int adxl313_write_mag_value(struct adxl313=
_data *data,
> >                                    enum iio_event_direction dir,
> >                                    enum iio_event_info info,
> >                                    enum adxl313_activity_type type_act,
> > +                                  enum adxl313_activity_type type_inac=
t,
> >                                    int val, int val2)
> >  {
> >         switch (info) {
> >         case IIO_EV_INFO_VALUE:
> >                 return _adxl313_write_mag_value(data, dir,
> >                                                 type_act,
> > +                                               type_inact,
> >                                                 val, val2);
> > +       case IIO_EV_INFO_PERIOD:
> > +               return adxl313_set_inact_time_s(data, val);
> >         default:
> >                 return -EINVAL;
> >         }
> >
> >
> > Which is adding PERIOD to something called write_mag_value()
> >
> > Whilst I can see why you ended up with naming as:
> >
> > adxl313_write_mag_value() as the magnitude event specific part of
> > adxl13_event_write_value()
> >
> > and indeed
> >
> > _adxl313_write_mag_value() as the thing that writes IIO_EV_INFO_VALUE
> > value (i.e. the threshold) for the magnitude events.
> >
> > Last time I hit a similar naming stack, I spinkled in some _info
> >
> > So have the inner one called something slightly more specific like
> >
> > adxl313_write_mag_info_value()
> >
> > =20
> > > +                                enum iio_event_direction dir,
> > > +                                enum iio_event_info info,
> > > +                                enum adxl313_activity_type type_act,
> > > +                                int val, int val2)
> > > +{
> > > +     switch (info) {
> > > +     case IIO_EV_INFO_VALUE:
> > > +             return _adxl313_write_mag_value(data, dir,
> > > +                                             type_act,
> > > +                                             val, val2);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static int adxl313_read_event_value(struct iio_dev *indio_dev,
> > > +                                 const struct iio_chan_spec *chan,
> > > +                                 enum iio_event_type type,
> > > +                                 enum iio_event_direction dir,
> > > +                                 enum iio_event_info info,
> > > +                                 int *val, int *val2)
> > > +{
> > > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > > +
> > > +     switch (type) {
> > > +     case IIO_EV_TYPE_MAG:
> > > +             return adxl313_read_mag_value(data, dir, info,
> > > +                                           ADXL313_ACTIVITY,
> > > +                                           val, val2);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static int adxl313_write_event_value(struct iio_dev *indio_dev,
> > > +                                  const struct iio_chan_spec *chan,
> > > +                                  enum iio_event_type type,
> > > +                                  enum iio_event_direction dir,
> > > +                                  enum iio_event_info info,
> > > +                                  int val, int val2)
> > > +{
> > > +     struct adxl313_data *data =3D iio_priv(indio_dev);
> > > +
> > > +     switch (type) {
> > > +     case IIO_EV_TYPE_MAG:
> > > +             return adxl313_write_mag_value(data, dir, info,
> > > +                                            ADXL313_ACTIVITY,
> > > +                                            val, val2);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > + =20
> >
> > Otherwise LGTM
> > =20
>=20
> Hi, I'm about to wrap this up for the final version (let's see...).
>=20
> I understand that three levels of switch/case are not good. Instead
> here I did a particular function/helper per switch/case level.
> Finally, I ended up with, e.g.
>=20
> adxl313_write_event_value()  // calls
>   \-> adxl313_write_mag_value()  // calls
>          \-> _adxl313_write_mag_value()
>=20
> Personally, I think, why not just having the following calls hierarchy:
>=20
> adxl313_write_event_value()  // calls
>   \-> adxl313_write_mag_value()
>=20
> First question: Regarding the adxl345 driver, with a little higher
> level of complexity, I adopted such a solution keeping still 2 levels
> of switch case inside the helper. Would this be ok for the ADXL313,
> too? I mean, having just one helper, but that one containing one level
> of nested switch case inside a switch/case?

I think a bit of nesting is fine but it depends on whether we end
up with conditionals etc in the inner most nest.  If that's going
on or the code is otherwise complex then breaking it up into single
layers makes sense.

>=20
>=20
> Another question about the naming of the helper. As you saw, I went
> "creative" and used the commonly used name for such functions
> replacing "_event_" by "_mag_". I see this can be confusing, but also
> it might make clear where the (only locally used) helper belongs to.
>=20
> I understand names with leading '_' are not likely to be a decent
> choice here. But in general in case of adxl313_write_mag_value() -like
> names. What would be a better name for it, or would it be ok?

mag_value was fine, it was only when you then use the same *write_mag_value
postfix to mean the IIO_EV_INFO_VALUE of the outer *write_mag_value
that things got problematic.  Hence suggestion to use
write_mag_info_value postfix for that inner most call. For the outer calls
the write_mag_value() postfix was fine.

>=20
> By the answers given to the above, and if you don't object I would
> like to prepare the single level of helper approach (then having one
> nested switch/case) and keep just the adxl313_*_mag_value() or
> ..._config() functions. Let me know what you think.

The nesting comments were from Andy (IIRC), so perhaps he can offer
some feedback on what he feels is reasonable.

Thanks,

Jonathan

>=20
> > Jonathan =20
>=20


