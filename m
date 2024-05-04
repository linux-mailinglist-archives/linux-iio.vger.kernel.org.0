Return-Path: <linux-iio+bounces-4792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E468BBACE
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B201F214E5
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636D21CD15;
	Sat,  4 May 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JM2JSS4g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC61C69E;
	Sat,  4 May 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714822716; cv=none; b=KtVB655sJxwBInme1k6EBN7NAn2eQF2BTv8b0RlzS9xOP4l/1rqWAn2I3Z0JyJ4X198gLg9mkYDr9CsjT9U5f1d65XpOlmEQq17DxqBAS8bvyVL3eQkNCA3UwFmoQTTkxyS4PSO6/WDh/E4KenO8hASmhSCuZ/ss5Hr++LuwlGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714822716; c=relaxed/simple;
	bh=gvDIBLSUbzVrRNJpbCt/aVyrFjWfo6ElSSBarhcm6v4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyZH9xa4OjwQKTXZGCpTOrwnPdvIwgTMxqJklfU2R8BE2QeLjsAVwYxKjUkLmyFg9C1pFEejyS+lEcRf1hkBlJmumtZUNr0hVQk+upJ7FKo1QC310/YELTaAVSeBj0EqdeXQXnc5wmoROXlG8URYTP4jwK/0ivjvxcp/5mK9aw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JM2JSS4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9055CC2BBFC;
	Sat,  4 May 2024 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714822715;
	bh=gvDIBLSUbzVrRNJpbCt/aVyrFjWfo6ElSSBarhcm6v4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JM2JSS4gN9GwcKnlltlTCF3Fe0zhp2iwY2U7kMntuh3tIpjhfex4Xyh5Y1/Uh0Bn/
	 Un8EZsqpjsZ+CDNLrf/NdDHtt/gf6/UFI+vA+4iLW+6ZjIuiE7nxK0wqZsHUw23NMn
	 HxtRxbXT4qKak++yuyJ2x1HBt3b63S9yePN1KopIDAHHwvw99VFXq6QuBZTNhstP30
	 jqW/Hwb0JKfMYS5l4Q6YJeH9lQz0wKG4k4VuwK00kVbjxeF+Cojn/9kzLw43YlFD8s
	 J+l7ucAsWo5ujGGUr/irGqlje6eGcJNUZIslj2rjZinub8xk5JpnFt4GuAgBnTg8rW
	 6WeINCs8+Ko7A==
Date: Sat, 4 May 2024 12:38:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Harrisonn <jorge.harrisonn@usp.br>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, laisnuto@usp.br
Subject: Re: [PATCH 2/2] iio: adc: ad7923: using claim_direct_scoped for
 code simplification
Message-ID: <20240504123824.3cbf28c5@jic23-huawei>
In-Reply-To: <20240501215724.26655-3-jorge.harrisonn@usp.br>
References: <20240501215724.26655-1-jorge.harrisonn@usp.br>
	<20240501215724.26655-3-jorge.harrisonn@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 May 2024 18:57:24 -0300
Jorge Harrisonn <jorge.harrisonn@usp.br> wrote:

> Using iio_device_claim_direct_scoped instead of calling `iio_device
> _claim_direct_modeand later callingiio_device_release_direct_mode`
> 
> This should make code cleaner and error handling easier
> 
> Co-authored-by: Lais Nuto <laisnuto@usp.br>
> Signed-off-by: Lais Nuto <laisnuto@usp.br>
> Signed-off-by: Jorge Harrisonn <jorge.harrisonn@usp.br>
Hi Jorge, Lais,

Comments inline.

> ---
>  drivers/iio/adc/ad7923.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 9d6bf6d0927a..a646521b2ef3 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -260,22 +260,20 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> -		ret = ad7923_scan_direct(st, chan->address);
> -		iio_device_release_direct_mode(indio_dev);
> -
> -		if (ret < 0)
> -			return ret;
> -
> -		if (chan->address == EXTRACT(ret, 12, 4))
> -			*val = EXTRACT(ret, chan->scan_type.shift,
> -				       chan->scan_type.realbits);
> -		else
> -			return -EIO;
> -
> -		return IIO_VAL_INT;
> +		    iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {         	

Lots of stray white space + why this indent for the line above?

> +			ret = ad7923_scan_direct(st, chan->address); 
> +				
No blank line here as the check should be clearly associated with
the line above.
> +			if (ret < 0)
> +				return ret;
> +
> +			if (chan->address == EXTRACT(ret, 12, 4))
> +				*val = EXTRACT(ret, 0, 12);
> +			else
> +				return -EIO;
Flip this logic
			if (chan->address != EXTRACT(ret, 12, 4))
				return -EIO;

			*val = EXTRACT(ret, 0, 12);

However, better to also change the cases where the masks is fixed at
compile time to use the standard FIELD_GET() and provide appropriate
mask defines.

That change would be a separate patch, so up to you whether you want
to do that as an addition for v2.



> +
> +			return IIO_VAL_INT;
> +		}
> +    	unreachable();
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = ad7923_get_range(st);
>  		if (ret < 0)


