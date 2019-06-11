Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB453CA22
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbfFKLhL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 07:37:11 -0400
Received: from h1.radempa.de ([176.9.142.194]:60965 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389649AbfFKLhL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Jun 2019 07:37:11 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 07:37:09 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.cosmopool.net (Postfix) with ESMTP id 4646B901F94;
        Tue, 11 Jun 2019 13:30:47 +0200 (CEST)
Received: from mail.cosmopool.net ([127.0.0.1])
        by localhost (mail.b.radempa.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ij_MrkGKdSO2; Tue, 11 Jun 2019 13:30:46 +0200 (CEST)
Received: from stardust.g4.wien.funkfeuer.at (178.113.142.121.wireless.dyn.drei.com [178.113.142.121])
        by mail.cosmopool.net (Postfix) with ESMTPSA id 6A17B901143;
        Tue, 11 Jun 2019 13:30:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ccbib.org; s=201902;
        t=1560252646; bh=ZCH0JvrbXKHoNEYNzHbRMZV18dizh1EGMEms6MyPm0o=;
        h=From:To:cc:Subject:In-reply-to:References:Date:From;
        b=C4gL6ugjg2d1rlwYB+annNS1964QANXtpmDwKUHEuXILo3M8a8SPCht5k9JbiLLc4
         Nsc5LdxTZH5Z3MqBjAbIbMxCMLec/6RbTxHlsVB8fRT2pO7mXUi4Epw3mgQ4xeomYN
         bJCH3Z0HDKaeGrYRmBSsu/sjh+VhJanetMqAilrw=
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
        (envelope-from <harald@ccbib.org>)
        id 1haezD-0000WF-2x; Tue, 11 Jun 2019 13:30:43 +0200
From:   Harald Geyer <harald@ccbib.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: Replace older GPIO APIs with GPIO Consumer APIs for the dht11 sensor
In-reply-to: <20190611035554.GA20589@t-1000>
References: <20190611035554.GA20589@t-1000>
Comments: In-reply-to Shobhit Kukreti <shobhitkukreti@gmail.com>
   message dated "Mon, 10 Jun 2019 20:55:57 -0700."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1997.1560252642.1@stardust.g4.wien.funkfeuer.at>
Date:   Tue, 11 Jun 2019 13:30:42 +0200
Message-Id: <E1haezD-0000WF-2x@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Shobhit Kukreti writes:
> The dht11 driver uses a single gpio to make measurements. It was
> using the older global gpio numberspace. The patch replaces the
> old gpio api with the new gpio descriptor based api.
> 
> Removed header files "linux/gpio.h" and "linux/of_gpio.h"
>
> Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>

Acked-by: Harald Geyer <harald@ccbib.org>

> ---
>  drivers/iio/humidity/dht11.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index c815920..f5128d8 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -22,8 +22,7 @@
>  #include <linux/completion.h>
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/timekeeping.h>
>  
>  #include <linux/iio/iio.h>
> @@ -72,7 +71,7 @@
>  struct dht11 {
>  	struct device			*dev;
>  
> -	int				gpio;
> +	struct gpio_desc		*gpiod;
>  	int				irq;
>  
>  	struct completion		completion;
> @@ -179,7 +178,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
>  		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
>  		dht11->edges[dht11->num_edges++].value =
> -						gpio_get_value(dht11->gpio);
> +						gpiod_get_value(dht11->gpiod);
>  
>  		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
>  			complete(&dht11->completion);
> @@ -217,12 +216,12 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>  		reinit_completion(&dht11->completion);
>  
>  		dht11->num_edges = 0;
> -		ret = gpio_direction_output(dht11->gpio, 0);
> +		ret = gpiod_direction_output(dht11->gpiod, 0);
>  		if (ret)
>  			goto err;
>  		usleep_range(DHT11_START_TRANSMISSION_MIN,
>  			     DHT11_START_TRANSMISSION_MAX);
> -		ret = gpio_direction_input(dht11->gpio);
> +		ret = gpiod_direction_input(dht11->gpiod);
>  		if (ret)
>  			goto err;
>  
> @@ -294,10 +293,8 @@ MODULE_DEVICE_TABLE(of, dht11_dt_ids);
>  static int dht11_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *node = dev->of_node;
>  	struct dht11 *dht11;
>  	struct iio_dev *iio;
> -	int ret;
>  
>  	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
>  	if (!iio) {
> @@ -307,18 +304,13 @@ static int dht11_probe(struct platform_device *pdev)
>  
>  	dht11 = iio_priv(iio);
>  	dht11->dev = dev;
> +	dht11->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
> +	if (IS_ERR(dht11->gpiod))
> +		return PTR_ERR(dht11->gpiod);
>  
> -	ret = of_get_gpio(node, 0);
> -	if (ret < 0)
> -		return ret;
> -	dht11->gpio = ret;
> -	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
> -	if (ret)
> -		return ret;
> -
> -	dht11->irq = gpio_to_irq(dht11->gpio);
> +	dht11->irq = gpiod_to_irq(dht11->gpiod);
>  	if (dht11->irq < 0) {
> -		dev_err(dev, "GPIO %d has no interrupt\n", dht11->gpio);
> +		dev_err(dev, "GPIO %d has no interrupt\n", desc_to_gpio(dht11->gpiod));
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.7.4
> 

-- 
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via CLAM to xASPBtezLNqj4cUe8MT5nZjthRSEjrRQXN
or via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
