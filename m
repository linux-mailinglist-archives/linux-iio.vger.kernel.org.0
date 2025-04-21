Return-Path: <linux-iio+bounces-18409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F5A94FE4
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280DA7A4C2A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E702627E7;
	Mon, 21 Apr 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPSKx+d1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0425C147;
	Mon, 21 Apr 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233907; cv=none; b=j2QbQFFTu6PRy6NHrDJUCR6UWALY6O2RBa98T090GCAmilvOrv4Z2tnMDICnMmELTdWkGEd6/0kgTJ9GHLVHMH0Z/NWoKAORv6D0iIUOxtoX2vvSr9SxFqEft5AAWBT6gkzvLVIp9tWTCrtdnBzHdL7GueG2RwnagdOga6J81Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233907; c=relaxed/simple;
	bh=xIOsJ++5ldkl33Ki3QyxhNNEyh/er5ilQpmhljgokC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev9iZ9jwateU6f3Nxg5fwlBMojivLruohdQJX7QVw2gB27YWSFM/WFcF2WyWCIJrmJmqLhRurQUP4PEeBD6GJBkCxgJAyfep/EQnqzJ79faXxUzrmN9yiXrd+VB1iUMLmBJmzYlHytXj0h64anTwpfFDu32mECsdHpkv46N6TmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPSKx+d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09667C4CEE4;
	Mon, 21 Apr 2025 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745233906;
	bh=xIOsJ++5ldkl33Ki3QyxhNNEyh/er5ilQpmhljgokC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JPSKx+d1iKqilsixLE1m1PbLAH9n0c75A2xNSjkla7Z/w6WMcIII6RrrfYIINWeeT
	 4eQBAT8W1T06j1O+nSRF/msnKL3PrFMIufjYvetCaAtpS0ARBD2VbxTySnpVFCIyMr
	 ao2x0lt/2hyq8UMtbWdYW/EHAOo54ZSRqwXyv1/VI93zjryiB28+S7VkvipNzHlTdi
	 NINLEe8eAoS/GKxLz4GWKVX2AcmCS+qVhILaUf1dxmIcBWmVTibrY9sC1rjsxSDkMe
	 9Y8j1GoxtQLp01t/NTlOPsp7Oc8TDEht+aWOxS+yqAN90aEjs2YTBnhcDJ+QSDtTcp
	 1q37DQAEoUoYg==
Date: Mon, 21 Apr 2025 12:11:37 +0100
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
Subject: Re: [PATCH 03/10] iio: adc: hx711: use struct with aligned_s64
 timestamp
Message-ID: <20250421121137.26e30217@jic23-huawei>
In-Reply-To: <20250418-iio-prefer-aligned_s64-timestamp-v1-3-4c6080710516@baylibre.com>
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
	<20250418-iio-prefer-aligned_s64-timestamp-v1-3-4c6080710516@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 14:58:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use a struct with aligned s64_timestamp instead of a padded array for
> the buffer used for iio_push_to_buffers_with_ts(). This makes it easier
> to see the correctness of the size and alignment of the buffer.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
This one is good and doesn't have the issue with moving timestamps.

Applied.
> ---
>  drivers/iio/adc/hx711.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 8da0419ecfa3575aa54a93707c681ec8ced28be8..7235fa9e13d57c693751757c5d40e8a799622f17 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -87,7 +87,10 @@ struct hx711_data {
>  	 * triggered buffer
>  	 * 2x32-bit channel + 64-bit naturally aligned timestamp
>  	 */
> -	u32			buffer[4] __aligned(8);
> +	struct {
> +		u32 channel[2];
> +		aligned_s64 timestamp;
> +	} buffer;
>  	/*
>  	 * delay after a rising edge on SCK until the data is ready DOUT
>  	 * this is dependent on the hx711 where the datasheet tells a
> @@ -361,15 +364,15 @@ static irqreturn_t hx711_trigger(int irq, void *p)
>  
>  	mutex_lock(&hx711_data->lock);
>  
> -	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
> +	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
>  
>  	iio_for_each_active_channel(indio_dev, i) {
> -		hx711_data->buffer[j] = hx711_reset_read(hx711_data,
> +		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
>  					indio_dev->channels[i].channel);
>  		j++;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, hx711_data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
>  							pf->timestamp);
>  
>  	mutex_unlock(&hx711_data->lock);
> 


