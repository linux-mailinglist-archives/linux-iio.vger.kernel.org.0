Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2CC31AFC3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 09:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhBNIzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 03:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhBNIzK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Feb 2021 03:55:10 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5583C061574;
        Sun, 14 Feb 2021 00:54:29 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id ba1so2083872plb.1;
        Sun, 14 Feb 2021 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYuS9JOp9cmIEb3fMdH3acyVbHUll4sIDvPh/OFGunU=;
        b=AaUzBsy8VhqfiCC23nAs3dOmbkC9iK/nyRujBPJ7eXdeW7ZmhG5tX26uRt3aHgk3vN
         HN53vZofETUAhudw2oi7Lk36ELsiondWxx7M9Dk/zrGcQ0j1ATo5FzaIXtrWJn2LOiIR
         Vw2GkuSVhOfDLRprxaX/+67L4RfTfOHVxgYHOLX6aPv1bApxGuX3xLp9ddjuAqhGFyBv
         jZXa2VeeMFOP8hgLbCFhxbfSaMBHXBaCaZx8tdAe19oxpyfVrmHiBG4e80TF6lSpDeKe
         KjLgfLI0SEHCu6A4KzTC4Vdvvj8OmHfcLXUNbY3MJFhTxd5m9lkbGXDmnUMnOeGPzPkD
         rEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYuS9JOp9cmIEb3fMdH3acyVbHUll4sIDvPh/OFGunU=;
        b=nkrSx217N8oPlGpi815YD45d2fu0gF5vuTPp2/GtRfHwr5Rw+e3e2zANfexeEPv+9a
         aGAWF2JHpf7Voh0ecS5Qm2taR3mDkXiKjwYkaqYoy1DbVg5zHoysrfOGehv4MXxu4ae+
         Q58AisToG7zCrdC8nLDzNl+//8zW6JPdwUgMiE4Snh45C2krjToOfIkgyur1FV7Qkvzd
         ncadG7euUwMv2+Cq+76MZ64P5T/rcrxD9HA9DYFKh5kybOv5c8Anjuehcw2Cn6OZXduE
         Se0jW5ozitrjNaWTP5/ARetj2LYPIZuFxCvPIuNwlNBXTH5K2Lqvb3xkVPfs1obx+0US
         SA3g==
X-Gm-Message-State: AOAM531GcSzy1JsDrrvw6hsXIpq/MMjQtoMpbIvMMHHTqOmJRzlsdpWG
        N8lBXQX9sMjgTvqc+FIeh58=
X-Google-Smtp-Source: ABdhPJyxvG0gxPuzig7x2t42kU7U/jNEV5mx4lehV46WY1lkVeU2fIvdOfx7PsmrJZm5xpiy0lIbwQ==
X-Received: by 2002:a17:90a:4882:: with SMTP id b2mr10994420pjh.69.1613292869234;
        Sun, 14 Feb 2021 00:54:29 -0800 (PST)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id o21sm12618153pjp.42.2021.02.14.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 00:54:28 -0800 (PST)
Date:   Sun, 14 Feb 2021 17:54:22 +0900
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
Subject: Re: [PATCH v5 2/2] counter: add IRQ or GPIO based event counter
Message-ID: <YCjlPhEtyH+vfSi4@shinobu>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PZUh/e7p+iwgzS79"
Content-Disposition: inline
In-Reply-To: <20210208135347.18494-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--PZUh/e7p+iwgzS79
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 08, 2021 at 02:53:47PM +0100, Oleksij Rempel wrote:
> Add simple IRQ or GPIO base event counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
>=20
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Hi Oleksij,

You're adding a new driver here so I'd like to see a new entry added to
the MAINTAINERS file so users know who to contact when they have
questions or want to submit patches.

> ---
>  drivers/counter/Kconfig     |  10 ++
>  drivers/counter/Makefile    |   1 +
>  drivers/counter/event-cnt.c | 250 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 261 insertions(+)
>  create mode 100644 drivers/counter/event-cnt.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2de53ab0dd25..3284987e070a 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -29,6 +29,16 @@ config 104_QUAD_8
>  	  The base port addresses for the devices may be configured via the base
>  	  array module parameter.
> =20
> +config EVENT_CNT
> +	tristate "Event counter driver"
> +	depends on GPIOLIB
> +	help
> +	  Select this option to enable event counter driver. Any interrupt sour=
ce
> +	  can be used by this driver as the event source.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gpio-pulse-cnt.
> +
>  config STM32_TIMER_CNT
>  	tristate "STM32 Timer encoder counter driver"
>  	depends on MFD_STM32_TIMERS || COMPILE_TEST
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 0a393f71e481..6626900468f6 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_COUNTER) +=3D counter.o
> =20
>  obj-$(CONFIG_104_QUAD_8)	+=3D 104-quad-8.o
> +obj-$(CONFIG_EVENT_CNT)		+=3D event-cnt.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
>  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
> diff --git a/drivers/counter/event-cnt.c b/drivers/counter/event-cnt.c
> new file mode 100644
> index 000000000000..a394fe72c4e4
> --- /dev/null
> +++ b/drivers/counter/event-cnt.c
> @@ -0,0 +1,250 @@
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
> +#define EVENT_CNT_NAME		"event-cnt"
> +
> +struct event_cnt_priv {
> +	struct counter_device counter;
> +	struct counter_ops ops;
> +	struct gpio_desc *gpio;
> +	int irq;
> +	bool enabled;
> +	atomic_t count;
> +};
> +
> +static irqreturn_t event_cnt_isr(int irq, void *dev_id)
> +{
> +	struct event_cnt_priv *priv =3D dev_id;
> +
> +	atomic_inc(&priv->count);

This is just used to count the number of interrupts right? I wonder if
we can do this smarter. For example, the kernel already keeps track of
number of interrupts that has occurred for any particular IRQ line on a
CPU (see the 'kstat_irqs' member of struct irq_desc, and the
show_interrupts() function in kernel/irq/proc.c). Would it make sense to
simply store the initial interrupt count on driver load or enablement,
and then return the difference during a count_read() callback?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t event_cnt_enable_read(struct counter_device *counter,
> +				     struct counter_count *count, void *private,
> +				     char *buf)
> +{
> +	struct event_cnt_priv *priv =3D counter->priv;
> +
> +	return sysfs_emit(buf, "%d\n", priv->enabled);
> +}
> +
> +static ssize_t event_cnt_enable_write(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      void *private, const char *buf,
> +				      size_t len)
> +{
> +	struct event_cnt_priv *priv =3D counter->priv;
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
> +		priv->enabled =3D enable;
> +		enable_irq(priv->irq);
> +	} else {
> +		disable_irq(priv->irq);
> +		priv->enabled =3D enable;
> +	}

Given the conditional path we know the value "enable" will hold here.
it'll be good to set priv->enabled explicitly here so there's no
confusion to a future reviewer:

	if (enable) {
		priv->enabled =3D 1;
		enable_irq(priv->irq);
	} else {
		disable_irq(priv->irq);
		priv->enabled =3D 0;
	}

> +
> +	return len;
> +}
> +
> +static const struct counter_count_ext event_cnt_ext[] =3D {
> +	{
> +		.name =3D "enable",
> +		.read =3D event_cnt_enable_read,
> +		.write =3D event_cnt_enable_write,
> +	},
> +};
> +
> +static enum counter_synapse_action event_cnt_synapse_actionss[] =3D {
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +};
> +
> +static int event_cnt_action_get(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    struct counter_synapse *synapse,
> +			    size_t *action)
> +{
> +	*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;

Fix this as mentioned in my earlier reply:
https://lore.kernel.org/linux-iio/YCFHRGbiVxpNgkQS@shinobu/

> +
> +	return 0;
> +}
> +
> +static int event_cnt_read(struct counter_device *counter,
> +				 struct counter_count *count,
> +				 unsigned long *val)
> +{
> +	struct event_cnt_priv *priv =3D counter->priv;
> +
> +	*val =3D atomic_read(&priv->count);
> +
> +	return 0;
> +}
> +
> +static int event_cnt_write(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  const unsigned long val)
> +{
> +	struct event_cnt_priv *priv =3D counter->priv;
> +
> +	atomic_set(&priv->count, val);
> +
> +	return 0;
> +}
> +
> +static int event_cnt_function_get(struct counter_device *counter,
> +				  struct counter_count *count, size_t *function)
> +{
> +	*function =3D COUNTER_COUNT_FUNCTION_INCREASE;

Fix this as mentioned in my earlier reply:
https://lore.kernel.org/linux-iio/YCFHRGbiVxpNgkQS@shinobu/

> +
> +	return 0;
> +}
> +
> +static int event_cnt_signal_read(struct counter_device *counter,
> +				 struct counter_signal *signal,
> +				 enum counter_signal_value *val)
> +{
> +	struct event_cnt_priv *priv =3D counter->priv;
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
> +static struct counter_signal event_cnt_signals[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "Channel 0 signal",

You should choose a more description name for this Signal;
"Channel 0 signal" isn't very useful information for the user. Is this
signal the respective GPIO line state?

> +	},
> +};
> +
> +static struct counter_synapse event_cnt_synapses[] =3D {
> +	{
> +		.actions_list =3D event_cnt_synapse_actionss,
> +		.num_actions =3D ARRAY_SIZE(event_cnt_synapse_actionss),
> +		.signal =3D &event_cnt_signals[0]
> +	},
> +};
> +
> +static enum counter_count_function event_cnt_functions[] =3D {
> +	COUNTER_COUNT_FUNCTION_INCREASE,
> +};
> +
> +static struct counter_count event_cnts[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "Channel 1 Count",
> +		.functions_list =3D event_cnt_functions,
> +		.num_functions =3D ARRAY_SIZE(event_cnt_functions),
> +		.synapses =3D event_cnt_synapses,
> +		.num_synapses =3D ARRAY_SIZE(event_cnt_synapses),
> +		.ext =3D event_cnt_ext,
> +		.num_ext =3D ARRAY_SIZE(event_cnt_ext),
> +	},
> +};
> +
> +static int event_cnt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct event_cnt_priv *priv;
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
> +	priv->ops.action_get =3D event_cnt_action_get;
> +	priv->ops.count_read =3D event_cnt_read;
> +	priv->ops.count_write =3D event_cnt_write;
> +	priv->ops.function_get =3D event_cnt_function_get;
> +	if (priv->gpio)
> +		priv->ops.signal_read  =3D event_cnt_signal_read;

Move ops out of priv and make it static const. You can get rid of this
priv->gpio conditional here and instead perform it for num_signals
as I explain inline below.

> +
> +	priv->counter.name =3D dev_name(dev);
> +	priv->counter.parent =3D dev;
> +	priv->counter.ops =3D &priv->ops;
> +	priv->counter.counts =3D event_cnts;
> +	priv->counter.num_counts =3D ARRAY_SIZE(event_cnts);
> +	priv->counter.signals =3D event_cnt_signals;
> +	priv->counter.num_signals =3D ARRAY_SIZE(event_cnt_signals);

If the Signal provided is only valid for GPIO sources, then you should
add a conditional check here. Simply setting num_signals to 0 should be
enough to disable the creation of the Signal attribute for non-GPIO
sources:

	priv->counter.num_signals =3D priv->gpio ?
				    ARRAY_SIZE(event_cnt_signals) : 0;


> +	priv->counter.priv =3D priv;
> +
> +	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
> +	ret =3D devm_request_irq(dev, priv->irq, event_cnt_isr,
> +			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +			       EVENT_CNT_NAME, priv);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, priv);

This line isn't needed; you don't ever deal with struct device directly
do you?

William Breathitt Gray

> +
> +	return devm_counter_register(dev, &priv->counter);
> +}
> +
> +static const struct of_device_id event_cnt_of_match[] =3D {
> +	{ .compatible =3D "event-counter", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, event_cnt_of_match);
> +
> +static struct platform_driver event_cnt_driver =3D {
> +	.probe =3D event_cnt_probe,
> +	.driver =3D {
> +		.name =3D EVENT_CNT_NAME,
> +		.of_match_table =3D event_cnt_of_match,
> +	},
> +};
> +module_platform_driver(event_cnt_driver);
> +
> +MODULE_ALIAS("platform:event-counter");
> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> +MODULE_DESCRIPTION("Event counter driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.30.0
>=20

--PZUh/e7p+iwgzS79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAo5TMACgkQhvpINdm7
VJL/ghAAup+oOZSH/ro88Xs7Gnc+CqsE/TYwvgYbOCABtOG8FXFc09q2RB1gTWH9
5gYtNSAhHDBGL/Wbv55TtUkHUk3Qcq82LUMrWI/4jaBoZ1M9+aVq9m5tUd464E3J
KeD0D5FXKqZxk+DfTRaJgOqVFxha7KWwBkLgB3BI8pmoPhLXPYLqHcCuSJIleTqk
5CQFma894uu/FBx05IZTheLDqE1ZD9mKaelB1AW82HyjXWC2M76t982yNgm5avUN
ogg3KPd3SCNwBDYcbJHktCQw+n2fEQpclcmCTXUMe4Z6VpFndQSCOojUHFhwkkL+
kKDr7WIdVlv2ROTskX9C06iBBm1Vbdy1Is7T9WHCgL9uD3BaFHtSFQ8saLFT0jz5
8CVmSIiIBLa7NFkElzlGOau6EyrvqAhWPCKeqfjWvXiF2cCLW9CYqiKtu7XjQxmO
sMJeU3boyU80ZzvZgiophVPCDZdJ5t/LxZlIqHx+aJv5bz28dq1IudpD89pMBPaw
ZpJmGHpeEkFNk/XiS0u1yief+tKfae6oCZR6AHF4c6Bs+cJCsrDp7bCkvNUKPUuu
h/Pn+73rbf/pwr4VmxK+vhVV3DhU4VsOTs9S40/9Ilmaa94ELy8H6cQTRozMwoNs
JTwSz56SE2+CNf725tqz7N+eKXei2vjJ+adb5hDCYkpYK0B5KrI=
=xaBy
-----END PGP SIGNATURE-----

--PZUh/e7p+iwgzS79--
