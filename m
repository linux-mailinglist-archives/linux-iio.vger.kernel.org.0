Return-Path: <linux-iio+bounces-10238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27799991E7B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C07282518
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD79176FB8;
	Sun,  6 Oct 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DW1Xgzjo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC50171092;
	Sun,  6 Oct 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221179; cv=none; b=E8UVC9G6ru1LlTWobZycfBSdtxOraK++foM09t2DqKnlEidzeBIb6n+wLo+LMPvFQDzyB+QAMkYsW9Ze5an2XavusYEycDml5BSIpmq56CAUsD389+SF2hOYa/+GRcx5VGXLg3DDQZrCa45JN/lCPUynMYy4iLrTZMS1saAjBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221179; c=relaxed/simple;
	bh=ZZ28W3MqOasxWhE2CMLNQ90vx+sOSEW/BvskApx8i3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+/FQKRNG+P5bgP1076Xn0YDC25XpJXNPSrVxEfP0XMux2Fo8yzrZL8YWYaKztZPgOVM2GxaFxfr8vnK0K9GRKTPtZaQDF/m65tFO3irZo8vfla3b7cnC2RSXPY4PUIa7I2935INoGt+IE6o92dfE/DhGiYIUUs6E5BYOLyW3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DW1Xgzjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24831C4CEC5;
	Sun,  6 Oct 2024 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221179;
	bh=ZZ28W3MqOasxWhE2CMLNQ90vx+sOSEW/BvskApx8i3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DW1Xgzjoag7fpBe4vwZRMTLLoQxt7B3QiwsXkevm41MtoMHjUcT0sTLsE9tYtb6/7
	 ESUKVRhmMMNcQVdGL0UWUxOMFi8OJOP2HUVrUWWzJ0HFDmbw1AqzYKXzyYsBAVikqX
	 h5hzCzta9kItOy9CbfJezojWWA0l2Z7TCw0Vl5c6P3797ZLifPW5CnaT5sWpp48mFX
	 ck5kIVRZ28+/hf+HuL/dVV4ovj6/FUMfO+lC6dUwtyu94soIJAB/wrpU3MQUkePL5t
	 6mwiwdxvx40PFoIvDBBxhW16EzKO74BNl+S1F1IeZfYeOOkXwdjaYKaga6TIIlcM6m
	 Qx2f953eI56lw==
Date: Sun, 6 Oct 2024 14:26:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cristian Pop
 <cristian.pop@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: frequency: adf4377: add missing select
 REMAP_SPI in Kconfig
Message-ID: <20241006142610.2c71fe93@jic23-huawei>
In-Reply-To: <20241003-ad2s1210-select-v1-3-4019453f8c33@gmail.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
	<20241003-ad2s1210-select-v1-3-4019453f8c33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 18:49:35 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This driver makes use of regmap_spi, but does not select the required
> module.
> Add the missing 'select REGMAP_SPI'.
> 
> Fixes: eda549e2e524 ("iio: frequency: adf4377: add support for ADF4377")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.

> ---
>  drivers/iio/frequency/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index c455be7d4a1c..89ae09db5ca5 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -53,6 +53,7 @@ config ADF4371
>  config ADF4377
>  	tristate "Analog Devices ADF4377 Microwave Wideband Synthesizer"
>  	depends on SPI && COMMON_CLK
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for Analog Devices ADF4377 Microwave
>  	  Wideband Synthesizer.
> 


