Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C3F1D62ED
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgEPRP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 13:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgEPRP1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 13:15:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618AC20756;
        Sat, 16 May 2020 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649327;
        bh=UFcxAeFE3SPRLnvNasRhmzG8Bcy6a0fnOsbSJPfdJ60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IjDYS2+lL53IsLZmPGS9PxVLjYvUEWxRk58arwUdxRBAHEiERoPkdkSur8zVAV4gT
         Vaj8DkhvkYppWWOJRcNVj10K7VXZ7TbgtabI+8uWRGJj06kVrWQq7bLDdTMQWb4nWo
         rQqIhLe0OgGTQRACXGKGTMQxb3ZygaGgkpg7lCiI=
Date:   Sat, 16 May 2020 18:15:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <ak@it-klinger.de>
Subject: Re: [PATCH v2 2/8] iio: at91-sama5d2_adc: pass ref to IIO device
 via param for int function
Message-ID: <20200516181522.096433bc@archlinux>
In-Reply-To: <20200514131710.84201-3-alexandru.ardelean@analog.com>
References: <20200514131710.84201-1-alexandru.ardelean@analog.com>
        <20200514131710.84201-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 16:17:04 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since there will be some changes to how iio_priv_to_dev() is implemented,
> it could be that the helper becomes a bit slower, as it will be hidden away
> in the IIO core.
> 
> For this driver, the IIO device can be passed directly as a parameter to
> the at91_adc_no_pen_detect_interrupt() function, thus making it immune to
> the change of iio_priv_to_dev().
> The function gets called in an interrupt context.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Looks sensible to me.   We could get the state structure from the 
iio_dev inside that function, but then it would be different from the
pen version, so I think what you have here is probably best option.

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 9abbbdcc7420..822b8782acba 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1275,10 +1275,9 @@ static void at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
>  	st->touch_st.touching = true;
>  }
>  
> -static void at91_adc_no_pen_detect_interrupt(struct at91_adc_state *st)
> +static void at91_adc_no_pen_detect_interrupt(struct iio_dev *indio_dev,
> +					     struct at91_adc_state *st)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> -
>  	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
>  			AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER);
>  	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_NOPEN |
> @@ -1318,7 +1317,7 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
>  		at91_adc_pen_detect_interrupt(st);
>  	} else if ((status & AT91_SAMA5D2_IER_NOPEN)) {
>  		/* nopen detected IRQ */
> -		at91_adc_no_pen_detect_interrupt(st);
> +		at91_adc_no_pen_detect_interrupt(indio, st);
>  	} else if ((status & AT91_SAMA5D2_ISR_PENS) &&
>  		   ((status & rdy_mask) == rdy_mask)) {
>  		/* periodic trigger IRQ - during pen sense */

