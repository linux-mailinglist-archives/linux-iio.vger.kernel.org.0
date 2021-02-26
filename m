Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AA73262D2
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 13:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZMmB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 07:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBZMmB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 07:42:01 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ABBC061574;
        Fri, 26 Feb 2021 04:41:20 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id o31so3020152uae.2;
        Fri, 26 Feb 2021 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwcTLQq3H5c2UK+OWGZKD2GMY78k6FaSogjGLTzQit8=;
        b=M9p/Cwg3Hk2dvA+4WL3gl2+aEcE0ue3aBk9SU7aQbc2qmuL+BX36vV0xKLLTJh9tJa
         Fh/WU8GsgK8dL6w8baYWFT9ZeSmeFOTWpjdVZ86huewZfkSyqnR4RwJjnVJwK3kfN4PN
         Sxnhv9Eh8vIkdIqcrD7ub5yRDWZcioX3dtXpRrX/jO74RH/yzV3SccMxIpQVDlf1jetu
         RudRuCpW+8QISOsEu8ydsbrq46FpZIE0vTtthLsoBIU2oH3TDYNsqtHgYZJoe1aHFjQb
         UyQMkIpRyUTTwGaghKdb/6vmqmECC8xainPpgSLLjRWDUPOCO/PJZg4WAKzt+VXriyew
         Nf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwcTLQq3H5c2UK+OWGZKD2GMY78k6FaSogjGLTzQit8=;
        b=PoL+5vcGGMX5ftaeL6Z8Qx2vd7e3NW6MLm5RGtPIiUNe9HuD8iKPYrS6SaY3cCwKpb
         ZUPJRcGXh2Or0QS+MgMQ1JPjMU1hRAxMDRPwgBFiCsG0sEFmw7nzszmCYvSsLWFfIq7Z
         3TjKG9m11ue4WnBz0kganmzLxB5CWMDXr4eV7AoQkLKZ4T6gikT4YDk0FT7wtUFgQJxW
         CrcgOBZhTi+5vsWkBfUfF1Q9NUyQFKySdgWYR6LD/rUOPTThZx7OBdjYomy98+pUu4Rk
         uErPJVk6/rfFDqxVZROpyFf2px4PWsvxyhaKnFqpOmLaPVmbjbDCDLFolJddyF8ENiyY
         dkpg==
X-Gm-Message-State: AOAM531MYrz5LYvYm3oTWmHBqugCJPOXu6k2T4tw1hXW1YUGHxpxeSXW
        5LGQOt4HWleyvB+fc58ZRok=
X-Google-Smtp-Source: ABdhPJzMFEgfXaU6K+NKWQQKLNJlmLF00kHu1fORscS0i96AsC2HhFP+MQfxEHsi96P69E1a6IMneA==
X-Received: by 2002:ab0:1c1b:: with SMTP id a27mr1457614uaj.62.1614343279413;
        Fri, 26 Feb 2021 04:41:19 -0800 (PST)
Received: from shinobu ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id e128sm1062680vkg.1.2021.02.26.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 04:41:18 -0800 (PST)
Date:   Fri, 26 Feb 2021 21:41:11 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v7 2/2] counter: add IRQ or GPIO based counter
Message-ID: <YDjsZ8hyETN0VpCM@shinobu>
References: <20210226090830.10927-1-o.rempel@pengutronix.de>
 <20210226090830.10927-3-o.rempel@pengutronix.de>
 <YDjDMBfWwdImiZxY@shinobu>
 <20210226121455.t7kz4cxtganzt2xz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zDZZKf6/pb+UPY5C"
Content-Disposition: inline
In-Reply-To: <20210226121455.t7kz4cxtganzt2xz@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zDZZKf6/pb+UPY5C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 01:14:55PM +0100, Oleksij Rempel wrote:
> On Fri, Feb 26, 2021 at 06:45:20PM +0900, William Breathitt Gray wrote:
> > On Fri, Feb 26, 2021 at 10:08:30AM +0100, Oleksij Rempel wrote:
> > > +static int interrupt_cnt_signal_read(struct counter_device *counter,
> > > +				     struct counter_signal *signal,
> > > +				     enum counter_signal_value *val)
> > > +{
> > > +	struct interrupt_cnt_priv *priv =3D counter->priv;
> > > +	int ret;

I forgot about this function. Add a check here to return -EINVAL if
we're not dealing with a GPIO:

	if (!priv->gpio)
		return -EINVAL;

> > > +
> > > +	ret =3D gpiod_get_value(priv->gpio);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val =3D ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct counter_ops interrupt_cnt_ops =3D {
> > > +	.action_get =3D interrupt_cnt_action_get,
> > > +	.count_read =3D interrupt_cnt_read,
> > > +	.count_write =3D interrupt_cnt_write,
> > > +	.function_get =3D interrupt_cnt_function_get,
> > > +	.signal_read  =3D interrupt_cnt_signal_read,
> > > +};
> > > +
> > > +static int interrupt_cnt_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct interrupt_cnt_priv *priv;
> > > +	int ret;
> > > +
> > > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	priv->irq =3D platform_get_irq_optional(pdev,  0);
> > > +	if (priv->irq =3D=3D -ENXIO)
> > > +		priv->irq =3D 0;
> > > +	else if (priv->irq < 0)
> > > +		return dev_err_probe(dev, priv->irq, "failed to get IRQ\n");
> > > +
> > > +	priv->gpio =3D devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> > > +	if (IS_ERR(priv->gpio))
> > > +		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get GPIO=
\n");
> > > +
> > > +	if (!priv->irq && !priv->gpio) {
> > > +		dev_err(dev, "IRQ and GPIO are not found. At least one source shou=
ld be provided\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	if (!priv->irq) {
> > > +		int irq =3D gpiod_to_irq(priv->gpio);
> > > +
> > > +		if (irq < 0)
> > > +			return dev_err_probe(dev, irq, "failed to get IRQ from GPIO\n");
> > > +
> > > +		priv->irq =3D irq;
> > > +	}
> > > +
> > > +	if (priv->gpio) {
> >=20
> > This if statement can be removed. There's no need to restrict this to
> > just GPIO because we're always dealing with an IRQ, so allocate the
> > "IRQ #" name unconditionally and set signals/num_signals.
>=20
> Your previous suggestion was to no assign signals if there is no gpios.
> What should I do?
>=20
> Regards,
> Oleksij
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

I'm sorry for not being clear. I'm saying there is no need to
differentiate here because there will always be a respective IRQ line
whether there is a GPIO line or not. So removing the if statement is all
you need to do.

Instead of:

	if (priv->gpio) {
		priv->signals.name =3D devm_kasprintf(dev, GFP_KERNEL, "IRQ %d",
					    priv->irq);
		if (!priv->signals.name)
			return -ENOMEM;

		priv->counter.signals =3D &priv->signals;
		priv->counter.num_signals =3D 1;
	}
=09
	priv->synapses.actions_list =3D interrupt_cnt_synapse_actionss;
	priv->synapses.num_actions =3D ARRAY_SIZE(interrupt_cnt_synapse_actionss);
	priv->synapses.signal =3D &priv->signals;
	...

You can just have those lines execute unconditionally even if there are
no gpios:

	priv->signals.name =3D devm_kasprintf(dev, GFP_KERNEL, "IRQ %d",
				    priv->irq);
	if (!priv->signals.name)
		return -ENOMEM;

	priv->counter.signals =3D &priv->signals;
	priv->counter.num_signals =3D 1;
=09
	priv->synapses.actions_list =3D interrupt_cnt_synapse_actionss;
	priv->synapses.num_actions =3D ARRAY_SIZE(interrupt_cnt_synapse_actionss);
	priv->synapses.signal =3D &priv->signals;
	...

William Breathitt Gray

--zDZZKf6/pb+UPY5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA47EQACgkQhvpINdm7
VJL2OxAAw+LYMNXAWMCpkG64pnB+bM+4rXT547BrG7UkDPr7qvDHgVHY5cx+jTwR
Uaisl3EGDMLID45fIiDXkZ74WYJB16xrVGTi8/4msfoJFINgKR7AzQ90wUqSx1VF
3GOTy/kKTokzJQ41Hv1sJtGX5rh+5+bzt62nTpEuY4lc3lQAlgZk3/03IoR33zoX
eAQ0eQFxyjIdakF3HYlGodS8Vz5dSviBNmmtElvaGRgEdBFiz6fxaKMGHV15nWO/
BfhIf78TyPCq+KqhQLJb+L7Hvz4cv2bqLHxPOCkmXODBrylYd7TbmVA0JEl8prGM
OlwPazjT+5a8/yNh/CM09G2xiUUzwunB61Hiny64MWPeWRNM3M4W0ErxQqmp3sgz
k8QJJ+swppHzC/pLeZTJAEySwQk/eGGu9x3TL2r+GVpegsDkbeaiXqmFRy2+EiIx
royJZVa6/7HJ0xTrCO8gUHSMFIK4dwAUpQaPeyXaJ/zEdlgdYxy5a9TugNVyVaez
Zs2UtajmVUNHvqIVkbZUt8oQ6ZghMaHwZ2ffDMqG2249umcC7/RkmvpMH97XEDIj
MqKCer2gVLqkLAGOV++7MiWLNgjBtCvDkH8atWPCNPny6mcUHE9bfWF1h8/Ckhn3
5jU/aboI6HYWBfEwnmmMM7KE4J12jZeWZ/gzcFulV3j/JesOY2c=
=lFTA
-----END PGP SIGNATURE-----

--zDZZKf6/pb+UPY5C--
