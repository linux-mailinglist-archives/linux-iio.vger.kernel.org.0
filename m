Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E21ACF16
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 15:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfIHNt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 09:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfIHNt1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 09:49:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB6020854;
        Sun,  8 Sep 2019 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567950566;
        bh=uc60KOZWV5guRBPrvX5cZcJk9hyhbSRiAGv78v+FNz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H+sDSlQQC6cTC/DJSI2an1gJzM2V0TZrScPZGYOJyd43jn9jn+ovbKGg06cI/qBub
         dbU9o2OOaRGGZTBvFwLfly1SyETu7UwMFRggWGsH3A9I/C8KWWjc1oFKyzjQ//yrUz
         UQuVe5foCRNmCNJC+VwnqN87kjzPo+eW4pNO/J84=
Date:   Sun, 8 Sep 2019 14:49:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: hx711: optimize sampling of data
Message-ID: <20190908144922.51ba448e@archlinux>
In-Reply-To: <20190907101759.kft6xwsqc5lf4acq@arbad>
References: <20190907101759.kft6xwsqc5lf4acq@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 7 Sep 2019 12:18:00 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Fix bug in sampling function hx711_cycle() when interrupt occures while
> PD_SCK is high. If PD_SCK is high for at least 60 us power down mode of
> the sensor is entered which in turn leads to a wrong measurement.
> 
> Move query of DOUT at the latest point of time which is at the end of
> PD_SCK low period.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hi Andreas,

One thing I'm not clear on from these is how much a 'fix' they
are.  That just effects whether we mark them for stable / push them
out as quickly as possible or not.  So has this been seen in 
normal operation?

+ please add fixes tags to the two fixes.

For patch 3, it's in the very low importance category so it may
well get forgotten if these two go through the fixes tree
(up to you to remind me!)

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

