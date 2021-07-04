Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681C53BADD4
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhGDQiJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 12:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDQiJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 12:38:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98646613C8;
        Sun,  4 Jul 2021 16:35:30 +0000 (UTC)
Date:   Sun, 4 Jul 2021 17:37:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <20210704173754.64919405@jic23-huawei>
In-Reply-To: <20210701010034.303088-6-liambeguin@gmail.com>
References: <20210701010034.303088-1-liambeguin@gmail.com>
        <20210701010034.303088-6-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 21:00:29 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> Add IIO_VAL_INT_PLUS_{NANO,MICRO} scaling support.
> Scale the integer part and the decimal parts individually and keep the
> original scaling type.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 98bcb5d418d6..8f79c582519c 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -87,7 +87,16 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			do_div(tmp, 1000000000LL);
>  			*val = tmp;
>  			return ret;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			fallthrough;

As earlier, I'm fairly sure you don't need this (but I could be wrong,
so if I am wrong point me at a reference).

> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp = (s64)*val * rescale->numerator;
> +			*val = div_s64(tmp, rescale->denominator);
> +			tmp = (s64)*val2 * rescale->numerator;
> +			*val2 = div_s64(tmp, rescale->denominator);
> +			return ret;
>  		default:
> +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
>  			return -EOPNOTSUPP;
>  		}
>  	default:

