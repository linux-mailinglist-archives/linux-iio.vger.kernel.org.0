Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867ED256DAC
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgH3Mms (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 08:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgH3Mmr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 08:42:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 704DE207DA;
        Sun, 30 Aug 2020 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598791365;
        bh=y2vp4dpoQuo56Uh2QqbVVL2d1a3SZoNlTyoln2GLUWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OtxO6Pz8gXNBQK+4CT/epmYznLkIad7xI7XtQdYuIfgWsNsiFLBzIviFLucQ6DeDH
         UC5UyBWdmbC30z302aRQw1dbwohvtm1+Ck38qtij3dTKnqMlU0wjXgdtTZi/FuWCVM
         l99nUAyvPJ2RGMpMecUPFlFCEjs/7lEWUKi23fZU=
Date:   Sun, 30 Aug 2020 13:42:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Darren Schachter <dts86@cornell.edu>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mporter@konsulko.com, robertcnelson@beagleboard.org,
        drew@beagleboard.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pulse: Support PWM capture with TI AM3358 eCAP
 module
Message-ID: <20200830134239.449bf411@archlinux>
In-Reply-To: <20200818153614.6438-1-dts86@cornell.edu>
References: <20200818153614.6438-1-dts86@cornell.edu>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Aug 2020 10:36:14 -0500
Darren Schachter <dts86@cornell.edu> wrote:

> This IIO driver adds support for PWM capture with the TI eCAP module.
> This driver is based on Matt Porter's eCAP driver from January 2014,
> which was never merged into the mainline [1]. Like Matt's code, this
> driver implements interrupt driven triggered buffer capture. However,
> the driver has been updated based on previous suggestions in the IIO
> mailing list. Additionally, support for prescalar control and finer
> polarity control has been included. Users can now configure the
> polarities of CAP1 and CAP2 individually, allowing for the measurement
> of a signal's high-time, low-time, or period.
> 
> [1] https://marc.info/?l=linux-iio&m=145968010427392&w=2
> 
> Signed-off-by: Darren Schachter <dts86@cornell.edu>
Hi Darren,

I'll review this as is, but from earlier feedback it seems we have
some other questions to answer before potentially taking this
into IIO. 

There is a fair bit of new ABI in here that all needs documenting.

Thanks,

Jonathan

> ---
>  drivers/iio/Kconfig              |   1 +
>  drivers/iio/Makefile             |   1 +
>  drivers/iio/industrialio-core.c  |   1 +
>  drivers/iio/pulse/Kconfig        |  18 +
>  drivers/iio/pulse/Makefile       |   6 +
>  drivers/iio/pulse/pulse_tiecap.c | 585 +++++++++++++++++++++++++++++++
>  include/uapi/linux/iio/types.h   |   1 +
>  7 files changed, 613 insertions(+)
>  create mode 100644 drivers/iio/pulse/Kconfig
>  create mode 100644 drivers/iio/pulse/Makefile
>  create mode 100644 drivers/iio/pulse/pulse_tiecap.c
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d5c073a8aa3e..0351b0dd209e 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -93,6 +93,7 @@ source "drivers/iio/potentiometer/Kconfig"
>  source "drivers/iio/potentiostat/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
> +source "drivers/iio/pulse/Kconfig"
>  source "drivers/iio/resolver/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
>  
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 1712011c0f4a..8a26c4a53b31 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -36,6 +36,7 @@ obj-y += potentiometer/
>  obj-y += potentiostat/
>  obj-y += pressure/
>  obj-y += proximity/
> +obj-y += pulse/
>  obj-y += resolver/
>  obj-y += temperature/
>  obj-y += trigger/
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 352533342702..6f4f0be474ef 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -86,6 +86,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
> +	[IIO_PULSE] = "pulse",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/drivers/iio/pulse/Kconfig b/drivers/iio/pulse/Kconfig
> new file mode 100644
> index 000000000000..802873df2d62
> --- /dev/null
> +++ b/drivers/iio/pulse/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# Pulse Capture Devices
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Pulse Capture Devices"
> +
> +config IIO_TIECAP
> +	tristate "TI ECAP Pulse Capture"
> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  If you say yes here you get support for the TI ECAP peripheral
> +	  in pulse capture mode. This driver can also be built as a
> +	  module. If so, the module will be called pulse_tiecap.
> +
> +endmenu
> diff --git a/drivers/iio/pulse/Makefile b/drivers/iio/pulse/Makefile
> new file mode 100644
> index 000000000000..8eefe9dd230b
> --- /dev/null
> +++ b/drivers/iio/pulse/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for IIO PWM Capture Device
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_IIO_TIECAP)	+= pulse_tiecap.o
> \ No newline at end of file

Fix that.

> diff --git a/drivers/iio/pulse/pulse_tiecap.c b/drivers/iio/pulse/pulse_tiecap.c
> new file mode 100644
> index 000000000000..feec6078895d
> --- /dev/null
> +++ b/drivers/iio/pulse/pulse_tiecap.c
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * ECAP pulse capture driver
> + *
> + * Copyright (C) 2020 Linaro Limited
> + * Author: Matt Porter <mporter@linaro.org>
> + * Author: Darren Schachter <dts86@cornell.edu>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

No need to repeat the license text if you have SPDX header.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +/* ECAP regs and bits */
> +#define ECAP_CAP1			0x08
> +#define ECAP_CAP2			0x0c
> +#define ECAP_ECCTL1			0x28
> +#define ECAP_ECCTL1_RUN_FREE		BIT(15)
> +#define ECAP_ECCTL1_CAPLDEN		BIT(8)
> +#define ECAP_ECCTL1_CAP2POL		BIT(2)
> +#define ECAP_ECCTL1_CTRRST1		BIT(1)
> +#define ECAP_ECCTL1_CAP1POL		BIT(0)
> +#define ECAP_ECCTL1_PRESCALE_OFFSET	9
> +#define ECAP_ECCTL1_PRESCALE_MASK	(0x1F << ECAP_ECCTL1_PRESCALE_OFFSET)
> +#define ECAP_ECCTL2			0x2a
> +#define ECAP_ECCTL2_SYNCO_SEL_DIS	BIT(7)
> +#define ECAP_ECCTL2_TSCTR_FREERUN	BIT(4)
> +#define ECAP_ECCTL2_REARM		BIT(3)
> +#define ECAP_ECCTL2_STOP_WRAP_2		BIT(1)
> +#define ECAP_ECEINT			0x2c
> +#define ECAP_ECFLG			0x2e
> +#define ECAP_ECCLR			0x30
> +#define ECAP_ECINT_CTRCMP		BIT(7)
> +#define ECAP_ECINT_CTRPRD		BIT(6)
> +#define ECAP_ECINT_CTROVF		BIT(5)
> +#define ECAP_ECINT_CEVT4		BIT(4)
> +#define ECAP_ECINT_CEVT3		BIT(3)
> +#define ECAP_ECINT_CEVT2		BIT(2)
> +#define ECAP_ECINT_CEVT1		BIT(1)
> +#define ECAP_ECINT_ALL		(ECAP_ECINT_CTRCMP |	\
> +				ECAP_ECINT_CTRPRD |	\
> +				ECAP_ECINT_CTROVF |	\
> +				ECAP_ECINT_CEVT4 |	\
> +				ECAP_ECINT_CEVT3 |	\
> +				ECAP_ECINT_CEVT2 |	\
> +				ECAP_ECINT_CEVT1)
> +
> +/* ECAP driver flags */
> +#define ECAP_PRESCALAR_OFFSET	3
> +#define ECAP_POL_CAP2_OFFSET	2
> +#define ECAP_POL_CAP1_OFFSET	1
> +#define ECAP_ENABLED			0
> +#define ECAP_PRESCALAR(flags)	(((uint8_t)(flags >> ECAP_PRESCALAR_OFFSET)) & 0x1F)

Masks should use GENMASK
I'm not sure why you need that uint8_t cast?


> +
> +
> +struct ecap_context {
> +	u32 cap1;
> +	u32 cap2;
> +	u16 ecctl1;
> +	u16 ecctl2;
> +	u16 eceint;
> +};
> +
> +struct ecap_state {
> +	unsigned long   flags;	// keep track of state (enabled, polarity, etc.)
> +	struct mutex    lock;
> +	unsigned int    clk_rate;
> +	void __iomem    *regs;
> +	u32		*buf;
> +	struct ecap_context ctx;
> +};
> +
> +#define dev_to_ecap_state(d) iio_priv(dev_to_iio_dev(d))
> +
> +static const struct iio_chan_spec ecap_channels[] = {
> +	{
> +		.type			= IIO_PULSE,
> +		.channel		= 0,
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index		= 0,
> +		.scan_type = {
> +			.sign		= 'u',
> +			.realbits	= 32,
> +			.storagebits	= 32,
> +			.endianness	= IIO_LE,
> +		},
> +		.modified	= 0,

Modified == 0 is an obviously default so no need to state it.

> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +static ssize_t ecap_attr_pol_cap1_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	return sprintf(buf, "%d\n",
> +				test_bit(ECAP_POL_CAP1_OFFSET, &state->flags));
> +}
> +
> +static ssize_t ecap_attr_pol_cap1_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t len)
> +{
> +	int ret;
> +	bool val;
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	if (test_bit(ECAP_ENABLED, &state->flags))
> +		return -EINVAL;
> +
> +	ret = strtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val)
> +		set_bit(ECAP_POL_CAP1_OFFSET, &state->flags);
> +	else
> +		clear_bit(ECAP_POL_CAP1_OFFSET, &state->flags);
> +
> +	return len;
> +}
> +
> +static ssize_t ecap_attr_pol_cap2_show(struct device *dev,
> +					struct device_attribute *attr, char *buf)
> +{
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	return sprintf(buf, "%d\n",
> +				test_bit(ECAP_POL_CAP2_OFFSET, &state->flags));
> +}
> +
> +static ssize_t ecap_attr_pol_cap2_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t len)
> +{
> +	int ret;
> +	bool val;
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	if (test_bit(ECAP_ENABLED, &state->flags))
> +		return -EINVAL;
> +
> +	ret = strtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +

The locking around state->flags is a bit uneven.
Whilst these are atomic they could happen mid way through
the read modify write cycles elsewhere and leave things in an odd state.

> +	if (val)
> +		set_bit(ECAP_POL_CAP2_OFFSET, &state->flags);
> +	else
> +		clear_bit(ECAP_POL_CAP2_OFFSET, &state->flags);
> +
> +	return len;
> +}
> +
> +static ssize_t ecap_attr_prescalar_show(struct device *dev,
> +					struct device_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	mutex_lock(&state->lock);
> +	ret = sprintf(buf, "%x\n", ECAP_PRESCALAR(state->flags));
> +	mutex_unlock(&state->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t ecap_attr_prescalar_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t len)
> +{
> +	int ret;
> +	long val;
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	if (test_bit(ECAP_ENABLED, &state->flags))
> +		return -EINVAL;
> +
> +	ret = kstrtol(buf, 16, &val);
> +	if (val > 0x05 && val != 0x1E && val != 0x1F)

That odd set of rules needs a comment to explain what is going on.

> +		return -EINVAL;
> +
> +	mutex_lock(&state->lock);
> +	state->flags &= ~(0x1F << ECAP_PRESCALAR_OFFSET); // clear bits

Comment is fairly obvious and in wrong style so just get rid of it.

> +	state->flags |= (val << ECAP_PRESCALAR_OFFSET);
> +	mutex_unlock(&state->lock);
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(pulse_cap1pol, 0644,
> +	ecap_attr_pol_cap1_show, ecap_attr_pol_cap1_store, 0);
> +static IIO_DEVICE_ATTR(pulse_cap2pol, 0644,
> +	ecap_attr_pol_cap2_show, ecap_attr_pol_cap2_store, 0);
> +static IIO_DEVICE_ATTR(pulse_prescalar, 0644,
> +	ecap_attr_prescalar_show, ecap_attr_prescalar_store, 0);
> +
> +static struct attribute *ecap_attributes[] = {
> +	&iio_dev_attr_pulse_cap1pol.dev_attr.attr,
> +	&iio_dev_attr_pulse_cap2pol.dev_attr.attr,
> +	&iio_dev_attr_pulse_prescalar.dev_attr.attr,

This is custom ABI so needs to documented in a suitable file
under

Documentation/ABI/testing/sysfs-bus-iio*

That lets us assess whether these can map to exsiting ABI.
I suspect prescaler could be but I haven't looked at what it actually is.


> +	NULL
> +};
> +
> +static struct attribute_group ecap_attribute_group = {
> +	.attrs = ecap_attributes,
> +};
> +
> +static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
> +	//.owner = THIS_MODULE;
Unusual to not have at least an enable tied up to a trigger.

If the trigger is only useful for this device and is sufficiently
tightly coupled to the buffer (like here) then there is no need to
expose the trigger at all.

We have other devices that provide buffered access without triggers.

> +};
> +
> +
> +static int ecap_read_raw(struct iio_dev *idev,
> +				struct iio_chan_spec const *ch, int *val,
> +				int *val2, long mask)
> +{
> +	struct ecap_state *state = iio_priv(idev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = NSEC_PER_SEC / state->clk_rate;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +// (note: driver_module is no longer a field of iio_info)
> +static const struct iio_info ecap_info = {
> +	//.driver_module = THIS_MODULE,

Please remove from driver before posting.

> +	.attrs = &ecap_attribute_group,
> +	.read_raw = &ecap_read_raw
> +};
> +
> +static irqreturn_t ecap_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct ecap_state *state = iio_priv(idev);
> +
> +	/* Read pulse counter value */
> +	*state->buf = readl(state->regs + ECAP_CAP2);
> +
> +	dev_dbg(&idev->dev, "TIECAP: Value: %d, Time: %lld\n", *state->buf, pf->timestamp);
> +
> +	iio_push_to_buffers_with_timestamp(idev, state->buf, pf->timestamp);
> +
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ecap_buffer_predisable(struct iio_dev *idev)
> +{
> +	struct ecap_state *state = iio_priv(idev);
> +	int ret = 0;
> +	u16 ecctl2;
> +
> +	dev_dbg(&idev->dev, "TIECAP: Buffer pre disable...\n");
> +
> +	//ret = iio_triggered_buffer_predisable(idev);
> +
> +	/* Stop capture */
> +	clear_bit(ECAP_ENABLED, &state->flags);
> +	ecctl2 = readw(state->regs + ECAP_ECCTL2) & ~ECAP_ECCTL2_TSCTR_FREERUN;
> +	writew(ecctl2, state->regs + ECAP_ECCTL2);
> +
> +	/* Disable and clear all interrupts */
> +	writew(0, state->regs + ECAP_ECEINT);
> +	writew(ECAP_ECINT_ALL, state->regs + ECAP_ECCLR);
> +
> +	pm_runtime_put_sync(idev->dev.parent);
> +
> +	return ret;
> +}
> +
> +static int ecap_buffer_postenable(struct iio_dev *idev)
> +{
> +	struct ecap_state *state = iio_priv(idev);
> +	int ret = 0;
> +	u16 ecctl1, ecctl2;
> +
> +	dev_dbg(&idev->dev, "TIECAP: Buffer post enable...\n");
> +
> +	pm_runtime_get_sync(idev->dev.parent);
> +
> +	ecctl1 = readw(state->regs + ECAP_ECCTL1);
> +
> +	/* Configure pulse polarity */
> +	if (test_bit(ECAP_POL_CAP1_OFFSET, &state->flags)) {
> +		/* CAP1 falling */
> +		ecctl1 |= ECAP_ECCTL1_CAP1POL;
> +	} else {
> +		/* CAP1 rising */
> +		ecctl1 &= ~ECAP_ECCTL1_CAP1POL;
> +	}
> +
> +	if (test_bit(ECAP_POL_CAP2_OFFSET, &state->flags)) {
> +		/* CAP2 falling */
> +		ecctl1 |= ECAP_ECCTL1_CAP2POL;
> +	} else {
> +		/* CAP2 rising */
> +		ecctl1 &= ~ECAP_ECCTL1_CAP2POL;
> +	}
> +
> +	/* Configure pulse prescalar */
> +	ecctl1 &= ~ECAP_ECCTL1_PRESCALE_MASK;
> +	ecctl1 |= (ECAP_PRESCALAR(state->flags) << ECAP_ECCTL1_PRESCALE_OFFSET);
> +
> +	writew(ecctl1, state->regs + ECAP_ECCTL1);
> +

One blank line is all that's ever needed.

> +
> +	/* Enable CAP2 interrupt */
> +	writew(ECAP_ECINT_CEVT2, state->regs + ECAP_ECEINT);
> +
> +	/* Enable capture */
> +	ecctl2 = readw(state->regs + ECAP_ECCTL2);
> +	ecctl2 |= ECAP_ECCTL2_TSCTR_FREERUN | ECAP_ECCTL2_REARM;
> +	writew(ecctl2, state->regs + ECAP_ECCTL2);
> +	set_bit(ECAP_ENABLED, &state->flags);
> +
> +	//ret = iio_triggered_buffer_postenable(idev);

Please remove this stuff. It just adds noise to what we are reviewing here.


> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ecap_buffer_setup_ops = {
> +	.postenable = &ecap_buffer_postenable,
> +	.predisable = &ecap_buffer_predisable
> +};
> +
> +static irqreturn_t ecap_interrupt_handler(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct ecap_state *state = iio_priv(idev);
> +	u16 ints;
> +
> +	dev_dbg(&idev->dev, "TIECAP: Interrupt handling...\n");
> +
> +	iio_trigger_poll(idev->trig);
> +
> +	/* Clear CAP2 interrupt */
> +	ints = readw(state->regs + ECAP_ECFLG);
> +	if (ints & ECAP_ECINT_CEVT2)
> +		writew(ECAP_ECINT_CEVT2, state->regs + ECAP_ECCLR);
> +	else
> +		dev_warn(&idev->dev, "unhandled interrupt flag: %04x\n", ints);

This should be in the try_reenable callback I think to ensure we are actually
done with the interrupt.  Will also allow us to use the trigger to gather
other measurements at roughly the same time.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void ecap_init_hw(struct iio_dev *idev)
> +{
> +	struct ecap_state *state = iio_priv(idev);
> +
> +	// Update flags

Kernel comment syntax is
/* Update flags */

> +	state->flags &= 0;

= 0 seems easier to read.

> +
> +	// Initialize with CAP1 = rising, CAP2 = falling
> +	// (measure the on-time of the signal)
> +	set_bit(ECAP_POL_CAP2_OFFSET, &state->flags);
> +
> +	// Configure ECAP module
> +	writew(ECAP_ECCTL1_RUN_FREE | ECAP_ECCTL1_CAPLDEN |
> +			ECAP_ECCTL1_CAP2POL | ECAP_ECCTL1_CTRRST1,
> +			state->regs + ECAP_ECCTL1);
> +	writew(ECAP_ECCTL2_SYNCO_SEL_DIS | ECAP_ECCTL2_STOP_WRAP_2,
> +			state->regs + ECAP_ECCTL2);
> +}
> +
> +static int ecap_probe(struct platform_device *pdev)
> +{
> +	int irq, ret;
> +	struct iio_dev *idev;
> +	struct clk *clk;
> +	struct ecap_state *state;
> +	struct resource *r;
> +	struct iio_trigger *trig;
> +
> +	dev_dbg(&pdev->dev, "TIECAP: Probing....\n");

I would reduce the number of debug prints.
They tend to not be that useful once a driver is known to work.

> +
> +	idev = devm_iio_device_alloc(&pdev->dev, sizeof(struct ecap_state));

sizeof(*state) preferred.

> +	if (!idev)
> +		return -ENOMEM;

Add a blank line after error checks like this. It makes the flow a bit
easier to read.

> +	state = iio_priv(idev);
> +
> +	mutex_init(&state->lock);
> +
> +	clk = devm_clk_get(&pdev->dev, "fck");
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "failed to get clock\n");
> +		return PTR_ERR(clk);
> +	}
> +
> +	state->clk_rate = clk_get_rate(clk);

Does it make sense to read and cache this?  I guess it unlikely to change
but conversely people only tend to read scale infrequently so we could
read it there and be fairly sure the value read was up to date.

> +	if (!state->clk_rate) {
> +		dev_err(&pdev->dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	platform_set_drvdata(pdev, idev);
> +
> +	idev->dev.parent = &pdev->dev;
> +	idev->name = dev_name(&pdev->dev);
> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &ecap_info;
> +	idev->channels = ecap_channels;
> +	/* One h/w capture and one s/w timestamp channel per instance */
> +	idev->num_channels = 2;
> +
> +	trig = devm_iio_trigger_alloc(&pdev->dev, "%s-dev%d",
> +						idev->name, idev->id);

Odd indenting.  Should align after opening bracket on the line above.

> +
> +	if (!trig)
> +		return -ENOMEM;

As above.  A blank line here.

> +	trig->dev.parent = idev->dev.parent;
> +	iio_trigger_set_drvdata(trig, idev);
> +	trig->ops = &iio_interrupt_trigger_ops;
> +
> +	ret = iio_trigger_register(trig);

I'm not seeing where you unregister the trigger.
This could probably use devm_iio_trigger_register.

> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register trigger\n");
> +		return ret;
> +	}
> +
> +	ret = iio_triggered_buffer_setup(idev, &iio_pollfunc_store_time,
> +						&ecap_trigger_handler,
> +						&ecap_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no irq is specified\n");
> +		return irq;
> +	}

Blank line here.

> +	ret = devm_request_irq(&pdev->dev, irq,
> +				&ecap_interrupt_handler,
> +				0, dev_name(&pdev->dev), idev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to register device\n");
> +		goto uninit_buffer;
> +	}
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	state->regs = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(state->regs)) {
> +		dev_err(&pdev->dev, "unable to remap registers\n");
> +		ret = PTR_ERR(state->regs);
> +		goto uninit_buffer;
> +	}
> +
> +	ret = iio_device_register(idev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "unable to register device\n");
> +		goto uninit_buffer;
> +	}
> +
> +	state->buf = devm_kzalloc(&idev->dev, idev->scan_bytes, GFP_KERNEL);

A driver shouldn't be accessing scan_bytes directly.
Also I assume it has a fixed size?  
Hence you might as well just put the array directly in state.
Note however, that iio_push_to_buffers_with_timestamp requires the buffer
is 8 byte aligned.  So you will need to mark buf __aligned(8)


> +	if (!state->buf) {
> +		ret = -ENOMEM;
> +		goto uninit_buffer;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
> +	ecap_init_hw(idev);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +
> +	dev_dbg(&pdev->dev, "TIECAP: Probe complete.\n");
> +
> +	return 0;
> +
> +uninit_buffer:
> +	iio_triggered_buffer_cleanup(idev);
> +
> +	return ret;
> +}
> +
> +static int ecap_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *idev = platform_get_drvdata(pdev);
> +
> +	iio_device_unregister(idev);
> +
> +	pm_runtime_disable(&pdev->dev);

Given pm_runtime_enable is after iio_device_register, we should
really be doing this before iio_device_unregister.

> +
> +	iio_triggered_buffer_cleanup(idev);
As this is the last element, we should be safe to use devm_iio_trigger_buffer_setup
That will also make the code more obviously correct by keeping the
ecap_remove ordering the reverse of what happens in ecap_probe.

> +
> +	dev_dbg(&pdev->dev, "TIECAP: Module removed.\n");
> +	return 0;
> +}
> +
> +static int __maybe_unused ecap_suspend(struct device *dev)
> +{
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	dev_dbg(dev, "TIECAP: Module suspended.\n");
> +
> +	pm_runtime_get_sync(dev);
> +	state->ctx.cap1 = readl(state->regs + ECAP_CAP1);
> +	state->ctx.cap2 = readl(state->regs + ECAP_CAP2);
> +	state->ctx.eceint = readw(state->regs + ECAP_ECEINT);
> +	state->ctx.ecctl1 = readw(state->regs + ECAP_ECCTL1);
> +	state->ctx.ecctl2 = readw(state->regs + ECAP_ECCTL2);
> +	pm_runtime_put_sync(dev);
> +
> +	/* If capture was active, disable eCAP */
> +	if (test_bit(ECAP_ENABLED, &state->flags))
> +		pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ecap_resume(struct device *dev)
> +{
> +	struct ecap_state *state = dev_to_ecap_state(dev);
> +
> +	dev_dbg(dev, "TIECAP: Module resumed.\n");
> +
> +	/* If capture was active, enable ECAP */
> +	if (test_bit(ECAP_ENABLED, &state->flags))
> +		pm_runtime_get_sync(dev);
> +
> +	pm_runtime_get_sync(dev);
> +	writel(state->ctx.cap1, state->regs + ECAP_CAP1);
> +	writel(state->ctx.cap2, state->regs + ECAP_CAP2);
> +	writew(state->ctx.eceint, state->regs + ECAP_ECEINT);
> +	writew(state->ctx.ecctl1, state->regs + ECAP_ECCTL1);
> +	writew(state->ctx.ecctl2, state->regs + ECAP_ECCTL2);
> +	pm_runtime_put_sync(dev);

Nice to have a blank line before simple returns like this.
Just makes the code flow a tiny bit more obvious to a quick
read.

> +	return 0;
> +}
> +
> +
> +static SIMPLE_DEV_PM_OPS(ecap_pm_ops, ecap_suspend, ecap_resume);
> +
> +static const struct of_device_id ecap_of_ids[] = {
> +	{ .compatible   = "ti,am33xx-ecap" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ecap_of_ids);
> +
> +/* Platform driver information */
> +static struct platform_driver ecap_driver = {
> +	.driver = {
> +		.name = "ecap_pulse", // the name "ecap" is used by the pwm_tiecap module
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(ecap_of_ids),

Please drop of_match_ptr and any protections on CONFIG_OF.
That just stops us doing ACPI probing.  Whilst that may not
matter for this particular part I am keen to avoid this anti
pattern being introduced in more new drivers.  Slowly working
through removing it from existing ones!

Note that also involves using the generic fw parsing functions
rather than the of specific ones if relevant. Mind you I don't think
you actually have any.

> +		.pm = &ecap_pm_ops,
> +	},
> +	.probe = ecap_probe,
> +	.remove = ecap_remove,
> +};
> +module_platform_driver(ecap_driver);
> +
> +/* Module information */
> +MODULE_DESCRIPTION("TI eCAP driver");
> +MODULE_AUTHOR("Matt Porter <porter@linaro.org>, Darren Schachter <dts86@cornell.edu>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index fdd81affca4b..3c8d85c39177 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -47,6 +47,7 @@ enum iio_chan_type {
>  	IIO_POSITIONRELATIVE,
>  	IIO_PHASE,
>  	IIO_MASSCONCENTRATION,
> +	IIO_PULSE,
>  };
>  
>  enum iio_modifier {

