Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697E4167E49
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 14:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgBUNR5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 08:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgBUNR4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Feb 2020 08:17:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC52E24650;
        Fri, 21 Feb 2020 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582291075;
        bh=S1Jbj5o5lJoLCnkgP2rdU16DC7uSI63S2yqDd33FuFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=03sht77VZSMQkXc5jsctcYxDT1DYcJLCl1NTKpq/YU1rLIU/NjjUm6gKf9jzEtHTV
         CoxbxnWEDKprrHIxgKnQaPV++9nlaPGoUdhstgUD1qiwlbNCcgH75eDLpENrcaYNOw
         SVXbaQwtB2wrJWZ2Nl2SU2elwciyWlh8z91OITqo=
Date:   Fri, 21 Feb 2020 13:17:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, Gregor Riepl <onitake@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH] iio: light: Simplify the current to lux LUT
Message-ID: <20200221131751.59ce8be7@archlinux>
In-Reply-To: <20200220212053.32577-1-linus.walleij@linaro.org>
References: <20200220212053.32577-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Feb 2020 22:20:53 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> From: Gregor Riepl <onitake@gmail.com>
> 
> The look-up-table for currens to lux is simply specifying
> all currents from 5..47 mA, if we add some values for 0..5
> we can just select the index for the lux value in an array
> from the mA value. Use clamp() to get the value in the
> range of values in the array.
> 
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Gregor Riepl <onitake@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/gp2ap002.c | 92 ++++++------------------------------
>  1 file changed, 14 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index f747a42882e0..b24f43f961c8 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -204,71 +204,27 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
>  	return IRQ_HANDLED;
>  }
>  
> -struct gp2ap002_illuminance {
> -	unsigned int curr;
> -	unsigned int lux;
> -};
> -
>  /*
>   * This array maps current and lux.
>   *
>   * Ambient light sensing range is 3 to 55000 lux.
>   *
>   * This mapping is based on the following formula.
> - * illuminance = 10 ^ (current / 10)
> + * illuminance = 10 ^ (current[mA] / 10)
> + *
> + * When the ADC measures 0, return 0 lux.
>   */
> -static const struct gp2ap002_illuminance gp2ap002_illuminance_table[] = {
> -	{ .curr		= 5, .lux	= 3 },
> -	{ .curr		= 6, .lux	= 4 },
> -	{ .curr		= 7, .lux	= 5 },
> -	{ .curr		= 8, .lux	= 6 },
> -	{ .curr		= 9, .lux	= 8 },
> -	{ .curr		= 10, .lux	= 10 },
> -	{ .curr		= 11, .lux	= 12 },
> -	{ .curr		= 12, .lux	= 16 },
> -	{ .curr		= 13, .lux	= 20 },
> -	{ .curr		= 14, .lux	= 25 },
> -	{ .curr		= 15, .lux	= 32 },
> -	{ .curr		= 16, .lux	= 40 },
> -	{ .curr		= 17, .lux	= 50 },
> -	{ .curr		= 18, .lux	= 63 },
> -	{ .curr		= 19, .lux	= 79 },
> -	{ .curr		= 20, .lux	= 100 },
> -	{ .curr		= 21, .lux	= 126 },
> -	{ .curr		= 22, .lux	= 158 },
> -	{ .curr		= 23, .lux	= 200 },
> -	{ .curr		= 24, .lux	= 251 },
> -	{ .curr		= 25, .lux	= 316 },
> -	{ .curr		= 26, .lux	= 398 },
> -	{ .curr		= 27, .lux	= 501 },
> -	{ .curr		= 28, .lux	= 631 },
> -	{ .curr		= 29, .lux	= 794 },
> -	{ .curr		= 30, .lux	= 1000 },
> -	{ .curr		= 31, .lux	= 1259 },
> -	{ .curr		= 32, .lux	= 1585 },
> -	{ .curr		= 33, .lux	= 1995 },
> -	{ .curr		= 34, .lux	= 2512 },
> -	{ .curr		= 35, .lux	= 3162 },
> -	{ .curr		= 36, .lux	= 3981 },
> -	{ .curr		= 37, .lux	= 5012 },
> -	{ .curr		= 38, .lux	= 6310 },
> -	{ .curr		= 39, .lux	= 7943 },
> -	{ .curr		= 40, .lux	= 10000 },
> -	{ .curr		= 41, .lux	= 12589 },
> -	{ .curr		= 42, .lux	= 15849 },
> -	{ .curr		= 43, .lux	= 19953 },
> -	{ .curr		= 44, .lux	= 25119 },
> -	{ .curr		= 45, .lux	= 31623 },
> -	{ .curr		= 46, .lux	= 39811 },
> -	{ .curr		= 47, .lux	= 50119 },
> +static const u16 gp2ap002_illuminance_table[] = {
> +	0, 1, 1, 2, 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 25, 32, 40, 50, 63, 79,
> +	100, 126, 158, 200, 251, 316, 398, 501, 631, 794, 1000, 1259, 1585,
> +	1995, 2512, 3162, 3981, 5012, 6310, 7943, 10000, 12589, 15849, 19953,
> +	25119, 31623, 39811, 50119,
>  };
>  
>  static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
>  {
> -	const struct gp2ap002_illuminance *ill1;
> -	const struct gp2ap002_illuminance *ill2;
>  	int ret, res;
> -	int i;
> +	u16 lux;
>  
>  	ret = iio_read_channel_processed(gp2ap002->alsout, &res);
>  	if (ret < 0)
> @@ -276,31 +232,11 @@ static int gp2ap002_get_lux(struct gp2ap002 *gp2ap002)
>  
>  	dev_dbg(gp2ap002->dev, "read %d mA from ADC\n", res);
>  
> -	ill1 = &gp2ap002_illuminance_table[0];
> -	if (res < ill1->curr) {
> -		dev_dbg(gp2ap002->dev, "total darkness\n");
> -		return 0;
> -	}
> -	for (i = 0; i < ARRAY_SIZE(gp2ap002_illuminance_table) - 1; i++) {
> -		ill1 = &gp2ap002_illuminance_table[i];
> -		ill2 = &gp2ap002_illuminance_table[i + 1];
> -
> -		if (res > ill2->curr)
> -			continue;
> -		if ((res <= ill1->curr) && (res >= ill2->curr))
> -			break;
> -	}
> -	if (res > ill2->curr) {
> -		dev_info_once(gp2ap002->dev, "max current overflow\n");
> -		return ill2->curr;
> -	}
> -	/* Interpolate and return */
> -	dev_dbg(gp2ap002->dev, "interpolate index %d and %d\n", i, i + 1);
> -	/* How many steps along the curve */
> -	i = res - ill1->curr; /* x - x0 */
> -	/* Linear interpolation */
> -	return ill1->lux + i *
> -		((ill2->lux - ill1->lux) / (ill2->curr - ill1->curr));
> +	/* ensure we don't under/overflow */
> +	res = clamp(res, 0, (int)ARRAY_SIZE(gp2ap002_illuminance_table) - 1);
> +	lux = gp2ap002_illuminance_table[res];
> +
> +	return (int)lux;
>  }
>  
>  static int gp2ap002_read_raw(struct iio_dev *indio_dev,

