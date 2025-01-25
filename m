Return-Path: <linux-iio+bounces-14568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4505A1C320
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C546F1886B70
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0441207E1C;
	Sat, 25 Jan 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb7tKTGd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD621DD866;
	Sat, 25 Jan 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807978; cv=none; b=FXnwq+FXjoToITIMepUMf4Upx0vic9ff53Cttz5POfuLKpM43zZXVrGO58fm7deHT86KjInU6uINCL2wNb8NY3tq/QmmtML2mEQKiSuDYzlSXYC0Vly6XARwiKmvfY/+jLUQm+u6VBYu622jd3MkbDFqERKk4WeEuplla/rpGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807978; c=relaxed/simple;
	bh=cPSpWp6T3HMZHsft2l1bqgKTBeKfQ8ohC1eVOtPLW4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miow8/KVMeDbdPL3GaYH84+M/kx3dN6Yk2B7hpBpNm73+4tiD6lEa1HNNJ5IJuhiCVJB3IqpmIpQqtMM2rgI6IsTQCAQ2eiDjX47c/ZsD81WTDiUMt6IJoXodWg0/x1wh6SDjNa5APta4Q4LZ7+8aWqpJkroEqzpwuxObADdF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb7tKTGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F100C4CED6;
	Sat, 25 Jan 2025 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737807978;
	bh=cPSpWp6T3HMZHsft2l1bqgKTBeKfQ8ohC1eVOtPLW4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sb7tKTGdDnHtY83VCWcwhtUZaGR59P6VJVEEhsrh1z1EUZDF5cLyzDlXKzf9TX9q3
	 1S8e27vL1pYFVAjfHu2FwYxrqO4l1DM9k0aDM8L+usklL3Mh5k8NfA5aN8q0RsnVPC
	 d1H0/g/PYw+6L5EOlKe39ANYr7S2AdVoG9xxt33qJtcTvUNjF6gMh9VNy0mFr9+Rij
	 k2XxtEWVsmT7J5LqIy8fDIgeAgVyYlC57E7vFrZCcLm6V2/8xkI78qMnBGn9J7jzwG
	 9HeAzyMYpdSXFcE6ohJQJKNiyyaX/XSna/w8hMBFxIJG+d9n4kqpdgeTKI1w505mIS
	 rtnzQAfYd8EzQ==
Date: Sat, 25 Jan 2025 12:26:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <swinchenbach@arka.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "Michael.Hennerich@analog.com"
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: filter: admv8818: Force initialization of SDO
Message-ID: <20250125122610.4d084c13@jic23-huawei>
In-Reply-To: <SA1P110MB1069C61BF6709D362CA86CA0BCE3A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
References: <SA1P110MB1069C61BF6709D362CA86CA0BCE3A@SA1P110MB1069.NAMP110.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 18:27:46 +0000
Sam Winchenbach <swinchenbach@arka.org> wrote:

> From f851ce8225fc239fcbfc2e06adaa93336a9242ae Mon Sep 17 00:00:00 2001
> From: Sam Winchenbach <swinchenbach@arka.org>
> Date: Thu, 23 Jan 2025 15:24:09 -0500
> Subject: [PATCH] iio: filter: admv8818: Force initialization of SDO
Hi Sam, we shouldn't be seeing the email header in the patch.

I can tidy that up if you can't fix it though. 
> 
> When a weak pull-up is present on the SDO line, regmap_update_bits fails
> to write both the SOFTRESET and SDOACTIVE bits because it incorrectly
> reads them as already set.
> 
> Since the soft reset disables the SDO line, performing a
> read-modify-write operation on ADI_SPI_CONFIG_A to enable the SDO line
> doesn't make sense. This change directly writes to the register instead
> of using regmap_update_bits.
> 
Sounds like a fix, so could you send an appropriate Fixes tag
in a v2 and/or a reply to this email.

> Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
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


