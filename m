Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC2C22C645
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 15:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGXNYq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 09:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbgGXNYq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Jul 2020 09:24:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 480D1206D7;
        Fri, 24 Jul 2020 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595597084;
        bh=4z1/bmUznRinKUdWY6aWYIBGEwRBUUbAdUZSqMcyOBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmpO6zc+ZuhbxqKkL5uICah+JraY0XPPS4SWKneXFPskhLg1PRrZS1VvLCRppv8dr
         K8782LpmV+2uJuH4yV5YcId/scA3ctaQRBEAS7rIQSx/2Dtl+3WLnRY53z1EcS5/oI
         Qi0HHuZ8N5jqrN+QHfAwAnW9um0b8tqNemXUGYCg=
Date:   Fri, 24 Jul 2020 15:24:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabrizio Benedetti <fabrizio.benedetti.82@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_agm1264k-fl.c: Replaced udelay by
 usleep_range
Message-ID: <20200724132446.GB316746@kroah.com>
References: <20200724100907.GA8977@fbenedet-HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724100907.GA8977@fbenedet-HP>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 24, 2020 at 12:09:07PM +0200, Fabrizio Benedetti wrote:
> This patch replace udelay with usleep_range
> according to the Documentation/timers/timers-howto.txt .
> The usleep_range have a range that is >= of udelay.
> 
> Signed-off-by: Fabrizio Benedetti <fabrizio.benedetti.82@gmail.com>
> ---
>  drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
> index eeeeec97ad27..4a67a660bb17 100644
> --- a/drivers/staging/fbtft/fb_agm1264k-fl.c
> +++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
> @@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
>  	dev_dbg(par->info->device, "%s()\n", __func__);
>  
>  	gpiod_set_value(par->gpio.reset, 0);
> -	udelay(20);
> +	usleep_range(20, 25);

And are you sure that 25 is ok here?

Unless you have the hardware, don't make up random numbers for things
like delays :)

Also, be sure you use the correct mailing lists, why did you ignore the
output of scripts/get_maintainer.pl for this patch?

thanks,

greg k-h
