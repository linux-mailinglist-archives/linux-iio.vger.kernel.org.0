Return-Path: <linux-iio+bounces-15155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA7A2D620
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 13:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DD87A31CD
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD262246324;
	Sat,  8 Feb 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJuhsjYm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928219F101;
	Sat,  8 Feb 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739018881; cv=none; b=A5YKo5jwMAN1ZxQFF4UjfODFJXYwM2QXJ+9aFIwr4OYo+Rv6IhAamRmo+5DC8+NCK0CkH7NIkXTsNIBY0dpCDHRe8fMi/EnOyeH2lhH43pRTWoHntplh8HPxrQksMafj/Sl3RBpM7WSCQfvFCt1zTIjPBcRcUARdnM+aO+SRPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739018881; c=relaxed/simple;
	bh=rkjAJDmcZ08GU1LSXtsRaCeqzcwheKnmCu00NzzoXkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyZQEfypHNpPk75T97uRaJbjNMPRwg6WHjsKI663QEMMKP9YalDxp6FvhFALFqw1axQ0asH5bLrijfXGuczjTlJEpdm9XS0/asjc+XtLrl4xAZzpzDbF7ecqJ4RTqGSe/8GeH3+AjmaXUDjxQpJXbq5hEbYDNyB4ZCjr2tqsIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJuhsjYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39452C4CED6;
	Sat,  8 Feb 2025 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739018880;
	bh=rkjAJDmcZ08GU1LSXtsRaCeqzcwheKnmCu00NzzoXkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QJuhsjYmC3VkbAsKwDEi2dZoarb+4Andt8eMjnaNCvhhwHcxelZnoMvgE+4kMn21J
	 o9kc2LdEvj5MeOT/3ix4OYMygb1n5hD1Uly8pMr1bbUtEGcQ581HUF2vtVcpvxS7C/
	 zQIPkpUsQctiaYuYVoOPKZZ0pqQn6flfnE/xfSvOPRotZ+xz07WGB7kvfG+f8WPzcj
	 mJ/+awoNs55LiXUXF4dJHzvImNrd9LfgSDToZKLk92ID0B67dQ+NetvWURlkNdGKe2
	 EBYLcFcgMoya165gz8EshkqvI4XT3ibh/4FNwortLYLankp0+HJtX9vZPdTqoMw9ln
	 ibAUkDHaTCpJg==
Date: Sat, 8 Feb 2025 12:47:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <swinchenbach@arka.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3] iio: filter: admv8818: Force initialization of SDO
Message-ID: <20250208124753.7182dc88@jic23-huawei>
In-Reply-To: <SA1P110MB106904C961B0F3FAFFED74C0BCF5A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References: <SA1P110MB106911327A8819E9AF67E676BCE2A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
	<SA1P110MB106904C961B0F3FAFFED74C0BCF5A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 13:34:34 +0000
Sam Winchenbach <swinchenbach@arka.org> wrote:

> When a weak pull-up is present on the SDO line, regmap_update_bits fails
> to write both the SOFTRESET and SDOACTIVE bits because it incorrectly
> reads them as already set.
> 
> Since the soft reset disables the SDO line, performing a
> read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line
> doesn't make sense. This change directly writes to the register instead
> of using regmap_update_bits.
> 
> Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
Applied and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/filter/admv8818.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> index 195e58bc4..9cd1eee84 100644
> --- a/drivers/iio/filter/admv8818.c
> +++ b/drivers/iio/filter/admv8818.c
> @@ -577,21 +577,15 @@ static int admv8818_init(struct admv8818_state *st)
>  	struct spi_device *spi = st->spi;
>  	unsigned int chip_id;
>  
> -	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> -				 ADMV8818_SOFTRESET_N_MSK |
> -				 ADMV8818_SOFTRESET_MSK,
> -				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
> -				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
> +	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> +			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
>  	if (ret) {
>  		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
>  		return ret;
>  	}
>  
> -	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> -				 ADMV8818_SDOACTIVE_N_MSK |
> -				 ADMV8818_SDOACTIVE_MSK,
> -				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
> -				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
> +	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
> +			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
>  	if (ret) {
>  		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
>  		return ret;


