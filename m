Return-Path: <linux-iio+bounces-5290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A2D8CF01D
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBAC1C20E1A
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F308593B;
	Sat, 25 May 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obBvJa60"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6109473;
	Sat, 25 May 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716654950; cv=none; b=ePWI/CREhpm91UM7BGZfqr71dBcAe07NuWnRd2jo8AF4Cx2uujyRkeOVkElPL3pVQG3xk4PmkDBv62X1NnrPz6aOzkLNLQuj0C/Uz3MxoiFOZUVp3UnCkeY2n8Yma9O+zK84AwJRt2coAub5QxYIyFavm5bRjb4gcBU723kRFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716654950; c=relaxed/simple;
	bh=Sqqz1FjK+oJdzV4g2FjKietB7+W/O0D+oOGIlfRmPMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5TJfiV24G5SayPjcUFjX3+URV4NLsWUgtVpOVH0DRrpp9ScnvXVrCZmrhXx7HcJA+XwYNDNSXvJSuVcqtKThFK8i6+tlg+BWoGCsvTyfmcFvITm7+5z0Y5plmIKWZYfitO6FFkVv5noH7eqmTllZTNY/ZGq5p00RNEFPpWhniY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obBvJa60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2200C2BD11;
	Sat, 25 May 2024 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716654949;
	bh=Sqqz1FjK+oJdzV4g2FjKietB7+W/O0D+oOGIlfRmPMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obBvJa60w7bIvZhP5zGUyHSOKm1zYl+fQcZpLIlXCimrlFMbS1hJfE/jBznPoMgzN
	 gOpONnT4wZJ7Z8wOMexRxewOt2rSgM6VOjVMse7kkhujZ7EdaRjgCPRehpvy+eCNVe
	 CmXL2RNiEbK5plhmTZfyVJ0UW2hPddmseEPsF3/4ZS0fnkNskMjaqKdtHKvLCrVM4i
	 k8d+Vrc4jOt0cUk4dzSQZZc9TDzCGF3e85J8rn0ONdrwZfvWQ/nqp1YnqBHPBEmw0g
	 jQPwCVTwRQmAbn0soiQUFIVCs+iaFYYLTHN9kRMWKBGbyJ6z9CH2oQiGkUp09WGEUi
	 w5p/D6kJi7QSQ==
Date: Sat, 25 May 2024 17:35:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: andy@kernel.org, Jonathan.Cameron@huawei.com, alisa.roman@analog.com,
 bigunclemax@gmail.com, broonie@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, fr0st61te@gmail.com,
 krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de, lgirdwood@gmail.com,
 liambeguin@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
 marcus.folkesson@gmail.com, michael.hennerich@analog.com,
 nuno.sa@analog.com, okan.sahin@analog.com, robh@kernel.org,
 schnelle@linux.ibm.com
Subject: Re: [PATCH] fix
Message-ID: <20240525173515.02b38d7a@jic23-huawei>
In-Reply-To: <20240522095023.35189-1-alisa.roman@analog.com>
References: <ZktB5Ex5oQ2E45QR@smile.fi.intel.com>
	<20240522095023.35189-1-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 12:50:23 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> ---
> 
> Would this fix be alright, since writing something like if(!ret) may be
> confusing?
> 
Looks fine to me. Squashed into original commit that I messed up.

Thanks for sorting this out.

Jonathan

> And regarding the comment, my bad, there is nothing wrong there.
> 
>  drivers/iio/adc/ad7192.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 101afce49378..0789121236d6 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1101,14 +1101,12 @@ static int ad7194_parse_channels(struct iio_dev *indio_dev)
>  		ret = fwnode_property_read_u32_array(child, "diff-channels",
>  						     ain, ARRAY_SIZE(ain));
>  		if (ret == 0) {
> -			ret = ad7194_validate_ain_channel(dev, ain[0]);
> -			if (ret)
> +			if (!ad7194_validate_ain_channel(dev, ain[0]))
>  				return dev_err_probe(dev, -EINVAL,
>  						     "Invalid AIN channel: %u\n",
>  						     ain[0]);
>  
> -			ret = ad7194_validate_ain_channel(dev, ain[1]);
> -			if (ret)
> +			if (!ad7194_validate_ain_channel(dev, ain[1]))
>  				return dev_err_probe(dev, -EINVAL,
>  						     "Invalid AIN channel: %u\n",
>  						     ain[1]);
> @@ -1125,8 +1123,7 @@ static int ad7194_parse_channels(struct iio_dev *indio_dev)
>  				return dev_err_probe(dev, ret,
>  						     "Missing channel property\n");
>  
> -			ret = ad7194_validate_ain_channel(dev, ain[0]);
> -			if (ret)
> +			if (!ad7194_validate_ain_channel(dev, ain[0]))
>  				return dev_err_probe(dev, -EINVAL,
>  						     "Invalid AIN channel: %u\n",
>  						     ain[0]);


