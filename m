Return-Path: <linux-iio+bounces-5100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16F8C949E
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F4C1C2095E
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169CE4644E;
	Sun, 19 May 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeoasi9G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6FC125;
	Sun, 19 May 2024 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716121792; cv=none; b=DPaEAs1pyJ11Uesf2wfyD0gpy155/wYt2N+e6FRmSsuD89RL/BypIPRlZhNzq4ZowziwG/LtWt/BJkqSGpiPR8QFNSpEpQoO8UWt5MXnGhGaDfPV7DTL8RzSg6ePkJyLbigB3ULazUmRU8ESE6krmsZp0oQo5RB7wUXcCxuT8nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716121792; c=relaxed/simple;
	bh=XplS7g9XBR4slyRkjVfB4D5m11QQr+XO7LDsHyPJccQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtC2LsTxVlebkCCc0Ksu7+1I7JTr4L2D/C9Jkc/024DoKBCk6rGIVCHfG8MaZwHy1u9PNbGqHUcAcPAwLiC+ODnhvyIZUfThzQSQz08tM1zRe1CKzx3MmUaP7iEZJ93TbZR8oGjqaoDgX5SSgaovyxCxjpbLG1TFt+3s9A2ru3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeoasi9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3623C32781;
	Sun, 19 May 2024 12:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716121792;
	bh=XplS7g9XBR4slyRkjVfB4D5m11QQr+XO7LDsHyPJccQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oeoasi9G+h95P3n13yKFonnMBvrkfRLJEojWd0I0aW2gvkSYRZ/xtnjXRlv6I52TH
	 lm25BO5PQp54fVUCziVfPDWWl78GhKanXihHIa8RHN58IuXybEew2raO8s31xSKyx2
	 gPJDCQyAQfarAVmmh+P/L4whCT1n+KS+gw6knzssyJNKjUFge+dxmc0uIxM3mDvtnN
	 viIfjDJFbJYK/tTTup7DiPwdiHqtHy7/dnJ5Oud2B8weMZeogFmNLILqrDRewys4Oo
	 sdve9HInAb6UNvsaimfh5R1aEAWZP8yQAlvH0FIaKRhF7oT5KByJkS+/gC65r1YAoZ
	 B9P2zDlRZm1Qw==
Date: Sun, 19 May 2024 13:29:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Crt Mori <cmo@melexis.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
Subject: Re: [PATCH  v2] iio: temperature: mlx90635: Fix ERR_PTR dereference
 in mlx90635_probe()
Message-ID: <20240519132940.3714e57b@jic23-huawei>
In-Reply-To: <20240513203427.3208696-1-harshit.m.mogalapalli@oracle.com>
References: <20240513203427.3208696-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 13:34:27 -0700
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,
> instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
> like a copy paste error.
> 
> Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Please make sure to pick up tags given on earlier versions.  You dropped
Crt's Reviewed-by without giving a reasons. I've put it back.

Applied to the fixes-togreg branch of iio.git and marked for stable.
I'll be rebasing that on rc1 once available. Until then it won't be visible.

Thanks,

Jonathan

> ---
> This is found using smatch, only compile tested.
> v1->v2: Address Crt's comments.
> ---
>  drivers/iio/temperature/mlx90635.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index 1f5c962c1818..f7f88498ba0e 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -947,9 +947,9 @@ static int mlx90635_probe(struct i2c_client *client)
>  				     "failed to allocate regmap\n");
>  
>  	regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
> -	if (IS_ERR(regmap))
> -		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> -				     "failed to allocate regmap\n");
> +	if (IS_ERR(regmap_ee))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
> +				     "failed to allocate EEPROM regmap\n");
>  
>  	mlx90635 = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);


