Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09EE43C43D
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 09:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhJ0Hqq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbhJ0Hqp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Oct 2021 03:46:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE42C061570;
        Wed, 27 Oct 2021 00:44:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y1so1386492plk.10;
        Wed, 27 Oct 2021 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7yBjvb8gdUvVQO2RKt++HyAZN7mrz/1bd0Px+r1tJak=;
        b=cmpkLj/zIQh9O4c6RKKl5Xr3idAVFG0jnom5exVTucZ7W9cmCvu5GpQ2YXHIQhdIf2
         hnhsHGzF36F8ZBJpa8FdkK2f3ndUag8BHjw3TgT0OjMKwpL6i/qDtY9W4rnCZFELi0ch
         p4dwOdHA5iYG2mrJAB/tg7ft7xL2DtgoEfmxiKX5am79ocDA+vUjUpSCi40d7C+ayA3Q
         XWpiaMnoRthEKOt79Wr2jJk06zvI4g9qocTC7Kv03d26JiL1LODPLK56qffW44yvWNh2
         hssR5YPso9KFW+eaGdr7+sgilng59Ev04kedpL7tbJzxatLkxAmvkeOf4CAca7Nirt9q
         j61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7yBjvb8gdUvVQO2RKt++HyAZN7mrz/1bd0Px+r1tJak=;
        b=IhzA0lmSDzdZyZ9jzDWVbAGgmBfz7nedF9hUcVdF/K1uwqZqfiwn7rYHd1KsdxuQU4
         qOwJKR/f5jT9PY+WnYRiymKeAmFTaxCL22wdQpS2ST7Or8q9p3Sf81ONS5ZBEPjFgImx
         chO1gYaaLmcxDwfIC6WpzSF/o1JQUIXBvLocIrGjUuUqGDjwGZCQaR7EgD9Cq2CyhDZF
         wb9g0MzXbUHQsEJxNjVOUnVWCJerk7/6hLbA6JPHo/eEHdkj4edJVGTHblju0wP25wkW
         g7FArvuQJuN+hw+J1WdOJWO0Ufjii6Q6SpesBsMOCK2Q9B3kFaNiIif6g85w4VwzorhK
         2j6A==
X-Gm-Message-State: AOAM532XHoOr/e4qb6Gf0b4H6C1eZjmnEquR5bVv57xk6WMWSPesUghx
        vh3YU7+CCUsyDj3Yojzf8Qk=
X-Google-Smtp-Source: ABdhPJyGnk2EsP4V+wEC/UzgU1c9o+qWav5CfgGqwO4jXWogcqZyhfgC6F0KFZSw999gfC3TuJFztw==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr4277450pjb.0.1635320660455;
        Wed, 27 Oct 2021 00:44:20 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id z124sm26242465pfb.108.2021.10.27.00.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:44:19 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:44:15 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] counter/ti-eqep: add support for latched position
Message-ID: <YXkDT2gaFfdIsgTQ@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-6-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oo+GcfNM/KI+dHM6"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-6-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oo+GcfNM/KI+dHM6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:40PM -0500, David Lechner wrote:
> This adds support to the TI eQEP counter driver for a latched position.
> This is a new extension that gets the counter count that was recorded
> when an event was triggered. A new device-level latch_mode attribute is
> added to select the trigger. Edge capture unit support will be needed
> to make full use of this, but "Unit timeout" mode can already be used
> to calculate high speeds.
>=20
> The unit timer could also have attributes for latched_time and
> latched_period that use the same trigger. However this is not a use
> case at this time, so they can be added later if needed.

I see that "latched_count" holds the captured counter count; would this
"latched_time" hold the captured unit timer time? If so, does that mean
setting the latch mode to "Unit timeout" always results in a
"latched_time" equal to 0 (assuming that's when the timeout event
triggers)?

>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/counter/ti-eqep.c | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 1ba7f3c7cb7e..ef899655ad1d 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -405,12 +405,28 @@ static int ti_eqep_direction_read(struct counter_de=
vice *counter,
>  	return 0;
>  }
> =20
> +static int ti_eqep_position_latched_count_read(struct counter_device *co=
unter,
> +					       struct counter_count *count,
> +					       u64 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qposlat;
> +
> +	regmap_read(priv->regmap32, QPOSLAT, &qposlat);
> +
> +	*value =3D qposlat;
> +
> +	return 0;
> +}
> +
>  static struct counter_comp ti_eqep_position_ext[] =3D {
>  	COUNTER_COMP_CEILING(ti_eqep_position_ceiling_read,
>  			     ti_eqep_position_ceiling_write),
>  	COUNTER_COMP_ENABLE(ti_eqep_position_enable_read,
>  			    ti_eqep_position_enable_write),
>  	COUNTER_COMP_DIRECTION(ti_eqep_direction_read),
> +	COUNTER_COMP_COUNT_U64("latched_count",
> +			       ti_eqep_position_latched_count_read, NULL),
>  };
> =20
>  static struct counter_signal ti_eqep_signals[] =3D {
> @@ -463,6 +479,38 @@ static struct counter_count ti_eqep_counts[] =3D {
>  	},
>  };
> =20
> +static int ti_eqep_latch_mode_read(struct counter_device *counter,
> +					    u32 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qepctl;
> +
> +	regmap_read(priv->regmap16, QEPCTL, &qepctl);
> +	*value =3D !!(qepctl & QEPCTL_QCLM);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_latch_mode_write(struct counter_device *counter,
> +					     u32 value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +
> +	if (value)
> +		regmap_set_bits(priv->regmap16, QEPCTL, QEPCTL_QCLM);
> +	else
> +		regmap_clear_bits(priv->regmap16, QEPCTL, QEPCTL_QCLM);
> +
> +	return 0;
> +}
> +
> +static const char *const ti_eqep_latch_mode_names[] =3D {
> +	"Read count",
> +	"Unit timeout",
> +};
> +
> +static DEFINE_COUNTER_ENUM(ti_eqep_latch_modes, ti_eqep_latch_mode_names=
);
> +
>  static int ti_eqep_unit_timer_time_read(struct counter_device *counter,
>  				       u64 *value)
>  {
> @@ -553,6 +601,8 @@ static int ti_eqep_unit_timer_enable_write(struct cou=
nter_device *counter,
>  }
> =20
>  static struct counter_comp ti_eqep_device_ext[] =3D {
> +	COUNTER_COMP_DEVICE_ENUM("latch_mode", ti_eqep_latch_mode_read,
> +				ti_eqep_latch_mode_write, ti_eqep_latch_modes),

It seems more appropriate to move this alongside "latched_count" as
Count extension because this is setting the trigger mode to latch the
respective Count's count. Or does this particular extension also affect
the "latched_time" capture for the unit timer?

William Breathitt Gray

>  	COUNTER_COMP_DEVICE_U64("unit_timer_time", ti_eqep_unit_timer_time_read,
>  				ti_eqep_unit_timer_time_write),
>  	COUNTER_COMP_DEVICE_U64("unit_timer_period",
> --=20
> 2.25.1
>=20

--oo+GcfNM/KI+dHM6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF5AzoACgkQhvpINdm7
VJLgGQ//T/av+naaP5b2gfHOqXf8cEcfqKkcjA+rzE8Jr/JOOULRM6C/8mzjnJ4M
d3JQfY3QbmcC5E14+zjEAgIfR48vrj9MlC53/vaD8uc6Z0JYBo55BVsA4oWGF4pz
joPNrEgN6RSGxuvgDZKXXWDi7DznLfzUhxOevGxJdAgCxHFFUNcwGTChrR4rGnje
OlEvf2D4AVbccAOzxkKwfmcEYaOwO0/LtfoMbDwmskCU8EUxo/Mpl1JklNN90QTB
8BBd1ntPEhYxnJ1PDYVgjBoOdXXG1WY0bsmANRafHEfm9viG1szOmnMmBPVY9tG8
SRpZctjB1kR3novzC9LQEB0Nxor41bVOxvkV2rV8TJ1DzO5poLQFHc1cmX5atXew
ZhMZg/JQCRUKaz6t22XziMMQIq4Vnc4BMPr+TCogW8LC7dOi573U73lfvATpcD57
BA8LRvA/R4GheuQuNPYA5ADRQP/PJtGq/htIILoKAJi6Icfl+fF9mNvN2Pxw9wZK
5+Y17c6l6wdzsoITKhmtZNr9HUIAm3TSS/JdFJZwxnI69XL3wpxThT0KE/NnX8aZ
REEB43sRWWu92xgN5Bi5YktA6uMdjC9IHfwITmLyLnOtDbViv04AHNuZefpwVFwj
fjoWfFnjwXlgg3g25rcOkUD+twNthvtEibL8sjy0XYXlcWorskw=
=u0gb
-----END PGP SIGNATURE-----

--oo+GcfNM/KI+dHM6--
