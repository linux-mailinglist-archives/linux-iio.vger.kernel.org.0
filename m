Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569AC3A044
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfFHOYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 10:24:07 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33378 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfFHOYH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 10:24:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 6D2079E8552;
        Sat,  8 Jun 2019 15:24:05 +0100 (BST)
Date:   Sat, 8 Jun 2019 15:24:03 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: tcs3414: fix iio_triggered_buffer_{pre,post}enable
 positions
Message-ID: <20190608152403.00bc86d7@archlinux>
In-Reply-To: <20190529142040.7993-1-alexandru.ardelean@analog.com>
References: <20190529142040.7993-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 May 2019 17:20:40 +0300
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

Looks fine to me, but I'm looking for a tested-by/ack from Peter.

Thanks,

Jonathan

> ---
>  drivers/iio/light/tcs3414.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> index 205e5659ce6b..ae70bf89be70 100644
> --- a/drivers/iio/light/tcs3414.c
> +++ b/drivers/iio/light/tcs3414.c
> @@ -243,32 +243,42 @@ static const struct iio_info tcs3414_info = {
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

