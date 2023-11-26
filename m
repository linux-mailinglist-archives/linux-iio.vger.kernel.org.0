Return-Path: <linux-iio+bounces-407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017297F94C5
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 19:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C8EB20CBD
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424FFBFD;
	Sun, 26 Nov 2023 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KChUsiRX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085DDDC2;
	Sun, 26 Nov 2023 18:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D10C433C8;
	Sun, 26 Nov 2023 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701022005;
	bh=p6pNrvNvpBYQrf6KyXpLpX8bFfn2jNLT6e4Wi7PEf04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KChUsiRXHl3vEPXtjrHXhvJwnz3eCN19O6H9V8Kw5H/LTNuOJZTpB8vbot6SfSXyf
	 L254+AfwdIYObskHu0ji4rHe+gYnSyZfbn0nprzJYdOBAK/aFR9mEntxwyXquhNiS5
	 sWyoPNjFx5xsZ5k9iI8NRO+0vZOrjATlb5Snqj7O/hbTMgmGgljLLQ03BMBRh6YPkp
	 SQTi8dm2oLtKqaDQpXqfD8ABjVj+gUCTPOMuUOE/AH3Xv/wPXdZT+1+bxeWuSNd0CE
	 7XBFb44H6ieAWdwUp8miQMME67c9Wy8ogOKtdFcAX0uJ9InLlQPS7nLsZV0VjzKbZw
	 ajftHtjpRyysw==
Date: Sun, 26 Nov 2023 18:06:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jagath Jog J <jagathjog1996@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, oe-kbuild-all@lists.linux.dev,
 lkp@intel.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi323: Make the local structures static
Message-ID: <20231126180637.1a832574@jic23-huawei>
In-Reply-To: <20231108035831.5889-1-jagathjog1996@gmail.com>
References: <20231108035831.5889-1-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Nov 2023 09:28:31 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Make the local structures static within their respective driver files.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311070530.qKhLTz1Y-lkp@intel.com/
> Fixes: b512c767e7bc ("iio: imu: Add driver for BMI323 IMU")
Applied to the togreg branch of iio.git but I dropped this fixes tag because
it's already wrong due to a rebase and that may well happen again.

Probably better to just not have one in this case :(

Jonathan

> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323_i2c.c | 2 +-
>  drivers/iio/imu/bmi323/bmi323_spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index 0008e186367d..20a8001b9956 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -66,7 +66,7 @@ static struct regmap_bus bmi323_regmap_bus = {
>  	.write = bmi323_regmap_i2c_write,
>  };
>  
> -const struct regmap_config bmi323_i2c_regmap_config = {
> +static const struct regmap_config bmi323_i2c_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.max_register = BMI323_CFG_RES_REG,
> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
> index 6dc3352dd714..7b1e8127d0dd 100644
> --- a/drivers/iio/imu/bmi323/bmi323_spi.c
> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
> @@ -41,7 +41,7 @@ static struct regmap_bus bmi323_regmap_bus = {
>  	.write = bmi323_regmap_spi_write,
>  };
>  
> -const struct regmap_config bmi323_spi_regmap_config = {
> +static const struct regmap_config bmi323_spi_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.pad_bits = 8,


