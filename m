Return-Path: <linux-iio+bounces-17639-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AFA7CA0F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D0C189302B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8818E13B7A3;
	Sat,  5 Apr 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiY1G//X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72A2C9D;
	Sat,  5 Apr 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743869525; cv=none; b=RKjElksThcBpbncyl8obFt+scXwrfaI8P9cCHb0ZhSAl+SIvcy7ZplOUr0I0fRsMUDgLWpmUa6buiN9Szil14QJFOvh8Nb7hEPV4jT/oq8qVZB5uuBJwfz0Hralvw1ABsOVll6BF7eLnI9sb+waOHhR1hFZ7cJqS3TRIn48jeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743869525; c=relaxed/simple;
	bh=O45zD6gJyBuFICNey4+XKg8Yf23rHwbV2WQOwAMg29s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6aixbSv1jX6TzuOnx8cmlk5FxiujL4dlJpGKx5J/50vZ4B8+cNpUZG1IX0PUCe8IvzsIFjhjOkhpatVgQLQ5MTmMiNpoLfK3EFppPVu4O5mo+VD0eGiXpVUOj66N0cfIn4Yz021VN8vICS+WWIkLFgP8P9p/mFlg720xooLtjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiY1G//X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E29C4CEE4;
	Sat,  5 Apr 2025 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743869524;
	bh=O45zD6gJyBuFICNey4+XKg8Yf23rHwbV2WQOwAMg29s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hiY1G//XH8rZnQk+M3DYGsGhBIyvyMB1HFBZG4AC6gy0w/NXkhEKox16LuqDaVD6v
	 pepfz0lMYHqcBXR4GiLRjaOF+b40vhxh4x4zOvZbP8gAO8Btrw4I1esfFfQOJUxoV+
	 U47+oWMzQzIj4JRU3laMwGbibP5EimBaEs7vflOLd5+kYFa97emaZExpYtw5FUDCyH
	 NhMkeD7niSkwTcyCPIb9D6vx1hUq1+z2MbDcnAQD+u6cFIIDH09WSnvLrVko+9vUMv
	 eYyEEDkU31K0oEIHcE1M0PpDAyvRbeWcwT3Au+fbezJUJQxdBZIazybivcSQuEroQM
	 2aIvGPeHjeLVg==
Date: Sat, 5 Apr 2025 17:11:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250405171155.091edbae@jic23-huawei>
In-Reply-To: <20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
	<20250403-togreg-v3-3-d4b06a4af5a9@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 13:33:57 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

Hi Kim,
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is disabl=
ed
> by default.


As below. Given the bindings provide for use with an external ADC to read
a wide range of signals, if intent is not to provide that support 'yet'
(which is fine) then add a paragraph here to say that.

>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>


A few additional comments from me inline.  Particular fun is the
long running SPI regmap DMA safety assumptions question.
For now I think we have to assume bulk read/write still need
a DMA safe buffer.

Jonathan

> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4b757e19f0c8349999f72e53a=
bb1a4f483a44eb2
> --- /dev/null
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -0,0 +1,514 @@

> +
> +#define AD3530R_INTERFACE_CONFIG_A		0x00
> +#define AD3530R_OUTPUT_OPERATING_MODE_0		0x20
> +#define AD3530R_OUTPUT_OPERATING_MODE_1		0x21
> +#define AD3530R_OUTPUT_CONTROL_0		0x2A
> +#define AD3530R_REFERENCE_CONTROL_0		0x3C
> +#define AD3530R_SW_LDAC_TRIG_A			0xE5
> +#define AD3530R_INPUT_CH(c)			(2 * (c) + 0xEB)
> +
> +#define AD3531R_SW_LDAC_TRIG_A			0xDD
> +#define AD3531R_INPUT_CH(c)			(2 * (c) + 0xE3)

I'd add a define for the first channel and then just have the
rest of this in the device specific function that uses it.

> +
> +#define AD3530R_SW_LDAC_TRIG_MASK		BIT(7)
> +#define AD3530R_OUTPUT_CONTROL_MASK		BIT(2)
> +#define AD3530R_REFERENCE_CONTROL_MASK		BIT(0)
> +#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
> +
> +#define AD3530R_SW_RESET			(BIT(7) | BIT(0))
> +#define AD3530R_MAX_CHANNELS			8
> +#define AD3531R_MAX_CHANNELS			4
> +#define AD3530R_CH(c)				(c)

This seems a little unnecessary...
Given it is only called in device specific functions I'd just encode that
there.

> +#define AD3530R_32KOHM_POWERDOWN_MODE		3
> +#define AD3530R_INTERNAL_VREF_MV		2500
> +#define AD3530R_LDAC_PULSE_US			100

> +static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
> +			     unsigned int val)
> +{
> +	int ret;
> +	__be16 reg_val;
> +
> +	guard(mutex)(&st->lock);
> +	reg_val =3D cpu_to_be16(val);
> +
> +	ret =3D regmap_bulk_write(st->regmap, st->chip_info->input_ch_reg(chan),
> +				&reg_val, sizeof(reg_val));

As below. regmap_bulk_write() shouldn't assume the buffer is bounced so
needs a DMA safe buffer.

> +	if (ret)
> +		return ret;
> +
> +	if (st->ldac_gpio)
> +		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
> +
> +	return regmap_update_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
> +				  AD3530R_SW_LDAC_TRIG_MASK,
> +				  FIELD_PREP(AD3530R_SW_LDAC_TRIG_MASK, 1));
> +}
> +
> +static int ad3530r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ad3530r_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +	__be16 reg_val;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D regmap_bulk_read(st->regmap,
> +				       st->chip_info->input_ch_reg(chan->channel),
> +				       &reg_val, sizeof(reg_val));

So this runs into the old question of whether we need a DMA safe buffer
for a regmap_bulk_read when the bus is SPI.  In practice we probably
don't because of internal details of the regmap but I believe nothing has
changed on the guidance to not assume that in drivers.  So this regval
should be DMA safe. Easiest option is a
__be16 val __aligned(IIO_DMA_MINALIGN) at then end of the st structure
though we will also need to take a mutex to prevent multiple uses of that
buffer.

Maybe we should revisit this with Mark. I checked briefly and 'think'
there is always a copy.

> +		if (ret)
> +			return ret;
> +
> +		*val =3D FIELD_GET(AD3530R_REG_VAL_MASK, be16_to_cpu(reg_val));
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->vref_mv;
> +		*val2 =3D 16;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +#define AD3530R_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\
> +	.name =3D (_name),						\
> +	.read =3D (_read),						\
> +	.write =3D (_write),						\
> +	.private =3D (_what),						\
> +	.shared =3D (_shared),						\
> +}
> +
> +static const struct iio_chan_spec_ext_info ad3530r_ext_info[] =3D {
> +	AD3530R_CHAN_EXT_INFO("powerdown", 0, IIO_SEPARATE,
> +			      ad3530r_get_dac_powerdown,
> +			      ad3530r_set_dac_powerdown),
As there is only one don't use a macro.


	{
		.name =3D "powerdown",
		.shared =3D IIO_SEPARATE,
		.read =3D ...
		.write=3D ...
	},

> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3530r_powerdown_mode_enum),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> +			   &ad3530r_powerdown_mode_enum),
> +	{ },
> +};
> +
> +#define AD3530R_CHAN(_chan) {						\
> +	.type =3D IIO_VOLTAGE,						\
> +	.indexed =3D 1,							\
> +	.channel =3D _chan,						\
> +	.output =3D 1,							\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.ext_info =3D ad3530r_ext_info,					\
> +}
> +
> +static const struct iio_chan_spec ad3530r_channels[] =3D {

Hmm. You only have output channels but we have the stuff
to read the mux value on a pin.  (Nuno mentioned this as well).
If that is enabled I'd expect to see all the input channels to reflect what
we might read by putting it on that pin and reading it with an ADC we
are consumer.

I'm fine if we make that a job for another day though
just state that really clearly in the patch description.

> +	AD3530R_CHAN(0),
> +	AD3530R_CHAN(1),
> +	AD3530R_CHAN(2),
> +	AD3530R_CHAN(3),
> +	AD3530R_CHAN(4),
> +	AD3530R_CHAN(5),
> +	AD3530R_CHAN(6),
> +	AD3530R_CHAN(7),
> +};
> +
> +static const struct iio_chan_spec ad3531r_channels[] =3D {
> +	AD3530R_CHAN(0),
> +	AD3530R_CHAN(1),
> +	AD3530R_CHAN(2),
> +	AD3530R_CHAN(3),
> +};


