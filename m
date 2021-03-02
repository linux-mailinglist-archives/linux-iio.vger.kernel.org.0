Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130F32B3A9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Mar 2021 05:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhCCEJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Mar 2021 23:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhCBBS5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 20:18:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CB9C06178A;
        Mon,  1 Mar 2021 17:18:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e9so11036948plh.3;
        Mon, 01 Mar 2021 17:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZzTMV7jBQ/4yYQFTgGQVg3S9o5JLZiKHfBzjeSpcZqY=;
        b=p5rwj9+fyE3DzESCGKg7k080cmzvIn6EYFiolcyYjQI96PRh6UVtwWh24ncOwOm91v
         M/93bzdSJuO5r4wHaC/ajqvdT47e1qT2tVqpipQGu3QzBgsR22elr1jWx65qgwLbfVub
         U9xPuu5w6iO4EeJ+fCi4IGQ2C5VRGYP0b5+1pVbcPmH52W7uz15xBH0WFBioqPOiZL06
         PHCQiJvxP1vFX1tSXTMZlI6Nc5vITNd5jGIg96xMfbaOZSjhOqFIvN0ZxWcqOjYjlxTT
         +2OFKDH/YrCmzAhD3Z7B31C/ZBrg9at5wBjedtWubTUfj7MfGh360MD5dAvsyaihlV0i
         MIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZzTMV7jBQ/4yYQFTgGQVg3S9o5JLZiKHfBzjeSpcZqY=;
        b=IsI/qcUR2G5CoStTSipqWGqgQAfg2QCkd523Sq1cHurTcGR1k+6BQY2bb5DNZYQyaJ
         azCz/ka25VUkw/VWBQZtIsZufUMz0Y7Xm+147iR84RgSYuIpkWpLUZMO3Mhkr4/Qu8IG
         wcKesNj88xqMuN+P0O5o9radSouaay9Um6FSpfn/YOeUIbl1/2YtXWxTic3AozOvgyjU
         fkmyB7vcJsybUmdEZdXEhW4dEvMNaMJe1yi+oprOBsJUBEFlzRH347V3kZaNSPZ/jkcw
         NpUNlmOEFIHqMRnhcKScUpcNJx+pogv9hgXypMTJrR+2IrbuPmtrrxk+m2Z1H+LgOPKS
         +/gw==
X-Gm-Message-State: AOAM5319Nfyte4UwtdXMpScURlyyLiRgAU5uzfoBJCzi4BHmn2MIqnXs
        yioeInFq3Wx0izB0XGBqbCpBWi2IYg9jvA==
X-Google-Smtp-Source: ABdhPJy9lEsoDSt75XCvbR9AbXEglxey/mBhYBW7R3udnvz4NYNsQ/+too5cYHeVVoCwlcBx08bcxw==
X-Received: by 2002:a17:90b:3805:: with SMTP id mq5mr1735037pjb.78.1614647896841;
        Mon, 01 Mar 2021 17:18:16 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id n4sm18084854pgg.68.2021.03.01.17.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 17:18:16 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:18:10 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 2/2] counter: add IRQ or GPIO based counter
Message-ID: <YD2SUtcnJ4jMOJ4R@shinobu>
References: <20210301080401.22190-1-o.rempel@pengutronix.de>
 <20210301080401.22190-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d+xIjvF4BdfXdB0j"
Content-Disposition: inline
In-Reply-To: <20210301080401.22190-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--d+xIjvF4BdfXdB0j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2021 at 09:04:01AM +0100, Oleksij Rempel wrote:
> Add simple IRQ or GPIO base counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
>=20
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

This version looks acceptable for the Counter subsystem.

Thanks,

Reviewed-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  MAINTAINERS                     |   7 +
>  drivers/counter/Kconfig         |  10 ++
>  drivers/counter/Makefile        |   1 +
>  drivers/counter/interrupt-cnt.c | 244 ++++++++++++++++++++++++++++++++
>  4 files changed, 262 insertions(+)
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
> index 000000000000..a99ee7996977
> --- /dev/null
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -0,0 +1,244 @@
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
> +	*action =3D 0;
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
> +	*function =3D 0;
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
> +	if (!priv->gpio)
> +		return -EINVAL;
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
> +	priv->signals.name =3D devm_kasprintf(dev, GFP_KERNEL, "IRQ %d",
> +					    priv->irq);
> +	if (!priv->signals.name)
> +		return -ENOMEM;
> +
> +	priv->counter.signals =3D &priv->signals;
> +	priv->counter.num_signals =3D 1;
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

--d+xIjvF4BdfXdB0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmA9klIACgkQhvpINdm7
VJKGJw/9GEJmTV6QCNZquKbcoOMHtaEkxCm5N1FBFZ5Q9oS3qFGDK1HweyXll38K
718fFVyVLmu9SaCSXpN8C8DV+ktPZlaLMFIXHzXc5SOLRvoumq+Wuctxz+cm+k4H
eRAA8mgEcBfUCGw5s1RypLcYmLtflRwKeEbizwAqVoxHDIXILZX6Mryq4ptpFUuW
HBUV+8Y1KVmb8tYzSLNNPzoZ0dA5XQMBE3/aAdkmtpRcUf+Ynu40mKyhIdcVPGzg
Noaljb4VsOzkrD49nEesHJcCpXs1vETWnHX98Yy7lUiCmbSnZVVQofO3yPoCTYZR
pE1JrfkPfGizpHKBBUMNt/PqrqwV4gxT91mNthtZ1P45q86DHCMDJP3Bz9DSEneM
QBjpRsSj6/2bf4uP0VXuGv38fKDyY7w3mAvNdBSA+RCId9cMedmUycjfsvmoQcv7
17vU07xn72le94huboMSpZhsnmtASh2ebfvlDDpmjuHQuJNN0bQSJjwsVq43w83I
ddZr/Py9c4/1fIMavqxiroC1Y0Lr/U7e6fc1z2TgvdXtzy3/g4E+IeflEx4YO9aD
ANZcs/Tu61ZCDyrTJgIpbqNDJkwEIlCuKk07lF062aNC2X70w7PwlyNRPUdnnFTt
kePJMOEkGjH82N9SgovzjcV9bPtOWeDjaRBu0DXbOCUop4rw24s=
=AapP
-----END PGP SIGNATURE-----

--d+xIjvF4BdfXdB0j--
