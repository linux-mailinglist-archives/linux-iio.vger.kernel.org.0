Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F993A1E1E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 22:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhFIUcw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 16:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhFIUcv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 16:32:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64DF761278;
        Wed,  9 Jun 2021 20:30:54 +0000 (UTC)
Date:   Wed, 9 Jun 2021 21:32:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     peda@axentia.se, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 4/8] iio: inkern: return valid type on raw to
 processed conversion
Message-ID: <20210609213247.2ad09186@jic23-huawei>
In-Reply-To: <20210607144718.1724413-5-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
        <20210607144718.1724413-5-liambeguin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Jun 2021 10:47:14 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> From: Liam Beguin <lvb@xiphos.com>
> 
> iio_convert_raw_to_processed_unlocked() applies the offset and scale of
> a channel on it's raw value.
> The processed value returned is always an integer. Return IIO_VAL_INT so
> that consumers can use this return value directly.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
This looks likely to cause breakage given that return value will go to
consumers directly via iio_convert_raw_to_processed()

Looks like this will break lmp91000 which checks for error as

if (ret)

> ---
>  drivers/iio/inkern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 0b5667f22b1d..00d234e87234 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -618,7 +618,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  		 * raw value and return.
>  		 */
>  		*processed = raw * scale;
> -		return 0;
> +		return IIO_VAL_INT;
>  	}
>  
>  	switch (scale_type) {
> @@ -652,7 +652,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> +	return IIO_VAL_INT;
>  }
>  
>  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,

