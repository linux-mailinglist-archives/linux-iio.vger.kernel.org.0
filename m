Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A70C44488C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 19:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKCSva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 14:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhKCSva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 14:51:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57EFC60E78;
        Wed,  3 Nov 2021 18:48:52 +0000 (UTC)
Date:   Wed, 3 Nov 2021 18:53:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: ti-ads1015: Remove shift variable
 ads1015_read_raw
Message-ID: <20211103185325.5d968556@jic23-huawei>
In-Reply-To: <20211101071822.522178-3-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
        <20211101071822.522178-3-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Nov 2021 00:18:20 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> By using scan_type.realbits when processing raw data,
> we use scan_type.shit only once, thus we don't need to define a local

Possibly Freudian typo..

> variable for it anymore.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Otherwise looks fine to me and works for both
realbits = 16, shift = 0
realbits = 12, shift = 4

Jonathan

> ---
>  drivers/iio/adc/ti-ads1015.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index b0352e91ac165..b92d4cd1b8238 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -464,9 +464,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&data->lock);
>  	switch (mask) {
> -	case IIO_CHAN_INFO_RAW: {
> -		int shift = chan->scan_type.shift;
> -
> +	case IIO_CHAN_INFO_RAW:
>  		ret = iio_device_claim_direct_mode(indio_dev);
>  		if (ret)
>  			break;
> @@ -487,7 +485,8 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>  			goto release_direct;
>  		}
>  
> -		*val = sign_extend32(*val >> shift, 15 - shift);
> +		*val = sign_extend32(*val >> chan->scan_type.shift,
> +				     chan->scan_type.realbits - 1);
>  
>  		ret = ads1015_set_power_state(data, false);
>  		if (ret < 0)
> @@ -497,7 +496,6 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
>  release_direct:
>  		iio_device_release_direct_mode(indio_dev);
>  		break;
> -	}
>  	case IIO_CHAN_INFO_SCALE:
>  		idx = data->channel_data[chan->address].pga;
>  		*val = ads1015_fullscale_range[idx];

