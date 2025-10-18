Return-Path: <linux-iio+bounces-25254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8491BED869
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DF819A5BE1
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C8927B353;
	Sat, 18 Oct 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGwVCgbJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70927263B;
	Sat, 18 Oct 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814663; cv=none; b=uL4RWdmwMi+etVcxlyjvEUYkT41VmNeIGjZqByx0ZlGj27S9U1NHqWYefEUkku8P243woMwujaMihaltWC/PHts6EUcV3V9oDvHf2rctyjbO34MM+rWrqCt6ZFk2Qj4eqPE1PWCMCMxt0jhs9J+8NGgYeHf15HRhMWu/ysODQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814663; c=relaxed/simple;
	bh=P/VoKpC1CNUIZ+LSMrTePdg6XIKlZEX2nKBrmafJEGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbT8noXlLNDoiQkrve7wpSOCl3500Lph5Qb52+qjvj+Wb3NoIbUhYGnLydrGFs82yZ/86LARlDmXo0RItbDs/7Lp1DERA8jLfhsGQiao2i5jZ9kKLV4Z2n0dI8IJA5vXw2AB8cyip74rD+0oPKhsL7pdYC5dmKjM+73lYwcGm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGwVCgbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AC6C4CEF8;
	Sat, 18 Oct 2025 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760814662;
	bh=P/VoKpC1CNUIZ+LSMrTePdg6XIKlZEX2nKBrmafJEGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TGwVCgbJ7SaFO2m8lx6rb/CR4cit0sXneHInHIcvLuo1pWXoAOKiXqp0QYY7/HlZE
	 a/YCgdV99p8KQx861Fq+QHrb1/ofCK/ZCHrCeKzd+zpa+g3cLLgvpb1wuKCxQJoTEx
	 BqiQWN/4kJoklWaufTZqhBy2gfWwx+dG3p+AWgF7pg2ovcjxDecWRx8mSId5xj7aV8
	 dV8U6OMUSzdrxEJq3hWYBt8Y16TP7k9aCA2WNNC4puuVMNusroSFbbO4M5FYc2WrGH
	 zh6cJQ6Ul94hYHYi76hpa/Kt3nakakblChV7dLEiHIFGGYjezkY3NiQ7jLDLXmc53R
	 zJ7JY8SlwkztA==
Date: Sat, 18 Oct 2025 20:10:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <20251018201052.464041af@jic23-huawei>
In-Reply-To: <20251015142816.1274605-3-herve.codina@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 16:28:14 +0200
"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com> wrote:

> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ACD cores (ADC1
> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.
> 
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
Hi Herve,

A few additional things inline from me.  I may well have overlapped with
the review Nuno did but tried to avoid doing it too much!

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/rzn1-adc.c b/drivers/iio/adc/rzn1-adc.c
> new file mode 100644
> index 000000000000..f5e16b9cdf17
> --- /dev/null
> +++ b/drivers/iio/adc/rzn1-adc.c
> @@ -0,0 +1,626 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/N1 ADC driver
> + *
> + * Copyright (C) 2025 Schneider-Electric
> + *
> + * Author: Herve Codina <herve.codina@bootlin.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/completion.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>

I didn't see anything around iio_maps in here so
don't think you need this or driver.h

In general check these follow the slightly vague
version of Include What you Use (IWYU) that we try to follow for
kernel drivers.

> +#include <linux/iio/driver.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/bits.h>
> +#include <linux/of.h>
once of_match_ptr() is gone, this probably doesn't want to be here.
mod_devicetable.h does though for the id table.

> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
I'm not sure if there is a specific order to these headers.
If not, go with alphabetical.

> +
> +/*                  ADC1 ADC2
> + * RZ/N1D, BGA 400   y    y
> + * RZ/N1D, BGA 324   y    n
> + * RZ/N1S, BGA 324   y    n
> + * RZ/N1S, BGA 196   y    n
> + * RZ/N1L, BGA 196   y    n
> + */
> +
> +#define RZN1_ADC_CONTROL_REG	0x2c
> +#define RZN1_ADC_CONTROL_ADC_BUSY	BIT(6)
> +#define RZN1_ADC_FORCE_REG		0x30
> +#define RZN1_ADC_SET_FORCE_REG		0x34
> +#define RZN1_ADC_CLEAR_FORCE_REG	0x38
> +#define RZN1_ADC_FORCE_VC(_n)		BIT(_n)
> +
> +#define RZN1_ADC_CONFIG_REG	0x40
> +#define RZN1_ADC_CONFIG_ADC_POWER_DOWN	BIT(3)
> +
> +#define RZN1_ADC_VC_REG(_n)	(0xc0 + 0x4 * (_n))
> +#define RZN1_ADC_VC_ADC2_ENABLE		BIT(16)
> +#define RZN1_ADC_VC_ADC1_ENABLE		BIT(15)
> +#define RZN1_ADC_VC_ADC2_CHANNEL_SEL_MASK	GENMASK(5, 3)
> +#define RZN1_ADC_VC_ADC2_CHANNEL_SEL(_c)	FIELD_PREP(RZN1_ADC_VC_ADC2_CHANNEL_SEL_MASK, _c)
> +#define RZN1_ADC_VC_ADC1_CHANNEL_SEL_MASK	GENMASK(2, 0)
> +#define RZN1_ADC_VC_ADC1_CHANNEL_SEL(_c)	FIELD_PREP(RZN1_ADC_VC_ADC1_CHANNEL_SEL_MASK, _c)

Similar to below. I'd just have the slightly longer FIELD_PREP() inline

> +
> +#define RZN1_ADC_ADC1_DATA_REG(_n)	(0x100 + 0x4 * (_n))
> +#define RZN1_ADC_ADC2_DATA_REG(_n)	(0x140 + 0x4 * (_n))
> +#define RZN1_ADC_ADCX_DATA_DATA_MASK	GENMASK(11, 0)
> +#define RZN1_ADC_ADCX_GET_DATA(_reg)	FIELD_GET(RZN1_ADC_ADCX_DATA_DATA_MASK, _reg)
For this one and some of the others I'm not convinced the extra macro
adds value over just using FIELD_GET() inline.
Your defines have good names, so it is pretty clear what is going on from
just the field name.


> +static int rzn1_adc_core_get_vref_mv(struct rzn1_adc_core *adc_core)
Is this realistically going to change at runtime?

Long time back we always wrote drivers to allow for that happening
but in reality it turned out people very rarely use vrefs that are
adjusted after power up, so these days it's generally acceptable to grab
voltages at power up and use those for all time.

> +{
> +	int vref_uv;
> +
> +	if (!adc_core->vref)
> +		return -ENODEV;
> +
> +	vref_uv = regulator_get_voltage(adc_core->vref);
> +	if (vref_uv < 0)
> +		return vref_uv;
> +
> +	return vref_uv / 1000;
> +}

> +
> +static int rzn1_adc_read_raw_ch(struct rzn1_adc *rzn1_adc, unsigned int chan, int *val)
> +{
> +	u32 *adc1_data, *adc2_data;
> +	int adc1_ch, adc2_ch;
> +	u32 adc_data;
> +	int ret;
> +
> +	if (chan < 8) {
> +		/* chan 0..7 used to get ADC1 ch 0..7 */
> +		adc1_ch = chan;
> +		adc1_data = &adc_data;
> +		adc2_ch = -1;
> +		adc2_data = NULL;
> +	} else if (chan < 16) {
> +		/* chan 8..15 used to get ADC2 ch 0..7 */
> +		adc1_ch = -1;
> +		adc1_data = NULL;
> +		adc2_ch = chan - 8;
> +		adc2_data = &adc_data;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(rzn1_adc->dev);
There is a new toy to simplify code flow like this (see recent commits
to pm_runtime.h for more info). Note this went in during the merge window
and so has very few users yet.  I plan to look at how thoroughly we
can use it in other drivers when I get some time.  The ACQUIRE() stuff
can also probably work for some other things like claiming direct mode.
Given how new it is, I'm not going to insist on anyone using it for
runtime pm just yet.

	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
	if (ret < 0)
		return ret;

	guard(mutex)(&rzn1_adc->lock);

Then you can return directly in all error cases rather than needing the goto end;
Not that this is only a good idea in cases like this where all gotos become unnecessary/
Mixing the two is a bad idea (as cleanup.h docs call out)

> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&rzn1_adc->lock);
> +
> +	rzn1_adc_vc_setup_conversion(rzn1_adc, chan, adc1_ch, adc2_ch);
> +
> +	ret = rzn1_adc_vc_start_conversion(rzn1_adc, chan);
> +	if (ret)
> +		goto end;
> +
> +	ret = rzn1_adc_vc_wait_conversion(rzn1_adc, chan, adc1_data, adc2_data);
> +	if (ret) {
> +		rzn1_adc_vc_stop_conversion(rzn1_adc, chan);
> +		goto end;
> +	}
> +
> +	*val = adc_data;
> +	ret = IIO_VAL_INT;
> +
> +end:
> +	mutex_unlock(&rzn1_adc->lock);
> +
> +	pm_runtime_mark_last_busy(rzn1_adc->dev);

As below. This no longer needs to be explicitly called.

> +	pm_runtime_put_autosuspend(rzn1_adc->dev);
> +
> +	return ret;
> +}



> +
> +static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> +					 struct iio_dev *indio_dev)
> +{
> +	int adc_used;
> +
> +	adc_used = rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> +	adc_used |= rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> +
> +	switch (adc_used) {
> +	case 0x01:
> +		indio_dev->channels = rzn1_adc1_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_channels);
> +		return 0;
> +	case 0x02:
> +		indio_dev->channels = rzn1_adc2_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc2_channels);
> +		return 0;
> +	case 0x03:
> +		indio_dev->channels = rzn1_adc1_adc2_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_adc2_channels);

Are we likely to see more complex sets?  If not the bitmap seems like an
unnecessary bit of extra complexity.

> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	dev_err(rzn1_adc->dev, "Failed to set IIO channels, no ADC core used\n");
> +	return -ENODEV;
> +}
> +
> +static int rzn1_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct rzn1_adc *rzn1_adc;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*rzn1_adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	rzn1_adc = iio_priv(indio_dev);
> +	rzn1_adc->dev = dev;
> +	mutex_init(&rzn1_adc->lock);
For new code small preference for enabling the debug stuff that
	ret = devm_mutex_init()
	if (ret)
		return ret;

ends up registering.  I'm not sure it will often be useful but it is
now cheap to turn on.

> +
> +	rzn1_adc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzn1_adc->regs))
> +		return PTR_ERR(rzn1_adc->regs);
> +
> +	rzn1_adc->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(rzn1_adc->pclk))
> +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to get pclk\n");
> +
> +	rzn1_adc->adc_clk = devm_clk_get(dev, "adc-clk");
> +	if (IS_ERR(rzn1_adc->pclk))
> +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to get adc-clk\n");
> +
> +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[0],
> +					   "adc1-avdd", "adc1-vref");
> +	if (ret)
> +		return ret;
> +
> +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[1],
> +					   "adc2-avdd", "adc2-vref");
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &rzn1_adc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	ret = rzn1_adc_set_iio_dev_channels(rzn1_adc, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = rzn1_adc_enable(rzn1_adc);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		goto disable;
> +
> +	pm_runtime_mark_last_busy(dev);

No longer need this.  It is called inside pm_runtime_put_autosuspend()

> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +disable:
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +
> +	rzn1_adc_disable(rzn1_adc);

So this came up in Nuno's review and I think you said you were looking at it,,
but at this level moving the whole lot to devm seems likely to simplify things
a little at least.

> +	return ret;
> +}
> +
> +static void rzn1_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
> +
> +	pm_runtime_disable(rzn1_adc->dev);
> +	pm_runtime_set_suspended(rzn1_adc->dev);
> +	pm_runtime_dont_use_autosuspend(rzn1_adc->dev);
> +
> +	rzn1_adc_disable(rzn1_adc);
> +}

> +
> +static const struct dev_pm_ops rzn1_adc_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(rzn1_adc_pm_runtime_suspend, rzn1_adc_pm_runtime_resume, NULL)

Isn't this opencoded DEFINE_RUNTIME_DEV_PM_OPS()?

> +};
> +
> +static const struct of_device_id rzn1_adc_of_match[] = {
> +	{ .compatible = "renesas,rzn1-adc" },
> +	{ /* sentinel */ },
No trailing comma and the comment can go.  We kind of standardized
on
	{ }

in IIO for these a while back in the interests of consistency rather
than any strong reason to pick particular formatting over another.

> +};
> +
> +MODULE_DEVICE_TABLE(of, rzn1_adc_of_match);
> +
> +static struct platform_driver rzn1_adc_driver = {
> +	.probe = rzn1_adc_probe,
> +	.remove = rzn1_adc_remove,
> +	.driver = {
> +		.name = "rzn1-adc",
> +		.of_match_table = of_match_ptr(rzn1_adc_of_match),
I think Nuno already got this but drop of_match_ptr().
Sure we may not care about the other firmware types that can use
of_match_table (but are not OF) but in general I'd rather not have
examples of this in tree and in practice saving space for someone who
is building with COMPILE_TEST and no DT support is not a goal I care about ;)

> +		.pm = pm_ptr(&rzn1_adc_pm_ops),
> +	},
> +};


