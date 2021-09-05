Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CE4400F4C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbhIELYj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhIELYg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:24:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AEC610F8;
        Sun,  5 Sep 2021 11:23:31 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:26:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Florian Boor <florian.boor@kernelconcepts.de>
Cc:     linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com,
        Michael.Hennerich@analog.com
Subject: Re: [PATCH] iio: adc: ad799x: Implement selecting external
 reference voltage input on AD7991, AD7995 and AD7999.
Message-ID: <20210905122653.0e081ab2@jic23-huawei>
In-Reply-To: <20210830145934.11024-1-florian.boor@kernelconcepts.de>
References: <20210830145934.11024-1-florian.boor@kernelconcepts.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Aug 2021 16:59:34 +0200
Florian Boor <florian.boor@kernelconcepts.de> wrote:

> Make use of the AD7991_REF_SEL bit and support using the external
> reference voltage by setting the 'vref-external' property in devicetree.
> 
> Signed-off-by: Florian Boor <florian.boor@kernelconcepts.de>

Normal convention on this (not helped here by the complete lack of
a binding document for this device) would be that the driver would
use the external vref is vref-supply is present.

Currently the driver uses devm_regulator_get().  In this case it
should be using devm_regulator_get_optional() as that will avoid a
'fake' regulator being provided.  

The driver will need a few changes to handle the possible error return
from that call, but it shouldn't be too complicated.

If you are willing it would be great to have a binding description for
this driver. I'm no sure how it has slipped through the net for so long!

Jonathan

> ---
>  drivers/iio/adc/ad799x.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 18bf8386d50a..3ae7ec72caa3 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -770,6 +770,7 @@ static int ad799x_probe(struct i2c_client *client,
>  				   const struct i2c_device_id *id)
>  {
>  	int ret;
> +	int extra_config = 0;
>  	struct ad799x_state *st;
>  	struct iio_dev *indio_dev;
>  	const struct ad799x_chip_info *chip_info =
> @@ -806,6 +807,17 @@ static int ad799x_probe(struct i2c_client *client,
>  	if (ret)
>  		goto error_disable_reg;
>  
> +
> +	/* allow to use external reference voltage */
> +	if ((st->id == ad7991) || (st->id == ad7995) || (st->id == ad7999)) {
> +		unsigned int vref_external = 0;
> +	        of_property_read_u32(client->dev.of_node, "vref-external",
> +			&vref_external);
> +
> +		if (vref_external)
> +			extra_config |= AD7991_REF_SEL;
> +	}
> +
>  	st->client = client;
>  
>  	indio_dev->name = id->name;
> @@ -815,7 +827,7 @@ static int ad799x_probe(struct i2c_client *client,
>  	indio_dev->channels = st->chip_config->channel;
>  	indio_dev->num_channels = chip_info->num_channels;
>  
> -	ret = ad799x_update_config(st, st->chip_config->default_config);
> +	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
>  	if (ret)
>  		goto error_disable_vref;
>  

