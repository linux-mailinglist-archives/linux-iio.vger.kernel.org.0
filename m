Return-Path: <linux-iio+bounces-24063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0E7B56192
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568C85604EF
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F42F0670;
	Sat, 13 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flIqDofb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADD2765D9;
	Sat, 13 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757773650; cv=none; b=ncV9r8VHWFD5goAklonGrEdY9YfzG2EF7LLI2PewEhU8DzoLOAeiclwHKB6n8VRx2RPvJretBk6xlp7mniY5AQEgT8Gw55PpUcH5UR6PPmoaFxQtBVOJELzJnnf9zy0gthn7e16f2tG4NduoWq4TiXGIIu3YA9LCnoOylxJxmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757773650; c=relaxed/simple;
	bh=JB8ChRJxerzz0aN6yPFlNI/MgDihUqost679njvHcTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOhWSBmXBncuhi/PP020CZIswoxQmUjB4qBl4P374TZ6HGVGk4blyAxBjCQgDl+987mIfX2w+8AG5uc0pN40cSAj8zRHoxJu3KWeZ+J4LcfvaHrRfbt6Np3MBnij3qNE8BkgTBfcoqwkUhsFSA5wazzsGL2EkeWlFymgpatimTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flIqDofb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B140C4CEEB;
	Sat, 13 Sep 2025 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757773649;
	bh=JB8ChRJxerzz0aN6yPFlNI/MgDihUqost679njvHcTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=flIqDofbblx0JYbzrD1gdRc2Cbgs5TJtfhU4jNyHKDUbNIB5JuLY4XENLeG9SwUmy
	 c9rLeHH4iC06u0wbckU3e5AURbOp18kfOb8nfYhi74pAKoyAQPJWNSeDKQjV1c1gEy
	 HAtxOfwR+yoP4VV7KuZxqNpdEGcBXjdZiOGfnC37kz6xpVOt6WQvrXz169uA9pehnc
	 eiB7bb/Q88X2fIFPw3VdWjH/VgsSCYBakIWSsla24H3+wpYV1K6ljNqYDAL+WuJT8x
	 mm6eLezBKYGvV2BiwlhivaCdiLzaVmUgETpOXicXLsrIwyd1vL8uvjF1ohgnULnfI3
	 D34JDKxNbhzvw==
Date: Mon, 25 Aug 2025 15:52:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: pressure: bmp280: Use
 gpiod_set_value_cansleep()
Message-ID: <20250825155208.2b3c483b@jic23-huawei>
In-Reply-To: <aKsAMRkmGX160gHl@pc>
References: <aKsAMRkmGX160gHl@pc>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 13:06:09 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> Replace `gpiod_set_value()` with `gpiod_set_value_cansleep()`, which is
> required when the GPIO controller is connected via a slow bus such as
> I2C. This is also safe to use in sleepable contexts like the driver
> probe function.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
Don't worry about keeping the number of patches consistent if some
are already applied.  However, I'm not sure where the previous patch 2
has gone...

Jonathan

> Changes in v5:
>   - Clarify commit message in patch 3/3 to better explain why
>     gpiod_set_value_cansleep() is needed, as suggested by Andy
>     Shevchenko.
> 
> Changes in v4:
>   - Split patch 2/2 into two separate patches, as suggested by Markus
>     Elfring.
> 
> Changes in v3:
>   - Split into two separate patches, as suggested by Andy Shevchenko.
>   - Improve the error message to "failed to get reset GPIO", as
>     suggested by David Lechner.
>   - Add Fixes and Cc tags where appropriate, as suggested by Markus
>     Elfring.
> 
> Changes in v2:
>   - Use IS_ERR() instead of IS_ERR_OR_NULL()
>   - Drop dev_info()
>   - Use gpiod_set_value_cansleep()
>   - Improve commit title and message
>  drivers/iio/pressure/bmp280-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 1f0852fc3414..656f6189c84c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3217,7 +3217,7 @@ int bmp280_common_probe(struct device *dev,
>  		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
>  
>  	/* Deassert the signal */
> -	gpiod_set_value(gpiod, 0);
> +	gpiod_set_value_cansleep(gpiod, 0);
>  
>  	data->regmap = regmap;
>  


