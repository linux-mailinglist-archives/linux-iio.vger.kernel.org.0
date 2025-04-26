Return-Path: <linux-iio+bounces-18683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B457A9DA6A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502D27AA45B
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D722A4D6;
	Sat, 26 Apr 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCnEm0L9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D92253A7;
	Sat, 26 Apr 2025 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745666670; cv=none; b=Ya6fKkWqtUjAmGpDCnw5/rWENjgcnf9TzPNPailV+G+jSkriycmot800HARt8ci0hRecTuxDRHG7ZJjTW0Op9S431hfte/OYpwqTvHfP9shIVJueFrC3OQeEitL1Ngrass09MZ2ce3geaYBPMELrB+R6XPlmIYirBAnspK0GEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745666670; c=relaxed/simple;
	bh=Vm3IZsXSU/eJ3GT/vGl/2eAMEOMlqN1H1YjSaFCjHPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX+6RSGEBI6wyZEfbZ/gvNXKX+aW3Z7X/ycofHOT337Max6M2UJQlU9HT3TiAgg6mv8+EtZfEt5m//H1pMPHF2wtGLm1xRGopXkekI2ib+CmvqnpO7cGd6atby/F7tF2O5D2ZoU/plofKF7gFEceNbtIT6Hk30HEeZl2PUKgoaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCnEm0L9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD53C4CEE2;
	Sat, 26 Apr 2025 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745666670;
	bh=Vm3IZsXSU/eJ3GT/vGl/2eAMEOMlqN1H1YjSaFCjHPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kCnEm0L9XsLd42X/d0xWdPdEJPU7tmJ/15p7TAlv5KLJSJb/CYnsflVssIrYoHGP1
	 oA6ItURQH2h4irWSOEx0cwTW0DyppMfy62Odo7Nfg/LEctieuYFG+iEE9qnpl+CYYI
	 isU6WMDFGU1kqGnyZo8GjCRXfuO4TozI/bgSIIV4qHX82t572Nz5lUDBeKecp/KwH1
	 tPMolfjPPAnSng9TgfCpRQN6jTZod1Fo0mnA+AQzr+4lerl5riS+Vwo0KyXWdSohC+
	 RihIlAISvJgbTjwVFlsdrZIvsWmKJ+5pab9hPI/gnz2S39gH99ix+JAQ2V1JYgsZhO
	 OPPIZ6TSSGM8Q==
Date: Sat, 26 Apr 2025 12:24:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/6] iio: adc: ad4695: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Message-ID: <20250426122422.29660e70@jic23-huawei>
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-3-f12df1bff248@baylibre.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
	<20250425-iio-introduce-iio_declare_buffer_with_ts-v3-3-f12df1bff248@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 16:08:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
> used with iio_push_to_buffers_with_ts(). This makes the code a bit
> easier to read and understand.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad4695.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 0c633d43e480d5404074e9fa35f1d330b448f0a2..992abf6c63b51dee222caf624e172455fb9b9900 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -160,8 +160,7 @@ struct ad4695_state {
>  	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
>  	struct spi_message buf_read_msg;
>  	/* Raw conversion data received. */
> -	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
> -		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
> +	IIO_DECLARE_DMA_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);

As a follow up, maybe we can rename that AD4695_MAX_CHANNELS to
AD4695_MAX_ADC_CHANNELS so I don't wonder why there is a + 1?

>  	u16 raw_data;
>  	/* Commands to send for single conversion. */
>  	u16 cnv_cmd;
> 


