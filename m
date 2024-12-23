Return-Path: <linux-iio+bounces-13758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E619FAE2F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B854161E35
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2024 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4503A19DF95;
	Mon, 23 Dec 2024 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/rvdUHg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E4194C69;
	Mon, 23 Dec 2024 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734956153; cv=none; b=KE9KN34JRFCRowyb490S5J9JBFkvo1yCkroj+SUzyFJdePmI8vgfXqUIw7iVNQhrHMfHjo2eHcS59gsrEL26quQGNg7NfNMefr7WuRc4kACuHU++EOOj2i725Lz+I8CC2CY7dGdVVT7tmzl652lkX2Y1PgNPe+cL//oV+JCjMyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734956153; c=relaxed/simple;
	bh=pxTZeuCLhpWPZhZG4FzgMGz5D9zyramfwjXIGOyu6pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn8gdq5DBnXybfzZchI4Sz0Ra5qj2sbnDLHpnbJgo786JwgWmL53RNhZmYXsZkQz3rT3Jwj4TrYfBIVXKz91JPtm6Se7lP/7ECBI57/rbf8LjEfAQuBznLSpUV0HR+NSWdwv5MIe08sCVFWo6w/BltgdjIxMqWYrrMnSuZOCPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/rvdUHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC11DC4CED3;
	Mon, 23 Dec 2024 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734956152;
	bh=pxTZeuCLhpWPZhZG4FzgMGz5D9zyramfwjXIGOyu6pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/rvdUHge1PuO3OqMDtwgNIeuhdvbzm3bUG9l9pI8LLGaMjMYPhmusM9qWm/GWGjt
	 nqXhwRslI73rVIQgWWLAWbwKcX7RKY93SFblS5g0kR2MUcAOevmAR/u/QpVSGjvgA0
	 NmuSGK09XZUmvLCfiAZQua1bhbC5rJAOG6EFPnhP+9BRFQDBU56qeTs1KrLrt7ChXl
	 0aV0Bqm/yjl6DgoPk+Boh+zh4u1iW9PJeM2t2J9qQVczPMw4VxzcE9PmcNRYXvheRL
	 W5uA3prhskH1zFOztAostPF5yzYwgzoGodprwedHyhnihERka5dTo305VrSjDZDeVD
	 sAtjID/lHLt4A==
Date: Mon, 23 Dec 2024 12:15:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20241223121542.76c53b7e@jic23-huawei>
In-Reply-To: <20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5@baylibre.com>
References: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
	<20241219-eblanc-ad4630_v1-v2-2-f36e55907bf5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 17:10:37 +0100
Esteban Blanc <eblanc@baylibre.com> wrote:

> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> 
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

Hi Esteban,

Just a couple of really trivial things inline. Key here is Marcelo's question
about moving the mode selection into regmap callbacks.

Jonathan

> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..feb98a0fdbeb3e48cd356d817a5dda6d23f5ed3f
> --- /dev/null
> +++ b/drivers/iio/adc/ad4030.c


> +static int ad4030_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals = st->offset_avail;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*vals = (void *)ad4030_gain_avail;

Trivial but could just cast it to the right type instead of using void *
to avoid it :)

> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_RANGE;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4030_exit_config_mode(st);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
might as well
	return ad4030_exit_config_mode(st);
and save a couple of lines with no significant loss of readability.

> +}

