Return-Path: <linux-iio+bounces-18695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A912A9DB76
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF8925604
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652E3208;
	Sat, 26 Apr 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzGjUlA+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE78F5A
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745677608; cv=none; b=LHghJGBMOcy/pTXoo7BnITtPva2pxs0MOSDE/+X2SyeQgJpkMZgW4XYms7MW4Bgoahx0Mnqre6k9BoCSMgepQKvx4laBGDsvTG8/IuFD+ejnulnyGa4UJGjvm6+updSZIgz35dHrDZsw2Xt+PdPuBloKmIqo8yskYu4y1E2ChBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745677608; c=relaxed/simple;
	bh=22Yps8pyxe1HNyvWy4l7tXN/hWy3sJh6lUXBWxppxhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JicHp7nz8KLwzLcaiddFLpKk+JmU0q7ToBSxkPq2+WOPn9zAr+PUAVAwweyBd6HBclARI+YoMA8KT/byAFyq6FTi1ul30KTZNLF77tfYlR4vDSXNdlX4PCPtd0lzZKU9qVso3AO+sbASZBkyDIXmwayqUEN+G3CN6/5CE/4LWNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzGjUlA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB4FC4CEE2;
	Sat, 26 Apr 2025 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745677607;
	bh=22Yps8pyxe1HNyvWy4l7tXN/hWy3sJh6lUXBWxppxhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YzGjUlA+BochiFfgGCrKt7uIb4LuPdaW/e1tCwbLSVxHQmOu8en4xNDQJxjLifHkQ
	 4+Jnd4l0Rj37jr/jDrUoIbAVfgt/4zWd3nR0jVZ7IhgWlaOrbYVsdQsPduNHLuehJj
	 ilwIFm4mbGmt2H/O0DCAH7kmPTTLyVVCQs1Xa4oztbU09yWC14U9J7YJdIRXO47VgJ
	 kkHCGCYdB1IPh+1NX5WmjAtM+OExB0cJ4+Z7x48SshVJ9GpNL6eTiWDmMeq4yfVwQ8
	 mm/iwWbuNS98lCXxejfbQgF6F8N8PSfos2QT75wKowRTqzAzPVlqTRR5TPJyhS+lm7
	 5o2RuY9MhRwCg==
Date: Sat, 26 Apr 2025 15:26:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Beatriz Viana Costa <beatrizvianacosta16@gmail.com>
Cc: beatrizvianacosta@usp.br, linux-iio@vger.kernel.org,
 gabevictor333@gmail.com, gabevictor@usp.br
Subject: Re: [PATCH] iio: light: zopt2201: Remove code duplication in scale
 write functions
Message-ID: <20250426152641.639d9805@jic23-huawei>
In-Reply-To: <20250424002144.23260-1-beatrizvianacosta16@gmail.com>
References: <20250424002144.23260-1-beatrizvianacosta16@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 21:21:44 -0300
Beatriz Viana Costa <beatrizvianacosta16@gmail.com> wrote:

> Consolidate duplicated logic from zopt2201_write_scale_als_by_idx() and
> zopt2201_write_scale_uvb_by_idx() into a new generic helper function
> zopt2201_write_scale_by_idx(). This function takes an additional
> parameter: a pointer to a zopt2201_scale array.
> 
> To support this, the previously anonymous and duplicated struct used in
> the scale arrays was promoted to a named struct: zopt2201_scale.
> 
> This change also corrects an incorrect array access that existed in
> zopt2201_write_scale_uvb_by_idx().
> 
> Signed-off-by: Beatriz Viana Costa <beatrizvianacosta16@gmail.com>
> Co-developed-by: Gabriela Victor <gabevictor333@gmail.com>
> Signed-off-by: Gabriela Victor <gabevictor333@gmail.com>
Looks good to me.

If you want a follow up, this driver could benefit from use of guard()

Applied to the togreg branch of iio.git, and initially pushed out as testing
for 0-day to take a look at it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/zopt2201.c | 42 +++++++++++-------------------------
>  1 file changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
> index 604be60e9..1e5e9bf29 100644
> --- a/drivers/iio/light/zopt2201.c
> +++ b/drivers/iio/light/zopt2201.c
> @@ -113,11 +113,13 @@ static const struct {
>  	{ 13,   3125 },
>  };
>  
> -static const struct {
> +struct zopt2201_scale {
>  	unsigned int scale, uscale; /* scale factor as integer + micro */
>  	u8 gain; /* gain register value */
>  	u8 res; /* resolution register value */
> -} zopt2201_scale_als[] = {
> +};
> +
> +static struct zopt2201_scale zopt2201_scale_als[] = {
>  	{ 19, 200000, 0, 5 },
>  	{  6, 400000, 1, 5 },
>  	{  3, 200000, 2, 5 },
> @@ -142,11 +144,7 @@ static const struct {
>  	{  0,   8333, 4, 0 },
>  };
>  
> -static const struct {
> -	unsigned int scale, uscale; /* scale factor as integer + micro */
> -	u8 gain; /* gain register value */
> -	u8 res; /* resolution register value */
> -} zopt2201_scale_uvb[] = {
> +static struct zopt2201_scale zopt2201_scale_uvb[] = {
>  	{ 0, 460800, 0, 5 },
>  	{ 0, 153600, 1, 5 },
>  	{ 0,  76800, 2, 5 },
> @@ -348,16 +346,17 @@ static int zopt2201_set_gain(struct zopt2201_data *data, u8 gain)
>  	return 0;
>  }
>  
> -static int zopt2201_write_scale_als_by_idx(struct zopt2201_data *data, int idx)
> +static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
> +				     struct zopt2201_scale *zopt2201_scale_array)
>  {
>  	int ret;
>  
>  	mutex_lock(&data->lock);

Here is an example where cleanup.h / guard would simplify the code by allowing a
direct return.

> -	ret = zopt2201_set_resolution(data, zopt2201_scale_als[idx].res);
> +	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
>  	if (ret < 0)
>  		goto unlock;
>  
> -	ret = zopt2201_set_gain(data, zopt2201_scale_als[idx].gain);
> +	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
>  
>  unlock:
>  	mutex_unlock(&data->lock);
> @@ -371,29 +370,12 @@ static int zopt2201_write_scale_als(struct zopt2201_data *data,
>  
>  	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_als); i++)
>  		if (val == zopt2201_scale_als[i].scale &&
> -		    val2 == zopt2201_scale_als[i].uscale) {
> -			return zopt2201_write_scale_als_by_idx(data, i);
> -		}
> +		    val2 == zopt2201_scale_als[i].uscale)
> +			return zopt2201_write_scale_by_idx(data, i, zopt2201_scale_als);
>  
>  	return -EINVAL;
>  }
>  
> -static int zopt2201_write_scale_uvb_by_idx(struct zopt2201_data *data, int idx)
> -{
> -	int ret;
> -
> -	mutex_lock(&data->lock);
> -	ret = zopt2201_set_resolution(data, zopt2201_scale_als[idx].res);
> -	if (ret < 0)
> -		goto unlock;
> -
> -	ret = zopt2201_set_gain(data, zopt2201_scale_als[idx].gain);
> -
> -unlock:
> -	mutex_unlock(&data->lock);
> -	return ret;
> -}
> -
>  static int zopt2201_write_scale_uvb(struct zopt2201_data *data,
>  				     int val, int val2)
>  {
> @@ -402,7 +384,7 @@ static int zopt2201_write_scale_uvb(struct zopt2201_data *data,
>  	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_uvb); i++)
>  		if (val == zopt2201_scale_uvb[i].scale &&
>  		    val2 == zopt2201_scale_uvb[i].uscale)
> -			return zopt2201_write_scale_uvb_by_idx(data, i);
> +			return zopt2201_write_scale_by_idx(data, i, zopt2201_scale_uvb);
>  
>  	return -EINVAL;
>  }


