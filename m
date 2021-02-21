Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4261E320B58
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 16:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBUP1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 10:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUP1Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 10:27:24 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12AB64EF1;
        Sun, 21 Feb 2021 15:26:41 +0000 (UTC)
Date:   Sun, 21 Feb 2021 15:26:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ioana Ciornei <ciorneiioana@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adis16400: Fix an error code in
 adis16400_initial_setup()
Message-ID: <20210221152638.162fc405@archlinux>
In-Reply-To: <YCwgFb3JVG6qrlQ+@mwanda>
References: <YCwgFb3JVG6qrlQ+@mwanda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Feb 2021 22:42:13 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This is to silence a new Smatch warning:
> 
>     drivers/iio/imu/adis16400.c:492 adis16400_initial_setup()
>     warn: sscanf doesn't return error codes
> 
> If the condition "if (st->variant->flags & ADIS16400_HAS_SLOW_MODE) {"
> is false then we return 1 instead of returning 0 and probe will fail.
> 
> Fixes: 72a868b38bdd ("iio: imu: check sscanf return value")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hi Dan,

May be worth a follow up at some point to get rid of the silliness
of goto err_ret by using direct returns.  Obviously that is a rather
less minimal fix however so not so good for backports.

Hence, applied this to the fixes-togreg branch of iio.git and marked
for stable. 

Thanks,


Jonathan

> ---
>  drivers/iio/imu/adis16400.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 54af2ed664f6..785a4ce606d8 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -462,8 +462,7 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
>  		if (ret)
>  			goto err_ret;
>  
> -		ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
> -		if (ret != 1) {
> +		if (sscanf(indio_dev->name, "adis%u\n", &device_id) != 1) {
>  			ret = -EINVAL;
>  			goto err_ret;
>  		}

