Return-Path: <linux-iio+bounces-9571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDE9791A7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D769C1F22C48
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF9D1D0944;
	Sat, 14 Sep 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyPpZPHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851331EB25;
	Sat, 14 Sep 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325703; cv=none; b=Z/9KKlpi6uEjbAo46iotNJ+kwYEVsinng566krBkcBBK93OSnTi3NL3wJnXP755C7g/YBpjLneVszitg5QDc/rYGQIUyRQe4Nu65OKwtUS3KQ94NYZ/vtNIqWOd9MnpFmRv4RyvDHaRDMhOSKSZblOfaL6hCZ/FE70rJh6qVUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325703; c=relaxed/simple;
	bh=AuIu66dp0tlSdoI9wLQhcO+08+VL03gcY/lSWrfgWg4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLkGuYAFmix4b7XNNtTuvMjBxijFkfWwSPl4wk/nIdj9QF7zarzB7+GFjabTBBIXrO2DPmIfRvjUxmyQhTugJUG8JHkAull1qucDMl6GYhCwhTwn0HCM8d0DoZzVw+SCuZvvfYRD/EVqS6aD1noPcl5fVviNhGpA5DfPAjY+zkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyPpZPHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C158C4CEC0;
	Sat, 14 Sep 2024 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726325702;
	bh=AuIu66dp0tlSdoI9wLQhcO+08+VL03gcY/lSWrfgWg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HyPpZPHBOwxYJ/Yp4LFstP+K0qh8XgSWHOPBMPw0fr1GAHIO6B+CJYchw/qyY2OHU
	 ld6ldCtGcGLauUEtGr415+uMsUxdzY3S6lUxF9FM4NzabYMb1HIpeZsx/Vy0F814w0
	 wWG4nOwTj17MeHSSjbhBjx+0QAVDkGWXihMPj1ydmra7CV6Gc7nwVZwEdiC1OajlHA
	 iBiWc350x8mQ0DPKC5TFqoZt2CUvzRuRuMcSANQeOyHzjSkVb8hWgjeUQj91Yd45yL
	 h5EU1IqQpulx+GnrTG7sk7k9qUp5arMzHPKlKOPqbfNxL7hLl9keN7cDghjjUaKb2F
	 JSmkkJGK+AaBA==
Date: Sat, 14 Sep 2024 15:54:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/7] iio: light: veml6030: make use of regmap_set_bits()
Message-ID: <20240914155454.0d82f4ae@jic23-huawei>
In-Reply-To: <20240913-veml6035-v1-4-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-4-0b09c0c90418@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 15:18:59 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Instead of using regmap_update_bits() and passing val = 1, use
> regmap_set_bits().
> 
Applied but description tweaked as key here is that VEML6030_ALS_SD is 1.
If it contained other bits then this change would be wrong.


> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index df2ba3078b91..5d4c2e35b987 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -149,8 +149,8 @@ static int veml6030_als_pwr_on(struct veml6030_data *data)
>  
>  static int veml6030_als_shut_down(struct veml6030_data *data)
>  {
> -	return regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
> -				 VEML6030_ALS_SD, 1);
> +	return regmap_set_bits(data->regmap, VEML6030_REG_ALS_CONF,
> +				 VEML6030_ALS_SD);
>  }
>  
>  static void veml6030_als_shut_down_action(void *data)
> 


