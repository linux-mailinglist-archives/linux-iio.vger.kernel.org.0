Return-Path: <linux-iio+bounces-17420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C435A764BF
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A7C1697D6
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4051E104E;
	Mon, 31 Mar 2025 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn35hVfq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5F1DF738;
	Mon, 31 Mar 2025 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419496; cv=none; b=RsyObJUmbtBnR0anMXGxpTB6tYW9F6sw/BkvPrfnDhJSxfSKVBo10msZMHyjXxosKvYMfX86PKXc3XmP6t/eWUS5yqDHrV+dp3z5q0aAN9FS5hCEDsKKQNQed19Tr7+fHb4rnUcWH6gXk5INKRubqwdcz6BQUyXGLwD9cG0x9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419496; c=relaxed/simple;
	bh=ToVl5s0RX30wsE1JGZ8Oo6lsEMnYO/jqCv3oJ3odNCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq19Q0yj38xxeBTms8ToRpHX+3B9MkVX444wsFaYHzQ4fuC/ypZuc1JpkInthmvJGJdULwsYbC/CfjGifloQQcM08w3W9Fx0Eut2sybBLWO4CJYLvFGxOSJFTpCESfgUS0MgKIZLaYA/YefbHSocAg7zMcBk0WKdU8DFJVPRAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn35hVfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DF0C4CEE3;
	Mon, 31 Mar 2025 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743419494;
	bh=ToVl5s0RX30wsE1JGZ8Oo6lsEMnYO/jqCv3oJ3odNCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gn35hVfq20httgc+1wFBMcrSpFOYWqTZK/Nhs0UvoD60L/EdQQxtufInpxmR5fM+j
	 yRE3JWRQY6WOALpaw+no8XiEhdBRBMZtLGYlFGQE/vGda/BFmfB059MGaloW+cqz63
	 mlqqWE+WnkSmxsf9AmmLAOpvulgJISuIcR5dQJ+jGhn+3XQTz3yVBufWYeS/QvrNDr
	 simzNxj6OGgBXRatOtTFf5pP7Ae6Dcur4SIX/LmfP4AE+MVWaNxMvef7TAs3NZOCcM
	 qW8jjK0oF6zsg5yfAGmo7oWepzUD0r6pr2P9tuYE3g+d3H/JCIPSdFz2HM7Aj5qoxT
	 eFKn3L2zNHSCA==
Date: Mon, 31 Mar 2025 12:11:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ti-adc128s052: Fix ADC value on BE
 systems
Message-ID: <20250331121124.4fed1d44@jic23-huawei>
In-Reply-To: <babe1eac3de30aa22e09266de1f5521fa9e0decd.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
	<babe1eac3de30aa22e09266de1f5521fa9e0decd.1742474322.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:02:55 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> ADCs supported by the ti-adc128s052 driver do return the ADC data in 16
> bits using big-endian format. The driver does unconditionally swap the
> bytes. This leads to wrong values being reported to users on big endian
> systems.
> 
> Fix this by using the be16_to_cpu() instead of doing unconditional byte
> swapping.

It's not doing unconditional byte swap that I can see. The
adc->buffer[0] << 8 | adc->buffer[1]
will work on big or little endian systems as we are explicitly saying
which byte represents higher bit values in a 16 bit output so on little
endian it's a byte swap, but on big endian it's a noop (the compiler might
noticed that and replace this code sequence with an assignment)

Good cleanup, but not a fix as such unless I'm missing something.
> 
> Fixes: 913b86468674 ("iio: adc: Add TI ADC128S052")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> I have no big endian machines on my hands to test this. Problem was
> spotted by reading the code, which leaves some room for errors.
> Careful reviewing is appreciated!
> ---
>  drivers/iio/adc/ti-adc128s052.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index a456ea78462f..d1e31122ea0d 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -28,19 +28,20 @@ struct adc128 {
>  	struct regulator *reg;
>  	struct mutex lock;
>  
> -	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
> +	__be16 buffer __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  {
>  	int ret;
> +	char *msg = (char *)&adc->buffer;
>  
> -	mutex_lock(&adc->lock);
> +	msg[0] = channel << 3;
> +	msg[1] = 0;

Given you are writing shared state why move this out of the lock?
Whilst here maybe using guard() would clean this driver up a little.


Use a separate buffer (or a union) so we can avoid the casting here

>  
> -	adc->buffer[0] = channel << 3;
> -	adc->buffer[1] = 0;
> +	mutex_lock(&adc->lock);
>  
> -	ret = spi_write(adc->spi, &adc->buffer, 2);
> +	ret = spi_write(adc->spi, msg, 2);

Given you are tidying this up, lets make the source of that size value obvious.

sizeof(adc->buffer)

>  	if (ret < 0) {
>  		mutex_unlock(&adc->lock);
>  		return ret;
> @@ -53,7 +54,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> +	return be16_to_cpu(adc->buffer) & 0xFFF;
>  }
>  
>  static int adc128_read_raw(struct iio_dev *indio_dev,


