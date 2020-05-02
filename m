Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D931C278A
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 20:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgEBSZr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 14:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgEBSZq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 14:25:46 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6062072E;
        Sat,  2 May 2020 18:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588443945;
        bh=4xtD+5d23b9hmfE6WuotCTglkcLgeOgR/W0bd3CpJsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xtlIwTwcSxZ2EgS7xSg/Q5PPVOXa9WxzHRrJwuPRpIfkJs7YUzjJtwZQX8klHXHJM
         gCLcRV375bZ2X2VespTPsTsuup4GNMXlu3nYH4i/fSxCpBNEVaorB6v9hGbC0T/9wT
         Yl/vVSXZGFuzWRbGUdZXkbp8xYasq2bZuGZeC1LQ=
Date:   Sat, 2 May 2020 19:25:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad5933: rework probe to use devm_
 function variants
Message-ID: <20200502192542.63cc25a2@archlinux>
In-Reply-To: <20200428093128.60747-1-alexandru.ardelean@analog.com>
References: <20200428093128.60747-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 12:31:28 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change cleans up the driver's probe function to use only devm_
> function variants. This also gets rid of the remove function and moves the
> clock & regulator de-initializations to the 'ad5933_cleanup()' callback.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Basic rule of thumb. Whatever you register with devm_add_action_or_reset
should only cleanup one one thing done in the probe path.
There is almost always a race if you do more than one bit of cleanup
per such callback + it's harder to review as it fails the 'obviously correct
test'.

Jonathan

> ---
>  .../staging/iio/impedance-analyzer/ad5933.c   | 59 ++++++++-----------
>  1 file changed, 23 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index af0bcf95ee8a..06a6dcd7883b 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -602,11 +602,12 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
>  	.postdisable = ad5933_ring_postdisable,
>  };
>  
> -static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> +static int ad5933_register_ring_funcs_and_init(struct device *dev,
> +					       struct iio_dev *indio_dev)
>  {
>  	struct iio_buffer *buffer;
>  
> -	buffer = iio_kfifo_allocate();
> +	buffer = devm_iio_kfifo_allocate(dev);
>  	if (!buffer)
>  		return -ENOMEM;
>  
> @@ -676,6 +677,14 @@ static void ad5933_work(struct work_struct *work)
>  	}
>  }
>  
> +static void ad5933_cleanup(void *data)
> +{
> +	struct ad5933_state *st = data;
> +
> +	clk_disable_unprepare(st->mclk);
> +	regulator_disable(st->reg);

Please do two separate callbacks so that these can be handled
in the correct places.  I.e. you do something then immediately
register the handler to undo it.

Currently you can end up disabling a clock you haven't enabled
(which I am fairly sure will give you an error message).

> +}
> +
>  static int ad5933_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -703,23 +712,28 @@ static int ad5933_probe(struct i2c_client *client,
>  		dev_err(&client->dev, "Failed to enable specified VDD supply\n");
>  		return ret;
>  	}
> +
> +	ret = devm_add_action_or_reset(&client->dev, ad5933_cleanup, st);
> +	if (ret)
> +		return ret;
> +
>  	ret = regulator_get_voltage(st->reg);
>  
>  	if (ret < 0)
> -		goto error_disable_reg;
> +		return ret;
>  
>  	st->vref_mv = ret / 1000;
>  
>  	st->mclk = devm_clk_get(&client->dev, "mclk");
>  	if (IS_ERR(st->mclk) && PTR_ERR(st->mclk) != -ENOENT) {
>  		ret = PTR_ERR(st->mclk);
> -		goto error_disable_reg;
> +		return ret;
>  	}
>  
>  	if (!IS_ERR(st->mclk)) {
>  		ret = clk_prepare_enable(st->mclk);
>  		if (ret < 0)
> -			goto error_disable_reg;
> +			return ret;
>  		ext_clk_hz = clk_get_rate(st->mclk);
>  	}
>  
> @@ -742,41 +756,15 @@ static int ad5933_probe(struct i2c_client *client,
>  	indio_dev->channels = ad5933_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
>  
> -	ret = ad5933_register_ring_funcs_and_init(indio_dev);
> +	ret = ad5933_register_ring_funcs_and_init(&client->dev, indio_dev);
>  	if (ret)
> -		goto error_disable_mclk;
> +		return ret;
>  
>  	ret = ad5933_setup(st);
>  	if (ret)
> -		goto error_unreg_ring;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_unreg_ring;
> -
> -	return 0;
> -
> -error_unreg_ring:
> -	iio_kfifo_free(indio_dev->buffer);
> -error_disable_mclk:
> -	clk_disable_unprepare(st->mclk);
> -error_disable_reg:
> -	regulator_disable(st->reg);
> -
> -	return ret;
> -}
> -
> -static int ad5933_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ad5933_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_kfifo_free(indio_dev->buffer);
> -	regulator_disable(st->reg);
> -	clk_disable_unprepare(st->mclk);
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id ad5933_id[] = {
> @@ -801,7 +789,6 @@ static struct i2c_driver ad5933_driver = {
>  		.of_match_table = ad5933_of_match,
>  	},
>  	.probe = ad5933_probe,
> -	.remove = ad5933_remove,
>  	.id_table = ad5933_id,
>  };
>  module_i2c_driver(ad5933_driver);

