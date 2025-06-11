Return-Path: <linux-iio+bounces-20443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1071AAD5A10
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74B1F7A2E79
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0091EA7C6;
	Wed, 11 Jun 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi7NUwnL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C11A8F9E;
	Wed, 11 Jun 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654914; cv=none; b=JIDjQ8NaJDrK5L/G57jq7lL7kFo7anB21pP6oUeHUsY/0mmhO5cy21FQoMmQJo4fSoY9Eq8YYcMbIpA09+lPZxaq6Xd/rizzeXlMoE5jBou1JB9bq9Iz/TsXB3nTZzyJavzNTqJ/KvzxK85x6SjBh9KARYq/i7LhGnKgto1iu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654914; c=relaxed/simple;
	bh=yG0qEN9iK0Qu2JMlxAnUIyglXULFNntoaza+2Eo8eRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URy3ERixwWdIxjBrZ9tJstzaW/cyKShOtcgZ3m106T+ZkOPPoI1Bw3j5kQiSvYmBfB0VgAggvXLHvc0IEtGKPMhTKgkb+I9jF2SN9JA5y5mxvwN6LrtQZ+mPuX+MIn2PcBsCgrDqAmx+pq+hFbkdi70SXEWw7hNS4bCxulHQ2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi7NUwnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6D7C4CEE3;
	Wed, 11 Jun 2025 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749654914;
	bh=yG0qEN9iK0Qu2JMlxAnUIyglXULFNntoaza+2Eo8eRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pi7NUwnLU5dF4siui2NezhOx8z78XMyrLLHN6Af+25CrAXksUSgdbJU8LpCsKmSIQ
	 0WzZGcQMuc11O6hQGq7S6JbaK6r2mKZINzzL8AdghRogkOwfmr8uz7OzwFADT+/Tqu
	 O7kHoM24IA/LqGiilkzGtIGWbq0mPibFsEmo8SzpoWSRieVpnMp5PBO6sF33MVBtJg
	 H/KKJ0Ni2qJfi1GocMHW3DEIpd29cWg1NhGqsuxDnGbzWxe008c2bXurHBPNzJALig
	 C3kWBV14Kjr057Ww4Z5OvREV2IC77evW7ssCSZenjielCvGiQtWGkK2wjv5MBr/CPA
	 mzwJ+9BSGfm8w==
Date: Wed, 11 Jun 2025 16:15:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
Message-ID: <20250611161504.56d402e2@jic23-huawei>
In-Reply-To: <CAFXKEHZcS2qpb1zp6kkQm_Pb-MxYHErpjD=q6huuLm1Nq=xjqA@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-8-l.rubusch@gmail.com>
	<CAHp75VemOXhpRp2hfDhvzi3y5j5oL-_0xMmWRWkwEtX7Ks5nMQ@mail.gmail.com>
	<CAFXKEHZcS2qpb1zp6kkQm_Pb-MxYHErpjD=q6huuLm1Nq=xjqA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 16:49:34 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Andy,
>=20
> On Sun, Jun 1, 2025 at 9:38=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.=
com> wrote: =20
> > >
> > > Add possibilities to set a threshold for activity sensing. Extend the
> > > interrupt handler to process activity interrupts. Provide functions t=
o set
> > > the activity threshold and to enable/disable activity sensing. Furthe=
r add
> > > a fake channel for having x, y and z axis anded on the iio channel. =
=20
> >
> > IIO
> >
> > And what does the 'anded' mean?
> > =20
> > > This is a preparatory patch. Some of the definitions and functions are
> > > supposed to be extended for inactivity later on. =20
> >
> > ...
> > =20
> > > +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> > > +                                  enum adxl313_activity_type type)
> > > +{
> > > +       unsigned int axis_ctrl;
> > > +       unsigned int regval;
> > > +       int axis_en, int_en, ret;
> > > +
> > > +       ret =3D regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, =
&axis_ctrl);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       /* Check if axis for activity are enabled */
> > > +       if (type !=3D ADXL313_ACTIVITY)
> > > +               return 0;
> > > +
> > > +       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl); =20
> >
> > If it's false, it will be false anyway. No need to defer the check:
> >
> >   if (!axis_en)
> >     return false;
> > =20
> > > +       /* The axis are enabled, now check if specific interrupt is e=
nabled */
> > > +       ret =3D regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &re=
gval);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       int_en =3D adxl313_act_int_reg[type] & regval;
> > > +
> > > +       return axis_en && int_en; =20
> >
> >   return ... & regval;
> > =20
> > > +} =20
> >
> > I have already commented on this a couple of times.
> >
> > ...
> > =20
> > > +       /* Scale factor 15.625 mg/LSB */
> > > +       regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625); =20
> >
> > I would rather do
> >
> > val * MICRO + val2
> >
> > which is read more naturally (we will easily get that the expression
> > uses MICRO scale).
> >
> > ...
> > =20
> > > +       int ret =3D -ENOENT;
> > > +
> > > +       if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
> > > +               ret =3D iio_push_event(indio_dev,
> > > +                                    IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > +                                                       IIO_MOD_X_OR_=
Y_OR_Z,
> > > +                                                       IIO_EV_TYPE_M=
AG,
> > > +                                                       IIO_EV_DIR_RI=
SING),
> > > +                                    ts);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > >
> > >         if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
> > >                 samples =3D adxl313_get_samples(data);
> > >                 if (samples < 0)
> > >                         return samples;
> > >
> > > -               return adxl313_fifo_push(indio_dev, samples);
> > > +               ret =3D adxl313_fifo_push(indio_dev, samples); =20
> >
> > This is not needed...
> > =20
>=20
> IMHO this will be needed, or shall be needed in the follow up context.
>=20
> The [going to be renamed] function push_events() shall evaluate the
> interrupt status register for the events the driver can handle and
> also eventually drain the FIFO in case of watermark. It shall
> distinguish between failure, events / drain the FIFO which can be
> handled, and events which cannot be handled so far. It's not a if /
> else, there can be some event, and some fifo data. Therefore I'd like
> not a simple return here, but init a ret var.
>=20
> I interpreted your reviews, to change the particular implementation as
> if there was just activity. Then in a follow up patch, rewrite it
> again, now to distinguish just bewteen just activity and inactivity
> e.g. by if/else. Eventually rewrite it by a third approach to
> distinghish activity, inactivity, AC-coupled activity and AC-coupled
> inactivity, might be now switch/case. Eventually you might complain
> that my patches contain way too much modification of every line in
> every patch.
>=20
> I'd rather like to start right away with the final structure with just
> the first element - e.g. "activity" - leads to results like the above.
> Less churn among patches, but having just one element looks like
> having taken an over-complicated approach.

I'd do the from the first but with the comment up with where ret is
declared. =20

>=20
> Perhaps it's my patch split? Unsure, I tried to note in the commit messag=
e:
> > This is a preparatory patch. Some of the definitions and functions are
> > supposed to be extended for inactivity later on. =20
> Perhaps it needs more feedback here?
>=20
> Another example is seting up the read/write_event_config() or
> read/write_event_value() functions. I mean, eventually this will
> become a switch/case implementation. Of course with just one element
> switch/case seems to be obvious overkill. Going by your advice, I
> changed it to if(!..) return, it's definitely cleaner. Definitely in
> the follow up patches this will be rewritten, though.
Don't do that. Just use the switch from the start.

Sometimes we will give review feedback that doesn't take the whole
series into account (because it takes much longer to review a full series
then reread the feedback to spot anything that turned out to be due
to a later change)  In those cases it is fine to just reply to the
comment with - "The switch gathers additional elements in patches X,Y,Z
and so is introduced in this first patch to reduce churn.

>=20
> Please, let me know what is the best approach or what I can improve to
> avoid such "ping pong patching" as you name it?
>=20
> Might be that you're right here in this particular case, but then it
> would be better to discuss the final structure, isn't it?
>=20
>=20
> > >         }
> > >
> > >         /* Return error if no event data was pushed to the IIO channe=
l. */
> > > -       return -ENOENT;
> > > +       return ret; =20
> >
> > ...and this looks wrong. =20
>=20
> Well, as I said. Each separate if-condition (not just if-else), could
> be ok or not. If ok, the function still shall continue, might be at
> the end, also a watermark flag is in the status reg and the FIFO needs
> to be drained. It also might be, that some event comes which the
> driver does still not handle, but not necessarily an error
> (missconfiguration). So, draining the FIFO helps in most cases to
> bring a derailed sensor back on track. If not doing so, it silmply
> stops working, you would need to turn off and on again, or even power
> cycle the setup.
>=20
> Probably you have a better idea here, but pls have a look into the
> final setup. I really appreciate your feedbacks. I understand this is
> a rather problematic part of the code. To me it makes sense like this,
> but I'd highly appreciate your advice.

The code is correct I think as I said in my review, but it is a little
unusual.  One option is sanity check and return early if none of the
events we support is set.  That removes this path from consideration.

>=20
> >
> > Before the case was clear, if we have no respective bit set in the
> > int_stat, we return ENOENT. Now it depends on the other bit. If this
> > is correct behaviour, it needs a comment.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko =20


