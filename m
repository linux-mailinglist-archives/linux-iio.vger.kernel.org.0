Return-Path: <linux-iio+bounces-17370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8BAA75B6D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0FC3A9AB3
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D831D8E07;
	Sun, 30 Mar 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZaDyiON"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A964A8F;
	Sun, 30 Mar 2025 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356077; cv=none; b=XeBalvxL3OpwfzThHZUQX8/IuVm+mis7RhvPEo/nWWGQQnXv6nCXeYYLjQmJigsKRhzvbq4qFL2m88DWbqO0uB6aVgm+kYH2ff7PNXY0OfiIzXwaSAxfYm0/8lQFLqBxbENlEsjpSj4JbvLUdvA3hiQ9xkHIwWs2LHSg00DcEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356077; c=relaxed/simple;
	bh=/f7cHgswFyevL77zH0J7n/IZxVHe5aFvptP81sWfbUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnf+rXtjxh1798u0KNv9vxuqznSepC0SeKQuYqjInXhaXNn79xmdF/OeoMipalRsNlhzyzhO3Ute1wUfu6euvAkqzSgXMvZIQsu7QxOIKibIK4XqnJr+wbx2EYmgu+e7CZxz5g2pK60CZtv6ZIsi9wdub5elXveabClEroNfJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZaDyiON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668D6C4CEDD;
	Sun, 30 Mar 2025 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743356076;
	bh=/f7cHgswFyevL77zH0J7n/IZxVHe5aFvptP81sWfbUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZaDyiONhUvs6eisrJKBQzPDhbQNncQcDkxB774A201WTkxWsKGgXSzpuJ8VpwrQt
	 w/wXknp32z3H5ZZqudHHKQtmrxL7MVArflug8alGFgD++kVQYICZyYV8wgQmQk+mTD
	 5pQRLidErVcdC6Nnt++QpfBCS30JG4iB/L5+JG3Fg1NNl6BO8E50LyLRYLiz+CBEFK
	 KvFYuuXMMRmh/WLVkD/9XAfMOc12qABBzyOLeDazdz4UaCz+KIYc15iUC4XOgJfq8M
	 s8AMCziDogMRApUydFK0WIPf+vR9PEwAoNDBVgZZbNpQf9ol50Y4WwDpK5d2bl2J64
	 7FBLiq5VGfHNA==
Date: Sun, 30 Mar 2025 18:34:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/13] iio: light: al3010: Move
 devm_add_action_or_reset back to _probe
Message-ID: <20250330183428.454f846d@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-9-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-9-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:48 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> In a preparation to the regmap transition.
I'm not following the reasoning for this patch.

The setup action being unwound is done in _init()
and if we happen to get an error on the write immediately after
where it currently is, we no longer power down the device.



> 
> Improve error handling using dev_err_probe().
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3010.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 8c004a9239aef246a8c6f6c3f4acd6b760ee8249..8098c92c9572befe92d00ef0785ded5e1a08d587 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -89,12 +89,6 @@ static int al3010_init(struct al3010_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = devm_add_action_or_reset(&data->client->dev,
> -				       al3010_set_pwr_off,
> -				       data);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
>  					FIELD_PREP(AL3010_GAIN_MASK,
>  						   AL3XXX_RANGE_3));
> @@ -195,6 +189,10 @@ static int al3010_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(dev, al3010_set_pwr_off, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add action\n");
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> 


