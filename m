Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BCC15DB35
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgBNPk4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 10:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbgBNPk4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 10:40:56 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAB72467D;
        Fri, 14 Feb 2020 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581694856;
        bh=v+owP3ISw49O9bIkXyz/Z8SVlg482uuJFZRpP3SjwZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dw/uu2/OPxIJNPP8VUXDeP9Sc2WVGmzRPoWs4iuQKali0vUWF+VTJelxUBa2aTZoi
         2Dgp+74o2WzDNNZyrGtSBwgQ26SMMu6XPai2Dcoe5kwrRsMc+WbfVsaMMVwlY35Odw
         pZdhpHHsNcPSWtMwwTqgbIp5znmx5Mch57Th72QY=
Date:   Fri, 14 Feb 2020 15:40:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] staging: iio: adc: ad7192: fail probe on
 get_voltage
Message-ID: <20200214154051.3aa1d09a@archlinux>
In-Reply-To: <20200212161721.16200-2-alexandru.tachici@analog.com>
References: <20200212161721.16200-1-alexandru.tachici@analog.com>
        <20200212161721.16200-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Feb 2020 18:17:17 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch makes the ad7192_probe fail in case
> regulator_get_voltage will return an error or voltage
> is set to 0.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
There are some corner cases around this that we may meet
in the future. Particularly if someone uses a variable reg
to provide this voltage.  However, we can fix those when
we come to them.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index bf3e2a9cc07f..41da8b4cdc48 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -899,10 +899,13 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	voltage_uv = regulator_get_voltage(st->avdd);
>  
> -	if (voltage_uv)
> +	if (voltage_uv > 0) {
>  		st->int_vref_mv = voltage_uv / 1000;
> -	else
> +	} else {
> +		ret = voltage_uv;
>  		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
> +		goto error_disable_avdd;
> +	}
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	st->devid = spi_get_device_id(spi)->driver_data;

