Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67909ED2D2
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfKCKZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:25:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCKZ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:25:29 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3093420842;
        Sun,  3 Nov 2019 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572776728;
        bh=WTxM6Ibc3QKJyTK44KnaxTI2l5Cnh8TX3bpCQRrlJiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=By0JoHd+51ISddgZr38vjridT5SBZUNUxWjemOsBwYzXcHmwnnWeAK1p+wudettyx
         NxkcuL4Lm8qYlm8eeGSsD/pnyvTDqAh5/8cXpmXDn3f9PePNAue3GT/MIJRKypw+Wc
         /iU0HHVIxoxt8C8aGQnC3ClXCa9lk20JB3TQ1T0E=
Date:   Sun, 3 Nov 2019 10:25:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 03/10] iio: imu: adis16460: check ret val for non-zero
 vs less-than-zero
Message-ID: <20191103102524.2b5e05cc@archlinux>
In-Reply-To: <20191101093505.9408-4-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:34:58 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS library functions return zero on success, and negative values for
> error. Positive values aren't returned, but we only care about the success
> value (which is zero).
> 
> This change is mostly needed so that the compiler won't make any inferences
> about some about values being potentially un-initialized. This only
> triggers after making some functions inline, because the compiler can
> better follow return paths.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied thanks.

Jonathan

> ---
>  drivers/iio/imu/adis16460.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 6aed9e84abbf..b55812521537 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -80,7 +80,7 @@ static int adis16460_show_serial_number(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_16(&adis16460->adis, ADIS16460_REG_SERIAL_NUM,
>  		&serial);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = serial;
> @@ -98,7 +98,7 @@ static int adis16460_show_product_id(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_16(&adis16460->adis, ADIS16460_REG_PROD_ID,
>  		&prod_id);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = prod_id;
> @@ -116,7 +116,7 @@ static int adis16460_show_flash_count(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_32(&adis16460->adis, ADIS16460_REG_FLASH_CNT,
>  		&flash_count);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = flash_count;
> @@ -176,7 +176,7 @@ static int adis16460_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
>  	unsigned int freq;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16460_REG_DEC_RATE, &t);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	freq = 2048000 / (t + 1);

