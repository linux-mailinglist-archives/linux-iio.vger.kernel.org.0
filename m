Return-Path: <linux-iio+bounces-18411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F318BA9500B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3314616B0E0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACD71DD873;
	Mon, 21 Apr 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myzm4XAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581CCA5E;
	Mon, 21 Apr 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745234132; cv=none; b=nWzEZ8PhlxiNl2s2KmpQA8qkAIACxz8w2tdbtfOv8/NFBzCYP+jKxfD+eA3/b452dvrWHpENIL6PJUBnHDAsrbSb173uDogfOsZHt7GX6ejG0eoj7cMYe36QYTBLoO8z5MyzRSOe5GCLmadeU2pFS4tYjg+Jh+s8jyLHyB7b1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745234132; c=relaxed/simple;
	bh=TdFSkW6rqypU0+ImrYwDMTJM3iLFX0OMR7ZgNNK8YxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g06Cece1gWp3RghdGQ7bDA5BubVBF65Uqb9ayOV5kVdhAV3XZIXWxWnJcmEcNMSlvUhpTFeTBcepClmRO44DSCsf6Ntil3Id1edFhpVwv1CLhis4vY101/Z18IJ+uF+Jo8Wg2Ci05J9L272jTOusnq/OgNjKFB8CI56wCMMxuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myzm4XAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D609C4CEE4;
	Mon, 21 Apr 2025 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745234131;
	bh=TdFSkW6rqypU0+ImrYwDMTJM3iLFX0OMR7ZgNNK8YxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Myzm4XAFqBLGoeUjlyfyQjhc7KPyaHZA16g4xxJMBb7l20uElkuxTHmsAWf8saup6
	 adlybNGy/G7BUnaHEPf8718dBJGEgRFuQeQkCxtqX8Bn9p/2l2vvxhcpjI9hB0bsPM
	 lJ2+qyke6mrPwKI8Hh8un4rovBOZX2OkCk4Q8X9nn227DZEF2okAnm8j/vbca6YH+g
	 VaMbt/bih3JxM+cQak8hKBgGM5Hm7usTKDTOQkny7+xPYSR7/bJtZQyYZOZQ94UFRL
	 zmDWSIkMfemzQLrVhOmcFqQVVSellMq3+ImJPvJP9nDSEsU1RBZZE8h7a7SANHZNZ4
	 E3UN3wWgZ/wMQ==
Date: Mon, 21 Apr 2025 12:15:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Andreas Klinger <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 06/10] iio: adc: ti-adc0832: use struct with aligned_s64
 timestamp
Message-ID: <20250421121519.4189bd3d@jic23-huawei>
In-Reply-To: <20250418-iio-prefer-aligned_s64-timestamp-v1-6-4c6080710516@baylibre.com>
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
	<20250418-iio-prefer-aligned_s64-timestamp-v1-6-4c6080710516@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 14:58:25 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use a struct with aligned s64_timestamp instead of a padded array for
> the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
> to see the correctness of the size and alignment of the buffer.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-adc0832.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
> index cfcdafbe284b103a069857028886411bc72dea4f..f508f7113faa2610a2889f3c36c5a679fa72264d 100644
> --- a/drivers/iio/adc/ti-adc0832.c
> +++ b/drivers/iio/adc/ti-adc0832.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/iio/buffer.h>
> @@ -29,12 +30,10 @@ struct adc0832 {
>  	struct regulator *reg;
>  	struct mutex lock;
>  	u8 mux_bits;
> -	/*
> -	 * Max size needed: 16x 1 byte ADC data + 8 bytes timestamp
> -	 * May be shorter if not all channels are enabled subject
> -	 * to the timestamp remaining 8 byte aligned.

If the comment is going, we need to capture that there are 16 channels
via a define or a comment.

This one probably wants to stay as a buffer but the same will apply to a new
patch doing that.


> -	 */
> -	u8 data[24] __aligned(8);
> +	struct {
> +		u8 data[16];
> +		aligned_s64 timestamp;
> +	} buffer;
>  
>  	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
>  	u8 rx_buf[2];
> @@ -222,10 +221,10 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
>  			goto out;
>  		}
>  
> -		adc->data[i] = ret;
> +		adc->buffer.data[i] = ret;
>  		i++;
>  	}
> -	iio_push_to_buffers_with_ts(indio_dev, adc->data, sizeof(adc->data),
> +	iio_push_to_buffers_with_ts(indio_dev, &adc->buffer, sizeof(adc->buffer),
>  				    iio_get_time_ns(indio_dev));
>  out:
>  	mutex_unlock(&adc->lock);
> 


