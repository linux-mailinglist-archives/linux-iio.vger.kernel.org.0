Return-Path: <linux-iio+bounces-16349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9727A4E186
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFA517EDD7
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4A25FA13;
	Tue,  4 Mar 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEsUbuqC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE0251794;
	Tue,  4 Mar 2025 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099007; cv=none; b=cki+TV+fdgdIQbLv9qIMYYU3VoqY7sAJuz/MSI1sW8S55CysF4sIa4LJs1gS7W3F+yJeE2I/FtM2jE4nqHK+yIKsJO473riUdVVZURQJ8QH/debWD+LOX5kYLHVrxxs+AtTXO0B+CW6/Zf2A+A1wsyrsAbEMjduFlm5zJSKX1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099007; c=relaxed/simple;
	bh=EG7fO0317vBfbJP8636Fh5TRmrrfZxNyijCyNuGS57A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOwi30go7v0GCJsH9obiJeFUy6StSkecdImb27v0IPJYJt8xWa3qZHD1sfXQDIx54Ms+ohKK3kONbbwrUVK6PTt9AIQJPpqV3Mp4tcPZ55hDwJcSl5qL2fVliFPADJ+Bure8GDzPzqUzKFxhHe4P1pzp0cF5V1clDQTOEycMSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEsUbuqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662FEC4CEE5;
	Tue,  4 Mar 2025 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099006;
	bh=EG7fO0317vBfbJP8636Fh5TRmrrfZxNyijCyNuGS57A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KEsUbuqCAqB7/5pC9+4tZTB5umCLE1JCnDTboLx2AdqYeeLzKxxouu+nVRjxOS2di
	 Ka2QDLjFOJdVrjaYKwqdaFdVp53VWxcz/LUOhdE/kjo/pT6BdaBpyhClP9zlDHdl2m
	 qCgIMyVNvputN7zRCLTutRraROSZOt6Y4FkjjCfQD5rT6YWWIuYkow5oEYNioF3RSt
	 rHAeUER5xD70rtPVmuIcSgVThU/288mk0tY/Pj9rbBASJUaRRH9aJYQP127qMTwYEL
	 bRISy4BP2SWJ/ehFqH+UziAelhNZW6Z3zN5XAkRXNlKB9TV4+6bMgPkgaszL0d7Is/
	 TZ7mhPB+M+lnQ==
Date: Tue, 4 Mar 2025 14:36:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: iio: ad9834: Use devm_regulator_get_enable()
Message-ID: <20250304143635.3ff62fce@jic23-huawei>
In-Reply-To: <20250303222200.34339-1-danascape@gmail.com>
References: <20250303222200.34339-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 03:52:00 +0530
Saalim Quadri <danascape@gmail.com> wrote:

> Use devm_regulator_get_enable() to simplify code.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 6e99e008c5f4..5da2084c46c9 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -387,33 +387,15 @@ static const struct iio_info ad9833_info = {
>  	.attrs = &ad9833_attribute_group,
>  };
>  
> -static void ad9834_disable_reg(void *data)
> -{
> -	struct regulator *reg = data;
> -
> -	regulator_disable(reg);
> -}
> -
>  static int ad9834_probe(struct spi_device *spi)
>  {
>  	struct ad9834_state *st;
>  	struct iio_dev *indio_dev;
> -	struct regulator *reg;
>  	int ret;
>  
> -	reg = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(reg))
> -		return PTR_ERR(reg);
> -
> -	ret = regulator_enable(reg);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_reg, reg);
> +	ret = devm_regulator_get_enable(&spi->dev, "avdd");
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&spi->dev, ret, "Failed to get AVDD voltage\n");
Hi,

You aren't getting the voltage, just turning the regulator on so this
error message is misleading.

>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev) {


