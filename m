Return-Path: <linux-iio+bounces-17604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC17A7A90A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8993B8146
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9B252919;
	Thu,  3 Apr 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="f0Bkz4rX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20C252906;
	Thu,  3 Apr 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703383; cv=none; b=IGf0DWjBpKu3bkUvsODKeG0UeXiy0s61OCHRhDHT+kXt6aOi8QCBgIRdI7ibqjE4a9OCCs6oEQh83vTvX+VYuWURkNzgGqfU52EVXofIFbdqR3HOsS8xhqzrjl34ITJpGo4df1KtLikjpDbPi+MGol4XBU2OpleASGJnTdgcfpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703383; c=relaxed/simple;
	bh=EZ/3QHprMgvIbJAI0Y0yjBJviEcXYKgybQ1mJdA3yhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKexa18HQaSts9Ulkluht6PnG2/8QdHPfK7C+NLmUIqHYdZBjGXbFOd5mxMjeWsSy6GKxTf6MJ3eSfTglvVDMUhFBTXvFMlbUrmijirVm/volas8EXX0Mv/MPAJl09K36YR7zyDYl6YZyyhOcCyUc4gj31dfnqY5n9vZBosZeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=f0Bkz4rX; arc=none smtp.client-ip=80.12.242.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 0OssuZpVk0cMk0OswuDZfg; Thu, 03 Apr 2025 20:01:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743703310;
	bh=2ieRkX52RZnkiUxos+tLtIvh5wxLHTwYQ58rulZe6Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=f0Bkz4rXfHt4jwzmXxEeB/ra0Hix9/iQPxRwd222i2NpjCp/5Df/kIAkXwGWlouZu
	 FZR0Dwip4wIrq8G71UTWTGbHSMhBtmjrMYmEhMgg1B72ttSkyak9SZvXAf55SoIT2k
	 FoFFi/LY5ZUF17mxJJrLfDjtRUR4ARVK5so8lJndTyQZ7bVjvPzCz+O/i6fW6RyKjy
	 AaAtxu7q6teffMI6/rJeMOrGmph+0im8+Yr1duLpgYJuX/uwEgWqfxA5L4isREwZgb
	 cG1ajxcYulRl9NYJwYX03bhDa7ir6LmZ5la4ujA9l0H1wHF5begWnoRQ0BkgMYzGh5
	 uyTVUpyXOZj0w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 03 Apr 2025 20:01:50 +0200
X-ME-IP: 90.11.132.44
Message-ID: <eda0d691-93ac-4833-8978-6d39730c4db2@wanadoo.fr>
Date: Thu, 3 Apr 2025 20:01:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] iio: light: al3010: Improve al3010_init error
 handling with dev_err_probe()
To: devnull+david.ixit.cz@kernel.org
Cc: clamor95@gmail.com, david@ixit.cz, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 longnoserob@gmail.com
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
 <20250402-al3010-iio-regmap-v4-1-d189bea87261@ixit.cz>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250402-al3010-iio-regmap-v4-1-d189bea87261@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/04/2025 à 21:33, David Heidelberg via B4 Relay a écrit :
> From: David Heidelberg <david-W22tF5X+A20@public.gmane.org>
> 
> Minor code simplifications and improved error reporting.
> 
> Signed-off-by: David Heidelberg <david-W22tF5X+A20@public.gmane.org>
> ---
>   drivers/iio/light/al3010.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 8c004a9239aef246a8c6f6c3f4acd6b760ee8249..34a29a51c5f9e8aa143d3ba195b79a19793e4f88 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -92,8 +92,8 @@ static int al3010_init(struct al3010_data *data)
>   	ret = devm_add_action_or_reset(&data->client->dev,
>   				       al3010_set_pwr_off,
>   				       data);
> -	if (ret < 0)
> -		return ret;
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "failed to add action\n");

Not sure this new message is needed.

The error is unlikely, and kmalloc(), which is used in is 
devm_add_action_or_reset(), is already verbose.

CJ

>   
>   	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
>   					FIELD_PREP(AL3010_GAIN_MASK,
> @@ -190,10 +190,8 @@ static int al3010_probe(struct i2c_client *client)
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   
>   	ret = al3010_init(data);
> -	if (ret < 0) {
> -		dev_err(dev, "al3010 chip init failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init ALS\n");
>   
>   	return devm_iio_device_register(dev, indio_dev);
>   }
> 


