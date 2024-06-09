Return-Path: <linux-iio+bounces-6100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF6901591
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F1A1C20B2B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FED1CD0C;
	Sun,  9 Jun 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt59Q2jS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BDA3F
	for <linux-iio@vger.kernel.org>; Sun,  9 Jun 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929505; cv=none; b=aSApdZmLf2lVRTPhT0l+EX2xJGZ3qcwbW5dC2dAyTSZzhM5Y3IicstlpPkxNUVWktNlCqjJ+WSsJG546DINx9tYfZww8a/1CmI2xyqtoGsFrf73X2YnKaOOy8t779ZvO+aEmEAj2D0WrmlpjYuwxK8YJ9SqQGHAqa7EFC0ZqXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929505; c=relaxed/simple;
	bh=qoUm1YRg5TA3BJt3MqFeHn2XgWcPvO0xpivW9H4bswY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLjpj8AWJzS+z8rqrTbk+WysAFwbt6m9fpch1RmkH0EMTWX9EyHoTx23KVklujvPREeu+wyRgETeqxUuIGyww1MxYP62s1d89LSKG0R/EcxnYg45KaBqaMOxaedb114L3yvWPeYyJ7SDrFz+777zioAYGPZNt9FZmeg8ott5s3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt59Q2jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A164CC2BD10;
	Sun,  9 Jun 2024 10:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717929505;
	bh=qoUm1YRg5TA3BJt3MqFeHn2XgWcPvO0xpivW9H4bswY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rt59Q2jSpIbgvDWm8qdk3/PNtOlPR0CFCLYnrJ6CNDGLuhmianuJxE0FD+quuOLSE
	 79Yydxk6NZ0a2UeZBDJVq/6B0M93qb9tb9LdFoSxTtwQLecXK6Q/4C83c6+ZHnKxKT
	 AKZbX+HYQ5pGEXkPofQwtcfErpy76EL4HwGSqCYzacr5c1sZqI71mYN586zz7Z7Vwk
	 lGbLYW8SIiKrHV0ZAUNLpW1e/Rjo1JnQ7Z+Xg+pZk+ph0a9Np+zIGAuV4MA+X3gEbF
	 jTNKO/Fb5huevp4bHRfgMwml8t1XMEzAMSx9XEYAHmXDqAIOb4YoEgZsQf2+JTXIgV
	 wHRPD06GTc5KQ==
Date: Sun, 9 Jun 2024 11:37:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ke Sun <sunke@kylinos.cn>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 Anshul Dalal <anshulusr@gmail.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>, Andrea Collamati <andrea.collamati@gmail.com>,
 linux-iio@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] iio: dac: fix ad9739a random config compile error
Message-ID: <20240609113751.70517cfc@jic23-huawei>
In-Reply-To: <20240609030847.2869455-1-sunke@kylinos.cn>
References: <20240609030847.2869455-1-sunke@kylinos.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Jun 2024 11:08:47 +0800
Ke Sun <sunke@kylinos.cn> wrote:

> WARNING: unmet direct dependencies detected for REGMAP_SPI
>   Depends on [n]: SPI [=n]
>   Selected by [m]:
>   - AD9739A [=m] && IIO [=m] && (SPI [=n] || COMPILE_TEST [=y])
> ...
> ERROR: modpost: "spi_write_then_read" [drivers/base/regmap/regmap-spi.ko] undefined!
> ERROR: modpost: "spi_async" [drivers/base/regmap/regmap-spi.ko] undefined!
> ERROR: modpost: "spi_sync" [drivers/base/regmap/regmap-spi.ko] undefined!
> ERROR: modpost: "__spi_register_driver" [drivers/iio/dac/ad9739a.ko] undefined!
> 
> Fixes: e77603d5468b ("iio: dac: support the ad9739a RF DAC")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404250156.2PQRWmex-lkp@intel.com/
> 
No blank line in tag blocks they are used by various scripts and also checked
by various patch correctness scripts so this will just get me moaned at
by bots.  I'll fix that.

> Signed-off-by: Ke Sun <sunke@kylinos.cn>
SPI is built in most rand configs anyway so this seems like it won't
reduce our testing scope significantly.

Applied.

> ---
>  drivers/iio/dac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 3c2bf620f00f..ee0d9798d8b4 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -133,7 +133,7 @@ config AD5624R_SPI
>  
>  config AD9739A
>  	tristate "Analog Devices AD9739A RF DAC spi driver"
> -	depends on SPI || COMPILE_TEST
> +	depends on SPI
>  	select REGMAP_SPI
>  	select IIO_BACKEND
>  	help


