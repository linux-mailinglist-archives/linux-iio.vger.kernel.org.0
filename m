Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE253300DA
	for <lists+linux-iio@lfdr.de>; Sun,  7 Mar 2021 13:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCGM3s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Mar 2021 07:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhCGM3s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Mar 2021 07:29:48 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD4D650F8;
        Sun,  7 Mar 2021 12:29:47 +0000 (UTC)
Date:   Sun, 7 Mar 2021 12:29:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: kfifo: mask flags without zero-check in
 devm_iio_kfifo_buffer_setup()
Message-ID: <20210307122944.2276f633@archlinux>
In-Reply-To: <20210306162834.7339-1-ardeleanalex@gmail.com>
References: <20210306162834.7339-1-ardeleanalex@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  6 Mar 2021 18:28:34 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> As pointed by Lars, this doesn't require a zero-check. Also, while looking
> at this a little closer at it (again), the masking can be done later, as
> there is a zero-check for 'mode_flags' anyway, which returns -EINVAL. And
> we only need the 'mode_flags' later in the logic.
> 
> This change is more of a tweak.
> 
> Fixes: ae9886d6aa29 ("iio: kfifo: add devm_iio_kfifo_buffer_setup() helper")
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>

I've applied this as a separate patch.  Thanks,

Jonathan

> ---
> 
> Apologies for the late-ness of this.
> I don't know if this makes sense to squash in the original, or to have
> as a fix commit.
> It is a bit messy now that the original is committed into the tree,
> and now we're fixing/tweaking it.
> 
>  drivers/iio/buffer/kfifo_buf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index e8a434f84778..8e3a1a9e495c 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -275,9 +275,6 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
>  {
>  	struct iio_buffer *buffer;
>  
> -	if (mode_flags)
> -		mode_flags &= kfifo_access_funcs.modes;
> -
>  	if (!mode_flags)
>  		return -EINVAL;
>  
> @@ -285,6 +282,8 @@ int devm_iio_kfifo_buffer_setup(struct device *dev,
>  	if (!buffer)
>  		return -ENOMEM;
>  
> +	mode_flags &= kfifo_access_funcs.modes;
> +
>  	indio_dev->modes |= mode_flags;
>  	indio_dev->setup_ops = setup_ops;
>  

