Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3C174D0A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Mar 2020 12:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgCALt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Mar 2020 06:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCALt1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Mar 2020 06:49:27 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397D720880;
        Sun,  1 Mar 2020 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583063367;
        bh=lqv6k2AUqcf3ik7NpXV+GV0FZoPOJtzPmrajVNG6J7s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SHtuB4nipbFBPN0BXcNhPoc/iWt1v/4dxXD3uXZ4GVrcel6MqrVlCJSaF6TIqNcdH
         UEnR2gP2ayIBQPVJwYK+1no8AlruoDH0tRU84x6rCtKxTZRwl9yIjPeonMgUG3ySzk
         3C0hn/+I6p1NKAbL+LPLBVAPb7RkizD3CHlmuaD0=
Date:   Sun, 1 Mar 2020 11:49:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, grekh@linuxfoundation.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v3] staging: iio: update TODO
Message-ID: <20200301114922.6117def9@archlinux>
In-Reply-To: <5e5a6fbd.1c69fb81.f08c3.4cf0@mx.google.com>
References: <5e5a6fbd.1c69fb81.f08c3.4cf0@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Feb 2020 19:35:45 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Since there are no uses of the old GPIO API, remove the item from
> the TODO.
> 
> Changelog
> v3: Remove new items added.
> v2: Add work item mentioned by Alexandru in
> https://marc.info/?l=linux-iio&m=158261515624212&w=2
Change log belongs below the --- as we don't want this info in the
git history. I've tidied up and applied to the togreg branch of iio.git
(pushed out as testing for the autobuilders to play with it).

Thanks,

Jonathan

> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
> ---
>  drivers/staging/iio/TODO | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> index 1b8ebf2c1b69..4d469016a13a 100644
> --- a/drivers/staging/iio/TODO
> +++ b/drivers/staging/iio/TODO
> @@ -1,10 +1,4 @@
> -2018-04-15
> -
> -All affected drivers:
> -Convert all uses of the old GPIO API from <linux/gpio.h> to the
> -GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
> -lines from device tree, ACPI or board files, board files should
> -use <linux/gpio/machine.h>.
> +2020-02-25
>  
>  
>  ADI Drivers:

