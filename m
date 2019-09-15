Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B00B3000
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 14:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfIOMxb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 08:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbfIOMxb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:53:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62ADD21479;
        Sun, 15 Sep 2019 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568552010;
        bh=j1MhtTL/HDQs+iWSaui+/inPThD5GVkIgBWEhB3l9Wg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TBpEfH0L/yWtWIwpEqIT85T7Ccsoz+Int2biZ3vy4zgc/WPx6z6ZAZJSrYQ5AQ/DM
         3KRXyf2v5JlfP5eOcP8ROhfCM2JCHyO6FjPLH3bSBzHy3kXzHydaUfF346DV5EbkX5
         i5r/ii3GySRU8Y0d93dYnT8CWy/40ByxyFHUCc4M=
Date:   Sun, 15 Sep 2019 13:53:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: hx711: fix bug in sampling of data
Message-ID: <20190915135326.69551618@archlinux>
In-Reply-To: <20190909123720.qdew2c4evxd6dpyk@arbad>
References: <20190909123720.qdew2c4evxd6dpyk@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Sep 2019 14:37:21 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Fix bug in sampling function hx711_cycle() when interrupt occures while
> PD_SCK is high. If PD_SCK is high for at least 60 us power down mode of
> the sensor is entered which in turn leads to a wrong measurement.
> 
> Switch off interrupts during a PD_SCK high period and move query of DOUT
> to the latest point of time which is at the end of PD_SCK low period.
> 
> This bug exists in the driver since it's initial addition. The more
> interrupts on the system the higher is the probability that it happens.
> 
> Fixes: c3b2fdd0ea7e ("iio: adc: hx711: Add IIO driver for AVIA HX711")
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 88c7fe15003b..0678964dbd21 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -101,13 +101,14 @@ struct hx711_data {
>  static int hx711_cycle(struct hx711_data *hx711_data)
>  {
>  	int val;
> +	unsigned long flags;
>  
>  	/*
>  	 * if preempted for more then 60us while PD_SCK is high:
>  	 * hx711 is going in reset
>  	 * ==> measuring is false
>  	 */
> -	preempt_disable();
> +	local_irq_save(flags);
>  	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
>  
>  	/*
> @@ -117,7 +118,6 @@ static int hx711_cycle(struct hx711_data *hx711_data)
>  	 */
>  	ndelay(hx711_data->data_ready_delay_ns);
>  
> -	val = gpiod_get_value(hx711_data->gpiod_dout);
>  	/*
>  	 * here we are not waiting for 0.2 us as suggested by the datasheet,
>  	 * because the oscilloscope showed in a test scenario
> @@ -125,7 +125,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
>  	 * and 0.56 us for PD_SCK low on TI Sitara with 800 MHz
>  	 */
>  	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
> -	preempt_enable();
> +	local_irq_restore(flags);
>  
>  	/*
>  	 * make it a square wave for addressing cases with capacitance on
> @@ -133,7 +133,8 @@ static int hx711_cycle(struct hx711_data *hx711_data)
>  	 */
>  	ndelay(hx711_data->data_ready_delay_ns);
>  
> -	return val;
> +	/* sample as late as possible */
> +	return gpiod_get_value(hx711_data->gpiod_dout);
>  }
>  
>  static int hx711_read(struct hx711_data *hx711_data)

