Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05E019EB1C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgDEMJQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:09:16 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35348 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgDEMJQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 08:09:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 666009E74A5;
        Sun,  5 Apr 2020 13:09:14 +0100 (BST)
Date:   Sun, 5 Apr 2020 13:09:12 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: remove duplicated macro
Message-ID: <20200405130912.5929ee08@archlinux>
In-Reply-To: <20200405130724.70094f1c@archlinux>
References: <f7c16e9f25debe726645f25df6c9c18aa44f0a1f.1586082819.git.lorenzo@kernel.org>
        <20200405130724.70094f1c@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 5 Apr 2020 13:07:24 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  5 Apr 2020 12:36:26 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> 
> > Remove ST_LSM6DSX_REG_WHOAMI_ADDR duplicated macro and rely on ST sensor
> > common definitions
> > 
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> Applied.

Actually no.  I'd rather duplicate the value than have this
largerly unconnected driver include that header with lots of other
stuff in it.

So dropped.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 84d219ae6aee..f3cf13b29d18 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -58,12 +58,11 @@
> >  #include <linux/regmap.h>
> >  #include <linux/bitfield.h>
> >  
> > +#include <linux/iio/common/st_sensors.h>
> >  #include <linux/platform_data/st_sensors_pdata.h>
> >  
> >  #include "st_lsm6dsx.h"
> >  
> > -#define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
> > -
> >  #define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
> >  
> >  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
> > @@ -1364,7 +1363,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> >  		return -ENODEV;
> >  	}
> >  
> > -	err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
> > +	err = regmap_read(hw->regmap, ST_SENSORS_DEFAULT_WAI_ADDRESS, &data);
> >  	if (err < 0) {
> >  		dev_err(hw->dev, "failed to read whoami register\n");
> >  		return err;  
> 

