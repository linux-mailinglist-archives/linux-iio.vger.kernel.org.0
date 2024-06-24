Return-Path: <linux-iio+bounces-6843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C191575C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 21:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7521F22D15
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741BA1A01D5;
	Mon, 24 Jun 2024 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhq4pMun"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A61A01C8;
	Mon, 24 Jun 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258272; cv=none; b=iz5zf5oZSd30c6xH7KKt5PspmAuKXckeBqjTWWoux6t0qS3sirmpLZOleDPeKkcAyK7pPIkNcOJ1yp8qeklGomBAIquyjgi15l1jRhkEeQ7W3PKrWVvS5/Ax9VhfIKfrIXSUf28PcA1I+FAhMFbKa7nXh9tX5FeX47cZQkBvdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258272; c=relaxed/simple;
	bh=ozzJdGQZHB4A7ItrRhmGCRi2pZDVDoEwFIhTP08/eiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6EI58KfnNpBaF3U72poANkwkRnMfX9YIMYMzBke1U/Z9d41pLs0nTqUR52YQ3Thf8jbXGDNGsTY0L2TZOVBb4JUTeMxmWuoi+J12URBQgA0a5K+xqlxCgBxjoKKrpWI9iyNP2PpPr4KlNZAwpV2/zzBtncr2aOmHyR+EGeCCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhq4pMun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE719C2BBFC;
	Mon, 24 Jun 2024 19:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719258271;
	bh=ozzJdGQZHB4A7ItrRhmGCRi2pZDVDoEwFIhTP08/eiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dhq4pMunpONhJ4X+mjkZwybn49k8f6R9eY3l6z0ar/Dg+svA1fTV8vb9Qwzy1QsbL
	 rdmW5nRMvrFjPo2Zod/6M1WzHb0fcsUjqvZaU7qo8iur+WqM9K19Teyg+jHxpsbXa4
	 y7D6qxVxtLdsCWkMXRwA0GHvZiupBQwU4RBWp2imjYf9DC8qC64UO2nIOtWO3CRkwP
	 Mm2qjY73W0lEyfSE84wKW8kdoBgS343dKTz7FZSYno3MaciTn+E5+AMRXRViVj3UYv
	 JFBPBdJxRpKXZD/AWAsK4WhR1X+PiZz2xA6YMkgEmyOtV9ueEjHx/9VgaiHMnpsGXX
	 Qu31Y9zt9MHOA==
Date: Mon, 24 Jun 2024 20:44:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] spi: add devm_spi_optimize_message() helper
Message-ID: <20240624204424.6a91a5e4@jic23-huawei>
In-Reply-To: <20240621-devm_spi_optimize_message-v1-2-3f9dcba6e95e@baylibre.com>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
	<20240621-devm_spi_optimize_message-v1-2-3f9dcba6e95e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 15:51:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new helper function devm_spi_optimize_message() that
> automatically registers spi_unoptimize_message() to be called
> when the device is removed.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
The new function can be called from modules and doesn't have an
EXPORT_SYMBOL_GPL()

I failed to spot this but a build test immediately noticed!

Jonathan

> ---
>  Documentation/driver-api/driver-model/devres.rst |  1 +
>  drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
>  include/linux/spi/spi.h                          |  2 ++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index a1c17bcae68d..ac9ee7441887 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -464,6 +464,7 @@ SLAVE DMA ENGINE
>  SPI
>    devm_spi_alloc_master()
>    devm_spi_alloc_slave()
> +  devm_spi_optimize_message()
>    devm_spi_register_controller()
>    devm_spi_register_host()
>    devm_spi_register_target()
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 54cbe652a4df..3f953504244b 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4358,6 +4358,33 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>  	return ctlr->transfer(spi, message);
>  }
>  
> +static void devm_spi_unoptimize_message(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}
> +
> +/**
> + * devm_spi_optimize_message - managed version of spi_optimize_message()
> + * @dev: the device that manages @msg (usually @spi->dev)
> + * @spi: the device that will be used for the message
> + * @msg: the message to optimize
> + * Return: zero on success, else a negative error code
> + *
> + * spi_unoptimize_message() will automatically be called when the device is
> + * removed.
> + */
> +int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
> +			      struct spi_message *msg)
> +{
> +	int ret;
> +
> +	ret = spi_optimize_message(spi, msg);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_spi_unoptimize_message, msg);
> +}
Missing an export.

> +
>  /**
>   * spi_async - asynchronous SPI transfer
>   * @spi: device with which data will be exchanged
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 85785bcd20c1..a9388714e7e7 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1272,6 +1272,8 @@ static inline void spi_message_free(struct spi_message *m)
>  
>  extern int spi_optimize_message(struct spi_device *spi, struct spi_message *msg);
>  extern void spi_unoptimize_message(struct spi_message *msg);
> +extern int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
> +				     struct spi_message *msg);
>  
>  extern int spi_setup(struct spi_device *spi);
>  extern int spi_async(struct spi_device *spi, struct spi_message *message);
> 


