Return-Path: <linux-iio+bounces-5303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3BC8CF071
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB19281C39
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483486AE7;
	Sat, 25 May 2024 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz6wyo8M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA249473;
	Sat, 25 May 2024 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716658175; cv=none; b=p67yl9YfSQ2DdZeFIxmr+poi32K0aveaKyZ8/VQWLLTzpbCvts/QIutMhWh+luJqEyjjuCz22mQoZFvLRgosEVWbU+VXUIF72ueKjAQlqzSTywBIZteChVXA0cjUlZAQBOAf9roE3JaTJrgqCu2nnHxItrhO6/nXOe8DNpZ+lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716658175; c=relaxed/simple;
	bh=Ix5ZA2sKjCOi4M8doKjLb5umOxPLM58qMYPoYAVI5xM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHGtK6/0qJG4tMU7Rj7iTwMHOuE+U6+EyaDjE32kd02HZvEMma9RH7Y1lB0qiAocpmGp+6PzJg2Mt0HVhnAwVR5GthN/zNmUgDF1v0bXe9jAwbgRfRLVTX94NxNN+98Ftkss+XgYyjbG6cw41kNcnwesUujupvwPcld/+oJZg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz6wyo8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A27C2BD11;
	Sat, 25 May 2024 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716658174;
	bh=Ix5ZA2sKjCOi4M8doKjLb5umOxPLM58qMYPoYAVI5xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uz6wyo8MDGjZVyrxdn8Nb7+TgGnU42buxToxoNO3Gtn10aOMXCiz1UhIw1nMz3UOT
	 qR4gA9R5ZEXYj1brMA8zE5N/Gg+a0HONxYQUBCCYbWwr0OEpafzlCGekKyY3XP+lUH
	 yaWKPevvHDko3s+Y+IiaYbM8nAn5/Kbo5N/i0WzoEQsbhI1GI7OjqjHmhWoUT8V6Bk
	 8P4MpKF91fVoD0VMLKf2E8UGLfd/poZc4mdRnmeXV5xodU12gWN9TNY5nugx3Hc1ZY
	 gTTn80rrI8KAoqngjY3ae/Xa8asKOPcMHF6MZCoNf95Sx9/7EZUisSKljrLvM0XowC
	 id4CFZFWwOVPQ==
Date: Sat, 25 May 2024 18:29:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: invensense: fix odr switching to same value
Message-ID: <20240525182923.490475e5@jic23-huawei>
In-Reply-To: <20240524124851.567485-1-inv.git-commit@tdk.com>
References: <20240524124851.567485-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 12:48:51 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> ODR switching happens in 2 steps, update to store the new value and then
> apply when the ODR change flag is received in the data. When switching to
> the same ODR value, the ODR change flag is never happening, and frequency
> switching is blocked waiting for the never coming apply.
> 
> Fix the issue by preventing update to happen when switching to same ODR
> value.
> 
> Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Applied to the fixes-togreg branch of iio.git

Note I'll rebase that tree on rc1 once available.

> ---
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index fa205f17bd90..f44458c380d9 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -60,11 +60,15 @@ EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_init, IIO_INV_SENSORS_TIMESTAMP);
>  int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
>  				     uint32_t period, bool fifo)
>  {
> +	uint32_t mult;
> +
>  	/* when FIFO is on, prevent odr change if one is already pending */
>  	if (fifo && ts->new_mult != 0)
>  		return -EAGAIN;
>  
> -	ts->new_mult = period / ts->chip.clock_period;
> +	mult = period / ts->chip.clock_period;
> +	if (mult != ts->mult)
> +		ts->new_mult = mult;
>  
>  	return 0;
>  }


