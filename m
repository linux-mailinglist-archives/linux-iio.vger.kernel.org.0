Return-Path: <linux-iio+bounces-7046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27A91CE53
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497FB1C2102E
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3712FB1A;
	Sat, 29 Jun 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4JlnwHC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5D7E572;
	Sat, 29 Jun 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682951; cv=none; b=I/7brGDX+09iJG4an5GggXdPp9oZt33MA1W9YnaBc1sXTgCqoftv358nehqA7Y+nwcoB57Zq+asQmx85PPzsdhq91DSQ1HPkehJas7dd2EX5K77kruWsb7E/mAHHt6W+hrQGe3Ca0YW1YaeG5jwDhUSwz14MILZUvr5N+G6Nd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682951; c=relaxed/simple;
	bh=US+8KXQx1fwi/a8jD0zUwSsEZBdy/fbhsvBAD8skako=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFPkNvZyQRI4Yb9aY8exewX2aey9tfb349W+bzc9Plwuh07nm91XMqr3nLSU2TgjTA0RqOuo/24wtiZg55HAKxItyuN9yeu8dqqdTXvAGvgeTFSXzU+Z8pGahTw0va3Q9l6DvaEyc7b3P1SkvDXoXN1SbwSiyCHxSfxFnt1O+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4JlnwHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53973C2BBFC;
	Sat, 29 Jun 2024 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719682951;
	bh=US+8KXQx1fwi/a8jD0zUwSsEZBdy/fbhsvBAD8skako=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4JlnwHCEc+hfj9ptbDX7Kd/eVbqdBjDkzjQS1yeA8FUCqOXHXm/yFCOC0Njw/LX0
	 yZl1pC1EF/Hi4/1Kaee/gTH6avf1vD0W6/+Ys1Ya9ZvgH0Lbllv0mAKl4EtYmnkJ+2
	 mBT3SI23m+TQEniR0TR4e532CkYznmnlA0deMYcYA/MqM7HEwRLOx5QakSfnIZnEn5
	 x4PsvAS1OVRuRIGtTCHOYKuZbtAbTWivdEV27/YqJwUq/uwRr0Pv6Kz4x929hvT1C/
	 MjTkyrVPvWnpieuitzsFjb9Y1Bng0HMGBEAd7nqEmAd15OOoediA5WyDXbrAzLUhas
	 6Ji7QK8PojXIw==
Date: Sat, 29 Jun 2024 18:42:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, Jun Yan <jerrysteve1101@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: accel: add ADXL380 driver
Message-ID: <20240629184225.2ad12550@jic23-huawei>
In-Reply-To: <20240627102617.24416-2-antoniu.miclaus@analog.com>
References: <20240627102617.24416-1-antoniu.miclaus@analog.com>
	<20240627102617.24416-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jun 2024 13:25:18 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADXL380/ADXL382 is a low noise density, low power, 3-axis
> accelerometer with selectable measurement ranges. The ADXL380 supports
> the +/-4 g, +/-8 g, and +/-16 g ranges, and the ADXL382 supports
> +/-15 g, +/-30 g and +/-60 g ranges.
> The ADXL380/ADXL382 offers industry leading noise, enabling precision
> applications with minimal calibration. The low noise, and low power
> ADXL380/ADXL382 enables accurate measurement in an environment with
> high vibration, heart sounds and audio.
>=20
> In addition to its low power consumption, the ADXL380/ADXL382 has many
> features to enable true system level performance. These include a
> built-in micropower temperature sensor, single / double / triple tap
> detection and a state machine to prevent a false triggering. In
> addition, the ADXL380/ADXL382 has provisions for external control of
> the sampling time and/or an external clock.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu, Ramona,

Some trivial stuff that I'd just have cleaned up, but one thing I don't
understand which is which entries of your iio_priv() structure you've
marked with __aligned(IIO_DMA_MINALIGN).  That's beyond the level of thing
I'll tweak whilst applying.

I might be missing a path in which they are used for DMA transfers though!

Jonathan

> ---
> changes in v3:
>  - rearrange includes in alphabetical order.
>  - rework defines clearly stating which are registers.
>  - use BIT() and FIELD_GET() where possible.
>  - convert register related enums into macro definitions.
>  - add spacings after { and before } for arrays.
>  - reorder the `adxl380_state` structure members.
>  - mark structure members with  __aligned(IIO_DMA_MINALIGN) where require=
d.
This change has me confused because I'm not sure why it is required
for the ones you've marked (you do need one such marking at least though!)

>  - drop redundant brackets.
>  - use min() function where it applies.
>  - use put_unaligned_be24() where it applies.
>  - wrap lines where indicated by the reviewers.
>  - assign directly instead of using get_unaligned_be16 where not necessar=
y.
>  - rework error handling for irq_handler.
>  - add missing error check.
>  - drop  !=3D IIO_ACCEL for IIO_CHAN_INFO_SCALE
>  - use MICRO where possible.
>  - return iio_format_value() directly.
>  - check for negative values aswell.
>  - reorder local declarations.
>  - improve dev_err_probe string description.
>  - drop _ from functions naming where possible.
>  - rework chip/part id handling.
>  - improve comment for the delay required after reset.
>  - add regulators implementation for the supplies.
>  - handle both irqs.
>  - use i2c_get_match_data.
>  - use spi_get_device_match_data.
>  - include mod_devicetable.h.

> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> new file mode 100644
> index 000000000000..b569265190e6
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380.c
...


> +struct adxl380_state {

...

> +	int irq;
> +	int int_map[2];
> +	int lpf_tbl[4] __aligned(IIO_DMA_MINALIGN);
> +	int hpf_tbl[7][2] __aligned(IIO_DMA_MINALIGN);
Unless you allow the driver to write these two tables at the
time dma is going on with the other one you shoudn't need
to force them into separate cachelines.

I'm more curious though - why these two?
=46rom a quick look I can't figure out where they are potentially
used for DMA?

> +
> +	__be16 fifo_buf[ADXL380_FIFO_SAMPLES];
This one is used for regmap_no_inc_read() so if you drop
the __aligned() markings above this will need one.

> +};


> +static int adxl380_set_odr(struct adxl380_state *st, u8 odr)
> +{
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D adxl380_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
> +				 ADXL380_TRIG_CFG_DEC_2X_MSK,
> +				 FIELD_PREP(ADXL380_TRIG_CFG_DEC_2X_MSK, (odr & 1)));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
> +				 ADXL380_TRIG_CFG_SINC_RATE_MSK,
> +				 FIELD_PREP(ADXL380_TRIG_CFG_SINC_RATE_MSK, (odr >> 1)));
Brackets around (odr >> 1) don't add anythign and make long lines
even longer.



...

> +
> +static ssize_t adxl380_get_fifo_enabled(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct adxl380_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	unsigned int reg_val;
> +
> +	ret =3D regmap_read(st->regmap, ADXL380_DIG_EN_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%lu\n", FIELD_GET(ADXL380_FIFO_EN_MSK, reg_val)=
);
Long line that should be wrapped.
> +}
> +
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_min, 0);
> +static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       adxl380_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       adxl380_get_fifo_enabled, NULL, 0);
> +
> +static const struct iio_dev_attr *adxl380_fifo_attributes[] =3D {
> +	&iio_dev_attr_hwfifo_watermark_min,
> +	&iio_dev_attr_hwfifo_watermark_max,
> +	&iio_dev_attr_hwfifo_watermark,
> +	&iio_dev_attr_hwfifo_enabled,
> +	NULL,

No comma on null terminators as we never add anything after them.

> +};

...

> +static int adxl380_config_irq(struct iio_dev *indio_dev)
> +{
> +	struct adxl380_state *st =3D iio_priv(indio_dev);
> +	unsigned long irq_flag;
> +	struct irq_data *desc;
> +	u32 irq_type;
> +	u8 polarity;
> +	int ret;
> +
> +	desc =3D irq_get_irq_data(st->irq);
> +	if (!desc)
> +		return dev_err_probe(st->dev, -EINVAL, "Could not find IRQ %d\n", st->=
irq);
> +
> +	irq_type =3D irqd_get_trigger_type(desc);
> +	if (irq_type =3D=3D IRQ_TYPE_LEVEL_HIGH) {
> +		polarity =3D 0;
> +		irq_flag =3D IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
> +	} else if (irq_type =3D=3D IRQ_TYPE_LEVEL_LOW) {
> +		polarity =3D 1;
> +		irq_flag =3D IRQF_TRIGGER_LOW | IRQF_ONESHOT;
> +	} else {
> +		return dev_err_probe(st->dev, -EINVAL,
> +				     "Invalid interrupt 0x%x. Only level interrupts supported\n",
> +			irq_type);

Odd indentation. =20

> +	}
> +
> +	ret =3D regmap_update_bits(st->regmap, ADXL380_INT0_REG,
> +				 ADXL380_INT0_POL_MSK,
> +				 FIELD_PREP(ADXL380_INT0_POL_MSK, polarity));
> +	if (ret)
> +		return ret;
> +
> +	return devm_request_threaded_irq(st->dev, st->irq, NULL,
> +					 adxl380_irq_handler, irq_flag,
> +					 indio_dev->name, indio_dev);
> +}
>
> +
> +int adxl380_probe(struct device *dev, struct regmap *regmap,
> +		  const struct adxl380_chip_info *chip_info)
> +{

...

> +	st->irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT0");
> +	if (st->irq  > 0) {

one space only before >

> +		st->int_map[0] =3D ADXL380_INT0_MAP0_REG;
> +		st->int_map[1] =3D ADXL380_INT0_MAP1_REG;
> +	} else {
> +		st->irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +		if (st->irq  > 0)

one space only before >

> +			return dev_err_probe(dev, -ENODEV,
> +					     "no interrupt name specified");
> +		st->int_map[0] =3D ADXL380_INT1_MAP0_REG;
> +		st->int_map[1] =3D ADXL380_INT1_MAP1_REG;
> +	}
> +
> +	ret =3D adxl380_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_kfifo_buffer_setup_ext(st->dev, indio_dev,
> +					      &adxl380_buffer_ops,
> +					      adxl380_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}



> diff --git a/drivers/iio/accel/adxl380_i2c.c b/drivers/iio/accel/adxl380_=
i2c.c
> new file mode 100644
> index 000000000000..dad3b39a5125
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380_i2c.c
> @@ -0,0 +1,64 @@

...

> +static const struct i2c_device_id adxl380_i2c_id[] =3D {
> +	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info},
> +	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info},

space before }

> +	{}
As below - be consistent.=20
> +};
> +MODULE_DEVICE_TABLE(i2c, adxl380_i2c_id);
> +
> +static const struct of_device_id adxl380_of_match[] =3D {
> +	{ .compatible =3D "adi,adxl380", .data =3D &adxl380_chip_info},
> +	{ .compatible =3D "adi,adxl382", .data =3D &adxl382_chip_info},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adxl380_of_match);

> diff --git a/drivers/iio/accel/adxl380_spi.c b/drivers/iio/accel/adxl380_=
spi.c
> new file mode 100644
> index 000000000000..c244ae328714
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380_spi.c
> @@ -0,0 +1,66 @@

> +
> +static const struct spi_device_id adxl380_spi_id[] =3D {
> +	{ "adxl380", (kernel_ulong_t)&adxl380_chip_info },
> +	{ "adxl382", (kernel_ulong_t)&adxl382_chip_info },
> +	{}

Spacing should be consistent.  I'd have { } as below.

> +};
> +MODULE_DEVICE_TABLE(spi, adxl380_spi_id);
> +
> +static const struct of_device_id adxl380_of_match[] =3D {
> +	{ .compatible =3D "adi,adxl380", .data =3D &adxl380_chip_info },
> +	{ .compatible =3D "adi,adxl382", .data =3D &adxl382_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adxl380_of_match);


