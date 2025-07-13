Return-Path: <linux-iio+bounces-21612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E10B0316C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E2317C42D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C7277C98;
	Sun, 13 Jul 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8ts0APa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022F8F4A;
	Sun, 13 Jul 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416370; cv=none; b=YIBukaQ2MOpNOA+8xx1GFH0hZMSmukO6QVnXGN97QfUsXnMuIyFa/y42EriDddNUf2mlX+J9MbnDbn+1iZNz/OYqzWCwjrMFjSZwkxkx/mrvDH+JO4Cor4P2/15QWasCvcyAlAJuw9u8SIGTYG9BCK+XLETluj7EPMdCCGq1n3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416370; c=relaxed/simple;
	bh=fpo59i0bzYIje6m0g0ps1dgHQntCj0piJ8NHn7X9Drc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDPw65rzQePyEcx8ZO6nO3D09DO6K4REDrfWpKKecu22dWTw42zzo4LcsoF9VC9+zW8q8Ba4S+26/9kS6s2mMhIyEvSMzM+/306MXff0mm5VNZADwd7X8dPZKKki7YcB0UrRY9XlPILet7gAGEwi9inB0pt7+tP6C3QvUCI+z6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8ts0APa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76633C4CEE3;
	Sun, 13 Jul 2025 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752416370;
	bh=fpo59i0bzYIje6m0g0ps1dgHQntCj0piJ8NHn7X9Drc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b8ts0APah2Gtg/8pJznbYaDdDazmdA+bZephqUTbikUsyqCGdA9gPXhGSo43R2NIl
	 HQYa5nwDGHvFJ5CgS3TsNr2Wev7wqDYe+BA3zZCvTf4UbPMx8N72ZFpFLPUKnHzJ3z
	 2Ou1jiIEn9x8bXdI+vdmSufQPpcB3KgCYkoXAuTD31FC1QtXA2oJQqaBezUBLH16+o
	 gHydtT9n+8bzynNSKa1WHiAe5d45BLzQWVsGGjCiKfRAoWJxa/b5Vc6HiApYgdaCcz
	 qVyMViIMIiyGbLqNzn1ePO86gXH+v7AxEAaHjGfarMbFpxVCo+K8ZtEaobBNPiymwr
	 Y8H0yxcXrY0Bg==
Date: Sun, 13 Jul 2025 15:19:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
Message-ID: <20250713151925.3d34f79b@jic23-huawei>
In-Reply-To: <20250709-icm42pmreg-v1-2-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-2-3d0e793c99b2@geanix.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 14:35:10 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> The vdd regulator is not used for runtime power management, so it does
> not need explicit enable/disable handling.
> Use devm_regulator_get_enable() to let the regulator be managed
> automatically by devm.
> 
> This simplifies the code by removing the manual enable and cleanup
> logic.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
In general good, but I think it has a small code organisation side
effect we probably don't want!

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 -
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 25 ++++--------------------
>  2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 1430ab4f1dea5d5ba6277d74275fc44a6cd30eb8..c8b48a5c5ed0677bb35201d32934936faaf7a1a6 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -167,7 +167,6 @@ struct inv_icm42600_state {
>  	enum inv_icm42600_chip chip;
>  	const char *name;
>  	struct regmap *map;
> -	struct regulator *vdd_supply;
>  	struct regulator *vddio_supply;
>  	int irq;
>  	struct iio_mount_matrix orientation;
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index 69496d1c1ff73132f5e7bd076d18a62c293285a2..35f7c66d77790829a739d2c54ba77e53903a9297 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -697,17 +697,6 @@ static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
>  	return 0;
>  }
>  
> -static void inv_icm42600_disable_vdd_reg(void *_data)
> -{
> -	struct inv_icm42600_state *st = _data;
> -	const struct device *dev = regmap_get_device(st->map);
> -	int ret;
> -
> -	ret = regulator_disable(st->vdd_supply);
> -	if (ret)
> -		dev_err(dev, "failed to disable vdd error %d\n", ret);
> -}
> -
>  static void inv_icm42600_disable_vddio_reg(void *_data)
>  {
>  	struct inv_icm42600_state *st = _data;
> @@ -773,23 +762,17 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
>  		return ret;
>  	}
>  
> -	st->vdd_supply = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(st->vdd_supply))
> -		return PTR_ERR(st->vdd_supply);
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get vdd regulator\n");
>  
>  	st->vddio_supply = devm_regulator_get(dev, "vddio");
>  	if (IS_ERR(st->vddio_supply))
>  		return PTR_ERR(st->vddio_supply);
>  
> -	ret = regulator_enable(st->vdd_supply);
> -	if (ret)
> -		return ret;
>  	msleep(INV_ICM42600_POWER_UP_TIME_MS);
This sleep is associated with the enabling of vdd.  So we probably want
to keep those together.  So either move this up, or pull the
vdd handling down to just above this.

Thanks,

Jonathan

>  
> -	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vdd_reg, st);
> -	if (ret)
> -		return ret;
> -
>  	ret = inv_icm42600_enable_regulator_vddio(st);
>  	if (ret)
>  		return ret;
> 


