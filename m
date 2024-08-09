Return-Path: <linux-iio+bounces-8338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3E94CA59
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 08:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868381F2156A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 06:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1616CD2F;
	Fri,  9 Aug 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eksbxkDY"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-208.smtpout.orange.fr [193.252.23.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5343D6D;
	Fri,  9 Aug 2024 06:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723184343; cv=none; b=gzeRNZIi4d35ZrrexcPzZqFZHafHostYFuUQeQJPCGf2RMZ1c/8YcafFcHvas5ZGHxEH2XzCgp/+Rd9IeO8s3HKu+90a3jGg29KdLlvEE39Y+WIqCDCdu1ksLwxUIrRhxEnZLzMvAWFlwlti2TB88M0zRnrbVYgbDIHZNWiTRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723184343; c=relaxed/simple;
	bh=wFoYMwyfsFTzjE325TCHZbNnkEXgbRJO28L/36Ev5zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG9Qa9111SmslX1xg2Ai9dqePiq0WPHj2utHRFN6/eIrSPGNh/G4qhySyrTsY5BeKxMC4bPP7MEC4yYeMsYmogFWvi2jWu9HxUKf/dSRkqOQ92BJRCM2mPjBUEAbN2yvf4HPSbjFUXiAb68tKLeR7nIkmnaOd7pIGuV7dadOPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eksbxkDY; arc=none smtp.client-ip=193.252.23.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id cIxbs8sMKj4pfcIxbs3hT3; Fri, 09 Aug 2024 08:18:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723184331;
	bh=tHOdZOhWw2F2fHwgKKW/WSEMYXdMyQeIMRR0zyj8gbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eksbxkDY+7P8EMndA30bJMiQtUobex1UZXYR3XXqfBVkYDjvNxYauvMzygGsNH47c
	 l9Rlm3L/o7lnEdMndy6uJQug/yD1MTyAHwpiPHT+j9vi5lz67EkARx7DMoIilE7rF7
	 MfHtmNZy6SISmPAS+aXADseTs/wuwpLSzzTh4HAAH74C8VYjRuLDGC6eF9JDyPcCbH
	 B4ho6yysjPIcALEvKbfDi7XBEygamhgjoCj5WDNdW77ujbNLkykQ8W1kfj+6CrySAq
	 ysvas7Q5FG98rXp79UMrG+tHU76U1r8bm6YBOaEUZYnlznEYTGRXhmQIUml9mAITEe
	 XNxLriSbm2rsw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 09 Aug 2024 08:18:51 +0200
X-ME-IP: 90.11.132.44
Message-ID: <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
Date: Fri, 9 Aug 2024 08:18:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jic23@kernel.org, kernel-janitors@vger.kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 matteomartelli3@gmail.com
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/08/2024 à 21:28, Dan Carpenter a écrit :
> This error path was intended to return, and not just print an error.  The
> current code will lead to an error pointer dereference.
> 
> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/iio/adc/pac1921.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index d04c6685d780..8200a47bdf21 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *client)
>   
>   	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
>   	if (IS_ERR(priv->regmap))
> -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> -			      "Cannot initialize register map\n");
> +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),

The (int) is unusual.

CJ

> +				     "Cannot initialize register map\n");
>   
>   	devm_mutex_init(dev, &priv->lock);
>   


