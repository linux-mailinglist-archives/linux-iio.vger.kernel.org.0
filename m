Return-Path: <linux-iio+bounces-23004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A9B2CB5C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6E2188315C
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AB30E0F1;
	Tue, 19 Aug 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDgHIzZE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3572206B8;
	Tue, 19 Aug 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625760; cv=none; b=HuZJTfjaLeslg9PQpwtAa6OzAWGk9RFaCMirxhZFGVWHLrpE8RJMYAUKimkWEo2SP0Rj8X84/WKpJ+DEMYkN60pdE360MGJaOa66YLKMUGIh55TlF78t7IkHq+nU01xfJ8o5uHXHBbZpRy1hOEznxLMN+XjX2z9vOVAjqxQiyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625760; c=relaxed/simple;
	bh=w1gebZhtcPh/rs7t+GaRcCMsH3OpcsQIB1iR3B6i4Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qt2SrNXakFtbc/s6hc6RCyLTJPBC3vdTVYSD5H7JiwEwokVnjD9V8pmxWwdUuXBWehr1/SH3aV88gXF2jDSZnbS8vAlXP0RzZQQS8gszU4RF/9xOjikvgcBy1FPuN/f4BOAwpJwYp33aSqAJ8LeeevW5eXkgI1DBKM7+VS87zrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDgHIzZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3904DC113D0;
	Tue, 19 Aug 2025 17:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755625758;
	bh=w1gebZhtcPh/rs7t+GaRcCMsH3OpcsQIB1iR3B6i4Ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GDgHIzZE3+efgVVhAHR3c8usuZ9PRROcH+7FKK8uuKejWUc/2wx4xSgofrF0agtz5
	 y/KitcOvPmhSb//6hU4xwuVFrLlbNxJ8PWwYptTjsGjKz5OR9wh5kWEs/q6abBqIE6
	 WXo0KsKajkw9zb6tPbuOp6oADwOiLOmoteg8/E6WEU0JG5Td3fWA3XFcaS1314Znnn
	 miTyjRgzlgSNxJopoDIA0mKrbaq/OQ9hlXuy8HSVGt/eHDb7eql4l0CEuyE/Q2F1DH
	 EA+8WR0Owa7Wzm3kdR4AnU+lFGL4AFGiSnw3gER2GkyAoKk6xGRKVyy74nyMAKjJ2B
	 AD4iyEjyVqeAw==
Date: Tue, 19 Aug 2025 18:49:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Waqar Hameed <waqar.hameed@axis.com>, Song Qiang
 <songqiang1304521@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 next] iio: proximity: vl53l0x-i2c: Fix error code in
 probe()
Message-ID: <20250819184908.324b0ca8@jic23-huawei>
In-Reply-To: <aKSSHTdJf5QoYiRx@stanley.mountain>
References: <aKSSHTdJf5QoYiRx@stanley.mountain>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 18:02:53 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Commit 65e8202f0322 ("iio: Remove error prints for
> devm_add_action_or_reset()") accidentally introduced a bug where we
> returned "ret" but the error code was stored in "error" if
> devm_add_action_or_reset() failed.  Using two variables to store error
> codes is unnecessary and confusing.  Delete the "error" variable and use
> "ret" everywhere instead.
> 
> Fixes: 65e8202f0322 ("iio: Remove error prints for devm_add_action_or_reset()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
Applied to the togreg branch of iio.git (where that patch is)
and very briefly pushed out as testing to get some build coverage for other
stuff I'm queuing this evening.

Thanks

Jonathan

> ---
> v2: Fix typos.  Add Andy's r-b tag.
> 
>  drivers/iio/proximity/vl53l0x-i2c.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 696340ec027a..ad3e46d47fa8 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -311,7 +311,6 @@ static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
> -	int error;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -344,13 +343,13 @@ static int vl53l0x_probe(struct i2c_client *client)
>  		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
>  				     "Cannot get reset GPIO\n");
>  
> -	error = vl53l0x_power_on(data);
> -	if (error)
> -		return dev_err_probe(&client->dev, error,
> +	ret = vl53l0x_power_on(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
>  				     "Failed to power on the chip\n");
>  
> -	error = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
> -	if (error)
> +	ret = devm_add_action_or_reset(&client->dev, vl53l0x_power_off, data);
> +	if (ret)
>  		return ret;
>  
>  	indio_dev->name = "vl53l0x";


