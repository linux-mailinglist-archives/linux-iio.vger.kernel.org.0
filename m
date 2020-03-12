Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D591834F8
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCLP30 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 11:29:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36081 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgCLP3Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 11:29:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so4668549qtb.3;
        Thu, 12 Mar 2020 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+aLlIdDG/mksFbP+Kuj1XQUaQdKeQJnEvcCIGD2kNVQ=;
        b=mE9mB3iHmekaqNHXXzkG85FxjkzrYH73NT5Ul1m9Xk3UTbMtz6EOkIJ2TPOYVv6Iyd
         yrkpA/VVguaIM/IXV4NFQoDaK8Jsro67T8njEYH93B1OuP2wrLSMmJwEQV244tjuQMRN
         V9OYDvE71yVe9XpoH/ZEAiRAGI4kXDnHmPAKSIoUfKZnOTitz+fk8NTB/CZvWzk4qU9B
         d0eTCPe48R7/m//O3FHXu9WpOkshFZIAptZ3M50vhj5LiO5IImBtVjTDTeSgFriToKQr
         NwvSOq+JgKfzRDYoUfjGPPZyeO7BAiRjxQyOZdAf5lM7kfy1sv2G3dJJJV8W6yYIiecw
         Q1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+aLlIdDG/mksFbP+Kuj1XQUaQdKeQJnEvcCIGD2kNVQ=;
        b=OBXfBT7ykcmA/cSbjLWXVE6JXQirmsYXX23+GtT8RTP8ewMuHIwx9WF+tIk0Ux8jXn
         k9O09RGKvbjjyn2wZH+qUHh7khYZdeRj0njt/9U9B90fuGhvYIjn0JO9Ld0Uec3zRfBH
         PhO14W8pJOkYcYXq4fBKa9ZOOSLsUdBRBtf9eWBPPEZhXxFqFO40eH6RPEvGSJuMp5Av
         QYaBvpJe8Lk7KbUAjuyD8xwPrt/Fw2+DKzA1evrYdCC9JOiKuoc3dqMzBq8JsPul071j
         aLrf+MLjLk4bLHNol4RF56qRhm2fEg94yKz0Hx+PiqOqlkfnHsXtcspE8NBGNOAqL+ay
         ZlWg==
X-Gm-Message-State: ANhLgQ3mTTOovOvRWFmpEBDnXc8sxvkhM+y/La/GLnJzKahr8RUFuFpa
        IvdQFENMEi2hORe3RQH93UE=
X-Google-Smtp-Source: ADFU+vum/tj5uNdpDh1roRmK8QwGTPSdsCg51RiBLz9jvOG51mcAGjkY7FjOyc+1AsmZlZmJSVE1/w==
X-Received: by 2002:aed:34e6:: with SMTP id x93mr422181qtd.194.1584026963055;
        Thu, 12 Mar 2020 08:29:23 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id v126sm10404020qkb.107.2020.03.12.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:29:21 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:29:01 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200312152901.GA3250@icarus>
References: <20200312112438.GA32462@syed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20200312112438.GA32462@syed>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 04:54:38PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions to 104-quad-8 counter
> driver generic interface code changes. There is no IRQ handling so spin_l=
ock calls
> are used for protection.
>=20
> Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface
> support")
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
>=20
> Split the patch from filter clock prescaler and differential encoder
> cable status changes. Also, include more code statements for protection
> using spin_lock calls and remove protection from few code statements as
> they were unnecessary.
> ---

Hello Syed,

Text above the "---" line will be saved as part of the commit message,
which is not what we want for review comments. Move your comments to
below this line instead; this patch I submitted recently is a good
example of the format:
https://lore.kernel.org/linux-iio/20200301220719.25173-1-vilhelm.gray@gmail=
=2Ecom/

I have some more changes for this patch, but we're almost finished. :-)

>  drivers/counter/104-quad-8.c | 174 ++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 149 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9dab190..7d42303 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -44,6 +44,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses=
");
>   * @base:		base port address of the IIO device
>   */
>  struct quad8_iio {
> +	spinlock_t lock;
>  	struct counter_device counter;
>  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
> @@ -123,6 +124,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>  		/* Borrow XOR Carry effectively doubles count range */
>  		*val =3D (borrow ^ carry) << 24;
> =20
> +		spin_lock(&priv->lock);
> +
>  		/* Reset Byte Pointer; transfer Counter to Output Latch */
>  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
>  		     base_offset + 1);
> @@ -130,6 +133,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>  		for (i =3D 0; i < 3; i++)
>  			*val |=3D (unsigned int)inb(base_offset) << (8 * i);
> =20
> +		spin_unlock(&priv->lock);
> +
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_ENABLE:
>  		*val =3D priv->ab_enable[chan->channel];
> @@ -160,6 +165,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		if ((unsigned int)val > 0xFFFFFF)
>  			return -EINVAL;
> =20
> +		spin_lock(&priv->lock);
> +
>  		/* Reset Byte Pointer */
>  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> =20
> @@ -183,12 +190,16 @@ static int quad8_write_raw(struct iio_dev *indio_de=
v,
>  		/* Reset Error flag */
>  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> =20
> +		spin_unlock(&priv->lock);
> +
>  		return 0;
>  	case IIO_CHAN_INFO_ENABLE:
>  		/* only boolean values accepted */
>  		if (val < 0 || val > 1)
>  			return -EINVAL;
> =20
> +		spin_lock(&priv->lock);
> +
>  		priv->ab_enable[chan->channel] =3D val;
> =20
>  		ior_cfg =3D val | priv->preset_enable[chan->channel] << 1;
> @@ -196,8 +207,12 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		/* Load I/O control configuration */
>  		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> =20
> +		spin_unlock(&priv->lock);
> +
>  		return 0;
>  	case IIO_CHAN_INFO_SCALE:
> +		spin_lock(&priv->lock);
> +
>  		/* Quadrature scaling only available in quadrature mode */
>  		if (!priv->quadrature_mode[chan->channel] && (val2 || val !=3D 1))
>  			return -EINVAL;

We will need to careful here because there are some return statements;
we are bound to deadlock if we return without calling spin_unlock first.

There are a couple ways I can think of that allow you to resolve this:
for example you can call spin_unlock before every return statement, or
maybe create a goto that calls spin_unlock and then returns -EINVAL;
I'll leave it up for you to decide how to solve this.

> @@ -219,6 +234,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		else
>  			return -EINVAL;
> =20
> +		spin_unlock(&priv->lock);
> +
>  		return 0;
>  	}
> =20
> @@ -255,6 +272,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset[chan->channel] =3D preset;
> =20
>  	/* Reset Byte Pointer */
> @@ -264,6 +283,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	for (i =3D 0; i < 3; i++)
>  		outb(preset >> (8 * i), base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -293,6 +314,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Preset enable is active low in Input/Output Control register */
>  	preset_enable =3D !preset_enable;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset_enable[chan->channel] =3D preset_enable;
> =20
>  	ior_cfg =3D priv->ab_enable[chan->channel] |
> @@ -301,6 +324,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -358,6 +383,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	unsigned int mode_cfg =3D cnt_mode << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[chan->channel] =3D cnt_mode;
> =20
>  	/* Add quadrature mode configuration */
> @@ -367,6 +394,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -394,9 +423,13 @@ static int quad8_set_synchronous_mode(struct iio_dev=
 *indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
>  {
>  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> -	const unsigned int idr_cfg =3D synchronous_mode |
> -		priv->index_polarity[chan->channel] << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> +	unsigned int idr_cfg;

The synchronous_mode parameter does not need protection so you can
initialize idr_cfg to it immediately:

	unsigned int idr_cfg =3D synchronous_mode;

> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg =3D synchronous_mode |
> +		priv->index_polarity[chan->channel] << 1;

Since we set idr_cfg to synchronous_mode earlier, this line can become:

	idr_cfg |=3D priv->index_polarity[chan->channel] << 1;

> =20
>  	/* Index function must be non-synchronous in non-quadrature mode */
>  	if (synchronous_mode && !priv->quadrature_mode[chan->channel])

There is a return statement here that could create a deadlock situation.
To resolve this, you can call spin_unlock before the return statement.

> @@ -407,6 +440,8 @@ static int quad8_set_synchronous_mode(struct iio_dev =
*indio_dev,
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -434,8 +469,12 @@ static int quad8_set_quadrature_mode(struct iio_dev =
*indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
>  {
>  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> -	unsigned int mode_cfg =3D priv->count_mode[chan->channel] << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> +	unsigned int mode_cfg;
> +
> +	spin_lock(&priv->lock);
> +
> +	mode_cfg =3D priv->count_mode[chan->channel] << 1;
> =20
>  	if (quadrature_mode)
>  		mode_cfg |=3D (priv->quadrature_scale[chan->channel] + 1) << 3;
> @@ -453,6 +492,8 @@ static int quad8_set_quadrature_mode(struct iio_dev *=
indio_dev,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -480,15 +521,21 @@ static int quad8_set_index_polarity(struct iio_dev =
*indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int index_polarity)
>  {
>  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> -	const unsigned int idr_cfg =3D priv->synchronous_mode[chan->channel] |
> -		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> +	unsigned int idr_cfg;

The index_polarity parameter does not need protection so we can
initialize idr_cfg to it immediately:

	unsigned int idr_cfg =3D index_polarity << 1;

> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg =3D priv->synchronous_mode[chan->channel] |
> +		index_polarity << 1;

Since we idr_cfg was set with index_polarity earlier, this line can
become:

	idr_cfg |=3D priv->synchronous_mode[chan->channel];

> =20
>  	priv->index_polarity[chan->channel] =3D index_polarity;
> =20
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -603,6 +650,8 @@ static int quad8_count_read(struct counter_device *co=
unter,
>  	/* Borrow XOR Carry effectively doubles count range */
>  	*val =3D (unsigned long)(borrow ^ carry) << 24;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);

You can redeclare priv throughout your patch to drop the const qualifier
whenever needed so that you don't need to constantly cast these
spin_lock/spin_unlock calls everywhere:

	struct quad8_iio *const priv =3D counter->priv;
	...
	spin_lock(&priv->lock);
	...
	spin_unlock(&priv->lock);

> +
>  	/* Reset Byte Pointer; transfer Counter to Output Latch */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
>  	     base_offset + 1);
> @@ -610,6 +659,8 @@ static int quad8_count_read(struct counter_device *co=
unter,
>  	for (i =3D 0; i < 3; i++)
>  		*val |=3D (unsigned long)inb(base_offset) << (8 * i);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	return 0;
>  }
> =20
> @@ -624,6 +675,8 @@ static int quad8_count_write(struct counter_device *c=
ounter,
>  	if (val > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* Reset Byte Pointer */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> =20
> @@ -647,6 +700,8 @@ static int quad8_count_write(struct counter_device *c=
ounter,
>  	/* Reset Error flag */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	return 0;
>  }
> =20
> @@ -669,11 +724,11 @@ static int quad8_function_get(struct counter_device=
 *counter,
>  {
>  	const struct quad8_iio *const priv =3D counter->priv;
>  	const int id =3D count->id;
> -	const unsigned int quadrature_mode =3D priv->quadrature_mode[id];
> -	const unsigned int scale =3D priv->quadrature_scale[id];
> =20
> -	if (quadrature_mode)
> -		switch (scale) {
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
> +	if (priv->quadrature_mode[id])
> +		switch (priv->quadrature_scale[id]) {
>  		case 0:
>  			*function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
>  			break;
> @@ -687,6 +742,8 @@ static int quad8_function_get(struct counter_device *=
counter,
>  	else
>  		*function =3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	return 0;
>  }
> =20
> @@ -697,10 +754,15 @@ static int quad8_function_set(struct counter_device=
 *counter,
>  	const int id =3D count->id;
>  	unsigned int *const quadrature_mode =3D priv->quadrature_mode + id;
>  	unsigned int *const scale =3D priv->quadrature_scale + id;
> -	unsigned int mode_cfg =3D priv->count_mode[id] << 1;
>  	unsigned int *const synchronous_mode =3D priv->synchronous_mode + id;
> -	const unsigned int idr_cfg =3D priv->index_polarity[id] << 1;
>  	const int base_offset =3D priv->base + 2 * id + 1;
> +	unsigned int mode_cfg;
> +	unsigned int idr_cfg;
> +
> +	spin_lock(&priv->lock);
> +
> +	mode_cfg =3D priv->count_mode[id] << 1;
> +	idr_cfg =3D priv->index_polarity[id] << 1;
> =20
>  	if (function =3D=3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
>  		*quadrature_mode =3D 0;
> @@ -736,6 +798,8 @@ static int quad8_function_set(struct counter_device *=
counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -852,15 +916,21 @@ static int quad8_index_polarity_set(struct counter_=
device *counter,
>  {
>  	struct quad8_iio *const priv =3D counter->priv;
>  	const size_t channel_id =3D signal->id - 16;
> -	const unsigned int idr_cfg =3D priv->synchronous_mode[channel_id] |
> -		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> +	unsigned int idr_cfg;

The index_polarity parameter does not need to be protected so you can
initalized idr_cfg with it immediatedly:

	unsigned int idr_cfg =3D index_polarity << 1;

> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg =3D priv->synchronous_mode[channel_id] |
> +		index_polarity << 1;

Since idr_cfg was already initialized with index_polarity, this line can
become:

	idr_cfg |=3D priv->synchronous_mode[channel_id];

> =20
>  	priv->index_polarity[channel_id] =3D index_polarity;
> =20
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -887,9 +957,13 @@ static int quad8_synchronous_mode_set(struct counter=
_device *counter,
>  {
>  	struct quad8_iio *const priv =3D counter->priv;
>  	const size_t channel_id =3D signal->id - 16;
> -	const unsigned int idr_cfg =3D synchronous_mode |
> -		priv->index_polarity[channel_id] << 1;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> +	unsigned int idr_cfg;

The synchronous_mode parameter does not need to be protected so you can
initalized idr_cfg with it immediatedly:

	unsigned int idr_cfg =3D synchronous_mode;

> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg =3D synchronous_mode |
> +		priv->index_polarity[channel_id] << 1;

Since idr_cfg was already initialized with synchronous_mode, this line
can become:

	idr_cfg |=3D priv->index_polarity[channel_id] << 1;

> =20
>  	/* Index function must be non-synchronous in non-quadrature mode */
>  	if (synchronous_mode && !priv->quadrature_mode[channel_id])

There's a return statement here that can cause a deadlock. You should
call spin_unlock before the return statement.

> @@ -900,6 +974,8 @@ static int quad8_synchronous_mode_set(struct counter_=
device *counter,
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -964,6 +1040,8 @@ static int quad8_count_mode_set(struct counter_devic=
e *counter,
>  		break;
>  	}
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[count->id] =3D cnt_mode;
> =20
>  	/* Set count mode configuration value */
> @@ -976,6 +1054,8 @@ static int quad8_count_mode_set(struct counter_devic=
e *counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -1017,6 +1097,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	if (err)
>  		return err;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->ab_enable[count->id] =3D ab_enable;
> =20
>  	ior_cfg =3D ab_enable | priv->preset_enable[count->id] << 1;
> @@ -1024,6 +1106,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	/* Load I/O control configuration */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1052,6 +1136,22 @@ static ssize_t quad8_count_preset_read(struct coun=
ter_device *counter,
>  	return sprintf(buf, "%u\n", priv->preset[count->id]);
>  }
> =20
> +void quad8_preset_register_set(struct counter_device *counter,
> +		const int base_offset, int id, unsigned int preset)

We can simplify this parameter list some more because base_offset can be
determined by the id. I think something like the following would work:

void quad8_preset_register_set(struct quad8_iio *quad8iio,
			       unsigned int id, unsigned int preset)
{
	const unsigned int base_offset =3D quad8iio->base + 2 * id;
	...

> +{
> +	struct quad8_iio *const priv =3D counter->priv;
> +	int i;
> +
> +	priv->preset[id] =3D preset;
> +
> +	/* Reset Byte Pointer */
> +	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> +
> +	/* Set Preset Register */
> +	for (i =3D 0; i < 3; i++)
> +		outb(preset >> (8 * i), base_offset);
> +}
> +
>  static ssize_t quad8_count_preset_write(struct counter_device *counter,
>  	struct counter_count *count, void *private, const char *buf, size_t len)
>  {
> @@ -1059,7 +1159,6 @@ static ssize_t quad8_count_preset_write(struct coun=
ter_device *counter,
>  	const int base_offset =3D priv->base + 2 * count->id;

Defining base_offset here will no longer be necessary because the new
quad8_preset_register_set will define it, so you can delete this line.

>  	unsigned int preset;
>  	int ret;
> -	int i;
> =20
>  	ret =3D kstrtouint(buf, 0, &preset);
>  	if (ret)
> @@ -1069,14 +1168,11 @@ static ssize_t quad8_count_preset_write(struct co=
unter_device *counter,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> -	priv->preset[count->id] =3D preset;
> +	spin_lock(&priv->lock);
> =20
> -	/* Reset Byte Pointer */
> -	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> +	quad8_preset_register_set(counter, base_offset, count->id, preset);

This then becomes:

	quad8_preset_register_set(priv, count->id, preset);

> =20
> -	/* Set Preset Register */
> -	for (i =3D 0; i < 3; i++)
> -		outb(preset >> (8 * i), base_offset);
> +	spin_unlock(&priv->lock);
> =20
>  	return len;
>  }
> @@ -1086,13 +1182,17 @@ static ssize_t quad8_count_ceiling_read(struct co=
unter_device *counter,
>  {
>  	const struct quad8_iio *const priv =3D counter->priv;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
>  	switch (priv->count_mode[count->id]) {
>  	case 1:
>  	case 3:
> -		return quad8_count_preset_read(counter, count, private, buf);
> +		return sprintf(buf, "%u\n", priv->preset[count->id]);
>  	}
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
>  	return sprintf(buf, "33554431\n");
>  }
> @@ -1101,15 +1201,32 @@ static ssize_t quad8_count_ceiling_write(struct c=
ounter_device *counter,
>  	struct counter_count *count, void *private, const char *buf, size_t len)
>  {
>  	struct quad8_iio *const priv =3D counter->priv;
> +	const int base_offset =3D priv->base + 2 * count->id;

This base_offset can go away since it will be defined anyway in the
quad8_preset_register_set function.

> +	unsigned int preset;

Rename this variable to "ceiling". Although ceiling and preset share the
same register, they are functionally different so it's best for us to
differentiate between the two.

> +	int ret;
> +
> +	spin_lock(&priv->lock);
> =20
>  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
>  	switch (priv->count_mode[count->id]) {
>  	case 1:
>  	case 3:
> -		return quad8_count_preset_write(counter, count, private, buf,
> -						len);
> +		ret =3D kstrtouint(buf, 0, &preset);
> +		if (ret)
> +			return ret;
> +
> +		/* Only 24-bit values are supported */
> +		if (preset > 0xFFFFFF)
> +			return -EINVAL;

The kstrtouint call and 24-bit value check should occur outside of this
switch statement since this check is needed regardless of the count
mode. So something like this:

		ret =3D kstrtouint(buf, 0, &ceiling);
		if (ret)
			return ret;

		if (ceiling > 0xFFFFFF)
			return -EINVAL;

		spin_lock(&priv->lock);

		switch (priv->count_mode[count->id]) {
		...

> +
> +		quad8_preset_register_set(counter, base_offset,
> +				count->id, preset);

This becomes:

		quad8_preset_register_set(priv, count->id, ceiling);

> +
> +		return len;

This return is not needed. You can break here instead.

Sincerely,

William Breathitt Gray

>  	}
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1137,6 +1254,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
ct counter_device *counter,
>  	/* Preset enable is active low in Input/Output Control register */
>  	preset_enable =3D !preset_enable;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset_enable[count->id] =3D preset_enable;
> =20
>  	ior_cfg =3D priv->ab_enable[count->id] | (unsigned int)preset_enable <<=
 1;
> @@ -1144,6 +1263,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
ct counter_device *counter,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1429,6 +1550,9 @@ static int quad8_probe(struct device *dev, unsigned=
 int id)
>  	quad8iio->counter.priv =3D quad8iio;
>  	quad8iio->base =3D base[id];
> =20
> +	/* Initialize spin lock */
> +	spin_lock_init(&quad8iio->lock);
> +
>  	/* Reset all counters and disable interrupt function */
>  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
>  	/* Set initial configuration for all counters */
> --=20
> 2.7.4
>=20

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5qVSMACgkQhvpINdm7
VJJKqhAAsfSHShzmSqEv83HtJW/Y1ZZxcTkA+NtcCGmHisnUXsOO1UDcXISlSBT9
pDMCyI8/I/RSutYMXwTu+HJzgAVFvnqljg8Xj1rO9vzhWmKP86P+aBpwIhfNTSMR
v4T7nhRCwY21Cr5RcMZ52OOdnfDNZPhQSmFZKo1zo+uoZAqegrx+kFnM7ZzFkPUu
E1oXbPsLh4tTKR39pnbMTgGZk2aWTsLXfP8AdiP7DkMK/0wwVIFCQudt5Zz5BbTG
JRImKShKE4RBPLWw8vCftEzEnqCBZWE6qTimXbj0q6ZuQGfyp85DDyWrXuy0YAIM
BrUTy/r8Wm+/AGl5kQ4Q7eSzJy+pG9LTj6QQdMQq7HGeLjLN2ZeHVimFeU/iaN7C
ctGtyOkWRoOQj2X9pU5uY1reO+iE5N689uYSPol1h0iIBnXCPR4NGPhPPgrxivZ9
GGp8EupKL9r1QIDAQsczNMnM1HWA+KNvHiW+2zbXJlLurMwAhrbL3VHTsHGtsRcY
lF3n+1cZw998++6DR7cqb5TXanSDEm1qw72UTdjCedZklQxQSuqdhkg3FCuDoL9Z
CLMAbaPF9tl5IxGaghKIeXRXGvsBQWVyBmQ7th+MtUar5eNmFbLdVKXSEu++SToh
TT8U/bz2lMgGBWdQ3BEPeQ/dyw3oMQ0Q48oZAXthcuGNrSwGOGk=
=vfJd
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
