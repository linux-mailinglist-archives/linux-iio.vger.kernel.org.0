Return-Path: <linux-iio+bounces-3276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669886F585
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 15:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2266428205E
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038455A10C;
	Sun,  3 Mar 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqJJT0hB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A45A0ED
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709475883; cv=none; b=RPMIrjiML9Mk2VMuHw9Z0zh+QMF4Y8ArRQOyRBOMO6z963R7nuuU1WcadCy1uvdfTn1PFncbGaItRCoNH97TDWZOC3/CY1WUmyoD5bA3xbQobKG3aRYnVlxkFaACtXbwrPxYRg2i4mfEE7n10rCYwrZ31MPGCLV9L86I/usqbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709475883; c=relaxed/simple;
	bh=5xSMoqKkjjGAGqHCfK5/Svh+OMW2g11oAf6NxJUiAWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5rrdkijNpvJKhMdJDpFkx3Pqm2yOwo8njJPeb+AcmrJd9V6GDVbq1vHW7jO7zr7NsQ6nBEi+Dc9mBvYZTtG5aTRBoONiM/aO3EBg2ZGLJU5Xdq90Tb4xyh3BRZXVH7g66xnTm8+XGpLFKTpslZCTzYSkLgntAY3YCgKfnTi0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqJJT0hB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606C4C433C7;
	Sun,  3 Mar 2024 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709475883;
	bh=5xSMoqKkjjGAGqHCfK5/Svh+OMW2g11oAf6NxJUiAWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IqJJT0hB6j6CqxWAHqZ7nf93NqrqyYhfV50lxeRilZ7V5JtsBpl3u1qiWI/g2UbZU
	 GMAWNoJUSaBgXSKbOQoIt98nIGTbdh8uesqxQI3hNJRM/YkcZWl2vxXhxoVhIk8sBY
	 0LEjejxe29yOGf7P4tmAvFxblSD2m1Kj1yAj91cMs8sGD++NS8/fTcrV0H3pxT51C2
	 sN2ebEes4jnjQ1x5aOAwy+cfXIHXwBrEYGvq+bOdRDk64C5hh4T7FzabovjUVlnOlZ
	 Dr9TJPTQ2tC0CgRMRrRajOQJzh9STUY6QykcDaDR7U4a1tFzLlaPJQ/f0xpAflCcbb
	 6MRCQ+rhjQgUQ==
Date: Sun, 3 Mar 2024 14:24:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 4/4] iio: inkern: move to the cleanup.h magic
Message-ID: <20240303142431.506c05a2@jic23-huawei>
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	<20240229-iio-use-cleanup-magic-v3-4-c3d34889ae3c@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 16:10:28 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> While at it, also use __free(kfree) where allocations are done and drop
> obvious comment in iio_channel_read_min().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Hi Nuno

Series looks very nice. One trivial thing inline - I can tidy that up whilst
applying if nothing else comes up.

Given this obviously touches a lot of core code, so even though simple it's
high risk for queuing up late. I also have a complex mess already queued up
for the coming merge window. Hence I'm going to hold off on applying this
series until the start of the next cycle.

Nothing outside IIO is going to depend on it, so it's rather simpler decision
to hold it than for the ones that add new general purpose infrastructure.

Jonathan




>  EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
>  
> @@ -757,29 +711,24 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
>  	int ret;
>  
> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> -	if (!chan->indio_dev->info) {
> -		ret = -ENODEV;
> -		goto err_unlock;
> -	}
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
> +	if (!chan->indio_dev->info)
> +		return -ENODEV;
>  
>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>  		ret = iio_channel_read(chan, val, NULL,
>  				       IIO_CHAN_INFO_PROCESSED);
>  		if (ret < 0)
> -			goto err_unlock;
> +			return ret;
>  		*val *= scale;

		return 0;

>  	} else {
could drop the else.

>  		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  		if (ret < 0)
> -			goto err_unlock;
> +			return ret;
>  		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val,
>  							    scale);
		return iio_convert_raw_to_proc...

>  	}
>  
> -err_unlock:
> -	mutex_unlock(&iio_dev_opaque->info_exist_lock);
> -
>  	return ret;
Drop this.
>  }


