Return-Path: <linux-iio+bounces-17645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20503A7CA63
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB31C3B395E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9669B18C03F;
	Sat,  5 Apr 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsX0eCu/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146527456;
	Sat,  5 Apr 2025 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743872281; cv=none; b=DsK62bYbGPFUhH7x3AtIcy5oNVyzCr92oPad/SC8Af461ZUrscq9UlePr0H4267uY8h6ApRPtSpegG2X3dGgvDDzq7MANFXWvyn4y3FRJNbp8JVXYMcvpDMOOVKx84dtVQd0FYOtedJkBJrLSmC4KFTFpa3x+E868hKeOBbbBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743872281; c=relaxed/simple;
	bh=aBT+7PFrGC/kKA8DXJUdHAINSOVJOoDuou0OXI3rA3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syeQeolvt6q9iKPcMnugBv89CNyZpG7e+HSaeRMGzaH2V5+dLIbAgpkYBhQ/M0je1fJaxh1yxR8la6jpKvIBOzGWsHSu0GHvJ8L7yTYKFxkPgXrQEq2WMdBl5guHhZ0ugNLD1FvL6Jk+X/8YwxCgNUYnBNj8Nkik3BC2EeoZUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsX0eCu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1768C4CEE4;
	Sat,  5 Apr 2025 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743872280;
	bh=aBT+7PFrGC/kKA8DXJUdHAINSOVJOoDuou0OXI3rA3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lsX0eCu/IgotzswIka5vBTlSqSYJuOWJ3KUWO251NUmuziMECG0c/1UVCTkjfouqX
	 3HigR7luvMeHzVj7sAUxCNfS4MPzEA4D7dmao2bFGDYeDv2byN0m4rlsJkVkWafS9T
	 HtpyGWMasL8n5u1wlgXnWXAfNA5wFrS1Zn+G6J8UNS8ie++RVc41a882zmG6DFSuDO
	 OVhtjlVueZmZhyQMmfcIps5cv8Yza89GrqG5YCYxPT4gcPAsmgXpTStocNb1A86rbw
	 I/axQYbtstYQrE4nr/e10H736zw+WJY0vZhSt0ybgaPK//6AyB02Lw9rB4jTmVtKM8
	 dd9mU7zKg3Efw==
Date: Sat, 5 Apr 2025 17:57:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: light: al3000a: Fix an error handling path
 in al3000a_probe()
Message-ID: <20250405175755.4f5d57e3@jic23-huawei>
In-Reply-To: <20250402-al3010-iio-regmap-v4-2-d189bea87261@ixit.cz>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
	<20250402-al3010-iio-regmap-v4-2-d189bea87261@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Apr 2025 21:33:25 +0200
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> If regmap_write() fails in al3000a_init(), al3000a_set_pwr_off is
> not called.
> 
> In order to avoid such a situation, move the devm_add_action_or_reset()
> which calls al3000a_set_pwr_off right after a successful
> al3000a_set_pwr_on.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3000a.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
> index e2fbb1270040f43d9f0a97838861818a8eaef813..6d5115b2a06c5acce18d831b9c41d3d5121fba12 100644
> --- a/drivers/iio/light/al3000a.c
> +++ b/drivers/iio/light/al3000a.c
> @@ -85,12 +85,17 @@ static void al3000a_set_pwr_off(void *_data)
>  
>  static int al3000a_init(struct al3000a_data *data)
>  {
> +	struct device *dev = regmap_get_device(data->regmap);
>  	int ret;
>  
>  	ret = al3000a_set_pwr_on(data);
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add action\n");
Whilst this is the same thing Christophe pointed out in patch 1, as it is simple code
movement I think it is fine to leave it here 'for now'. 

It probably makes sense to scrub IIO in general for cases of this if we decide
the general rule is no error messages for devm_add_action* failures (given they
are only possible if memory allocation fails).

Jonathan

> +
>  	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
>  	if (ret)
>  		return ret;
> @@ -157,10 +162,6 @@ static int al3000a_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to init ALS\n");
>  
> -	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "failed to add action\n");
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> 


