Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33192C7505
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388124AbgK1Vt3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732799AbgK1TEJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:04:09 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823A424679;
        Sat, 28 Nov 2020 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606571036;
        bh=y8xSzwhE92q2EySyYkUqGtr0mZ9hF3RD8J9JIx/Ufkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gk1oeaM6olIOr4VGM+2X3UhJgKOeVpKyvwA6jZ89a2/h9KYu0wzC6KgM2rmT/jfOe
         4V4GhGwSW1ql6scMjeaZUdLc+DRtAyqoqiM6xjphCS55nKO8SH/osAShCslb5Niilb
         5NAzJ4SeYKSufERqhSP84q6ZLvDhj0od9+KUblm0=
Date:   Sat, 28 Nov 2020 13:43:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: potentiometer: ad5272: Correct polarity of
 reset
Message-ID: <20201128134352.4b2529a6@archlinux>
In-Reply-To: <20201124050014.4453-1-preid@electromag.com.au>
References: <20201124050014.4453-1-preid@electromag.com.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Nov 2020 13:00:14 +0800
Phil Reid <preid@electromag.com.au> wrote:

> The driver should assert reset by setting the gpio high, and
> then release it by setting it the gpio low. This allows the
> device tree (or other hardware definition) to specify how the
> gpio is configured.
> 
> For example as open drain or push-pull depending on the
> connected hardware.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>

I'm in 2 minds on whether we want to push this back to stable or not.
Phil, do you have any idea if we have dt in the wild for this on any
boards where people are actually likely to update their kernel
(to stable)?

Applied to togreg branch of iio.git.  If we want a stable backport
after this has gone out in a non-rebasing tree we can request it
explicitly.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/ad5272.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
> index 70c45d346df0..d8cbd170262f 100644
> --- a/drivers/iio/potentiometer/ad5272.c
> +++ b/drivers/iio/potentiometer/ad5272.c
> @@ -143,13 +143,13 @@ static int ad5272_reset(struct ad5272_data *data)
>  	struct gpio_desc *reset_gpio;
>  
>  	reset_gpio = devm_gpiod_get_optional(&data->client->dev, "reset",
> -		GPIOD_OUT_LOW);
> +		GPIOD_OUT_HIGH);
>  	if (IS_ERR(reset_gpio))
>  		return PTR_ERR(reset_gpio);
>  
>  	if (reset_gpio) {
>  		udelay(1);
> -		gpiod_set_value(reset_gpio, 1);
> +		gpiod_set_value(reset_gpio, 0);
>  	} else {
>  		ad5272_write(data, AD5272_RESET, 0);
>  	}

