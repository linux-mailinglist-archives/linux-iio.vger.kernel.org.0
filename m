Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC4167D1D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 13:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgBUMJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 07:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgBUMJb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 07:09:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBE9207FD;
        Fri, 21 Feb 2020 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582286971;
        bh=rCCt3hQJXbQ3ymL3KjHXQb8VsrsS0ocTxzLO94BzgC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dndglOlu81JK+OfGO5maXEAQ8JgiNn/iWQ6fHVDgnQp0t1hauKigKnmGapyydPVch
         JOd4u3L6Bawupx5awsfhGlw+1c3MmeUzZeI2IHHXxrS74Lu9tVrjMW4y2zMAF77Nvk
         24KWgwii9Sp0ij6LnIpyOTRfIBk5q+Enq9yrlgsY=
Date:   Fri, 21 Feb 2020 12:09:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 1/3] iio: chemical: atlas-sensor: allow probe without
 interrupt line
Message-ID: <20200221120927.4f7db7db@archlinux>
In-Reply-To: <20200218034239.135619-2-matt.ranostay@konsulko.com>
References: <20200218034239.135619-1-matt.ranostay@konsulko.com>
        <20200218034239.135619-2-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Feb 2020 19:42:37 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Sensors don't actually need a interrupt line to give valid readings,
> and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
> the required check for interrupt, and continue along in the probe
> function.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Hmm. I'll apply this version, but I'm still not really happy with the logic.
That interrupt enable should occur in the trigger related callbacks (as it's
to do with the trigger) rather than in the buffer ones.  The boundary between
the two is blurred when a device is only used with it's own trigger so this
only becomes an issue once we have external triggers being supported.

This is a more minimal change so perhaps you can look at whether the logic
can be tidied up later.  

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/atlas-sensor.c | 33 ++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 2f0a6fed2589..d95818b74770 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -76,6 +76,7 @@ struct atlas_data {
>  	struct atlas_device *chip;
>  	struct regmap *regmap;
>  	struct irq_work work;
> +	unsigned int interrupt_enabled;
>  
>  	__be32 buffer[6]; /* 96-bit data + 32-bit pad + 64-bit timestamp */
>  };
> @@ -304,6 +305,9 @@ static int atlas_set_powermode(struct atlas_data *data, int on)
>  
>  static int atlas_set_interrupt(struct atlas_data *data, bool state)
>  {
> +	if (!data->interrupt_enabled)
> +		return 0;
> +
>  	return regmap_update_bits(data->regmap, ATLAS_REG_INT_CONTROL,
>  				  ATLAS_REG_INT_CONTROL_EN,
>  				  state ? ATLAS_REG_INT_CONTROL_EN : 0);
> @@ -572,11 +576,6 @@ static int atlas_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	if (client->irq <= 0) {
> -		dev_err(&client->dev, "no valid irq defined\n");
> -		return -EINVAL;
> -	}
> -
>  	ret = chip->calibration(data);
>  	if (ret)
>  		return ret;
> @@ -596,16 +595,20 @@ static int atlas_probe(struct i2c_client *client,
>  
>  	init_irq_work(&data->work, atlas_work_handler);
>  
> -	/* interrupt pin toggles on new conversion */
> -	ret = devm_request_threaded_irq(&client->dev, client->irq,
> -					NULL, atlas_interrupt_handler,
> -					IRQF_TRIGGER_RISING |
> -					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -					"atlas_irq",
> -					indio_dev);
> -	if (ret) {
> -		dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
> -		goto unregister_buffer;
> +	if (client->irq > 0) {
> +		/* interrupt pin toggles on new conversion */
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +				NULL, atlas_interrupt_handler,
> +				IRQF_TRIGGER_RISING |
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				"atlas_irq",
> +				indio_dev);
> +
> +		if (ret)
> +			dev_warn(&client->dev,
> +				"request irq (%d) failed\n", client->irq);
> +		else
> +			data->interrupt_enabled = 1;
>  	}
>  
>  	ret = atlas_set_powermode(data, 1);

