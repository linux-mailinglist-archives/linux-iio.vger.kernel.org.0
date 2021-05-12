Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67AA37C0B3
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhELOvy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 10:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhELOvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 10:51:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92D8560D07;
        Wed, 12 May 2021 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831003;
        bh=5Unu48Z8aR0Vut0JJNdVeezm8/I9DMdbL/cT0VY7vhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gdd6WeyHznrpz1S7YMSTjx5TMjgw5lCLBrBF7xO+cElHAOYOocOc8Vbqb8pSwfIIf
         WseRbsnQwvtVambjjbCw/hm3/7HHPXTbwx/ZxwgAPADCXYjdcvIT8JiLQLEcSgAbdJ
         PnFyD+0izD0B6XfBxAB5gOgXczzwMbsLCuovE9omV1z0DsDW6MmMv4uhjR3RrBl57Z
         IUA7X+BPIYOolmfZq3HT/wJaleC1NT3mWS5sd5j6ubYyglpi+7HHUIwtDrfAgeCJep
         UFRlWvLokDHNEo4WhoDSfOWqxz+qP2y7Rb0OQQ9c1c4Wfv/Pb5GxUNv5tNIsmODREI
         CxLJ2CNg7pM1A==
Date:   Wed, 12 May 2021 16:49:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 23/28] iio: pressure: zpa2326: fix potential extra call
 of runtime suspend.
Message-ID: <20210512164951.3de2d515@coco.lan>
In-Reply-To: <20210509113354.660190-24-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-24-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:49 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This case illustrates why the new pm_runtime_sync_and_get() is good
> in that it makes clear the correct way to handle errors.
> 
> Calling pm_runtime_put() on failure of the _get() in pm_runtime_get_sync()
> will potentially result in powering down an already powered down device
> (as we never successfully powered it up.  Unlikely to cause any problems
> in reality.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This one seems a little odd on my eyes, although I don't know much about
IIO, as it calls RPM get only at:

	zpa2326_init_runtime()

on a balanced way, as the routine starts with RPM get() ends with RPM put().

Then it does a put at zpa2326_suspend() and a get at zpa2326_resume().

Can RPM usage_count be zero at suspend (or are there some other part
of IIO core that increments it?). Because, if after resume, usage_count
would be equal to 1, as I guess RPM core prevent negative values.

Regards,
Mauro



> ---
>  drivers/iio/pressure/zpa2326.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 89295c90f801..97ac3ba399f7 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -664,11 +664,9 @@ static int zpa2326_resume(const struct iio_dev *indio_dev)
>  {
>  	int err;
>  
> -	err = pm_runtime_get_sync(indio_dev->dev.parent);
> -	if (err < 0) {
> -		pm_runtime_put(indio_dev->dev.parent);
> +	err = pm_runtime_resume_and_get(indio_dev->dev.parent);
> +	if (err < 0)
>  		return err;
> -	}
>  
>  	if (err > 0) {
>  		/*



Thanks,
Mauro
