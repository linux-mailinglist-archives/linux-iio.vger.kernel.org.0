Return-Path: <linux-iio+bounces-24528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC85BA6F17
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280C43B6667
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AA2DCC13;
	Sun, 28 Sep 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjUM2nql"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595042D2499;
	Sun, 28 Sep 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759055199; cv=none; b=U6P/9iZ6x8JNEzxAUG+OrXYI6nz2nMbmZoIcRGAMhc8i8cT/dx0INxegOLD0HHeaDiZeHANK8NoZV+dy/IPebFe+UETX5YqUxn8P8N+14uTssRTK3UByLwKlrq5ZCJDXai+j5sGwzonVQMVdfv3EkPkJFmg7Zp775oEzGziBVOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759055199; c=relaxed/simple;
	bh=pJxqhvQ/ydGHAUyAzeo6A50SLSfNmD2j4zHABBSczUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLs0Ge1824NHYpPTGZ96Z+nLpo6+J+KlLJlDvWW7FmCwda8TsOFNR5HsT39AZuj1iRhzMoYlJ5vCPQvlDd4xSBa8yZsrZifiBiQA0Dgg1brFnxrBt31FlkjXPUWXYXDbnNMh68gYhf4lh2y1KcBecSwVdr29lVEN8Fgsp9zmSmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjUM2nql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4F0C4CEF0;
	Sun, 28 Sep 2025 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759055198;
	bh=pJxqhvQ/ydGHAUyAzeo6A50SLSfNmD2j4zHABBSczUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sjUM2nqlFnn6Ra2hHRfL0+nL1pbAPOJ9E+2J793lmSSs/lpvj7Ga7pD4myvJ4T4Oo
	 xZGw0tHYCZCBWM5oP3bqxumAhS60rk9aQWKIoXvk6bPXS3voz2oDll7gxehTkixLSk
	 SXn7/YFsg/KZQHbM7orqQ8mgJPzVO3ktieXMTw9yfGj9s/29u+bXVdtxD0otnXMSth
	 B5xVxhssuVt5SmqeP0tcHLEtArSg4WUP7NimTFnjXd1ftUILitxJ80KesA4f88cCZM
	 c1/a3B3eaVjgMx4lJ1/wBRy1Wi7ceQwrbC+waeDeWSx6cxWtxyPxn/2LQkBjL3OoEI
	 82WUadE2+JJKw==
Date: Sun, 28 Sep 2025 11:26:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <michael.hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 8/8] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
Message-ID: <20250928112628.7a1357ab@jic23-huawei>
In-Reply-To: <4be3b7a31146836b35cc88005f2314cff9f3db97.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
	<4be3b7a31146836b35cc88005f2314cff9f3db97.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 17:41:04 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> that scales the analog input signal prior to it reaching the ADC. The PGA
> is controlled through a pair of pins (A0 and A1) whose state define the
> gain that is applied to the input signal.
> 
> Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> through the IIO device channel scale available interface and enable control
> of the PGA through the channel scale interface.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

One trivial comment + a suggestion that we might want to consider pushing
the pin strap pga support to a future patch so we can not stall the driver
on that being resolved.  Note that would mean splitting the DT patch as well.

Anyhow, no rush on that given we have lots of time in this kernel cycle.

Jonathan

> @@ -996,6 +1116,17 @@ static int ad4030_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }

> @@ -1307,6 +1439,50 @@ static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
>  							   IIO_BUFFER_DIRECTION_IN);
>  }
>  
> +static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
> +			    struct ad4030_state *st)
> +{
> +	unsigned int i;
> +	int pga_gain_dB;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "adi,pga-gain-db", &pga_gain_dB);

I'm not sure the pga question will resolve quickly so perhaps we initially only
support the pins connected to gpios and add the pin strapped support later?

It's early in this cycle, so we can delay that decision for a few weeks and
see where we are then on that DT question.

> +	if (ret == -EINVAL) {
> +		/* Setup GPIOs for PGA control */
> +		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->pga_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +					     "Failed to get PGA gpios.\n");
> +
> +		if (st->pga_gpios->ndescs != ADAQ4616_PGA_PINS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Expected 2 GPIOs for PGA control.\n");
> +
> +		st->scale_avail_size = ARRAY_SIZE(adaq4216_hw_gains_db);
> +		st->pga_index = 0;
> +		return 0;
> +	} else if (ret != 0) {

if (ret) is fairly commonly used for error checking when non 0 is what we want.

> +		return dev_err_probe(dev, ret, "Failed to get PGA value.\n");
> +	}
> +
> +	/* Set ADC driver to handle pin-strapped PGA pins setup */
> +	for (i = 0; i < ARRAY_SIZE(adaq4216_hw_gains_db); i++) {
> +		if (pga_gain_dB != adaq4216_hw_gains_db[i])
> +			continue;
> +
> +		st->pga_index = i;
> +		break;
> +	}
> +	if (i == ARRAY_SIZE(adaq4216_hw_gains_db))
> +		return dev_err_probe(dev, -EINVAL, "Invalid PGA gain: %d.\n",
> +				     pga_gain_dB);
> +
> +	st->scale_avail_size = 1;
> +	st->pga_gpios = NULL;
> +
> +	return 0;
> +}


