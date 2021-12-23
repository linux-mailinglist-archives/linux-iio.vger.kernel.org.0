Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E0747E413
	for <lists+linux-iio@lfdr.de>; Thu, 23 Dec 2021 14:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348384AbhLWN06 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Dec 2021 08:26:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52550 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348338AbhLWN05 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Dec 2021 08:26:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A153161E51
        for <linux-iio@vger.kernel.org>; Thu, 23 Dec 2021 13:26:57 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 3AEF7C36AE5;
        Thu, 23 Dec 2021 13:26:52 +0000 (UTC)
Date:   Thu, 23 Dec 2021 13:32:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/13] iio: ad9523: Use sysfs_emit()
Message-ID: <20211223133228.5ae582af@jic23-huawei>
In-Reply-To: <20211216185217.1054495-5-lars@metafoo.de>
References: <20211216185217.1054495-1-lars@metafoo.de>
        <20211216185217.1054495-5-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 19:52:08 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> knows about the sysfs buffer specifics and has some built-in checks for
> size and alignment.
> 
> Use sysfs_emit() to format the custom device attributes of the ad9523
> driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/frequency/ad9523.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index bdb0bc3b12dd..a0f92c336fc4 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -551,7 +551,7 @@ static ssize_t ad9523_show(struct device *dev,
>  	mutex_lock(&st->lock);
>  	ret = ad9523_read(indio_dev, AD9523_READBACK_0);
>  	if (ret >= 0) {
> -		ret = sprintf(buf, "%d\n", !!(ret & (1 <<
> +		ret = sysfs_emit(buf, "%d\n", !!(ret & (1 <<
>  			(u32)this_attr->address)));

Obviously not due to this patch, but that's some horrible line breaking.
I might just tidy that up whilst applying this - or send a follow up to
do it.

>  	}
>  	mutex_unlock(&st->lock);

