Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE32225D5B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 13:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGTLZc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 07:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgGTLZb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jul 2020 07:25:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 193D222B4E;
        Mon, 20 Jul 2020 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595244331;
        bh=JrIe64vK19fXZOsenVP7rSnigc5B7CQyObVtpukyt1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AykSFuOn+cstZkFbNL+KY6qvlK4kCSU5uPHlPeDldKfDu0PXZefvVqXHboHMjIQZt
         W8wxYkACqbN5vId5Q52h4q1xkiVbwYn3h0+jIxHrFQO4tX0lT1eMo/AiK+wua1LrVn
         7nPe5XpvSj4mP7D90jmXMg313jH3wP4UnkEy3j4M=
Date:   Mon, 20 Jul 2020 12:25:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 3/3] iio: adc: xilinx-xadc: use devm_krealloc()
Message-ID: <20200720122526.2662732f@archlinux>
In-Reply-To: <20200715092528.8136-4-brgl@bgdev.pl>
References: <20200715092528.8136-1-brgl@bgdev.pl>
        <20200715092528.8136-4-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Jul 2020 11:25:28 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Use the managed variant of krealloc() and shrink the code a bit.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Looks good to me.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index d7fecab9252e4..5bdbe502e983a 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1094,6 +1094,7 @@ MODULE_DEVICE_TABLE(of, xadc_of_match_table);
>  static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	unsigned int *conf)
>  {
> +	struct device *dev = indio_dev->dev.parent;
>  	struct xadc *xadc = iio_priv(indio_dev);
>  	struct iio_chan_spec *channels, *chan;
>  	struct device_node *chan_node, *child;
> @@ -1138,7 +1139,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  		*conf |= XADC_CONF0_MUX | XADC_CONF0_CHAN(ext_mux_chan);
>  	}
>  
> -	channels = kmemdup(xadc_channels, sizeof(xadc_channels), GFP_KERNEL);
> +	channels = devm_kmemdup(dev, xadc_channels,
> +				sizeof(xadc_channels), GFP_KERNEL);
>  	if (!channels)
>  		return -ENOMEM;
>  
> @@ -1174,8 +1176,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	of_node_put(chan_node);
>  
>  	indio_dev->num_channels = num_channels;
> -	indio_dev->channels = krealloc(channels, sizeof(*channels) *
> -					num_channels, GFP_KERNEL);
> +	indio_dev->channels = devm_krealloc(dev, channels,
> +					    sizeof(*channels) * num_channels,
> +					    GFP_KERNEL);
>  	/* If we can't resize the channels array, just use the original */
>  	if (!indio_dev->channels)
>  		indio_dev->channels = channels;
> @@ -1229,14 +1232,14 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	ret = xadc_parse_dt(indio_dev, pdev->dev.of_node, &conf0);
>  	if (ret)
> -		goto err_device_free;
> +		return ret;
>  
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
>  		ret = iio_triggered_buffer_setup(indio_dev,
>  			&iio_pollfunc_store_time, &xadc_trigger_handler,
>  			&xadc_buffer_ops);
>  		if (ret)
> -			goto err_device_free;
> +			return ret;
>  
>  		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
>  		if (IS_ERR(xadc->convst_trigger)) {
> @@ -1354,8 +1357,6 @@ static int xadc_probe(struct platform_device *pdev)
>  err_triggered_buffer_cleanup:
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>  		iio_triggered_buffer_cleanup(indio_dev);
> -err_device_free:
> -	kfree(indio_dev->channels);
>  
>  	return ret;
>  }
> @@ -1375,7 +1376,6 @@ static int xadc_remove(struct platform_device *pdev)
>  	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
>  	clk_disable_unprepare(xadc->clk);
>  	kfree(xadc->data);
> -	kfree(indio_dev->channels);
>  
>  	return 0;
>  }

