Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8AD2C7524
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgK1Vt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbgK1S7o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 13:59:44 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6392467D;
        Sat, 28 Nov 2020 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606571680;
        bh=EQteL+c74mRL4e+NuB8VT4Ykr2TJi8KcKP+ixqxUUmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sjDK79wORRbnsukahdrFaYyzTLaYdTlW/UttXDfCCQMx1+BNaK0m40iX9rD1bYEEg
         IXxdwLxJw8HeBFWaeyZI5P88N+RdnIjBn5VMBBjftrdQvvx2sRr5h9JPSIOI1K7Xvi
         ZdKXtMV5LKeeDL3CyivVtFjQmv59d3KT7YuipxP8=
Date:   Sat, 28 Nov 2020 13:54:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     andy.shevchenko@gmail.com, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] iio:core: Introduce unlocked version of
 iio_map_array_unregister()
Message-ID: <20201128135435.33e9f6ee@archlinux>
In-Reply-To: <1606571059-13974-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1606571059-13974-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Nov 2020 14:44:18 +0100
Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:

> Introduce an unlocked version of iio_map_array_unregister(). This function
> can help to unwind in case of error while the iio_map_list_lock mutex is
> held.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Hi.

The mailing list is having issues today and as I use b4 to pull patches
from lore.kernel.org I can't easily pick this up.

I had as you've probably guessed forgotten about this one.
A few notes to make it harder for people to do that in future.
1. Don't send patch series (or new versions of older patches) in reply
   to an existing thread.   They get lost and difficult to pull out.
   b4 can't automatically figure out which patches to pull from that
   original thread for example.
2. Always version number whole series with same number, even if some patches
   are new.   So this should be v3.

Anyhow, I'll pick up this resend once the mailing list recovers or I get
annoyed enough to do it the old fashioned manual way.

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ede99e0..39c1d63 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -24,6 +24,21 @@ struct iio_map_internal {
>  static LIST_HEAD(iio_map_list);
>  static DEFINE_MUTEX(iio_map_list_lock);
>  
> +static int iio_map_array_unregister_locked(struct iio_dev *indio_dev)
> +{
> +	int ret = -ENODEV;
> +	struct iio_map_internal *mapi, *next;
> +
> +	list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
> +		if (indio_dev == mapi->indio_dev) {
> +			list_del(&mapi->l);
> +			kfree(mapi);
> +			ret = 0;
> +		}
> +	}
> +	return ret;
> +}
> +
>  int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  {
>  	int i = 0, ret = 0;
> @@ -57,18 +72,12 @@ EXPORT_SYMBOL_GPL(iio_map_array_register);
>   */
>  int iio_map_array_unregister(struct iio_dev *indio_dev)
>  {
> -	int ret = -ENODEV;
> -	struct iio_map_internal *mapi, *next;
> +	int ret;
>  
>  	mutex_lock(&iio_map_list_lock);
> -	list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
> -		if (indio_dev == mapi->indio_dev) {
> -			list_del(&mapi->l);
> -			kfree(mapi);
> -			ret = 0;
> -		}
> -	}
> +	ret = iio_map_array_unregister_locked(indio_dev);
>  	mutex_unlock(&iio_map_list_lock);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iio_map_array_unregister);

