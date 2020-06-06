Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71751F07D5
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgFFQL6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 12:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbgFFQL6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 12:11:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F9A20772;
        Sat,  6 Jun 2020 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591459918;
        bh=5nTYU96E9V/b22ZpW8mYRNyFiqDSTfluQthuqiDTznk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mjquTdMZ4SN7cL0+zUmV6S27yeiiIJEfWCMBlCI9zf1q5UMT46JdIXwpBWMkcdIRd
         PeVbY2KJVRoJnDLKIROq1sIFKk0xuPvAfC+61ybn8KtLCchKQSzuq5RtZEQ/iIXwby
         pBgHrqXf4PwLkIca6LbIwPUDkxlnpMdoQNnkJTFQ=
Date:   Sat, 6 Jun 2020 17:11:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: Re: [PATCH] io: pressure: zpa2326: handle pm_runtime_get_sync
 failure
Message-ID: <20200606171153.6824a326@archlinux>
In-Reply-To: <20200605024445.35672-1-navid.emamdoost@gmail.com>
References: <20200605024445.35672-1-navid.emamdoost@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  4 Jun 2020 21:44:44 -0500
Navid Emamdoost <navid.emamdoost@gmail.com> wrote:

> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Hi Navid,

This looks to be a fix, be it for a case that we are hopefully
unlikely to ever hit.  Please could you add an appropriate
Fixes tag so we can work out how far to backport it?

Patch looks good to me so if you just reply with a suitable
tag I can add it whilst applying.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/zpa2326.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 99dfe33ee402..245f2e2d412b 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -664,8 +664,10 @@ static int zpa2326_resume(const struct iio_dev *indio_dev)
>  	int err;
>  
>  	err = pm_runtime_get_sync(indio_dev->dev.parent);
> -	if (err < 0)
> +	if (err < 0) {
> +		pm_runtime_put(indio_dev->dev.parent);
>  		return err;
> +	}
>  
>  	if (err > 0) {
>  		/*

