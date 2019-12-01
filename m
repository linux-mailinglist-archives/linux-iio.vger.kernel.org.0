Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AE10E39C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 22:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLAVUb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 16:20:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfLAVUb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 16:20:31 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A55820865;
        Sun,  1 Dec 2019 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575235229;
        bh=uHdExriX8sRz8N5ESQe912a8qTJZQFnjKMTLvzkgWFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DYkprT4sQ82IUO8g8OGljv0DyViaNbFN7hZYtLO6FM8AB3xJfpQF0GsG7qg3PyGAT
         y4jnw6voCUY89ruPSzSt2Hc9htdT2FZDPv2ceVUHxYT16Gi9+Sgk60XZpQKQf//1hL
         SH+VZprp07Ae6BgDHnTWu51jIkWLYNSthtXIHlJM=
Date:   Sun, 1 Dec 2019 21:20:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        sean@geanix.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not power-off accel if events
 are enabled
Message-ID: <20191201212025.1c7dc713@archlinux>
In-Reply-To: <20191201210727.GB11638@localhost.localdomain>
References: <f245c67b9eff976fbc264affb1f6135c51222b4d.1575019621.git.lorenzo@kernel.org>
        <20191201210151.5aa8c4c3@archlinux>
        <20191201210727.GB11638@localhost.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 1 Dec 2019 23:07:27 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Fri, 29 Nov 2019 11:37:24 +0200
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> > > Do not power-off accel unconditionally if wake-up events are enabled
> > > powering off the hw FIFO. At the same time do not power-off the accel
> > > sensor if it is 'batched' in the hw FIFO disabling sensor events
> > > 
> > > Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> > > Tested-by: Sean Nyekjaer <sean@geanix.com>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>  
> > Not applied as this seems to be dependent on one of the earlier patches.
> > Please put them in a series and resend.  
> 
> Hi Jonathan,
> 
> Sorry for the noise, but I discovered the issue after I have already sent
> the other patch out. I will post them together in v2.
I've picked it up given I now have the other one anyway.

Applied to the fixes-togreg branch of iio.git

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
> > > ---
> > > This patch is based on https://patchwork.kernel.org/patch/11266301/
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++++---
> > >  1 file changed, 26 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 13590c041d22..990643da9f4e 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1447,8 +1447,9 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
> > >  	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
> > >  }
> > >  
> > > -int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> > > -				 bool enable)
> > > +static int
> > > +__st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> > > +			       bool enable)
> > >  {
> > >  	struct st_lsm6dsx_hw *hw = sensor->hw;
> > >  	u32 odr = enable ? sensor->odr : 0;
> > > @@ -1466,6 +1467,26 @@ int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> > >  	return 0;
> > >  }
> > >  
> > > +static int
> > > +st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
> > > +{
> > > +	struct st_lsm6dsx_hw *hw = sensor->hw;
> > > +
> > > +	if (sensor->id == ST_LSM6DSX_ID_GYRO || enable)
> > > +		return 0;
> > > +
> > > +	return hw->enable_event;
> > > +}
> > > +
> > > +int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> > > +				 bool enable)
> > > +{
> > > +	if (st_lsm6dsx_check_events(sensor, enable))
> > > +		return 0;
> > > +
> > > +	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
> > > +}
> > > +
> > >  static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
> > >  				   u8 addr, int *val)
> > >  {
> > > @@ -1662,7 +1683,7 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> > >  	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> > >  	struct st_lsm6dsx_hw *hw = sensor->hw;
> > >  	u8 enable_event;
> > > -	int err = 0;
> > > +	int err;
> > >  
> > >  	if (type != IIO_EV_TYPE_THRESH)
> > >  		return -EINVAL;
> > > @@ -1690,7 +1711,8 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> > >  		return err;
> > >  
> > >  	mutex_lock(&hw->conf_lock);
> > > -	err = st_lsm6dsx_sensor_set_enable(sensor, state);
> > > +	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
> > > +		err = __st_lsm6dsx_sensor_set_enable(sensor, state);
> > >  	mutex_unlock(&hw->conf_lock);
> > >  	if (err < 0)
> > >  		return err;  
> >   

