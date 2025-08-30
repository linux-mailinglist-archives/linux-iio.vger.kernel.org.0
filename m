Return-Path: <linux-iio+bounces-23491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A75B3CEBC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A031897A3C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F92DAFBF;
	Sat, 30 Aug 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZpxBXs7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBD2DAFA5;
	Sat, 30 Aug 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579401; cv=none; b=iVnCj6yEvH+IxpDOgT2jp5q2ZojShwEpf0lDA5j9oA+RmYXjd0IbkcGpRTp6rGwW6YkbRKlpKUnc55uljCyM9beR8Uz9IOd81jS6a9b/PanAWkR48jTavHcRJ8FuwzsOTQhK+9CIMCI2RFPhjZGKBbuGwYQfHEBZwRhCc8uPyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579401; c=relaxed/simple;
	bh=0/4i5sW5GYY43WWd8JCcpS/pAorDT72EtPMpDi0pbLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLf0QLbUQtKD67UomXkbXfA7AIoMlX4+3Jeoxsx5bCQXtinKLQJVvNTl3koIICFwymi8xA1oaCf+90886YwucusBB9tWq8pvEZuhecPDVuOwAoV9TUo1BgxXZhPszaa5ASEPSxMiyQ7R1l76/5kC6CKadhIQlPhqZ13pTWd8S7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZpxBXs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DACC4CEF1;
	Sat, 30 Aug 2025 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756579401;
	bh=0/4i5sW5GYY43WWd8JCcpS/pAorDT72EtPMpDi0pbLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZpxBXs7cohSvfKdWaw/D65K8ETuNQ91Ii3IKaomU/bGjTEgrB6KAKUe0sjuvPc7O
	 Ox91lKmqCXqVsesTPjxsZImlJl4aCDXCpQUy54JiRhG1iOzkzOnqMLoFZtohhUKehy
	 Zz2BHtPFtQUqiD461d6CEWuDzXyoNAoAR8MOjNioHQLRKr+zfDwZ7I+kFgcB2QLhqy
	 PU0dI1Y+LTLwulxGFfppoZa0qwlSyFyWKKRu4NsmFwwWkPgeQA/TRex5BKQ4qAEovk
	 QQ+YiGYQSq8YhIzjYg0SdjABh1e9/RE+4ZG01GrWH/Nw4FUma0HtOFAmcQjTwtgUPy
	 aiGrbZuARHfTw==
Date: Sat, 30 Aug 2025 19:43:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <corbet@lwn.net>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <broonie@kernel.org>,
 <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
 <ahaslam@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH 01/15] iio: adc: ad4030: Fix _scale for when
 oversampling is enabled
Message-ID: <20250830194308.32def0e5@jic23-huawei>
In-Reply-To: <f9d40e8deb3d17a41b4fd6ecc1b8ac92275f0078.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
	<f9d40e8deb3d17a41b4fd6ecc1b8ac92275f0078.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 21:40:24 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Previously, the AD4030 driver was using the number of scan realbits for the
> voltage channel to derive the scale to millivolts. Though, when sample
> averaging is enabled (oversampling_ratio > 1), the number of scan realbits
> for the channel is set to 30 and doesn't match the amount of conversion
> precision bits. Due to that, the calculated channel scale did not correctly
> scale raw sample data to millivolt units in those cases. Use chip specific
> precision bits to derive the correct channel _scale on every and all
> channel configuration.
> 
> Fixes: dc78e71d7c15 ("iio: adc: ad4030: remove some duplicate code")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Hi Marcelo

I was assuming that when this said 'averaging' it actually meant
summing (there is a note about using the upper precision bits to get the same
scaling which is what we'd expect it were simply summing over X samples).

So given that we don't divide back down to get the original scaling I'm
not following how this works.

E.g. If we 'averaged' just 2 values of 3 then we'd go from a value of 3 to
one of 6.  Therefore I'd expect the scale to halve as each lsb represents
half the voltage it did when we weren't averaging those 2 samples.

I think that is what we'd see with the current code, so my reasoning is
clearly wrong, but why?

Jonathan

> ---
> This was probalby buggy since 
> commit 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> but I decided to set the fixes tag with dc78e71d7c15 because this patch will
> not apply cleanly over 949abd1ca5a4.
> 
>  drivers/iio/adc/ad4030.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 1bc2f9a22470..82784593f976 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -394,7 +394,14 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
>  	else
>  		*val = st->vref_uv / MILLI;
>  
> -	*val2 = scan_type->realbits;
> +	/*
> +	 * Even though the sample data comes in a 30-bit chunk when the ADC
> +	 * is averaging samples, the conversion precision is still 16-bit or
> +	 * 24-bit depending on the device. Thus, instead of scan_type->realbits,
> +	 * use chip specific precision bits to derive the correct scale to mV.
> +	 */
> +	*val2 = scan_type->realbits == 30 ? st->chip->precision_bits
> +					  : scan_type->realbits;
>  
>  	return IIO_VAL_FRACTIONAL_LOG2;
>  }


