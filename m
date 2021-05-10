Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0A378E44
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhEJNHl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:07:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3043 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbhEJL73 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 07:59:29 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fdztx3wNWz6rmgC;
        Mon, 10 May 2021 19:52:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 13:58:21 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 12:58:20 +0100
Date:   Mon, 10 May 2021 12:56:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [PATCH] iio: adc: ad7192: Avoid disabling a clock that was
 never enabled.
Message-ID: <20210510125639.00004fab@Huawei.com>
In-Reply-To: <CA+U=Dsp5T52yJ9rs1Ov4W9Lxs6mySGa9cndAiKMhEzh0K1-8oQ@mail.gmail.com>
References: <20210509114118.660422-1-jic23@kernel.org>
        <CA+U=Dsp5T52yJ9rs1Ov4W9Lxs6mySGa9cndAiKMhEzh0K1-8oQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 May 2021 14:30:48 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, May 9, 2021 at 2:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Found by inspection.
> >
> > If the internal clock source is being used, the driver doesn't
> > call clk_prepare_enable() and as such we should not call
> > clk_disable_unprepare()
> >
> > Use the same condition to protect the disable path as is used
> > on the enable one.  Note this will all get simplified when
> > the driver moves over to a full devm_ flow, but that would make
> > backporting the fix harder.
> >
> > Fix obviously predates move out of staging, but backporting will
> > become more complex (and is unlikely to happen), hence that patch
> > is given in the fixes tag.
> >  
> 
> This also looks like a conversion to devm_ would help.
> But later.

Absolutely.  I decided to do a pre parse of likely targets for
devmification to see if we had fixed that needed to go first and
that's when I noticed this one.

That way we don't end up with the mess I caused in the previous
set where I have to remember to finally pick up the non fix
part after the fixes are in.

Jonathan

> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> 
> > Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> > Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> > ---
> >  drivers/iio/adc/ad7192.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 2ed580521d81..d3be67aa0522 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -1014,7 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
> >         return 0;
> >
> >  error_disable_clk:
> > -       clk_disable_unprepare(st->mclk);
> > +       if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> > +           st->clock_sel == AD7192_CLK_EXT_MCLK2)
> > +               clk_disable_unprepare(st->mclk);
> >  error_remove_trigger:
> >         ad_sd_cleanup_buffer_and_trigger(indio_dev);
> >  error_disable_dvdd:
> > @@ -1031,7 +1033,9 @@ static int ad7192_remove(struct spi_device *spi)
> >         struct ad7192_state *st = iio_priv(indio_dev);
> >
> >         iio_device_unregister(indio_dev);
> > -       clk_disable_unprepare(st->mclk);
> > +       if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> > +           st->clock_sel == AD7192_CLK_EXT_MCLK2)
> > +               clk_disable_unprepare(st->mclk);
> >         ad_sd_cleanup_buffer_and_trigger(indio_dev);
> >
> >         regulator_disable(st->dvdd);
> > --
> > 2.31.1
> >  

