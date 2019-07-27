Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF9277882
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 13:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfG0L5y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 07:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfG0L5y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 07:57:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3D5A2077C;
        Sat, 27 Jul 2019 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564228673;
        bh=Qt1Rf8kXzBIqNTkx2KISu/ts1iMKogFu67lTKS8akwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v/HEhMy0bQOo4vFVcF94DEwwyVIWHx7+pCMkhVSsEY3OVeC7TUfFW103L3KbvqJcq
         VH7Za++mrEkiLmJgYnQmayvu3G2mS8ZXy5dlfL/mFHkeyodeVaG989Xpg1V39kKTNS
         guPhMWIvdhu0M9ba8dA+QI6Yij3H8KPpAqd+Zdv0=
Date:   Sat, 27 Jul 2019 12:57:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: Use device-managed API
Message-ID: <20190727125749.63297c28@archlinux>
In-Reply-To: <20190726123058.22915-1-hslester96@gmail.com>
References: <20190726123058.22915-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 20:30:58 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use devm_iio_device_register to simplify
> the code.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Please try to pick up on likely reviewers in your cc list.  In this case
Brian did a lot of work cleaning these drivers up so I've added him.
Not everyone keeps up with the linux-iio list for some reason ;)

Immediate thought was that you had broken the ordering but turns out
it is already buggy.

As things stand, we remove the userspace interfaces (iio_device_unregister)
after turning off the power.   This is obviously a bad idea and also
form a purely "obviously correct" stand point, we aren't doing the reverse
of probe.

So, I 'think' the right option is to reorder remove so that the power left
on until after the iio_device_unregister call. At that point, we can't
use devm_iio_device_register as we'll have the same incorrect ordering
we currently have.

Brian, you looked at this driver most recently.  Thoughts?

Thanks,

Jonathan



> ---
>  drivers/iio/light/tsl2772.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 83cece921843..aa5891d105e8 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1877,7 +1877,7 @@ static int tsl2772_probe(struct i2c_client *clientp,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&clientp->dev, indio_dev);
>  	if (ret) {
>  		tsl2772_chip_off(indio_dev);
>  		dev_err(&clientp->dev,
> @@ -1928,8 +1928,6 @@ static int tsl2772_remove(struct i2c_client *client)
>  
>  	tsl2772_chip_off(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	return 0;
>  }
>  

