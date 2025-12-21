Return-Path: <linux-iio+bounces-27302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1788CD452C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 222C63004795
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312C3019D6;
	Sun, 21 Dec 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agBTQtvX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBF2877EA;
	Sun, 21 Dec 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346883; cv=none; b=jWuLYTiHn/1bevbYB4N5DIJhGfrAN3clcV+aWZFCbSRCkdz210ncdndMFn7Xrl3nrskeC4a0K+tRYTWdgM2VR4Xn8RHU8RwHInrCvjNr7ApJvuRIAuky8z0p9LtaxQ6e2xk12IXFfb6vOE7dmwr5mbVURXjShApx8734Xdx6d+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346883; c=relaxed/simple;
	bh=z/mx8B2hdpxN1mExex7TStMICGgUrl3OlOmd6rwH5Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ky9GWXAxL9q82UAWmDYbPYRswziV9okBdwB0USPI9ai/leEfwsCjuKXYPZ2VRAVJl+8E9apexPaxqynRErwtn7MeSJkHuJIAyjHcVDffAg0yK1wHKSnEibuGlaOnsERU6VXpqXd43vgiCsir2WXBcVv0AIUso7xKzO7RCIP1n3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agBTQtvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BDBC4CEFB;
	Sun, 21 Dec 2025 19:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766346883;
	bh=z/mx8B2hdpxN1mExex7TStMICGgUrl3OlOmd6rwH5Yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=agBTQtvX75AXhMMGx1jD439neFiIvKuFiIoNY3rf28njQoV40Tbts4bljHlKHAaWm
	 yE9ZLhutGMCk/ljaOLBOA8P9NSYYO4U0hZllyb8oT1m9Ux8UiuouAJqinQwQAif5+j
	 6M44YrO0ichaYeXfYZdOU14bH4ewkDAkHNxtJLhJ2svy+xXXr6g1qwWhQKwI8WL4ZJ
	 AVERnZTCZct28f5Rr4N707wHq2CfzkQ4uxYur6X4C1UYBi1F9qEjwIpEsS9H3BHfLs
	 PYiyK7+leczDZb52ca99/wHclA2MN5mjLMH0X159BRjY5HqQvEpaO1xZNu5SflIUFN
	 EKdnHuRtBfwTA==
Date: Sun, 21 Dec 2025 19:54:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad9467: include two's complement in
 default mode
Message-ID: <20251221195434.2bdde0e6@jic23-huawei>
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d@vaisala.com>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	<20251216-b4-ad9467-optional-backend-v1-1-83e61531ef4d@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 11:40:05 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> All supported drivers currently implicitly use two's complement mode.
> Make this clear by declaring two's complement in the default
> output mode. Calibration mode uses offset binary, so change the output
> mode only when running the calibration or other test mode.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
A few comments inline, along with the obvious build error fix
from the bot report of including linux/bitfield.h

> ---
>  drivers/iio/adc/ad9467.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 59c3fa3bcc9b0b8b36b78c3b54fd7977cae23496..60fc3361b2689a4c38287c613ef93fe00338e5fa 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c

> @@ -671,10 +678,14 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
>  
>  static int ad9647_calibrate_prepare(struct ad9467_state *st)
>  {
> +	unsigned int cmode;
>  	unsigned int c;
>  	int ret;
>  
> -	ret = ad9467_outputmode_set(st, st->info->default_output_mode);
> +	cmode = (st->info->default_output_mode & ~AN877_ADC_OUTPUT_MODE_MASK) |
> +		FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
> +			   AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
As below. Maybe copy then FIELD_MODIFY() the result.

> +	ret = ad9467_outputmode_set(st, cmode);
>  	if (ret)
>  		return ret;
>  
> @@ -778,7 +789,7 @@ static int ad9647_calibrate_stop(struct ad9467_state *st)
>  			return ret;
>  	}
>  
> -	mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +	mode = st->info->default_output_mode;
>  	return ad9467_outputmode_set(st, mode);
>  }
>  
> @@ -1174,12 +1185,18 @@ static ssize_t ad9467_chan_test_mode_write(struct file *file,
>  		if (ret)
>  			return ret;
>  
> -		out_mode = st->info->default_output_mode | AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +		out_mode = st->info->default_output_mode;
>  		ret = ad9467_outputmode_set(st, out_mode);
>  		if (ret)
>  			return ret;
>  	} else {
> -		ret = ad9467_outputmode_set(st, st->info->default_output_mode);
> +		unsigned int cmode;
> +
> +		cmode = (st->info->default_output_mode &
> +			~AN877_ADC_OUTPUT_MODE_MASK) |
> +			FIELD_PREP(AN877_ADC_OUTPUT_MODE_MASK,
> +				   AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);
Might be cleaner as
		unsigned int cmode = st->info->default_output_mode;

		FIELD_MODIFY(AN877_ADC_OUTPUT_MODE_MASK, &cmode, 
			     AN877_ADC_OUTPUT_MODE_OFFSET_BINARY);

I don't mind that much though if you prefer the original.

> +		ret = ad9467_outputmode_set(st, cmode);
>  		if (ret)
>  			return ret;
>  
> 


