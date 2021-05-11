Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBA37A8AA
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhEKONf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhEKONZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 May 2021 10:13:25 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F72613F7;
        Tue, 11 May 2021 14:12:17 +0000 (UTC)
Date:   Tue, 11 May 2021 15:13:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alexandru.tachici@analog.com,
        linux@deviqon.com
Subject: Re: [PATCH v2 04/12] iio: adc: ad7192: handle zero Avdd regulator
 value as error
Message-ID: <20210511151323.30832207@jic23-huawei>
In-Reply-To: <20210511071831.576145-5-aardelean@deviqon.com>
References: <20210511071831.576145-1-aardelean@deviqon.com>
        <20210511071831.576145-5-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 10:18:23 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change fixes a corner-case, where the returned voltage is actually
> zero. This is also what patch ab0afa65bbc7 ("staging: iio: adc: ad7192:
> fail probe on get_voltage") was trying to do.
> 
> But as Jonathan pointed out, a zero-value would signal that the probe has
> succeeded, putting the driver is a semi-initialized state.
> 
> Fixes: ab0afa65bbc7 ("staging: iio: adc: ad7192: fail probe on get_voltage")
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>

Given that voltage_uv == 1 would result in a situation no worse than
for voltage_uv == 0 perhaps we should just change the following condition to

if (voltage_uv >= 0)  ?

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index d3be67aa0522..79df54e0dc96 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -950,6 +950,11 @@ static int ad7192_probe(struct spi_device *spi)
>  	}
>  
>  	voltage_uv = regulator_get_voltage(st->avdd);
> +	if (voltage_uv == 0) {
> +		ret = -EINVAL;
> +		dev_err(&spi->dev, "Zero value provided for AVdd supply\n");
> +		goto error_disable_avdd;
> +	}
>  
>  	if (voltage_uv > 0) {
>  		st->int_vref_mv = voltage_uv / 1000;

