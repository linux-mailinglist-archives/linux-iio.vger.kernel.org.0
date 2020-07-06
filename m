Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2AA215F42
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jul 2020 21:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGFTW3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jul 2020 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgGFTW2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jul 2020 15:22:28 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76481C061755;
        Mon,  6 Jul 2020 12:22:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 6so4611601qtt.0;
        Mon, 06 Jul 2020 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mSJURApmI0XDof06xJ/040FaP4Lsh5mGIGPGO2bsB/M=;
        b=OfXPLxQhnN1C4VhJbywVpRV1QvyRFIivwpwKCYCtLxWJ0FER8CciLYtuQQtLlJtbaM
         PNldACCzgmSsP2Qeq/GEVN9usr9z6caH5errs6HQdTImw3/gxSLigzrhm5ECARjepcv6
         FJcBaHLl/CQQThwk/97qTzbClKLbs+v0B3HYo8a2s17QYVH8TRN+rji/ls3SU7nuEvDV
         7W/boAtatzuWvFgDxjvVPXiKT5E7j01wbYeewyctQoUrYpBXJEbTSYecTYH8OjA/Cc7y
         SZbchaRGs6iMJE9hdyiG7Uwz28JYLDUj8mYfwkEXeWLj3OzmfBMJ0k0FLYrvZ1d9NWcw
         Z4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mSJURApmI0XDof06xJ/040FaP4Lsh5mGIGPGO2bsB/M=;
        b=Wqht/l3q1gxZPmMq2nbSgG0kpK2bYiVJYynSi+q3A4o552zpKDmV94qAw9Fdeyzz5c
         2znKsTVMFPoSe3QpJut+7pFfhIQajbN1Nkwb99xO2GFTVNMsiG2adVgk1ujhWY05EtDH
         MOGqR0YPAqendUrl6YVbZX0S9HXRNk3Dc6Yc1fpBn6VVzcMsBAF7NIorw6yAJbg7A5sq
         0owfcAB+jOCVfymd54YKDOgvytf/1YoAqqxyDhH2hTIzXkDU7NCo9S2vPBb6Pt95sP1p
         k1mMHwssFjlK7luQZbDkpW6daYBSGBE3LSPIpZsilTg+ZGtsB6pDLSAsGxTPk3NQENuE
         cBZQ==
X-Gm-Message-State: AOAM530zZa3b/oFazOhRcZ5491PZ+ysJQW4XUkBNZ15lJs/2QpgXNOuO
        71ZK82pvodJ+yyLdNtqAG4FWu9RoFB0WRw==
X-Google-Smtp-Source: ABdhPJzaC9pIEkdr/4a1VWrNRAtcG8XjdiaWpw2EtWMDvYMvDQPNdXBwtpF7hclIQsJyDCNJf9r2Qg==
X-Received: by 2002:ac8:1654:: with SMTP id x20mr37305665qtk.83.1594063347589;
        Mon, 06 Jul 2020 12:22:27 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id u27sm20950782qkm.121.2020.07.06.12.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 12:22:26 -0700 (PDT)
Date:   Mon, 6 Jul 2020 15:22:12 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     jic23@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 5/5] counter: Add microchip TCB capture counter
Message-ID: <20200706192212.GA12483@shinobu>
References: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
 <20200706114347.174452-6-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20200706114347.174452-6-kamel.bouhara@bootlin.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2020 at 01:43:47PM +0200, Kamel Bouhara wrote:
> This drivers allows to use the capture mode of the Timer Counter Block
> hardware block available in Microchip SoCs through the counter subsystem.
>=20
> Two functions of the counter are supported for the moment: period
> capture and quadrature decoder. The latter is only supported by the
> SAMA5 series of SoCs.
>=20
> For the period capture mode a basic setup has been chosen that will
> reset the counter each time the period is actually reached. Of course
> the device offers much more possibilities.
>=20
> For quadrature mode, both channel 0 and 1 must be configured even if we
> only capture the position (no revolution/rotation).
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

Hi Kamel,

I wasn't sure if I had already signed off on this, but just in case I took
another look over this patch and it seems good to me. Feel free to add my
Signed-off-by line if there are no changes to this patch in the future.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/Kconfig                 |  11 +
>  drivers/counter/Makefile                |   1 +
>  drivers/counter/microchip-tcb-capture.c | 397 ++++++++++++++++++++++++
>  3 files changed, 409 insertions(+)
>  create mode 100644 drivers/counter/microchip-tcb-capture.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index c80fa76bb531..2de53ab0dd25 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -70,4 +70,15 @@ config FTM_QUADDEC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ftm-quaddec.
> =20
> +config MICROCHIP_TCB_CAPTURE
> +	tristate "Microchip Timer Counter Capture driver"
> +	depends on HAS_IOMEM && OF
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the Microchip Timer Counter Block
> +	  capture driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called microchip-tcb-capture.
> +
>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index 55142d1f4c43..0a393f71e481 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
>  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
>  obj-$(CONFIG_FTM_QUADDEC)	+=3D ftm-quaddec.o
> +obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+=3D microchip-tcb-capture.o
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/mi=
crochip-tcb-capture.c
> new file mode 100644
> index 000000000000..f7b7743ddb94
> --- /dev/null
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/**
> + * Copyright (C) 2020 Microchip
> + *
> + * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
> + */
> +#include <linux/clk.h>
> +#include <linux/counter.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <soc/at91/atmel_tcb.h>
> +
> +#define ATMEL_TC_CMR_MASK	(ATMEL_TC_LDRA_RISING | ATMEL_TC_LDRB_FALLING =
| \
> +				 ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_LDBDIS | \
> +				 ATMEL_TC_LDBSTOP)
> +
> +#define ATMEL_TC_QDEN			BIT(8)
> +#define ATMEL_TC_POSEN			BIT(9)
> +
> +struct mchp_tc_data {
> +	const struct atmel_tcb_config *tc_cfg;
> +	struct counter_device counter;
> +	struct regmap *regmap;
> +	int qdec_mode;
> +	int num_channels;
> +	int channel[2];
> +	bool trig_inverted;
> +};
> +
> +enum mchp_tc_count_function {
> +	MCHP_TC_FUNCTION_INCREASE,
> +	MCHP_TC_FUNCTION_QUADRATURE,
> +};
> +
> +static enum counter_count_function mchp_tc_count_functions[] =3D {
> +	[MCHP_TC_FUNCTION_INCREASE] =3D COUNTER_COUNT_FUNCTION_INCREASE,
> +	[MCHP_TC_FUNCTION_QUADRATURE] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +};
> +
> +enum mchp_tc_synapse_action {
> +	MCHP_TC_SYNAPSE_ACTION_NONE =3D 0,
> +	MCHP_TC_SYNAPSE_ACTION_RISING_EDGE,
> +	MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE,
> +	MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE
> +};
> +
> +static enum counter_synapse_action mchp_tc_synapse_actions[] =3D {
> +	[MCHP_TC_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> +	[MCHP_TC_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_RISING_=
EDGE,
> +	[MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION_FALLIN=
G_EDGE,
> +	[MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE] =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGE=
S,
> +};
> +
> +static struct counter_signal mchp_tc_count_signals[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "Channel A",
> +	},
> +	{
> +		.id =3D 1,
> +		.name =3D "Channel B",
> +	}
> +};
> +
> +static struct counter_synapse mchp_tc_count_synapses[] =3D {
> +	{
> +		.actions_list =3D mchp_tc_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(mchp_tc_synapse_actions),
> +		.signal =3D &mchp_tc_count_signals[0]
> +	},
> +	{
> +		.actions_list =3D mchp_tc_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(mchp_tc_synapse_actions),
> +		.signal =3D &mchp_tc_count_signals[1]
> +	}
> +};
> +
> +static int mchp_tc_count_function_get(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      size_t *function)
> +{
> +	struct mchp_tc_data *const priv =3D counter->priv;
> +
> +	if (priv->qdec_mode)
> +		*function =3D MCHP_TC_FUNCTION_QUADRATURE;
> +	else
> +		*function =3D MCHP_TC_FUNCTION_INCREASE;
> +
> +	return 0;
> +}
> +
> +static int mchp_tc_count_function_set(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      size_t function)
> +{
> +	struct mchp_tc_data *const priv =3D counter->priv;
> +	u32 bmr, cmr;
> +
> +	regmap_read(priv->regmap, ATMEL_TC_BMR, &bmr);
> +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
> +
> +	/* Set capture mode */
> +	cmr &=3D ~ATMEL_TC_WAVE;
> +
> +	switch (function) {
> +	case MCHP_TC_FUNCTION_INCREASE:
> +		priv->qdec_mode =3D 0;
> +		/* Set highest rate based on whether soc has gclk or not */
> +		bmr &=3D ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
> +		if (priv->tc_cfg->has_gclk)
> +			cmr |=3D ATMEL_TC_TIMER_CLOCK2;
> +		else
> +			cmr |=3D ATMEL_TC_TIMER_CLOCK1;
> +		/* Setup the period capture mode */
> +		cmr |=3D  ATMEL_TC_CMR_MASK;
> +		cmr &=3D ~(ATMEL_TC_ABETRG | ATMEL_TC_XC0);
> +		break;
> +	case MCHP_TC_FUNCTION_QUADRATURE:
> +		if (!priv->tc_cfg->has_qdec)
> +			return -EINVAL;
> +		/* In QDEC mode settings both channels 0 and 1 are required */
> +		if (priv->num_channels < 2 || priv->channel[0] !=3D 0 ||
> +		    priv->channel[1] !=3D 1) {
> +			pr_err("Invalid channels number or id for quadrature mode\n");
> +			return -EINVAL;
> +		}
> +		priv->qdec_mode =3D 1;
> +		bmr |=3D ATMEL_TC_QDEN | ATMEL_TC_POSEN;
> +		cmr |=3D ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_ABETRG | ATMEL_TC_XC0;
> +		break;
> +	}
> +
> +	regmap_write(priv->regmap, ATMEL_TC_BMR, bmr);
> +	regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), cmr);
> +
> +	/* Enable clock and trigger counter */
> +	regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], CCR),
> +		     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
> +
> +	if (priv->qdec_mode) {
> +		regmap_write(priv->regmap,
> +			     ATMEL_TC_REG(priv->channel[1], CMR), cmr);
> +		regmap_write(priv->regmap,
> +			     ATMEL_TC_REG(priv->channel[1], CCR),
> +			     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mchp_tc_count_signal_read(struct counter_device *counter,
> +				     struct counter_signal *signal,
> +				     enum counter_signal_value *val)
> +{
> +	struct mchp_tc_data *const priv =3D counter->priv;
> +	bool sigstatus;
> +	u32 sr;
> +
> +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], SR), &sr);
> +
> +	if (priv->trig_inverted)
> +		sigstatus =3D (sr & ATMEL_TC_MTIOB);
> +	else
> +		sigstatus =3D (sr & ATMEL_TC_MTIOA);
> +
> +	*val =3D sigstatus ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> +
> +	return 0;
> +}
> +
> +static int mchp_tc_count_action_get(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    struct counter_synapse *synapse,
> +				    size_t *action)
> +{
> +	struct mchp_tc_data *const priv =3D counter->priv;
> +	u32 cmr;
> +
> +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
> +
> +	*action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> +
> +	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> +		*action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> +	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
> +		*action =3D MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
> +	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
> +		*action =3D MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
> +	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
> +		*action =3D MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
> +
> +	return 0;
> +}
> +
> +static int mchp_tc_count_action_set(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    struct counter_synapse *synapse,
> +				    size_t action)
> +{
> +	struct mchp_tc_data *const priv =3D counter->priv;
> +	u32 edge =3D ATMEL_TC_ETRGEDG_NONE;
> +
> +	/* QDEC mode is rising edge only */
> +	if (priv->qdec_mode)
> +		return -EINVAL;
> +
> +	switch (action) {
> +	case MCHP_TC_SYNAPSE_ACTION_NONE:
> +		edge =3D ATMEL_TC_ETRGEDG_NONE;
> +		break;
> +	case MCHP_TC_SYNAPSE_ACTION_RISING_EDGE:
> +		edge =3D ATMEL_TC_ETRGEDG_RISING;
> +		break;
> +	case MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE:
> +		edge =3D ATMEL_TC_ETRGEDG_FALLING;
> +		break;
> +	case MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE:
> +		edge =3D ATMEL_TC_ETRGEDG_BOTH;
> +		break;
> +	}
> +
> +	return regmap_write_bits(priv->regmap,
> +				ATMEL_TC_REG(priv->channel[0], CMR),
> +				ATMEL_TC_ETRGEDG, edge);
> +}
> +
> +static int mchp_tc_count_read(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      unsigned long *val)
> +{
> +	struct mchp_tc_data *const priv =3D counter->priv;
> +	u32 cnt;
> +
> +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CV), &cnt);
> +	*val =3D cnt;
> +
> +	return 0;
> +}
> +
> +static struct counter_count mchp_tc_counts[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "Timer Counter",
> +		.functions_list =3D mchp_tc_count_functions,
> +		.num_functions =3D ARRAY_SIZE(mchp_tc_count_functions),
> +		.synapses =3D mchp_tc_count_synapses,
> +		.num_synapses =3D ARRAY_SIZE(mchp_tc_count_synapses),
> +	},
> +};
> +
> +static struct counter_ops mchp_tc_ops =3D {
> +	.signal_read  =3D mchp_tc_count_signal_read,
> +	.count_read   =3D mchp_tc_count_read,
> +	.function_get =3D mchp_tc_count_function_get,
> +	.function_set =3D mchp_tc_count_function_set,
> +	.action_get   =3D mchp_tc_count_action_get,
> +	.action_set   =3D mchp_tc_count_action_set
> +};
> +
> +static const struct atmel_tcb_config tcb_rm9200_config =3D {
> +		.counter_width =3D 16,
> +};
> +
> +static const struct atmel_tcb_config tcb_sam9x5_config =3D {
> +		.counter_width =3D 32,
> +};
> +
> +static const struct atmel_tcb_config tcb_sama5d2_config =3D {
> +		.counter_width =3D 32,
> +		.has_gclk =3D true,
> +		.has_qdec =3D true,
> +};
> +
> +static const struct atmel_tcb_config tcb_sama5d3_config =3D {
> +		.counter_width =3D 32,
> +		.has_qdec =3D true,
> +};
> +
> +static const struct of_device_id atmel_tc_of_match[] =3D {
> +	{ .compatible =3D "atmel,at91rm9200-tcb", .data =3D &tcb_rm9200_config,=
 },
> +	{ .compatible =3D "atmel,at91sam9x5-tcb", .data =3D &tcb_sam9x5_config,=
 },
> +	{ .compatible =3D "atmel,sama5d2-tcb", .data =3D &tcb_sama5d2_config, },
> +	{ .compatible =3D "atmel,sama5d3-tcb", .data =3D &tcb_sama5d3_config, },
> +	{ /* sentinel */ }
> +};
> +
> +static void mchp_tc_clk_remove(void *ptr)
> +{
> +	clk_disable_unprepare((struct clk *)ptr);
> +}
> +
> +static int mchp_tc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	const struct atmel_tcb_config *tcb_config;
> +	const struct of_device_id *match;
> +	struct mchp_tc_data *priv;
> +	char clk_name[7];
> +	struct regmap *regmap;
> +	struct clk *clk[3];
> +	int channel;
> +	int ret, i;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	match =3D of_match_node(atmel_tc_of_match, np->parent);
> +	tcb_config =3D match->data;
> +	if (!tcb_config) {
> +		dev_err(&pdev->dev, "No matching parent node found\n");
> +		return -ENODEV;
> +	}
> +
> +	regmap =3D syscon_node_to_regmap(np->parent);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	/* max. channels number is 2 when in QDEC mode */
> +	priv->num_channels =3D of_property_count_u32_elems(np, "reg");
> +	if (priv->num_channels < 0) {
> +		dev_err(&pdev->dev, "Invalid or missing channel\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Register channels and initialize clocks */
> +	for (i =3D 0; i < priv->num_channels; i++) {
> +		ret =3D of_property_read_u32_index(np, "reg", i, &channel);
> +		if (ret < 0 || channel > 2)
> +			return -ENODEV;
> +
> +		priv->channel[i] =3D channel;
> +
> +		snprintf(clk_name, sizeof(clk_name), "t%d_clk", channel);
> +
> +		clk[i] =3D of_clk_get_by_name(np->parent, clk_name);
> +		if (IS_ERR(clk[i])) {
> +			/* Fallback to t0_clk */
> +			clk[i] =3D of_clk_get_by_name(np->parent, "t0_clk");
> +			if (IS_ERR(clk[i]))
> +				return PTR_ERR(clk[i]);
> +		}
> +
> +		ret =3D clk_prepare_enable(clk[i]);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D devm_add_action_or_reset(&pdev->dev,
> +					       mchp_tc_clk_remove,
> +					       clk[i]);
> +		if (ret)
> +			return ret;
> +
> +		dev_dbg(&pdev->dev,
> +			"Initialized capture mode on channel %d\n",
> +			channel);
> +	}
> +
> +	priv->tc_cfg =3D tcb_config;
> +	priv->regmap =3D regmap;
> +	priv->counter.name =3D dev_name(&pdev->dev);
> +	priv->counter.parent =3D &pdev->dev;
> +	priv->counter.ops =3D &mchp_tc_ops;
> +	priv->counter.num_counts =3D ARRAY_SIZE(mchp_tc_counts);
> +	priv->counter.counts =3D mchp_tc_counts;
> +	priv->counter.num_signals =3D ARRAY_SIZE(mchp_tc_count_signals);
> +	priv->counter.signals =3D mchp_tc_count_signals;
> +	priv->counter.priv =3D priv;
> +
> +	return devm_counter_register(&pdev->dev, &priv->counter);
> +}
> +
> +static const struct of_device_id mchp_tc_dt_ids[] =3D {
> +	{ .compatible =3D "microchip,tcb-capture", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mchp_tc_dt_ids);
> +
> +static struct platform_driver mchp_tc_driver =3D {
> +	.probe =3D mchp_tc_probe,
> +	.driver =3D {
> +		.name =3D "microchip-tcb-capture",
> +		.of_match_table =3D mchp_tc_dt_ids,
> +	},
> +};
> +module_platform_driver(mchp_tc_driver);
> +
> +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
> +MODULE_DESCRIPTION("Microchip TCB Capture driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.26.2
>=20

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8DedwACgkQhvpINdm7
VJKGZg//Wo+wIlG4tq14J2yfHAvWuWPu945hX6OjIFVqFc2L2V4f1Y8LslPt6SSL
yRtiiscpk/pqQs69OR2VpYsOXGU+wWxPmStqeJBav2nKwqZsNczrSDPIvQaRdkPE
CAxBuTG/3eE6W/indVHWP4i212kKDdYpC6+seOmotKpTwhniVNcRX7zaba5NFvep
i6QMOrWCoh/fyViibMdSNIfNgwTV5IIQPaDNB6cOYB7zEFh+EkDf300Xx/+A7eoA
8HgqyR3xuuZ2RHySg/RlAByyUdspWvjSngI8KlNFxFt05vvSaFjWiXusRRhkkif1
0ed0CoIL1q3qGDG+HOAJ+mBj/qDLDalzBifV2rLYeSYCGjt2+c24ulLmFuBPY64p
sRN0yORK9LosPheWRzIHHU7c8WErs4alGUmryJicmhxDdEtP0OtCxbyHFbHfvssd
7wpt/YGXH5tLpSijI0U/0vAFSh9hoh/+ybt6EdjAxwOQdpSbwJahz3TQidvgjt5p
Wla2cmNYe0YnRETpwMzEZ5b8ar3ze9IeFvO7/3pgJttLv3GMahLOXs5iU/j3hcfp
HnxNFTQZm0GXG+G8DePMHPtOacQ0eApuKXRbEWXTydhpQbKrrwqMM9STlV8fNKuV
mB4uAkLX0WI5zontjmyp5By7iZNrLkcUZzOlu/+u1T5kSSKQFao=
=TAH2
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
