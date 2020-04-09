Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA01A34AA
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgDINQ4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 09:16:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43659 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgDINQ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 09:16:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id z90so2315327qtd.10;
        Thu, 09 Apr 2020 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8d4nk7ETo3F3DA2kGe+80zUBojFlS+nov9CnWYSaabw=;
        b=T6HVKZbbBQzwTk1WBKchYfYSb6ZAsypwdwJ0wgHru42NQ+VebSRiQD7jeQrJUZ++cU
         Fdr/od4GEgNPMg9BQjzN5ox6E+z4vr5+Aui9Tpnc57em4QiUrZNieol9/2/kXSgrW8Le
         8rQI4bA/p1j29XDq9C+HlZCXA/ED8KcxJBeWWFh9VfCqRlmKzGPpqAyCm0oKd0z8Lz2s
         D0gYjQWazQGtnCNGqsqqH3gd1srwnHpf0+elQiue8Y8KEL1QF7w0PcbtDssm7E0GbZN0
         pBcOtCrTVRuB6HemqICQDeBgy7tUAxakbU+zUGTMM+toJR7PbjHZsXpNcLCerhTw1cq6
         6isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8d4nk7ETo3F3DA2kGe+80zUBojFlS+nov9CnWYSaabw=;
        b=ZpJifmXRFNWk60vNqUT9VHeuBvK+AteAef/19ae1X0Fnblcx4KKjWU20T18MXmtggB
         fhlaUCBrNREMU7/1/YgjQBGLHprhP+wTHnVh81EmbjI2KcEOVu1bbivyyqgp7Z9A7WDt
         AFL/fcxdqUvepkrP7L0Lmnr3Lx7LLXtXRFuQ5SNMArBU6I/+pTgDKYKlWIevgyUu4wkw
         ShtVgNSJR2DthxJQXxu1ANjSvF6NVOdbXO4XGut+mpC5qColmNqz6idRFm89GUUk4yBf
         oksYdaHryp805lct3XEk1qb+cbT0SwLBPfTsE5avvh7Rit7SaJ5FYIJ9YS/DpDHAMYyR
         xSCg==
X-Gm-Message-State: AGi0PuZLkh8OrHuXqIHlRAhN9KmBYLxgx79wec8JXoesWA4qQkjZVf/l
        QzyIDqM18dvzTgz6S5XjQhdB1rSSBBOXjw==
X-Google-Smtp-Source: APiQypI0RnqSsU+mhVCnGSI59Zc8nIKfSp2Nk+HKUuvbua569AJgAT0hjXbyf0p6SNUMR5mnorIiJA==
X-Received: by 2002:ac8:60a:: with SMTP id d10mr12651357qth.140.1586438214440;
        Thu, 09 Apr 2020 06:16:54 -0700 (PDT)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id g63sm17560672qkb.89.2020.04.09.06.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 06:16:53 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:16:37 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] counter: Add atmel TCB capture counter
Message-ID: <20200409131611.GA3511@icarus>
References: <20200406155320.1291701-1-kamel.bouhara@bootlin.com>
 <20200406155320.1291701-4-kamel.bouhara@bootlin.com>
 <20200408213013.GA30867@icarus>
 <20200409082531.GE1489441@kb-xps>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20200409082531.GE1489441@kb-xps>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2020 at 10:25:31AM +0200, Kamel Bouhara wrote:
> On Wed, Apr 08, 2020 at 05:31:03PM -0400, William Breathitt Gray wrote:
> > On Mon, Apr 06, 2020 at 05:53:20PM +0200, Kamel Bouhara wrote:
> > > This drivers allows to use the capture mode of the Timer Counter Block
> > > hardware block available in Atmel SoCs through the counter subsystem.
> > >
> > > Two functions of the counter are supported for the moment: period
> > > capture and quadrature decoder. The latter is only supported by the
> > > SAMA5 series of SoCs.
> > >
> > > For the period capture mode a basic setup has been chosen that will
> > > reset the counter each time the period is actually reached. Of course
> > > the device offers much more possibilities.
> > >
> > > For quadrature mode, both channel 0 and 1 must be configured even if =
we
> > > only capture the position (no revolution/rotation).
> > >
> > > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >
> > Hi Kamel,
> >
>=20
> Hi William,
>=20
> > Thank you for submitting support for this driver. Since this is a new
> > counter driver, make sure to create an entry for it in the top-level
> > MAINTAINERS file so users know who to contact to report bugs and other
> > issues.
> >
>=20
> I'll skip this if you're ok with the fact that the file name already
> match the at91 maintainers ?

No problem, you can skip this, I didn't realize it was already matching.

William Breathitt Gray

>=20
> > I've written some more comments inline below.
> >
> > > ---
> > >  drivers/counter/Kconfig             |  11 +
> > >  drivers/counter/Makefile            |   1 +
> > >  drivers/counter/atmel-tcb-capture.c | 388 ++++++++++++++++++++++++++=
++
> > >  3 files changed, 400 insertions(+)
> > >  create mode 100644 drivers/counter/atmel-tcb-capture.c
> > >
> > > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > > index c80fa76bb531..c50d7453ec33 100644
> > > --- a/drivers/counter/Kconfig
> > > +++ b/drivers/counter/Kconfig
> > > @@ -70,4 +70,15 @@ config FTM_QUADDEC
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called ftm-quaddec.
> > >
> > > +config ATMEL_TCB_CAPTURE
> > > +	tristate "Atmel Timer Counter Capture driver"
> > > +	depends on HAS_IOMEM && OF
> > > +	select REGMAP_MMIO
> > > +	help
> > > +	  Select this option to enable the Atmel Timer Counter Block
> > > +	  capture driver.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called atmel-tcb-capture.
> > > +
> > >  endif # COUNTER
> > > diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> > > index 55142d1f4c43..70c5b8924588 100644
> > > --- a/drivers/counter/Makefile
> > > +++ b/drivers/counter/Makefile
> > > @@ -10,3 +10,4 @@ obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
> > >  obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
> > >  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
> > >  obj-$(CONFIG_FTM_QUADDEC)	+=3D ftm-quaddec.o
> > > +obj-$(CONFIG_ATMEL_TCB_CAPTURE)	+=3D atmel-tcb-capture.o
> > > diff --git a/drivers/counter/atmel-tcb-capture.c b/drivers/counter/at=
mel-tcb-capture.c
> > > new file mode 100644
> > > index 000000000000..6ac809503f90
> > > --- /dev/null
> > > +++ b/drivers/counter/atmel-tcb-capture.c
> > > @@ -0,0 +1,388 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/**
> > > + * Copyright (C) 2020 Atmel
> > > + *
> > > + * Author: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > > + *
> > > + */
> > > +#include <linux/clk.h>
> > > +#include <linux/counter.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <soc/at91/atmel_tcb.h>
> > > +
> > > +#define ATMEL_TC_CMR_MASK	(ATMEL_TC_LDRA_RISING | ATMEL_TC_LDRB_FALL=
ING | \
> > > +				 ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_LDBDIS | \
> > > +				 ATMEL_TC_LDBSTOP)
> > > +
> > > +#define ATMEL_TC_QDEN			BIT(8)
> > > +#define ATMEL_TC_POSEN			BIT(9)
> > > +
> > > +struct atmel_tc_data {
> > > +	const struct atmel_tcb_config *tc_cfg;
> > > +	struct counter_device counter;
> > > +	struct regmap *regmap;
> > > +	int qdec_mode;
> > > +	int num_channels;
> > > +	int channel[2];
> > > +	bool trig_inverted;
> > > +};
> > > +
> > > +enum atmel_tc_count_function {
> > > +	ATMEL_TC_FUNCTION_INCREASE,
> > > +	ATMEL_TC_FUNCTION_QUADRATURE,
> > > +};
> > > +
> > > +static enum counter_count_function atmel_tc_count_functions[] =3D {
> > > +	[ATMEL_TC_FUNCTION_INCREASE] =3D COUNTER_COUNT_FUNCTION_INCREASE,
> > > +	[ATMEL_TC_FUNCTION_QUADRATURE] =3D COUNTER_COUNT_FUNCTION_QUADRATUR=
E_X4,
> > > +};
> > > +
> > > +enum atmel_tc_synapse_action {
> > > +	ATMEL_TC_SYNAPSE_ACTION_NONE =3D 0,
> > > +	ATMEL_TC_SYNAPSE_ACTION_RISING_EDGE,
> > > +	ATMEL_TC_SYNAPSE_ACTION_FALLING_EDGE,
> > > +	ATMEL_TC_SYNAPSE_ACTION_BOTH_EDGE
> > > +};
> > > +
> > > +static enum counter_synapse_action atmel_tc_synapse_actions[] =3D {
> > > +	[ATMEL_TC_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> > > +	[ATMEL_TC_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_RI=
SING_EDGE,
> > > +	[ATMEL_TC_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION_F=
ALLING_EDGE,
> > > +	[ATMEL_TC_SYNAPSE_ACTION_BOTH_EDGE] =3D COUNTER_SYNAPSE_ACTION_BOTH=
_EDGES,
> > > +};
> > > +
> > > +static struct counter_signal atmel_tc_count_signals[] =3D {
> > > +	{
> > > +		.id =3D 0,
> > > +		.name =3D "Channel A",
> > > +	},
> > > +	{
> > > +		.id =3D 1,
> > > +		.name =3D "Channel B",
> > > +	}
> > > +};
> > > +
> > > +static struct counter_synapse atmel_tc_count_synapses[] =3D {
> > > +	{
> > > +		.actions_list =3D atmel_tc_synapse_actions,
> > > +		.num_actions =3D ARRAY_SIZE(atmel_tc_synapse_actions),
> > > +		.signal =3D &atmel_tc_count_signals[0]
> > > +	},
> > > +	{
> > > +		.actions_list =3D atmel_tc_synapse_actions,
> > > +		.num_actions =3D ARRAY_SIZE(atmel_tc_synapse_actions),
> > > +		.signal =3D &atmel_tc_count_signals[1]
> > > +	}
> > > +};
> > > +
> > > +static int atmel_tc_count_function_get(struct counter_device *counte=
r,
> > > +				       struct counter_count *count,
> > > +				       size_t *function)
> > > +{
> > > +	struct atmel_tc_data *const priv =3D counter->priv;
> > > +
> > > +	if (priv->qdec_mode)
> > > +		*function =3D ATMEL_TC_FUNCTION_QUADRATURE;
> > > +	else
> > > +		*function =3D ATMEL_TC_FUNCTION_INCREASE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int atmel_tc_count_function_set(struct counter_device *counte=
r,
> > > +				       struct counter_count *count,
> > > +				       size_t function)
> > > +{
> > > +	struct atmel_tc_data *const priv =3D counter->priv;
> > > +	u32 bmr, cmr;
> > > +
> > > +	regmap_read(priv->regmap, ATMEL_TC_BMR, &bmr);
> > > +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr=
);
> > > +
> > > +	/* Set capture mode */
> > > +	cmr &=3D ~ATMEL_TC_WAVE;
> > > +
> > > +	switch (function) {
> > > +	case ATMEL_TC_FUNCTION_INCREASE:
> > > +		priv->qdec_mode =3D 0;
> > > +		/* Set highest rate based on whether soc has gclk or not */
> > > +		bmr &=3D ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
> > > +		if (priv->tc_cfg->has_gclk)
> > > +			cmr |=3D ATMEL_TC_TIMER_CLOCK2;
> > > +		else
> > > +			cmr |=3D ATMEL_TC_TIMER_CLOCK1;
> > > +		/* Setup the period capture mode */
> > > +		cmr |=3D  ATMEL_TC_CMR_MASK;
> > > +		cmr &=3D ~(ATMEL_TC_ABETRG | ATMEL_TC_XC0);
> > > +		break;
> > > +	case ATMEL_TC_FUNCTION_QUADRATURE:
> > > +		if (!priv->tc_cfg->has_qdec)
> > > +			return -ENODEV;
> >
> > I think returning an -EINVAL here might be better. I can understand that
> > the system does not have a quadrature encoder device in this case, but
> > from the user perspective they are requesting to set the function for
> > the existing counter device. Therefore, if the existing counter device
> > does not support the requested function, it makes sense to report the
> > issue as simply an invalid argument (return -EINVAL) for this particular
> > device.
> >
>=20
> Good point, fixed for v2.
>=20
> > > +		/* In QDEC mode settings both channels 0 and 1 are required */
> > > +		if (priv->num_channels < 2 || priv->channel[0] !=3D 0 ||
> > > +		    priv->channel[1] !=3D 1) {
> > > +			pr_err("Invalid channels number or id for quadrature mode\n");
> > > +			return -EINVAL;
> > > +		}
> > > +		priv->qdec_mode =3D 1;
> > > +		bmr |=3D ATMEL_TC_QDEN | ATMEL_TC_POSEN;
> > > +		cmr |=3D ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_ABETRG | ATMEL_TC_XC0;
> > > +		break;
> > > +	}
> > > +
> > > +	regmap_write(priv->regmap, ATMEL_TC_BMR, bmr);
> > > +	regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), cmr=
);
> > > +
> > > +	/* Enable clock and trigger counter */
> > > +	regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], CCR),
> > > +		     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
> > > +
> > > +	if (priv->qdec_mode) {
> > > +		regmap_write(priv->regmap,
> > > +			     ATMEL_TC_REG(priv->channel[1], CMR), cmr);
> > > +		regmap_write(priv->regmap,
> > > +			     ATMEL_TC_REG(priv->channel[1], CCR),
> > > +			     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int atmel_tc_count_signal_read(struct counter_device *counter,
> > > +				      struct counter_signal *signal,
> > > +				      enum counter_signal_value *val)
> > > +{
> > > +	struct atmel_tc_data *const priv =3D counter->priv;
> > > +	bool sigstatus;
> > > +	u32 sr;
> > > +
> > > +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], SR), &sr);
> > > +
> > > +	if (priv->trig_inverted)
> > > +		sigstatus =3D (sr & ATMEL_TC_MTIOB);
> > > +	else
> > > +		sigstatus =3D (sr & ATMEL_TC_MTIOA);
> > > +
> > > +	*val =3D sigstatus ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int atmel_tc_count_action_get(struct counter_device *counter,
> > > +				     struct counter_count *count,
> > > +				     struct counter_synapse *synapse,
> > > +				     size_t *action)
> > > +{
> > > +	struct atmel_tc_data *const priv =3D counter->priv;
> > > +	u32 cmr;
> > > +
> > > +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr=
);
> > > +
> > > +	*action =3D ATMEL_TC_SYNAPSE_ACTION_NONE;
> > > +
> > > +	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> > > +		*action =3D ATMEL_TC_SYNAPSE_ACTION_NONE;
> > > +	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
> > > +		*action =3D ATMEL_TC_SYNAPSE_ACTION_RISING_EDGE;
> > > +	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
> > > +		*action =3D ATMEL_TC_SYNAPSE_ACTION_FALLING_EDGE;
> > > +	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
> > > +		*action =3D ATMEL_TC_SYNAPSE_ACTION_BOTH_EDGE;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int atmel_tc_count_action_set(struct counter_device *counter,
> > > +				     struct counter_count *count,
> > > +				     struct counter_synapse *synapse,
> > > +				     size_t action)
> > > +{
> > > +	struct atmel_tc_data *const priv =3D counter->priv;
> > > +	u32 edge =3D ATMEL_TC_ETRGEDG_NONE;
> > > +
> > > +	switch (action) {
> > > +	case ATMEL_TC_SYNAPSE_ACTION_NONE:
> > > +		edge =3D ATMEL_TC_ETRGEDG_NONE;
> > > +		break;
> > > +	case ATMEL_TC_SYNAPSE_ACTION_RISING_EDGE:
> > > +		edge =3D ATMEL_TC_ETRGEDG_RISING;
> > > +		break;
> > > +	case ATMEL_TC_SYNAPSE_ACTION_FALLING_EDGE:
> > > +		edge =3D ATMEL_TC_ETRGEDG_FALLING;
> > > +		break;
> > > +	case ATMEL_TC_SYNAPSE_ACTION_BOTH_EDGE:
> > > +		edge =3D ATMEL_TC_ETRGEDG_BOTH;
> > > +		break;
> > > +	}
> > > +
> > > +	return regmap_write_bits(priv->regmap,
> > > +				ATMEL_TC_REG(priv->channel[0], CMR),
> > > +				ATMEL_TC_ETRGEDG, edge);
> >
> > Are users able to adjust the edges like this even if the device is
> > configured for QDEC mode? If not, you should return -EINVAL if the
> > device is in QDEC mode.
> >
>=20
> You're right, in QDEC mode, rising edge must be selected as the external
> trigger edge.
>=20
> Fixed.
>=20
> > > +}
> > > +
> > > +static int atmel_tc_count_read(struct counter_device *counter,
> > > +			       struct counter_count *count,
> > > +			       unsigned long *val)
> > > +{
> > > +	struct atmel_tc_data *const priv =3D counter->priv;
> > > +	u32 cnt;
> > > +
> > > +	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CV), &cnt);
> > > +	*val =3D cnt;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct counter_count atmel_tc_count =3D {
> > > +	.id =3D 0,
> > > +	.name =3D "Timer Counter",
> > > +	.functions_list =3D atmel_tc_count_functions,
> > > +	.num_functions =3D ARRAY_SIZE(atmel_tc_count_functions),
> > > +	.synapses =3D atmel_tc_count_synapses,
> > > +	.num_synapses =3D ARRAY_SIZE(atmel_tc_count_synapses),
> > > +};
> > > +
> > > +static struct counter_ops atmel_tc_ops =3D {
> > > +	.signal_read  =3D atmel_tc_count_signal_read,
> > > +	.count_read   =3D atmel_tc_count_read,
> > > +	.count_write  =3D NULL,
> >
> > No need to explicitly set count_write to NULL since it will be NULL by
> > default in this static structure.
> >
>=20
> Fixed, thanks.
>=20
> > > +	.function_get =3D atmel_tc_count_function_get,
> > > +	.function_set =3D atmel_tc_count_function_set,
> > > +	.action_get   =3D atmel_tc_count_action_get,
> > > +	.action_set   =3D atmel_tc_count_action_set
> > > +};
> > > +
> > > +static const struct atmel_tcb_config tcb_rm9200_config =3D {
> > > +		.counter_width =3D 16,
> > > +};
> > > +
> > > +static const struct atmel_tcb_config tcb_sam9x5_config =3D {
> > > +		.counter_width =3D 32,
> > > +};
> > > +
> > > +static const struct atmel_tcb_config tcb_sama5d2_config =3D {
> > > +		.counter_width =3D 32,
> > > +		.has_gclk =3D true,
> > > +		.has_qdec =3D true,
> > > +};
> > > +
> > > +static const struct atmel_tcb_config tcb_sama5d3_config =3D {
> > > +		.counter_width =3D 32,
> > > +		.has_qdec =3D true,
> > > +};
> > > +
> > > +static const struct of_device_id atmel_tc_of_match[] =3D {
> > > +	{ .compatible =3D "atmel,at91rm9200-tcb", .data =3D &tcb_rm9200_con=
fig, },
> > > +	{ .compatible =3D "atmel,at91sam9x5-tcb", .data =3D &tcb_sam9x5_con=
fig, },
> > > +	{ .compatible =3D "atmel,sama5d2-tcb", .data =3D &tcb_sama5d2_confi=
g, },
> > > +	{ .compatible =3D "atmel,sama5d3-tcb", .data =3D &tcb_sama5d3_confi=
g, },
> > > +	{ /* sentinel */ }
> > > +};
> > > +
> > > +static int atmel_tc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np =3D pdev->dev.of_node;
> > > +	const struct atmel_tcb_config *tcb_config;
> > > +	const struct of_device_id *match;
> > > +	struct atmel_tc_data *priv;
> > > +	char clk_name[] =3D "t0_clk";
> > > +	struct regmap *regmap;
> > > +	struct clk *clk[3];
> > > +	int channel;
> > > +	int ret, i;
> > > +
> > > +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	platform_set_drvdata(pdev, priv);
> > > +
> > > +	match =3D of_match_node(atmel_tc_of_match, np->parent);
> > > +	tcb_config =3D match->data;
> > > +	if (!tcb_config) {
> > > +		dev_err(&pdev->dev, "No matching parent node found\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	regmap =3D syscon_node_to_regmap(np->parent);
> > > +	if (IS_ERR(priv->regmap))
> > > +		return PTR_ERR(priv->regmap);
> > > +
> > > +	/* max. channels number is 2 when in QDEC mode */
> > > +	priv->num_channels =3D of_property_count_u32_elems(np, "reg");
> > > +	if (priv->num_channels < 0) {
> > > +		dev_err(&pdev->dev, "Invalid or missing channel\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Register channels and initialize clocks */
> > > +	for (i =3D 0; i < priv->num_channels; i++) {
> > > +		ret =3D of_property_read_u32_index(np, "reg", i, &channel);
> > > +		if (ret < 0 || channel > 2)
> > > +			return -ENODEV;
> > > +
> > > +		priv->channel[i] =3D channel;
> > > +
> > > +		clk_name[1] +=3D channel;
> >
> > You're being clever here (not a bad thing) but this looks too easy to
> > get wrong and confused. I'd much rather see a snprintf here for clarity
> > and know that nothing funny is going to happen.
> >
>=20
> Well ok let's be less clever for the sake of clarity :).
>=20
> > > +		clk[i] =3D of_clk_get_by_name(np->parent, clk_name);
> > > +		if (IS_ERR(clk[i])) {
> > > +			/* Fallback to t0_clk */
> > > +			clk[i] =3D of_clk_get_by_name(np->parent, "t0_clk");
> > > +			if (IS_ERR(clk[i]))
> > > +				return PTR_ERR(clk[i]);
> > > +		}
> > > +
> > > +		ret =3D clk_prepare_enable(clk[i]);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		dev_info(&pdev->dev,
> > > +			 "Initialized capture mode on channel %d\n",
> > > +			 channel);
> > > +	}
> > > +
> > > +	priv->tc_cfg =3D tcb_config;
> > > +	priv->regmap =3D regmap;
> > > +	priv->counter.name =3D dev_name(&pdev->dev);
> > > +	priv->counter.parent =3D &pdev->dev;
> > > +	priv->counter.ops =3D &atmel_tc_ops;
> > > +	priv->counter.num_counts =3D 1;
> >
> > Use ARRAY_SIZE here so that future reviewers will know that num_counts
> > matches what's in the atmel_tc_count array without having to check so
> > themselves.
> >
>=20
> OK, yet the atmel_tc_count isn't an array I guess that it shall be.
>=20
> Thanks,
>=20
> Kamel
>=20
> > William Breathitt Gray
> >
> > > +	priv->counter.counts =3D &atmel_tc_count;
> > > +	priv->counter.num_signals =3D ARRAY_SIZE(atmel_tc_count_signals);
> > > +	priv->counter.signals =3D atmel_tc_count_signals;
> > > +	priv->counter.priv =3D priv;
> > > +
> > > +	ret =3D devm_counter_register(&pdev->dev, &priv->counter);
> > > +	if (ret < 0) {
> > > +		for (i =3D 0; i < priv->num_channels; i++)
> > > +			clk_disable_unprepare(clk[i]);
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id atmel_tc_dt_ids[] =3D {
> > > +	{ .compatible =3D "atmel,tcb-capture", },
> > > +	{ /* sentinel */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, atmel_tc_dt_ids);
> > > +
> > > +static struct platform_driver atmel_tc_driver =3D {
> > > +	.probe =3D atmel_tc_probe,
> > > +	.driver =3D {
> > > +		.name =3D "atmel-tcb-capture",
> > > +		.of_match_table =3D atmel_tc_dt_ids,
> > > +	},
> > > +};
> > > +module_platform_driver(atmel_tc_driver);
> > > +
> > > +MODULE_AUTHOR("Kamel Bouhara <kamel.bouhara@bootlin.com>");
> > > +MODULE_DESCRIPTION("Atmel TCB Capture driver");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.25.0
> > >
>=20
>=20
>=20
> --
> Kamel Bouhara, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl6PIDUACgkQhvpINdm7
VJI6xw//a7ITzeLtqHNbovWZ9j9VXCuBjO+QSM61gqEpYceL2cfiWqLuxYV1YMuI
Xfi3eYIzA04Jyz4vkUogJJUOfwQHq75XqO1fZmNHTeHgEIwRCJ2xjzKbaQS/zxGK
CZzfzCT60m/fPB9th4Xo9PGjwN6Xv0AVcY73SkgL8uekIOCx1l7AJ5G3yvH1mGr+
Xx2u9IIh5LjYDW/Eimi7Fg9/yXOJfDjHrdozdyEPGFYv20XSV/VNdeaHcV6ypwK2
H50qAGRjet3JeBQqmpx0NyXFOe1ZzKbT6i75hmWt82gbtjZWT4O6fqSEJG2tezah
gbdNg2m8l++dQUGzt2Vfp0Q1qdD4k/8WBUQNeZKHrSlgOXvMIWbVuRhQexhOM6hN
d+GkKpc2zgBbeL2n1BYP0MCuhpkiiqtdHwiEyh5jp0IhXcnGPfmo3dJHsxrPJGuW
nIqchJ8fapinrc2thqLBaorF4NWbK58USyG+g3xrB8Sp7NkAO1m4PLZV+cbqma1m
Nc/XeSL9P+cGtgMp6616KC03ni3lx/ZL5lbA1KNc4vi5djh74M6aR1jxKJewWVNN
rk+DuSzxhqQWLBRCqPV4xIXXfLbp02OESQHwbuK9jKXf+170bKAI9gQk33Q29d9B
JveAIbDuidiMZbZudplXwkzXHXmEACWOuJjeHoU/GBI08duYl3U=
=xIkG
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
