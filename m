Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABB6B3008
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfIOM7y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 08:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfIOM7x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 08:59:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D831521479;
        Sun, 15 Sep 2019 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568552393;
        bh=ln1XYnDUNmHvQzhKYhNxFghmE7S90N/Di34Az2haAiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zygvL6ycuA9PSn7D9yZvQ74bwEJfxXhVkqzGFl/plytxSJ0WU7nhK6GrH+tOPC3vd
         2PdWjTsXSH1hvJd7aO3qC3boDk7o2Awg/Qlc4ChxGwXYC/SObW6Q3gtyn6jk92B9nC
         nCZWbV6PjXD5zT7HYclMbyBX0G1zDbJdWnlxt7ZY=
Date:   Sun, 15 Sep 2019 13:59:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: hx711: optimize performance in read
 cycle
Message-ID: <20190915135948.609aba98@archlinux>
In-Reply-To: <20190909123746.lvd2q3dwgaksktuy@arbad>
References: <20190909123746.lvd2q3dwgaksktuy@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Sep 2019 14:37:48 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Set gain in hx711_reset() to its default value after a reset cycle. This
> omits one precautionary read cycle, because the read is performed in
> hx711_set_gain_for_channel() anyway if gain has changed.
> 
> Check for DOUT low and if its high wait some time if it goes down
> instead of doing a blind reset cycle when DOUT is not down.
> 
> This is a performance optimization which allows to query the sensor with
> a higher frequency.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Hi Andreas,

This one seems to have a slightly non trivial interaction with patch 1
so will have to wait until the fixes-togreg branch works it's way back
around to the upstream for the togreg branch.   Give me a poke if I seem
to have lost it!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 0678964dbd21..c8686558429b 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -23,6 +23,7 @@
>  
>  /* gain to pulse and scale conversion */
>  #define HX711_GAIN_MAX		3
> +#define HX711_RESET_GAIN	128
>  
>  struct hx711_gain_to_scale {
>  	int			gain;
> @@ -100,7 +101,6 @@ struct hx711_data {
>  
>  static int hx711_cycle(struct hx711_data *hx711_data)
>  {
> -	int val;
>  	unsigned long flags;
>  
>  	/*
> @@ -186,8 +186,7 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
>  
>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> -	int ret;
> -	int val = gpiod_get_value(hx711_data->gpiod_dout);
> +	int val = hx711_wait_for_ready(hx711_data);
>  
>  	if (val) {
>  		/*
> @@ -203,22 +202,10 @@ static int hx711_reset(struct hx711_data *hx711_data)
>  		msleep(10);
>  		gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
>  
> -		ret = hx711_wait_for_ready(hx711_data);
> -		if (ret)
> -			return ret;
> -		/*
> -		 * after a reset the gain is 128 so we do a dummy read
> -		 * to set the gain for the next read
> -		 */
> -		ret = hx711_read(hx711_data);
> -		if (ret < 0)
> -			return ret;
> -
> -		/*
> -		 * after a dummy read we need to wait vor readiness
> -		 * for not mixing gain pulses with the clock
> -		 */
>  		val = hx711_wait_for_ready(hx711_data);
> +
> +		/* after a reset the gain is 128 */
> +		hx711_data->gain_set = HX711_RESET_GAIN;
>  	}
>  
>  	return val;

