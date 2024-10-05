Return-Path: <linux-iio+bounces-10179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F5599186D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32E61F22AE1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C715749C;
	Sat,  5 Oct 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la+0kgN+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825C14D430;
	Sat,  5 Oct 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146905; cv=none; b=pTZzu/i7/paRkaD9XOksQK1kkt2H1uxYDER4qcrv6X0z/x/jyUYnToRf+/A70MbkY93E3OfenaQfgQnCLIlk/wpLnZs4eNvD5aSEtJq9yXPz2k8394QwNtN+u0NdSk+J+wQTvdZ0QqWfHNws81wxQOV7kLTi/QbZnp9pCsEkAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146905; c=relaxed/simple;
	bh=91HCMg0JjX99Rn04tXze6sRRPkgJg/UlDJEpIAcwTAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uedt0QoyAAeNOYNRprk3yHs5xl1FJ3aanK3aZre0fEbChF/gZ+h4tyvbZk8/udpMLeqtoxWV0iMYwEjqQsrkG5ME94TZGFHVxK/JFqtsLrL0tIIx5b4M5m2hNrBpMTENP4wztICCkeZ8s4njT81HvKd50Fti5Yo8PBoDzcXNyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la+0kgN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84201C4CEC2;
	Sat,  5 Oct 2024 16:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728146905;
	bh=91HCMg0JjX99Rn04tXze6sRRPkgJg/UlDJEpIAcwTAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=la+0kgN+h9xgZBdbZcTKRpgRBC+5kaLDIl6IA4xeKWgkl7hIWRAHWTqjVXNqYQ/O3
	 o/zKtq5p0UbTarLBR02lQb9HC0px1+KEmh+UsDylsKZBPmkXy8A/hVwT71g7XfiYBf
	 r/SZZPy9YvYrEs5FgySdzSREsUt8SAacttfIjSaF2XWvZmL8N3meH2O0ZM5rIPc/L8
	 TVVmvu6/y/2nyqGKKNrp9OGNcAUBMxgLu4ziSphb9eRAn/8ss/ytKeDzvAqrLYY4kd
	 3xaqEYF/S5pZGx19XshzPmKs1kUDx/NDP7VtOAut7EVjFJYxAkd1eGnI0Pu8pGTyb/
	 2nK2+lahGlLpg==
Date: Sat, 5 Oct 2024 17:47:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: light: vl6180: Added Interrupt support for
 single shot access
Message-ID: <20241005174755.6864d482@jic23-huawei>
In-Reply-To: <20241004150148.14033-3-abhashkumarjha123@gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
	<20241004150148.14033-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 20:31:47 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Configured the GPIO1 pin to provide output interrupts. And then the
> interrupts are serviced in the `vl6180_measure` function when the
> irq_handler signals that the reading is complete.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>

A few comments inline.

Thanks,

Jonathan

> ---

> @@ -211,6 +216,7 @@ static int vl6180_write_word(struct i2c_client *client, u16 cmd, u16 val)
>  static int vl6180_measure(struct vl6180_data *data, int addr)
>  {
>  	struct i2c_client *client = data->client;
> +	unsigned long time_left;
>  	int tries = 20, ret;
>  	u16 value;
>  
> @@ -221,19 +227,26 @@ static int vl6180_measure(struct vl6180_data *data, int addr)
>  	if (ret < 0)
>  		goto fail;
>  
> -	while (tries--) {
> -		ret = vl6180_read_byte(client, VL6180_INTR_STATUS);
> -		if (ret < 0)
> -			goto fail;
> -
> -		if (ret & vl6180_chan_regs_table[addr].drdy_mask)
> -			break;
> -		msleep(20);
> -	}
> +	if (client->irq) {
> +		reinit_completion(&data->completion);

That's late so there is a race condition. You might be delayed just before this
and finish the measurement before the reint_completion() in which case you'll
clear the complete() that happens in the interrupt handler before
then waiting on it.  This reinit needs to be before whatever can potentially trigger
that interrupt.

> +		time_left = wait_for_completion_timeout(&data->completion, HZ/10);
HZ / 10
> +		if (time_left == 0)
> +			return -ETIMEDOUT;
> +	} else {
> +		while (tries--) {
> +			ret = vl6180_read_byte(client, VL6180_INTR_STATUS);
> +			if (ret < 0)
> +				goto fail;
> +
> +			if (ret & vl6180_chan_regs_table[addr].drdy_mask)
> +				break;
> +			msleep(20);
> +		}
>  
> -	if (tries < 0) {
> -		ret = -EIO;
> -		goto fail;
> +		if (tries < 0) {
> +			ret = -EIO;
> +			goto fail;
> +		}
>  	}
>  
>  	/* Read result value from appropriate registers */
> @@ -479,6 +492,15 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
>  	}
>  }

...

>  static const struct iio_info vl6180_info = {
>  	.read_raw = vl6180_read_raw,
>  	.write_raw = vl6180_write_raw,
> @@ -514,6 +536,11 @@ static int vl6180_init(struct vl6180_data *data)
>  	if (ret != 0x01)
>  		dev_info(&client->dev, "device is not fresh out of reset\n");
>  
> +	ret = vl6180_write_byte(client, VL6180_MODE_GPIO1,
> +				VL6180_GPIO1_INTR_OUT);

I would only do this if the interrupt is wired. It's probably harmless otherwise
but seems a bit odd if that pin isn't connected to anything.

> +	if (ret < 0)
> +		return ret;
> +
>  	/* Enable ALS and Range ready interrupts */
>  	ret = vl6180_write_byte(client, VL6180_INTR_CONFIG,
>  				VL6180_ALS_READY | VL6180_RANGE_READY);
> @@ -580,6 +607,19 @@ static int vl6180_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, vl6180_threaded_irq,
> +						IRQF_ONESHOT,
> +						indio_dev->name, indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
> +			return ret;

return dev_err_probe()

> +		}
> +
> +		init_completion(&data->completion);
> +	}
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  


