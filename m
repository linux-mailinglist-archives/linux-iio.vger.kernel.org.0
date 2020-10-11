Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963F428A7E8
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 17:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgJKPHy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 11:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgJKPHy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 11:07:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C51322227;
        Sun, 11 Oct 2020 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602428873;
        bh=K95hkdd7AoNjuHnqL45zkddYXasQVQJRtZtgB5dyItc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OgMkmb0XX6JiA9+Um7Bu7rEAXBh0noynOT+tZ3bYWXro4Dethf7hJHKyDGYQpMJac
         BinOe0VdXv7H3MikGOgUo0hlHf0EJUTWoYoYo2kDr2hUPg4kTzb6hOlGHvgeznO7hX
         ipYcw0/uB4rPNxf7VJfUPqwWGh4nE/HfhkEHMomg=
Date:   Sun, 11 Oct 2020 16:07:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:core: In map_array_register() cleanup in case of
 error
Message-ID: <20201011160748.4a47b889@archlinux>
In-Reply-To: <1602420080-15905-1-git-send-email-LinoSanfilippo@gmx.de>
References: <1602420080-15905-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Oct 2020 14:41:20 +0200
Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:

> In function map_array_register() properly rewind in case of error.
> Furthermore save an extra label by using a break instead of goto to leave
> the concerning loop.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Good spot. I'd rather we went with a different code flow though.
See below.

Thanks,

Jonathan


> ---
>  drivers/iio/inkern.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 5a8351c..0735cc4 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -28,6 +28,7 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  {
>  	int i = 0, ret = 0;
>  	struct iio_map_internal *mapi;
> +	struct list_head *pos, *tmp;
> 
>  	if (maps == NULL)
>  		return 0;
> @@ -37,14 +38,22 @@ int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
>  		mapi = kzalloc(sizeof(*mapi), GFP_KERNEL);
>  		if (mapi == NULL) {
>  			ret = -ENOMEM;
> -			goto error_ret;
> +			break;
>  		}
>  		mapi->map = &maps[i];
>  		mapi->indio_dev = indio_dev;
>  		list_add_tail(&mapi->l, &iio_map_list);
>  		i++;
>  	}
> -error_ret:
> +
Please do this as a a separate error path rather than having
it as non trivial unwinding in the main code flow.

i.e. goto error_ret, but handle that path separately after
the return below.

> +	if (ret) { /* undo */
> +		while (i--) {
> +			mapi = list_last_entry(&iio_map_list,
> +					       struct iio_map_internal, l);
> +			list_del(&mapi->l);
> +			kfree(mapi);
> +		}
> +	}
>  	mutex_unlock(&iio_map_list_lock);
> 
>  	return ret;
> --
> 2.7.4
> 

