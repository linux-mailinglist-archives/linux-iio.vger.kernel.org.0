Return-Path: <linux-iio+bounces-5619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D6A8D7566
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B3F1C213E1
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8163A267;
	Sun,  2 Jun 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nusNZtLu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497323B2BB;
	Sun,  2 Jun 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717332120; cv=none; b=CyPPwVRVIyV/tfeTIbGSJlBeUFFZqM0UodP3oMkgcVNKomK6eiNUY72vGEQpcA25rx/uGr5K7KqRg2/hnAlznOjZx1FDKJia+RXVKYHkbo9VROScW8gQ2rm8x9i5oQiOu0aKQA6SHuh5o00ea5HvLRzT17Zs5UP+1Q88+rnvDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717332120; c=relaxed/simple;
	bh=/VwbBF5g70XFNUWtesKYS/kHHhxlo11Bi8yiiCJTQNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efEa67ikui0buOQqAPPat4iUH8EBKi0gMP8YtIooVssvPqn+5Q9jhmReVmSwNsbkxOgICJqq769RMC35YLKk5dEHIOwX2gxCH0NdW3at77JbZmefqBzFR1IQOMdkYDmZ4a2VIXU1/KneoOWLN63GSWInlZMCdK+5CxG7oFwo4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nusNZtLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72514C2BBFC;
	Sun,  2 Jun 2024 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717332119;
	bh=/VwbBF5g70XFNUWtesKYS/kHHhxlo11Bi8yiiCJTQNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nusNZtLuYFZiPkzdHFtkyD4rZMmAB1hmGDYyAR/6+fXbGuWRSziRHWpYF/bzA+X8c
	 SHtG+mXAx0TT1cU+ibkbIBREuUiSJa61DWXR+6Rg/CIf9pakYsucM2YiawusgGygYy
	 ziZrJArqAv0zRnuFiOH31EUibvlWcz4wodfGmxKwuXJD109w++VJmF9NzhtdUcP9wI
	 pHsUqeticzDIEb4jzS6RJxdoDN0d83q27bT7Kc0xwU4NcRzgz6wj3vsaut3T44KHu1
	 VM6ASguaALtwGOvvVKwBdDzAbtGQ3oIIhWWobit7mrHNLpRfGTlO//bwnaLmRwU1rn
	 rocFgkILPmc1Q==
Date: Sun, 2 Jun 2024 13:41:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/17] iio: chemical: bme680: Fix type in define
Message-ID: <20240602134150.6cdf01af@jic23-huawei>
In-Reply-To: <20240527183805.311501-6-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 20:37:53 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
Patch title "type" should be "typo". :)

> Fix a define typo that instead of BME680_... it is
> saying BM6880_...
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h      | 2 +-
>  drivers/iio/chemical/bme680_core.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index 4edc5d21cb9f..3133d624270a 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -12,7 +12,7 @@
>  
>  #define BME680_REG_TEMP_MSB			0x22
>  #define BME680_REG_PRESS_MSB			0x1F
> -#define BM6880_REG_HUMIDITY_MSB			0x25
> +#define BME680_REG_HUMIDITY_MSB			0x25
>  #define BME680_REG_GAS_MSB			0x2A
>  #define BME680_REG_GAS_R_LSB			0x2B
>  #define   BME680_GAS_STAB_BIT			BIT(4)
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index dd2cd11b6dd3..8b42c4716412 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -719,7 +719,7 @@ static int bme680_read_humid(struct bme680_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
>  			       &tmp, sizeof(tmp));
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read humidity\n");


