Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3636A0B9
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhDXLGg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 07:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhDXLGf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Apr 2021 07:06:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE98F61574;
        Sat, 24 Apr 2021 11:05:55 +0000 (UTC)
Date:   Sat, 24 Apr 2021 12:06:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Nuno Sa <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/9] iio: adis16475: do not return ints in irq
 handlers
Message-ID: <20210424120636.15565c54@jic23-huawei>
In-Reply-To: <CA+U=Dsq0SYxfZ+k-CoKnYDk93LkV4xEpJDSoWjMvgDcmv8UhVA@mail.gmail.com>
References: <20210422101911.135630-1-nuno.sa@analog.com>
        <20210422101911.135630-4-nuno.sa@analog.com>
        <CA+U=Dsq0SYxfZ+k-CoKnYDk93LkV4xEpJDSoWjMvgDcmv8UhVA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Apr 2021 09:41:26 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
> >
> > On an IRQ handler we should return normal error codes as 'irqreturn_t'
> > is expected.
> >  
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> > Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Hi Nuno,

This needs a more detailed commit message as it is simply changing
the return code.  That goto does other stuff.
Please add some more info and send a v3 with this + other patches
I that build on it and hence I won't be able to apply.

Whilst this one is a real bug, I'm not that fussed about backporting
it quickly so will probably be fine to take this via togreg once the
commit message gives enough detail.

Thanks,

Jonathan


> > ---
> >  drivers/iio/imu/adis16475.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > index 1de62fc79e0f..51b76444db0b 100644
> > --- a/drivers/iio/imu/adis16475.c
> > +++ b/drivers/iio/imu/adis16475.c
> > @@ -1068,7 +1068,7 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> >
> >         ret = spi_sync(adis->spi, &adis->msg);
> >         if (ret)
> > -               return ret;
> > +               goto check_burst32;
> >
> >         adis->spi->max_speed_hz = cached_spi_speed_hz;
> >         buffer = adis->buffer;
> > --
> > 2.31.1
> >  

