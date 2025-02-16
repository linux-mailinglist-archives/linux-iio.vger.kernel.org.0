Return-Path: <linux-iio+bounces-15577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D31A3754E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087663B0019
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4CD199E8D;
	Sun, 16 Feb 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSnb5Wcv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40943C8E0;
	Sun, 16 Feb 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721554; cv=none; b=JjaTfYzqsDo3z5UOcJFd4gbWEok18dm7FsAkwiRYlJrq6mxxAtByH8Kll0OGc+s3PMcw7583yk4KLLhrg+2v8q3Bx23WhRoet3q7d5qnhlDYkRFAlBulGMMl0HU7FM0HO9DDI1oF1j5OgEiBUs1ZNYB8sVQoL21JsKT0LJnG7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721554; c=relaxed/simple;
	bh=tzRwEphCXCXbvUeFh2tqFV1w5C5R3tQ/tBfNFSyYgcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GakBtoQFcozF25GLAjoORjxSDiEw+CVvRRDMK0ZahT9Bbmh1v7Rzz5xwfPJAL95ShyYBV8bDUUs0CWRu/CxnDt3Sfr9L+mE71xX87Af9/PLnzpCu2hUbpKTO32KRQfj1GrTm1kKaxSHier1i1TdB9ubRsOQkScEXgEw+GpvXmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSnb5Wcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9FBC4CEE4;
	Sun, 16 Feb 2025 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739721553;
	bh=tzRwEphCXCXbvUeFh2tqFV1w5C5R3tQ/tBfNFSyYgcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mSnb5WcvZxZab5ZaPIiE/x6oN0qbhUASUGtNRDzkEq0pMRwrXGdaOZLPX+Vc0jBJJ
	 +dsVUh6rKKTzfBXx0VyGGD0azL/mKQGDsYxbu+IJOvWpoET/roHaNkSMR0cd4dXEDD
	 ON6ku54RXIbiPCsiy8KbtOYAXjOavm0eR22mL/es9nntKF7kxIVGOOP80sY8kGhQ5O
	 MIhBxqq5Osc1FLvk++MQTFg2+dX+kbbvvUL2eFawE6xumF9rfKZ5qhYuYzE1LRQyif
	 DhEI8XfGPy452GbaUBVBnvCISqmLCeIjDYDAzZLZheTos3I0nX+xvdEM/PR0QVFQRr
	 rGPQKG3U4jrgw==
Date: Sun, 16 Feb 2025 15:59:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <dlechner@baylibre.com>
Subject: Re: [PATCH RESEND v3 02/17] iio: adc: ad7768-1: set MOSI idle state
 to prevent accidental reset
Message-ID: <20250216155903.0ebd32de@jic23-huawei>
In-Reply-To: <c2a2b0f3d54829079763a5511359a1fa80516cfb.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<c2a2b0f3d54829079763a5511359a1fa80516cfb.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:16:07 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Datasheet recommends Setting the MOSI idle state to high in order to
> prevent accidental reset of the device when SCLK is free running.
> This happens when the controller clocks out a 1 followed by 63 zeros
> while the CS is held low.
> 
> Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Just a quick note that I'm not picking these first two up on their
own (yet) as I don't want to create an upstream dependency issue that
might delay the main set.  If anyone would prefer these being rushed
in and potential delay to the new stuff in here, then let me know.

Jonathan

> ---
> v3 Changes:
> * Patch moved closer to the start of the patch set.
> 
> v2 Changes:
> * Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
>   continues the same. I realized that using bits_per_word does not avoid the problem that
>   MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
>   during a transfer, nothing happens.
> ---
>  drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index c3cf04311c40..2e2d50ccb744 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -574,6 +574,21 @@ static int ad7768_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	/*
> +	 * Datasheet recommends SDI line to be kept high when data is not being
> +	 * clocked out of the controller and the spi clock is free running,
> +	 * to prevent accidental reset.
> +	 * Since many controllers do not support the SPI_MOSI_IDLE_HIGH flag
> +	 * yet, only request the MOSI idle state to enable if the controller
> +	 * supports it.
> +	 */
> +	if (spi->controller->mode_bits & SPI_MOSI_IDLE_HIGH) {
> +		spi->mode |= SPI_MOSI_IDLE_HIGH;
> +		ret = spi_setup(spi);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	st->spi = spi;
>  
>  	st->vref = devm_regulator_get(&spi->dev, "vref");


