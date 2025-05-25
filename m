Return-Path: <linux-iio+bounces-19863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990CEAC33DE
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E551754CF
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA31F03D7;
	Sun, 25 May 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS5PS7mf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E51E5206;
	Sun, 25 May 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748169432; cv=none; b=F0ZSaJWiv4mYutuxZS5oY450wPhM6gZIZebioplrqUByeu/psgVZpBZkvOaam95X2uQKnsEVKkFS12DNvFzCYrRqmVrdyxavzDhmVJZ3W14Vll+VAIEy/mcoqOhLDvcTGU62owRtuXGAxGPsD2nN6zeR2RriaX4lxLeeMqWPIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748169432; c=relaxed/simple;
	bh=FW5xPz9u+XNijdV+UBVWW95CfDN792tY8lVObzhxd/k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWFDswSqW8q8iXIR1qLJB8UQqdQnR3nEPBZnz+ZyhgI1xBCL5rpRpfeWmfPZ3IApx8uHTYWoi+DfscDMZsNOiGxqpLJPPAM52wY/SsuGuI10vlfLpPWTqCV+J6q0bFx8zwh7VzywxzrM9r0lUkGVp3TOZMe7+os0/vr3MBeWSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS5PS7mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C991C4CEEA;
	Sun, 25 May 2025 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748169431;
	bh=FW5xPz9u+XNijdV+UBVWW95CfDN792tY8lVObzhxd/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fS5PS7mf0SBAtaX0sWHbzNXOV4u6R1WbXGTFMBDODuwm3uMoudj1S8fEoWBks+oco
	 dLT2uf8mndzSVUBwVyTgRxqme0hdmaUVsSwj7rRhL6aQEdpioaMqUOf4mBGQBhuZOx
	 YwPvcrdwNzj6KDF7AwaNT+Aa51EM5Zhst1GX3ebORuD9unyDzpevmjtUpQ5AWSMFJf
	 mvMVFvvSmbTUHbVeBU6b6VYdXe94ICtxWxLOl4cIlXEqxLFUpCbKdZKSHULAxqF9vc
	 Nj3gmI9Jn9U1Jtj4B7E/bk4qPBKfESv+Z8irItycOJ2AeIJIWHFgjaNmK50fuKi6Yu
	 ZaB7HXPqz+N6Q==
Date: Sun, 25 May 2025 11:36:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ana-Maria
 Cusco <ana-maria.cusco@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 02/10] iio: adc: Add basic support for AD4170
Message-ID: <20250525113659.2661c8d7@jic23-huawei>
In-Reply-To: <2c308bf8464660079ec6da82a62316e9f2ebd5f7.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	<2c308bf8464660079ec6da82a62316e9f2ebd5f7.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 May 2025 09:34:00 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
>=20
> The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> analog to digital converter. The AD4170 design offers a flexible data
> aquisition solution with crosspoint multiplexed analog inputs, configurab=
le
> ADC voltage reference inputs, ultra-low noise integrated PGA, digital
> filtering, wide range of configurable output data rates, internal
> oscillator and temperature sensor, four GPIOs, and integrated features for
> interfacing with load cell weigh scales, RTD, and thermocouple sensors.
>=20
> Add basic support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Differential and pseudo-differential input configuration.
>=20
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

A few minor things inline.

J

> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> new file mode 100644
> index 000000000000..bf19b31095ee
> --- /dev/null
> +++ b/drivers/iio/adc/ad4170.c

> +
> +/*
> + * Verifies whether the channel configuration is valid by checking the p=
rovided
> + * input type, polarity, and voltage references result in a sane input r=
ange.
> + * Returns negative error code on failure.
> + */
> +static int ad4170_get_input_range(struct ad4170_state *st,
> +				  struct iio_chan_spec const *chan,
> +				  unsigned int ch_reg, unsigned int ref_sel)
> +{
> +	bool bipolar =3D chan->scan_type.sign =3D=3D 's';
> +	struct device *dev =3D &st->spi->dev;
> +	int refp, refn, ain_voltage, ret;
> +
> +	switch (ref_sel) {
> +	case AD4170_REF_REFIN1:
> +		if (st->vrefs_uv[AD4170_REFIN1P_SUP] =3D=3D -ENODEV ||
> +		    st->vrefs_uv[AD4170_REFIN1N_SUP] =3D=3D -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "REFIN=C2=B1 selected but not provided\n");
> +
> +		refp =3D st->vrefs_uv[AD4170_REFIN1P_SUP];
> +		refn =3D st->vrefs_uv[AD4170_REFIN1N_SUP];
> +		break;
> +	case AD4170_REF_REFIN2:
> +		if (st->vrefs_uv[AD4170_REFIN2P_SUP] =3D=3D -ENODEV ||
> +		    st->vrefs_uv[AD4170_REFIN2N_SUP] =3D=3D -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "REFIN2=C2=B1 selected but not provided\n");
> +
> +		refp =3D st->vrefs_uv[AD4170_REFIN2P_SUP];
> +		refn =3D st->vrefs_uv[AD4170_REFIN2N_SUP];
> +		break;
> +	case AD4170_REF_AVDD:
> +		refp =3D st->vrefs_uv[AD4170_AVDD_SUP];
> +		refn =3D st->vrefs_uv[AD4170_AVSS_SUP];
> +		break;
> +	case AD4170_REF_REFOUT:
> +		/* REFOUT is 2.5 V relative to AVSS */
> +		refp =3D st->vrefs_uv[AD4170_AVSS_SUP] + AD4170_INT_REF_2_5V;
> +		refn =3D st->vrefs_uv[AD4170_AVSS_SUP];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Find out the analog input range from the channel type, polarity, and
> +	 * voltage reference selection.
> +	 * AD4170 channels are either differential or pseudo-differential.
> +	 * Diff input voltage range: =E2=88=92VREF/gain to +VREF/gain (datashee=
t page 6)
> +	 * Pseudo-diff input voltage range: 0 to VREF/gain (datasheet page 6)
> +	 */
> +	if (chan->differential) {
> +		if (!bipolar)
> +			return dev_err_probe(&st->spi->dev, -EINVAL,

dev

> +					     "Channel %u differential unipolar\n",
> +					     ch_reg);
> +
> +		/*
> +		 * Differential bipolar channel.
> +		 * avss-supply is never above 0V.
> +		 * Assuming refin1n-supply not above 0V.
> +		 * Assuming refin2n-supply not above 0V.
> +		 */
> +		return refp + abs(refn);
> +	}
> +	/*
> +	 * Some configurations can lead to invalid setups.
> +	 * For example, if AVSS =3D -2.5V, REF_SELECT set to REFOUT (REFOUT/AVS=
S),
> +	 * and pseudo-diff channel configuration set, then the input range
> +	 * should go from 0V to +VREF (single-ended - datasheet pg 10), but
> +	 * REFOUT/AVSS range would be -2.5V to 0V.
> +	 * Check the positive reference is higher than 0V for pseudo-diff
> +	 * channels.
> +	 */
> +	if (refp <=3D 0)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,

dev

> +				     "REF+ <=3D GND for pseudo-diff chan %u\n",
> +				     ch_reg);
> +
> +	if (bipolar)
> +		return refp;
> +
> +	/*
> +	 * Pseudo-differential unipolar channel.
> +	 * Input expected to swing from IN- to +VREF.
> +	 */
> +	ret =3D ad4170_get_ain_voltage_uv(st, chan->channel2, &ain_voltage);
> +	if (ret)
> +		return ret;
> +
> +	if (refp - ain_voltage <=3D 0)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,

dev

> +				     "Negative input >=3D REF+ for pseudo-diff chan %u\n",
> +				     ch_reg);
> +
> +	return refp - ain_voltage;
> +}



> +static int ad4170_parse_reference(struct ad4170_state *st,
> +				  struct fwnode_handle *child,
> +				  struct ad4170_setup *setup)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +	u8 aux;
> +
> +	/* Optional positive reference buffering, if omitted we use the default=
 */

I'd drop the "if omitted" part as the next line makes that clear.

> +	aux =3D AD4170_REF_BUF_FULL; /* Default to full precharge buffer enable=
d. */
> +	ret =3D fwnode_property_read_u8(child, "adi,buffered-positive", &aux);
> +	if (!ret) {
> +		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)

Given default is within these limits (I assume!), can simplified as:

	aux =3D AD4170_REF_BUF_FULL;
	fwnode_property_read_u8(child, "adi,buffered-positive", &aux);
	if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
		return dev_err_probe(dev, -EINVAL,
				     "Invalid adi,buffered-positive: %u\n", aux);

	setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_BUF_P_MSK, aux);


> +					     aux);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid adi,buffered-positive: %u\n",
> +					     aux);
> +	}
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_BUF_P_MSK, aux);
> +
> +	/* Optional negative reference buffering, if omitted we use the default=
 */
> +	aux =3D AD4170_REF_BUF_FULL; /* Default to full precharge buffer enable=
d. */

Similar refactor to above applies here and dropping the obvious what happens
if omitted comment.

> +	ret =3D fwnode_property_read_u8(child, "adi,buffered-negative", &aux);
> +	if (!ret) {
> +		if (aux < AD4170_REF_BUF_PRE || aux > AD4170_REF_BUF_BYPASS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid adi,buffered-negative: %u\n",
> +					     aux);
> +	}
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_BUF_M_MSK, aux);
> +
> +	/* Optional voltage reference selection, if omitted we use the default =
*/
> +	aux =3D AD4170_REF_REFOUT; /* Default reference selection. */

And here.

> +	ret =3D fwnode_property_read_u8(child, "adi,reference-select", &aux);
> +	if (!ret) {
> +		if (aux > AD4170_REF_AVDD)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid reference selected %u\n",
> +					     aux);
> +	}
> +	setup->afe |=3D FIELD_PREP(AD4170_AFE_REF_SELECT_MSK, aux);
> +
> +	return 0;
> +}
> +
> +static int ad4170_parse_adc_channel_type(struct device *dev,
> +					 struct fwnode_handle *child,
> +					 struct iio_chan_spec *chan)
> +{
> +	u32 pins[2];
> +	int ret, ret2;
> +
> +	/* Parse pseudo-differential channel configuration */
> +	ret =3D fwnode_property_read_u32(child, "single-channel", &pins[0]);
> +	ret2 =3D fwnode_property_read_u32(child, "common-mode-channel", &pins[1=
]);
> +	if (!ret && ret2)
> +		return dev_err_probe(dev, ret,
> +			"single-ended channels must define common-mode-channel\n");

ret =3D=3D 0 so that will report success.

Move the ret2 logic down into this (!ret) statement that comes next then you
can just use ret and avoid this sort of issue. (Likely smatch would have
caught this but better to never have a bug report + fix :)


> +	if (!ret) {
> +		chan->differential =3D false;
> +		chan->channel =3D pins[0];
> +		chan->channel2 =3D pins[1];
> +		return 0;
> +	}
> +
> +	/* Parse differential channel configuration */
> +	ret =3D fwnode_property_read_u32_array(child, "diff-channels", pins,
> +					     ARRAY_SIZE(pins));
> +	if (!ret) {
> +		chan->differential =3D true;
> +		chan->channel =3D pins[0];
> +		chan->channel2 =3D pins[1];
> +		return 0;
> +	}
> +	return dev_err_probe(dev, ret,
> +		"Channel must define one of diff-channels or single-channel.\n");
> +}

> +
> +static int ad4170_probe(struct spi_device *spi)
> +{

> +
> +	init_completion(&st->completion);
> +
> +	if (spi->irq) {
> +		ret =3D devm_request_irq(&st->spi->dev, st->spi->irq,

Use dev and spi->irq.




> +				       &ad4170_irq_handler, IRQF_ONESHOT,
> +				       indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

