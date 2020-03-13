Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CEF184CF6
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCMQvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 12:51:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41886 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMQvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Mar 2020 12:51:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id s11so2314420qks.8;
        Fri, 13 Mar 2020 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KCxWvHbsE1m99nAdCY1XLbvZW4lryxINZcyByjwWtaw=;
        b=jbMcevFmAv9s9WoxuloH+6sRPikIcwzE2jD3qAa5fkY1ulehyu5ogo2E/10r5N0sV+
         zA9vkOtKRbcgdySE6YzXk3J0ITtLUcU9UQczeuvO+hfacHu1JPPG5MG3OCRd3s48RfPq
         zr4euBQr3UtJQWHxtvc0x+wXFwrwuthLlZW1BW+r8GSn1Kkws3RN+iQp0OtSAPP0IC8l
         DmGyam380jKcKDXCST/7uBaBA47NE3kJrDiw0aOWeruHOYPNrHmsK7YwVOhfMFKup/26
         Kb7fjYuY0dEaUAMJFQOytgw4UFB6AjR7ZdAtRbSCYnUsAvQ6qvYEbszuJfn7DBbHBjvc
         3Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KCxWvHbsE1m99nAdCY1XLbvZW4lryxINZcyByjwWtaw=;
        b=j+d+EgHaA+iFiBMqF9cgriJeRcb4x/03MQXZ99E2K62ZF6XEpXKE9JrBpZLgbnCo7s
         CPbtmf79fKEjaXNTce9xCCZ36tcmymWGsqpyn+Vbu27pVWKcUPnddcC9NJ8GrKv+TjLI
         1NINLOUhlx1pdEk+QSvr2Y4cjgcAytruYTsJJ/3IrVzBzorve/ICD6gSulYJ+py/17We
         2yv2qfrmM2tZ12mnvR6rsN6tj5HHKKO9n2Xt6uos43bREQP9LoXceZVqR3ssElDQHeOY
         0avgmu5gwdpVStxxd2mtkEa5GWLsngj2i9bhbEZy9tq9S/snodKyualVYZEA+e+CDmjD
         X8TA==
X-Gm-Message-State: ANhLgQ0VEkrgOyT5rMShxthrjFBk86cGh7brmmIdMDKs+YUtkW8lrtj/
        xTA/1LwqgA1jL9ZoQBoPLaQ=
X-Google-Smtp-Source: ADFU+vtRRXqAnoiksV3OFv4Lb9zErrB1SAgQjLw+G4Whxrdj8Avl/vxnzB970uXH2Awlk8AJu9cdbg==
X-Received: by 2002:a05:620a:128d:: with SMTP id w13mr13904898qki.191.1584118278352;
        Fri, 13 Mar 2020 09:51:18 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u51sm5635420qth.46.2020.03.13.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:51:17 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:51:02 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200313165102.GA5024@icarus>
References: <20200313120057.GA17812@syed>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20200313120057.GA17812@syed>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2020 at 05:30:58PM +0530, Syed Nayyar Waris wrote:
> Add lock protection from race conditions to 104-quad-8 counter driver
> generic interface code changes. There is no IRQ handling so spin_lock
> calls are used for protection.
>=20
> Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface =
support")
>=20
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Thanks Syed, this version looks good to me.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Jonathan, if you have no objections please pick up this series.

William Breathitt Gray

> ---
> Changes in v4:
>  - Shift review-comments section so that its not saved in commit message.
>  - Add spin_unlock calls for deadlock avoidance.
>  - Change parameters of quad8_preset_register_set.
>  - Few changes related to assignment statements.
>=20
>  drivers/counter/104-quad-8.c | 194 +++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 160 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9dab190..88decab 100644
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
> @@ -196,11 +207,18 @@ static int quad8_write_raw(struct iio_dev *indio_de=
v,
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
> -		if (!priv->quadrature_mode[chan->channel] && (val2 || val !=3D 1))
> +		if (!priv->quadrature_mode[chan->channel] &&
> +				(val2 || val !=3D 1)) {
> +			spin_unlock(&priv->lock);
>  			return -EINVAL;
> +		}
> =20
>  		/* Only three gain states (1, 0.5, 0.25) */
>  		if (val =3D=3D 1 && !val2)
> @@ -214,11 +232,15 @@ static int quad8_write_raw(struct iio_dev *indio_de=
v,
>  				priv->quadrature_scale[chan->channel] =3D 2;
>  				break;
>  			default:
> +				spin_unlock(&priv->lock);
>  				return -EINVAL;
>  			}
> -		else
> +		else {
> +			spin_unlock(&priv->lock);
>  			return -EINVAL;
> +		}
> =20
> +		spin_unlock(&priv->lock);
>  		return 0;
>  	}
> =20
> @@ -255,6 +277,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset[chan->channel] =3D preset;
> =20
>  	/* Reset Byte Pointer */
> @@ -264,6 +288,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	for (i =3D 0; i < 3; i++)
>  		outb(preset >> (8 * i), base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -293,6 +319,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Preset enable is active low in Input/Output Control register */
>  	preset_enable =3D !preset_enable;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset_enable[chan->channel] =3D preset_enable;
> =20
>  	ior_cfg =3D priv->ab_enable[chan->channel] |
> @@ -301,6 +329,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -358,6 +388,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	unsigned int mode_cfg =3D cnt_mode << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[chan->channel] =3D cnt_mode;
> =20
>  	/* Add quadrature mode configuration */
> @@ -367,6 +399,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -394,19 +428,26 @@ static int quad8_set_synchronous_mode(struct iio_de=
v *indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
>  {
>  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> -	const unsigned int idr_cfg =3D synchronous_mode |
> -		priv->index_polarity[chan->channel] << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> +	unsigned int idr_cfg =3D synchronous_mode;
> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg |=3D priv->index_polarity[chan->channel] << 1;
> =20
>  	/* Index function must be non-synchronous in non-quadrature mode */
> -	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
> +	if (synchronous_mode && !priv->quadrature_mode[chan->channel]) {
> +		spin_unlock(&priv->lock);
>  		return -EINVAL;
> +	}
> =20
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
> @@ -434,8 +475,12 @@ static int quad8_set_quadrature_mode(struct iio_dev =
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
> @@ -453,6 +498,8 @@ static int quad8_set_quadrature_mode(struct iio_dev *=
indio_dev,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -480,15 +527,20 @@ static int quad8_set_index_polarity(struct iio_dev =
*indio_dev,
>  	const struct iio_chan_spec *chan, unsigned int index_polarity)
>  {
>  	struct quad8_iio *const priv =3D iio_priv(indio_dev);
> -	const unsigned int idr_cfg =3D priv->synchronous_mode[chan->channel] |
> -		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> +	unsigned int idr_cfg =3D index_polarity << 1;
> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg |=3D priv->synchronous_mode[chan->channel];
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
> @@ -589,7 +641,7 @@ static int quad8_signal_read(struct counter_device *c=
ounter,
>  static int quad8_count_read(struct counter_device *counter,
>  	struct counter_count *count, unsigned long *val)
>  {
> -	const struct quad8_iio *const priv =3D counter->priv;
> +	struct quad8_iio *const priv =3D counter->priv;
>  	const int base_offset =3D priv->base + 2 * count->id;
>  	unsigned int flags;
>  	unsigned int borrow;
> @@ -603,6 +655,8 @@ static int quad8_count_read(struct counter_device *co=
unter,
>  	/* Borrow XOR Carry effectively doubles count range */
>  	*val =3D (unsigned long)(borrow ^ carry) << 24;
> =20
> +	spin_lock(&priv->lock);
> +
>  	/* Reset Byte Pointer; transfer Counter to Output Latch */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
>  	     base_offset + 1);
> @@ -610,13 +664,15 @@ static int quad8_count_read(struct counter_device *=
counter,
>  	for (i =3D 0; i < 3; i++)
>  		*val |=3D (unsigned long)inb(base_offset) << (8 * i);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
>  static int quad8_count_write(struct counter_device *counter,
>  	struct counter_count *count, unsigned long val)
>  {
> -	const struct quad8_iio *const priv =3D counter->priv;
> +	struct quad8_iio *const priv =3D counter->priv;
>  	const int base_offset =3D priv->base + 2 * count->id;
>  	int i;
> =20
> @@ -624,6 +680,8 @@ static int quad8_count_write(struct counter_device *c=
ounter,
>  	if (val > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
>  	/* Reset Byte Pointer */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> =20
> @@ -647,6 +705,8 @@ static int quad8_count_write(struct counter_device *c=
ounter,
>  	/* Reset Error flag */
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -667,13 +727,13 @@ static enum counter_count_function quad8_count_func=
tions_list[] =3D {
>  static int quad8_function_get(struct counter_device *counter,
>  	struct counter_count *count, size_t *function)
>  {
> -	const struct quad8_iio *const priv =3D counter->priv;
> +	struct quad8_iio *const priv =3D counter->priv;
>  	const int id =3D count->id;
> -	const unsigned int quadrature_mode =3D priv->quadrature_mode[id];
> -	const unsigned int scale =3D priv->quadrature_scale[id];
> =20
> -	if (quadrature_mode)
> -		switch (scale) {
> +	spin_lock(&priv->lock);
> +
> +	if (priv->quadrature_mode[id])
> +		switch (priv->quadrature_scale[id]) {
>  		case 0:
>  			*function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
>  			break;
> @@ -687,6 +747,8 @@ static int quad8_function_get(struct counter_device *=
counter,
>  	else
>  		*function =3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -697,10 +759,15 @@ static int quad8_function_set(struct counter_device=
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
> @@ -736,6 +803,8 @@ static int quad8_function_set(struct counter_device *=
counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -852,15 +921,20 @@ static int quad8_index_polarity_set(struct counter_=
device *counter,
>  {
>  	struct quad8_iio *const priv =3D counter->priv;
>  	const size_t channel_id =3D signal->id - 16;
> -	const unsigned int idr_cfg =3D priv->synchronous_mode[channel_id] |
> -		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> +	unsigned int idr_cfg =3D index_polarity << 1;
> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg |=3D priv->synchronous_mode[channel_id];
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
> @@ -887,19 +961,26 @@ static int quad8_synchronous_mode_set(struct counte=
r_device *counter,
>  {
>  	struct quad8_iio *const priv =3D counter->priv;
>  	const size_t channel_id =3D signal->id - 16;
> -	const unsigned int idr_cfg =3D synchronous_mode |
> -		priv->index_polarity[channel_id] << 1;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> +	unsigned int idr_cfg =3D synchronous_mode;
> +
> +	spin_lock(&priv->lock);
> +
> +	idr_cfg |=3D priv->index_polarity[channel_id] << 1;
> =20
>  	/* Index function must be non-synchronous in non-quadrature mode */
> -	if (synchronous_mode && !priv->quadrature_mode[channel_id])
> +	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
> +		spin_unlock(&priv->lock);
>  		return -EINVAL;
> +	}
> =20
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
> @@ -964,6 +1045,8 @@ static int quad8_count_mode_set(struct counter_devic=
e *counter,
>  		break;
>  	}
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[count->id] =3D cnt_mode;
> =20
>  	/* Set count mode configuration value */
> @@ -976,6 +1059,8 @@ static int quad8_count_mode_set(struct counter_devic=
e *counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -1017,6 +1102,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	if (err)
>  		return err;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->ab_enable[count->id] =3D ab_enable;
> =20
>  	ior_cfg =3D ab_enable | priv->preset_enable[count->id] << 1;
> @@ -1024,6 +1111,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	/* Load I/O control configuration */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1052,14 +1141,28 @@ static ssize_t quad8_count_preset_read(struct cou=
nter_device *counter,
>  	return sprintf(buf, "%u\n", priv->preset[count->id]);
>  }
> =20
> +void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
> +		unsigned int preset)
> +{
> +	const unsigned int base_offset =3D quad8iio->base + 2 * id;
> +	int i;
> +
> +	quad8iio->preset[id] =3D preset;
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
>  	struct quad8_iio *const priv =3D counter->priv;
> -	const int base_offset =3D priv->base + 2 * count->id;
>  	unsigned int preset;
>  	int ret;
> -	int i;
> =20
>  	ret =3D kstrtouint(buf, 0, &preset);
>  	if (ret)
> @@ -1069,14 +1172,11 @@ static ssize_t quad8_count_preset_write(struct co=
unter_device *counter,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> -	priv->preset[count->id] =3D preset;
> +	spin_lock(&priv->lock);
> =20
> -	/* Reset Byte Pointer */
> -	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
> +	quad8_preset_register_set(priv, count->id, preset);
> =20
> -	/* Set Preset Register */
> -	for (i =3D 0; i < 3; i++)
> -		outb(preset >> (8 * i), base_offset);
> +	spin_unlock(&priv->lock);
> =20
>  	return len;
>  }
> @@ -1084,15 +1184,20 @@ static ssize_t quad8_count_preset_write(struct co=
unter_device *counter,
>  static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
>  	struct counter_count *count, void *private, char *buf)
>  {
> -	const struct quad8_iio *const priv =3D counter->priv;
> +	struct quad8_iio *const priv =3D counter->priv;
> +
> +	spin_lock(&priv->lock);
> =20
>  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
>  	switch (priv->count_mode[count->id]) {
>  	case 1:
>  	case 3:
> -		return quad8_count_preset_read(counter, count, private, buf);
> +		spin_unlock(&priv->lock);
> +		return sprintf(buf, "%u\n", priv->preset[count->id]);
>  	}
> =20
> +	spin_unlock(&priv->lock);
> +
>  	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
>  	return sprintf(buf, "33554431\n");
>  }
> @@ -1101,15 +1206,29 @@ static ssize_t quad8_count_ceiling_write(struct c=
ounter_device *counter,
>  	struct counter_count *count, void *private, const char *buf, size_t len)
>  {
>  	struct quad8_iio *const priv =3D counter->priv;
> +	unsigned int ceiling;
> +	int ret;
> +
> +	ret =3D kstrtouint(buf, 0, &ceiling);
> +	if (ret)
> +		return ret;
> +
> +	/* Only 24-bit values are supported */
> +	if (ceiling > 0xFFFFFF)
> +		return -EINVAL;
> +
> +	spin_lock(&priv->lock);
> =20
>  	/* Range Limit and Modulo-N count modes use preset value as ceiling */
>  	switch (priv->count_mode[count->id]) {
>  	case 1:
>  	case 3:
> -		return quad8_count_preset_write(counter, count, private, buf,
> -						len);
> +		quad8_preset_register_set(priv, count->id, ceiling);
> +		break;
>  	}
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1137,6 +1256,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
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
> @@ -1144,6 +1265,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
ct counter_device *counter,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1429,6 +1552,9 @@ static int quad8_probe(struct device *dev, unsigned=
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

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5rueoACgkQhvpINdm7
VJL4Hg//aZuwJR5vA8szWlkLcmHVB5z0Hy1/oc2bO71g1Y9+8nsegV/Nt3M8NCmn
Y8LLsezFw2EPgke3lC12CK2wr2wvavc2b38qJrt54ObpRkxCK4Dy4uMTw/IQWhir
y3jkauBDZlREShcZaWmRD3k4nCqZov2DwHYA8ZiKdu33ybmkXavAFfpDeqcXHSxc
xpUzyYvOibXGNcVr2sbi57OzcFsk+/13CXWlMdtH+LNQ6dvpBibaewQWFsj/b1Zf
OA0mprzoY1CcfrAZAF1ccJfOgqATZNbmZhbPB7N/pqx3+QbVO3Lk3GiOcFDiOKoj
tCeVgUy9tA3jYrquanQ42F8/s5ijvoNY5DXX/cPBcdvOo7qLeMIGq0h3K0yNN5yW
VFsoJ8C06DGf80tig1UpIUNg/zBavZKrE9JcqVZBTsz7EjpfeMWtaIz97j1VhWWC
obZz1ioSMb+canfYY0edpNn1ppHPaCs7PW03IRwoDV1kDHmOR2Nn+/3CJdmbsm5q
V0Pb1ATsgyQWbdCgXYiUlHHJBsuRnnhLjSa/jgxmznkDCiVVmsMThkK9/ihVSbMa
/qYIH3CU0IiUrbYzFsKVHiMMueCYED5SpoVAmVxM+BnepGzYKM8xTH2vOIJCe9a6
IKu39cXtHep+2zJQXzw2WKeSuLES990bRmpZRm8sF3KB/1FS1Go=
=WQmp
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
