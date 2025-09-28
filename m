Return-Path: <linux-iio+bounces-24526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5381ABA6EB4
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E2E3B9100
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3238A2DC33F;
	Sun, 28 Sep 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca/lIEPd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1C2561B9;
	Sun, 28 Sep 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054140; cv=none; b=BpG905/JM1BXOE7lDruilT/ODgnGV6ThxJDeSWHScr0dQH/UnrCYELjOL5d+jxxzIyC+AnYtNDZ235OWILLoVbcXgdIvJeOzXd6fkfZGse4fdUmQ7K+GGtG6w9jp6cUWBPrXRt6beHj2LfRTkDA3aeh9rkPJipsIqpNaGQaofmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054140; c=relaxed/simple;
	bh=H+cGetWpoYz5fxQOkiLy26iMWF7ZKEieo15FkWkuCLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uViCAXQqQHceZFCpgC/OVTD7dyqcqk0E24PLWSwwucblInwk5iQQhHEHgAN2pmfBQ9D1EJh8Fa9uLZ52UlWstc74wSBwWbBxg8Vxmv6ysFOrUDvYoJ6Iwg+9NuNRZCL72TS3fYtjJPyUJ4Y7jG7HKTj2sF/ezIHUfBwCneg8HgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca/lIEPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECCFC4CEF0;
	Sun, 28 Sep 2025 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759054139;
	bh=H+cGetWpoYz5fxQOkiLy26iMWF7ZKEieo15FkWkuCLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ca/lIEPdyaJwnbZ3oJujOOCpOI5rpkvkQ/U351tOwaEVZCoCBESDOpmcHPr5D3mZE
	 YDlWBKuHPEkHzu1v+y1P3gS2z/fga0zLePssp98PUVWauNq/vf66QZIrg8eLZCXemA
	 HUMmT/iCyTp60HbMrxdHjzx8wujWuXur8exQf/EIHBOEmjXMtAUt/Xe7sjdA/NilYk
	 DgvqooenheybIhwe4u4An+QlftyAhZ2sFgfDlTOL+wyxqiTVIr6/Ajp23BtkbYVr6i
	 8UP9/27yCyn+AhWo+ezKFeexmypAU7AC+Fu01BWH/aDsX2GZA4fLNx6hr78OJt6qlA
	 wd/+3umHjIvzg==
Date: Sun, 28 Sep 2025 11:08:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <michael.hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v3 6/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <20250928110836.79ab434e@jic23-huawei>
In-Reply-To: <0028720d2cb21898ef044458065ac8a0bc829588.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
	<0028720d2cb21898ef044458065ac8a0bc829588.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 17:40:29 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve such
> high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates. Add SPI offload support for AD4030
> and similar ADCs to enable data capture at maximum sample rates.
> 
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
This isn't my area of speciality so I'll be looking for some review tags from others.
Comments inline are completely trivial things that'd I'd just fix up but
you'll be doing another spin for the bot error anyway so over to you!

Jonathan

> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index cdf5933e9725..8fca98738e3e 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c

> +
> +static int ad4030_update_conversion_rate(struct ad4030_state *st,
> +					 unsigned int freq, unsigned int avg_log2)
> +{
> +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> +	struct pwm_waveform cnv_wf = { };
> +	u64 target = AD4030_TCNVH_NS;
> +	u64 offload_period_ns;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	/*
> +	 * When averaging/oversampling over N samples, we fire the offload
> +	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
> +	 * signal needs to be N times faster than the offload trigger. Take that
> +	 * into account to correctly re-evaluate both the PWM waveform connected
> +	 * to CNV and the SPI offload trigger.
> +	 */
> +	freq <<= avg_log2;
> +
> +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> +	/*
> +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> +	 * rounded PWM's value is less than 10, increase the target value by 10
> +	 * and attempt to round the waveform again, until the value is at least
> +	 * 10 ns. Use a separate variable to represent the target in case the
> +	 * rounding is severe enough to keep putting the first few results under
> +	 * the minimum 10ns condition checked by the while loop.
> +	 */
> +	do {
> +		cnv_wf.duty_length_ns = target;
> +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target += AD4030_TCNVH_NS;
> +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> +
> +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> +		return -EINVAL;
> +
> +	offload_period_ns = cnv_wf.period_length_ns;
> +	/*
> +	 * Make the offload trigger period be N times longer than the CNV PWM
> +	 * period when averaging over N samples.
> +	 */
> +	offload_period_ns <<= avg_log2;
> +
> +	config->periodic.frequency_hz =  DIV_ROUND_UP_ULL(NSEC_PER_SEC,

Bonus space after =

> +							  offload_period_ns);


> @@ -869,7 +1035,9 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
>  static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
>  				   const unsigned long *scan_mask)
>  {
> -	return ad4030_set_mode(indio_dev, *scan_mask);
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	return ad4030_set_mode(st, *scan_mask, st->avg_log2);
Trivial and entirely up to you but you can do the following without significant lost of
readability.

	return ad4030_set_mode(iio_priv(indio_dev), &scan_mask, st->avg_log2);

>  }


