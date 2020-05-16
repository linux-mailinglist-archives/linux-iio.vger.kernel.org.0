Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609411D62F2
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgEPRRz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 13:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgEPRRy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 13:17:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1C720756;
        Sat, 16 May 2020 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649474;
        bh=IcHZ7TOh5vvvk0say8vEkTHU3vT+7RvmCSLthgNzCLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vsrsTh6IOhShbQ5wYFS+COo68gFFwCD/TNQhprwkiTMwrVUbFGacw8W+L7ruNT0gR
         Y3ZgdhYioeixFEVMOs7E/sH4nkzIPXAeKAICDRXl71IcDuXvQHxBenOPs1px1ZcyQv
         Gzrpg3u8nQn+nJq0CYd3hVneWeX9woZBBrJnR35c=
Date:   Sat, 16 May 2020 18:17:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>
Subject: Re: [PATCH v2 3/8] iio: at91_adc: pass ref to IIO device via param
 for int function
Message-ID: <20200516181749.243c9515@archlinux>
In-Reply-To: <20200514131710.84201-4-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
        <20200514131710.84201-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 16:17:05 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since there will be some changes to how iio_priv_to_dev() is implemented,
> it could be that the helper becomes a bit slower, as it will be hidden away
> in the IIO core.
> 
> For this driver, the IIO device can be passed directly as a parameter to
> the at91_ts_sample() function, thus making it immune to the change of
> iio_priv_to_dev().
> The function gets called in an interrupt context.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I wonder. Should we just pass the struct device?  It's only used for
error printing I think, so we could make that explicit.

I'm not that bothered either way though.

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 0368b6dc6d60..5999defe47cd 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -287,13 +287,12 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>  	}
>  }
>  
> -static int at91_ts_sample(struct at91_adc_state *st)
> +static int at91_ts_sample(struct iio_dev *idev, struct at91_adc_state *st)
>  {
>  	unsigned int xscale, yscale, reg, z1, z2;
>  	unsigned int x, y, pres, xpos, ypos;
>  	unsigned int rxp = 1;
>  	unsigned int factor = 1000;
> -	struct iio_dev *idev = iio_priv_to_dev(st);
>  
>  	unsigned int xyz_mask_bits = st->res;
>  	unsigned int xyz_mask = (1 << xyz_mask_bits) - 1;
> @@ -449,7 +448,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
>  
>  		if (status & AT91_ADC_ISR_PENS) {
>  			/* validate data by pen contact */
> -			at91_ts_sample(st);
> +			at91_ts_sample(idev, st);
>  		} else {
>  			/* triggered by event that is no pen contact, just read
>  			 * them to clean the interrupt and discard all.

