Return-Path: <linux-iio+bounces-13201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE599E816C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65B81883351
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBF14D2A2;
	Sat,  7 Dec 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvQ6tv+H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAC22C6CD;
	Sat,  7 Dec 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733594319; cv=none; b=IdSvdVXNd/Cv8WCgMILOUuSoQYz/MdU+x1ftYvZ6BHWDmuemtpbkxHzmtzrFViWnHZJgNyqTDpGRXMuO3sGy4+Jw4ge16KasfJXR9uu7huXA4Tbu77ckEmeJaByArCwA2pCdAKRTYrPqS4fzrdYzFToC4ANqxs8gfMLS8+S4v5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733594319; c=relaxed/simple;
	bh=KQVFdWR43wLYPyw8mjjNMylsAYGgvtlenOstfU+m/5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLC3k8sIpSLTbp+KtX/yxqOvb9WdnRUuNCaVrdqCxB+Z4gKZX59XjXNoIQAwELG1wriazdYYQzt/RF0GCN2eOafgPGV6tSnU44bhrQ9pYvpjWY5ZrjGpl40Z7lVvwyOaD1W4KEDSPXAh/jzwXC76iQQisxBlaj3FMD9CYKWYJR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvQ6tv+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FBBC4CECD;
	Sat,  7 Dec 2024 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733594319;
	bh=KQVFdWR43wLYPyw8mjjNMylsAYGgvtlenOstfU+m/5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XvQ6tv+HKL3aVtFUjnU982KQzZFNdRmIhPkCSVAWnt4VypqEtzSnTELt587mCFCDy
	 Xg6HuU7Tdwc5sgnu9JJQB/s6GX1VrWpCGvv0XD+xbE4ubVHDNpJ3SDBdJ8qySM8Kuj
	 OsoQGqIbBaHmp1h4N1pLeTP/BqrqPOR/lD0BA0Z10+5KiUhS4lRozHEQGtxTTDYT+F
	 exL5EK4Nort7l24n++IqrsyXYYvvPT01PL3j2akQ6H4V2WlF/tMHEoOQl30Cd/K3MT
	 F7MXDQ9D0UuHp/ZpjLg5ubim+Ebcm24XKoCZvCaLuDdsAo9A+IPDidM3Vod/r3mNz9
	 7mZEJHbDYMN7A==
Date: Sat, 7 Dec 2024 17:58:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad9467: Fix the "don't allow reading vref
 if not available" case
Message-ID: <20241207175829.31a32667@jic23-huawei>
In-Reply-To: <cc65da19e0578823d29e11996f86042e84d5715c.1733503146.git.christophe.jaillet@wanadoo.fr>
References: <cc65da19e0578823d29e11996f86042e84d5715c.1733503146.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 17:39:28 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> The commit in Fixes adds a special case when only one possible scale is
> available.
> If several scales are available, it sets the .read_avail field of the
> struct iio_info to ad9467_read_avail().
> 
> However, this field already holds this function pointer, so the code is a
> no-op.
> 
> Use another struct iio_info instead to actually reflect the intent
> described in the commit message. This way, the structure to use is selected
> at runtime and they can be kept as const.
> 
> This is safer because modifying static structs that are shared between all
> instances like this, based on the properties of a single instance, is
> asking for trouble down the road.
> 
> Fixes: b92f94f74826 ("iio: adc: ad9467: don't allow reading vref if not available")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is compile tested only and is completely speculative.
> 
> Changes in v2:
>   - use another struct iio_info to keep the structure const
Agree entirely with David that this is the way to go.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> v1: https://lore.kernel.org/linux-kernel/556f87c8931d7d7cdf56ebc79f974f8bef045b0d.1733431628.git.christophe.jaillet@wanadoo.fr/
> ---
>  drivers/iio/adc/ad9467.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index d358958ab310..f30119b42ba0 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -895,7 +895,7 @@ static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static struct iio_info ad9467_info = {
> +static const struct iio_info ad9467_info = {
>  	.read_raw = ad9467_read_raw,
>  	.write_raw = ad9467_write_raw,
>  	.update_scan_mode = ad9467_update_scan_mode,
> @@ -903,6 +903,14 @@ static struct iio_info ad9467_info = {
>  	.read_avail = ad9467_read_avail,
>  };
>  
> +/* Same as above, but without .read_avail */
> +static const struct iio_info ad9467_info_no_read_avail = {
> +	.read_raw = ad9467_read_raw,
> +	.write_raw = ad9467_write_raw,
> +	.update_scan_mode = ad9467_update_scan_mode,
> +	.debugfs_reg_access = ad9467_reg_access,
> +};
> +
>  static int ad9467_scale_fill(struct ad9467_state *st)
>  {
>  	const struct ad9467_chip_info *info = st->info;
> @@ -1214,11 +1222,12 @@ static int ad9467_probe(struct spi_device *spi)
>  	}
>  
>  	if (st->info->num_scales > 1)
> -		ad9467_info.read_avail = ad9467_read_avail;
> +		indio_dev->info = &ad9467_info;
> +	else
> +		indio_dev->info = &ad9467_info_no_read_avail;
>  	indio_dev->name = st->info->name;
>  	indio_dev->channels = st->info->channels;
>  	indio_dev->num_channels = st->info->num_channels;
> -	indio_dev->info = &ad9467_info;
>  
>  	ret = ad9467_iio_backend_get(st);
>  	if (ret)


