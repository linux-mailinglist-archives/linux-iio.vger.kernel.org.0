Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC933977E6
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jun 2021 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhFAQYm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Jun 2021 12:24:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3124 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFAQYl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jun 2021 12:24:41 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvcfW5LV5z6Q2Tp;
        Wed,  2 Jun 2021 00:13:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 18:22:58 +0200
Received: from localhost (10.52.121.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 1 Jun 2021
 17:22:57 +0100
Date:   Tue, 1 Jun 2021 17:22:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     <peda@axentia.se>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v1 3/9] iio: afe: rescale: use core to get processed
 value
Message-ID: <20210601172252.00007f5c@Huawei.com>
In-Reply-To: <20210530005917.20953-4-liambeguin@gmail.com>
References: <20210530005917.20953-1-liambeguin@gmail.com>
        <20210530005917.20953-4-liambeguin@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.71]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 May 2021 20:59:11 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Make use of the IIO core to compute the source channel's processed
> value. This reduces duplication and will facilitate the addition of
> offsets in the iio-rescale driver.

Fairly sure you just dropped a lot or precision if the devices do provide
a scale.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 37 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index e42ea2b1707d..4d0813b274d1 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -38,36 +38,20 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct rescale *rescale = iio_priv(indio_dev);
> -	unsigned long long tmp;
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		return iio_read_channel_raw(rescale->source, val);
> +		ret = iio_read_channel_processed(rescale->source, val);

iio_read_channel_processed() provides a IIO_VAL_INT as you can see.
Now that can be heavily truncated.  In some cases it is always 0
(e.g. device reading very small currents only).

To maintain that scaling we deliberately combine it with the
scaling from the afe, hopefully maintaining that precision because
the scale value has much higher degree of precision.

We could probably do this better than currently with a more complex
conversion function.

It might seem like a good idea to fix up iio_read_channel_processed
to return IIO_VAL_INT_PLUS_MICRO or similar, but potentially that
would still throw away precision, for example if the scale is
expressed as IIO_VAL_FRACTIONAL to a high degree of precision.

Jonathan

>  
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = iio_read_channel_scale(rescale->source, val, val2);
> -		switch (ret) {
> -		case IIO_VAL_FRACTIONAL:
> -			*val *= rescale->numerator;
> -			*val2 *= rescale->denominator;
> -			return ret;
> -		case IIO_VAL_INT:
> -			*val *= rescale->numerator;
> -			if (rescale->denominator == 1)
> -				return ret;
> -			*val2 = rescale->denominator;
> -			return IIO_VAL_FRACTIONAL;
> -		case IIO_VAL_FRACTIONAL_LOG2:
> -			tmp = *val * 1000000000LL;
> -			do_div(tmp, rescale->denominator);
> -			tmp *= rescale->numerator;
> -			do_div(tmp, 1000000000LL);
> -			*val = tmp;
> -			return ret;
> -		default:
> -			return -EOPNOTSUPP;
> -		}
> +		*val = rescale->numerator;
> +		if (rescale->denominator == 1)
> +			return IIO_VAL_INT;
> +		*val2 = rescale->denominator;
> +
> +		return IIO_VAL_FRACTIONAL;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -130,9 +114,8 @@ static int rescale_configure_channel(struct device *dev,
>  	chan->ext_info = rescale->ext_info;
>  	chan->type = rescale->cfg->type;
>  
> -	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
> -	    !iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
> -		dev_err(dev, "source channel does not support raw/scale\n");
> +	if (!iio_channel_has_info(schan, IIO_CHAN_INFO_RAW)) {
> +		dev_err(dev, "source channel does not support raw\n");
>  		return -EINVAL;
>  	}
>  

