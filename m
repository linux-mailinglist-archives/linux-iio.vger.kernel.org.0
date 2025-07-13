Return-Path: <linux-iio+bounces-21613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C66B03170
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CA817C574
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5546D278E7C;
	Sun, 13 Jul 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOslMyHI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124311B87E9;
	Sun, 13 Jul 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416528; cv=none; b=G4bf2OBQyz1TDAgsdIpFsMwqC71Xo7UdUSpe5EINO5U1OJp/GNDbHdqXPKF13wu4Q81KniYkZi26Nv4IaW7muEZXlEBW9OXemw2L/+pzl/TqJWnp0IRV232Ytr6d1kRlfvbVsIztODHYUwEN6zP1DMKnz4Fb8HuVXYQSGhU/B1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416528; c=relaxed/simple;
	bh=HP4Wp2jkXL5D123nCFwZc99bQV88QuFNsGsvtPlAcd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDmVZA6sYJbyjkvOPvj3d2qnVIUJc189PK1/zb7FYT0x+xRGPovOsb41A+vCABmKGq1QbPY0wL2vCSjUExQWl8zUzCoAMZspi/kp8L8delGOTYtEM+3ELX+aJsOk8oviRIGJjX/A2aN79uEM6tnZFcMgdQf89b9BowxgR8B7rsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOslMyHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331E4C4CEE3;
	Sun, 13 Jul 2025 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752416527;
	bh=HP4Wp2jkXL5D123nCFwZc99bQV88QuFNsGsvtPlAcd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JOslMyHIUF72jX2VHOvaoH+2vd99oScf3hpQev2wUOJ4IgMvG+fcA3AkjOw4EOcVt
	 U4JYxZzCsbYfDWZYiASu3Dk+N8TTx5s3S/i2+i1ShUQbyiChi+frErrlcbjks5KVMP
	 Mp+ATD3W3ccRrhjd5lG/LQHnBzJhpFv9Fc+FhOUHiGGQ4xIdHA0eBPcxahDySbnkeL
	 ZRvAqyHGRAK3LW9+x3NftKL2VekS73AwhO7gFTjWEHb3u7pQFsLKZkfAGL9UoeNHpZ
	 oPZwwg4sQz6JPa4nSfcS3qyyi60UHk6yj8JY7EjYX3Bjvd7Md6m/ACcFTuBEEESl86
	 GPzpyHJFl5yBA==
Date: Sun, 13 Jul 2025 15:22:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: imu: inv_icm42600: Remove redundant error msg
 on regulator_disable()
Message-ID: <20250713152200.041e05dd@jic23-huawei>
In-Reply-To: <20250709-icm42pmreg-v1-3-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-3-3d0e793c99b2@geanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 14:35:11 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> The regulator framework already emits an error message when
> regulator_disable() fails, making the local dev_err() redundant.
> Remove the duplicate message to avoid cluttering the kernel log
> with the same error twice.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 35f7c66d77790829a739d2c54ba77e53903a9297..55a29b1e2b11355598b0ede7af22857aed3ae134 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -700,12 +700,8 @@ static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
>  static void inv_icm42600_disable_vddio_reg(void *_data)
>  {
>  	struct inv_icm42600_state *st = _data;
> -	const struct device *dev = regmap_get_device(st->map);
> -	int ret;
>  
> -	ret = regulator_disable(st->vddio_supply);
> -	if (ret)
> -		dev_err(dev, "failed to disable vddio error %d\n", ret);

Dropping this message (which is sensible) reinforces my lack of warm
fuzzy feelings about patch 1.  I'd definitely leave those other calls
alone and keep this as just a tight wrapper around st.  Note though that
can just pass the regulator as the parameter to the devm_add_action_or_reset()
and simplify this a bit more now you don't need to get to the dev.

> +	regulator_disable(st->vddio_supply);
>  }
>  
>  static void inv_icm42600_disable_pm(void *_data)
> 


