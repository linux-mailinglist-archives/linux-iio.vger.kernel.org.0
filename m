Return-Path: <linux-iio+bounces-9336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F6970885
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC97B1F215C4
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5E117335E;
	Sun,  8 Sep 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv2WHiR9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CD26281;
	Sun,  8 Sep 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811637; cv=none; b=HhIKcuQ3XzKi1cbbRkifzpPAh/ZpeE0pz9S5P/WeqDdmeoTPuuLxXBOMHjScwpUqzsMt2yDfIngXfkSUXHOWxxmnQER/nX0a6iOGcMIWJWa8WDmsnqpl7NB5Ax3G7bxmRE51XLS5jjLXuDeQwhYw/cwy2ZQuSfVe2i9sDib2foM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811637; c=relaxed/simple;
	bh=PIcvZtsoIzTVaZa/nNjjaWmeTXq08evXFChGDir598Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPeYYWDBFCIPwsy/9foQMiUx4lXqWRjZ6YkFRLglClVFbvqUczCj85RovSlJxUy3caZxomzoLrcyRShNvdAnARwR+7iQmbn+GWO2QU+zJqiV/dZhtq5SG5B8wWgH9T3THcCETqxg4m5b2y7ntIHdTwLJVlAxJxOQmfbEjXT0uSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv2WHiR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE71C4CEC3;
	Sun,  8 Sep 2024 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725811636;
	bh=PIcvZtsoIzTVaZa/nNjjaWmeTXq08evXFChGDir598Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gv2WHiR99Ydnee/z7mHk6CwvnDAa2gij/yb8AbG4oRQhW1m+OJQbiwLkNbLc9MUrH
	 323+NNKW+kHXh11VviwYwD0adrBI+e3LtIhsBSRQAFs2aEsVPtmY7jtsPdlnyW00qN
	 9OzOLZWn1dqr9ZQ0J0ZX5SBr44Z/Ltd/NLANz9bHigShtHLSAH2EUMSSMBQOMnrR6S
	 nUZ0Im4xMDWob67euLExRD/6Q12gCEbtalFl7S5ZrIjHchnlIrauaBsNljym93+Sd+
	 2nhb/pqrpr0katSmrlDsbFjsxwGFauphC+i+a66SA6PVZsaaJIo8tA20abxZJn0XIo
	 uuNohV9GJBKBA==
Date: Sun, 8 Sep 2024 17:07:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r: add axi platform driver
Message-ID: <20240908170708.2efd6fd0@jic23-huawei>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Sep 2024 17:17:38 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add support for ad3552r-axi, where ad3552r has to be controlled
> by the custom (fpga-based) ad3552r AXI DAC IP.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Comments inline.

> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 56a125f56284..cc2af3aa3f52 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -5,6 +5,7 @@
> =20
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD3552R) +=3D ad3552r.o ad3552r-common.o
> +obj-$(CONFIG_AD3552R_AXI) +=3D ad3552r-axi.o ad3552r-common.o
>  obj-$(CONFIG_AD5360) +=3D ad5360.o
>  obj-$(CONFIG_AD5380) +=3D ad5380.o
>  obj-$(CONFIG_AD5421) +=3D ad5421.o
> diff --git a/drivers/iio/dac/ad3552r-axi.c b/drivers/iio/dac/ad3552r-axi.c
> new file mode 100644
> index 000000000000..a9311f29f45d
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-axi.c
> @@ -0,0 +1,567 @@

> +
> +static int ad3552r_axi_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct ad3552r_axi_state *st =3D iio_priv(indio_dev);
> +	int err, ch =3D chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		int clk_rate;
> +
> +		err =3D iio_backend_read_raw(st->back, chan, &clk_rate, 0,
> +					   IIO_CHAN_INFO_FREQUENCY);
> +		if (err !=3D IIO_VAL_INT)
> +			return err;

If it is another postive value I think you want to return -EINVAL
If it's negative return err as here.

> +
> +		/*
> +		 * Data stream SDR/DDR (clk_in/8 or clk_in/4 update rate).
> +		 * Samplerate has sense in DDR only.
> +		 */
> +		if (st->single_channel)
> +			clk_rate =3D DIV_ROUND_CLOSEST(clk_rate, 4);
> +		else
> +			clk_rate =3D DIV_ROUND_CLOSEST(clk_rate, 8);
> +
> +		*val =3D clk_rate;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_RAW:
> +		err =3D iio_backend_bus_reg_read(st->back,
> +					       AD3552R_REG_ADDR_CH_DAC_16B(ch),
> +					       val, 2);
> +		if (err)
> +			return err;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int ad3552r_axi_set_output_range(struct ad3552r_axi_state *st,
> +					unsigned int mode)
> +{
> +	int range_ch_0 =3D FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode);
> +	int range_ch_1 =3D FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode);
> +
> +	return axi3552r_qspi_update_reg_bits(st->back,
> +				AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> +				AD3552R_MASK_CH_OUTPUT_RANGE,
> +				range_ch_0 | range_ch_1, 1);


	return axi3552r_qspi_update_reg_bits(st->back,
				AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
				AD3552R_MASK_CH_OUTPUT_RANGE,
				FIELD_PREP(AD3552R_MASK_CH0_RANGE, mode) |
				FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode),
				1);

looks fine to me  from readability point of view and it's shorter.


> +}

> +
> +static int ad3552r_axi_setup(struct ad3552r_axi_state *st)
> +{
> +	struct fwnode_handle *child __free(fwnode_handle) =3D NULL;
> +	u8 gs_p, gs_n;
> +	s16 goffs;
> +	u16 id, rfb;
> +	u16 reg =3D 0, offset =3D 0;
> +	u32 val, range;
> +	int err;
> +
> +	err =3D ad3552r_axi_reset(st);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_ddr_disable(st->back);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PA=
D,
> +					AD3552R_SCRATCH_PAD_TEST_VAL1, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL1) {
> +		dev_err(st->dev,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
> +		return -EIO;
> +	}
> +
> +	err =3D iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_SCRATCH_PAD,
> +					AD3552R_SCRATCH_PAD_TEST_VAL2, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	if (val !=3D AD3552R_SCRATCH_PAD_TEST_VAL2) {
> +		dev_err(st->dev,
> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
> +		return -EIO;
> +	}

This scratch pad test is a separate enough 'thing' maybe pull it out as
another function called from here?


> +
> +	err =3D iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_=
L,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	id =3D val;
> +
> +	err =3D iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_=
H,
> +				       &val, 1);
> +	if (err)
> +		return err;
> +
> +	id |=3D val << 8;
> +	if (id !=3D st->model_data->chip_id) {
> +		dev_err(st->dev, "Chip ID mismatch. Expected 0x%x, Read 0x%x\n",
> +			AD3552R_ID, id);
> +	}

no {} needed here.
Also dev_info()  to make it slightly less ominous :)


> +
> +	err =3D iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +					AD3552R_REF_INIT, 1);

Hmm. This was snuck in during previous patch.  Pull new definitions out of =
that
and put them in this patch.  I only noticed because I wondered what value it
had and was surprised to find it doesn't exist in current driver.

I'm not sure a define for write it all to 0 is worth while. Maybe just
put a zero here.

> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +					AD3552R_TRANSFER_INIT, 1);
Another define that sneaked in during previous patch.
Given it's not 'general' and only used here. I'd drop that define and
use the various parts that make it up here.

Mind you those defines should be introduced in this patch not the
previous one.


> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err =3D iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> +	if (err)
> +		return err;
> +
> +	err =3D ad3552r_get_ref_voltage(st->dev, &val);
> +	if (err)
> +		return err;
> +
> +	err =3D axi3552r_qspi_update_reg_bits(st->back,
> +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> +				val, 1);
> +	if (err)
> +		return err;
> +
> +	err =3D ad3552r_get_drive_strength(st->dev, &val);
> +	if (!err) {
> +		err =3D axi3552r_qspi_update_reg_bits(st->back,
> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> +					val, 1);
> +		if (err)
> +			return err;
> +	}
> +
> +	child =3D device_get_named_child_node(st->dev, "channel");
> +	if (!child)
> +		return -EINVAL;
> +
> +	err =3D ad3552r_get_output_range(st->dev, st->model_data->chip_id,
> +				       child, &range);
> +	if (!err)
> +		return ad3552r_axi_set_output_range(st, range);
> +
> +	if (err !=3D -ENOENT)
> +		return err;
> +
> +	/* Try to get custom range */
> +	err =3D ad3552r_get_custom_gain(st->dev, child,
> +					&gs_p, &gs_n, &rfb, &goffs);
> +	if (err)
> +		return err;
> +
> +	ad3552r_calc_custom_gain(gs_p, gs_n, goffs, &reg);

I'd return regs

> +
> +	offset =3D abs((s32)goffs);

Hmm. abs(goffs) should use a short I think which will work without the
cast and ultimately rely on sign extension of the result.

> +
> +	err =3D iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_OFFSET(0),
> +					offset, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	err =3D iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_OFFSET(1),
> +					offset, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	err =3D iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_GAIN(0),
> +					reg, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	err =3D iio_backend_bus_reg_write(st->back,
> +					AD3552R_REG_ADDR_CH_GAIN(1),
> +					reg, 1);
> +	if (err)
> +		return dev_err_probe(st->dev, err,
> +					"Error writing register\n");
> +
> +	return 0;
> +}

...

> +
> +static const struct iio_chan_spec_ext_info ad3552r_axi_ext_info[] =3D {
> +	IIO_ENUM("synchronous_mode", IIO_SHARED_BY_TYPE,
> +		 &ad3552r_synchronous_mode_enum),
> +	IIO_ENUM_AVAILABLE("synchronous_mode", IIO_SHARED_BY_TYPE,
> +			   &ad3552r_synchronous_mode_enum),
> +	{}
{ }

Also see discussion in next patch on this. I'm not sure it makes
sense to expose this to userspace but maybe I just don't yet understand
the use case.

> +};
> +
> +#define AD3552R_CHANNEL(ch) { \
> +	.type =3D IIO_VOLTAGE, \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.output =3D 1, \
> +	.indexed =3D 1, \
> +	.channel =3D (ch), \
> +	.scan_index =3D (ch), \
> +	.scan_type =3D { \
> +		.sign =3D 'u', \
> +		.realbits =3D 16, \
> +		.storagebits =3D 16, \
> +		.endianness =3D IIO_BE, \
> +	}, \
> +	.ext_info =3D ad3552r_axi_ext_info, \
> +}

> +
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_AUTHOR("Angelo Dureghello <adueghello@baylibre.com>");
> +MODULE_DESCRIPTION("AD3552R Driver - AXI IP version");

Maybe relax that description to include all potential backends.
As long as they keep to the bindings and interfaces, someone else's
completely different backend implementation should work with your
front end driver.  Mind you I can't immediately think of a better
name and module descriptions aren't ABI anyway, so maybe we don't care.


> +MODULE_LICENSE("GPL");
>=20


