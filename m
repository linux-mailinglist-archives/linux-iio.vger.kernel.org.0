Return-Path: <linux-iio+bounces-26874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E4CAB520
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7807430562C1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B772D3A69;
	Sun,  7 Dec 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkDYgUCG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32273B8D71;
	Sun,  7 Dec 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765112989; cv=none; b=oB6cIcksDbjm0zlIVY9sa0yhFVp/QD0OwOF4vcIxHz2Rq0AOT0fItoNunlt0JB0I8ZgBNWAOgjTnK0fwFt6H0RfiqpFp4gMuLI9LEJ5uyMMZdx4SJGmk8Gz8uRZ4m1X9MWrIQU6THPFBPAwOIzEAoNQw1mtDkEFWPcrnRS74qzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765112989; c=relaxed/simple;
	bh=MfV/7ZHFiqQjaNaOycta3KjrAqwsiSKxlCt4pooHHIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyRhlUV6U5yeEPT2PJh9BgSUSyYJ7ESdeiQy/JX0UYtI3IUfrnfYLhLCd4TKExR9Il017Z/jq18tobLRF3AnKjtkTWK/LBBjWVXjkra3QiBNGvHw0I4dnzpFcu6vRoTF5sRyhOjrjKjRfLdQnrv2nGAln7+BIYOJ6oudrDLDrN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkDYgUCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B249C4CEFB;
	Sun,  7 Dec 2025 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765112988;
	bh=MfV/7ZHFiqQjaNaOycta3KjrAqwsiSKxlCt4pooHHIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RkDYgUCGUzfHNIfZ3hY7Xp8Tg54IGA3hcuGa/E/IB4dwWTzdWeBl7gUDpLWQmMosS
	 oX6UmdVh69zHLhCXivueiILpjiSDCWsR3VA0oPA59sxAiumoDmgs7XGWSZ5R/hOJyH
	 RJl6oyRVA5U27/qZq/i3xVMD0UHlkR2YOuwzwfaVSLolQ//jfdib+W1IYkEbKLp/rR
	 xVZGeK/MFLUwsmjmiZ/YEvMY1JRuHgbBktj2GWDXU3xEPSArCNn4kWEHeuvy3bwHuR
	 fugdPZB418DmzqNUkjKirDTpU0c/hY5eZXXLdtgq0QIf8bmDc/KoBCPr0K2m9ZoGDK
	 HyJkBomIZr95w==
Date: Sun, 7 Dec 2025 13:09:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Alexandru Ardelean	
 <alexandru.ardelean@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ad9467: support write/read offset
Message-ID: <20251207130939.6e72fb9d@jic23-huawei>
In-Reply-To: <fdf00f852543f9da3efd0c87c78165d9f22db367.camel@gmail.com>
References: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
	<20251203-ad9434-fixes-v3-2-38d14f28456f@vaisala.com>
	<fdf00f852543f9da3efd0c87c78165d9f22db367.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Dec 2025 11:05:50 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2025-12-03 at 09:28 +0000, Tomas Melin wrote:
> > Support configuring output calibration value. Among the devices
> > currently supported by this driver, this setting is specific to
> > ad9434. The offset can be used to calibrate the output against
> > a known input. The register is called offset, but the procedure
> > is best mapped internally with calibbias operation.
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> > --- =20
>=20
> Still don't really like the style in .info_mask_shared_by_type and=20
> .info_mask_shared_by_type_available. But ok, it seems I'm the only one. S=
o:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Applied but with via _calibbias added to the patch title to make
it clear this isn't via _offset which might make people waste time
wondering what is going on.

Note this is on my local tree that I might push out as testing
but will only become togreg after I rebase on rc1 in a week or so.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad9467.c | 60 +++++++++++++++++++++++++++++++++++=
++++++++++++-
> > =C2=A01 file changed, 59 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > index 2d8f8da3671dac61994a1864a82cdbef7f54c1af..48c10acb1566ba471be0804=
e7c39b0b553d76188 100644
> > --- a/drivers/iio/adc/ad9467.c
> > +++ b/drivers/iio/adc/ad9467.c
> > @@ -145,6 +145,7 @@ struct ad9467_chip_info {
> > =C2=A0	unsigned int num_lanes;
> > =C2=A0	unsigned int dco_en;
> > =C2=A0	unsigned int test_points;
> > +	const int *offset_range;
> > =C2=A0	/* data clock output */
> > =C2=A0	bool has_dco;
> > =C2=A0	bool has_dco_invert;
> > @@ -234,6 +235,10 @@ static int ad9467_reg_access(struct iio_dev *indio=
_dev, unsigned int reg,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static const int ad9434_offset_range[] =3D {
> > +	-128, 1, 127,
> > +};
> > +
> > =C2=A0static const unsigned int ad9265_scale_table[][2] =3D {
> > =C2=A0	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
> > =C2=A0};
> > @@ -298,7 +303,24 @@ static void __ad9467_get_scale(struct ad9467_state=
 *st, int index,
> > =C2=A0}
> > =C2=A0
> > =C2=A0static const struct iio_chan_spec ad9434_channels[] =3D {
> > -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> > +	{
> > +		.type =3D IIO_VOLTAGE,
> > +		.indexed =3D 1,
> > +		.channel =3D 0,
> > +		.info_mask_shared_by_type =3D
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > +			BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +		.info_mask_shared_by_type_available =3D
> > +			BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_CALIBBIAS),
> > +		.scan_index =3D 0,
> > +		.scan_type =3D {
> > +			.sign =3D 's',
> > +			.realbits =3D 12,
> > +			.storagebits =3D 16,
> > +		},
> > +	},
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct iio_chan_spec ad9467_channels[] =3D {
> > @@ -367,6 +389,7 @@ static const struct ad9467_chip_info ad9434_chip_tb=
l =3D {
> > =C2=A0	.default_output_mode =3D AD9434_DEF_OUTPUT_MODE,
> > =C2=A0	.vref_mask =3D AD9434_REG_VREF_MASK,
> > =C2=A0	.num_lanes =3D 6,
> > +	.offset_range =3D ad9434_offset_range,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static const struct ad9467_chip_info ad9265_chip_tbl =3D {
> > @@ -499,6 +522,33 @@ static int ad9467_set_scale(struct ad9467_state *s=
t, int val, int val2)
> > =C2=A0	return -EINVAL;
> > =C2=A0}
> > =C2=A0
> > +static int ad9467_get_offset(struct ad9467_state *st, int *val)
> > +{
> > +	int ret;
> > +
> > +	ret =3D ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
> > +	if (ret < 0)
> > +		return ret;
> > +	*val =3D ret;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int ad9467_set_offset(struct ad9467_state *st, int val)
> > +{
> > +	int ret;
> > +
> > +	if (val < st->info->offset_range[0] || val > st->info->offset_range[2=
])
> > +		return -EINVAL;
> > +
> > +	ret =3D ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
> > +				AN877_ADC_TRANSFER_SYNC);
> > +}
> > +
> > =C2=A0static int ad9467_outputmode_set(struct ad9467_state *st, unsigne=
d int mode)
> > =C2=A0{
> > =C2=A0	int ret;
> > @@ -802,6 +852,8 @@ static int ad9467_read_raw(struct iio_dev *indio_de=
v,
> > =C2=A0	struct ad9467_state *st =3D iio_priv(indio_dev);
> > =C2=A0
> > =C2=A0	switch (m) {
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		return ad9467_get_offset(st, val);
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > =C2=A0		return ad9467_get_scale(st, val, val2);
> > =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> > @@ -836,6 +888,8 @@ static int ad9467_write_raw(struct iio_dev *indio_d=
ev,
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	switch (mask) {
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		return ad9467_set_offset(st, val);
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > =C2=A0		return ad9467_set_scale(st, val, val2);
> > =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> > @@ -874,6 +928,10 @@ static int ad9467_read_avail(struct iio_dev *indio=
_dev,
> > =C2=A0	const struct ad9467_chip_info *info =3D st->info;
> > =C2=A0
> > =C2=A0	switch (mask) {
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		*type =3D IIO_VAL_INT;
> > +		*vals =3D info->offset_range;
> > +		return IIO_AVAIL_RANGE;
> > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > =C2=A0		*vals =3D (const int *)st->scales;
> > =C2=A0		*type =3D IIO_VAL_INT_PLUS_MICRO; =20


