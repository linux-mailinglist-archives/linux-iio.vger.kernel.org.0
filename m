Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9694391B3
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 10:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhJYIua (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhJYIu3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 04:50:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6228C061745;
        Mon, 25 Oct 2021 01:48:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d5so10112434pfu.1;
        Mon, 25 Oct 2021 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SOJlnCiZSupKP9SIJKepHt2o7XplreuRDHmKrfzEaXA=;
        b=jWEUBCaD7n7CuWDEyLCxrHE0Htj/hDftJUtaTbd1Gj6vcN7RMgvnaU/7Tbo3Lq2Qg9
         ytu7RRwU+Aqhkzh9xyw2Czb1J1U1koR7T9fp/tmPxQmacTXdMvLalpzYh+f5e5j0DXb9
         uf5aBuBfge0Dac2yazYtbI1D5jUMyA7PTo/8YMifSbhcB30hDzPOV79VuCUvGWW9sJ1e
         qxk1rVPDLEmHCpXbENtgWqV3gu4XjyRown+0WJgZPS73pEQI5S2oBIVsZjtLVBKbhgmo
         sl13OBMtIdP1PrkgLlS92j8VSr7GKztKZOslAtOTqMWSR2VcjUPx8HHm8rCT2wZ3mbRJ
         jxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SOJlnCiZSupKP9SIJKepHt2o7XplreuRDHmKrfzEaXA=;
        b=nz1+cP/gNPWGEpdxEAA4YKMqTGRemaR9PYAd/kcKy5Fo4SwsHJYZItEv/JlGbJU8Wo
         aGAHy/AX0YTZs5T76CZANXT7239H+daaI2RCJ5XnJuXA6uglQSrkLL1Tzw/ZZBkpgTgl
         1q67eNorXElcC8knJsv9nwOOSYtphHj4Kg7UG5l8y2xExQF7WHIKTPoUPvhZ1k2qSlaS
         4Rx3F+vNDa2GZ+3kPc43gOIOVA1NvR9J+TzQIJSIltxwZp32MFfvR6snE6pQRnkFW78I
         TxOzF0a08Urk17XU0ON2UTrO7MOcHXnmqL0Qn+JxP0yl0x/RoMcL0GtvQi8Bc0lOdq/Y
         LyLA==
X-Gm-Message-State: AOAM530TCHfgXEioG68Mc2taUknQfsYxZtN9w7ljBlrvvk7KpXmNvXAF
        pleHSmsaJtCS3p1U5x43BEgnOnx4100=
X-Google-Smtp-Source: ABdhPJyZ3l2NTn9GmAojkuhItDdVWIz+/WmKjyz2mzB9uZiy3oABR2RyQEN9n6OGvLr5ZmTYkYbq3Q==
X-Received: by 2002:a63:7445:: with SMTP id e5mr1441728pgn.482.1635151687255;
        Mon, 25 Oct 2021 01:48:07 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id s13sm20578477pfk.175.2021.10.25.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 01:48:06 -0700 (PDT)
Date:   Mon, 25 Oct 2021 17:48:01 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] counter/ti-eqep: add support for unit timer
Message-ID: <YXZvQSU6bRRaWD89@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-4-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d71MlQyvtsLzRQ2B"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-4-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--d71MlQyvtsLzRQ2B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:38PM -0500, David Lechner wrote:
> This adds support to the TI eQEP counter driver for the Unit Timer.
> The Unit Timer is a device-level extension that provides a timer to be
> used for speed calculations. The sysfs interface for the Unit Timer is
> new and will be documented in a later commit. It contains a R/W time
> attribute for the current time, a R/W period attribute for the timeout
> period and a R/W enable attribute to start/stop the timer. It also
> implements a timeout event on the chrdev interface that is triggered
> each time the period timeout is reached.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

I'll comment on the sysfs interface in the respective docs patch. Some
comments regarding this patch below.

> ---
>  drivers/counter/ti-eqep.c    | 132 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/counter.h |   2 +
>  2 files changed, 133 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 9881e5115da6..a4a5a4486329 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/counter.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -131,6 +132,7 @@ enum ti_eqep_count_func {
> =20
>  struct ti_eqep_cnt {
>  	struct counter_device counter;
> +	unsigned long sysclkout_rate;
>  	struct regmap *regmap32;
>  	struct regmap *regmap16;
>  };
> @@ -298,6 +300,9 @@ static int ti_eqep_events_configure(struct counter_de=
vice *counter)
>  		case COUNTER_EVENT_DIRECTION_CHANGE:
>  			qeint |=3D QEINT_QDC;
>  			break;
> +		case COUNTER_EVENT_TIMEOUT:
> +			qeint |=3D QEINT_UTO;
> +			break;
>  		}
>  	}
> =20
> @@ -311,6 +316,7 @@ static int ti_eqep_watch_validate(struct counter_devi=
ce *counter,
>  	case COUNTER_EVENT_OVERFLOW:
>  	case COUNTER_EVENT_UNDERFLOW:
>  	case COUNTER_EVENT_DIRECTION_CHANGE:
> +	case COUNTER_EVENT_TIMEOUT:
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -457,6 +463,106 @@ static struct counter_count ti_eqep_counts[] =3D {
>  	},
>  };
> =20
> +static int ti_eqep_unit_timer_time_read(struct counter_device *counter,
> +				       u64 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qutmr;
> +
> +	regmap_read(priv->regmap32, QUTMR, &qutmr);
> +
> +	/* convert timer ticks to nanoseconds */
> +	*value =3D mul_u64_u32_div(qutmr, NSEC_PER_SEC, priv->sysclkout_rate);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_unit_timer_time_write(struct counter_device *counter,
> +					u64 value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qutmr;
> +
> +	/* convert nanoseconds to timer ticks */
> +	qutmr =3D value =3D mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_P=
ER_SEC);
> +	if (qutmr !=3D value)
> +		return -ERANGE;
> +
> +	regmap_write(priv->regmap32, QUTMR, qutmr);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_unit_timer_period_read(struct counter_device *counter,
> +					  u64 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 quprd;
> +
> +	regmap_read(priv->regmap32, QUPRD, &quprd);
> +
> +	/* convert timer ticks to nanoseconds */
> +	*value =3D mul_u64_u32_div(quprd, NSEC_PER_SEC, priv->sysclkout_rate);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_unit_timer_period_write(struct counter_device *counte=
r,
> +					   u64 value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 quprd;
> +
> +	/* convert nanoseconds to timer ticks */
> +	quprd =3D value =3D mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_P=
ER_SEC);
> +	if (quprd !=3D value)
> +		return -ERANGE;
> +
> +	/* protect against infinite unit timeout interrupts */
> +	if (quprd =3D=3D 0)
> +		return -EINVAL;

I doubt there's any practical reason for a user to set the timer period
to 0, but perhaps we should not try to protect users from themselves
here. It's very obvious and expected that setting the timer period to 0
results in timeouts as quickly as possible, so really the user should be
left to reap the fruits of their decision regardless of how asinine that
decision is.

> +
> +	regmap_write(priv->regmap32, QUPRD, quprd);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_unit_timer_enable_read(struct counter_device *counter,
> +					  u8 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qepctl;
> +
> +	regmap_read(priv->regmap16, QEPCTL, &qepctl);
> +	*value =3D !!(qepctl & QEPCTL_UTE);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_unit_timer_enable_write(struct counter_device *counte=
r,
> +					   u8 value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +
> +	if (value)
> +		regmap_set_bits(priv->regmap16, QEPCTL, QEPCTL_UTE);
> +	else
> +		regmap_clear_bits(priv->regmap16, QEPCTL, QEPCTL_UTE);
> +
> +	return 0;
> +}
> +
> +static struct counter_comp ti_eqep_device_ext[] =3D {
> +	COUNTER_COMP_DEVICE_U64("unit_timer_time", ti_eqep_unit_timer_time_read,
> +				ti_eqep_unit_timer_time_write),
> +	COUNTER_COMP_DEVICE_U64("unit_timer_period",
> +				ti_eqep_unit_timer_period_read,
> +				ti_eqep_unit_timer_period_write),
> +	COUNTER_COMP_DEVICE_BOOL("unit_timer_enable",
> +				 ti_eqep_unit_timer_enable_read,
> +				 ti_eqep_unit_timer_enable_write),
> +};
> +
>  static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
>  {
>  	struct ti_eqep_cnt *priv =3D dev_id;
> @@ -474,6 +580,8 @@ static irqreturn_t ti_eqep_irq_handler(int irq, void =
*dev_id)
>  	if (qflg & QFLG_QDC)
>  		counter_push_event(counter, COUNTER_EVENT_DIRECTION_CHANGE, 0);
> =20
> +	if (qflg & QFLG_UTO)
> +		counter_push_event(counter, COUNTER_EVENT_TIMEOUT, 0);
> =20
>  	regmap_set_bits(priv->regmap16, QCLR, ~0);

Same comment here as the previous patches about clearing all interrupt
flags.

> =20
> @@ -500,6 +608,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct ti_eqep_cnt *priv;
> +	struct clk *clk;
>  	void __iomem *base;
>  	int err;
>  	int irq;
> @@ -508,6 +617,24 @@ static int ti_eqep_probe(struct platform_device *pde=
v)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> +	clk =3D devm_clk_get(dev, "sysclkout");
> +	if (IS_ERR(clk)) {
> +		if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to get sysclkout");
> +		return PTR_ERR(clk);
> +	}
> +
> +	priv->sysclkout_rate =3D clk_get_rate(clk);
> +	if (priv->sysclkout_rate =3D=3D 0) {
> +		dev_err(dev, "failed to get sysclkout rate");
> +		/* prevent divide by zero */
> +		priv->sysclkout_rate =3D 1;
> +		/*
> +		 * This error is not expected and the driver is mostly usable
> +		 * without clock rate anyway, so don't exit here.
> +		 */

If the values for these new attributes are expected to be denominated in
nanoseconds then we must guarantee that. You should certainly error out
here if you can't guarantee such.

Alternatively, you could provide an additional set of attributes that
are denominated in units of raw timer ticks rather than nanoseconds.
That way if you can't determine the clock rate you can simply have the
nanosecond-denominated timer attributes return an EOPNOTSUPP error code
or similar while still providing users with the raw timer ticks
attributes.

William Breathitt Gray

> +	}
> +
>  	base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -536,6 +663,8 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	priv->counter.ops =3D &ti_eqep_counter_ops;
>  	priv->counter.counts =3D ti_eqep_counts;
>  	priv->counter.num_counts =3D ARRAY_SIZE(ti_eqep_counts);
> +	priv->counter.ext =3D ti_eqep_device_ext;
> +	priv->counter.num_ext =3D ARRAY_SIZE(ti_eqep_device_ext);
>  	priv->counter.signals =3D ti_eqep_signals;
>  	priv->counter.num_signals =3D ARRAY_SIZE(ti_eqep_signals);
>  	priv->counter.priv =3D priv;
> @@ -552,10 +681,11 @@ static int ti_eqep_probe(struct platform_device *pd=
ev)
> =20
>  	/*
>  	 * We can end up with an interupt infinite loop (interrupts triggered
> -	 * as soon as they are cleared) if we leave this at the default value
> +	 * as soon as they are cleared) if we leave these at the default value
>  	 * of 0 and events are enabled.
>  	 */
>  	regmap_write(priv->regmap32, QPOSMAX, UINT_MAX);
> +	regmap_write(priv->regmap32, QUPRD, UINT_MAX);
> =20
>  	err =3D counter_register(&priv->counter);
>  	if (err < 0) {
> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> index 36dd3b474d09..640d9719b88c 100644
> --- a/include/uapi/linux/counter.h
> +++ b/include/uapi/linux/counter.h
> @@ -63,6 +63,8 @@ enum counter_event_type {
>  	COUNTER_EVENT_INDEX,
>  	/* Direction change detected */
>  	COUNTER_EVENT_DIRECTION_CHANGE,
> +	/* Timer exceeded timeout */
> +	COUNTER_EVENT_TIMEOUT,
>  };
> =20
>  /**
> --=20
> 2.25.1
>=20

--d71MlQyvtsLzRQ2B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF2bywACgkQhvpINdm7
VJJ7tg//aDHVGj7iEDr8/ZT3fTBI6GpWrPtv2bQ6l7v7sbDNO7MK4GJla/7pBjIG
SapC+Ktkx1713X3rAbnw/t1ZIlneVtfWlCo7zq+WPGNOE12i4xsrrgb81AnvJD/7
3bmDZ9x3tBnmHKSGyYBGQCfSCM7sV3jjTuB4qxvaQY6OVDQR/M3C70VjZO3UWOe2
nyHthb/aG3x2H49hbalezOmlA+4Eqm0SZ0oxLvO7kSmOWjtqDrZSfMUaQgaQ9A+M
+yquD4+cq2CGQ3+RGXCr7T6eo5X/xWxXgb+UiEOn8F+4pd3o04SZGbqm44JiX5jF
9z1ZUAWy16NF3XJaa0UedkVXFMzaxWwS3S/ErXdYBBrZjNYTvw52nCOXkTxbV/DA
qTqemQy/d59mEjxNrsZI9kAgei9MqLn6wwAUM1txSFxPFI38hyJLbi4ScdVl568I
70t6DGQBTfRMCBCZIv15eD45JFPuulCqZZbUSLE0KJI+vObu8LTvebcvXjQOjjo0
36M86FnaGqdnd7fo7ivxqbyB1qnoLn1zH4XfCOLzMZU9CjedqVbFVITjC5MWfPtQ
0J3F9SVi4oBzKqw7HTt5Op58FIUfEUTpxuXXEPIBxBkXE1tRkqaTjizIBqZNyZuq
+2UwTV27SWorrSLV/9GcXGBIlM6SdfJeVcbK5bEQIU7g1483ZII=
=PWl0
-----END PGP SIGNATURE-----

--d71MlQyvtsLzRQ2B--
