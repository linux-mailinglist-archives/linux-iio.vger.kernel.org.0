Return-Path: <linux-iio+bounces-16348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB62A4E164
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998C417E4CB
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42C253B75;
	Tue,  4 Mar 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrG21Sfl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55545253B50;
	Tue,  4 Mar 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098924; cv=none; b=ZvKKShG0VW0P8ZUGoFNc0yf9qB+qiAH0p9li1q9mVsTYGT38S9ftItM7Tu9upqOZ8r1/3YdmTdANSBHzH975QWczJR0rQSPmjQAzNqtBGtsiZfZ0MMj9xcUBs2MW6p20Gmf1UORc1/clqb3k1u4ymVLkSkQFBpdZucUQ56kq7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098924; c=relaxed/simple;
	bh=HA/EqEu0cw/BtzLiMnQRIy7r8rN4w8ZK+l6Ngj/Zlk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYQav3Y2yGdKL+dHm0wewLrFxImEQu2tOhmK8VLv43Jhjt0cyK0Tqs75rrfsh1ssBMyJPzh/0R2eqEPh1A8oGIfwstbGpT52eLVnGxHjjBmTdtk9HHnyUlTaWfGe5ySUeaPt03nC6yLB3mc639i1cwFhWf17u7DGDGbro7WlZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrG21Sfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAC2C4CEE7;
	Tue,  4 Mar 2025 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098923;
	bh=HA/EqEu0cw/BtzLiMnQRIy7r8rN4w8ZK+l6Ngj/Zlk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QrG21Sfl+iAOpw2chf7PBTK8AJg39XjitXV8A7NkvlO/xKNvffN4S4DLsETfFHGon
	 2BsUYuFXus7so6UwWlsQ2DNZpMpDRvCuUtxMlywfs791DQ3yQtxaaqelaGR3ssC5qC
	 0NGWgYmEMTmp5PIJ2igP/Yw2PHJx3oPHD9n+CzxpekyG/Gxxw22i/xB92TsEu0SQ+g
	 Dz5yozoFX2SCya1Wv2/AjHF9bMHillEu008CTGk40ChJO988Gyo/cy2inzJM73wfql
	 d0k5GGoxLDHpOdYBGt5GrS6acJhcw7/79rFu4p2rPtkwR70ZNcHUDoGY0lzLFwwL0m
	 ypnff4/CTEDqQ==
Date: Tue, 4 Mar 2025 14:35:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: ad9832: Use devm_regulator_get_enable()
Message-ID: <20250304143511.1f5e8e70@jic23-huawei>
In-Reply-To: <20250303221427.30964-1-danascape@gmail.com>
References: <20250303221427.30964-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 03:44:27 +0530
Saalim Quadri <danascape@gmail.com> wrote:
Hi Saalim,

Thanks for your patch - a few comments inline.

> Use devm_regulator_get_enable() to reduce boiler plate
> code.

Wrap patch descriptions to 75 chars.

> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 37 +++-----------------------
>  1 file changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 140ee4f9c137..a26d7caac131 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -74,8 +74,6 @@
>  /**
>   * struct ad9832_state - driver instance specific data
>   * @spi:		spi_device
> - * @avdd:		supply regulator for the analog section
> - * @dvdd:		supply regulator for the digital section
>   * @mclk:		external master clock
>   * @ctrl_fp:		cached frequency/phase control word
>   * @ctrl_ss:		cached sync/selsrc control word
> @@ -94,8 +92,6 @@
>  
>  struct ad9832_state {
>  	struct spi_device		*spi;
> -	struct regulator		*avdd;
> -	struct regulator		*dvdd;
>  	struct clk			*mclk;
>  	unsigned short			ctrl_fp;
>  	unsigned short			ctrl_ss;
> @@ -297,11 +293,6 @@ static const struct iio_info ad9832_info = {
>  	.attrs = &ad9832_attribute_group,
>  };
>  
> -static void ad9832_reg_disable(void *reg)
> -{
> -	regulator_disable(reg);
> -}
> -
>  static int ad9832_probe(struct spi_device *spi)
>  {
>  	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -320,33 +311,13 @@ static int ad9832_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->avdd = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->avdd))
> -		return PTR_ERR(st->avdd);
> -
> -	ret = regulator_enable(st->avdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->avdd);
> +	ret = devm_regulator_get_enable(&spi->dev, "avdd");
>  	if (ret)
> -		return ret;
> -
> -	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
> -	if (IS_ERR(st->dvdd))
> -		return PTR_ERR(st->dvdd);
> +			return dev_err_probe(&spi->dev, ret, "failed to get AVDD voltage\n");

Please fix indentation. Should only be 1 tab more than if (ret)


>  
> -	ret = regulator_enable(st->dvdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9832_reg_disable, st->dvdd);
> +	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
>  	if (ret)
> -		return ret;
> +			return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVDD supply\n");

As above.

>  
>  	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
>  	if (IS_ERR(st->mclk))


