Return-Path: <linux-iio+bounces-5614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F08D754A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225F91C20E0B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3639FD7;
	Sun,  2 Jun 2024 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX5W5Hen"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1273442F;
	Sun,  2 Jun 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717330912; cv=none; b=Hl08Frha+7QBrUJ53pN8L6P/GPlQqpXG6pcXiX8HCpoE0tPEZTLg+EnwPAcI1NV3xGnuV+VlOfX3zp8nvJ4RCtkhsbFG6hENGGGPsiCXNhCnKHpPvKud8RlxcBddxk4FB6euJnp3APzf+zF5aP8rwWehiUZ1k/ucHd2xkFCsCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717330912; c=relaxed/simple;
	bh=lvlJGVin53fnlae77bxMcOXn67Pohe2vjm+EJ3BfPM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxfbc3FWyyjAinZCRQY0sjQ7+2oWhTH8cUOlJEdbw9R/+YaEQIMYcOljnB2HQxOwZQTB07T53xRhOfUCDaFOaZ55UiwW7lFHbSdU5lyf0Nit54JqccMtcvDx/GZB+kuDYDx+M7CHmpofkZ1lfR7LqjiMadlK/OwKaORqMJ3NBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX5W5Hen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09512C2BBFC;
	Sun,  2 Jun 2024 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717330911;
	bh=lvlJGVin53fnlae77bxMcOXn67Pohe2vjm+EJ3BfPM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BX5W5HenofAKkd9eAfCi7h95mfHrbaOuDP2Ka5zTZHBdgOQprKYJ5hSdeYFQbH5BM
	 ECcsm9+StBwrGjd7iuQ8UFko6PgOQB4AQ60Sd7oSdpjB9aFrI/khJrnXt2Q4EhMw/H
	 BEN/6Pfc1wxKKbkSxLMQ3ndCQKXmXfCHS5Tl0/7/MJDIikOddL+64KgPSQZU4+uJtN
	 51zfk6D/Ooz4e6sOSyZ7PUzBzfiJPp5IAC43gdwHlz6F+mX53LCnuV0EA4t3QigXHh
	 oKrwrK15+B5XssU3HaBMAMrdpxGIstFiEWTMsgzTVBcrSj5UYFGb9hX73H1np/jFoC
	 x1+W0la6fG8pA==
Date: Sun, 2 Jun 2024 13:21:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v3 4/5] iio: adc: ad7173: Clear append status bit
Message-ID: <20240602132140.31dbdef0@jic23-huawei>
In-Reply-To: <20240530-ad7173-fixes-v3-4-b85f33079e18@analog.com>
References: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
	<20240530-ad7173-fixes-v3-4-b85f33079e18@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 15:07:52 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> The previous value of the append status bit was not cleared before
> setting the new value. This caused the bit to remain set after enabling
> buffered mode for multiple channels and not permit further buffered
> reads from a single channel after the fact.
> 
> Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Applied to the fixes-togreg branch of iio.git.

> ---
>  drivers/iio/adc/ad7173.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index eb512878c30e..e66a137a76be 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -543,6 +543,7 @@ static int ad7173_append_status(struct ad_sigma_delta *sd, bool append)
>  	unsigned int interface_mode = st->interface_mode;
>  	int ret;
>  
> +	interface_mode &= ~AD7173_INTERFACE_DATA_STAT;
>  	interface_mode |= AD7173_INTERFACE_DATA_STAT_EN(append);
>  	ret = ad_sd_write_reg(&st->sd, AD7173_REG_INTERFACE_MODE, 2, interface_mode);
>  	if (ret)
> 


