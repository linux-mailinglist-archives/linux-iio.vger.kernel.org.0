Return-Path: <linux-iio+bounces-18864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41294AA170F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 19:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05966987C81
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E424C074;
	Tue, 29 Apr 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQPQjB1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBEF22172E
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948284; cv=none; b=RL/WrXEnEBZHzmnZYUimcD8ccMnHf1Yhosm3hN5TWKyXtpLgDgzKIbRUrjxTBC3HbUBPxvmICVkUVJ0GYQlWqUigb2c97wfsUJfKO1Fu075s5po6mgjkrYUtHFmn+wYGG+gQumRUbgQ35Mn9QkBD9K6ZOvY+q+7IZer05qx54hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948284; c=relaxed/simple;
	bh=ulKQTRkY9vC7MtbHNkm8UaVAhGwpG7qqDFiPLuNKCLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fmi+73Eigb/fZKKt5aHDgd2/ioG4KdVDoUb8JsZnBuH/pwT2LFToeDoQCeoZekvfY869j7JrzyKXVQNd7g7sbDvjBcX+s5Yhc0x9CjOmBmPrWJmaHso8+TkNISOy6F/CAdXQG9zcu5LE5WjfcXD11lVyiwe49nQXrjOPog3ZHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQPQjB1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE5C4CEEA;
	Tue, 29 Apr 2025 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745948284;
	bh=ulKQTRkY9vC7MtbHNkm8UaVAhGwpG7qqDFiPLuNKCLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FQPQjB1ZMWFDRKuIcDUap8XDZVUoj5IAdRfw2gV4pynQ4ff+OrLcNWTkVTYSWtscc
	 HnLCDjp/dDYvmvWaRjh83FmdEzA+GHcuLbLKUIVsWHce+MHT+1Nzk95ifRyJxZIIl3
	 CKljVRjzvSUlhRJE+3JiDyrTaKCQNCvCOqAiSwFxkgC7iHJVNBGqiiWWFKbyWMipWa
	 Pu2UoHIGNeXmZJuxpkgsvx/4+6MYhPB3XeVpyHEInMJdNgOSCPoGDuZnajR65Y08X8
	 O7IZLmFh9cGb8xI/E7Hy12a1D0Il2YXBEkSMwjoMNFhNcma9LZ2nHB7MnRt6sdmwTr
	 75kS9Q3o4thsQ==
Date: Tue, 29 Apr 2025 18:37:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cesar Bispo <dm.cesaraugusto@gmail.com>
Cc: linux-iio@vger.kernel.org, Cesar Bispo <cesar.bispo@ime.usp.br>, GabrIel
 Ferreira <gabrielfsouza.araujo@usp.br>
Subject: Re: [PATCH 1/2] iio: adc: ad7476: modernize single regulator call
Message-ID: <20250429183757.14fdeee7@jic23-huawei>
In-Reply-To: <20250429160526.5934-2-cesar.bispo@ime.usp.br>
References: <20250429160526.5934-1-cesar.bispo@ime.usp.br>
	<20250429160526.5934-2-cesar.bispo@ime.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 13:05:18 -0300
Cesar Bispo <dm.cesaraugusto@gmail.com> wrote:

> Replace a single instance of legacy regulator handling in each driver
> with devm_regulator_get_enable() and devm_regulator_get_enable_optional().
> This change improves code clarity and aligns with modern kernel APIs.
> 
> Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
> Co-developed-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
> Signed-off-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
Take a closer look at the signatures of these functions.

I'm a bit surprised if this builds.
> ---
>  drivers/iio/adc/ad7476.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 37b0515cf4fc..33155f76230e 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -314,7 +314,7 @@ static int ad7476_probe(struct spi_device *spi)
>  	st->chip_info =
>  		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>  
> -	reg = devm_regulator_get(&spi->dev, "vcc");
> +	reg = devm_regulator_get_enable(&spi->dev, "vcc");
>  	if (IS_ERR(reg))
>  		return PTR_ERR(reg);
>  
> @@ -334,11 +334,11 @@ static int ad7476_probe(struct spi_device *spi)
>  
>  		/* If a device has an internal reference vref is optional */
>  		if (st->chip_info->int_vref_uv) {
> -			reg = devm_regulator_get_optional(&spi->dev, "vref");
> +			reg = devm_regulator_get_enable_optional(&spi->dev, "vref");
>  			if (IS_ERR(reg) && (PTR_ERR(reg) != -ENODEV))
>  				return PTR_ERR(reg);
>  		} else {
> -			reg = devm_regulator_get(&spi->dev, "vref");
> +			reg = devm_regulator_get_enable(&spi->dev, "vref");
>  			if (IS_ERR(reg))
>  				return PTR_ERR(reg);
>  		}


