Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5B107F5C
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 17:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKWQ31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 11:29:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfKWQ31 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 11:29:27 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E25720719;
        Sat, 23 Nov 2019 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574526566;
        bh=ttQo5qpoKSKz2fy8gE/OGVK7L+NBmtPsjYZhifg7Ldw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aZjTAsJ50gfRBobQiO3HkwE0RabAa9hw6FZU6y6ws7MAk4gB68NackN+H1au7l50/
         rk70OtrJOGnF3gHrxnMBZS7Lg477DAN7UyAQQAON6WvV/iQxELRdHMnmwFlRyIE/W1
         NegMsBoIwPFWKA7tIepaPD+4O+vJrP/6Fm3rzGqc=
Date:   Sat, 23 Nov 2019 16:29:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1027: fix not unregistered iio trigger
Message-ID: <20191123162921.71499b80@archlinux>
In-Reply-To: <20191118114018.25431-1-hslester96@gmail.com>
References: <20191118114018.25431-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Nov 2019 19:40:18 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> The driver forgets to unregister the iio trigger in probe failure and
> remove.
> Use devm API to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Hi.

This has crossed with some other patches to the driver, but the fix
is still applicable.  If we want to push this back to older stable
branches we will need to do manual backports.

Adjusted version applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 214883458582..8caead7dffa5 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -446,7 +446,12 @@ static int max1027_probe(struct spi_device *spi)
>  	st->trig->ops = &max1027_trigger_ops;
>  	st->trig->dev.parent = &spi->dev;
>  	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	iio_trigger_register(st->trig);
> +
> +	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Failed to register iio trigger\n");
> +		return ret;
> +	}
>  
>  	ret = devm_request_threaded_irq(&spi->dev, spi->irq,
>  					iio_trigger_generic_data_rdy_poll,

