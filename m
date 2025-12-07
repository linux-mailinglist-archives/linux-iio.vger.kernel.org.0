Return-Path: <linux-iio+bounces-26896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE2CAB70E
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC97130102A0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC7D26F29F;
	Sun,  7 Dec 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSCrv8kQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB1242D6C;
	Sun,  7 Dec 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123129; cv=none; b=RLTAkCEmTJjeszRRSgPDP9wS9bkHvce26u4jK9yHyShth+gTC6kK/iJ+QIHVOQLxZ7m1VEtKgCdheTFNQVJa7SstHo2JB5IDas93gckOi7q2/25rOKpbX7CuOs3qKDksuB9DpXjoryoYQBLPS5YdzPzGj5AjzNsZsCM7nHeGeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123129; c=relaxed/simple;
	bh=WZLbksTy0pFDHVLlkzWAsSseWpLGYXKBbHAr/H5sJdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBGS5XhSM2VECNzLkFZz94rkC4EJRv4uKhoJsVBWac0NalFadcOFiOvCsQ1ovkLtpUE6QeY9lM0WizmfMoFsUvDAAfNC7g+0PPR7hOCfLaGyNQrsPXo4dMGhbGlS+rdUQhCqOHZjFgBPLZbR0a8Fe+DS13IML7zU+sb+kHESbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSCrv8kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FB4C4CEFB;
	Sun,  7 Dec 2025 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765123129;
	bh=WZLbksTy0pFDHVLlkzWAsSseWpLGYXKBbHAr/H5sJdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YSCrv8kQHcjS1DXXcwHALFwFhrpJzfsZc23wA4cHmyGiPbnbl3rPkUIck1jaf+ap1
	 mrCftClPUcHPgsnfomOKsgOAkSl/fXAp4u9hyVl6C0RUJuLwyCfunVrSujG0f7+L6K
	 CTEr8DiMPC842AHr0Z0cPuzY0YPIiGo36GpZ7oL7YmAQe07K105eu46yXiplD57Iw5
	 GS552njp0XxpdGSUV9G5hroumTjNGT1sva6a9DdmDdZ7NDVGwDMLv71MA2IxLpNXml
	 Mw8cbjK/mnn7+t/sq63Q6bu6i96WyoKoYtL+lpwxH0Hq/F4pVwWMuj1uH61+umWO0d
	 RF68jfYmekcvg==
Date: Sun, 7 Dec 2025 15:58:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 heiko@sntech.de, neil.armstrong@linaro.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <20251207155838.5b41324e@jic23-huawei>
In-Reply-To: <20251130153712.6792-5-raskar.shree97@gmail.com>
References: <20251130153712.6792-1-raskar.shree97@gmail.com>
	<20251130153712.6792-5-raskar.shree97@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Shrikant,

I'll try not to replicate too much stuff from Andy's review.

> +static irqreturn_t rfd77402_interrupt_handler(int irq, void *dev_id)

Why dev_id?  Seems unrelated to what it is which is data about the device.

> +{
> +	struct rfd77402_data *data = dev_id;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
> +	/* Check if the interrupt is from our device */
> +	if (!(ret & RFD77402_ICSR_RESULT))
> +		return IRQ_NONE;
> +
> +	/* Signal completion of measurement */
> +	complete(&data->completion);
> +	return IRQ_HANDLED;
> +}

> -static int rfd77402_measure(struct i2c_client *client)
> +static int rfd77402_measure(struct rfd77402_data *data)
>  {
> +	struct i2c_client *client = data->client;
>  	int ret;
> +

Blank line should have been in patch 3.  I just replied to that
having missed it whilst reading that one.


>  	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
>  				 RFD77402_STATUS_MCPU_ON);

> @@ -195,8 +247,25 @@ static const struct iio_info rfd77402_info = {
>  	.read_raw = rfd77402_read_raw,
>  };
>  
> +static int rfd77402_config_irq(struct i2c_client *client, u8 csr, u8 ier)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR, csr);
> +	if (ret < 0)

I would use
	if (ret)
here to make the next change more consistent looking.

> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, RFD77402_IER, ier);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
	return i2c_smbus_write_byte_data();

is fine as it is documented as never returning anything other than negative
or 0.

> +}
> +
>  static int rfd77402_init(struct i2c_client *client)
>  {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct rfd77402_data *data = iio_priv(indio_dev);
>  	int ret, i;
>  
>  	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
> @@ -204,9 +273,25 @@ static int rfd77402_init(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* configure INT pad as push-pull, active low */
> -	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
> -					RFD77402_ICSR_INT_MODE);
> +	if (data->irq_en) {
> +	/*
> +	 * Enable interrupt mode:
> +	 * - Configure ICSR for auto-clear on read, push-pull output and falling edge
> +	 * - Enable "result ready" interrupt in IER
> +	 */

Indent should match code.  Will require a bit more wrapping.


> +		ret = rfd77402_config_irq(client,
> +					  RFD77402_ICSR_CLR_CFG |
> +					  RFD77402_ICSR_INT_MODE,
> +					  RFD77402_IER_RESULT);
> +	} else {
> +	/*
> +	 * Disable all interrupts:
> +	 * - Clear ICSR configuration
> +	 * - Disable all interrupt in IER
> +	 */
As above.

> +		ret = rfd77402_config_irq(client, 0, 0);
> +	}
> +
>  	if (ret < 0)
>  		return ret;
>  
> @@ -283,6 +368,31 @@ static int rfd77402_probe(struct i2c_client *client)
>  	data = iio_priv(indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
> +	init_completion(&data->completion);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data->irq_en = false;
> +	if (client->irq > 0) {
> +		/* interrupt mode */

Kind of obvious comment. I'd drop it.

> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, rfd77402_interrupt_handler,
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

Repeating Andy here the direction is a firmware problem.
We have some historical drivers doing this which we now can't
fix as we don't know if boards need it.  But no new cases should
be added.

> +						"rfd77402", data);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"Failed to request IRQ %d: %d\n",
> +				client->irq, ret);
> +			return ret;
> +		}
> +
> +		data->irq_en = true;
> +		dev_info(&client->dev, "Using interrupt mode\n");

dev_dbg()

> +
> +	} else {
> +		/* polling mode */
> +		dev_info(&client->dev, "No interrupt specified, using polling mode\n");
Easy to tell from userspace with cat /proc/interrupts so no need for such a noisy print.
dev_dbg()
> +	}
>  
>  	indio_dev->info = &rfd77402_info;
>  	indio_dev->channels = rfd77402_channels;


