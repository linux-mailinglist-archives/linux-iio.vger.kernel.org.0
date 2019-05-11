Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF01A7B9
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 13:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfEKLus (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 07:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfEKLus (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 07:50:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB042146F;
        Sat, 11 May 2019 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557575448;
        bh=nDDMFQYHfL+d+v/1Rq8SNF5mVA3L/k/vc2XW3ujTiHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pfmxOQRLFHalBOlDOFQK3ShQqQCB9kxhmZg2AyMSu1Py+2VUfZf2tMMCbgQIXDkn2
         SKiQ1nUCOedsS1kHnWoPRUGPDwkwjdE8AckBdgKv9mxJsdiNhQuyJZRk3qanBMAz+h
         WICHpEvBqNd+f2yatrDerncB0DZj7Sn6y3vjPyzY=
Date:   Sat, 11 May 2019 12:50:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads8688: fix timestamp is not updated
 in buffer
Message-ID: <20190511125044.53f7b574@archlinux>
In-Reply-To: <20190507082304.11692-2-sean@geanix.com>
References: <20190507082304.11692-1-sean@geanix.com>
        <20190507082304.11692-2-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 10:23:04 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> When using the hrtimer iio trigger timestamp isn't updated.
> If we use iio_get_time_ns it is updated correctly.
> 
> Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Ah. I assumed this was the normal, with interrupts it'll update, with hrtimer
it won't - but turns out that in this driver it isn't updated in any path as
the top half that sets pf->timestamp isn't being registered.

Not registering that is correct for a device that doesn't have a dataready interrupt
as we want the timestamp as near to the actual read time as possible.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads8688.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index d9c354dbd7e4..304cad3dddc6 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -396,7 +396,7 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> -			pf->timestamp);
> +			iio_get_time_ns(indio_dev));
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  

