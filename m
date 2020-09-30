Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF86627E2C3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgI3HkZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 03:40:25 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60024 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HkZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 03:40:25 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id B73DE3A58E6
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 07:30:44 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 126AD20000E;
        Wed, 30 Sep 2020 07:30:21 +0000 (UTC)
Date:   Wed, 30 Sep 2020 09:30:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH v2 1/4] iio: adc: at91_adc: use
 of_device_get_match_data() helper
Message-ID: <20200930073021.GA2804081@piout.net>
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
 <20200930060008.42134-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930060008.42134-2-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/09/2020 09:00:05+0300, Alexandru Ardelean wrote:
> This is a small tidy-up. The of_device_get_match_data() helper retrieves
> the driver data from the OF table, without needed to explicitly know the
> table variable (since it can retrieve it from the driver object).
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/iio/adc/at91_adc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 9b2c548fae95..c9ec0a4a357e 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -829,8 +829,6 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
>  	return ticks;
>  }
>  
> -static const struct of_device_id at91_adc_dt_ids[];
> -
>  static int at91_adc_probe_dt_ts(struct device_node *node,
>  	struct at91_adc_state *st, struct device *dev)
>  {
> @@ -878,8 +876,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
>  	if (!node)
>  		return -EINVAL;
>  
> -	st->caps = (struct at91_adc_caps *)
> -		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
> +	st->caps = (struct at91_adc_caps *)of_device_get_match_data(&pdev->dev);
>  
>  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
