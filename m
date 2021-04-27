Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2164E36CA28
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhD0RNs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235512AbhD0RNr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:13:47 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E015861076;
        Tue, 27 Apr 2021 17:13:02 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:13:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Pop <cristian.pop@analog.com>
Subject: Re: [PATCH 2/8] iio: dac: ad5766: Drop duplicate setting of
 iio_dev.dev.parent
Message-ID: <20210427181347.32196fe5@jic23-huawei>
In-Reply-To: <CA+U=Dso3G_P-HkXTwSWtjtPgC-TV5X-pGcFh1xfQUEZpra1B9w@mail.gmail.com>
References: <20210426170251.351957-1-jic23@kernel.org>
        <20210426170251.351957-3-jic23@kernel.org>
        <CA+U=Dso3G_P-HkXTwSWtjtPgC-TV5X-pGcFh1xfQUEZpra1B9w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Apr 2021 10:26:31 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Apr 26, 2021 at 8:04 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This is set to the same value in devm_iio_device_alloc() so no need to do
> > it again.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Cristian Pop <cristian.pop@analog.com>
> > ---
> >  drivers/iio/dac/ad5766.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
> > index 79837a4b3a41..b0f180d46394 100644
> > --- a/drivers/iio/dac/ad5766.c
> > +++ b/drivers/iio/dac/ad5766.c
> > @@ -597,7 +597,6 @@ static int ad5766_probe(struct spi_device *spi)
> >         indio_dev->channels = st->chip_info->channels;
> >         indio_dev->num_channels = st->chip_info->num_channels;
> >         indio_dev->info = &ad5766_info;
> > -       indio_dev->dev.parent = &spi->dev;
> >         indio_dev->dev.of_node = spi->dev.of_node;  
> 
> Unrelated to this series.
> This looks like it could do without the of_node assignment as well.
> 
> I probably should have noticed this earlier.

Good point.  Rather than having a separate patch I'll pull that in here
whilst applying if no one shouts.

Thanks,

Jonathan

> 
> >         indio_dev->name = spi_get_device_id(spi)->name;
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> > --
> > 2.31.1
> >  

