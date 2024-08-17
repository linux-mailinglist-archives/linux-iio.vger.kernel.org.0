Return-Path: <linux-iio+bounces-8521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D795572A
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0812824FD
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E19148826;
	Sat, 17 Aug 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKMEe1NJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA558ABC;
	Sat, 17 Aug 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723890044; cv=none; b=TamzvsEZqQyCNE7sB4tbcQooPqthl6pdDTmewc1yvISngnZUpSd43y9cn9C3MVGnehZ7DNuQ8U5Bk+/ofFgVVALqxRsqvA0Qb3+dMwmvjlxLH//LTtLqVl9qKjJm2KfmL8NKw2/3e0+L8gQ229x0dAUM9RjtaAuRXKSEPClgM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723890044; c=relaxed/simple;
	bh=gQjONiikFsXYs3z8NWw5w1fNzi3PrS2Oc2oXtECh4tA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCNxdLfaRPv533q3V5cMQEIh4ARpkM50Z7pCbbw0O2WS6TzhfKfw8g9Lgh/p5g+k8xuFoBaNGGdfSIlh5U9ug2xgVZTRPLheOCA+e0liQczEo7Kn4Lox65h2MNLOWIDvhBmpbRJNdINNZ9S4PhCKxY9VE7dbmV0rovJYjSKaMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKMEe1NJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC3EC116B1;
	Sat, 17 Aug 2024 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723890044;
	bh=gQjONiikFsXYs3z8NWw5w1fNzi3PrS2Oc2oXtECh4tA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qKMEe1NJqLoh4VDDbcqtQoVclQPDFq6PlQWhdthBrf9hM05IxaHNcZuhl1r/e0fb7
	 b5lGupxPy50X2UI8IAc2bT+nmTa0kR+WA8qivrLv4CiTAPX6bdzIMzQrMEO1bW5Q7m
	 eNn+oWcqKQ4nub+/JYNHUJ/vweK6ACaVy6feiY7XiHZCUIBQH1lfK8qKz8V13Em8zi
	 mzv0OsMb1Xp/SgxZntLOknrejIVmlW9nvGDeThWpgp3dkiFZ1E8Mx/6Pq+tc0PTjMO
	 8Xi3tx/sqoQI2qvsaI1pRj8xyqTWWAhagd2tbwAJteWppXiNur6XWfoEDtP8Aya4E/
	 9NsU3I5Hqtkpg==
Date: Sat, 17 Aug 2024 11:20:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: dlechner@baylibre.com, dumitru.ceclan@analog.com0,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dumitru Ceclan
 <dumitru.ceclan@analog.com>
Subject: Re: [PATCH] iio: adc: ad7173: fix GPIO device info
Message-ID: <20240817112037.68cb99c2@jic23-huawei>
In-Reply-To: <20240809134909.26829-1-dumitru.ceclan@analog.com>
References: <20240809134909.26829-1-dumitru.ceclan@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Aug 2024 16:49:08 +0300
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> Models AD4114/5/6 have .higher_gpio_bits = true. This is not correct as
> the only models that have the GPIO bits to a higher position are AD4111/2.
> 
> Fix by removing the higher_gpio_bits = true from the AD4114/5/6 models.
> 
> Fixes: 13d12e3ad12d ("iio: adc: ad7173: Add support for AD411x devices")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Applied and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7173.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 9544bf7142ad..b77e2beb502a 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -302,7 +302,6 @@ static const struct ad7173_device_info ad4114_device_info = {
>  	.num_configs = 8,
>  	.num_voltage_in = 16,
>  	.num_gpios = 4,
> -	.higher_gpio_bits = true,
>  	.has_vincom_input = true,
>  	.has_temp = true,
>  	.has_input_buf = true,
> @@ -320,7 +319,6 @@ static const struct ad7173_device_info ad4115_device_info = {
>  	.num_configs = 8,
>  	.num_voltage_in = 16,
>  	.num_gpios = 4,
> -	.higher_gpio_bits = true,
>  	.has_vincom_input = true,
>  	.has_temp = true,
>  	.has_input_buf = true,
> @@ -338,7 +336,6 @@ static const struct ad7173_device_info ad4116_device_info = {
>  	.num_configs = 8,
>  	.num_voltage_in = 16,
>  	.num_gpios = 4,
> -	.higher_gpio_bits = true,
>  	.has_vincom_input = true,
>  	.has_temp = true,
>  	.has_input_buf = true,


