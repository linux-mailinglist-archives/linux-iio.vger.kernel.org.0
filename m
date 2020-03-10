Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E876017EF80
	for <lists+linux-iio@lfdr.de>; Tue, 10 Mar 2020 04:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCJD7l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 23:59:41 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45797 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJD7k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 23:59:40 -0400
Received: by mail-yw1-f66.google.com with SMTP id d206so12410527ywa.12;
        Mon, 09 Mar 2020 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZpJv7DnSC64dF4NnlmqHvTtIEUE0n271Jdj48q5vubU=;
        b=Iv3JITFvHmlDCoCxbC5w/I9DcY0D20mIPvLZMdjkjJXIvQiEC5WR+D9q9ODExxUUI2
         Gkhx0wfnO/Shmto6GZD6MuLLFZb8JHZ6vQolIdLMLTdRBvBDN5DijGWOdygD/sbbeCGL
         jWHO+97u+IWOi0PlMsK2UMBk3D9Wp5l4o5o2X2moxhnfKCKoC+Nr7u0FgURlWJ58Gq59
         Fazh0Gv44VW6FptP/XDTbmBJo67MqgZV4v4JJfoBM1dnerLF+tZrgG/GDViE1V8zkEDk
         c+hQusmkYoMDFziITFOB3YzxLf8qedIAhHPPhNo6knRo0CW7GyrbFWa7iq/EyTInxRYJ
         u/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZpJv7DnSC64dF4NnlmqHvTtIEUE0n271Jdj48q5vubU=;
        b=idZ1/YNfJj7TXg5sKgGie1G/boqCJWpAODuMCIa+sJSiVr6NBlkF8WD6WM8sW/XY6Z
         8QS2TJVrgjJgCOdqMRbofP9mWFSpg8+Kj3WyPoh0zbKSKNC3OIRY2F5yfYKoMLCT8XOl
         34k9fz91hSrbNzyyQFpJtN+A5pZ9di9wtcnEGddINWmp8iQu1FMQEptXj8NSzuGXItqK
         q6Ju5pZytdgoK7caywgNMty8UnquVVwQHyVU9oO3ts7to7PrpI19TCNBEDE9YJx/ZDwn
         GpeDDZRW70X02T51u10/6bk5Wsxrq7Xt44AR/kO89Qv4Dgckf/28rt+wM/oOon6brM46
         7b4w==
X-Gm-Message-State: ANhLgQ1A6PNJbYtblzkqK13c1JkOa6+LvTXdH4A5IDQXAT16U5rpKKY5
        73SVQxEbMJrMWAICPb9NPqI=
X-Google-Smtp-Source: ADFU+vtfuWbbaeMOPF8lENAunNFDEwQu1UI3MCur4PHWonRgDGV9zNR1DvmZ1kgX+vRyokZ3WTRqvw==
X-Received: by 2002:a25:83c8:: with SMTP id v8mr8513112ybm.201.1583812778060;
        Mon, 09 Mar 2020 20:59:38 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id p2sm19492628ywd.58.2020.03.09.20.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 20:59:36 -0700 (PDT)
Date:   Mon, 9 Mar 2020 23:59:16 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: 104-quad-8: Add lock protection
Message-ID: <20200310035916.GA16830@icarus>
References: <20200309145653.GA3329@syed.domain.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20200309145653.GA3329@syed.domain.name>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 08:26:53PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions in the 104-quad-8 counter
> driver. There is no IRQ handling so spin_lock calls are used for
> protection.

Hello Syed,

I have been thinking about this some more and it will be best to split
this patch into a series of patches to make it easier to backport this
fix. Specifically I'm thinking of three patches: one to cover the
majority of the changes, one dedicated to filter clock prescaler
changes, and one dedicated to differential encoder cable status changes.

The reason is that the filter clock prescaler and differential encoder
cable status code are new additions and not present in older kernels, so
breaking it apart this way to allow the patches to be merged up easier.

By the way, when you make a patch that has a fix, add a "Fixes" line
above your Signed-off-by line so that we know which commit introduced
the issue and thus requires the fix. For example, your main patch should
have the following line:

	Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface s=
upport")

However, the patch containing the changes for the filter clock prescaler
code would instead be this:

	Fixes: 9b74dddf79be ("counter: 104-quad-8: Support Filter Clock Prescaler")

Similarly, the patch containing the changes for the differential encoder
cable status code would be this:

	Fixes: bbef69e088c3 ("counter: 104-quad-8: Support Differential Encoder Ca=
ble Status")

In general, if you know the commit that has the bug, you can use the
following git command to generate a Fixes tag for you:

	git log <commit id> -1 --format=3D'Fixes: %h ("%s")'

>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> ---

When submit a second version of your patch, you can write what's new
under this line here so that reviewers can quickly know what's changed
since the last review. Alternatively, if you are submitting a patch
series, the cover letter can contain a summary of your changes.

In addition, remember to increment your patch version number in the
subject of your email. This can be done quickly by using the
"--subject-prefix" option of git format-patch.

>  drivers/counter/104-quad-8.c | 138 +++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 136 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9dab190..431c754 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -45,6 +45,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses=
");
>   */
>  struct quad8_iio {
>  	struct counter_device counter;
> +	spinlock_t lock;

Move this one line up so that it's the first member of quad8_iio; this
should help prevent a merge collision for the backporters.

>  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
>  	unsigned int count_mode[QUAD8_NUM_COUNTERS];
> @@ -111,15 +112,24 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (chan->type =3D=3D IIO_INDEX) {
> +			spin_lock(&priv->lock);
>  			*val =3D !!(inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
>  				& BIT(chan->channel));
> +			spin_unlock(&priv->lock);

I know I originally said to protect all outb/inb calls, but I
exaggerated somewhat since not exactly all require locks. For example,
you can regard this individual inb call as an atomic operation since its
argument will remain constant for the execution; so you don't need to
put spin_lock/spin_unlock calls here to protect it.

>  			return IIO_VAL_INT;
>  		}
> =20
> +		spin_lock(&priv->lock);
> +
>  		flags =3D inb(base_offset + 1);
> +
> +		spin_unlock(&priv->lock);
> +

This pair of spin_lock/spin_unlock calls is not needed here for the same
reason as above.

>  		borrow =3D flags & QUAD8_FLAG_BT;
>  		carry =3D !!(flags & QUAD8_FLAG_CT);
> =20
> +		spin_lock(&priv->lock);
> +
>  		/* Borrow XOR Carry effectively doubles count range */
>  		*val =3D (borrow ^ carry) << 24;

This val variable does not need to be protected since it's not related
to the 104-QUAD-8 device hardware state. You can move your spin_lock
call to here below this line.

> =20
> @@ -130,6 +140,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>  		for (i =3D 0; i < 3; i++)
>  			*val |=3D (unsigned int)inb(base_offset) << (8 * i);
> =20
> +		spin_unlock(&priv->lock);
> +
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_ENABLE:
>  		*val =3D priv->ab_enable[chan->channel];
> @@ -160,6 +172,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		if ((unsigned int)val > 0xFFFFFF)
>  			return -EINVAL;
> =20
> +		spin_lock(&priv->lock);
> +
>  		/* Reset Byte Pointer */
>  		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> =20
> @@ -183,12 +197,16 @@ static int quad8_write_raw(struct iio_dev *indio_de=
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
> @@ -196,6 +214,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		/* Load I/O control configuration */
>  		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> =20
> +		spin_unlock(&priv->lock);
> +
>  		return 0;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* Quadrature scaling only available in quadrature mode */

Quadrature mode could change between checking priv->quadrature_mode and
setting priv->quadrature_scale. You should add protection to this
section too.

> @@ -255,6 +275,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset[chan->channel] =3D preset;
> =20
>  	/* Reset Byte Pointer */
> @@ -264,6 +286,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	for (i =3D 0; i < 3; i++)
>  		outb(preset >> (8 * i), base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -293,6 +317,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Preset enable is active low in Input/Output Control register */
>  	preset_enable =3D !preset_enable;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset_enable[chan->channel] =3D preset_enable;
> =20
>  	ior_cfg =3D priv->ab_enable[chan->channel] |
> @@ -301,6 +327,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -314,8 +342,15 @@ static int quad8_get_noise_error(struct iio_dev *ind=
io_dev,
>  {
>  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> +	int quad8_noise_error;
> =20
> -	return !!(inb(base_offset) & QUAD8_FLAG_E);
> +	spin_lock(&priv->lock);
> +
> +	quad8_noise_error =3D !!(inb(base_offset) & QUAD8_FLAG_E);
> +
> +	spin_unlock(&priv->lock);
> +
> +	return quad8_noise_error;

No protection is necessary here since base_offset is constant and only a
single inb call is made.

>  }
> =20
>  static const struct iio_enum quad8_noise_error_enum =3D {
> @@ -334,8 +369,15 @@ static int quad8_get_count_direction(struct iio_dev =
*indio_dev,
>  {
>  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> +	int quad8_count_direction;
> +
> +	spin_lock(&priv->lock);
> =20
> -	return !!(inb(base_offset) & QUAD8_FLAG_UD);
> +	quad8_count_direction =3D !!(inb(base_offset) & QUAD8_FLAG_UD);
> +
> +	spin_unlock(&priv->lock);
> +
> +	return quad8_count_direction;

No protection necessary here either for the same reasons as above.

>  }
> =20
>  static const struct iio_enum quad8_count_direction_enum =3D {
> @@ -358,6 +400,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	unsigned int mode_cfg =3D cnt_mode << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[chan->channel] =3D cnt_mode;
> =20
>  	/* Add quadrature mode configuration */
> @@ -367,6 +411,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -402,11 +448,15 @@ static int quad8_set_synchronous_mode(struct iio_de=
v *indio_dev,
>  	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
>  		return -EINVAL;

Quadrature mode could change after this check, so this section should
also be protected.

> =20
> +	spin_lock(&priv->lock);
> +

The idr_cfg variable accesses priv->index_polarity which should be
protected; this means you'll need to redeclare idr_cfg so that you can
set it after calling spin_lock.

>  	priv->synchronous_mode[chan->channel] =3D synchronous_mode;
> =20
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -448,11 +498,15 @@ static int quad8_set_quadrature_mode(struct iio_dev=
 *indio_dev,
>  			quad8_set_synchronous_mode(indio_dev, chan, 0);
>  	}
> =20
> +	spin_lock(&priv->lock);
> +

This spin_lock should be higher since priv->quadrature_scale and
priv->sychronous_mode can change during this function's execution. In
addition, mode_cfg should be redefined and set after spin_lock is called
so that priv->count_mode is protected as well.

>  	priv->quadrature_mode[chan->channel] =3D quadrature_mode;
> =20
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -484,11 +538,15 @@ static int quad8_set_index_polarity(struct iio_dev =
*indio_dev,
>  		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> =20
> +	spin_lock(&priv->lock);
> +

The idr_cfg variable needs to be redefined and set after this spin_lock
call so that priv->synchronous_mode is protected too.

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
> @@ -578,9 +636,13 @@ static int quad8_signal_read(struct counter_device *=
counter,
>  	if (signal->id < 16)
>  		return -EINVAL;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	state =3D inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
>  		& BIT(signal->id - 16);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +

No protection needed here since this is an isolated inb call with a
constant argument.

>  	*val =3D (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> =20
>  	return 0;
> @@ -596,10 +658,17 @@ static int quad8_count_read(struct counter_device *=
counter,
>  	unsigned int carry;
>  	int i;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	flags =3D inb(base_offset + 1);
> +
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +

No protection needed here since this inb is isolated and has a constant
argument.

>  	borrow =3D flags & QUAD8_FLAG_BT;
>  	carry =3D !!(flags & QUAD8_FLAG_CT);
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* Borrow XOR Carry effectively doubles count range */
>  	*val =3D (unsigned long)(borrow ^ carry) << 24;
> =20

This val variable has no effect on the hardware state, so it does not
require protection. You can move your spin_lock call to here below this
line.

> @@ -610,6 +679,8 @@ static int quad8_count_read(struct counter_device *co=
unter,
>  	for (i =3D 0; i < 3; i++)
>  		*val |=3D (unsigned long)inb(base_offset) << (8 * i);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	return 0;
>  }
> =20
> @@ -624,6 +695,8 @@ static int quad8_count_write(struct counter_device *c=
ounter,
>  	if (val > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* Reset Byte Pointer */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> =20
> @@ -647,6 +720,8 @@ static int quad8_count_write(struct counter_device *c=
ounter,
>  	/* Reset Error flag */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	return 0;
>  }
> =20
> @@ -711,8 +786,11 @@ static int quad8_function_set(struct counter_device =
*counter,
>  		/* Synchronous function not supported in non-quadrature mode */
>  		if (*synchronous_mode) {
>  			*synchronous_mode =3D 0;
> +			spin_lock(&priv->lock);
>  			/* Disable synchronous function mode */
>  			outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> +			spin_unlock(&priv->lock);
> +

The synchronous_mode, quadrature_mode, and scale are local pointers to
quad8_iio configurations and thus require protection. Similarly mode_cfg
and idr_cfg are local variables that use quad8_iio configurations which
require protection. The mode_cfg and idr_cfg variables will need to be
redefined and set after a spin_lock call.

Since so many of the variables in this function use quad8_iio
configurations, it may be best to use a spin_lock call at the beginning
and a matching spin_unlock call at the end, in order to protect
everything.

>  		}
>  	} else {
>  		*quadrature_mode =3D 1;
> @@ -733,9 +811,13 @@ static int quad8_function_set(struct counter_device =
*counter,
>  		}
>  	}
> =20
> +	spin_lock(&priv->lock);
> +
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -746,9 +828,13 @@ static void quad8_direction_get(struct counter_devic=
e *counter,
>  	unsigned int ud_flag;
>  	const unsigned int flag_addr =3D priv->base + 2 * count->id + 1;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* U/D flag: nonzero =3D up, zero =3D down */
>  	ud_flag =3D inb(flag_addr) & QUAD8_FLAG_UD;
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +

No protection needed here since this is an isolated inb call with a
constant argument.

>  	*direction =3D (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
>  		COUNTER_COUNT_DIRECTION_BACKWARD;
>  }
> @@ -856,11 +942,15 @@ static int quad8_index_polarity_set(struct counter_=
device *counter,
>  		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> =20
> +	spin_lock(&priv->lock);
> +

The idr_cfg variable will need to be redefined and set after the
spin_lock call so that access to priv->synchronous_mode is protected.

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
> @@ -895,11 +985,15 @@ static int quad8_synchronous_mode_set(struct counte=
r_device *counter,
>  	if (synchronous_mode && !priv->quadrature_mode[channel_id])
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +

This spin_lock call should be before the conditional check above since
priv->quadrature_mode requires protection.

In addition, the idr_cfg variable needs to be redefined and set after
the spin_lock call so that access to priv->index_polarity is protected.

>  	priv->synchronous_mode[channel_id] =3D synchronous_mode;
> =20
>  	/* Load Index Control configuration to Index Control Register */
>  	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -964,6 +1058,8 @@ static int quad8_count_mode_set(struct counter_devic=
e *counter,
>  		break;
>  	}
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[count->id] =3D cnt_mode;
> =20
>  	/* Set count mode configuration value */
> @@ -976,6 +1072,8 @@ static int quad8_count_mode_set(struct counter_devic=
e *counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -1017,6 +1115,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	if (err)
>  		return err;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->ab_enable[count->id] =3D ab_enable;
> =20
>  	ior_cfg =3D ab_enable | priv->preset_enable[count->id] << 1;
> @@ -1024,6 +1124,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	/* Load I/O control configuration */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1033,8 +1135,12 @@ static int quad8_error_noise_get(struct counter_de=
vice *counter,
>  	const struct quad8_iio *const priv =3D counter->priv;
>  	const int base_offset =3D priv->base + 2 * count->id + 1;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +
>  	*noise_error =3D !!(inb(base_offset) & QUAD8_FLAG_E);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +

No protection needed here since this is an isolated inb call with a
constant argument.

>  	return 0;
>  }
> =20
> @@ -1069,6 +1175,8 @@ static ssize_t quad8_count_preset_write(struct coun=
ter_device *counter,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset[count->id] =3D preset;
> =20
>  	/* Reset Byte Pointer */
> @@ -1078,6 +1186,8 @@ static ssize_t quad8_count_preset_write(struct coun=
ter_device *counter,
>  	for (i =3D 0; i < 3; i++)
>  		outb(preset >> (8 * i), base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1137,6 +1247,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
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
> @@ -1144,6 +1256,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
ct counter_device *counter,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1160,9 +1274,13 @@ static ssize_t quad8_signal_cable_fault_read(struc=
t counter_device *counter,
>  	if (disabled)
>  		return -EINVAL;
> =20
> +	spin_lock(&((struct quad8_iio *)priv)->lock);
> +

The disabled variable should be redefined and set after the spin_lock
call so that access to priv->cable_fault_enable is protected.

>  	/* Logic 0 =3D cable fault */
>  	status =3D inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> =20
> +	spin_unlock(&((struct quad8_iio *)priv)->lock);
> +
>  	/* Mask respective channel and invert logic */
>  	fault =3D !(status & BIT(channel_id));
> =20
> @@ -1194,6 +1312,8 @@ static ssize_t quad8_signal_cable_fault_enable_writ=
e(
>  	if (ret)
>  		return ret;
> =20
> +	spin_lock(&priv->lock);
> +
>  	if (enable)
>  		priv->cable_fault_enable |=3D BIT(channel_id);
>  	else
> @@ -1204,6 +1324,8 @@ static ssize_t quad8_signal_cable_fault_enable_writ=
e(
> =20
>  	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1230,6 +1352,8 @@ static ssize_t quad8_signal_fck_prescaler_write(str=
uct counter_device *counter,
>  	if (ret)
>  		return ret;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->fck_prescaler[channel_id] =3D prescaler;
> =20
>  	/* Reset Byte Pointer */
> @@ -1240,6 +1364,8 @@ static ssize_t quad8_signal_fck_prescaler_write(str=
uct counter_device *counter,
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
>  	     base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1429,6 +1555,11 @@ static int quad8_probe(struct device *dev, unsigne=
d int id)
>  	quad8iio->counter.priv =3D quad8iio;
>  	quad8iio->base =3D base[id];
> =20
> +	/* Initialize spin lock */
> +	spin_lock_init(&quad8iio->lock);
> +
> +	spin_lock(&quad8iio->lock);

The quad8_probe is special because it is only executed on a device probe
event before the driver is loaded. This means that spin_lock/spin_unlock
calls are not needed in this function since concurrent access to the
104-QUAD-8 device is not yet possible. You can safely remove this
spin_lock call.

> +
>  	/* Reset all counters and disable interrupt function */
>  	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
>  	/* Set initial configuration for all counters */
> @@ -1456,11 +1587,14 @@ static int quad8_probe(struct device *dev, unsign=
ed int id)
>  		/* Disable index function; negative index polarity */
>  		outb(QUAD8_CTR_IDR, base_offset + 1);
>  	}
> +

You can remove this whitespace addition since it's not really related to
the rest of this patch.

>  	/* Disable Differential Encoder Cable Status for all channels */
>  	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
>  	/* Enable all counters */
>  	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> =20
> +	spin_unlock(&quad8iio->lock);

You can remove this spin_unlock call too since concurrent access to the
device is not yet possible here either.

Thank you,

William Breathitt Gray

> +
>  	/* Register IIO device */
>  	err =3D devm_iio_device_register(dev, indio_dev);
>  	if (err)
> --=20
> 2.7.4
>=20

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5nEIYACgkQhvpINdm7
VJJgSxAAjgbtJMcn4AoMg5v8vl7XQ90IFOHJ6IIBf21j+ERzcCDynD+GriW/rwne
SCpGADAk/zJykSM2gS+UN1B4dt2umnkrSq/H0ayjciwnfTVg6RskXHHXgFx54fV4
RfE+DhB2KIHHkKCuo/EXKkBwckRKnyNgf2RP6JCBivxB6PMdjBB/nK1ak5qZSUe7
jsNxo3nv9HwdkXv0sU6tUmrrjrGaZoS5V7MA9WH0+m/XWZnCkdM+O0Z01SVCzRjo
hkfH+tLhTb/KnqvQBcLwvpG71vDWW7wt/4m/P3UArZZ+L4K9uv9EsQZYJr3SmYXZ
ddUvz995r1CxXgnOU4EeI3a6j7P4NEfgqBZL2+89iM87p5kHnfUCGaocyR9IpIFX
y2H0W6P3apo/JwDwfj7TBPyq9rzGB+1ab8yYv7LNU0JpajDWJufg2SYAY/MyAhd2
4E1ySWC31oYVOidLcq/x6kcsLB6tGd4KcMiRgbIIMJs3HEO5SvsHrXtkJRTsC01L
89fFlD/t8F1tIvh2g5HUgJEuwU6JUYfClFqaSfnlEW4p6E/VS3CAdxrE9HukJtra
ifXJWqylnUojr8PTuQjNQVAfDwI68GOYzwQshJFI+lCR3tieTz+vk7UANrtVmYm2
sGQrKPpcePd5ZrBr2d/KKFhmSyeeLRrHASCQIfFZqwYsZpgNWDA=
=IhS4
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
