Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98C73CC4A1
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jul 2021 18:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhGQQ7I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jul 2021 12:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhGQQ7I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Jul 2021 12:59:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97118610F9;
        Sat, 17 Jul 2021 16:56:09 +0000 (UTC)
Date:   Sat, 17 Jul 2021 17:58:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: buffer: Save a few cycles in
 'iio_scan_mask_set()'
Message-ID: <20210717175832.2f3f8116@jic23-huawei>
In-Reply-To: <89d8a766eb971eda1ee362444a8711037bdb208c.1626261211.git.christophe.jaillet@wanadoo.fr>
References: <89d8a766eb971eda1ee362444a8711037bdb208c.1626261211.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Jul 2021 13:14:41 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Use 'bitmap_alloc()' instead of 'bitmap_zalloc()' because the bitmap
> is fully overridden by a 'bitmap_copy()' call just after its allocation.
> 
> While at it, fix the style of a NULL check.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index fdd623407b96..6d4776a7f002 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -354,8 +354,8 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
> -	if (trialmask == NULL)
> +	trialmask = bitmap_alloc(indio_dev->masklength, GFP_KERNEL);
> +	if (!trialmask)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
>  		WARN(1, "Trying to set scanmask prior to registering buffer\n");

