Return-Path: <linux-iio+bounces-15602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FEA3764F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0A7168FFA
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236619D881;
	Sun, 16 Feb 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4nUsyBp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6119A298;
	Sun, 16 Feb 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739727493; cv=none; b=T/UCCjj5e5/hVvQfr3ZMaKqQ4a0+KXbxbZnAcPvi5cBN2SdQDp6ky9SihQYhst8CE9ORAzN3Bf1oP8x9fQnAmKpGneShk+wEGj9I436ilC/LOEUEU2XVESFWEFYcxpyXn+M17qHneGGVIGVP9UtQcy1KO0J5OY9oiNSCXZupD8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739727493; c=relaxed/simple;
	bh=DbUMcXFKtHfM50Yjw/Uc2hXibnawpUKWpR41+KNiiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPtPmnkm4+R8wmyAAToma02bYZilmQpSod7SxKq8u4cw0PD3iSaVQPRzflqsm6Q0ManOmo3dAPYAfRr0Ak2aJNl6LLthLFigKaJyUYPzlQSRUOrhizGBd5+krgjTLoCBYm3UKC+QQ8cw+WRFTnGXj0zc04eRQYp1Ak2eLfQGCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4nUsyBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57503C4CEDD;
	Sun, 16 Feb 2025 17:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739727493;
	bh=DbUMcXFKtHfM50Yjw/Uc2hXibnawpUKWpR41+KNiiKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i4nUsyBpUXhtE/9YqJJ++JiujSDLehXLPYDL/zH0yaQkej2FIHCZyI4MK88AGB33j
	 TqXMRnUFW/wY0sIAylMT8yIuTFdTsKanQ9Z2Kg4ZywoQrmnjt4bmt7Qrv6deYn5yjK
	 Xc6Sk2+nOTq1z2eI+iVekSq5So8P24dszPmOIStjyNJ/wsq0Egz1hUqqeEeZQqFMDa
	 cYBiQYgWHIV30/RD3lTpfJhEsJ9dwr+hEtTz5GVUYncUPy8o9S6v5K/lJm3xlnEkI7
	 8GJ22Pye/a09CzgLXO72YWWzJcMYKcGEmCUJVzGPUtzSa9SsGuTedh6pRr9670VxRN
	 OSB632/jMvUMg==
Date: Sun, 16 Feb 2025 17:38:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 09/14] iio: accel: adxl345: extend sample frequency
 adjustments
Message-ID: <20250216173805.3b629a61@jic23-huawei>
In-Reply-To: <20250210110119.260858-10-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:14 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce enums and functions to work with the sample frequency
> adjustments. Let the sample frequency adjust via IIO and configure
> a reasonable default.
> 
> Replace the old static sample frequency handling. The patch is in
> preparation for activity/inactivity handling.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

I noticed now that we don't actually have regmap caching enabled.
I think it will make things sufficiently simpler that it is worth
doing even though you have to specify which registers are volatile etc.


> +
> +static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> +				 ADXL345_BW_RATE_MSK,
> +				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
> +	if (ret)
> +		return ret;
> +
> +	st->odr = odr;
Why do we need to keep a copy cached? Seems like we can get it from
regmap cache easily enough?

> +
> +	return 0;
> +}

> @@ -488,7 +572,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct adxl345_state *st = iio_priv(indio_dev);
> -	s64 n;
> +	enum adxl345_odr odr;
> +	int ret;
> +
> +	ret = adxl345_set_measure_en(st, false);

Please add some more on why this is now necessary to the patch description.

> +	if (ret)
> +		return ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -496,20 +585,24 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
>  		 * factor
>  		 */
> -		return regmap_write(st->regmap,
> -				    ADXL345_REG_OFS_AXIS(chan->address),
> -				    val / 4);
> +		ret = regmap_write(st->regmap,
> +				   ADXL345_REG_OFS_AXIS(chan->address),
> +				   val / 4);
> +		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		n = div_s64(val * NANOHZ_PER_HZ + val2,
> -			    ADXL345_BASE_RATE_NANO_HZ);
> -
> -		return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> -					  ADXL345_BW_RATE,
> -					  clamp_val(ilog2(n), 0,
> -						    ADXL345_BW_RATE));
> +		ret = adxl345_find_odr(st, val, val2, &odr);
> +		if (ret)
> +			return ret;
> +		ret = adxl345_set_odr(st, odr);
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> -	return -EINVAL;
> +	if (ret)
> +		return ret;
> +
> +	return adxl345_set_measure_en(st, true);
>  }



