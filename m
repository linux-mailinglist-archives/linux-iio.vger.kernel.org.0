Return-Path: <linux-iio+bounces-27604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB45FD0EEAC
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 169BE30049CD
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3F3382C9;
	Sun, 11 Jan 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtLRBp5d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314A304BDA;
	Sun, 11 Jan 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768135759; cv=none; b=usWR6XQNswgUuGzWT64np1XhwqaPmlMAaG+4mmjH3cytSaj1G1k3iL4nAJgS03yQjrQsm6BFAsDmIGkPhpmjBPjMvdvO97nHO/WEeTg5pV0xQoI3DR2QzJBNf8KFEbfx5rMIOaAor5PhkKhiHSDhG2/FY7il3xXOyEbWogHRpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768135759; c=relaxed/simple;
	bh=F8n+Sq20oDOM/6ipBIJy14ztNgcOqSj+bfJssPOGVT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQHRzPzaSz7O1vwy7i2K8LJb+zqE676NrSyB9DMUODgi5NZI+6rdccDKJeSmcdr7LeyocAWHUkfziUL19mi4m4wdjVe7fEfZIVC9+hPBaZzeg0rVO+jqGQ0TfBx7C777lo4J3ixzN1kM3VfpUun1NuhjhDdVj46GHAlzjYFdZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtLRBp5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A0C4CEF7;
	Sun, 11 Jan 2026 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768135759;
	bh=F8n+Sq20oDOM/6ipBIJy14ztNgcOqSj+bfJssPOGVT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UtLRBp5dS2EznPIbYS45wiez/gJjXplV6QuqIvYCNBH2cT3a00WzrPMa682vmlhNF
	 o4NW1hKGkjNRaG/lTNc3CWeZLCa60imRvky9MxV2ccxUzLYgM+AfRmYndWBvRlQKtz
	 c75XTTl0nnX8DVdWvP3W1vCp2pd6uKhtcURCDsyj1os3FhYXQfqq1WNVXmueuqAKkC
	 2WZjB5uMmFBy9rLTM71LdQ0JeGgT4Rpxc1bijbL1kE6+KArr2bUzeNo8ZV6iZ0RbYP
	 8PBCZRLl61N+EeTO8iT3WmB65UhfoPG8Z7+Ljua2sd5DPp+nyq8dtQuy37nURAPpKb
	 NItwQNvrGYchw==
Date: Sun, 11 Jan 2026 12:49:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar via B4 Relay
 <devnull+raskar.shree97.gmail.com@kernel.org>
Cc: raskar.shree97@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <20260111124908.1adec88b@jic23-huawei>
In-Reply-To: <20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
	<20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Jan 2026 21:47:41 +0530
Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org> wrote:

> From: Shrikant Raskar <raskar.shree97@gmail.com>
> 
> Add interrupt handling support to enable event-driven data acquisition
> instead of continuous polling. This improves responsiveness, reduces
> CPU overhead, and supports low-power operation by allowing the system
> to remain idle until an interrupt occurs.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> ---
Hi Shrikant,

A few additional (some may overlap with Andy's) comments from me.
Thanks,

Jonathan

> +
> +static int rfd77402_wait_for_irq(struct rfd77402_data *data)
> +{
> +	int ret;

Blank line here.  Pretty much always the case are declarations
in kernel code.

> +	/* As per datasheet, single measurement flow takes 100ms */
> +	ret = wait_for_completion_timeout(&data->completion,
> +					  msecs_to_jiffies(100));
> +	if (ret == 0)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}

>  static int rfd77402_init(struct i2c_client *client)
>  {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct rfd77402_data *data = iio_priv(indio_dev);
>  	int ret, i;
>  
>  	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
> @@ -193,10 +263,24 @@ static int rfd77402_init(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* configure INT pad as push-pull, active low */
> -	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
> -					RFD77402_ICSR_INT_MODE);
> -	if (ret < 0)
> +	if (data->irq_en) {
> +		/* Enable interrupt mode:
		/*
		 * Enable ...

is the comment syntax used in IIO.

> +		 * - Configure ICSR for auto-clear on read and
> +		 *   push-pull output
> +		 * - Enable "result ready" interrupt in IER
> +		 */
> +		ret = rfd77402_config_irq(client,
> +					  RFD77402_ICSR_CLR_CFG |
> +					  RFD77402_ICSR_INT_MODE,
> +					  RFD77402_IER_RESULT);
> +	} else {
> +		/* Disable all interrupts:

As above. Match local style for comments (which is not this!)
Oddly that was correct in v3 (indent is now fixed though)


> +		 * - Clear ICSR configuration
> +		 * - Disable all interrupts in IER
> +		 */
> +		ret = rfd77402_config_irq(client, 0, 0);
> +	}
> +	if (ret)
>  		return ret;
>  
>  	/* I2C configuration */
> @@ -271,7 +355,27 @@ static int rfd77402_probe(struct i2c_client *client)
>  
>  	data = iio_priv(indio_dev);
>  	data->client = client;
> -	mutex_init(&data->lock);
> +	ret = devm_mutex_init(&client->dev, &data->lock);
> +	if (ret)
> +		return ret;

I'm not that fussy about it given it's so minor but this is an unrelated
changes so in ideal world would be a separate patch.

> +
> +	init_completion(&data->completion);
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data->irq_en = false;

Not strictly necessary as it's kind of the obvious default and we
kzalloc data anyway so it's already false.

> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, rfd77402_interrupt_handler,
> +						IRQF_ONESHOT,
> +						"rfd77402", data);
> +		if (ret)
> +			return ret;
> +
> +		data->irq_en = true;
> +		dev_dbg(&client->dev, "Using interrupt mode\n");
> +	} else {
> +		dev_dbg(&client->dev, "Using polling mode\n");
> +	}
>  
>  	indio_dev->info = &rfd77402_info;
>  	indio_dev->channels = rfd77402_channels;
> 


