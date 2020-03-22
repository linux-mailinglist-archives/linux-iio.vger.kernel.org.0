Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A018EAA1
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVRBk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVRBk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:01:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49FF20724;
        Sun, 22 Mar 2020 17:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584896499;
        bh=fRgZZMF3O8FsJEBNZuwdEDytSWq+gORzarwQbFC502M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=icTarVVZBn8HYnGaH7DB2idV9R5zd0ChanKmPcbwcm+MUn6QvqZVMti4e75xzTDDc
         EO8N+2l3FlE58AzsWiD2tqjxHBf09vfYEeg0cTnHHB2RcK6otA4nGfuz0uAcRd4Z7i
         qoiBKz44XQNNjqLn77Kx6gyYSO3EGUolGKyyGzcU=
Date:   Sun, 22 Mar 2020 17:01:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: buffer: re-introduce bitmap_zalloc() for
 trialmask
Message-ID: <20200322170131.3e83f0bd@archlinux>
In-Reply-To: <20200321085956.11213-1-alexandru.ardelean@analog.com>
References: <20200317123621.27722-1-alexandru.ardelean@analog.com>
        <20200321085956.11213-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 10:59:56 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Commit 3862828a903d3 ("iio: buffer: Switch to bitmap_zalloc()") introduced
> bitmap_alloc(), but commit 20ea39ef9f2f9 ("iio: Fix scan mask selection")
> reverted it.
> 
> This change adds it back. The only difference is that it's adding
> bitmap_zalloc(). There might be some changes later that would require
> initializing it to zero. In any case, now it's already zero-ing the
> trialmask.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke it.

Thanks,

Jonathan
> ---
> 
> Changelog v1 -> v2:
> * add 'Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>' 
> * re-send from an Analog server; GMail changed the author to @gmail.com
> 
>  drivers/iio/industrialio-buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4ada5592aa2b..5ff34ce8b6a2 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -316,8 +316,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> -			    sizeof(*trialmask), GFP_KERNEL);
> +	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {

