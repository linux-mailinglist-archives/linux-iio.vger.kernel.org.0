Return-Path: <linux-iio+bounces-24308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B5B8C4E4
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B09D560546
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096529ACD1;
	Sat, 20 Sep 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/bFJ6Dc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E335D515;
	Sat, 20 Sep 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361383; cv=none; b=ZniHNelF9v4OCjQ+6LNTSd4tCh7ecVkrC/xNy7qOL3QJjZZn0twueTH0bdt+Orgj3SCOpp6/kSuEjO2bY3ShugJb7PWjZgoSHR7kYdrCI34qKgquotz84cCZGiv5yVjCi/kuGSuFEMPKouCLyOD1h44wNQ4wa8xu36AEF3ZJe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361383; c=relaxed/simple;
	bh=8XEGRu8PQcCsAGb5Pu649yAmmLV43sxK7OgP8RaqHIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExB4rrWA2HS8ePpqscNKksUjmFypuse6dgHdGguJbAvj7jLfjecJJV/9C6/aqX5avbK6htSXpoa0toYCRm+TyT+XN5HgKN88IH7Nkmy09pOL1QS69kZFIB80P8AQfltw3zDcEDEPXF3+t0c63csuVqVTKjBOdOs2Ns3FKMqlDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/bFJ6Dc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704A8C4CEEB;
	Sat, 20 Sep 2025 09:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758361383;
	bh=8XEGRu8PQcCsAGb5Pu649yAmmLV43sxK7OgP8RaqHIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/bFJ6DcZg6XnjoiQxOLyqkj1KqVKcdbFhcyehayJCuNqEEQagXjhb62HCUuaoYzu
	 /K+TPoFR8bgv1ki7hrjPd3sEwHE89MYuziUK8Ix28FYKSLnx3n5PbC/jx0nsFhKBoB
	 hSSdxxmfwGoKXNY5hj3tStgrUgft6jj4GNEf5SLQUbOZJvr4LiTDgJgIdPhMFa/tvR
	 rIg6cJkdgS8D9qJhxWGBXoDIcW6NBcsuoPHT/H8Z4Yppp4+YM2eDo2iSHyALfYqWEc
	 9r8hcFsSefToKgky4mm2hLmcmy5PEJP4WkwkEsj7tyNWwRPHki26ISDh8B3V12ioqv
	 La3FwOFmoEoxA==
Date: Sat, 20 Sep 2025 10:42:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <michael.hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v2 6/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <20250920104251.3f7dcbb2@jic23-huawei>
In-Reply-To: <da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
	<da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 14:39:10 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.
> 
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Most of the code for SPI offload support is based on work from Sergiu Cuciurean,
> Nuno Sa, Axel Haslam, and Trevor Gamblin. Thus, this patch comes with many
> co-developed-by tags. I also draw inspiration from other drivers supporting SPI
> offload, many of them written by David Lechner.
> 
> Change log v1 -> v2
> - Dropped all clock-modes and DDR related stuff for now as those will require
>   further changes to the SPI subsystem or to SPI controller drivers.
> - Update the modes register with proper output data mode bits when sample
>   averaging (oversampling_ratio) is set.
> - Lock on device state mutex before updating oversampling and sampling frequency.
> - Made sampling_frequency shared by all channels.
> - Better checking the requested sampling frequency is valid.
> - Adjusted to SPI offload data capture preparation and stop procedures.
> - Error out if try to get/set sampling frequency without offload trigger.
> - Depend on PWM so build always succeed.
> - Drop unmatched/unbalanced call to iio_device_release_direct().
> - No longer shadowing error codes.
> 
> Suggestions to v1 that I did not comply to:
> [SPI]
> > I would be tempted to put the loop check here [in drivers/spi/spi-offload-trigger-pwm.c]:
> > 
> > 	offload_offset_ns = periodic->offset_ns;
> > 
> > 	do {
> > 		wf.offset_ns = offload_offset_ns;
> > 		ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
> > 		if (ret)
> > 			return ret;
> > 		offload_offset_ns += 10;
> > 
> > 	} while (wf.offset_ns < periodic->offset_ns);
> > 
> > 	wf.duty_offset_ns = periodic->offset_ns;
> > 
> > instead of in the ADC driver so that all future callers don't have to
> > repeat this.  
> 
> Not sure implementing the PWM trigger phase approximation/rounding/setup within
> spi-offload-trigger-pwm is actually desirable. The PWM phase
> approximation/rounding/setup done in AD4030 iterates over the configuration of a
> second PWM (the PWM connected to the CNV pin). I haven't seen any other device
> that would use such double PWM setup schema so pushing an additional argument to
> spi_offload_trigger_pwm_validate() doesn't seem worth it.
> 
> [IIO]
> > Why using slower speed for offload?  
> Looks like it's the same max speed for both register access and data sample.
> So, just reusing the existing define for the max transfer speed.
> 
>  drivers/iio/adc/Kconfig  |   3 +
>  drivers/iio/adc/ad4030.c | 485 +++++++++++++++++++++++++++++++++++----
>  2 files changed, 445 insertions(+), 43 deletions(-)
Hi Marcelo

Just one thing I noticed today.  If nothing else comes up I can fix that
up whilst applying.  However, this will benefit from review from others
+ the IIO tree is effectively closed for this cycle so we have lots of time
to tidy up any remaining stuff.

Thanks,

Jonathan
 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index aa0e27321869..52805c779934 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c

> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));
> +	if (ret)
> +		return ret;
> +
> +	ad4030_prepare_offload_msg(indio_dev);
> +	st->offload_msg.offload = st->offload;
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret)
> +		goto out_reset_mode;
> +
> +	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_pwm_disable;
> +
> +	return 0;
> +
> +out_pwm_disable:
> +	pwm_disable(st->cnv_trigger);
> +out_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +out_reset_mode:
> +	/* reenter register configuration mode */
> +	ret = ad4030_enter_config_mode(st);

This blows away the original error.  I'd do something like
	if (ad40303_enter_config_mode(st))
		dev_err(...)

	return ret;
so we preserve whatever went wrong first.


> +	if (ret)
> +		dev_err(&st->spi->dev,
> +			"couldn't reenter register configuration mode\n");
> +	return ret;
> +}




