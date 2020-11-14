Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273E92B2EC3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKNRJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:09:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgKNRJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 12:09:14 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A5820A8B;
        Sat, 14 Nov 2020 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605373753;
        bh=IepkTZQ0wdLVptnurilT8/x+AIShJuf60u32T7BRUBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BT82qd+W6yRBTZO9p2N0nnE4ymQZD3ZdR7aW/jeTid+WKNIfZB0JnhH0p0czeWSTV
         Vtlf+Hz/n3J+AJNd9kAY9HyqKB19nsZ9l5i/hgWOnNZrYED71XqFd9hsSCUdNT/8M+
         tq/Kt5+CzsPXkWinu1r4ytYuWakD/FPmU0V64PJ4=
Date:   Sat, 14 Nov 2020 17:09:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: adc: at91_adc: remove forward declaration
Message-ID: <20201114170908.234f0141@archlinux>
In-Reply-To: <20201113212650.507680-7-alexandre.belloni@bootlin.com>
References: <20201113212650.507680-1-alexandre.belloni@bootlin.com>
        <20201113212650.507680-7-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Nov 2020 22:26:47 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Remove the forward declaration of at91_adc_dt_ids by using
> device_get_match_data. Also add const were possible since it is not
> discarded by the cast anymore.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Ignore comment on previous patch ;)

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 9f05eb722f5e..76aeebce6f4d 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -224,7 +224,6 @@ struct at91_adc_state {
>  	struct mutex		lock;
>  	u8			num_channels;
>  	void __iomem		*reg_base;
> -	struct at91_adc_reg_desc *registers;
>  	u32			startup_time;
>  	u8			sample_hold_time;
>  	bool			sleep_mode;
> @@ -233,7 +232,8 @@ struct at91_adc_state {
>  	u32			vref_mv;
>  	u32			res;		/* resolution used for convertions */
>  	wait_queue_head_t	wq_data_avail;
> -	struct at91_adc_caps	*caps;
> +	const struct at91_adc_caps *caps;
> +	const struct at91_adc_reg_desc *registers;
>  
>  	/*
>  	 * Following ADC channels are shared by touchscreen:
> @@ -569,7 +569,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *idev = iio_trigger_get_drvdata(trig);
>  	struct at91_adc_state *st = iio_priv(idev);
> -	struct at91_adc_reg_desc *reg = st->registers;
> +	const struct at91_adc_reg_desc *reg = st->registers;
>  	u32 status = at91_adc_readl(st, reg->trigger_register);
>  	int value;
>  	u8 bit;
> @@ -796,8 +796,6 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
>  	return ticks;
>  }
>  
> -static const struct of_device_id at91_adc_dt_ids[];
> -
>  static int at91_adc_probe_dt_ts(struct device_node *node,
>  	struct at91_adc_state *st, struct device *dev)
>  {
> @@ -1011,8 +1009,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	st = iio_priv(idev);
>  
> -	st->caps = (struct at91_adc_caps *)
> -		of_match_device(at91_adc_dt_ids, &pdev->dev)->data;
> +	st->caps = device_get_match_data(&pdev->dev);
>  
>  	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
>  

