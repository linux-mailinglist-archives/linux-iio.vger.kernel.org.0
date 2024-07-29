Return-Path: <linux-iio+bounces-8033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B193FEE3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 22:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996AF1F22374
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BEF1891D6;
	Mon, 29 Jul 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8Iy2am9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021315FA68;
	Mon, 29 Jul 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722284004; cv=none; b=LpB/Er8xmj0JG0SOM36LqSHZdJRb6Ocxo8mGiL4ilzomR/rxW3SUbnuP5nN6JcMedGO+WFUCw+1ZPJwdgHvLEaofDcs2ze+4HaqeoEqflsRVVur7R9qLUBs+wmOfiLrax9gf6r6dy8uTRMhttEYlXlGW9gjIf+y8i4a3mNeGM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722284004; c=relaxed/simple;
	bh=gGPWhEtkSuI4gw/H/rrz1kWifg4thlzksAPcYyJnj/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHs8XJPq92Bw6WStF9bju9KJ7qRMbIOmUJLqsW3qUCFXW0HNoCDglC0du/nCvzRw/uUhQfYNmSxOEEcXvmN4Dj+tglqa6K1W6yRzW60Wflm7pALdZKxLtiwgWfPLdc9k0Ig0LMJmk//ZWFeg77GV9E9rwIlTw3IXe81w10k6HFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8Iy2am9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8515C32786;
	Mon, 29 Jul 2024 20:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722284004;
	bh=gGPWhEtkSuI4gw/H/rrz1kWifg4thlzksAPcYyJnj/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8Iy2am9pROePioztZsl33xXkSdkDesNp8mvififF+1Z+3OZ10zAMFWzEjv5Hs1KO
	 l0LB4wsyWhhRZNtnmTgd4KYQS301Y9qqLCLjUZvRTxSqOIGhV+1+UQFp56yvijQX0T
	 2bXD3YZ9+UOsSHjDKdwy051bYjHjCWVyAd1v/5RRL+mLnU5i+qps+czmQoWPJwJHRf
	 NJJbMuG7E6mJ2XF8ympEDWi/ivx/ewqXawlzDUzKrKch3pSTjjeuSIjk6i0GmMEcJR
	 JT7kn1W+208bp1deITY8xYaME4rMg6gyxTGU+7xsS60kK7rlvhdn6a6KsnNDjVqnQq
	 Lm/RDm6FL1sDA==
Date: Mon, 29 Jul 2024 21:13:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Esteban Blanc" <eblanc@baylibre.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nuno Sa" <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>
Subject: Re: [PATCH RFC 2/5] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20240729211316.3b0d3f8b@jic23-huawei>
In-Reply-To: <D323OLK1T0CG.1OGNBVY1FDVJT@baylibre.com>
References: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
	<20240627-eblanc-ad4630_v1-v1-2-fdc0610c23b0@baylibre.com>
	<20240629173945.25b72bde@jic23-huawei>
	<D323OLK1T0CG.1OGNBVY1FDVJT@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 16:42:16 +0200
"Esteban Blanc" <eblanc@baylibre.com> wrote:

> On Sat Jun 29, 2024 at 6:39 PM CEST, Jonathan Cameron wrote:
> > On Thu, 27 Jun 2024 13:59:13 +0200
> > Esteban Blanc <eblanc@baylibre.com> wrote:
> >  
> > > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> > > 
> > > The driver implements basic support for the AD4030-24 1 channel
> > > differential ADC with hardware gain and offset control.
> > > 
> > > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>  
> 
> ...
> 
> > > +static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
> > > +			   void *val, size_t val_size)
> > > +{
> > > +	struct ad4030_state *st = context;
> > > +
> > > +	struct spi_transfer xfer = {
> > > +		.tx_buf = st->tx_data,
> > > +		.rx_buf = st->rx_data.raw,
> > > +		.len = reg_size + val_size,
> > > +	};
> > > +	int ret;
> > > +
> > > +	memcpy(st->tx_data, reg, reg_size);
> > > +
> > > +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	memcpy(val, &st->rx_data.raw[reg_size], val_size);  
> >
> > Can you just use spi_write_then_read() here?
> >  
> 
> I was planning on doing that. But I'm getting a timeout issue when
> using `spi_write_then_read`. I can see the tx_data going out, rx_data
> is recived but CS is kept asserted. I need to investigate more but in
> the meantime I'm using this as it is working. I will remove this
> workaround if I can find a fix and add a comment for now.
Fair enough. We've had a few drivers where the timing doesn't work
recently. Definitely good to leave a comment to avoid a 'fix' :)

> 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (st->chip->precision_bits == 16)
> > > +		offset <<= 16;
> > > +	else
> > > +		offset <<= 8;  
> >
> > As below. This is hard tor read. Just use appropriate unaligned gets for the
> > two cases to extract the write bytes directly.
> >  
> > > +	*val = be32_to_cpu(offset);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ad4030_set_chan_gain(struct iio_dev *indio_dev, int ch, int gain_int,
> > > +				int gain_frac)
> > > +{
> > > +	struct ad4030_state *st = iio_priv(indio_dev);
> > > +	__be16 val;
> > > +	u64 gain;
> > > +
> > > +	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
> > > +
> > > +	if (gain > AD4030_REG_GAIN_MAX_GAIN)
> > > +		return -EINVAL;
> > > +
> > > +	val = cpu_to_be16(DIV_ROUND_CLOSEST_ULL(gain * 0x8000, MICRO));
> > > +
> > > +	return regmap_bulk_write(st->regmap, AD4030_REG_GAIN_CHAN(ch), &val,
> > > +			  AD4030_REG_GAIN_BYTES_NB);
> > > +}
> > > +
> > > +static int ad4030_set_chan_offset(struct iio_dev *indio_dev, int ch, int offset)
> > > +{
> > > +	struct ad4030_state *st = iio_priv(indio_dev);
> > > +	__be32 val;
> > > +
> > > +	if (offset < st->min_offset || offset > st->max_offset)
> > > +		return -EINVAL;
> > > +
> > > +	val = cpu_to_be32(offset);
> > > +	if (st->chip->precision_bits == 16)
> > > +		val >>= 16;
> > > +	else
> > > +		val >>= 8;  
> >
> > I 'think' I get what this is doing but not 100% sure as it's a bit too unusual
> > and I'm not even sure what happens if we shift a __be32 value on a little endian
> > system. I would instead split this into appropriate cpu_to_be24() and cpu_to_be16()
> > to put the value directly in the right place rather than shifting in place.  
> 
> cpu_to_be24 does not exist yet. I will have a look on how to add them.
Ah. Almost by definition be24 isn't aligned in some cases.
So put_unaligned_be24() is what you are looking for.
My mistake!

Jonathan

> 
> 
> All the other comments will be addressed in V2.
> 
> Best regards,
> 


