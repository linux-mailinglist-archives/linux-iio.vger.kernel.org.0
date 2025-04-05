Return-Path: <linux-iio+bounces-17646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93656A7CA68
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9903D7A8268
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0B18D65F;
	Sat,  5 Apr 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6i/FRyt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CE189F57;
	Sat,  5 Apr 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743872389; cv=none; b=Ehb+Sn/hJETij/4gIOfJgdiVQNt5YBvOUchqRcSwNYObL4u8ICfTqjNVm6n/VB66dX9884ZpxI1HlPwvp/jJKexdHr2Lyze19FZY1bkVk+nzcLfUUGOrgHPyj51/BBhVlyY/mr+LpECiH9VoWiFtTS1I+/izUoX/ThJ3EDQydFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743872389; c=relaxed/simple;
	bh=8Z+qB0+ZAEPeA7z/Q+xgsiWWJz8q0lFh0xPu5FcI6RA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew8XSFgumy/md0uJyqeiQ7rs94mMMYddNH7u8YKcHGma01K4tsqT5f8MHzJR5Q2sPO/j6tNDjBBrpjffnWsfl/dN83vHivojMT1i2ryT8F7qaMkSgdwAQzZjUwDzsEU6HRYIHh0lkT5RMaF77Kq7WfvaxziBa+XirXwid9C0Nno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6i/FRyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545B5C4CEE4;
	Sat,  5 Apr 2025 16:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743872389;
	bh=8Z+qB0+ZAEPeA7z/Q+xgsiWWJz8q0lFh0xPu5FcI6RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P6i/FRyt00/YSuyvUkN7hweN9l4kKVsxwcV3wvoAPEzvkm2CxM/CzL9lpQE6vaWCy
	 upCPu8Bj0NTFYurPMrCfZjw7Y2MpXukafU1CYXiB9j8ht7suBSeFyMBu6IoTbXgoCJ
	 GHkCNyrqiAzQhDOipA1H/ILnTNuc6nqe7or0NECEqKZUhsjes81REWC4n4TFnVAbZQ
	 ro6/NoGdrsWZWTr4lBG3/rLqD88wPxkjtWcIZGLbsiuTglb9DftD4j9qdFfg6eHHGB
	 Lpy3HTK5pgqFnV5UDdxNSjDq0KZC/+f2MQQLAAgePMUURju0Su+mvj3eOR6z9/KnxN
	 z94K+lHJTvSPg==
Date: Sat, 5 Apr 2025 17:59:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: light: al3320a: Fix an error handling path
 in al3320a_probe()
Message-ID: <20250405175942.6264673f@jic23-huawei>
In-Reply-To: <20250402-al3010-iio-regmap-v4-3-d189bea87261@ixit.cz>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
	<20250402-al3010-iio-regmap-v4-3-d189bea87261@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Apr 2025 21:33:26 +0200
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> If regmap_write() fails in al3320a_init(), al3320a_set_pwr_off is
> not called.
> 
> In order to avoid such a situation, move the devm_add_action_or_reset()
> which calls al3320a_set_pwr_off right after a successful
> al3320a_set_pwr_on.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3320a.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 1b2b0359ed5dad5e00d2fe584f8f3495c13c997e..1fa693d54ae2a6e5ead3a9c7ac7018afeba9b760 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -101,6 +101,12 @@ static int al3320a_init(struct al3320a_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&data->client->dev,
> +				       al3320a_set_pwr_off,
> +				       data);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "failed to add action\n");
This one I'll drop whilst applying given we are adding a message with little
purpose (or chance of occurring) rather than moving one as we were in patch 2.

I've applied up to this patch with those tweaks. I might well pick up the others but
not looked closely at them yet!
> +
>  	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
>  					FIELD_PREP(AL3320A_GAIN_MASK,
>  						   AL3320A_RANGE_3));
> @@ -211,10 +217,6 @@ static int al3320a_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	ret = devm_add_action_or_reset(dev, al3320a_set_pwr_off, data);
> -	if (ret < 0)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> 


