Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F417D1B87B1
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDYQYp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgDYQYp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:24:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2104C20714;
        Sat, 25 Apr 2020 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587831884;
        bh=qOkE46JihjYcmTYObg5JClyEV8HDRPgl6K6r6bkhKq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZEY7Qhjn6exNWzw6Kctyl4C/GttuwFE8nzqaUqRRbELdxWSwURMQWQP6LSR9ohYTZ
         Ti2DLb2bD/sPtpnL2vW/rEVCZ/c31H345dF7nHrTrQJ4115pFOv3ZfZTDPbGP28sXH
         bzDLAss9iXqSrXZdWgrbdNgjFpTdsx02H26+xSps=
Date:   Sat, 25 Apr 2020 17:24:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 03/16] iio: adc: ti-ads124s08: Use
 get_unaligned_be24()
Message-ID: <20200425172441.2f2c3dab@archlinux>
In-Reply-To: <20200421003135.23060-3-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:22 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Added
#include <asm/unaligned.h>
and applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads124s08.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index 552c2be8d87a..2516e42ad00d 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -188,7 +188,6 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
>  {
>  	struct ads124s_private *priv = iio_priv(indio_dev);
>  	int ret;
> -	u32 tmp;
>  	struct spi_transfer t[] = {
>  		{
>  			.tx_buf = &priv->data[0],
> @@ -208,9 +207,7 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
>  	if (ret < 0)
>  		return ret;
>  
> -	tmp = priv->data[2] << 16 | priv->data[3] << 8 | priv->data[4];
> -
> -	return tmp;
> +	return get_unaligned_be24(&priv->data[2]);
>  }
>  
>  static int ads124s_read_raw(struct iio_dev *indio_dev,

