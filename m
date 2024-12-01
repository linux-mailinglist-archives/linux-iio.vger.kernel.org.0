Return-Path: <linux-iio+bounces-12918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4429DF5AA
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 14:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA96281566
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B971C9B75;
	Sun,  1 Dec 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYHQjSQw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826021C879A;
	Sun,  1 Dec 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058244; cv=none; b=AxB8GgeGVYU+Q1i5YT06rCEdqJZPRc3+uzwtq8gjfwKd/1eiqnhAXw0B77Xlt6ldH5s09pFxagqzxCcFcS+Tsrq3kUIyjMZdiyRMtE3/Ml7bSZoDy/Tu1Rj0VXrTVEBvBeJ3TqrAmWaNVtX6cJTaX49BoDRLSpk50uAijcYXbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058244; c=relaxed/simple;
	bh=Ocy0drU9oNXPh1SbTPQFTPl36pbTOQf9YeIulwK1wd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHo7Jz5G3kn3BIYrhgC0K1EkYzmnEojFfnd42ksMFU4Cis80s4Fo8H5I5A2Ljg8oeSCUmNzaW0gB6TI2noPltyurud9HcR9IgGq1K5oOvR2BF0UFFJ9aRrsJ2SJxRCCkduAzEnNBhzU7U4++lBD5zoZU2MJAu/7XZ0HuFlX0BZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYHQjSQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EB4C4CECF;
	Sun,  1 Dec 2024 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733058244;
	bh=Ocy0drU9oNXPh1SbTPQFTPl36pbTOQf9YeIulwK1wd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rYHQjSQw47OC7kna/w738iNb7+SpIqo+7Yus4JgIrv9SxzywUvPn6QDv4SFI4FlXV
	 8gZ0JWHP4YWUPJz4fFV3wFVMQuJ+BwRm/oGwikB4uLmjVeFXnNXkyEDkJURCn06XA2
	 EqF6Hqn2z+TIAm0lgKFpZp1eNWVxhrVLVcHTn6kKVuIJZN9byaAdqCkl4U1PcpsZ7f
	 mBQmsjBY/2uQYW3SLsa+Vt9+pYQRKb1A0OLuvkVYpNAhg8qZCGaZgSYHHTuxqElFad
	 YwREweM48V2wMD3THHTdRVjK0fI2lkvq3kMH50obwfFa9JwlUh71pfSlWgcaOeDXhA
	 gSREbB7J20N/A==
Date: Sun, 1 Dec 2024 13:03:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: lars@metafoo.de, dmurphy@ti.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()
Message-ID: <20241201130356.3bf4c693@jic23-huawei>
In-Reply-To: <20241122164308.390340-1-festevam@gmail.com>
References: <20241122164308.390340-1-festevam@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 13:43:08 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Using gpiod_set_value() to control the reset GPIO causes some verbose
> warnings during boot when the reset GPIO is controlled by an I2C IO
> expander.
> 
> As the caller can sleep, use the gpiod_set_value_cansleep() variant to
> fix the issue.
> 
> Tested on a custom i.MX93 board with a ADS124S08 ADC.
> 
> Cc: <stable@kernel.org>
> Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
Hmm. Could be considered a feature, but fair enough as the change is
trivial and you are setting it on a real board.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads124s08.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index 425b48d8986f..f452f57f11c9 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -183,9 +183,9 @@ static int ads124s_reset(struct iio_dev *indio_dev)
>  	struct ads124s_private *priv = iio_priv(indio_dev);
>  
>  	if (priv->reset_gpio) {
> -		gpiod_set_value(priv->reset_gpio, 0);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 0);
>  		udelay(200);
> -		gpiod_set_value(priv->reset_gpio, 1);
> +		gpiod_set_value_cansleep(priv->reset_gpio, 1);
>  	} else {
>  		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
>  	}


