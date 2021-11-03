Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFA4448A9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhKCS4F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 14:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhKCS4F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 14:56:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D985660EBB;
        Wed,  3 Nov 2021 18:53:26 +0000 (UTC)
Date:   Wed, 3 Nov 2021 18:58:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: mpl3115: Use scan_type.shift and realbit in
 mpl3115_read_raw
Message-ID: <20211103185801.166a3d62@jic23-huawei>
In-Reply-To: <20211101071822.522178-5-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
        <20211101071822.522178-5-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Nov 2021 00:18:22 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> When processing raw data using channel scan_type.shift as source of
> trust to shift data appropriately.
> When processing the temperature channel, use a 16bit big endian variable
> as buffer to increase conversion readability.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

This one looks fine to me, will pick up when rest are read if no
one else comments,

Jonathan

> ---
>  drivers/iio/pressure/mpl3115.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 1eb9e7b29e050..e95b9a5475b4e 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -74,7 +74,6 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct mpl3115_data *data = iio_priv(indio_dev);
> -	__be32 tmp = 0;
>  	int ret;
>  
>  	switch (mask) {
> @@ -84,7 +83,9 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		switch (chan->type) {
> -		case IIO_PRESSURE: /* in 0.25 pascal / LSB */
> +		case IIO_PRESSURE: { /* in 0.25 pascal / LSB */
> +			__be32 tmp = 0;
> +
>  			mutex_lock(&data->lock);
>  			ret = mpl3115_request(data);
>  			if (ret < 0) {
> @@ -96,10 +97,13 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>  			mutex_unlock(&data->lock);
>  			if (ret < 0)
>  				break;
> -			*val = be32_to_cpu(tmp) >> 12;
> +			*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
>  			ret = IIO_VAL_INT;
>  			break;
> -		case IIO_TEMP: /* in 0.0625 celsius / LSB */
> +		}
> +		case IIO_TEMP: { /* in 0.0625 celsius / LSB */
> +			__be16 tmp;
> +
>  			mutex_lock(&data->lock);
>  			ret = mpl3115_request(data);
>  			if (ret < 0) {
> @@ -111,9 +115,11 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>  			mutex_unlock(&data->lock);
>  			if (ret < 0)
>  				break;
> -			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
> +			*val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
> +					     chan->scan_type.realbits - 1);
>  			ret = IIO_VAL_INT;
>  			break;
> +		}
>  		default:
>  			ret = -EINVAL;
>  			break;

