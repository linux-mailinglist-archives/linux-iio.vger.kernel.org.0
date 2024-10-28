Return-Path: <linux-iio+bounces-11520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C909B3B9D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2271F22AB2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020020125C;
	Mon, 28 Oct 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzHAzrEh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D1201105;
	Mon, 28 Oct 2024 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147132; cv=none; b=bqqMhBKA8kciwJw114E975MIHTHI4ciATTlrxOO06a1O8p4Ci96zeQbUosXZ7nnN7Bv56mKvjkOPFzbrEVBR2mXai6Dvy7NWI/AqZFmYlglNAeJvOYuFQLQnsBEZDFaLBpC3P/eLoDv0vOy+bSIWaYfuFsAg/OOBwPVC2ThTrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147132; c=relaxed/simple;
	bh=rnjL8n+F/4v2n2O6orIt130j6FPaOE/7lllW+0hIfX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/uH0N4UcSuZsZmMohxTxZI+yJdixudcsk1VnkkMehMuR/ourSCHfA/UbSkNYyX6F05f+8++RNspbY5n9qhV1VXXnng0rTXBNcxkLtR4T2KSwucNzwTyDFMh9KaQqRL5jqrQ9eHs0tUFmTdHefp8W/uCjuYwoTaE5dGqhqz9tWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzHAzrEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40147C4CEE4;
	Mon, 28 Oct 2024 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147132;
	bh=rnjL8n+F/4v2n2O6orIt130j6FPaOE/7lllW+0hIfX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NzHAzrEh8IT+ZzT4RZDDB7mz2M3do9Md0mZc/l6A4fYPgznaFDnxSSWk6aCS+WR4x
	 K/j42/PRnZ1f3TQ5WritR5lOizr6SihIYpx2eaLAIQd1w1Kb9OLAPcV/rI726/9Bw0
	 HGyX6Wu7gHQUQZ7qf6dyXzY9XkSWtHLl9K5mAJ6DwqPV1HYrXV+a0y8Qk/nQTKmjle
	 xmMoNaALMZsKebxz+R4jdGbABBGykq/7AWN/dfvvDGjrhBd28YyWx1Ym42sD5/x0zD
	 +3X5Fn9GvJWK+ft22fsvXB5Q2VKB/fxMFD69QeTC5iqbBB8x8Temo4xR+0IlqUKhfy
	 Q12qGVY8etvDg==
Date: Mon, 28 Oct 2024 20:25:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ahaslam@baylibre.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: dac: ad5791: Use devm_iio_device_register
Message-ID: <20241028202523.5c876f99@jic23-huawei>
In-Reply-To: <20241028071118.699951-7-ahaslam@baylibre.com>
References: <20241028071118.699951-1-ahaslam@baylibre.com>
	<20241028071118.699951-7-ahaslam@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 08:11:18 +0100
ahaslam@baylibre.com wrote:

> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Use devm_iio_device_register to automatically free the iio device.
> since this is the last remaining resource that was not automatically
> freed, we can drop the ".remove" callback.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Hi Axel,

The bot did a much better review job than me this time.
Other than the obvious solutions to the things it pointed out,
this series looks fine to me.

Jonathan

> ---
>  drivers/iio/dac/ad5791.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index cf3d41a10c20..21332c9aca5d 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -405,24 +405,12 @@ static int ad5791_probe(struct spi_device *spi)
>  	if (ret)
>  		return dev_err_probe(&spi->dev, ret, "fail to write ctrl register\n");
>  
> -	spi_set_drvdata(spi, indio_dev);
>  	indio_dev->info = &ad5791_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = &st->chip_info->channel;
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = st->chip_info->name;
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		return dev_err_probe(&spi->dev, ret, "unable to register iio device\n");
> -
> -	return 0;
> -}
> -
> -static void ad5791_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
> -	iio_device_unregister(indio_dev);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id ad5791_of_match[] = {
> @@ -451,7 +439,6 @@ static struct spi_driver ad5791_driver = {
>  		   .of_match_table = ad5791_of_match,
>  		   },
>  	.probe = ad5791_probe,
> -	.remove = ad5791_remove,
>  	.id_table = ad5791_id,
>  };
>  module_spi_driver(ad5791_driver);


