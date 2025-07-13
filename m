Return-Path: <linux-iio+bounces-21614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A8BB0317B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214D91898E10
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70B27979C;
	Sun, 13 Jul 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTWb3whJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF48836;
	Sun, 13 Jul 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416899; cv=none; b=a7oOM48iQyscPw0U3GoXaBoxSK0yBOcjhUzdV4orLxqkq+5W5j085WTzFWofyYS3pLI0sx6ZdykSlXOGrxmuMe8FWB62wv6cTe85AQAdo/0/DSLxkMVQ92fEfV5D3TQtOXbtMiK7o3/rsIPIbgk4Ez13FB+fjIZA/G0hRCD/pHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416899; c=relaxed/simple;
	bh=K8oeAkKEEzFQ6RQcRKqBmBIjwD+qIuqJJMo+2zdOlck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPkHtUvHWFMM4rHUtOiyZJG4grSCW52zPYiW8WV8WmArMA309J0P/z5uta5Wosg6ZWTKleVbgPsOtkdHu+6ZpRzbwNlR4C+q/10cbQ8nA4LsU8XrZ2VhooaBLwlJlfCwSlTSSXBAbDg7oQBxKXgDZGRi/2mOp23N0tIZT3hdJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTWb3whJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95F1C4CEE3;
	Sun, 13 Jul 2025 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752416897;
	bh=K8oeAkKEEzFQ6RQcRKqBmBIjwD+qIuqJJMo+2zdOlck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TTWb3whJOlSEp5gucmF85ApZUppQYQWa9tIEpsnLeYj4xguTvvOPpB0nMu0ZihAGX
	 3BqWCaGujgcWn63x3LfITbY3sZj3jlXMGl/3Q8/z8MiHphIaXGlpEI22QMWBI4IS55
	 jNekoykhopt2ZhHjZouibnsgEZblYN1CNF4r48NQj5NfW58zhxe9N5xLpdUA0AxEDh
	 Oi4k49wUBmoVryrzuXOgOsYJu27KeejLZTKHhDC2aBAokMW/eCNIUZhnLGb0r1422K
	 0D0xkGCe8jz2QORO3v+0g4Hg0V7IjbKZcMuk+M3iNWzRn1UU+w2DtVbiVHPhnltqqP
	 pHgZ9yeoHJE9w==
Date: Sun, 13 Jul 2025 15:28:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <20250713152810.4483c786@jic23-huawei>
In-Reply-To: <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 14:35:12 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> calls during probe. These are not required when the device is marked
> active via pm_runtime_set_active() before enabling pm_runtime with
> pm_runtime_enable().
> 
> Also remove the redundant pm_runtime_put_sync() call from the cleanup
> path, since the core is not incrementing the usage count beforehand.
> 
> This simplifies the PM setup and avoids manipulating the usage counter
> unnecessarily.

Could we switch directly to using devm_pm_runtime_enable() for this driver?

At first glance looks like this code is missing the disable of autosuspend
that should be there (which devm_pm_runtime_enable() will also handle).


> 
> Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 55a29b1e2b11355598b0ede7af22857aed3ae134..1072bea11c73d09a9a0e6ea9d4a5c7a72248dca7 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -708,7 +708,6 @@ static void inv_icm42600_disable_pm(void *_data)
>  {
>  	struct device *dev = _data;
>  
> -	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  }
>  
> @@ -806,11 +805,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  	ret = pm_runtime_set_active(dev);
>  	if (ret)
>  		return ret;
> -	pm_runtime_get_noresume(dev);
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_set_autosuspend_delay(dev, INV_ICM42600_SUSPEND_DELAY_MS);
>  	pm_runtime_use_autosuspend(dev);
> -	pm_runtime_put(dev);
>  
>  	return devm_add_action_or_reset(dev, inv_icm42600_disable_pm, dev);
>  }
> 


