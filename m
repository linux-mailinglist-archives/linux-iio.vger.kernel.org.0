Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02A19185D9D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgCOOjq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 10:39:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40722 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCOOjp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 10:39:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id n5so11898591qtv.7;
        Sun, 15 Mar 2020 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H1yjMM6gS4cewTjdc+m6Sx1nYgETWU/8kZSgsScw6hc=;
        b=bbO4fGR1sFILMOwJv1qPfW1nl3LY9KDPk9R1GovowkYfcTBHbsoxCmagY7h8O+8CDz
         EiegT5Tf0Ie6OtMxrwZmDBXMq996vRIjnooCAU77Dd7oASV1w3rrJxrtA8qx/WcApHq0
         oH6VB+TN/WJQvbmWIAOkc1kL1hbUHC3NivC9wYtjhfqSfytQpDScpbUftfRGdqo9Wqtl
         VO9DgXvPxq2yc5B/KDie3dsBgEENaRa9hmAod/BlCrbGJ2a2DHo9gmApSbZZUwauSCk/
         CxGqofaZDYiGze333Ue66ge98zuTfNQXh5DiE/Jyi3IcjB6XaEMAh1k/ANIEvRSnYvuv
         9KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1yjMM6gS4cewTjdc+m6Sx1nYgETWU/8kZSgsScw6hc=;
        b=C0bOrF3FT+EdMUYvEpD53sg27xrazg5FudyU8pcF+r6EC4sq/Afpyz2P45lJFoI18a
         4sCajs2FmcjkhxNjV25/tMZ3Snj3Pdyj9+LUt4oUM+a5qN5EiM2aYp/m184+cP5XW+jd
         NLYbYrlJ9cfJE36XyB4+boUqE+uBn5NBTugg75vUKLM5Ug6hP4Ccpl0bZB2hfOteaX/O
         WqtmEuQv9ULj4e2kwK+mNBNHKVpyvDyK73gN7yOAOybNJGsI2yXvtAE0faJrDM7JK3rv
         SvkaU9Ilcr1nfIPu7khaPev6Gb8u8m0s/sNQA7ynMsy4u2L3T0zdaCkbPkTQohgZseOI
         60Wg==
X-Gm-Message-State: ANhLgQ2XT9/9/1umfPnsyu24nhvQXoV0w2lEHmkmmLlw3xNTMVAjVPh6
        lfuFWGPb6aSMc5sgTl9AR/NVK2L+2weVEg==
X-Google-Smtp-Source: ADFU+vsq0qsiwUWipkx4nZTY6hfD3t9KJ/dYgeMRTgUuuN00UOXe7qxKFZPq7gOx7L7m6yC+UdS27A==
X-Received: by 2002:ac8:6043:: with SMTP id k3mr21773116qtm.336.1584283182223;
        Sun, 15 Mar 2020 07:39:42 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id i28sm35231225qtc.57.2020.03.15.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 07:39:40 -0700 (PDT)
Date:   Sun, 15 Mar 2020 10:39:27 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200315143927.GA4087@icarus>
References: <20200313120057.GA17812@syed>
 <20200313165102.GA5024@icarus>
 <20200315120904.2475a9c1@archlinux>
 <20200315140512.GA3260@icarus>
 <20200315142916.25ffa24f@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20200315142916.25ffa24f@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2020 at 02:29:16PM +0000, Jonathan Cameron wrote:
> On Sun, 15 Mar 2020 10:06:56 -0400
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > On Sun, Mar 15, 2020 at 12:09:04PM +0000, Jonathan Cameron wrote:
> > > On Fri, 13 Mar 2020 12:51:02 -0400
> > > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> > >  =20
> > > > On Fri, Mar 13, 2020 at 05:30:58PM +0530, Syed Nayyar Waris wrote: =
=20
> > > > > Add lock protection from race conditions to 104-quad-8 counter dr=
iver
> > > > > generic interface code changes. There is no IRQ handling so spin_=
lock
> > > > > calls are used for protection.
> > > > >=20
> > > > > Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter in=
terface support")
> > > > >=20
> > > > > Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>   =20
> > > >=20
> > > > Thanks Syed, this version looks good to me.
> > > >=20
> > > > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > > >=20
> > > > Jonathan, if you have no objections please pick up this series. =20
> > >=20
> > > One question.  Why not a mutex?  If there aren't an interrupts involv=
ed
> > > that would normally be preferred.
> > >=20
> > > Jonathan =20
> >=20
> > I don't think a mutex would be appropriate in this context would it?
> > We're just executing some basic port I/O operations and briefly
> > accessing shared data. Because everything we're doing is very
> > short-term, there's no need for a mutex and adding one just adds the
> > chance of putting the thread to sleep which would be a larger latency
> > than simply waiting for the spinlock to be unlocked.
>=20
> The mutex should only put the thread to sleep if it's contended.
> Here that should be extremely rare.  The question of how large the
> latency is comes down to how contended we might be.  I guess we pretty
> much assume we aren't actually contended here unless something weird
> is going on.
>=20
> >=20
> > (We don't necessarily need raw_spinlock_t since interrupts aren't
> > involved, but I think the more generic spinlock_t is fine.)
>=20
> That does allow the RT sleeping spin locks to work fine, but in that
> case might as well just use a mutex in first place and have consistent
> results.
>=20
> Usually I'd be looking to use a mutex unless it was absolutely required
> to use a spinlock.=20
>=20
> I'm not that fussed though and it's very unlikely to make much difference
> in this case.  However, the statement in the patch title that we use
> spin_lock as no IRQ calls is very confusing...  Note that I'm fairly
> sure spin_lock and raw_spin_lock are currently the same thing unless
> you have applied the RT patch set.
>=20
> Jonathan

That's a fair point. I don't feel too strongly either way so if Syed
decides to switch to mutex_lock calls, or perhaps remove the confusing
line about IRQs calls in the commit message, I won't object to it.

William Breathitt Gray

>=20
> >=20
> > William Breathitt Gray
> >=20
> > >  =20
> > > >=20
> > > > William Breathitt Gray
> > > >  =20
> > > > > ---
> > > > > Changes in v4:
> > > > >  - Shift review-comments section so that its not saved in commit =
message.
> > > > >  - Add spin_unlock calls for deadlock avoidance.
> > > > >  - Change parameters of quad8_preset_register_set.
> > > > >  - Few changes related to assignment statements.
> > > > >=20
> > > > >  drivers/counter/104-quad-8.c | 194 +++++++++++++++++++++++++++++=
++++++--------
> > > > >  1 file changed, 160 insertions(+), 34 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-q=
uad-8.c
> > > > > index 9dab190..88decab 100644
> > > > > --- a/drivers/counter/104-quad-8.c
> > > > > +++ b/drivers/counter/104-quad-8.c
> > > > > @@ -44,6 +44,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base a=
ddresses");
> > > > >   * @base:		base port address of the IIO device
> > > > >   */
> > > > >  struct quad8_iio {
> > > > > +	spinlock_t lock;
> > > > >  	struct counter_device counter;
> > > > >  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
> > > > >  	unsigned int preset[QUAD8_NUM_COUNTERS];
> > > > > @@ -123,6 +124,8 @@ static int quad8_read_raw(struct iio_dev *ind=
io_dev,
> > > > >  		/* Borrow XOR Carry effectively doubles count range */
> > > > >  		*val =3D (borrow ^ carry) << 24;
> > > > > =20
> > > > > +		spin_lock(&priv->lock);
> > > > > +
> > > > >  		/* Reset Byte Pointer; transfer Counter to Output Latch */
> > > > >  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
> > > > >  		     base_offset + 1);
> > > > > @@ -130,6 +133,8 @@ static int quad8_read_raw(struct iio_dev *ind=
io_dev,
> > > > >  		for (i =3D 0; i < 3; i++)
> > > > >  			*val |=3D (unsigned int)inb(base_offset) << (8 * i);
> > > > > =20
> > > > > +		spin_unlock(&priv->lock);
> > > > > +
> > > > >  		return IIO_VAL_INT;
> > > > >  	case IIO_CHAN_INFO_ENABLE:
> > > > >  		*val =3D priv->ab_enable[chan->channel];
> > > > > @@ -160,6 +165,8 @@ static int quad8_write_raw(struct iio_dev *in=
dio_dev,
> > > > >  		if ((unsigned int)val > 0xFFFFFF)
> > > > >  			return -EINVAL;
> > > > > =20
> > > > > +		spin_lock(&priv->lock);
> > > > > +
> > > > >  		/* Reset Byte Pointer */
> > > > >  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > > > =20
> > > > > @@ -183,12 +190,16 @@ static int quad8_write_raw(struct iio_dev *=
indio_dev,
> > > > >  		/* Reset Error flag */
> > > > >  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> > > > > =20
> > > > > +		spin_unlock(&priv->lock);
> > > > > +
> > > > >  		return 0;
> > > > >  	case IIO_CHAN_INFO_ENABLE:
> > > > >  		/* only boolean values accepted */
> > > > >  		if (val < 0 || val > 1)
> > > > >  			return -EINVAL;
> > > > > =20
> > > > > +		spin_lock(&priv->lock);
> > > > > +
> > > > >  		priv->ab_enable[chan->channel] =3D val;
> > > > > =20
> > > > >  		ior_cfg =3D val | priv->preset_enable[chan->channel] << 1;
> > > > > @@ -196,11 +207,18 @@ static int quad8_write_raw(struct iio_dev *=
indio_dev,
> > > > >  		/* Load I/O control configuration */
> > > > >  		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> > > > > =20
> > > > > +		spin_unlock(&priv->lock);
> > > > > +
> > > > >  		return 0;
> > > > >  	case IIO_CHAN_INFO_SCALE:
> > > > > +		spin_lock(&priv->lock);
> > > > > +
> > > > >  		/* Quadrature scaling only available in quadrature mode */
> > > > > -		if (!priv->quadrature_mode[chan->channel] && (val2 || val !=3D=
 1))
> > > > > +		if (!priv->quadrature_mode[chan->channel] &&
> > > > > +				(val2 || val !=3D 1)) {
> > > > > +			spin_unlock(&priv->lock);
> > > > >  			return -EINVAL;
> > > > > +		}
> > > > > =20
> > > > >  		/* Only three gain states (1, 0.5, 0.25) */
> > > > >  		if (val =3D=3D 1 && !val2)
> > > > > @@ -214,11 +232,15 @@ static int quad8_write_raw(struct iio_dev *=
indio_dev,
> > > > >  				priv->quadrature_scale[chan->channel] =3D 2;
> > > > >  				break;
> > > > >  			default:
> > > > > +				spin_unlock(&priv->lock);
> > > > >  				return -EINVAL;
> > > > >  			}
> > > > > -		else
> > > > > +		else {
> > > > > +			spin_unlock(&priv->lock);
> > > > >  			return -EINVAL;
> > > > > +		}
> > > > > =20
> > > > > +		spin_unlock(&priv->lock);
> > > > >  		return 0;
> > > > >  	}
> > > > > =20
> > > > > @@ -255,6 +277,8 @@ static ssize_t quad8_write_preset(struct iio_=
dev *indio_dev, uintptr_t private,
> > > > >  	if (preset > 0xFFFFFF)
> > > > >  		return -EINVAL;
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	priv->preset[chan->channel] =3D preset;
> > > > > =20
> > > > >  	/* Reset Byte Pointer */
> > > > > @@ -264,6 +288,8 @@ static ssize_t quad8_write_preset(struct iio_=
dev *indio_dev, uintptr_t private,
> > > > >  	for (i =3D 0; i < 3; i++)
> > > > >  		outb(preset >> (8 * i), base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return len;
> > > > >  }
> > > > > =20
> > > > > @@ -293,6 +319,8 @@ static ssize_t quad8_write_set_to_preset_on_i=
ndex(struct iio_dev *indio_dev,
> > > > >  	/* Preset enable is active low in Input/Output Control register=
 */
> > > > >  	preset_enable =3D !preset_enable;
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	priv->preset_enable[chan->channel] =3D preset_enable;
> > > > > =20
> > > > >  	ior_cfg =3D priv->ab_enable[chan->channel] |
> > > > > @@ -301,6 +329,8 @@ static ssize_t quad8_write_set_to_preset_on_i=
ndex(struct iio_dev *indio_dev,
> > > > >  	/* Load I/O control configuration to Input / Output Control Reg=
ister */
> > > > >  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return len;
> > > > >  }
> > > > > =20
> > > > > @@ -358,6 +388,8 @@ static int quad8_set_count_mode(struct iio_de=
v *indio_dev,
> > > > >  	unsigned int mode_cfg =3D cnt_mode << 1;
> > > > >  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	priv->count_mode[chan->channel] =3D cnt_mode;
> > > > > =20
> > > > >  	/* Add quadrature mode configuration */
> > > > > @@ -367,6 +399,8 @@ static int quad8_set_count_mode(struct iio_de=
v *indio_dev,
> > > > >  	/* Load mode configuration to Counter Mode Register */
> > > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -394,19 +428,26 @@ static int quad8_set_synchronous_mode(struc=
t iio_dev *indio_dev,
> > > > >  	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
> > > > >  {
> > > > >  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> > > > > -	const unsigned int idr_cfg =3D synchronous_mode |
> > > > > -		priv->index_polarity[chan->channel] << 1;
> > > > >  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> > > > > +	unsigned int idr_cfg =3D synchronous_mode;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > > +	idr_cfg |=3D priv->index_polarity[chan->channel] << 1;
> > > > > =20
> > > > >  	/* Index function must be non-synchronous in non-quadrature mod=
e */
> > > > > -	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
> > > > > +	if (synchronous_mode && !priv->quadrature_mode[chan->channel]) {
> > > > > +		spin_unlock(&priv->lock);
> > > > >  		return -EINVAL;
> > > > > +	}
> > > > > =20
> > > > >  	priv->synchronous_mode[chan->channel] =3D synchronous_mode;
> > > > > =20
> > > > >  	/* Load Index Control configuration to Index Control Register */
> > > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -434,8 +475,12 @@ static int quad8_set_quadrature_mode(struct =
iio_dev *indio_dev,
> > > > >  	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
> > > > >  {
> > > > >  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> > > > > -	unsigned int mode_cfg =3D priv->count_mode[chan->channel] << 1;
> > > > >  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> > > > > +	unsigned int mode_cfg;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > > +	mode_cfg =3D priv->count_mode[chan->channel] << 1;
> > > > > =20
> > > > >  	if (quadrature_mode)
> > > > >  		mode_cfg |=3D (priv->quadrature_scale[chan->channel] + 1) << 3;
> > > > > @@ -453,6 +498,8 @@ static int quad8_set_quadrature_mode(struct i=
io_dev *indio_dev,
> > > > >  	/* Load mode configuration to Counter Mode Register */
> > > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -480,15 +527,20 @@ static int quad8_set_index_polarity(struct =
iio_dev *indio_dev,
> > > > >  	const struct iio_chan_spec *chan, unsigned int index_polarity)
> > > > >  {
> > > > >  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> > > > > -	const unsigned int idr_cfg =3D priv->synchronous_mode[chan->cha=
nnel] |
> > > > > -		index_polarity << 1;
> > > > >  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> > > > > +	unsigned int idr_cfg =3D index_polarity << 1;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > > +	idr_cfg |=3D priv->synchronous_mode[chan->channel];
> > > > > =20
> > > > >  	priv->index_polarity[chan->channel] =3D index_polarity;
> > > > > =20
> > > > >  	/* Load Index Control configuration to Index Control Register */
> > > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -589,7 +641,7 @@ static int quad8_signal_read(struct counter_d=
evice *counter,
> > > > >  static int quad8_count_read(struct counter_device *counter,
> > > > >  	struct counter_count *count, unsigned long *val)
> > > > >  {
> > > > > -	const struct quad8_iio *const priv =3D counter->priv;
> > > > > +	struct quad8_iio *const priv =3D counter->priv;
> > > > >  	const int base_offset =3D priv->base + 2 * count->id;
> > > > >  	unsigned int flags;
> > > > >  	unsigned int borrow;
> > > > > @@ -603,6 +655,8 @@ static int quad8_count_read(struct counter_de=
vice *counter,
> > > > >  	/* Borrow XOR Carry effectively doubles count range */
> > > > >  	*val =3D (unsigned long)(borrow ^ carry) << 24;
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	/* Reset Byte Pointer; transfer Counter to Output Latch */
> > > > >  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
> > > > >  	     base_offset + 1);
> > > > > @@ -610,13 +664,15 @@ static int quad8_count_read(struct counter_=
device *counter,
> > > > >  	for (i =3D 0; i < 3; i++)
> > > > >  		*val |=3D (unsigned long)inb(base_offset) << (8 * i);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > >  static int quad8_count_write(struct counter_device *counter,
> > > > >  	struct counter_count *count, unsigned long val)
> > > > >  {
> > > > > -	const struct quad8_iio *const priv =3D counter->priv;
> > > > > +	struct quad8_iio *const priv =3D counter->priv;
> > > > >  	const int base_offset =3D priv->base + 2 * count->id;
> > > > >  	int i;
> > > > > =20
> > > > > @@ -624,6 +680,8 @@ static int quad8_count_write(struct counter_d=
evice *counter,
> > > > >  	if (val > 0xFFFFFF)
> > > > >  		return -EINVAL;
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	/* Reset Byte Pointer */
> > > > >  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > > > =20
> > > > > @@ -647,6 +705,8 @@ static int quad8_count_write(struct counter_d=
evice *counter,
> > > > >  	/* Reset Error flag */
> > > > >  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -667,13 +727,13 @@ static enum counter_count_function quad8_co=
unt_functions_list[] =3D {
> > > > >  static int quad8_function_get(struct counter_device *counter,
> > > > >  	struct counter_count *count, size_t *function)
> > > > >  {
> > > > > -	const struct quad8_iio *const priv =3D counter->priv;
> > > > > +	struct quad8_iio *const priv =3D counter->priv;
> > > > >  	const int id =3D count->id;
> > > > > -	const unsigned int quadrature_mode =3D priv->quadrature_mode[id=
];
> > > > > -	const unsigned int scale =3D priv->quadrature_scale[id];
> > > > > =20
> > > > > -	if (quadrature_mode)
> > > > > -		switch (scale) {
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > > +	if (priv->quadrature_mode[id])
> > > > > +		switch (priv->quadrature_scale[id]) {
> > > > >  		case 0:
> > > > >  			*function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
> > > > >  			break;
> > > > > @@ -687,6 +747,8 @@ static int quad8_function_get(struct counter_=
device *counter,
> > > > >  	else
> > > > >  		*function =3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -697,10 +759,15 @@ static int quad8_function_set(struct counte=
r_device *counter,
> > > > >  	const int id =3D count->id;
> > > > >  	unsigned int *const quadrature_mode =3D priv->quadrature_mode +=
 id;
> > > > >  	unsigned int *const scale =3D priv->quadrature_scale + id;
> > > > > -	unsigned int mode_cfg =3D priv->count_mode[id] << 1;
> > > > >  	unsigned int *const synchronous_mode =3D priv->synchronous_mode=
 + id;
> > > > > -	const unsigned int idr_cfg =3D priv->index_polarity[id] << 1;
> > > > >  	const int base_offset =3D priv->base + 2 * id + 1;
> > > > > +	unsigned int mode_cfg;
> > > > > +	unsigned int idr_cfg;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > > +	mode_cfg =3D priv->count_mode[id] << 1;
> > > > > +	idr_cfg =3D priv->index_polarity[id] << 1;
> > > > > =20
> > > > >  	if (function =3D=3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
> > > > >  		*quadrature_mode =3D 0;
> > > > > @@ -736,6 +803,8 @@ static int quad8_function_set(struct counter_=
device *counter,
> > > > >  	/* Load mode configuration to Counter Mode Register */
> > > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -852,15 +921,20 @@ static int quad8_index_polarity_set(struct =
counter_device *counter,
> > > > >  {
> > > > >  	struct quad8_iio *const priv =3D counter->priv;
> > > > >  	const size_t channel_id =3D signal->id - 16;
> > > > > -	const unsigned int idr_cfg =3D priv->synchronous_mode[channel_i=
d] |
> > > > > -		index_polarity << 1;
> > > > >  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> > > > > +	unsigned int idr_cfg =3D index_polarity << 1;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > > +	idr_cfg |=3D priv->synchronous_mode[channel_id];
> > > > > =20
> > > > >  	priv->index_polarity[channel_id] =3D index_polarity;
> > > > > =20
> > > > >  	/* Load Index Control configuration to Index Control Register */
> > > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -887,19 +961,26 @@ static int quad8_synchronous_mode_set(struc=
t counter_device *counter,
> > > > >  {
> > > > >  	struct quad8_iio *const priv =3D counter->priv;
> > > > >  	const size_t channel_id =3D signal->id - 16;
> > > > > -	const unsigned int idr_cfg =3D synchronous_mode |
> > > > > -		priv->index_polarity[channel_id] << 1;
> > > > >  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> > > > > +	unsigned int idr_cfg =3D synchronous_mode;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > > +	idr_cfg |=3D priv->index_polarity[channel_id] << 1;
> > > > > =20
> > > > >  	/* Index function must be non-synchronous in non-quadrature mod=
e */
> > > > > -	if (synchronous_mode && !priv->quadrature_mode[channel_id])
> > > > > +	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
> > > > > +		spin_unlock(&priv->lock);
> > > > >  		return -EINVAL;
> > > > > +	}
> > > > > =20
> > > > >  	priv->synchronous_mode[channel_id] =3D synchronous_mode;
> > > > > =20
> > > > >  	/* Load Index Control configuration to Index Control Register */
> > > > >  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -964,6 +1045,8 @@ static int quad8_count_mode_set(struct count=
er_device *counter,
> > > > >  		break;
> > > > >  	}
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	priv->count_mode[count->id] =3D cnt_mode;
> > > > > =20
> > > > >  	/* Set count mode configuration value */
> > > > > @@ -976,6 +1059,8 @@ static int quad8_count_mode_set(struct count=
er_device *counter,
> > > > >  	/* Load mode configuration to Counter Mode Register */
> > > > >  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return 0;
> > > > >  }
> > > > > =20
> > > > > @@ -1017,6 +1102,8 @@ static ssize_t quad8_count_enable_write(str=
uct counter_device *counter,
> > > > >  	if (err)
> > > > >  		return err;
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	priv->ab_enable[count->id] =3D ab_enable;
> > > > > =20
> > > > >  	ior_cfg =3D ab_enable | priv->preset_enable[count->id] << 1;
> > > > > @@ -1024,6 +1111,8 @@ static ssize_t quad8_count_enable_write(str=
uct counter_device *counter,
> > > > >  	/* Load I/O control configuration */
> > > > >  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return len;
> > > > >  }
> > > > > =20
> > > > > @@ -1052,14 +1141,28 @@ static ssize_t quad8_count_preset_read(st=
ruct counter_device *counter,
> > > > >  	return sprintf(buf, "%u\n", priv->preset[count->id]);
> > > > >  }
> > > > > =20
> > > > > +void quad8_preset_register_set(struct quad8_iio *quad8iio, int i=
d,
> > > > > +		unsigned int preset)
> > > > > +{
> > > > > +	const unsigned int base_offset =3D quad8iio->base + 2 * id;
> > > > > +	int i;
> > > > > +
> > > > > +	quad8iio->preset[id] =3D preset;
> > > > > +
> > > > > +	/* Reset Byte Pointer */
> > > > > +	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > > > +
> > > > > +	/* Set Preset Register */
> > > > > +	for (i =3D 0; i < 3; i++)
> > > > > +		outb(preset >> (8 * i), base_offset);
> > > > > +}
> > > > > +
> > > > >  static ssize_t quad8_count_preset_write(struct counter_device *c=
ounter,
> > > > >  	struct counter_count *count, void *private, const char *buf, si=
ze_t len)
> > > > >  {
> > > > >  	struct quad8_iio *const priv =3D counter->priv;
> > > > > -	const int base_offset =3D priv->base + 2 * count->id;
> > > > >  	unsigned int preset;
> > > > >  	int ret;
> > > > > -	int i;
> > > > > =20
> > > > >  	ret =3D kstrtouint(buf, 0, &preset);
> > > > >  	if (ret)
> > > > > @@ -1069,14 +1172,11 @@ static ssize_t quad8_count_preset_write(s=
truct counter_device *counter,
> > > > >  	if (preset > 0xFFFFFF)
> > > > >  		return -EINVAL;
> > > > > =20
> > > > > -	priv->preset[count->id] =3D preset;
> > > > > +	spin_lock(&priv->lock);
> > > > > =20
> > > > > -	/* Reset Byte Pointer */
> > > > > -	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> > > > > +	quad8_preset_register_set(priv, count->id, preset);
> > > > > =20
> > > > > -	/* Set Preset Register */
> > > > > -	for (i =3D 0; i < 3; i++)
> > > > > -		outb(preset >> (8 * i), base_offset);
> > > > > +	spin_unlock(&priv->lock);
> > > > > =20
> > > > >  	return len;
> > > > >  }
> > > > > @@ -1084,15 +1184,20 @@ static ssize_t quad8_count_preset_write(s=
truct counter_device *counter,
> > > > >  static ssize_t quad8_count_ceiling_read(struct counter_device *c=
ounter,
> > > > >  	struct counter_count *count, void *private, char *buf)
> > > > >  {
> > > > > -	const struct quad8_iio *const priv =3D counter->priv;
> > > > > +	struct quad8_iio *const priv =3D counter->priv;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > =20
> > > > >  	/* Range Limit and Modulo-N count modes use preset value as cei=
ling */
> > > > >  	switch (priv->count_mode[count->id]) {
> > > > >  	case 1:
> > > > >  	case 3:
> > > > > -		return quad8_count_preset_read(counter, count, private, buf);
> > > > > +		spin_unlock(&priv->lock);
> > > > > +		return sprintf(buf, "%u\n", priv->preset[count->id]);
> > > > >  	}
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
> > > > >  	return sprintf(buf, "33554431\n");
> > > > >  }
> > > > > @@ -1101,15 +1206,29 @@ static ssize_t quad8_count_ceiling_write(=
struct counter_device *counter,
> > > > >  	struct counter_count *count, void *private, const char *buf, si=
ze_t len)
> > > > >  {
> > > > >  	struct quad8_iio *const priv =3D counter->priv;
> > > > > +	unsigned int ceiling;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret =3D kstrtouint(buf, 0, &ceiling);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	/* Only 24-bit values are supported */
> > > > > +	if (ceiling > 0xFFFFFF)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	spin_lock(&priv->lock);
> > > > > =20
> > > > >  	/* Range Limit and Modulo-N count modes use preset value as cei=
ling */
> > > > >  	switch (priv->count_mode[count->id]) {
> > > > >  	case 1:
> > > > >  	case 3:
> > > > > -		return quad8_count_preset_write(counter, count, private, buf,
> > > > > -						len);
> > > > > +		quad8_preset_register_set(priv, count->id, ceiling);
> > > > > +		break;
> > > > >  	}
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return len;
> > > > >  }
> > > > > =20
> > > > > @@ -1137,6 +1256,8 @@ static ssize_t quad8_count_preset_enable_wr=
ite(struct counter_device *counter,
> > > > >  	/* Preset enable is active low in Input/Output Control register=
 */
> > > > >  	preset_enable =3D !preset_enable;
> > > > > =20
> > > > > +	spin_lock(&priv->lock);
> > > > > +
> > > > >  	priv->preset_enable[count->id] =3D preset_enable;
> > > > > =20
> > > > >  	ior_cfg =3D priv->ab_enable[count->id] | (unsigned int)preset_e=
nable << 1;
> > > > > @@ -1144,6 +1265,8 @@ static ssize_t quad8_count_preset_enable_wr=
ite(struct counter_device *counter,
> > > > >  	/* Load I/O control configuration to Input / Output Control Reg=
ister */
> > > > >  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> > > > > =20
> > > > > +	spin_unlock(&priv->lock);
> > > > > +
> > > > >  	return len;
> > > > >  }
> > > > > =20
> > > > > @@ -1429,6 +1552,9 @@ static int quad8_probe(struct device *dev, =
unsigned int id)
> > > > >  	quad8iio->counter.priv =3D quad8iio;
> > > > >  	quad8iio->base =3D base[id];
> > > > > =20
> > > > > +	/* Initialize spin lock */
> > > > > +	spin_lock_init(&quad8iio->lock);
> > > > > +
> > > > >  	/* Reset all counters and disable interrupt function */
> > > > >  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP=
);
> > > > >  	/* Set initial configuration for all counters */
> > > > > --=20
> > > > > 2.7.4
> > > > >    =20
> > >  =20
>=20

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5uPhQACgkQhvpINdm7
VJIg0A/9FlYh3zAwPC160uVJnBz2xe82ok/S79xAiEhI7D12EcqNz7oANDHFgRD/
PVeOyCz7bLPh76I9iPOxU+wNEQ/KntWAwlygpjN02/NiydAaR6lkoZdA1Kg5J5vS
2+cj3b9XXR83yUTta5/JyP5URQ9Xz4pis79XL5lik9PBzF1dIxj9ujaighvGzVQc
JTUG8xWgvzW1MxK/efgfty6dTXqUXTkkLcP1zKb7AMDa0VKQF+A4P9p2wjYTDiAk
EqQmsl79xxQ2L9XtHdrs17B4bE3VXTgBlvQxeHUbmG49+xIjf9uFJNYYpC3riCI2
EqndSrH/l/I6XEqQ4X9x1a2YLFhRUcRWooLEApICBNImCiZsytW/LN7sQvOCkxUR
gpJ2C4OLugua375sCDYUbK20K2TpMBTcwldXDUvXnbVolma7qYB6qIiD518RgIJt
8T6h0ShUsKVaIprI+CCvZ2J/bQBFfp1KaO3clEOiHin79iAaQZ0z3XRZ8R1E9yKs
kN02IRRX7L/0gF51TCmd1uef1+TsNLMWQ1fx55avQ2/q4CXG1OM8oLAv/fBEYhrb
Y2OG32juqnI4Yk7seW1q1v8i/grvRMwX/g8hx5sXZNuEnU03wXpMq/14ZzvfoNqc
DkeXEHGjvk/jtze48+mSpk8fXGI0K8oBoGs7ViVWD49mVdXJhr0=
=jPaM
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
