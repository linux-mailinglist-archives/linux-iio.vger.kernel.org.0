Return-Path: <linux-iio+bounces-8779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6695ED1B
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125701F22125
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59099145FE8;
	Mon, 26 Aug 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz0c6MO8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC6145B1F;
	Mon, 26 Aug 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664483; cv=none; b=oapkwj/RHLm9Am3HbogJsLE+DcdYnznsCQK7S+ER8PdfhhMrJRlHKNkZrNfCYcHRdc9LLHaOGK4YWADLOAsPYQY/xSAeNwDmwzlrU19IZahXlxSw/ZJ3e0RBElNlPDSiQZhJOTb0Vgu38P1QXXEQy+PCfQBTDpVNgBL4u2gvjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664483; c=relaxed/simple;
	bh=tOUgInOKtpfGsDq0XN/aCDzC3Gyz0VVDNbURfDQgMks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1CN4kTG8tRqaD0Bqd6HXIMmRSG+rXzI0gVtALoff2TYMKFUfxYdI6tunDcy7IqEtzHdYIXiWCd2uucNI14jtPahyMP3Ys5jamfe39M2wQQcHA4JTen1G1CD0m0jwWHIhSf38txG7Iw5oMrRHLalPUq2fBHJ+KB6Z5pxtc3aNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz0c6MO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E55C5E892;
	Mon, 26 Aug 2024 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724664482;
	bh=tOUgInOKtpfGsDq0XN/aCDzC3Gyz0VVDNbURfDQgMks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hz0c6MO81u6Gs7ouPBR98N06TePtBFRnmnoW46fodLjllpo/FgETUWmWD4S6UXYM1
	 WsqxsMg892SRYrpZmsRwqklTtkIOzIvgfbuXCUDFij4lwLdiPw5Nmgx1TcFFm2lgJg
	 RkR/ZBZJOX6QBYA8ntWVbBnyeUA+KshZWtfRcIC20JwvGe9kY1XXvVDZSaN/vCkhRb
	 fhqASgyL+a/SxhvebD/3caGZU7ZyKWNZfpZXMhae99JiyDgV4MdY8yZcMitPccdMUc
	 QAIxbNK5uahpxNSC/viCxJ5O6LjFzU5Mce/p19dy4KyoU2dHPtJlosbnqXPsOSoTqU
	 7gkOWKdfsz4Yg==
Date: Mon, 26 Aug 2024 10:27:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Message-ID: <20240826102748.4be0b642@jic23-huawei>
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	<20240822-eblanc-ad4630_v1-v1-4-5c68f3327fdd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 14:45:20 +0200
Esteban Blanc <eblanc@baylibre.com> wrote:

> AD4630-24 and AD4630-16 are 2 channels ADCs. Both channels are
> interleaved bit per bit on SDO line.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Ah. I should have looked on in the patch set.  This obviously answers
question about plans to support more parts.

It feels like you made various improvements to naming etc
in this patch and then forgot to push them back to the earlier
patches.

Jonathan

> ---
>  drivers/iio/adc/ad4030.c | 197 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 173 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index e1e1dbf0565c..dbba5287b630 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -32,6 +32,8 @@
>  #define AD4030_REG_PRODUCT_ID_H				0x05
>  #define AD4030_REG_CHIP_GRADE				0x06
>  #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
> +#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE	0x03
> +#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
>  #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
>  #define AD4030_REG_SCRATCH_PAD			0x0A
>  #define AD4030_REG_SPI_REVISION			0x0B
> @@ -159,10 +161,14 @@ struct ad4030_state {
>  	struct {
>  		union {
>  			u8 raw[AD4030_MAXIMUM_RX_BUFFER_SIZE];
> -			struct {
> -				s32 val;
> -				u32 common;
> -			} __packed buffered[AD4030_MAX_HARDWARE_CHANNEL_NB];
> +			union {
> +				s32 diff[AD4030_MAX_HARDWARE_CHANNEL_NB];
> +				struct {
> +					s32 diff;
> +					u32 common;
> +				} __packed
Unless you are going to do something complex later, a union of unions is
just a union so can flatten this I think.  Also no need for __packed
for array of single size as those are always packed.

> +				buffered_common[AD4030_MAX_HARDWARE_CHANNEL_NB];

This style is confusing to read.  If you did need the __packed then it would be
worth pushing to previous line, but you don't.
In general feels like some of these renames should have been in the earlier
patch.

> +			};
>  		};
>  	} rx_data __aligned(IIO_DMA_MINALIGN);
>  };
> @@ -171,7 +177,7 @@ struct ad4030_state {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.type = IIO_VOLTAGE,						\
>  	.indexed = 1,							\
> -	.channel = _idx * 2 + 2,					\
> +	.channel = _idx * 3 + 2,					\
Odd change. Wrong patch? 
>  	.scan_index = _idx * 2 + 1,					\
>  	.extend_name = "Channel" #_idx " common byte part",		\
>  	.scan_type = {							\
> @@ -194,8 +200,8 @@ struct ad4030_state {
>  		BIT(IIO_CHAN_INFO_CALIBSCALE),				\
>  	.type = IIO_VOLTAGE,						\
>  	.indexed = 1,							\
> -	.channel = _idx * 2,						\
> -	.channel2 = _idx * 2 + 1,					\
> +	.channel = _idx * 3,						\
> +	.channel2 = _idx * 3 + 1,					\
>  	.scan_index = _idx * 2,						\
>  	.extend_name = "Channel" #_idx " differential part",		\
>  	.differential = true,						\
> @@ -412,7 +418,7 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned int avg_len)
>  static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
>  					unsigned int mask)
>  {
> -	/* Common byte channel is after the "real" differential sample channel */
> +	/* Common byte channels are after each differential channel */

Just use that comment in earlier patch to avoid noise.
Each can incorporate 1 even if it's a bit odd to read.

>  	return mask & AD4030_COMMON_BYTE_CHANNELS_FILTER;
>  }
>  

> +/*
> + * @brief Descramble 2 32bits numbers out of a 64bits. The bits are interleaved:
> + * 1 bit for first number, 1 bit for the second, and so on...
> + */
> +static void ad4030_extract_interleaved(u8 *src, u32 *ch0, u32 *ch1)
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
> +	*ch0 = out0;
> +	*ch1 = out1;
> +}
> +
>  static int ad4030_conversion(struct ad4030_state *st,
>  			     const struct iio_chan_spec *chan)
>  {
> @@ -460,12 +517,21 @@ static int ad4030_conversion(struct ad4030_state *st,
>  	if (ret)
>  		return ret;
>  
> -	if (st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> +	if (st->chip->num_channels == 2)
> +		ad4030_extract_interleaved(st->rx_data.raw,
> +					   &st->rx_data.diff[0],
> +					   &st->rx_data.diff[1]);
> +
> +	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> +	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
>  		return 0;
>  
>  	byte_index = BITS_TO_BYTES(chan->scan_type.realbits);
> -	for (i = 0; i < st->chip->num_channels; i++)
> -		st->rx_data.buffered[i].common = ((u8 *)&st->rx_data.buffered[i].val)[byte_index];
> +	/* Doing it backward to avoid overlap when reordering */
> +	for (i = st->chip->num_channels - 1; i > 0; i--) {
> +		st->rx_data.buffered_common[i].diff = st->rx_data.diff[i];
> +		st->rx_data.buffered_common[i].common = ((u8 *)&st->rx_data.diff[i])[byte_index];
> +	}

I wonder if doing it in place is actually worthwhile.  Maybe unpack into a second
array? That is still fairly small and may make code easier to read.


>  
>  	return 0;
>  }

...

>  
> +static const unsigned long ad4630_channel_masks[] = {
> +	/* Differential only */
> +	BIT(0) | BIT(2),
> +	/* Differential with common byte */
> +	GENMASK(3, 0),
The packing of data isn't going to be good. How bad to shuffle
to put the two small channels next to each other?
Seems like it means you will want to combine your deinterleave
and channel specific handling above, which is a bit fiddly but
not much worse than current code.


It only matters if you have timestamps though as otherwise
the 8 byte alignment will force 6 bytes of packing in one
place vs the 3 this gives in two places.
I guess maybe not worth doing unless you plan to combine
this with an offload engine in which case the timestamps will
probably be disabled and the 12 byte scan length will be preferable
to 16 bytes.

> +	0,
> +};
> +
>  static const struct iio_scan_type ad4030_24_scan_types[] = {
> -	[AD4030_SCAN_TYPE_NORMAL] = {
> +	[AD4030_OUT_DATA_MD_24_DIFF] = {
Name it this way in the first place.

>  		.sign = 's',
>  		.storagebits = 32,
>  		.realbits = 24,
> @@ -908,6 +1002,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
>  	},
>  };
>  
> +static const struct iio_scan_type ad4030_16_scan_types[] = {
> +	[AD4030_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 16,
> +		.shift = 16,
> +		.endianness = IIO_BE,
> +	},
> +	[AD4030_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_BE,
> +	}
> +};
> +


