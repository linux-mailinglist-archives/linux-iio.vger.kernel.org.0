Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9EF185C8A
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 14:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgCONPd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 09:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgCONPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 09:15:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2018E205ED;
        Sun, 15 Mar 2020 13:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584278132;
        bh=L9TCRCZ/dfS6izNS/TAi3NM2t9evQsFx3I2zI4Tegkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g15s06qBzzuM92lhLrGFDokl0lsw+cXpgaPI7cKoOez5Z157aY6qcgEvwo8KMaO1d
         lZASTNIpjepve7914QQf1mrfjsL+iNuhbJlfdb0ihwIWaildxFuljalkyWyTQOLqIB
         XqkruAHyyfHGdiJD+ceapuOJw1kQF+yAHv8PSFzA=
Date:   Sun, 15 Mar 2020 13:15:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 1/4] iio: adc: ad7476: Generate CONVST signal internally
Message-ID: <20200315131528.11d1b8bd@archlinux>
In-Reply-To: <20200311084328.17680-1-beniamin.bia@analog.com>
References: <20200311084328.17680-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Mar 2020 10:43:25 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> Compared to the other supported parts, AD7091R are dependent of
> a CONVST signal that initiates the conversion. At this moment, only
> sampling in buffered mode is supported for AD7091R and the only
> option until now was to generate this signal externally using an
> IIO trigger. This patch adds the option of generating it internally,
> more compatible triggers being available in this case.
> 
> Also, it is an intermiate step of adding support more devices.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Seems sensible.  Applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7476.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 76747488044b..32e857dfec9c 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -12,9 +12,11 @@
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/bitops.h>
> +#include <linux/delay.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -34,6 +36,7 @@ struct ad7476_state {
>  	struct spi_device		*spi;
>  	const struct ad7476_chip_info	*chip_info;
>  	struct regulator		*reg;
> +	struct gpio_desc		*convst_gpio;
>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
>  	/*
> @@ -64,6 +67,17 @@ enum ad7476_supported_device_ids {
>  	ID_ADS7868,
>  };
>  
> +static void ad7091_convst(struct ad7476_state *st)
> +{
> +	if (!st->convst_gpio)
> +		return;
> +
> +	gpiod_set_value(st->convst_gpio, 0);
> +	udelay(1); /* CONVST pulse width: 10 ns min */
> +	gpiod_set_value(st->convst_gpio, 1);
> +	udelay(1); /* Conversion time: 650 ns max */
> +}
> +
>  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -71,6 +85,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	struct ad7476_state *st = iio_priv(indio_dev);
>  	int b_sent;
>  
> +	ad7091_convst(st);
> +
>  	b_sent = spi_sync(st->spi, &st->msg);
>  	if (b_sent < 0)
>  		goto done;
> @@ -254,6 +270,12 @@ static int ad7476_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	st->convst_gpio = devm_gpiod_get_optional(&spi->dev,
> +						  "adi,conversion-start",
> +						  GPIOD_OUT_LOW);
> +	if (IS_ERR(st->convst_gpio))
> +		return PTR_ERR(st->convst_gpio);
> +
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	st->spi = spi;

