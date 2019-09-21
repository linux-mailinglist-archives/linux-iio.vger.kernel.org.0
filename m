Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F65B9EAF
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438256AbfIUPcm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 11:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389131AbfIUPcm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 11:32:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A409E2073F;
        Sat, 21 Sep 2019 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569079961;
        bh=IRspWwvzC35YYhQ9tB2epXO+xGJ1/kfpLYBNy1oqHZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RTN44ibI/4o1jtjDxWuRJf3k9bskgXQn7BMNoHCsUFFupPYilUgQ32BrSzC4/yVkn
         w2QHwb8uTgnILLatRFhnd23d0WNyo05265eqfm+k0yc+Jx4oAZTBGuITSIU2JVEo5H
         gH2JrH5sI8lNRq+beaCg4QVSS4sfKuZgM2a6P1iU=
Date:   Sat, 21 Sep 2019 16:32:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH][RESEND] iio: tcs3414: fix
 iio_triggered_buffer_{pre,post}enable positions
Message-ID: <20190921163236.7fa55f33@archlinux>
In-Reply-To: <20190920075723.28293-1-alexandru.ardelean@analog.com>
References: <20190529142040.7993-1-alexandru.ardelean@analog.com>
        <20190920075723.28293-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Sep 2019 10:57:23 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
> 
> For the predisable hook, the disable code should occur before detaching
> the poll func, and for the postenable hook, the poll func should be
> attached before the enable code.
> 
> The driver was slightly reworked. The preenable hook was moved to the
> postenable, to add some symmetry to the postenable/predisable part.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Seem's Peter is busy or missed this one.  Still time to send a review
though as I won't push out a non rebasing tree for at least a week.

Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/tcs3414.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index 7c0291c5fe76..b542e5619ead 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -240,32 +240,42 @@ static const struct iio_info tcs3414_info = {
>  	.attrs = &tcs3414_attribute_group,
>  };
>  
> -static int tcs3414_buffer_preenable(struct iio_dev *indio_dev)
> +static int tcs3414_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	struct tcs3414_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	data->control |= TCS3414_CONTROL_ADC_EN;
> -	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
>  		data->control);
> +	if (ret)
> +		iio_triggered_buffer_predisable(indio_dev);
> +
> +	return ret;
>  }
>  
>  static int tcs3414_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct tcs3414_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> +	int ret, ret2;
>  
>  	data->control &= ~TCS3414_CONTROL_ADC_EN;
> -	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
>  		data->control);
> +
> +	ret2 = iio_triggered_buffer_predisable(indio_dev);
> +	if (!ret)
> +		ret = ret2;
> +
> +	return ret;
>  }
>  
>  static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
> -	.preenable = tcs3414_buffer_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> +	.postenable = tcs3414_buffer_postenable,
>  	.predisable = tcs3414_buffer_predisable,
>  };
>  

