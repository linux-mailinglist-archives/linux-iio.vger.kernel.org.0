Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28717D425
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgCHOUX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 10:20:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40989 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCHOUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2020 10:20:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id p124so7382327ywc.8;
        Sun, 08 Mar 2020 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rAsLHqPreOnhAfPS+oKwEvJYPIKXeMjXEPoenF6HAzI=;
        b=g7ivLGK0lHANApPHXOvWxqrQOw2et5PWP7YXzEMay81Zixnhp4j0AOWV257b26jX/L
         pBJZs7lf8F04VdoLJ43yKYw3vurpjJ7IFhNPDOWRob7hzEjNibYAXXJku0zLkVOuHATn
         Iw9dqVykpvB/PB/KeJHeRBgkU9Zs76PblAo9Negew8h3RzhJAy6BKV1iwPIsHF2A1uUp
         FUYb+Kzsdyjf9VaCsugMUCizfU4kpDABK/kjxS/TN5nwVgtwd18ZWEEC6qQi76LkTU+l
         SJKhxk2yoGn9Z7OadT9GFlFRlZNwhGmECkWaEr9Dnn6KTQ4yiJfx1R7Cjml+VStmLJ84
         W9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rAsLHqPreOnhAfPS+oKwEvJYPIKXeMjXEPoenF6HAzI=;
        b=DzVbRFvpuBAjUgqxuDtVLzjB1h8iXisvUho1GCaSMnC9wDDQezV++Wy7AnEgnnQSHw
         CLiIrkYXlAJNsi59Xg9NZS0x/nHvFDCT1227YJ+YDLGWZYCTmHavPSQD9Rm6GhBPs+CE
         bxnMIdj9CZbDQgT65lmA644UBADKJfgFktdTop5xtoZYRjVQat7Tk7kmDUKjbcm11ecL
         FRvnvZ50YO86TcKM2msDZlH9i+zKALDwDmALs23gF1N3soKW0aWfjtFvaDV87YaZw8Tq
         xlfiZ1gvz+jJXddBnIPN2LQtuLJPn/eOT3YRiaCKw8bZ6xLPcE5G31x/QnfEu95quzh0
         6avw==
X-Gm-Message-State: ANhLgQ1otkqVOC4lpRExX5rHaJsVj6dPnWrg4BtrRxVX53fiuG/OGwdS
        tKoWzP6QE5RzYpr7CspTG90=
X-Google-Smtp-Source: ADFU+vv2TwPyBA5D5RbQUrD6fN2bkxVR8ml5wiEuvKaG6AfU5e4W3M/Ggch6lQsTKkQscyWY06Yq2Q==
X-Received: by 2002:a81:a045:: with SMTP id x66mr13278536ywg.45.1583677220301;
        Sun, 08 Mar 2020 07:20:20 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id h139sm16343194ywa.35.2020.03.08.07.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 07:20:19 -0700 (PDT)
Date:   Sun, 8 Mar 2020 10:20:17 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Syed Waris <syednwaris@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Testing: counter: 104-quad-8.c: Added lock protection
Message-ID: <20200308142017.GB3400@icarus>
References: <20200308104101.GA18548@syed.domain.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20200308104101.GA18548@syed.domain.name>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 08, 2020 at 04:11:01PM +0530, Syed Waris wrote:
> Added protection for quad8_iio configurations from race conditions in
> the 104-quad-8 counter driver. There are no IRQs, used spin-locks for
> protection.
>=20
> Signed-off-by: Syed Waris <syednwaris@gmail.com>

Hi Syed,

Thank you for your submission. I have some changes that should be made
to this patch before we accept it.

When you write a commit message and title, keep it in the present tense;
you can also remove the "Testing: " portion of the title since it's not
needed:

	counter: 104-quad-8: Add lock protection
=09
	Add protection for quad8_iio configurations from race conditions
	in the 104-quad-8 counter driver. There is no IRQ handling so
	spin_lock calls are used for protection.

As for the code changes in this patch, it will be good to protect all
the port I/O calls (outb/inb) in this driver in addition to the
quad8_iio configurations. The reason is that ACCES 104-QUAD-8 devices
use a byte pointer register to coordinate access to the data registers,
so these register states should be kept locked so that they are not
corrupted while accessing and modifying data on the device.

William Breathitt Gray

> ---
>  drivers/counter/104-quad-8.c | 61 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 0cfc813..cd8e09f 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -43,6 +43,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses=
");
>   */
>  struct quad8_iio {
>  	struct counter_device counter;
> +	spinlock_t lock;
>  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
>  	unsigned int count_mode[QUAD8_NUM_COUNTERS];
> @@ -185,6 +186,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		if (val < 0 || val > 1)
>  			return -EINVAL;
> =20
> +		spin_lock(&priv->lock);
> +
>  		priv->ab_enable[chan->channel] =3D val;
> =20
>  		ior_cfg =3D val | priv->preset_enable[chan->channel] << 1;
> @@ -192,6 +195,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
>  		/* Load I/O control configuration */
>  		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> =20
> +		spin_unlock(&priv->lock);
> +
>  		return 0;
>  	case IIO_CHAN_INFO_SCALE:
>  		/* Quadrature scaling only available in quadrature mode */
> @@ -251,6 +256,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset[chan->channel] =3D preset;
> =20
>  	/* Reset Byte Pointer */
> @@ -260,6 +267,8 @@ static ssize_t quad8_write_preset(struct iio_dev *ind=
io_dev, uintptr_t private,
>  	for (i =3D 0; i < 3; i++)
>  		outb(preset >> (8 * i), base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -289,6 +298,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Preset enable is active low in Input/Output Control register */
>  	preset_enable =3D !preset_enable;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset_enable[chan->channel] =3D preset_enable;
> =20
>  	ior_cfg =3D priv->ab_enable[chan->channel] |
> @@ -297,6 +308,8 @@ static ssize_t quad8_write_set_to_preset_on_index(str=
uct iio_dev *indio_dev,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -354,6 +367,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	unsigned int mode_cfg =3D cnt_mode << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[chan->channel] =3D cnt_mode;
> =20
>  	/* Add quadrature mode configuration */
> @@ -363,6 +378,8 @@ static int quad8_set_count_mode(struct iio_dev *indio=
_dev,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -398,11 +415,15 @@ static int quad8_set_synchronous_mode(struct iio_de=
v *indio_dev,
>  	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
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
> @@ -444,11 +465,15 @@ static int quad8_set_quadrature_mode(struct iio_dev=
 *indio_dev,
>  			quad8_set_synchronous_mode(indio_dev, chan, 0);
>  	}
> =20
> +	spin_lock(&priv->lock);
> +
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
> @@ -480,11 +505,15 @@ static int quad8_set_index_polarity(struct iio_dev =
*indio_dev,
>  		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * chan->channel + 1;
> =20
> +	spin_lock(&priv->lock);
> +
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
> @@ -852,11 +881,15 @@ static int quad8_index_polarity_set(struct counter_=
device *counter,
>  		index_polarity << 1;
>  	const int base_offset =3D priv->base + 2 * channel_id + 1;
> =20
> +	spin_lock(&priv->lock);
> +
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
> @@ -891,11 +924,15 @@ static int quad8_synchronous_mode_set(struct counte=
r_device *counter,
>  	if (synchronous_mode && !priv->quadrature_mode[channel_id])
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
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
> @@ -960,6 +997,8 @@ static int quad8_count_mode_set(struct counter_device=
 *counter,
>  		break;
>  	}
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->count_mode[count->id] =3D cnt_mode;
> =20
>  	/* Set count mode configuration value */
> @@ -972,6 +1011,8 @@ static int quad8_count_mode_set(struct counter_devic=
e *counter,
>  	/* Load mode configuration to Counter Mode Register */
>  	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return 0;
>  }
> =20
> @@ -1013,6 +1054,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	if (err)
>  		return err;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->ab_enable[count->id] =3D ab_enable;
> =20
>  	ior_cfg =3D ab_enable | priv->preset_enable[count->id] << 1;
> @@ -1020,6 +1063,8 @@ static ssize_t quad8_count_enable_write(struct coun=
ter_device *counter,
>  	/* Load I/O control configuration */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1065,6 +1110,8 @@ static ssize_t quad8_count_preset_write(struct coun=
ter_device *counter,
>  	if (preset > 0xFFFFFF)
>  		return -EINVAL;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->preset[count->id] =3D preset;
> =20
>  	/* Reset Byte Pointer */
> @@ -1074,6 +1121,8 @@ static ssize_t quad8_count_preset_write(struct coun=
ter_device *counter,
>  	for (i =3D 0; i < 3; i++)
>  		outb(preset >> (8 * i), base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1133,6 +1182,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
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
> @@ -1140,6 +1191,8 @@ static ssize_t quad8_count_preset_enable_write(stru=
ct counter_device *counter,
>  	/* Load I/O control configuration to Input / Output Control Register */
>  	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1166,6 +1219,8 @@ static ssize_t quad8_signal_fck_prescaler_write(str=
uct counter_device *counter,
>  	if (ret)
>  		return ret;
> =20
> +	spin_lock(&priv->lock);
> +
>  	priv->fck_prescaler[channel_id] =3D prescaler;
> =20
>  	/* Reset Byte Pointer */
> @@ -1176,6 +1231,8 @@ static ssize_t quad8_signal_fck_prescaler_write(str=
uct counter_device *counter,
>  	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
>  	     base_offset + 1);
> =20
> +	spin_unlock(&priv->lock);
> +
>  	return len;
>  }
> =20
> @@ -1383,6 +1440,10 @@ static int quad8_probe(struct device *dev, unsigne=
d int id)
>  		/* Disable index function; negative index polarity */
>  		outb(QUAD8_CTR_IDR, base_offset + 1);
>  	}
> +
> +	/* Initialize the spin lock */
> +	spin_lock_init(&quad8iio->lock);
> +
>  	/* Enable all counters */
>  	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
> =20
> --=20
> 2.7.4
>=20

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl5k/yEACgkQhvpINdm7
VJJ2ehAAn835tYYdn8UdnBX8emAOErlT08y3AgLsUEmM9KaojRCEDqkWOm/9tHd2
LjgCukWdQW/QG4Rk2ydihGzZ90Xhou3pB+HAkllEyipsweDxkwQ2ijwYd1k1Wmzi
u7cHO8Eti9YzKXdFj9OgnCnN99LROb2JZ5kS8jZfwtaHaIKietU4PvIPjZOqNZN7
hKjae5G/n0N+gFMtnavDX/wJIsb7bFQIf6puZ3e2V3IBqQktcWxH5WM8k0vzUR2T
4AMxBumS1pdUZp+rJJVb1P0xm2xgXTrA+OKnZjy47WAf9GPRvfxOQAu3xMFYZTFN
/RSTTy+/84yKBuXZBs6JvSaaA2GdMvTB6iF71efJ9e9qcH75PJMgjPPjftRG/+g/
23Rl8KKx038Mc7ZD+sXcvl50ZPk0eWcXn/AU+bCpt/6ClJ4Qs25lqcj4tTpbWf1M
uzB1oUgQNzbIQU88BeP7yeJJme2CC1n2KD0y4vEIxEMJoY1650AREVt9rkbm+EzF
deXOvGCGb0/aCyw0z7MuAUUxO9gRhyZCFaTDxpHEKgMw4nfuQwArS+Uw4T/S+C90
0sOjGHA2poMy1V4mtn8uq9uPSd4cC+ETK/yjImUk5UsR8NcGasnAuLBE+7/JKQQP
Pcj9NiwZ0QE8L4zvZEUOVgITga6E824vdA2bgSH+gkFw7qCVy4E=
=05tD
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
