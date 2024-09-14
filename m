Return-Path: <linux-iio+bounces-9558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE79197914C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5CAAB213FE
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60581CF7C4;
	Sat, 14 Sep 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K684u+ya"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F71CF2B6;
	Sat, 14 Sep 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323339; cv=none; b=BiCrCOQZzjm5pqJPeGBc668Jl251stE0OmNiKZnFBHjggVt0R3wDgXWke2/HRWADxi+MtAmRnSuDtExHbhNj5zwE3CnAXm7X8A3R6K9Q0G83Iq9NOFJnnhMb3G44HSl/SWMvgZbdhi6wumUjXqsqawOCFflyL71dtxOVHUy4r/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323339; c=relaxed/simple;
	bh=TZQfglloerJOXo5tlrCo8RGE7/fkrYq1ywpoq68zLys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWHtoj5Ayq7/NAmz/4ZYPc6ww2XJsrSbarwGAevF4cmWKN6m/RVZtdXLXtwX3Q1UhaoW5INHuFEdUDZ85xnG5XADvUAqFc0ZFP6LoY1CK1DBAEhe4BoMWJK3gSr59uPPSgoK2vxw1ta4huiKP+ohDsMzYd+SneCjUHLtgcO1CNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K684u+ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C6CC4CEC0;
	Sat, 14 Sep 2024 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726323339;
	bh=TZQfglloerJOXo5tlrCo8RGE7/fkrYq1ywpoq68zLys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K684u+ya66JO7pskVP73Gz0C6vhw0OtXp6ohtx2RjmQoX2Bp6yEew1POn+/95nIuN
	 8M2Xb0rcUgcv+a/HKPdStxU/nks1VCIzivHYvA5B/a2eVhUHRqRBruQQKWZ97vCzH4
	 U+ddjy+LLoZTA69Wj7zJvybxcHs3oXs4eyMop7mhfUbYRaiHyzx3+W2rQ/PRi2lcaG
	 qlUsE9zPJAxSQP4DpGXAwoWrO4m2/aQRQ5Vg2Qv9uA0MpMvYc7Po4ZlI7nvRS1A2p2
	 oAQELDDb577+pR9QQWHcBD7Z/4sIx52e1d90uvcUkNJKapIQIEL+CRbkXvPO2cTmZa
	 o5a4XLJ37mjag==
Date: Sat, 14 Sep 2024 15:15:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, David Heidelberg <david@ixit.cz>,
 Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: al3010: Fix an error handling path in
 al3010_probe()
Message-ID: <20240914151532.1c9580e2@jic23-huawei>
In-Reply-To: <ee5d10a2dd2b70f29772d5df33774d3974a80f30.1725993353.git.christophe.jaillet@wanadoo.fr>
References: <ee5d10a2dd2b70f29772d5df33774d3974a80f30.1725993353.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 20:36:06 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If i2c_smbus_write_byte_data() fails in al3010_init(),
> al3010_set_pwr(false) is not called.
> 
> In order to avoid such a situation, move the devm_add_action_or_reset()
> witch calls al3010_set_pwr(false) right after a successful
> al3010_set_pwr(true).
> 
> Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Looks correct to me, but given the upshot of the bug is that in
a case where an bus access fails we don't power down (which requires a bus
access). It's unlikely to happen in practice and outcome is device
remains powered up when it shouldn't be which isn't too bad an outcome.

Hence I'll queue this up the slow way.
Applied to the testing branch of iio.git for 0-day to play with it before
I rebase on rc1 once available.

Thanks,

Jonathan

> ---
> Compile tested only.
> This patch is speculative, review with care
> ---
>  drivers/iio/light/al3010.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 53569587ccb7..7cbb8b203300 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -87,7 +87,12 @@ static int al3010_init(struct al3010_data *data)
>  	int ret;
>  
>  	ret = al3010_set_pwr(data->client, true);
> +	if (ret < 0)
> +		return ret;
>  
> +	ret = devm_add_action_or_reset(&data->client->dev,
> +				       al3010_set_pwr_off,
> +				       data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -190,12 +195,6 @@ static int al3010_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	ret = devm_add_action_or_reset(&client->dev,
> -					al3010_set_pwr_off,
> -					data);
> -	if (ret < 0)
> -		return ret;
> -
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  


