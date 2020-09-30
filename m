Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F627E2C4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI3Hk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 03:40:29 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60158 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3Hk3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 03:40:29 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 2BB773B2E30
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2020 07:32:36 +0000 (UTC)
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 00FA1FF81A;
        Wed, 30 Sep 2020 07:32:12 +0000 (UTC)
Date:   Wed, 30 Sep 2020 09:32:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH v2 2/4] iio: adc: at91_adc: const-ify some driver data
Message-ID: <20200930073212.GB2804081@piout.net>
References: <20200930060008.42134-1-alexandru.ardelean@analog.com>
 <20200930060008.42134-3-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930060008.42134-3-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 30/09/2020 09:00:06+0300, Alexandru Ardelean wrote:
> The main intent is to get rid of the cast for the void-pointer returned by
> of_device_get_match_data().
> 
> This requires const-ifying the 'caps' and 'registers' references on the
> at91_adc_state struct.
> 
> The caps can be obtained also from the old platform_data (in the
> at91_adc_probe_pdata() function), but that cast is not touched in this
> patch, since the old platform_data should be removed/cleaned-away.
> Also, that cast deals with converting a kernel_ulong_t type to a pointer.
> So, updating that cast doesn't yield any benefit.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/iio/adc/at91_adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index c9ec0a4a357e..7d846a2852a5 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -202,7 +202,7 @@ struct at91_adc_state {
>  	struct mutex		lock;
>  	u8			num_channels;
>  	void __iomem		*reg_base;
> -	struct at91_adc_reg_desc *registers;
> +	const struct at91_adc_reg_desc *registers;
>  	u32			startup_time;
>  	u8			sample_hold_time;
>  	bool			sleep_mode;
> @@ -214,7 +214,7 @@ struct at91_adc_state {
>  	u32			res;		/* resolution used for convertions */
>  	bool			low_res;	/* the resolution corresponds to the lowest one */
>  	wait_queue_head_t	wq_data_avail;
> -	struct at91_adc_caps	*caps;
> +	const struct at91_adc_caps	*caps;
>  
>  	/*
>  	 * Following ADC channels are shared by touchscreen:
> @@ -550,7 +550,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *idev = iio_trigger_get_drvdata(trig);
>  	struct at91_adc_state *st = iio_priv(idev);
> -	struct at91_adc_reg_desc *reg = st->registers;
> +	const struct at91_adc_reg_desc *reg = st->registers;
>  	u32 status = at91_adc_readl(st, reg->trigger_register);
>  	int value;
>  	u8 bit;
> @@ -876,7 +876,7 @@ static int at91_adc_probe_dt(struct iio_dev *idev,
>  	if (!node)
>  		return -EINVAL;
>  
> -	st->caps = (struct at91_adc_caps *)of_device_get_match_data(&pdev->dev);
> +	st->caps = of_device_get_match_data(&pdev->dev);
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
