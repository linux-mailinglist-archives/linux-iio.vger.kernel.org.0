Return-Path: <linux-iio+bounces-7045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1636491CE38
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA0D1F21F36
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846B12FB0A;
	Sat, 29 Jun 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/vNqaUs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DD1EB2C;
	Sat, 29 Jun 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719680167; cv=none; b=Q0a9f02xj/LqdT5/T9zq9Rpmr0xhaOIRBSsxXMQyXZ6Qg7xztCvGXh1mulYGlEb10ifvZYVIbh/m6/dk4gPtgnV20huJk9vNLG3R0ujHEi6z+oPT4q2aP07YJdK2MfN0yWyYGfus1QNc3++0ADy9BtUmrwYe7wY4uYqVrz5Tvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719680167; c=relaxed/simple;
	bh=Ddah2MWFI/t6Z553jTfMoNvEC4s5AYvU9v114N5V8W0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/+mj5s0/U6xa7HyTXTBJJUDp3vv02S1x4anx/cfEqsLjk8NQFWpwVpGex/9T9+gJtNtON5DoApUL+SfenwuPa/iirwMdQ+K1mAZCn6qN7r1S93bAAMkJcmnXoGLxyhCqjjyfnPTGWTwaXtBcyCUxXNwdftr2csIXx2/zXT1LkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/vNqaUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1387FC2BBFC;
	Sat, 29 Jun 2024 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719680166;
	bh=Ddah2MWFI/t6Z553jTfMoNvEC4s5AYvU9v114N5V8W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W/vNqaUsuuUvQlXxUDhS3pwRKwEmI6ySzsp9WaaWVPL07WsppMNqeFMVBdfePtraa
	 NwYktLQXWxC163ttLZ7gpKPp4Y60oxMoKt2PaZf+gw4VFAv33+vrNE8MEeTO9aZFuz
	 6FlPPpXOuUsoqF3J2oJCOboTJveTDkLSlAAee0CR07Ox40La3MNRUcjD+dHBQqD7zv
	 AOmUDAmBCaG6ZWRpgPe/fJpwFeMh+e3JQgkblfpRreV2fFyxfWP5hukB1IsSI6lDbn
	 76UztO5sMc5QK1lIAYgDqagQ/zEq+slKJGoaco+fMBnljvcv/5FdgAenoAPS9uBr+a
	 Zd8mMmo9NFLhA==
Date: Sat, 29 Jun 2024 17:55:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 4/5] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Message-ID: <20240629175558.031e07c1@jic23-huawei>
In-Reply-To: <20240627-eblanc-ad4630_v1-v1-4-fdc0610c23b0@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240627-eblanc-ad4630_v1-v1-4-fdc0610c23b0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 13:59:15 +0200
Esteban Blanc <eblanc@baylibre.com> wrote:

> AD4630-24 and AD4630-16 are 2 channels ADCs. Both channels are
> interleaved bit per bit on SDO line.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  drivers/iio/adc/ad4030.c | 130 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 126 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 1bcbcbd40a45..09d2f6d8cfe6 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -32,6 +32,8 @@
>  #define AD4030_REG_PRODUCT_ID_H					0x05
>  #define AD4030_REG_CHIP_GRADE					0x06
>  #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE		0x10
> +#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE		0x03
> +#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE		0x00
>  #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE		GENMASK(7, 3)
>  #define AD4030_REG_SCRATCH_PAD					0x0A
>  #define AD4030_REG_SPI_REVISION					0x0B
> @@ -391,7 +393,10 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned int avg_len)
>  static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
>  					unsigned int mask)
>  {
> -	return mask & BIT(st->chip->num_channels);
> +	if (st->chip->num_channels == 1)
> +		return mask & BIT(st->chip->num_channels);
> +
> +	return mask & GENMASK(st->chip->num_channels + 1, st->chip->num_channels);
>  }
>  
>  static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
> @@ -412,6 +417,45 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
>  				st->mode);
>  }
>  
> +/*
> + * @brief Descramble 2 32bits numbers out of a 64bits. The bits are interleaved: 1 bit for first
line wrap at 80 chars unless good reason to be longer.
> + * number, 1 bit for the second, and so on...

Do you have a reference for the alg used? 
Google fed me a bunch of options for a perfect unshuffle 
though it is probably microarch dependent.


> + */
> +static void ad4030_extract_interleaved(u8 *src, u32 *out)
> +{
> +	u8 h0, h1, l0, l1;
> +	u32 out0, out1;
> +	u8 *out0_raw = (u8 *)&out0;
> +	u8 *out1_raw = (u8 *)&out1;
> +
> +	for (int i = 0; i < 4; i++) {
> +		h0 = src[i * 2];
> +		l1 = src[i * 2 + 1];
> +		h1 = h0 << 1;
> +		l0 = l1 >> 1;
> +
> +		h0 &= 0xAA;
> +		l0 &= 0x55;
> +		h1 &= 0xAA;
> +		l1 &= 0x55;
> +
> +		h0 = (h0 | h0 << 001) & 0xCC;
> +		h1 = (h1 | h1 << 001) & 0xCC;
> +		l0 = (l0 | l0 >> 001) & 0x33;
> +		l1 = (l1 | l1 >> 001) & 0x33;
> +		h0 = (h0 | h0 << 002) & 0xF0;
> +		h1 = (h1 | h1 << 002) & 0xF0;
> +		l0 = (l0 | l0 >> 002) & 0x0F;
> +		l1 = (l1 | l1 >> 002) & 0x0F;
> +
> +		out0_raw[i] = h0 | l0;
> +		out1_raw[i] = h1 | l1;
> +	}
> +
> +	out[0] = out0;
> +	out[1] = out1;
> +}
> +
>  static int ad4030_conversion(struct ad4030_state *st, const struct iio_chan_spec *chan)
>  {
>  	unsigned int bytes_to_read = (BITS_TO_BYTES(chan->scan_type.realbits) +
> @@ -437,10 +481,16 @@ static int ad4030_conversion(struct ad4030_state *st, const struct iio_chan_spec
>  	ndelay(AD4030_TCONV_NS);
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -	if (ret || (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> -		    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM))
> +	if (ret)
>  		return ret;
>  
> +	if (st->chip->num_channels == 2)
> +		ad4030_extract_interleaved(st->rx_data.raw, st->rx_data.val);
> +
> +	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> +	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> +		return 0;

If you make the suggested split of the error and good paths from patch 2 review
this will be a simpler diff.

> +
>  	byte_index = st->chip->precision_bits == 16 ? 3 : 4;
>  	for (i = 0; i < st->chip->num_channels; i++)
>  		st->rx_data.common[i] = ((u8 *)&st->rx_data.val[i])[byte_index];
> @@ -776,12 +826,25 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
>  
>  static int ad4030_config(struct ad4030_state *st)
>  {
> +	int ret;
> +	u8 reg_modes = 0;
Seems you can just use = below instead of |=

> +
>  	st->min_offset = (int)BIT(st->chip->precision_bits) * -1;
>  	st->max_offset = BIT(st->chip->precision_bits) - 1;
>  	st->offset_avail[0] = st->min_offset;
>  	st->offset_avail[1] = 1;
>  	st->offset_avail[2] = st->max_offset;
>  
> +	if (st->chip->num_channels > 1)
> +		reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
> +					AD4030_LANE_MD_INTERLEAVED);
> +	else
> +		reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE, AD4030_LANE_MD_1_PER_CH);

wrap that line.  Aim for sub 80 chars.

> +
> +	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
> +	if (ret)
> +		return ret;
> +
>  	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
>  		return regmap_write(st->regmap, AD4030_REG_IO,
>  				AD4030_REG_IO_MASK_IO2X);
> @@ -863,8 +926,14 @@ static const unsigned long ad4030_channel_masks[] = {
>  	0,
>  };
>  

Thanks,

Jonathan

