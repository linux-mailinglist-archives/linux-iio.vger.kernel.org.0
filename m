Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C00326069
	for <lists+linux-iio@lfdr.de>; Fri, 26 Feb 2021 10:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhBZJqQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 04:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZJqH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2021 04:46:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D40DC061574;
        Fri, 26 Feb 2021 01:45:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c19so5668506pjq.3;
        Fri, 26 Feb 2021 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7DB7rvwFqfFKue2IvxDTMhTNrw6PaagMofMVvcAa6HU=;
        b=p0Aot7FaW4Ce3LBrUcexMec/PbNBrB5IcmyQGs17jbgmLWVovh2HBf5K4SC9dwaJZh
         EGRQv5AfdVtN35wPpzlSmjJSzptgHQMuKad2zhAC5hyRMb+fPkes9gxEa/Nc87BqO3b+
         Z89g7k9ZplPfC1URrY0/TxgFk9S6g9omPgXH+pKpc6OnZoJG6iJ40AMKDZMJ2fJHUGDZ
         GJTjwmoHAVQ/0+DuTpyFI74sjv8KZBvwTUQYXn0WnSmrzo60yBM9woNIXJ1eIX3i0AHd
         sp+eMOc6tdCTwWFJvuE6gbduTNEEPJWyA+ewkuh87TtWiW5W2QFIQseoBoctJS2yzI0h
         r0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7DB7rvwFqfFKue2IvxDTMhTNrw6PaagMofMVvcAa6HU=;
        b=fd8716TOU8Vi6Ww6NtNeoMEI2P+UE2IEcUNUHPq9/uPiz3XpuiEgL2E9fiIbBgWraj
         gJeuyyKcfV+qf/18uEYzrxp46YkMzzlJmorh89Luw/Sq9JR1ryvR7jUHtJ69YRO7LeQP
         dZKdByz4zCk3YKzSBYs7K+OV1+EGLJuaklGDh2BKZyKSENDGS7InYHt/yUkiyY9Xs3Wa
         RGh4KBjJH6GoFLsKeCUaeLUEs0SPxzmNgB+wT/iZRJUEW7P2cvXStnOZVqWyemKlWGgJ
         9NEnu1ofANqqv3FovRD0z3DBdilMXpo06WarqYgWc+fqYPtNqGmuMTuagM+W/xmePpsT
         aCNQ==
X-Gm-Message-State: AOAM530Kg7un1S0FqdPbMd3K+scaVynkkeP2wLknZIrlUwIIK7QKGIH5
        P+HCfa5Pzicsf9MR16pPsgM=
X-Google-Smtp-Source: ABdhPJwLEYXeyG+fYgvSt/A9bQCuOy63RFQkkH4t6g2oTzT7T1NdTW+zmjPkSVKhDdEhO3682rO0/A==
X-Received: by 2002:a17:902:e8d3:b029:e3:cb77:2dde with SMTP id v19-20020a170902e8d3b02900e3cb772ddemr2302489plg.78.1614332726685;
        Fri, 26 Feb 2021 01:45:26 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id d16sm8201246pjd.25.2021.02.26.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 01:45:25 -0800 (PST)
Date:   Fri, 26 Feb 2021 18:45:20 +0900
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
Message-ID: <YDjDMBfWwdImiZxY@shinobu>
References: <20210226090830.10927-1-o.rempel@pengutronix.de>
 <20210226090830.10927-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1nUU+bGlEdYHmqn"
Content-Disposition: inline
In-Reply-To: <20210226090830.10927-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--H1nUU+bGlEdYHmqn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2021 at 10:08:30AM +0100, Oleksij Rempel wrote:
> Add simple IRQ or GPIO base counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
>=20
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Hi Oleksij,

We're almost there, but I spotted a couple of mistakes below.

> ---
>  MAINTAINERS                     |   7 +
>  drivers/counter/Kconfig         |  10 ++
>  drivers/counter/Makefile        |   1 +
>  drivers/counter/interrupt-cnt.c | 243 ++++++++++++++++++++++++++++++++
>  4 files changed, 261 insertions(+)
>  create mode 100644 drivers/counter/interrupt-cnt.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a50a543e3c81..ad0a4455afec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9217,6 +9217,13 @@ F:	include/dt-bindings/interconnect/
>  F:	include/linux/interconnect-provider.h
>  F:	include/linux/interconnect.h
> =20
> +INTERRUPT COUNTER DRIVER
> +M:	Oleksij Rempel <o.rempel@pengutronix.de>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-iio@vger.kernel.org
> +F:	Documentation/devicetree/bindings/counter/interrupt-counter.yaml
> +F:	drivers/counter/interrupt-cnt.c
> +
>  INVENSENSE ICM-426xx IMU DRIVER
>  M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>  L:	linux-iio@vger.kernel.org
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2de53ab0dd25..dcad13229134 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -29,6 +29,16 @@ config 104_QUAD_8
>  	  The base port addresses for the devices may be configured via the base
>  	  array module parameter.
> =20
> +config INTERRUPT_CNT
> +	tristate "Interrupt counter driver"
> +	depends on GPIOLIB
> +	help
> +	  Select this option to enable interrupt counter driver. Any interrupt
> +	  source can be used by this driver as the event source.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called interrupt-cnt.
> +
>  config STM32_TIMER_CNT
>  	tristate "STM32 Timer encoder counter driver"
>  	depends on MFD_STM32_TIMERS || COMPILE_TEST
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 0a393f71e481..cb646ed2f039 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_COUNTER) +=3D counter.o
> =20
>  obj-$(CONFIG_104_QUAD_8)	+=3D 104-quad-8.o
> +obj-$(CONFIG_INTERRUPT_CNT)		+=3D interrupt-cnt.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
>  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-=
cnt.c
> new file mode 100644
> index 000000000000..550383b6b591
> --- /dev/null
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
> + */
> +
> +#include <linux/counter.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#define INTERRUPT_CNT_NAME "interrupt-cnt"
> +
> +struct interrupt_cnt_priv {
> +	atomic_t count;
> +	struct counter_device counter;
> +	struct gpio_desc *gpio;
> +	int irq;
> +	bool enabled;
> +	struct counter_signal signals;
> +	struct counter_synapse synapses;
> +	struct counter_count cnts;
> +};
> +
> +static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
> +{
> +	struct interrupt_cnt_priv *priv =3D dev_id;
> +
> +	atomic_inc(&priv->count);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t interrupt_cnt_enable_read(struct counter_device *counter,
> +					 struct counter_count *count,
> +					 void *private, char *buf)
> +{
> +	struct interrupt_cnt_priv *priv =3D counter->priv;
> +
> +	return sysfs_emit(buf, "%d\n", priv->enabled);
> +}
> +
> +static ssize_t interrupt_cnt_enable_write(struct counter_device *counter,
> +					  struct counter_count *count,
> +					  void *private, const char *buf,
> +					  size_t len)
> +{
> +	struct interrupt_cnt_priv *priv =3D counter->priv;
> +	bool enable;
> +	ssize_t ret;
> +
> +	ret =3D kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->enabled =3D=3D enable)
> +		return len;
> +
> +	if (enable) {
> +		priv->enabled =3D true;
> +		enable_irq(priv->irq);
> +	} else {
> +		disable_irq(priv->irq);
> +		priv->enabled =3D false;
> +	}
> +
> +	return len;
> +}
> +
> +static const struct counter_count_ext interrupt_cnt_ext[] =3D {
> +	{
> +		.name =3D "enable",
> +		.read =3D interrupt_cnt_enable_read,
> +		.write =3D interrupt_cnt_enable_write,
> +	},
> +};
> +
> +static enum counter_synapse_action interrupt_cnt_synapse_actionss[] =3D {
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +};
> +
> +static int interrupt_cnt_action_get(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    struct counter_synapse *synapse,
> +				    size_t *action)
> +{
> +	*action =3D interrupt_cnt_synapse_actionss[0];

This needs to be set to the index of the element, not the value:

	*action =3D 0;

> +
> +	return 0;
> +}
> +
> +static int interrupt_cnt_read(struct counter_device *counter,
> +			      struct counter_count *count, unsigned long *val)
> +{
> +	struct interrupt_cnt_priv *priv =3D counter->priv;
> +
> +	*val =3D atomic_read(&priv->count);
> +
> +	return 0;
> +}
> +
> +static int interrupt_cnt_write(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       const unsigned long val)
> +{
> +	struct interrupt_cnt_priv *priv =3D counter->priv;
> +
> +	atomic_set(&priv->count, val);
> +
> +	return 0;
> +}
> +
> +static enum counter_count_function interrupt_cnt_functions[] =3D {
> +	COUNTER_COUNT_FUNCTION_INCREASE,
> +};
> +
> +static int interrupt_cnt_function_get(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      size_t *function)
> +{
> +	*function =3D interrupt_cnt_functions[0];

Same problem as action_get(); needs to be index, not value:

	*function =3D 0;

> +
> +	return 0;
> +}
> +
> +static int interrupt_cnt_signal_read(struct counter_device *counter,
> +				     struct counter_signal *signal,
> +				     enum counter_signal_value *val)
> +{
> +	struct interrupt_cnt_priv *priv =3D counter->priv;
> +	int ret;
> +
> +	ret =3D gpiod_get_value(priv->gpio);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> +
> +	return 0;
> +}
> +
> +static const struct counter_ops interrupt_cnt_ops =3D {
> +	.action_get =3D interrupt_cnt_action_get,
> +	.count_read =3D interrupt_cnt_read,
> +	.count_write =3D interrupt_cnt_write,
> +	.function_get =3D interrupt_cnt_function_get,
> +	.signal_read  =3D interrupt_cnt_signal_read,
> +};
> +
> +static int interrupt_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct interrupt_cnt_priv *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->irq =3D platform_get_irq_optional(pdev,  0);
> +	if (priv->irq =3D=3D -ENXIO)
> +		priv->irq =3D 0;
> +	else if (priv->irq < 0)
> +		return dev_err_probe(dev, priv->irq, "failed to get IRQ\n");
> +
> +	priv->gpio =3D devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> +	if (IS_ERR(priv->gpio))
> +		return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get GPIO\n");
> +
> +	if (!priv->irq && !priv->gpio) {
> +		dev_err(dev, "IRQ and GPIO are not found. At least one source should b=
e provided\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!priv->irq) {
> +		int irq =3D gpiod_to_irq(priv->gpio);
> +
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq, "failed to get IRQ from GPIO\n");
> +
> +		priv->irq =3D irq;
> +	}
> +
> +	if (priv->gpio) {

This if statement can be removed. There's no need to restrict this to
just GPIO because we're always dealing with an IRQ, so allocate the
"IRQ #" name unconditionally and set signals/num_signals.

William Breathitt Gray

> +		priv->signals.name =3D devm_kasprintf(dev, GFP_KERNEL, "IRQ %d",
> +					    priv->irq);
> +		if (!priv->signals.name)
> +			return -ENOMEM;
> +
> +		priv->counter.signals =3D &priv->signals;
> +		priv->counter.num_signals =3D 1;
> +	}
> +
> +	priv->synapses.actions_list =3D interrupt_cnt_synapse_actionss;
> +	priv->synapses.num_actions =3D ARRAY_SIZE(interrupt_cnt_synapse_actions=
s);
> +	priv->synapses.signal =3D &priv->signals;
> +
> +	priv->cnts.name =3D "Channel 0 Count";
> +	priv->cnts.functions_list =3D interrupt_cnt_functions;
> +	priv->cnts.num_functions =3D ARRAY_SIZE(interrupt_cnt_functions);
> +	priv->cnts.synapses =3D &priv->synapses;
> +	priv->cnts.num_synapses =3D 1;
> +	priv->cnts.ext =3D interrupt_cnt_ext;
> +	priv->cnts.num_ext =3D ARRAY_SIZE(interrupt_cnt_ext);
> +
> +	priv->counter.priv =3D priv;
> +	priv->counter.name =3D dev_name(dev);
> +	priv->counter.parent =3D dev;
> +	priv->counter.ops =3D &interrupt_cnt_ops;
> +	priv->counter.counts =3D &priv->cnts;
> +	priv->counter.num_counts =3D 1;
> +
> +	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
> +	ret =3D devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
> +			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +			       dev_name(dev), priv);
> +	if (ret)
> +		return ret;
> +
> +	return devm_counter_register(dev, &priv->counter);
> +}
> +
> +static const struct of_device_id interrupt_cnt_of_match[] =3D {
> +	{ .compatible =3D "interrupt-counter", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, interrupt_cnt_of_match);
> +
> +static struct platform_driver interrupt_cnt_driver =3D {
> +	.probe =3D interrupt_cnt_probe,
> +	.driver =3D {
> +		.name =3D INTERRUPT_CNT_NAME,
> +		.of_match_table =3D interrupt_cnt_of_match,
> +	},
> +};
> +module_platform_driver(interrupt_cnt_driver);
> +
> +MODULE_ALIAS("platform:interrupt-counter");
> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> +MODULE_DESCRIPTION("Interrupt counter driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.29.2
>=20

--H1nUU+bGlEdYHmqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA4wyQACgkQhvpINdm7
VJJxzA//V/buD+pOKghaucKGJOQgNsmMA8BaRkcHZunFnOS5D92VL4bBHsjv3D8o
qnpkd+LWd26E+eD5KxO009A7Fvq0/TReyXInGmbnTAWirgsUXqt2sdRMhMMBt/x1
UWy9kWwXEhevUPSvKfcyJ7Y2tzCyaWKT77Phl8PVHfbUxPWvlfnEB3+kBOiElnby
kuJH7R4nxAyaavRLcba0b5pUp8wgqJkSsR+h0/KajSHn01IwjSWR6LQZlovb9Dpb
GoZMssNnbRNSh4nVElOy80PM2p0v4FtK/3yBDKAU9GZngEHSQuBNDYdFz1tDihTX
prTDFPZqNzpPE7wfJskuzXAkYQi7404R4wN4m9s6DO8/ThxOybotEjnIrOmAkjpg
o5YC80uFJV6Lpt4BCDeoQ2KnYpHfKzEFK/i1APW2EjsTeSCE3uv+h+TOPvCOX/eA
D/wSmRToDgmlMmzGZflAe9qsUFLql/4PiQxHRzy2A2I75Y3TjZjyCq1fUNxkR5nI
xuAn2uufsoD5rYMWnDsGPRTsqhTQKMfRX0/RGCPoPrE0clGeATrvO4DULBU38PnP
puzwCm28FWWTFcBFcr4mB4+RFUSbBRUCKqtGl8ZCyF34qTI6rRATAVKIj7J4fAER
cAdJaaX68Qv9VUhi23pKCurD/qxYK6gnrL2d3cXZxGr4a++bnvA=
=lpXM
-----END PGP SIGNATURE-----

--H1nUU+bGlEdYHmqn--
