Return-Path: <linux-iio+bounces-7108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D7D91E7F4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703D31C220FF
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB5D16F0E0;
	Mon,  1 Jul 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+u8hD3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FA10F9;
	Mon,  1 Jul 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859652; cv=none; b=OmKjhOYKZk04A+iErMBkP7CnnmkXn5wsim+egto2gYO9E4G0wVVoMloMCcyW1zi7Tm9Sa7EpKKbsuW/J5fum2W09JalpKC4RBL4Hkid3wG680r6N4GUA3I+GxC7cNydYlKaTt1yN//t4TDh3iKF9HG3l/Z+Q9swC6j8NxDVOtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859652; c=relaxed/simple;
	bh=mFnr02DFIB+78ElF7PX2SxQ0feYn1cUlA/Ood/r/mbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icrcq/qHNaOSaslEb8Ij1Hjq3kmukMNKvZjsSacyfAUBPu9x47ETD1cC3nuDotiRGjjF0rEkuhhSWUlo3UTZ3imOcAao6sZk3rQM26O3wOHQq1DjdkCBrCnjihqsi0hHCZMLJ89ctDu7mx7YltoHazkjlGafSoKGft9Xdb9R7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+u8hD3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D85C116B1;
	Mon,  1 Jul 2024 18:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719859652;
	bh=mFnr02DFIB+78ElF7PX2SxQ0feYn1cUlA/Ood/r/mbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+u8hD3CVgxWZ2aQXxJHi32ecExvb+y6WKnLtUhy8GwcacBUWSqro5cAv/C3jT9qT
	 fA4PgF/i8BySUlO2Ez0LpOnT5gQWrIyS+kUfzLvkslDFZcG/J6cPpYUadatt4HcqEs
	 2cUin7dQTOIMaigzSREN+i8NH2e/PWeP+O3yI8A1V1LungGY3w+Hoxjn5xvZc9N0lv
	 zZP9vkevEqWnCJuvxh73LvrKBlIAwGpO8ivuQdWN2LtvNTQxGlWzj6FDwz2spkxEsf
	 6golh5dLyrrH3RjWxCLum43jJ0JVgYa+Irs3iNGRSBS7tAbUNELTVS944VuIZwBaUG
	 SmKbjN5WRnweQ==
Date: Mon, 1 Jul 2024 19:47:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, corbet@lwn.net, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: adc: Add support for AD4000
Message-ID: <20240701194721.389d0729@jic23-huawei>
In-Reply-To: <ZoLxLgpy44S38nSe@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
	<628a85cb8cbee32ea7d2930c63e73f2ef449a800.1719686465.git.marcelo.schmitt@analog.com>
	<20240630121726.5d75578e@jic23-huawei>
	<ZoLxLgpy44S38nSe@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2024 15:10:54 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 06/30, Jonathan Cameron wrote:
> > On Sat, 29 Jun 2024 16:06:59 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >   
> > > Add support for AD4000 series of low noise, low power, high speed,
> > > successive approximation register (SAR) ADCs.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>  
> > 
> > Hi Marcelo
> > 
> > A few comments inline. However, the spi_w8r8 etc can easily be a follow up
> > optimization patch (if you agree it's a good improvement) and the
> > other changes are so trivial I could tweak whilst applying.
> >   
> ...
> > > +	/*
> > > +	 * The gain is stored as a fraction of 1000 and, as we need to
> > > +	 * divide vref_mv by the gain, we invert the gain/1000 fraction.
> > > +	 * Also multiply by an extra MILLI to preserve precision.
> > > +	 * Thus, we have MILLI * MILLI equals MICRO as fraction numerator.
> > > +	 */
> > > +	val = mult_frac(st->vref_mv, MICRO, st->gain_milli);  
> > 
> > If you are rolling a v7 for other reasons, stick some line breaks in here!
> > It's a bit of a mass of text that is hard for my eyes to parse!
> >   
> Ack
> 
> ...
> 
> >   
> > > +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> > > +{
> > > +	struct spi_transfer t = {
> > > +		.tx_buf = st->tx_buf,
> > > +		.rx_buf = st->rx_buf,
> > > +		.len = 2,
> > > +	};
> > > +	int ret;
> > > +
> > > +	st->tx_buf[0] = AD4000_READ_COMMAND;
> > > +	ret = spi_sync_transfer(st->spi, &t, 1);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val = st->rx_buf[1];
> > > +	return ret;  
> > 
> > I'd be tempted to do
> > 
> > 	ssize_t ret;
> > 
> > 	ret = spi_w8r8(AD4000_READ_COMMAND);
> > 	if (ret < 0)
> > 		return ret;
> > 	*val = ret;
> > 	
> > 	return 0;
> >   
> I tried this when working on v6. Only difference was I had declared ret as int.
> Then reg values were not read correctly with spi_w8r8().
> I'm either missing something or reg access must be 16-bit transfer.
> Datasheet sais:
> "The AD4000/AD4004/AD4008 configuration register is read from and written to
> with a 16-bit SPI instruction."
> Yet, besides possible delay between first and last 8 SCLK pulses, I don't see
> any transfer level differences between current and spi_w8r8() versions.
Ah. If you go around again, throw in a comment so we don't 'fix' it in
the future!

> 
> > 
> >   
> ...
> > > +			ret = ad4000_write_reg(st, reg_val);
> > > +			if (ret < 0)
> > > +				return ret;
> > > +
> > > +			st->span_comp = span_comp_en;
> > > +			return ret;  
> > 
> > If you are spinning for another reason, make it clear this is always good.
> > The spi_write() never returns positive so current code is correct but I had
> > to go check which this would have avoided.
> > 
> > 			return 0;  
> 
> Ack
> > 
> > If nothing else comes up, I'll probably tweak whilst applying.
> > 
> > J
> >   
> > > +		}
> > > +		unreachable();
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}  
> >   


