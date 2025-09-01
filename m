Return-Path: <linux-iio+bounces-23602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F944B3EDB8
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 20:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB063AE27C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81193324B38;
	Mon,  1 Sep 2025 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu1Nr6oh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B91FF1C8;
	Mon,  1 Sep 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750691; cv=none; b=tF8B1WwXbtJfKGPJEkkP6EW2tlbiWQlumBqDuT1L6NeiSKLUz3NEvlKTzf/ax+oW6oU+n3EBcqr9o6e/gDOtt+DFyP7rEy0BWaxkUSPqzQ9LFQmymYClwCZyFLSPORztI/Am0a6R9AbqBQrRXTf2U8ac0ULzF0WgKEIj1Trpzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750691; c=relaxed/simple;
	bh=5Zf2YPshngsVOkG/Qo8FODQM43IPV/y1bmrRwQ/zpQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaf/NQ2z3zC8/3tL+NbVM3alfkUh+P7TrZkjDSOsYC1cW0oPqz2KGQfrptgt3p3hJR5+f2n/cOPS1chyWMkpiOiGWXRSVLQoXnavPM0aQ9Aq4pVgqqryVCGFSmBLZkKdC3exThSpZ1vp65Kp9TX5vt6XlGD/qWw057yNcxhdqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu1Nr6oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBABC4CEF0;
	Mon,  1 Sep 2025 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756750690;
	bh=5Zf2YPshngsVOkG/Qo8FODQM43IPV/y1bmrRwQ/zpQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mu1Nr6oh+SOYLrxMjOHH+8aLuUS/JNZb1eiS8U2FC59/j1E6NBqi4vzkQEcSVaaB+
	 ZaeooBEklgyfVYP/cgmTsWRe8fLGY8X1piDP37Z1KYW/z6ZKflBiGNSRRhZPnTTLpG
	 3rIkNAw6SSmGTqDQ4JDGrk/uoHoAUxUxbAowlGppThC6LxdvITn52wNZYMiQKCSklE
	 M03CMpt/9NxboPemzuN2P15LN5scKCcqfVLp3cOTnwpsYKAmxCVHVWqkODujPiy1FJ
	 t0Rad+0RCBBfrTCnmZWpqbZsCxQMURADoPI44LPz8RyBudz8bRXknyM2WNDBj2+ZBE
	 /exNCXJMwuzQg==
Date: Mon, 1 Sep 2025 19:18:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Karel Balej
 <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC
 ADC
Message-ID: <20250901191800.6a7674fe@jic23-huawei>
In-Reply-To: <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
	<20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Aug 2025 12:33:05 +0200
Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> wrote:

> Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> monitoring various system voltages and temperatures. Add the relevant
> register definitions to the MFD header and a driver for the ADC.
>=20
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

A few additional comments from me inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gp=
adc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4622d2525e0edeed89c6e6d43=
336b177590aa885
> --- /dev/null
> +++ b/drivers/iio/adc/88pm886-gpadc.c

> +
> +#include <linux/mfd/88pm886.h>
> +
> +struct pm886_gpadc {
> +	struct regmap *map;
> +};
> +
> +static const int pm886_gpadc_regs[] =3D {
> +	PM886_REG_GPADC_VSC,
> +	PM886_REG_GPADC_VCHG_PWR,
> +	PM886_REG_GPADC_VCF_OUT,
> +	PM886_REG_GPADC_VBAT,
> +	PM886_REG_GPADC_VBAT_SLP,
> +	PM886_REG_GPADC_VBUS,
> +
> +	PM886_REG_GPADC_GPADC0,
> +	PM886_REG_GPADC_GPADC1,
> +	PM886_REG_GPADC_GPADC2,
> +	PM886_REG_GPADC_GPADC3,
> +
> +	PM886_REG_GPADC_GND_DET1,
> +	PM886_REG_GPADC_GND_DET2,
> +	PM886_REG_GPADC_MIC_DET,
> +
> +	PM886_REG_GPADC_TINT,
> +};
> +
> +/* Must be kept in sync with the table above */
Define this first and use it to assign the table entries
[VSC_CHAN] =3D PM886_REG_GPADC_VSC,=20
etc and then no need for the comment as they will naturally

> +enum pm886_gpadc_channel {
> +	VSC_CHAN,
> +	VCHG_PWR_CHAN,
> +	VCF_OUT_CHAN,
> +	VBAT_CHAN,
> +	VBAT_SLP_CHAN,
> +	VBUS_CHAN,
> +
> +	GPADC0_CHAN,
> +	GPADC1_CHAN,
> +	GPADC2_CHAN,
> +	GPADC3_CHAN,
> +
> +	GND_DET1_CHAN,
> +	GND_DET2_CHAN,
> +	MIC_DET_CHAN,
> +
> +	TINT_CHAN,
> +};

> +static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel c=
han)
> +{
> +	struct pm886_gpadc *gpadc =3D iio_priv(iio);
> +	__be16 buf;
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(gpadc->map, pm886_gpadc_regs[chan], &buf, size=
of(buf));
> +	return !ret ? be16_to_cpu(buf) >> 4 : ret;

At very least flip the logic, probably better not using a ternary at all th=
ough.

> +}

>
> +static int
> +__pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *=
chan,
> +		       int *val, int *val2, long mask)
> +{
> +	unsigned long lsb =3D chan->address;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val =3D gpadc_get_raw(iio, chan->channel);
> +		if (*val < 0)
> +			return *val;
> +
> +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D lsb;
> +		*val2 =3D (MICRO / MILLI);
> +		return chan->type =3D=3D IIO_VOLTAGE
> +		       ? IIO_VAL_FRACTIONAL
> +		       : IIO_VAL_INT;

Split it so that in the IIO_VAL_INT case you don't set val2.
This is a case where burning a few lines for clearer code is a good idea.
Similar to the other case Andy pointed out.

> +
> +static int pm886_gpadc_setup(struct regmap *map, bool enable)
I wonder if you should just split this as only 1-2 lines are actually shared

static int pm886_gpadc_enable(struct regmap *map)
{
	const u8 config[] =3D {
		PM886_GPADC_CONFIG1_EN_ALL,
		PM886_GPADC_CONFIG2_EN_ALL,
		PM886_GPADC_GND_DET2_EN
	};
	int ret;

	/* Enable the ADC block */
	ret =3D regmap_set_bits(map, PM886_REG_GPADC_CONFIG(0x6), BIT(0));
	if (ret)
		return ret;

	/* Enable all channels */
	return regmap_bulk_write(map, PM886_REG_GPADC_CONFIG(0x1), config, ARRAY_S=
IZE(config));
}

static int pm886_gpadc_disable(struct regmap *map)
{
	return regmap_clear_bits(map, PM886_REG_GPADC_CONFIG(0x6), BIT(0));
}

Which I think ends up only 1 line longer than the more complex combined fun=
ction.

> +{
> +	const u8 config[] =3D {
> +		PM886_GPADC_CONFIG1_EN_ALL,
> +		PM886_GPADC_CONFIG2_EN_ALL,
> +		PM886_GPADC_GND_DET2_EN
> +	};
> +	int ret;
> +
> +	/* Enable/disable the ADC block */
> +	ret =3D regmap_assign_bits(map, PM886_REG_GPADC_CONFIG(0x6), BIT(0), en=
able);
> +	if (ret)
> +		return ret;
> +
> +	if (!enable)
> +		return 0;
> +
> +	/* If enabling, enable all channels */
> +	return regmap_bulk_write(map, PM886_REG_GPADC_CONFIG(0x1), config, ARRA=
Y_SIZE(config));
> +}

> +static int pm886_gpadc_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *iio =3D dev_get_drvdata(dev);
> +	struct pm886_gpadc *gpadc =3D iio_priv(iio);
> +
> +	return pm886_gpadc_setup(gpadc->map, true);
> +}
> +
> +static int pm886_gpadc_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *iio =3D dev_get_drvdata(dev);
> +	struct pm886_gpadc *gpadc =3D iio_priv(iio);
> +
> +	return pm886_gpadc_setup(gpadc->map, false);
> +}

