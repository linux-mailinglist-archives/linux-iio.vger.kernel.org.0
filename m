Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A224F47578
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFPPSf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 11:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfFPPSf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 11:18:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 462C12084B;
        Sun, 16 Jun 2019 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560698314;
        bh=+cBv0D4WKJT88FHE9AT3EwO/PO4Bc0pnE7UKxW1k6/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VqKBxP4OvbIvC8T09RetdaGOiMpdIxN5rK1pm46ALrqdZPR73q7eerdsvuW7f+kB4
         txuUELaQQVqg9KLDwsppRd7jT2LEbFIL5PUbhyuRVS7g9PHCKNBXLkwFOAlTZj+202
         Ln8Ug32ExuLywX9jrins/Y1Q+wvjAoyRYIdI3lfk=
Date:   Sun, 16 Jun 2019 16:18:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Harald Geyer <harald@ccbib.org>
Cc:     Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: Replace older GPIO APIs with GPIO
 Consumer APIs for the dht11 sensor
Message-ID: <20190616161830.29b42440@archlinux>
In-Reply-To: <E1haezD-0000WF-2x@stardust.g4.wien.funkfeuer.at>
References: <20190611035554.GA20589@t-1000>
        <E1haezD-0000WF-2x@stardust.g4.wien.funkfeuer.at>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Jun 2019 13:30:42 +0200
Harald Geyer <harald@ccbib.org> wrote:

> Shobhit Kukreti writes:
> > The dht11 driver uses a single gpio to make measurements. It was
> > using the older global gpio numberspace. The patch replaces the
> > old gpio api with the new gpio descriptor based api.
> > 
> > Removed header files "linux/gpio.h" and "linux/of_gpio.h"
> >
> > Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>  
> 
> Acked-by: Harald Geyer <harald@ccbib.org>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

thanks,

Jonathan

> 
> > ---
> >  drivers/iio/humidity/dht11.c | 28 ++++++++++------------------
> >  1 file changed, 10 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> > index c815920..f5128d8 100644
> > --- a/drivers/iio/humidity/dht11.c
> > +++ b/drivers/iio/humidity/dht11.c
> > @@ -22,8 +22,7 @@
> >  #include <linux/completion.h>
> >  #include <linux/mutex.h>
> >  #include <linux/delay.h>
> > -#include <linux/gpio.h>
> > -#include <linux/of_gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/timekeeping.h>
> >  
> >  #include <linux/iio/iio.h>
> > @@ -72,7 +71,7 @@
> >  struct dht11 {
> >  	struct device			*dev;
> >  
> > -	int				gpio;
> > +	struct gpio_desc		*gpiod;
> >  	int				irq;
> >  
> >  	struct completion		completion;
> > @@ -179,7 +178,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
> >  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> >  		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
> >  		dht11->edges[dht11->num_edges++].value =
> > -						gpio_get_value(dht11->gpio);
> > +						gpiod_get_value(dht11->gpiod);
> >  
> >  		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
> >  			complete(&dht11->completion);
> > @@ -217,12 +216,12 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
> >  		reinit_completion(&dht11->completion);
> >  
> >  		dht11->num_edges = 0;
> > -		ret = gpio_direction_output(dht11->gpio, 0);
> > +		ret = gpiod_direction_output(dht11->gpiod, 0);
> >  		if (ret)
> >  			goto err;
> >  		usleep_range(DHT11_START_TRANSMISSION_MIN,
> >  			     DHT11_START_TRANSMISSION_MAX);
> > -		ret = gpio_direction_input(dht11->gpio);
> > +		ret = gpiod_direction_input(dht11->gpiod);
> >  		if (ret)
> >  			goto err;
> >  
> > @@ -294,10 +293,8 @@ MODULE_DEVICE_TABLE(of, dht11_dt_ids);
> >  static int dht11_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	struct device_node *node = dev->of_node;
> >  	struct dht11 *dht11;
> >  	struct iio_dev *iio;
> > -	int ret;
> >  
> >  	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
> >  	if (!iio) {
> > @@ -307,18 +304,13 @@ static int dht11_probe(struct platform_device *pdev)
> >  
> >  	dht11 = iio_priv(iio);
> >  	dht11->dev = dev;
> > +	dht11->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
> > +	if (IS_ERR(dht11->gpiod))
> > +		return PTR_ERR(dht11->gpiod);
> >  
> > -	ret = of_get_gpio(node, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -	dht11->gpio = ret;
> > -	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
> > -	if (ret)
> > -		return ret;
> > -
> > -	dht11->irq = gpio_to_irq(dht11->gpio);
> > +	dht11->irq = gpiod_to_irq(dht11->gpiod);
> >  	if (dht11->irq < 0) {
> > -		dev_err(dev, "GPIO %d has no interrupt\n", dht11->gpio);
> > +		dev_err(dev, "GPIO %d has no interrupt\n", desc_to_gpio(dht11->gpiod));
> >  		return -EINVAL;
> >  	}
> >  
> > -- 
> > 2.7.4
> >   
> 

