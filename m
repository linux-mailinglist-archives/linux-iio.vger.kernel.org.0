Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B233CC4A4
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhGQRAB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 13:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhGQRAA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 13:00:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9B3610F9;
        Sat, 17 Jul 2021 16:57:01 +0000 (UTC)
Date:   Sat, 17 Jul 2021 17:59:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: buffer: Move a sanity check at the beginning
 of 'iio_scan_mask_set()'
Message-ID: <20210717175925.17091e96@jic23-huawei>
In-Reply-To: <98a351adda1908c306e981b9cc86d3dbc79eb5ec.1626261211.git.christophe.jaillet@wanadoo.fr>
References: <89d8a766eb971eda1ee362444a8711037bdb208c.1626261211.git.christophe.jaillet@wanadoo.fr>
        <98a351adda1908c306e981b9cc86d3dbc79eb5ec.1626261211.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Jul 2021 13:14:51 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> This is more standard to have sanity checks at the entry of a function,
> instead of allocating some memory first and having to free it if a
> condition is not met.

Indeed this is silly.  I'd guess result of code evolution, but perhaps
I was crazy in the first place :)

Applied,

Thanks,

Jonathan

> 
> Shuffle code a bit to check 'masklength' before calling 'bitmap_alloc()'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/iio/industrialio-buffer.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 6d4776a7f002..a95cc2da56be 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -354,13 +354,14 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
> -	if (!trialmask)
> -		return -ENOMEM;
>  	if (!indio_dev->masklength) {
>  		WARN(1, "Trying to set scanmask prior to registering buffer\n");
> -		goto err_invalid_mask;
> +		return -EINVAL;
>  	}
> +
> +	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
> +	if (!trialmask)
> +		return -ENOMEM;
>  	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
>  	set_bit(bit, trialmask);
>  

