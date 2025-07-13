Return-Path: <linux-iio+bounces-21611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2EEB0316A
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069603BA341
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2B1232368;
	Sun, 13 Jul 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/atbnSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993D433A8;
	Sun, 13 Jul 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416260; cv=none; b=mhcpBk5tVMJEfea5qaL8Jg/NHfZXq9ywgdQbYGzf9iVAWZVT3A1I8OvsPNAVnzxxm6mb+HvdZcxu1C42+F6Ys1FbAuICYvqsyjj8WopnhAeZlyVcN+H6ax8Tkkw1skOHbkNFU+LGDg1bjAq4c4i7hjo0Rvic2FUOG10vNxjKrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416260; c=relaxed/simple;
	bh=KOGwfPJ1OffQYGQGIidBoHZqq4u/uSN8sQTT8rD8pJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm/JQEK8XCOH8qcwj80N68LQGEGn1VYKCRHIbo4QSz5rJwXkItZpTjFcdj+vhVSLzCBjt2cl8SGKOd6ngKaPRDW3NBfpog1Y9Vvnujx1Ls1Bf5GMhksvbdt89QfvFi6UBvS3FcpxW4Zg66kdSpwUhqSZPVjUVO0VcXYAZOAJmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/atbnSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99728C4CEE3;
	Sun, 13 Jul 2025 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752416256;
	bh=KOGwfPJ1OffQYGQGIidBoHZqq4u/uSN8sQTT8rD8pJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u/atbnSH9300zFPNDBG1TN4GB/431HqNd8Ysq5RgtCEM0a7L4/PN4oJPQjwFURuMh
	 CWPtu10GeEqlRVgNmOnp9Gj0ukC9zt987+aXReOECF1iUOQX79YJaUjAsS2KChAkod
	 GuzogJ+Mjgok6nSxyJtH5kzb5uxeK3o5X0LEiqEcttSbU1sG6/VgUtm+GxDEVjxp1Z
	 I6SA6XszVKXbRaumU34FT+4u+sN4jUgVpDn2WMPCI3lPKBs36uaXcDw8wHc5aeQKy2
	 KdN0/HbT1o0h4xpQjTmTU1zkNpki95IktfYMlT5Bl3oi10dvJPp+y8VOyK837gP9Du
	 VEYcT92XyiA5A==
Date: Sun, 13 Jul 2025 15:17:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: imu: inv_icm42600: Use
 inv_icm42600_disable_vddio_reg()
Message-ID: <20250713151728.0a36e6a0@jic23-huawei>
In-Reply-To: <20250709-icm42pmreg-v1-1-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-1-3d0e793c99b2@geanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 14:35:09 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Replace direct calls to regulator_disable() with the existing
> inv_icm42600_disable_vddio_reg() helper. This improves consistency
> and ensures any future changes to the disable logic are centralized.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

That function only exists to match type for the devm_ callback
at the cost of using type safety.  So I'm not sure loosing type
safety in more of the code is a good direction to go in.

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index a4d42e7e21807f7954def431e9cf03dffaa5bd5e..69496d1c1ff73132f5e7bd076d18a62c293285a2 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -892,7 +892,7 @@ static int inv_icm42600_suspend(struct device *dev)
>  
>  	/* disable vddio regulator if chip is sleeping */
>  	if (!wakeup)
> -		regulator_disable(st->vddio_supply);
> +		inv_icm42600_disable_vddio_reg(st);
>  
>  out_unlock:
>  	mutex_unlock(&st->lock);
> @@ -973,7 +973,7 @@ static int inv_icm42600_runtime_suspend(struct device *dev)
>  	if (ret)
>  		goto error_unlock;
>  
> -	regulator_disable(st->vddio_supply);
> +	inv_icm42600_disable_vddio_reg(st);
>  
>  error_unlock:
>  	mutex_unlock(&st->lock);
> 


