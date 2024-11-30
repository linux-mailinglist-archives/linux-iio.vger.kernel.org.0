Return-Path: <linux-iio+bounces-12874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981619DF263
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D97E28141A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7021A706F;
	Sat, 30 Nov 2024 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlrZt+Sc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626943AA1;
	Sat, 30 Nov 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989109; cv=none; b=RahAKdHaJ9nkZMTaN5Z1YnBKjv7inUD4PZFxnmQA8iEu9RCBlOfDwut13bv8oQSdDvrQQHfsWAabU+pK78UEGKRtBvu3pjyNhgYlDLo93UnbkJi8XWQ1XDalFIsIEFzdaCvUh92EVxopjTffEsl/zx0W+QyZlLtgk2CCX1OaTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989109; c=relaxed/simple;
	bh=629BkUmlK3pxMrDH/XihQ9fTKurt97vAapob71sv82k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNY8EPsS48rOAztUd6TgYdo6GB3LO6KHZooKXqpoYCUgBGjwT937YtvAeJ8bIePwkLNC9LPXfZ2PdFn4+j3LnMJd1++l9Cg3MJQx/etCpDyjMIazCzbr43fdQJpUEg/6YP8aGCqE9Ldyt8BdLfG3RZ9JPIEelIejXQGft5VVfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlrZt+Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1051CC4CECC;
	Sat, 30 Nov 2024 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732989109;
	bh=629BkUmlK3pxMrDH/XihQ9fTKurt97vAapob71sv82k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dlrZt+Scz7ohFHP9uEuBcZrErJBJpd/5CQy5VaSTL3SO9PZks7i17MOUa5hXI8g4/
	 kk3ckgWfr1hMDYJoVSDDKNV7gUCi/lJHJJqVfxa2Wn7s9S27A0lQrxwd1ORt+fGxaf
	 daM3R90MG/nR13+4N28zj8aveJ3edIXp+0kZGsIojcgyBNw9IX4Y4pIkjWAadegf48
	 rmvGpy/rFFd5NH5DPySHlnpD/15Zy68R5bYjyC5f9DqjX4RTiT9YnPYFdiWSkqJgXP
	 tY9kUdrt8mDcx1yD7CNur8a19WcVrNfmmsSPhtfkUw+0XzmSJYQwGiAnZO7S5snh8p
	 4P0y7CSLYRnew==
Date: Sat, 30 Nov 2024 17:51:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: gts: Simplify using __free
Message-ID: <20241130175141.14d3589a@jic23-huawei>
In-Reply-To: <1f8e1388b69df8a5a1a87748e9c748d2a3aa0533.1732811829.git.mazziesaccount@gmail.com>
References: <cover.1732811829.git.mazziesaccount@gmail.com>
	<1f8e1388b69df8a5a1a87748e9c748d2a3aa0533.1732811829.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 18:50:24 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The error path in the gain_to_scaletables() uses goto for unwinding an
> allocation on failure. This can be slightly simplified by using the
> automated free when exiting the scope.
> 
> Use __free(kfree) and drop the goto based error handling.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> This is derived from the:
> https://lore.kernel.org/lkml/5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com/

Hi Matti

A few comments on specific parts of this below

Thanks,

Jonathan

> +static int build_combined_table(struct iio_gts *gts, int **gains, size_t gain_bytes)
> +{
> +	int ret, i, j, new_idx, time_idx;
> +	int *all_gains __free(kfree) = kcalloc(gts->num_itime, gain_bytes,
> +					       GFP_KERNEL);
> +
>  	if (!all_gains)
>  		return -ENOMEM;
>  
> @@ -232,10 +238,9 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  
>  	gts->avail_all_scales_table = kcalloc(new_idx, 2 * sizeof(int),
>  					      GFP_KERNEL);

I'm not particularly keen in a partial application of __free magic.

Perhaps you can use a local variable for this and a no_free_ptr() to assign it after we know
there can't be an error that requires it to be freed.

> -	if (!gts->avail_all_scales_table) {
> -		ret = -ENOMEM;
> -		goto free_out;
> -	}
> +	if (!gts->avail_all_scales_table)
> +		return -ENOMEM;
> +
>  	gts->num_avail_all_scales = new_idx;
>  
>  	for (i = 0; i < gts->num_avail_all_scales; i++) {
> @@ -246,14 +251,25 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  		if (ret) {
>  			kfree(gts->avail_all_scales_table);
>  			gts->num_avail_all_scales = 0;
> -			goto free_out;
> +			return ret;
>  		}
>  	}
>  
> -free_out:
> -	kfree(all_gains);
> +	return 0;
> +}
>  
> -	return ret;
> +static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
> +{
> +	int ret;
> +	size_t gain_bytes;
> +
> +	ret = fill_and_sort_scaletables(gts, gains, scales);
> +	if (ret)
> +		return ret;
> +
> +	gain_bytes = array_size(gts->num_hwgain, sizeof(int));

array_size is documented as being for 2D arrays, not an array of a multi byte
type.  We should not use it for this purpose.

I'd be tempted to not worry about overflow, but if you do want to be sure then
copy what kcalloc does and use a check_mul_overflow()

https://elixir.bootlin.com/linux/v6.12.1/source/include/linux/slab.h#L919

You don't have to tidy that up in this patch though.

> +
> +	return build_combined_table(gts, gains, gain_bytes);
>  }

>  
> +/**
> + * iio_gts_build_avail_time_table - build table of available integration times
> + * @gts:	Gain time scale descriptor
> + *
> + * Build the table which can represent the available times to be returned
> + * to users using the read_avail-callback.
> + *
> + * NOTE: Space allocated for the tables must be freed using
> + * iio_gts_purge_avail_time_table() when the tables are no longer needed.
> + *
> + * Return: 0 on success.
> + */
> +static int iio_gts_build_avail_time_table(struct iio_gts *gts)
Hmm. I guess this wrapper exists because perhaps you aren't comfortable
yet with the __free() handling mid function.  It does not harm so I'm fine
having this.

> +{
> +	if (!gts->num_itime)
> +		return 0;
> +
> +	return __iio_gts_build_avail_time_table(gts);
> +}
> +
>  /**
>   * iio_gts_purge_avail_time_table - free-up the available integration time table
>   * @gts:	Gain time scale descriptor


