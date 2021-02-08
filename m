Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F53134D3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhBHORa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 09:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhBHOPT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 09:15:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D483C061786;
        Mon,  8 Feb 2021 06:14:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nm1so8339883pjb.3;
        Mon, 08 Feb 2021 06:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=43dJuN3+4M8HezyAeEo/quzbJIvm3V1bbBUQwslkpy0=;
        b=V2oOraiska2N5MAixfgVBo+gQXNt/YHJNadrTlWjsVOrvOI6yvNkBIfEX2p4ApZtwR
         /nPjiGSkibgynh2pCLbxjmw3WkdV+lwqBW3RDQrgwqT5DAmnEXkCZf4rB0bLRFByFn6C
         Gy5Y+G7/XxFwWEUkbcN4bU9eGhbGBmD5u6yAqOpw8OJB0NZ+yNeViWSW2LLmnAIXY7Yw
         LwfKOj9AjdSr+z1fRJfuQOEhgsyY1VlUtWoUOoQYSIcEKcy18adIX5icMxFvyZEtNPHC
         EAkvgNqINwyFd1iJLGrH+QovllbGN8yL0/TCo6uV8d3OJ56Tl1lKu8h0OSvCEBtItX8h
         rmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=43dJuN3+4M8HezyAeEo/quzbJIvm3V1bbBUQwslkpy0=;
        b=gPrLfj8kAxIvtuqZO5n6Ut69hi2/FjcoIm7LIvIK5VYGRWlwMTXCvHKVhanO5v8XaW
         dUPn7AzUKtdQP5Gv8eKsANA9+1S2qTqyYuxcm1+lzkS5IuEzmM8lYqP7uK5bq68Vxi09
         F6hHcC4qDddS1li++oA+RjFlqGXwR86fHO7YmMoWkrX0xvMqDP6JcaI1uCAT4Am+p9cm
         FrR1Qt3wI3R3PhJxLgRD2U+9+SbxYF7xsD8h2aN+n/LFW+icH2f1nYTt/9xQi3fJNy+5
         owRza8Be7iPcRKudDbM5aT4JmLLT7pd46ktTfaNP/rFbaDlFUzv9fisNW3cGYVY2as4p
         ZLmQ==
X-Gm-Message-State: AOAM531GESAmAL3Bo1jJ4lPU2KtEGcvjljdWGZEkypa80wPSaPN909yO
        ebqSvthpKxKztiw4kv3L/0w=
X-Google-Smtp-Source: ABdhPJxfsDwiGrsoS/vr9Si9IT1bVFSQopIIFYjaFVU7j8bIa6HwuKOz5KVcRIz11U6S9GcBsrsN2g==
X-Received: by 2002:a17:902:d647:b029:e0:8ee:d8ac with SMTP id y7-20020a170902d647b02900e008eed8acmr16599867plh.4.1612793677701;
        Mon, 08 Feb 2021 06:14:37 -0800 (PST)
Received: from shinobu (113x37x72x20.ap113.ftth.ucom.ne.jp. [113.37.72.20])
        by smtp.gmail.com with ESMTPSA id h12sm18573203pgs.7.2021.02.08.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:14:35 -0800 (PST)
Date:   Mon, 8 Feb 2021 23:14:28 +0900
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
Message-ID: <YCFHRGbiVxpNgkQS@shinobu>
References: <20210208135347.18494-1-o.rempel@pengutronix.de>
 <20210208135347.18494-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7cf4ztcYRdl+KQEF"
Content-Disposition: inline
In-Reply-To: <20210208135347.18494-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7cf4ztcYRdl+KQEF
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

I haven't had a chance to do a proper review just yet, but a couple
things caught my eye as I skimmed so I want to mention them inline
below. I'll do a more complete review this weekend or soon after

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

The value pointed by this "action" parameter should be set to the index
of the action you want from your Synapse's ations[] array.

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

Same problem here as before: should be set to the index of the function
you want from your functions[] array.

William Breathitt Gray

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
> +
> +	priv->counter.name =3D dev_name(dev);
> +	priv->counter.parent =3D dev;
> +	priv->counter.ops =3D &priv->ops;
> +	priv->counter.counts =3D event_cnts;
> +	priv->counter.num_counts =3D ARRAY_SIZE(event_cnts);
> +	priv->counter.signals =3D event_cnt_signals;
> +	priv->counter.num_signals =3D ARRAY_SIZE(event_cnt_signals);
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

--7cf4ztcYRdl+KQEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmAhRywACgkQhvpINdm7
VJILtw//WfJKCocFo4GSt7kADLIFNZyvzCZ7ruUtC2CwVsKoQwFGW3mzd1uLYiCb
Hja0N2gTXr+MM5fDXLF/AFevnMojdRxcqjdOfia+9T+SsBEXIKGUS9wBUQfJfH7u
NzlkBrgUZNTyin88KD9Q5WDQfTTXqDAKAnocrRlX7ve/MXPYtlhaBWTDWPeZXohm
/4BFEdlHxJ1be3+swpLCevWMKRZsY+ibO2mzOx1gOfW+bDVjZNBzMpCqDvz2Rj3+
pIuARGYeg3BbbQRZfBexkFrfeeOUXDKjx8On++bUS0u7X+aSUb5k2Jt7OVm2F3SH
sv9CQfAsEwoXzjJM5/wqzUXPeElgC8WdF+03j3r22hWkulqMaqXNu8PCOtyMThzC
v99Xso8fRUlb0qBtMCmpdFSI1vRBfeMx1pf+KTxWQcjNTSzP0PmFbkuz9vj2sdgf
jdIKFcEVWcjAR8kYv10zpn3v6N0IrA6yrP6qBlJtXBGDNoMf8hm9irR+MXlsyxUo
abFW4HpyzX5skuaxpEcP2AFoutM6autw1P50RooxrVeuCJCEYhw6Y431DKtt1GgY
OA1njCkPsYuzfGJHv+ujAsVgew8kcMp32THLjE9Hg+yy7l6bfYWeLKnDc7bLjUb9
FYivFMKHugCTfxKURMzuN7nH/hU/ZC631pp8i0RjP+zNRYngB8g=
=X1Ab
-----END PGP SIGNATURE-----

--7cf4ztcYRdl+KQEF--
