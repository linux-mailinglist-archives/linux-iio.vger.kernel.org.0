Return-Path: <linux-iio+bounces-5128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE68C95D2
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 20:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743A9B20B6E
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FAC6D1A9;
	Sun, 19 May 2024 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNUibvPN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAB45038;
	Sun, 19 May 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716143733; cv=none; b=uHLPaO+0U8QbxTq2KjiJNc96vHrgvM/6oBfznTXpgO3mNma2teY4Wm4yPA4e3B+sanr7HmEEYruiDblUUB7V13Tvs71HiWTcjkFMO1HbB9Xe/WquDppHqEMgFsrETlN48d3JB2w846KFHc+IOVXvQbnERkIoJcG9u0vOfd6T+nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716143733; c=relaxed/simple;
	bh=xgvz6Rb6QeU43Wv8Xo7zNgrt2yfkty3dnYcWaaVoGAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaKIuBy3jb4woOGdxUOkBLtKMEWRPy3R+/6ERjvNzaHGyo6z3s/zhqS2z3ecNcqKrbD36Jp/SqCyIjiIObnVFKaghMzHV/fXy3V1RlsPDt266zqDKsW9gCBTuqtk5VnxfG1Mpcc7estZ+a7qUutVlEI03VfZFw2XswWUAgC6Z/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNUibvPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8D6C32781;
	Sun, 19 May 2024 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716143732;
	bh=xgvz6Rb6QeU43Wv8Xo7zNgrt2yfkty3dnYcWaaVoGAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNUibvPNTejhgOefLlI92K3IZ9Oty3afy85AfuMIbPSb5I2mVSByWuz60mQd6d2eQ
	 wZDCbcehzlCZi7G1v4w/dJIG4y1Oe9EYrejG4ADqdYQx6hoM7V/6KncT4rpYPkurCk
	 OxDUQTkW/UweB0fWtKdGEk+JgMcSuPMIZ27ujrwatGjpncaaGU+JcPKrRFMeq+xfMN
	 LX6NCrI8TSx4HUgzH0zXPW4lNv8dmsxbyVU4FSC6mE52aEV2zjVvdiXmmeMdFona+l
	 B3B7h7ooqXWzO6DQ+tFxY9sfdsj0qgznvWxnPnNvqcXkPJpk6LfNOngOml/XoOr74k
	 KhE5tnMaCctyQ==
Date: Sun, 19 May 2024 19:35:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v3 7/9] iio: imu: adis_trigger: Allow level interrupts
Message-ID: <20240519193520.23c3c77e@jic23-huawei>
In-Reply-To: <20240517074750.87376-8-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
	<20240517074750.87376-8-ramona.bolboaca13@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 May 2024 10:47:48 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Currently, adis library allows configuration only for edge interrupts,
> needed for data ready sampling.
> This patch removes the restriction for level interrupts, which are
> needed to handle FIFO watermark interrupts.
> Furthermore, in case of level interrupts, devm_request_threaded_irq is
> used for interrupt allocation, to avoid blocking the processor while
> retrieving the FIFO samples.

If respinning for any other reason, I'd rewrap this as a single paragraph.

This looks fine to me, but I'd like an Ack or RB from Nuno.
Last time I poked an adis part predated the common adis library :(

> 
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---
> changes in v3:
>  - new patch
>  drivers/iio/imu/adis_trigger.c | 39 ++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> index f890bf842db8..becf1f558b4e 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -34,21 +34,16 @@ static int adis_validate_irq_flag(struct adis *adis)
>  	if (adis->data->unmasked_drdy)
>  		adis->irq_flag |= IRQF_NO_AUTOEN;
>  	/*
> -	 * Typically this devices have data ready either on the rising edge or
> -	 * on the falling edge of the data ready pin. This checks enforces that
> -	 * one of those is set in the drivers... It defaults to
> -	 * IRQF_TRIGGER_RISING for backward compatibility with devices that
> -	 * don't support changing the pin polarity.
> +	 * Typically adis devices without fifo have data ready either on the

FIFO maybe as it's an acronym.

> +	 * rising edge or on the falling edge of the data ready pin.
> +	 * IMU devices with fifo support have the watermark pin level driven
> +	 * either high or low when the fifo is filled with the desired number
> +	 * of samples.
> +	 * It defaults to IRQF_TRIGGER_RISING for backward compatibility with
> +	 * devices that don't support changing the pin polarity.
>  	 */
> -	if (direction == IRQF_TRIGGER_NONE) {
> +	if (direction == IRQF_TRIGGER_NONE)
>  		adis->irq_flag |= IRQF_TRIGGER_RISING;
> -		return 0;
> -	} else if (direction != IRQF_TRIGGER_RISING &&
> -		   direction != IRQF_TRIGGER_FALLING) {
> -		dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
> -			adis->irq_flag);
> -		return -EINVAL;
> -	}
> 
>  	return 0;
>  }
> @@ -77,11 +72,19 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
> 
> -	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
> -			       &iio_trigger_generic_data_rdy_poll,
> -			       adis->irq_flag,
> -			       indio_dev->name,
> -			       adis->trig);
> +	if (adis->irq_flag & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> +		ret = devm_request_threaded_irq(&adis->spi->dev, adis->spi->irq,
> +						NULL,
> +						&iio_trigger_generic_data_rdy_poll,
> +						adis->irq_flag | IRQF_ONESHOT,
> +						indio_dev->name,
> +						adis->trig);
> +	else
> +		ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
> +				       &iio_trigger_generic_data_rdy_poll,
> +				       adis->irq_flag,
> +				       indio_dev->name,
> +				       adis->trig);
>  	if (ret)
>  		return ret;
> 
> --
> 2.34.1
> 


