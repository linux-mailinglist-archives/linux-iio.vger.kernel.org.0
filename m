Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF412B34E
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2019 09:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfL0Irk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Dec 2019 03:47:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57365 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfL0Irj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Dec 2019 03:47:39 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iklHJ-0002Dw-ML; Fri, 27 Dec 2019 09:47:25 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iklHE-0002Re-Do; Fri, 27 Dec 2019 09:47:20 +0100
Date:   Fri, 27 Dec 2019 09:47:20 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4000: Fix scale for vcnl4040
Message-ID: <20191227084720.GA6398@pengutronix.de>
References: <4f2a980d87a7d5ae27d61ed1d35c4f310bfc607c.1577114947.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f2a980d87a7d5ae27d61ed1d35c4f310bfc607c.1577114947.git.agx@sigxcpu.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:42:35 up 119 days, 20:56, 75 users,  load average: 0.06, 0.12,
 0.09
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guido,

On 19-12-23 16:30, Guido Günther wrote:
> According to the data sheet the ambient sensors's scale is 0.12
> lux/step, not 0.024 lux/step as used by vcnl4200.

This is only true if the als_it bits are set to '0'. Is it worth to add
a comment here?

> See p. 8 in https://www.vishay.com/docs/84307/designingvcnl4040.pdf
> 
> Fixes: 5a441aade5b3 ("light: vcnl4000 add support for the VCNL4040 proximity and light sensor")
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  drivers/iio/light/vcnl4000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 16dacea9eadf..b0e241aaefb4 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -163,7 +163,6 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	if (ret < 0)
>  		return ret;
>  
> -	data->al_scale = 24000;
>  	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
>  	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
>  	switch (id) {
> @@ -172,11 +171,13 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		/* show 54ms in total. */
>  		data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
>  		data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
> +		data->al_scale = 24000;
>  		break;
>  	case VCNL4040_PROD_ID:
>  		/* Integration time is 80ms, add 10ms. */
>  		data->vcnl4200_al.sampling_rate = ktime_set(0, 100000 * 1000);
>  		data->vcnl4200_ps.sampling_rate = ktime_set(0, 100000 * 1000);
> +		data->al_scale = 120000;
>  		break;
>  	}
>  	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
> -- 
> 2.23.0
