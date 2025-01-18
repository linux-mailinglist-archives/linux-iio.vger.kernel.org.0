Return-Path: <linux-iio+bounces-14465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9AFA15E34
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408CE3A7DC4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709B1A0B0E;
	Sat, 18 Jan 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miQ4mBqG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE4190497;
	Sat, 18 Jan 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219647; cv=none; b=C4L6ZvAwaJon0ilhT5up2/fz0AvSDVX7szBfT3Ybamd/v3UIkyuGAoOI2P8p3aMYegKA85cdTiFqbGeV7ACofPGNbGRAkVPhujDMjYP5r5mrZZdGUCA7QyBmvJkf+xr2Drv1VqHCM2Br2e3Dn57fwtLPtxFyhICT/tDsIoYuBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219647; c=relaxed/simple;
	bh=CJAOc+cvyzkZAg/GL1KVR/kwrvEA2csOj+g4Xxk3Ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhA1i3qjovAMT0qJdHqMee+dj8y70x12ujKvEAJq9U1G3kAIaJ8iyVsWht2un0389aAqnSPQZEl7mpAZ6ZWq+eI4/pFTy4gGEcuIeBByD9JJkt9nTypCgOE6DN/hpOhfgCg1j2dmZeE455Fb/ti1KQgt9r14M19t59/MZ+IWJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miQ4mBqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42B0C4CED1;
	Sat, 18 Jan 2025 17:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737219646;
	bh=CJAOc+cvyzkZAg/GL1KVR/kwrvEA2csOj+g4Xxk3Ft8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=miQ4mBqGrXHgZl/E8VOuJyJ6E+vxm3bzCqnLHmFL//A3lvzRM76cwU167rSHCxbVC
	 /4tMxsGzAgAazNnLsbqypBJ6tKj7fJc8T5blbUIuERD6N2ryy1kJMcboFcxWqWbxJc
	 jjIM8l/TezxXAUEjEPNxnixSuL5McS/0o9pZgPUbiiwhZMR57oSqLA85WeCIfWABjn
	 X4y2isXVwmiXvBNWfOPT3FoHgWA5dTcV1SxOsZDaXefqRSCqM4NfOBddkIuWpaWPYO
	 TvGQFHvKh2kF8ZxIX4ZlikqT9a+mu1EGp3vsz2VUr7N9WSs2XinzuBqa6yToQNNd9H
	 fgRlZDkuaID0w==
Date: Sat, 18 Jan 2025 17:00:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi270: add temperature channel
Message-ID: <20250118170038.21cfa888@jic23-huawei>
In-Reply-To: <20250118-bmi270-temp-v2-1-50bc85f36ab2@gmail.com>
References: <20250118-bmi270-temp-v2-1-50bc85f36ab2@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jan 2025 07:55:49 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> The BMI270 IMU includes a temperature sensor. Add a channel for reading
> the temperature.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Hi Gustavo,

Applied with a small tweak.

> ---
> Changes in v2:
> - Use 'MICRO' instead of 'MEGA' for scale values
> - Remove unintended whitespace change
> - Link to v1: https://lore.kernel.org/r/20250111-bmi270-temp-v1-1-76ee38211bf2@gmail.com
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 48 ++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 7fec52e0b48624f07031b63a9caf6c318f33f5dc..0f89554d6cd321aeda6175cc17663cc7ad83b8e6 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c

>  struct bmi270_scale {
> @@ -136,6 +143,10 @@ static const struct bmi270_scale bmi270_gyro_scale[] = {
>  	{ 0, 66 },
>  };
>  
> +static const struct bmi270_scale bmi270_temp_scale[] = {
> +	{BMI270_TEMP_SCALE / MICRO, BMI270_TEMP_SCALE % MICRO},
For consistency with local style (and the one I'm trying to keep to across IIO)
I added space after { and before }

Thanks,
Jonathan

> +};
> +



