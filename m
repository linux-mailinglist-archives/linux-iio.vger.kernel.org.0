Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED3B19ECCE
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDERO1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 13:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgDERO1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 13:14:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A1F20675;
        Sun,  5 Apr 2020 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586106865;
        bh=W65ai1oueEir50gFsszziEjG0Sb+T0esFzerZcyeo2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fWfmnoawTKN4guFn979lfobB6ly5wGoQxEcYBYuRYPsrEVjhESg9WIw8xdv/1rCV4
         76UQDdaGfMkV3gyenYNzJrs0uPiPcuG8HQYptTwH2htjIceeTXFp9C80aWaNuI0JCx
         Ovrhqa5MuxBoPZoMEjDluEsgdxmSTX1FvC6815Lc=
Date:   Sun, 5 Apr 2020 18:14:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: remove duplicated macro
Message-ID: <20200405181422.13b0467c@archlinux>
In-Reply-To: <CAJ0CqmU8XFmbtbExFPMGG4BxH+gMQUG+PaVbr4-8j4vB44uJHw@mail.gmail.com>
References: <f7c16e9f25debe726645f25df6c9c18aa44f0a1f.1586082819.git.lorenzo@kernel.org>
        <20200405130724.70094f1c@archlinux>
        <20200405130912.5929ee08@archlinux>
        <CAJ0CqmU8XFmbtbExFPMGG4BxH+gMQUG+PaVbr4-8j4vB44uJHw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Apr 2020 14:35:51 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> >
> > On Sun, 5 Apr 2020 13:07:24 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > On Sun,  5 Apr 2020 12:36:26 +0200
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >  
> > > > Remove ST_LSM6DSX_REG_WHOAMI_ADDR duplicated macro and rely on ST sensor
> > > > common definitions
> > > >
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> > > Applied.  
> >
> > Actually no.  I'd rather duplicate the value than have this
> > largerly unconnected driver include that header with lots of other
> > stuff in it.
> >
> > So dropped.  
> 
> actually I was thinking about it too but I guess we have the same
> issue in shub for LIS3MDL so I just aligned to it:
> https://github.com/LorenzoBianconi/linux-iio/blob/st_lsm6dsx_default_wai/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c#L96
Ah.  I'd like to drop that include rather than introduce it in the other file.

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >  
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 84d219ae6aee..f3cf13b29d18 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -58,12 +58,11 @@
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/bitfield.h>
> > > >
> > > > +#include <linux/iio/common/st_sensors.h>
> > > >  #include <linux/platform_data/st_sensors_pdata.h>
> > > >
> > > >  #include "st_lsm6dsx.h"
> > > >
> > > > -#define ST_LSM6DSX_REG_WHOAMI_ADDR         0x0f
> > > > -
> > > >  #define ST_LSM6DSX_TS_SENSITIVITY          25000UL /* 25us */
> > > >
> > > >  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
> > > > @@ -1364,7 +1363,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > > >             return -ENODEV;
> > > >     }
> > > >
> > > > -   err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
> > > > +   err = regmap_read(hw->regmap, ST_SENSORS_DEFAULT_WAI_ADDRESS, &data);
> > > >     if (err < 0) {
> > > >             dev_err(hw->dev, "failed to read whoami register\n");
> > > >             return err;  
> > >  
> >  
> 

