Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20082B2E36
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 16:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgKNPqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 10:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgKNPqq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 10:46:46 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B4522254;
        Sat, 14 Nov 2020 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605368806;
        bh=goHaolbjw30a+EKdHtSQX6pyt5XC1BydKi65tudi8MU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TwG4XwTitBBCcrpR8+kmM/0aTv9tvgTIRPnygVP4/I5RGNYKJKN0Tf+yP5idzt2aR
         HqYVW1XDcVYksnkogG7/mUPcwya8GXjbPxTQ/hhe6GnekdZ/Y0LTpaXZob8uiLnWrr
         1TYS+w1rkbhw/yDwc3O3iZjxCHLspQQVYarqU250=
Date:   Sat, 14 Nov 2020 15:46:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/4] device: provide devm_krealloc_array()
Message-ID: <20201114154641.0258f4ee@archlinux>
In-Reply-To: <20201102142228.14949-2-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
        <20201102142228.14949-2-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Nov 2020 15:22:25 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> When allocating an array of elements, users should check for
> multiplication overflow or preferably use one of the provided helpers
> like: devm_kmalloc_array().
> 
> This provides devm_krealloc_array() for users who want to reallocate
> managed arrays.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

+CC Greg KH. 

As this is going into a very generic place I'd like a relevant ack.
That file is a bit of a wild west for acks, but Greg seems most
appropriate person.

So Greg, any comments on this one?

Thanks,

Jonathan

> ---
>  include/linux/device.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 5ed101be7b2e..e77203faea55 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -226,6 +226,17 @@ static inline void *devm_kmalloc_array(struct device *dev,
>  
>  	return devm_kmalloc(dev, bytes, flags);
>  }
> +static inline void *
> +devm_krealloc_array(struct device *dev, void *ptr, size_t new_n,
> +		    size_t new_size, gfp_t gfp)
> +{
> +	size_t bytes;
> +
> +	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> +		return NULL;
> +
> +	return devm_krealloc(dev, ptr, bytes, gfp);
> +}
>  static inline void *devm_kcalloc(struct device *dev,
>  				 size_t n, size_t size, gfp_t flags)
>  {

