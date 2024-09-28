Return-Path: <linux-iio+bounces-9810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C450D988F97
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C2A1C20E55
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DBC1885BB;
	Sat, 28 Sep 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUFE1gt0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F118454C;
	Sat, 28 Sep 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533180; cv=none; b=GHYo7HlFn1OkA4OzslAeXgeDVX0AY37W4PTTOyRHHY5ResHaIzW/gerVZWrKo/VG81PPIWRZkgI95Yndi8Lbhnp0VVt+0sOyXPLkYE6OshA+xYyfscYR4ghEaLhFRW0tqaWaRzUDg7zsyUxMQXf6v4BxGClfPxFr/RbjKY3CwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533180; c=relaxed/simple;
	bh=POookSFDq8fwGr2RQqfcqGdNvcWHpGxh8YttZ6cwiNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtU4OyQHshBh5Ho6gkSvGLm4558syjYlkSknWKldJt+XbyGnAGvCjfIUgTJHV8kBfXupbGfvBW2sI1+cuyaMfm4Y7K0FnyKbecRQ96gmmBWY8O3EdMAyKgINZpW89L+rPpjBR3/qsFn/AK5PD1D8ehSUR3+1XzBiYUzmFDZBbYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUFE1gt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED87EC4CEC3;
	Sat, 28 Sep 2024 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727533179;
	bh=POookSFDq8fwGr2RQqfcqGdNvcWHpGxh8YttZ6cwiNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KUFE1gt03xK6aELbCpjLj2KCpz4Bjwux+g490qMzKKMQuM+EJhdgR1bTlKYbP8RDJ
	 jivOTzCaUYaeZJTnQxNv46NqfTjNBDlpVQXnJZ3HyTnG65Gh7h+1mLMaX2PP6i0/9v
	 4WgnYzJEobOASAuqNd+izuoruY80I/7x5//5CEYlS6M3iBI3NE/iQWNWSJaG8xYye2
	 l7clSYp5bt0JJWQM3/PH5fvLHCyF7CEXBrAIEOQTGC59252c4D82wntvV/EaimTsxZ
	 EV8sWlW7sJHijP6lK6AUM1CppjDiZZHtKMX3mOGrmYHFa6vbGKlHjG64xtyzPlsGSo
	 dDIzCMWsKEyww==
Date: Sat, 28 Sep 2024 15:19:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Conor Dooley <conor+dt@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>, Dimitri Fedrau
 <dima.fedrau@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: dac: support the ad8460 Waveform DAC
Message-ID: <20240928151930.0c22e5e9@jic23-huawei>
In-Reply-To: <8f869b3b-df3f-49a9-9b6e-640697aa91dd@wanadoo.fr>
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
	<20240912095435.18639-3-Mariel.Tinaco@analog.com>
	<8f869b3b-df3f-49a9-9b6e-640697aa91dd@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Sep 2024 20:21:56 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 12/09/2024 =C3=A0 11:54, Mariel Tinaco a =C3=A9crit=C2=A0:
> > The AD8460 is a =E2=80=9Cbits in, power out=E2=80=9D high voltage, high=
-power,
> > high-speed driver optimized for large output current (up to =C2=B11 A)
> > and high slew rate (up to =C2=B11800 V/=CE=BCs) at high voltage (up to =
=C2=B140 V)
> > into capacitive loads.
> >=20
> > A digital engine implements user-configurable features: modes for
> > digital input, programmable supply current, and fault monitoring
> > and programmable protection settings for output current,
> > output voltage, and junction temperature. The AD8460 operates on
> > high voltage dual supplies up to =C2=B155 V and a single low voltage
> > supply of 5 V.
> >=20
> > Signed-off-by: Mariel Tinaco <Mariel.Tinaco-OyLXuOCK7orQT0dZR+AlfA@publ=
ic.gmane.org>
> > --- =20

Rather than go around again, I fixed up all the comments made
and the autobuilder issues then applied this.

Diff follows. The only bit I'm not 100% sure on was your intent
with the temperature channel. I've made it an input but shout if
I'm missing something.

With this diff applied on top, applied to the togreg branch of iio.git
which is only pushed out as testing for now as I'll rebase on rc1
once available.

Thanks,

Jonathan

diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index 9ce3a0f288ba..dc8c76ba573d 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -533,7 +533,7 @@ static int ad8460_write_event_value(struct iio_dev *ind=
io_dev,
                                    enum iio_event_info info, int val, int =
val2)
 {
        struct ad8460_state *state =3D iio_priv(indio_dev);
-       unsigned int fault;
+       int fault;
=20
        if (type !=3D IIO_EV_TYPE_THRESH)
                return -EINVAL;
@@ -555,7 +555,7 @@ static int ad8460_read_event_value(struct iio_dev *indi=
o_dev,
                                   enum iio_event_info info, int *val, int =
*val2)
 {
        struct ad8460_state *state =3D iio_priv(indio_dev);
-       unsigned int fault;
+       int fault;
=20
        if (type !=3D IIO_EV_TYPE_THRESH)
                return -EINVAL;
@@ -576,7 +576,7 @@ static int ad8460_write_event_config(struct iio_dev *in=
dio_dev,
                                     enum iio_event_direction dir, int val)
 {
        struct ad8460_state *state =3D iio_priv(indio_dev);
-       unsigned int fault;
+       int fault;
=20
        if (type !=3D IIO_EV_TYPE_THRESH)
                return -EINVAL;
@@ -594,9 +594,8 @@ static int ad8460_read_event_config(struct iio_dev *ind=
io_dev,
                                    enum iio_event_direction dir)
 {
        struct ad8460_state *state =3D iio_priv(indio_dev);
-       unsigned int fault;
+       int fault, ret;
        bool en;
-       int ret;
=20
        if (type !=3D IIO_EV_TYPE_THRESH)
                return -EINVAL;
@@ -660,14 +659,14 @@ static const struct iio_enum ad8460_powerdown_mode_en=
um =3D {
 };
=20
 #define AD8460_CHAN_EXT_INFO(_name, _what, _read, _write) {            \
-       .name =3D _name,                                                  \
+       .name =3D (_name),                                                \
        .read =3D (_read),                                                \
        .write =3D (_write),                                              \
        .private =3D (_what),                                             \
        .shared =3D IIO_SEPARATE,                                         \
 }
=20
-static struct iio_chan_spec_ext_info ad8460_ext_info[] =3D {
+static const struct iio_chan_spec_ext_info ad8460_ext_info[] =3D {
        AD8460_CHAN_EXT_INFO("raw0", 0, ad8460_dac_input_read,
                             ad8460_dac_input_write),
        AD8460_CHAN_EXT_INFO("raw1", 1, ad8460_dac_input_read,
@@ -709,7 +708,7 @@ static struct iio_chan_spec_ext_info ad8460_ext_info[] =
=3D {
        IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad8460_powerdown_mode_enu=
m),
        IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
                           &ad8460_powerdown_mode_enum),
-       {}
+       { }
 };
=20
 static const struct iio_event_spec ad8460_events[] =3D {
@@ -761,7 +760,6 @@ static const struct iio_event_spec ad8460_events[] =3D {
 #define AD8460_TEMP_CHAN {                                     \
        .type =3D IIO_TEMP,                                       \
        .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),           \
-       .output =3D 1,                                            \
        .indexed =3D 1,                                           \
        .channel =3D 0,                                           \
        .scan_index =3D -1,                                       \
@@ -792,9 +790,9 @@ static const char * const ad8460_supplies[] =3D {
=20
 static int ad8460_probe(struct spi_device *spi)
 {
+       struct device *dev  =3D &spi->dev;
        struct ad8460_state *state;
        struct iio_dev *indio_dev;
-       struct device *dev;
        u32 tmp[2], temp;
        int ret;
=20
@@ -808,14 +806,15 @@ static int ad8460_probe(struct spi_device *spi)
        indio_dev->info =3D &ad8460_info;
=20
        state->spi =3D spi;
-       dev =3D &spi->dev;
=20
        state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config);
        if (IS_ERR(state->regmap))
                return dev_err_probe(dev, PTR_ERR(state->regmap),
                                     "Failed to initialize regmap");
=20
-       devm_mutex_init(dev, &state->lock);
+       ret =3D devm_mutex_init(dev, &state->lock);
+       if (ret)
+               return ret;
=20
        state->sync_clk =3D devm_clk_get_enabled(dev, NULL);
        if (IS_ERR(state->sync_clk))
@@ -835,10 +834,9 @@ static int ad8460_probe(struct spi_device *spi)
=20
        ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad8460_suppl=
ies),
                                             ad8460_supplies);
-       if (ret) {
-               dev_err(dev, "Failed to enable power supplies\n");
-               return ret;
-       }
+       if (ret)
+               return dev_err_probe(dev, ret,
+                                    "Failed to enable power supplies\n");
=20
        ret =3D devm_regulator_get_enable_read_voltage(dev, "refio_1p2v");
        if (ret < 0 && ret !=3D -ENODEV)
@@ -908,9 +906,8 @@ static int ad8460_probe(struct spi_device *spi)
                return ret;
=20
        /* Enables DAC by default */
-       ret =3D regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
-                                AD8460_HVDAC_SLEEP_MSK,
-                                FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, 0));
+       ret =3D regmap_clear_bits(state->regmap, AD8460_CTRL_REG(0x01),
+                               AD8460_HVDAC_SLEEP_MSK);
        if (ret)
                return ret;
=20

>=20
> Hi,
>=20
> ...
>=20
> > +#define AD8460_CHAN_EXT_INFO(_name, _what, _read, _write) {		\
> > +	.name =3D _name,							\
> > +	.read =3D (_read),						\
> > +	.write =3D (_write),						\
> > +	.private =3D (_what),						\ =20
>=20
> Why () for _read, _write, _what?
> (or why no () for _name?)
>=20
> > +	.shared =3D IIO_SEPARATE,						\
> > +}
> > +
> > +static struct iio_chan_spec_ext_info ad8460_ext_info[] =3D { =20
>=20
> I think this can be static const struct.
>=20
> > +	AD8460_CHAN_EXT_INFO("raw0", 0, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw1", 1, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw2", 2, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw3", 3, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw4", 4, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw5", 5, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw6", 6, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw7", 7, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw8", 8, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw9", 9, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw10", 10, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw11", 11, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw12", 12, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw13", 13, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw14", 14, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("raw15", 15, ad8460_dac_input_read,
> > +			     ad8460_dac_input_write),
> > +	AD8460_CHAN_EXT_INFO("toggle_en", 0, ad8460_read_toggle_en,
> > +			     ad8460_write_toggle_en),
> > +	AD8460_CHAN_EXT_INFO("symbol", 0, ad8460_read_symbol,
> > +			     ad8460_write_symbol),
> > +	AD8460_CHAN_EXT_INFO("powerdown", 0, ad8460_read_powerdown,
> > +			     ad8460_write_powerdown),
> > +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad8460_powerdown_mode_enum),
> > +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> > +			   &ad8460_powerdown_mode_enum),
> > +	{}
> > +}; =20
>=20
> ...
>=20
> > +static int ad8460_probe(struct spi_device *spi)
> > +{
> > +	struct ad8460_state *state;
> > +	struct iio_dev *indio_dev;
> > +	struct device *dev;
> > +	u32 tmp[2], temp;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*state));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	state =3D iio_priv(indio_dev);
> > +
> > +	indio_dev->name =3D "ad8460";
> > +	indio_dev->info =3D &ad8460_info;
> > +
> > +	state->spi =3D spi;
> > +	dev =3D &spi->dev;
> > +
> > +	state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config);
> > +	if (IS_ERR(state->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(state->regmap),
> > +				     "Failed to initialize regmap");
> > +
> > +	devm_mutex_init(dev, &state->lock);
> > +
> > +	state->sync_clk =3D devm_clk_get_enabled(dev, NULL);
> > +	if (IS_ERR(state->sync_clk))
> > +		return dev_err_probe(dev, PTR_ERR(state->sync_clk),
> > +				     "Failed to get sync clk\n");
> > +
> > +	state->tmp_adc_channel =3D devm_iio_channel_get(dev, "ad8460-tmp");
> > +	if (IS_ERR(state->tmp_adc_channel)) {
> > +		if (PTR_ERR(state->tmp_adc_channel) =3D=3D -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +		indio_dev->channels =3D ad8460_channels;
> > +		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels);
> > +	} else {
> > +		indio_dev->channels =3D ad8460_channels_with_tmp_adc;
> > +		indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels_with_tmp_adc);
> > +	}
> > +
> > +	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad8460_supplie=
s),
> > +					     ad8460_supplies);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable power supplies\n");
> > +		return ret; =20
>=20
> Nitpick: return dev_err_probe() as done in other places?
>=20
> > +	}
> > +
> > +	ret =3D devm_regulator_get_enable_read_voltage(dev, "refio_1p2v");
> > +	if (ret < 0 && ret !=3D -ENODEV)
> > +		return dev_err_probe(dev, ret, "Failed to get reference voltage\n");
> > +
> > +	state->refio_1p2v_mv =3D ret =3D=3D -ENODEV ? 1200 : ret / 1000; =20
>=20
> ...
>=20
> CJ


