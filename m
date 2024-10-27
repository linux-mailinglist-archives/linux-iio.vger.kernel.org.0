Return-Path: <linux-iio+bounces-11376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E48379B1CC3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83E67B21B38
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FF713B2B8;
	Sun, 27 Oct 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttyMvxhm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7441A8E;
	Sun, 27 Oct 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020948; cv=none; b=q/h2EgLPtqLRZcq4vd0xSptl5o7p3O9wcokq6g2XCfu+pbLqfaqEUeiE4REJTT34f89rcUeb4HyaiT4eMtXvHxLtgnqdcUGurcAp7gefccaBpYhitQOzgMMsLj0hyx51eTZ0snaZqaitn5BitBNWDZ/97zD6PXfiEu02wgVxHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020948; c=relaxed/simple;
	bh=ExHRIF6gwXnJTITxLEI5oYooxR5LpmWyUgh+6/92KOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrNlMKkG8bGXB4meg/wWAlO2xUxhhvsXHBTHuGcSYm+FEcE5p+5oaHGJW622p6PqvhD4E9Hf7bz+/rz1GCAknLqwMsVlbaqPOBFcV3OMCGfEbazkx6LGdizF44Bw0XhECyThch5P7Euo+XkkQqkZ9QCNOd134P9xDJ7ycFajQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttyMvxhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B034BC4CEC3;
	Sun, 27 Oct 2024 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730020947;
	bh=ExHRIF6gwXnJTITxLEI5oYooxR5LpmWyUgh+6/92KOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ttyMvxhmP6d1kX6QqMLrHyKTF+uk023nsgUmTFzYkcgDqgCKCCtAaHWzivflmNR0q
	 XcdVgaAv+lDKsAUx3lqw0iKWYHVBq7rStelxvq4wZGUMiZCwoM9qMLbu6LGs/D6pmG
	 JHtyymgCU1hCHNjMetCiEz4q2HXp7sgpLkAKgiGPMaqSamKs+B49ELnSiy7CNdIS3K
	 00Mx2IWs8E0pHm+6b0cc3bZwJ4yC/xi3gk1Rsz/92Oozobp9uvCE9dapMA6icaBO0y
	 jdi/S558gLBjU0CyfxVqDO9AYXsrpLHRnTNVnfD9GPaLhuECNn5lnHVlK9YWxCz0Jz
	 Pnyur/z1ha99A==
Date: Sun, 27 Oct 2024 09:22:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: adc: ad7380: fix oversampling formula
Message-ID: <20241027092217.2d4fbcb9@jic23-huawei>
In-Reply-To: <20241024-ad7380-add-adaq4380-4-support-v3-2-6a29bd0f79da@baylibre.com>
References: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
	<20241024-ad7380-add-adaq4380-4-support-v3-2-6a29bd0f79da@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 10:16:57 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> The formula in the datasheet for oversampling time conversion seems to
> be valid when device is at full speed using the maximum number of SDO
> lines. The driver currently support only 1 SDO line. The formula will

The 'new or corrected' formula I assume not the one in the datasheet?

> produce larger delays than what is currently set, but some devices
> actually require it.

This series is I think backed up behind the fixes chasing through Greg's
trees so I'm being a little fussier than I might otherwise be (when I'd
maybe just change stuff whilst applying and ask you to check the result!)

Code here looks fine, just a comment on the comment dropped.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/adc/ad7380.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index fb728570debe6432d5f991595cb35e9e7af8b740..d57e17f38925da5fb7c8a0a2320a21474ba04b37 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -77,6 +77,12 @@
>  #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
>  #define T_POWERUP_US 5000		/* Power up */
>  
> +/*
> + * AD738x support several SDO lines to increase throughput, but driver currently
> + * supports only 1 SDO line (standard SPI transaction)
> + */
> +#define AD7380_NUM_SDO_LINES		1
> +
>  struct ad7380_timing_specs {
>  	const unsigned int t_csh_ns;	/* CS minimum high time */
>  };
> @@ -649,7 +655,8 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
>  
>  	if (st->oversampling_ratio > 1)
>  		xfer.delay.value = T_CONVERT_0_NS +
> -			T_CONVERT_X_NS * (st->oversampling_ratio - 1);
> +			T_CONVERT_X_NS * (st->oversampling_ratio - 1) *
> +			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
>  
>  	return spi_sync_transfer(st->spi, &xfer, 1);
>  }
> @@ -667,12 +674,13 @@ static void ad7380_update_xfers(struct ad7380_state *st,
>  
>  	/*
>  	 * In the case of oversampling, conversion time is higher than in normal
> -	 * mode. Technically T_CONVERT_X_NS is lower for some chips, but we use
> -	 * the maximum value for simplicity for now.
> +	 * mode: t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS*(x - 1)*num_channel/number_of_sdo_lines
> +	 * where x is the oversampling ratio

Could drop the comment as the code is pretty clear.  Is the statement about T_CONVERT_X_NS
being the max value of supported chips worth keeping?

>  	 */
>  	if (st->oversampling_ratio > 1)
>  		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
> -			(st->oversampling_ratio - 1);
> +			(st->oversampling_ratio - 1) *
> +			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
>  
>  	if (st->seq) {
>  		xfer[0].delay.value = xfer[1].delay.value = t_convert;
> @@ -1021,7 +1029,8 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
>  	/* SPI 1-wire mode */
>  	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
>  				  AD7380_CONFIG2_SDO,
> -				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
> +				  FIELD_PREP(AD7380_CONFIG2_SDO,
> +					     AD7380_NUM_SDO_LINES));
>  }
>  
>  static int ad7380_probe(struct spi_device *spi)
> 


