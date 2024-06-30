Return-Path: <linux-iio+bounces-7084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D668791D163
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 13:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563671F2208C
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3713BC30;
	Sun, 30 Jun 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfbHhE0p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D47200C1;
	Sun, 30 Jun 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719746256; cv=none; b=Z4XlsTKo+5Gcruw1h2pknVWayT5sZ5dXIy6kmVBDOpc3Drv5K32J9/UAodJu1E/McszXKgELphBAXGQGcDmqjk40dmfk59mzaCTsg/mY263y3SBbqYHcsEhE2PnMrR1hkM9/3lvMtQ6jGuoAj4WlG6bwJI0yeOkv5ddJMY0cWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719746256; c=relaxed/simple;
	bh=NaPQ4uNEOSAllGqmDxgXXmyzGu/F7JDU6SOkzOWwVzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFM8Niqd7T8gLfKwB79wn+fUrBUfJBx56NMi0kq12gDBB2iwBUdMYhSUge1Z1UcF0GOHP8u+dYLhq/B4AQRyNdACUK3e1UGFoy0F7XZf0DnwjWNHVo4Cxhc5AkUEa3i976jv4VvGYT5noKbXB1W/8V558wdTeAEGtisYL639+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfbHhE0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434D1C2BD10;
	Sun, 30 Jun 2024 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719746255;
	bh=NaPQ4uNEOSAllGqmDxgXXmyzGu/F7JDU6SOkzOWwVzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfbHhE0p09RkjXrsJifIsNH0PoYOAp4wH5j47/qd7FzYIt1j+1n3ZoeO/GpWC27nE
	 UxTANs4hGAWsJMWc8vv4qJfESebNiLY4s2Qr9EFdq+WxqN7KkJVD7L/lW3gbIhTTaA
	 t0ffC/HFW77BhLC72xp6Nv+l0wY7FkmgmSvIz8lghKNwV3CDEWfIauUnfWQxfnThsS
	 2OwgvLtd10nC0IzT8brNo8B6iM8mBEKcHmAm2MsmKb6yevXrwOgEwJ/6Cdcekn9XG5
	 +nPGv1yG93M/eiT9gv85gNVtvDRn4Bgvp5v85jgCCeWny+nclBkiuCxa39acxNATUO
	 opdXS2BwS4cfw==
Date: Sun, 30 Jun 2024 12:17:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 6/7] iio: adc: Add support for AD4000
Message-ID: <20240630121726.5d75578e@jic23-huawei>
In-Reply-To: <628a85cb8cbee32ea7d2930c63e73f2ef449a800.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
	<628a85cb8cbee32ea7d2930c63e73f2ef449a800.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Jun 2024 16:06:59 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add support for AD4000 series of low noise, low power, high speed,
> successive approximation register (SAR) ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Hi Marcelo

A few comments inline. However, the spi_w8r8 etc can easily be a follow up
optimization patch (if you agree it's a good improvement) and the
other changes are so trivial I could tweak whilst applying.

So unless you have to do a v7 for some other reason this is fine for
merging as is - subject to the fact it's not been on list long enough yet
and I need Mark to pick up the SPI parts and throw me a tag to pull.

Thanks,

Jonathan


> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c
> @@ -0,0 +1,708 @@

> +
> +struct ad4000_state {
> +	struct spi_device *spi;
> +	struct gpio_desc *cnv_gpio;
> +	struct spi_transfer xfers[2];
> +	struct spi_message msg;
> +	struct mutex lock; /* Protect read modify write cycle */
> +	int vref_mv;
> +	enum ad4000_sdi sdi_pin;
> +	bool span_comp;
> +	u16 gain_milli;
> +	int scale_tbl[AD4000_SCALE_OPTIONS][2];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> +	 * to live in their own cache lines.
> +	 */
> +	struct {
> +		union {
> +			__be16 sample_buf16;
> +			__be32 sample_buf32;
> +		} data;
> +		s64 timestamp __aligned(8);
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +	u8 tx_buf[2];
> +	u8 rx_buf[2];

If you made the spi_w8r8() change suggested below (which uses a bounce buffer
in the spi core), rx_buf would be unused and can go away.

Given I think registers accesses on this device are all off the fast path
you could even use spi_write_then_read() with zero read size for the
register writes and rely on the spi core bounce buffers.
That way tx_buf goes away as well leaving you with the dma
safe buffer for only the fast path reads.

> +};
> +
> +static void ad4000_fill_scale_tbl(struct ad4000_state *st,
> +				  struct iio_chan_spec const *chan)
> +{
> +	int val, tmp0, tmp1;
> +	int scale_bits;
> +	u64 tmp2;
> +
> +	/*
> +	 * ADCs that output two's complement code have one less bit to express
> +	 * voltage magnitude.
> +	 */
> +	if (chan->scan_type.sign == 's')
> +		scale_bits = chan->scan_type.realbits - 1;
> +	else
> +		scale_bits = chan->scan_type.realbits;
> +
> +	/*
> +	 * The gain is stored as a fraction of 1000 and, as we need to
> +	 * divide vref_mv by the gain, we invert the gain/1000 fraction.
> +	 * Also multiply by an extra MILLI to preserve precision.
> +	 * Thus, we have MILLI * MILLI equals MICRO as fraction numerator.
> +	 */
> +	val = mult_frac(st->vref_mv, MICRO, st->gain_milli);

If you are rolling a v7 for other reasons, stick some line breaks in here!
It's a bit of a mass of text that is hard for my eyes to parse!

> +	/* Would multiply by NANO here but we multiplied by extra MILLI */
> +	tmp2 = shift_right((u64)val * MICRO, scale_bits);
> +	tmp0 = div_s64_rem(tmp2, NANO, &tmp1);
> +	/* Store scale for when span compression is disabled */
> +	st->scale_tbl[0][0] = tmp0; /* Integer part */
> +	st->scale_tbl[0][1] = abs(tmp1); /* Fractional part */
> +	/* Store scale for when span compression is enabled */
> +	st->scale_tbl[1][0] = tmp0;
> +	/* The integer part is always zero so don't bother to divide it. */
> +	if (chan->differential)
> +		st->scale_tbl[1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 4, 5);
> +	else
> +		st->scale_tbl[1][1] = DIV_ROUND_CLOSEST(abs(tmp1) * 9, 10);
> +}

> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +	struct spi_transfer t = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +		.len = 2,
> +	};
> +	int ret;
> +
> +	st->tx_buf[0] = AD4000_READ_COMMAND;
> +	ret = spi_sync_transfer(st->spi, &t, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = st->rx_buf[1];
> +	return ret;

I'd be tempted to do

	ssize_t ret;

	ret = spi_w8r8(AD4000_READ_COMMAND);
	if (ret < 0)
		return ret;
	*val = ret;
	
	return 0;

> +}


> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	bool span_comp_en;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			guard(mutex)(&st->lock);
> +
> +			ret = ad4000_read_reg(st, &reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			span_comp_en = val2 == st->scale_tbl[1][1];
> +			reg_val &= ~AD4000_CFG_SPAN_COMP;
> +			reg_val |= FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_en);
> +
> +			ret = ad4000_write_reg(st, reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			st->span_comp = span_comp_en;
> +			return ret;

If you are spinning for another reason, make it clear this is always good.
The spi_write() never returns positive so current code is correct but I had
to go check which this would have avoided.

			return 0;

If nothing else comes up, I'll probably tweak whilst applying.

J

> +		}
> +		unreachable();
> +	default:
> +		return -EINVAL;
> +	}
> +}


