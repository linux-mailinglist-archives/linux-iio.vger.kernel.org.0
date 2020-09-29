Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B2A27D32D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgI2Pyf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 11:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2Pye (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 11:54:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D2820739;
        Tue, 29 Sep 2020 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601394873;
        bh=U3wTRYS5La8oZ9gPFQ2NLqNVrKaawXqnWmHLf7jBugo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vcEe5K7ZTrM6qdlKpNQgRGLseTn+Z6feRuPNomWgf6sKL2sbO6e/9hUYdfC2q0l06
         b0CN2OOqC971x/OGRYG2GbiANlDA75+8azjPrmgpGl0rrS7A6QuHScdzTw0lbNiIW5
         oguiNtny8psnRx8jhn+BPl3ZZN/5efC564KKSQU8=
Date:   Tue, 29 Sep 2020 16:54:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 1/2] iio: adc: at91_adc: use of_device_get_match_data()
 helper
Message-ID: <20200929165428.15ac9e4c@archlinux>
In-Reply-To: <20200928125424.35921-1-alexandru.ardelean@analog.com>
References: <20200928125424.35921-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 15:54:23 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This tries to solve a warning reported by the lkp bot:
> 
> >> drivers/iio/adc/at91_adc.c:1439:34: warning: unused variable
> >> 'at91_adc_dt_ids' [-Wunused-const-variable]  
>    static const struct of_device_id at91_adc_dt_ids[] = {
>                                     ^
>    1 warning generated.
> 
> This shows up with 'compiler: clang version 12.0.0' and W=1 (as the bot
> mentions).
> 
> Forward declarations for global variables can be a bit weird; forward
> function declarations are more common.
Hi,

That's not the forward declaration that it is complaining about...

It's a reasonable patch anyway, but doesn't fix that warning which is
about of_match_ptr and the lack of #ifdef CONFIG_OF around the
actual definition.

For the bug warning, I'd add add a Kconfig dependency on OF.
It doesn't make any sense to allow building this driver without that.

So resend this as a simple tidy up patch and another one adding
that build dependency.

Thanks,

Jonathan

> 
> Maybe another fix for this would have been to prefix with 'extern' the
> 'at91_adc_dt_ids' variable, thus making it more friendly as a forward
> declaration. It would look weird, but it would work.
> 
> But, we can avoid that forward declaration altogether simply by obtaining
> the private data with of_device_get_match_data().
> 
> This appeared after commit 4027860dcc4c ("iio: Kconfig: at91_adc: add
> COMPILE_TEST dependency to driver"), which put this driver on the lkp's bot
> radar.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
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

