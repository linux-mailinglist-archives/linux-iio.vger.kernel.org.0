Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992B03A9B28
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhFPMz3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 08:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232890AbhFPMz2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 08:55:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B0B060FE9;
        Wed, 16 Jun 2021 12:53:20 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:55:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 5/6] iio: prox: pulsed-light-v2: Use
 pm_runtime_resume_and_get()
Message-ID: <20210616135523.0a5a509d@jic23-huawei>
In-Reply-To: <20210616091913.644e303f@coco.lan>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-6-jic23@kernel.org>
        <CAJCx=gncAzH-4HSgTzbzEJ5FYbjXUQW96JqBwmO=4Lx4+SLeEw@mail.gmail.com>
        <20210616091913.644e303f@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Jun 2021 09:19:13 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun, 16 May 2021 13:01:29 -0700
> Matt Ranostay <matt.ranostay@konsulko.com> escreveu:
> 
> > On Sun, May 16, 2021 at 9:22 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Using this new call makes it easy to handle any errors as a result
> > > of runtime resume as it exits without leaving the reference count
> > > elevated.
> > >    
> > 
> > Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied.

> 
> >   
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > > ---
> > >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > > index ecaeb1e11007..e94f63932edb 100644
> > > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > > @@ -158,7 +158,9 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
> > >         int tries = 10;
> > >         int ret;
> > >
> > > -       pm_runtime_get_sync(&client->dev);
> > > +       ret = pm_runtime_resume_and_get(&client->dev);
> > > +       if (ret < 0)
> > > +               return ret;
> > >
> > >         /* start sample */
> > >         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
> > > --
> > > 2.31.1
> > >    
> 
> 
> 
> Thanks,
> Mauro

