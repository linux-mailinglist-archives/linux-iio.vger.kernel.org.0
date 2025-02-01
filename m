Return-Path: <linux-iio+bounces-14823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B34A249DA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40F43A55F8
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DCE1BD018;
	Sat,  1 Feb 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzMa4qda"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEA35953;
	Sat,  1 Feb 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738423873; cv=none; b=k1taJC7GgFc2InHYBPHWmDtwplxh99s6/TdUWMuNuqtNQS7gaqQ15s9i8sNoWk4hY/9GYM7n3MsodhNuipl33L2/5pfRMIQGt3HZKTySqNgWJ50RXBUFtUmEDK0AEOK72zR1fUXWGOO/BeL1g9uXI7f4EIO66hksxr00HBcGzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738423873; c=relaxed/simple;
	bh=JM1R5GXAIPeeM+wmnjkuKRUft4TvRcPdYI90F09ZX0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvrPo0qHV+pqsLJ5abumNduhgW/7kOIAHuNtPODd+HtWw4O8K7cp84U0w9//o/NYe0yNpdhu8T/RrJvW6q15eVmF5pR4RU89bpIdtKBVG6I706HRlTWbz2PkPVKySjZAOhiOIsim09kYPBkn0aI45pNrhWa90YXJL/nMfOBae60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzMa4qda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F862C4CED3;
	Sat,  1 Feb 2025 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738423873;
	bh=JM1R5GXAIPeeM+wmnjkuKRUft4TvRcPdYI90F09ZX0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AzMa4qdaI9140Ib97pX9gwGolBKMoxZyFST/LcIhVx8nKu0bAw1ODzHV19UBxELyA
	 CaUri6iFjOXg3UYWcIZBeWzV2zhyWN6u/cNNA5+SNG7gLLcOvzKg+8gis6/Gtssu2T
	 NTJzeTe7JjyyCUKmBvNLSQaVq7xgROIJ5sbMGM9T51VS+YFPkrQQ7w4GRobpNQG8cx
	 hFp2FBY6DEnIydjjWXLK+kL2EbMu7dp9RIiNDFKjFK85R4nMELnmnxR4cZsBRHZJag
	 Lcem7V5AveZYIROjroo4hWcYtzHBjQy18RCBwqE9xnuJYeDn7NztWgwt+lbfstBx8F
	 AoyNeFcTXlyGQ==
Date: Sat, 1 Feb 2025 15:31:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 06/16] iio: adc: ad7768-1: set MOSI idle state to
 prevent accidental reset
Message-ID: <20250201153103.60675555@jic23-huawei>
In-Reply-To: <b99ec75a9f8a47df72a0e8cf126d7e9312ce59c1.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<b99ec75a9f8a47df72a0e8cf126d7e9312ce59c1.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:12:29 -0300
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

Ideally drag fix to start of patch set to make it obvious it can be
picked up without the rest.  I'm not grabbing it yet as doesn't
feel like it has enough review yet.

> ---
> v2 Changes:
> * Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
>   continues the same. I realized that using bits_per_word does not avoid the problem that
>   MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
>   during a transfer, nothing happens.
> ---
>  drivers/iio/adc/ad7768-1.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index c3cf04311c40..95ba89435652 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -574,6 +574,22 @@ static int ad7768_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	/*
> +	 * Datasheet recommends SDI line to be kept high when
> +	 * data is not being clocked out of the controller

Very short line wrap.  Go up to 80 chars.  If this picks up
some review, I can fix that whilst applying. If not do it for
your v3.

> +	 * and the spi clock is free running, to prevent
> +	 * accidental reset.
> +	 * Since many controllers do not support the
> +	 * SPI_MOSI_IDLE_HIGH flag yet, only request the MOSI
> +	 * idle state to enable if the controller supports it.
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


