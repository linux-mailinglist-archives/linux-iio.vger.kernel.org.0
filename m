Return-Path: <linux-iio+bounces-26078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7DC4418C
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97E4A34684D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65C2FE59A;
	Sun,  9 Nov 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjXh/WZw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279D1F7569;
	Sun,  9 Nov 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703600; cv=none; b=n4vjVA9ydQkyQ+L92Ws4NGuQxFb2ZeqY+QBFEXPy6SDFlyIaM9EaGROvRbSLFhD+yIzNnYHHKYcd0MK9kny25fh3OdOMpwiYo6dwTH+LZYEdYmSKcDoB29h+W/KzuysLiga10h+Ip8n9jy/DQNm4kmTDPXCakq3pprpl/HARvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703600; c=relaxed/simple;
	bh=vGm7piNNumvfH+d3L5yt/YJWBCXJfExiMhY1zi82YOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDeh10zQbISD5Sal7C+4uJbr8+Ds8oXigvacu0M3SYPnHkEyr/nxVDtnW3+lbY2XKRLLiPE1rzaIHtqRSgyXSnCr4X56//g+u3japNtoXGwIyA1b0XxlLSkBN2rInlyntdQY6fOwBch1+zAPzuTnXHU9QVp5Pd0lJ8cTc4J/lY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjXh/WZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BDAC19422;
	Sun,  9 Nov 2025 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762703599;
	bh=vGm7piNNumvfH+d3L5yt/YJWBCXJfExiMhY1zi82YOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RjXh/WZwlyQdf4vOwkk8FbnxyG/SaDMXcwPh64eneNAS2ItkdouCqZbk8i/Eaaru0
	 ndnB5aAxncPTPtxcpsXLGwG5CyGSnaUfv6Hm3+SvmoUw/hpu3X311rGQGaRBnCA3NA
	 5gnDLxMdSjiTEnAGINUcAGz4UAY6GG76m19lsMzYrSJT4AcBV4xMUVsty6LSLt8IUt
	 lOD4YN9Ddit8b/JKQZI2HPp5t+chTun5XAT1Xeb7UyUIpU1BUMeatI/y0lj6Z9TwUy
	 IQTaq95s3cHmuSNLPLoiSNjQLP2kOumwdw3GoJrsiG3TK0W7aWPKypMAs4XyCo8TcK
	 UGAK7sEsP3cMg==
Date: Sun, 9 Nov 2025 15:53:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: dac: adding support for Microchip
 MCP47FEB02
Message-ID: <20251109155312.499d5eb5@jic23-huawei>
In-Reply-To: <20251103-mcp47feb02-v2-2-8c37741bd97a@microchip.com>
References: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
	<20251103-mcp47feb02-v2-2-8c37741bd97a@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Nov 2025 17:50:30 +0200
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
> MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
> of buffered voltage output Digital-to-Analog Converters with nonvolatile =
or
> volatile memory and an I2C Interface.
>=20
> The families support up to 8 output channels.
>=20
> The devices can be 8-bit, 10-bit and 12-bit.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

A few minor things. Some of which probably overlap with Andy's comments.

Jonathan

> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..69f5ebbc89aed8ce229cd0c6a=
37ca58f8a822d46
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.c



> +static int mcp47feb02_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	int ret, ch;
> +	u8 pd_mode;
> +
> +	guard(mutex)(&data->lock);
> +
> +	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
> +		data->chdata[ch].powerdown =3D true;
> +		pd_mode =3D data->chdata[ch].powerdown_mode + 1;
> +		regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
> +				   DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));

ret =3D=20

> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(data->regmap, ch << 3, data->chdata[ch].dac_data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}


> +static void mcp47feb02_init_scale(struct mcp47feb02_data *data, enum mcp=
47feb02_scale scale,
> +				  int vref_mv, int scale_avail[])
> +{
> +	int value_micro, value_int;
> +	s64 tmp;
> +
> +	tmp =3D (s64)vref_mv * 1000000LL >> data->info->resolution;

MICRO or similar appropriate and avoids need to count zeros.

> +	value_int =3D div_s64_rem(tmp, 1000000LL, &value_micro);
> +	scale_avail[scale * 2] =3D value_int;
> +	scale_avail[scale * 2 + 1] =3D value_micro;
> +}

> +
> +static void mcp47feb02_get_scale_avail(struct mcp47feb02_data *data, int=
 *val, int *val2,
> +				       enum mcp47feb02_scale scale, int ch)

I'm not really following why this is get_scale_avail.  Just seems to be get=
ting
the scale from the index.  The function name should probably be less
about 'how' than 'what' it is doing.

> +{
> +	if (data->phys_channels >=3D 4 && (ch % 2)) {
> +		*val =3D data->scale_1[scale * 2];
> +		*val2 =3D data->scale_1[scale * 2 + 1];
> +	} else {
> +		*val =3D data->scale[scale * 2];
> +		*val2 =3D data->scale[scale * 2 + 1];
> +	}
> +}


> +
> +static int mcp47feb02_read_label(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *ch, char *label)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +
> +	return sysfs_emit(label, "%s\n", data->labels[ch->address]);
> +
> +	return 0;

I'm a bit surprised the compiler isn't moaning about unreachable code.

> +}

> +
> +static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
> +{
> +	int ret, i, vref_ch, gain_ch, pd_ch, pd_tmp;
> +	struct device *dev =3D &data->client->dev;
> +
> +	ret =3D regmap_read(data->regmap, MCP47FEB02_VREF_REG_ADDR, &vref_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR, =
&gain_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR, &pd_c=
h);
> +	if (ret)
> +		return ret;
> +
> +	gain_ch =3D gain_ch >> 8;

Is this extracting a field from a register? Probably better as a mask defin=
ition and
FIELD_GET()

> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		data->chdata[i].ref_mode =3D (vref_ch >> (2 * i)) & SET_DAC_CTRL_MASK;
> +		data->chdata[i].use_2x_gain =3D (gain_ch >> i)  & SET_GAIN_BIT;
> +
> +		/*
> +		 * Inform the user that the current voltage reference read from volati=
le
> +		 * register of the chip is different from the one from device tree.
> +		 * You can't have an external voltage reference connected to the pin a=
nd
> +		 * select the internal BandGap, because the VREF pin is either an inpu=
t or
> +		 * an output. When the DAC=E2=80=99s voltage reference is configured a=
s the VREF pin,
> +		 * the pin is an input. When the DAC=E2=80=99s voltage reference is co=
nfigured as the
> +		 * internal band gap, the pin is an output.
> +		 */
> +		if (data->chdata[i].ref_mode =3D=3D MCP47FEB02_INTERNAL_BAND_GAP) {
> +			if (data->phys_channels >=3D 4 && (i % 2)) {
> +				if (data->use_vref1)
> +					dev_info(dev, "cannot use Vref1 and internal BandGap");
> +			} else {
> +				if (data->use_vref)
> +					dev_info(dev, "cannot use Vref and internal BandGap");
> +			}
> +		}
> +
> +		pd_tmp =3D (pd_ch >> (2 * i)) & SET_DAC_CTRL_MASK;
> +		data->chdata[i].powerdown_mode =3D pd_tmp ? (pd_tmp - 1) : pd_tmp;
> +		data->chdata[i].powerdown =3D !!(data->chdata[i].powerdown_mode);
> +	}
> +
> +	return 0;
> +}

> +
> +static int mcp47feb02_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
> +	const struct mcp47feb02_features *info;
> +	struct device *dev =3D &client->dev;
> +	struct mcp47feb02_data *data;
> +	struct iio_dev *indio_dev;
> +	int vref1_mv =3D 0;
> +	int vref_mv =3D 0;
> +	int vdd_mv =3D 0;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->client =3D client;
> +	info =3D i2c_get_match_data(client);
> +	if (!info)
> +		return -EINVAL;
> +
> +	data->info =3D info;
> +
> +	if (info->have_eeprom) {
> +		data->regmap =3D devm_regmap_init_i2c(client, &mcp47feb02_regmap_confi=
g);
> +		indio_dev->info =3D &mcp47feb02_info;
> +	} else {
> +		data->regmap =3D devm_regmap_init_i2c(client, &mcp47fvb02_regmap_confi=
g);
> +		indio_dev->info =3D &mcp47fvb02_info;
> +	}
> +
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i=
2c regmap\n");
> +
> +	indio_dev->name =3D id->name;

This is fragile because it ultimately looks up in one type of
firmware matching structure when we might have probed from another and
hence relies on names matching precisely across those structures.
Best to avoid that. Just embed the name string in your info structure inste=
ad.

> +
> +	ret =3D mcp47feb02_parse_fw(indio_dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error parsing devicetree data\n");
Error parsing firmware data.  As it should be, your code is firmware type i=
ndependent
so error messages should not suggest it is device tree only.


> +
> +	ret =3D devm_mutex_init(dev, &data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return ret;
> +
> +	vdd_mv =3D ret / 1000;
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret > 0) {
> +		vref_mv =3D ret / 1000;
> +		data->use_vref =3D true;
> +	} else {
> +		dev_info(dev, "Vref is unavailable, internal band gap can be used inst=
ead\n");

Feels too noisy.  dev_dbg() appropriate I think.

> +	}
> +
> +	if (info->have_ext_vref1) {
> +		ret =3D devm_regulator_get_enable_read_voltage(dev, "vref1");
> +		if (ret > 0) {
> +			vref1_mv =3D ret / 1000;
> +			data->use_vref1 =3D true;
> +		} else {
> +			dev_info(dev,
> +				 "Vref1 is unavailable, internal band gap can be used instead\n");

Likewise, dev_dbg().

> +		}
> +	}
> +
> +	ret =3D mcp47feb02_init_ctrl_regs(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error initialising vref register\n");
> +
> +	ret =3D mcp47feb02_init_ch_scales(data, vdd_mv, vref_mv, vref1_mv);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

