Return-Path: <linux-iio+bounces-19628-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED15AABB0C2
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92D63B729D
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920881BD9C9;
	Sun, 18 May 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMz/a3z+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF318A6C4;
	Sun, 18 May 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747584441; cv=none; b=UxEt1XOh6rlBdtrch9vtTr8lgvTnnPLMd25c7HDGqGQrBCs1iGfyKWR6SieTrm/MOrrmFvHZQx3IWCZQr/jQUt3VixClT+TJn/vDZxp+bFHc5eK4yM+Ze8iG/Frqve5DdaxlzDkJDMC7idDHnLI3VCgEEKpC3BGrb1scSjUCqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747584441; c=relaxed/simple;
	bh=/oOSxHRw8PWs3F/U7jFywmFA8Y7v3tlzOjGzXM8Jifg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQDb4IXKkJB4jyDT4GdilbKEqlBcD8OQ7OLW5KXLZq5dZ/3pfRzuRLb3QApjHnu9ZxRUG2nztH9Yt6vpQ0r9EmeCgWgVU8V4jGDeQBRd4YZIwMitIgv6aVfxHiqo8vJ5/J5G+CsfcBXeTx/+lehhQEsJZbzq/Bu7tGuQAMNlEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMz/a3z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206C2C4CEE7;
	Sun, 18 May 2025 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747584440;
	bh=/oOSxHRw8PWs3F/U7jFywmFA8Y7v3tlzOjGzXM8Jifg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OMz/a3z+zST2wJtUF/DbK0iO0x/HipJ8VTRuzaXlRrYgoMgRE0LDPoR/s/n4W1hYD
	 toQvvMdvXr0dd4fYp83V8qr6VZ5gQbhW+1jQ2sIIHDcuFnonFGkcGAp5cZO3bhBgO5
	 lyqQnLYhcJo5Pt4hknUB2moJMgnrL416LXPWMPdW33z8QVhG2OWxmug6XmhCRMVr1I
	 KNgAD+fXikQY585ayfOPd5HUqbpM++OVx7AHRNhUukdP9xfw+si7aKNHXquobOcT37
	 ZW19we+jW/o4FF7nZwbL7WypCWdIVhf0fuebuxDgnpWfQshsY+R+qyAqXl6uMMRQUk
	 gIWe4zv0zoKJg==
Date: Sun, 18 May 2025 17:07:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] iio: irsd200: Remove print of error code from
 dev_err_probe
Message-ID: <20250518170712.7005d494@jic23-huawei>
In-Reply-To: <83c5ed21654b1b98437247d0fef823237af641b4.1747415559.git.waqar.hameed@axis.com>
References: <83c5ed21654b1b98437247d0fef823237af641b4.1747415559.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 19:18:56 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Since `dev_err_probe()` already prints the error code, there is no need
> to additionally print it in the error message. Therefore, just remove
> them.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Applied. Thanks.

Note that I'm now queuing stuff up for 6.17 unless the 6.15 release is
delayed for some reason.  That means I'll only push out as testing and
will be rebasing on 6.16-rc1

Jonathan

> ---
>  drivers/iio/proximity/irsd200.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> index b0ffd3574013..011b506f4542 100644
> --- a/drivers/iio/proximity/irsd200.c
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -881,9 +881,8 @@ static int irsd200_probe(struct i2c_client *client)
>  
>  	ret = devm_regulator_get_enable(data->dev, "vdd");
>  	if (ret)
> -		return dev_err_probe(
> -			data->dev, ret,
> -			"Could not get and enable regulator (%d)\n", ret);
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not get and enable regulator\n");
>  
>  	ret = irsd200_setup(data);
>  	if (ret)
> @@ -901,17 +900,15 @@ static int irsd200_probe(struct i2c_client *client)
>  	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev, NULL,
>  					      irsd200_trigger_handler, NULL);
>  	if (ret)
> -		return dev_err_probe(
> -			data->dev, ret,
> -			"Could not setup iio triggered buffer (%d)\n", ret);
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not setup iio triggered buffer\n");
>  
>  	ret = devm_request_threaded_irq(data->dev, client->irq, NULL,
>  					irsd200_irq_thread,
>  					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>  					NULL, indio_dev);
>  	if (ret)
> -		return dev_err_probe(data->dev, ret,
> -				     "Could not request irq (%d)\n", ret);
> +		return dev_err_probe(data->dev, ret, "Could not request irq\n");
>  
>  	trigger = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
>  					 iio_device_id(indio_dev));
> @@ -925,14 +922,12 @@ static int irsd200_probe(struct i2c_client *client)
>  	ret = devm_iio_trigger_register(data->dev, trigger);
>  	if (ret)
>  		return dev_err_probe(data->dev, ret,
> -				     "Could not register iio trigger (%d)\n",
> -				     ret);
> +				     "Could not register iio trigger\n");
>  
>  	ret = devm_iio_device_register(data->dev, indio_dev);
>  	if (ret)
>  		return dev_err_probe(data->dev, ret,
> -				     "Could not register iio device (%d)\n",
> -				     ret);
> +				     "Could not register iio device\n");
>  
>  	return 0;
>  }
> 
> base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3


