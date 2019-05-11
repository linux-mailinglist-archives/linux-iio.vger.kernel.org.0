Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3121A7A5
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfEKLK3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 07:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfEKLK3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 07:10:29 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57BF32173B;
        Sat, 11 May 2019 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557573026;
        bh=bwW33/ESg/efGFWJUP/cwZr2MXASbChQg/QZsFWR9Sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vNQepgGBzD9Kk7V0VU5kY8VS1G3D0Tr6Vu7CRu4Y+gq6+ySnM7KCogt8+ii/9e8+g
         nDMSwwJc7rhMS58Wn1CPZ4Prezf45Fn+l+GKiNjOo7S+5zArVUPYWd6NBx+2Bny0l+
         QRYSEELPbDbTYr09U4rOlh69vyNzk22VkPk7TdLM=
Date:   Sat, 11 May 2019 12:10:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "fabrice.gasnier@st.com" <fabrice.gasnier@st.com>
Subject: Re: [PATCH][V2] iio: Move attach/detach of the poll func to the
 core
Message-ID: <20190511121021.7ade8a9e@archlinux>
In-Reply-To: <7826097227a8ea52efd2c87cc81b7b4e6ff4d061.camel@analog.com>
References: <20181219140912.22582-1-alexandru.ardelean@analog.com>
        <20190505183723.4b439c56@archlinux>
        <7826097227a8ea52efd2c87cc81b7b4e6ff4d061.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 May 2019 08:45:20 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2019-05-05 at 18:37 +0100, Jonathan Cameron wrote:
> > 
> > 
> > On Wed, 19 Dec 2018 16:09:12 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > All devices using a triggered buffer need to attach and detach the
> > > trigger
> > > to the device in order to properly work. Instead of doing this in each
> > > and
> > > every driver by hand move this into the core.
> > > 
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > 
> > Hi Alex,
> > 
> > Firstly apologies that this is always at the back of my queue.
> > 
> > Anyhow, my one question is around where the new call to
> > iio_detach_pollfunc
> > is.  To reverse the ordering of the setup path it should be before the
> > individual buffer_disables, but you have it after.
> > 
> > I'll review the rest on the assumption we'll resolve that.
> > 
> > So the only difference intended here is to drop the attach out of
> > post_enable and have it just before it, and the detach out of predisable
> > and have it just after that.
> > 
> > There are a few drivers in here where the fundamental flow changes.
> > To my mind, the rules are:
> > 
> > 1) Anything used in the pollfunc should be setup before it is attached.
> > 2) Anything related to setup fo the flow that leads to the pollfunc being
> >    called isn't so critical as long as the final switch to enable that
> >    is after.
> > 
> > To do this, I think we need to first propose a series of patches
> > changing the ordering in those drivers so that the final patch just
> > becomes a change with no functional effects.  Any modifications
> > to the flow should occur in earlier patches.
> > 
> > So based on a not particularly exhaustive look we need to
> > 'fix' up 16 drivers before we look at the big cleanup.  
> 
> I'll take a look and see about these drivers.
> It will take me some time. I'll have to balance other stuff and come back
> to this.
Absolutely.  This is a nice bit of cleanup work but no need to rush.

Thanks

Jonathan

> 
> > 
> > I would really like to chip away at this over time even if you decide
> > you don't want to take it forwards because the current flows around
> > this are a mess (my fault as I've never been super clear to anyone
> > in review on how it 'should' work).
> > 
> > It would be nice to clear that up once and for all.
> > 
> > One thought is that we might want to change the update_scan_mode
> > function to take a flag that says 'no specific scan mode' as some
> > devices aren't using it because they want to enable 'all' channels
> > on leaving buffered mode.  If we do that we can probably call it
> > in the disable path as well and that will resolve a few drivers.
> > 
> > Thanks for your hard work on this.
> > 
> > *cross fingers you still want to take it forwards!*
> > 
> > Jonathan
> > 
> >   
> > > ---
> > > 
> > > Changelog v1 -> v2:
> > > * changed order of execution for attach poll func: first attach
> > > poll_func,
> > >   then call call post_enable() hook
> > > * updated drivers with change since first patch sent ; particularly
> > >   stm32-adc.c has a rather big update with V2
> > > 
> > > 
> > >  drivers/iio/accel/adxl372.c                   |  6 +-
> > >  drivers/iio/accel/bmc150-accel-core.c         |  4 +-
> > >  drivers/iio/accel/kxcjk-1013.c                |  2 -
> > >  drivers/iio/accel/kxsd9.c                     |  2 -
> > >  drivers/iio/accel/st_accel_buffer.c           |  8 ---
> > >  drivers/iio/accel/stk8312.c                   |  2 -
> > >  drivers/iio/accel/stk8ba50.c                  |  2 -
> > >  drivers/iio/adc/ad7266.c                      |  2 -
> > >  drivers/iio/adc/ad7766.c                      |  2 -
> > >  drivers/iio/adc/ad7887.c                      |  2 -
> > >  drivers/iio/adc/ad_sigma_delta.c              |  5 --
> > >  drivers/iio/adc/at91-sama5d2_adc.c            |  7 +--
> > >  drivers/iio/adc/dln2-adc.c                    |  4 +-
> > >  drivers/iio/adc/mxs-lradc-adc.c               |  2 -
> > >  drivers/iio/adc/stm32-adc.c                   | 36 ++----------
> > >  drivers/iio/adc/ti-adc084s021.c               |  2 -
> > >  drivers/iio/adc/ti-ads1015.c                  |  2 -
> > >  drivers/iio/adc/vf610_adc.c                   |  6 +-
> > >  drivers/iio/adc/xilinx-xadc-core.c            |  2 -
> > >  .../buffer/industrialio-triggered-buffer.c    | 10 +---
> > >  drivers/iio/chemical/atlas-ph-sensor.c        |  8 ---
> > >  drivers/iio/dummy/iio_simple_dummy_buffer.c   | 14 -----
> > >  drivers/iio/gyro/bmg160_core.c                |  2 -
> > >  drivers/iio/gyro/mpu3050-core.c               |  2 -
> > >  drivers/iio/gyro/st_gyro_buffer.c             |  8 ---
> > >  drivers/iio/humidity/hdc100x.c                |  7 +--
> > >  drivers/iio/humidity/hts221_buffer.c          |  2 -
> > >  drivers/iio/iio_core_trigger.h                | 20 ++++++-
> > >  drivers/iio/industrialio-buffer.c             | 16 ++++--
> > >  drivers/iio/industrialio-trigger.c            | 55 +++++++++----------
> > >  drivers/iio/light/gp2ap020a00f.c              | 11 +---
> > >  drivers/iio/light/isl29125.c                  |  5 --
> > >  drivers/iio/light/rpr0521.c                   |  2 -
> > >  drivers/iio/light/si1145.c                    |  2 -
> > >  drivers/iio/light/st_uvis25_core.c            |  2 -
> > >  drivers/iio/light/tcs3414.c                   |  5 --
> > >  drivers/iio/magnetometer/bmc150_magn.c        |  2 -
> > >  drivers/iio/magnetometer/rm3100-core.c        |  2 -
> > >  drivers/iio/magnetometer/st_magn_buffer.c     | 21 +------
> > >  drivers/iio/potentiostat/lmp91000.c           |  1 -
> > >  drivers/iio/pressure/st_pressure_buffer.c     | 23 +-------
> > >  drivers/iio/pressure/zpa2326.c                |  6 --
> > >  drivers/iio/proximity/sx9500.c                |  3 -
> > >  include/linux/iio/trigger_consumer.h          |  7 ---
> > >  44 files changed, 75 insertions(+), 259 deletions(-)
> > > 
> > > diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> > > index 3b84cb243a87..e3efdc0f23df 100644
> > > --- a/drivers/iio/accel/adxl372.c
> > > +++ b/drivers/iio/accel/adxl372.c
> > > @@ -817,7 +817,7 @@ static int adxl372_buffer_postenable(struct iio_dev
> > > *indio_dev)
> > >               return ret;
> > >       }
> > > 
> > > -     return iio_triggered_buffer_postenable(indio_dev);
> > > +     return 0;  
> > 
> > This is a reorder as now we'll call the rest of this function before the
> > attach.
> > Conceptually that means the pollfunc 'might be called'. In reality it
> > shouldn't
> > be as the upstream interrupt isn't enabled yet, but let us keep to the
> > flow.
> > 
> > Question is does that matter.
> > 
> > There is a lot of code in here, that definitely looks likely to be
> > relevant to
> > that so I would say yes it does...
> > 
> > It is 'probably' the case that we'd expect the code in here to be
> > conceptually
> > in preenable, rather than postenable, but as it stands this change looks
> > very
> > dubious an that change isn't trivial as there is a setwatermark callback
> > to deal as well.
> > 
> > Not too hard to fix, but I'd want a test before I'd be sure we hadn't
> > messed it
> > up.
> >   
> > >  }
> > > 
> > >  static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
> > > @@ -825,10 +825,6 @@ static int adxl372_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > >       struct adxl372_state *st = iio_priv(indio_dev);
> > >       int ret;
> > > 
> > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (ret < 0)
> > > -             return ret;
> > > -
> > >       adxl372_set_interrupts(st, 0, 0);
> > >       st->fifo_mode = ADXL372_FIFO_BYPASSED;
> > >       adxl372_configure_fifo(st);  
> > 
> > ...
> >   
> > > diff --git a/drivers/iio/accel/st_accel_buffer.c
> > > b/drivers/iio/accel/st_accel_buffer.c
> > > index 7fddc137e91e..cfa189774a1a 100644
> > > --- a/drivers/iio/accel/st_accel_buffer.c
> > > +++ b/drivers/iio/accel/st_accel_buffer.c
> > > @@ -51,10 +51,6 @@ static int st_accel_buffer_postenable(struct iio_dev
> > > *indio_dev)  
> > 
> > This driver is a bit miss-balanced already...
> >   
> > >       if (err < 0)
> > >               goto st_accel_buffer_postenable_error;
> > > 
> > > -     err = iio_triggered_buffer_postenable(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_accel_buffer_postenable_error;
> > > -  
> > 
> > And another one where the postenable contains a lot of setup that we
> > would now
> > not have here.  This needs unwinding.  I would guess that having a static
> > buffer of sufficient size would solve most of the issue.
> > Interesting question of whether the axis enable should be before or after
> > the pollfunc is attached.
> > 
> >   
> > >       return err;
> > > 
> > >  st_accel_buffer_postenable_error:
> > > @@ -68,10 +64,6 @@ static int st_accel_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > >       int err;
> > >       struct st_sensor_data *adata = iio_priv(indio_dev);
> > > 
> > > -     err = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_accel_buffer_predisable_error;
> > > -
> > >       err = st_sensors_set_axis_enable(indio_dev,
> > > ST_SENSORS_ENABLE_ALL_AXIS);
> > >       if (err < 0)
> > >               goto st_accel_buffer_predisable_error;  
> > 
> > ...  
> > > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > > b/drivers/iio/adc/ad_sigma_delta.c
> > > index ff5f2da2e1b1..815344387541 100644
> > > --- a/drivers/iio/adc/ad_sigma_delta.c
> > > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > > @@ -345,10 +345,6 @@ static int ad_sd_buffer_postenable(struct iio_dev
> > > *indio_dev)
> > >       unsigned int channel;
> > >       int ret;
> > > 
> > > -     ret = iio_triggered_buffer_postenable(indio_dev);
> > > -     if (ret < 0)
> > > -             return ret;
> > > -  
> > 
> > I think this one is fine as all the following is around getting the
> > device
> > into a state where the pollfunc 'will be called' rather than a state
> > where it is safe to call it. The boundary is a bit blurred though..
> >   
> > >       channel = find_first_bit(indio_dev->active_scan_mask,
> > >                                indio_dev->masklength);
> > >       ret = ad_sigma_delta_set_channel(sigma_delta,
> > > @@ -439,7 +435,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq,
> > > void *p)
> > > 
> > >  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
> > >       .postenable = &ad_sd_buffer_postenable,
> > > -     .predisable = &iio_triggered_buffer_predisable,
> > >       .postdisable = &ad_sd_buffer_postdisable,
> > >       .validate_scan_mask = &iio_validate_scan_mask_onehot,
> > >  };
> > > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-
> > > sama5d2_adc.c
> > > index d5ea84cf6460..90121aed2210 100644
> > > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > > @@ -904,7 +904,7 @@ static int at91_adc_buffer_postenable(struct
> > > iio_dev *indio_dev)
> > >               return ret;
> > >       }
> > > 
> > > -     return iio_triggered_buffer_postenable(indio_dev);  
> > 
> > Another one with major changes in resulting order.. I'm not totally sure
> > on
> > this one.
> > It looks like stuff that 'causes data' rather than is involved in
> > handling so
> > probably fine.  
> > > +     return 0;
> > >  }
> > > 
> > >  static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> > > @@ -924,11 +924,6 @@ static int at91_adc_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > >       if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> > >               return -EINVAL;
> > > 
> > > -     /* continue with the triggered buffer */
> > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (ret < 0)
> > > -             dev_err(&indio_dev->dev, "buffer predisable failed\n");
> > > -
> > >       if (!st->dma_st.dma_chan)
> > >               return ret;
> > > 
> > > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> > > index c64c6675cae6..51135e7c0d4f 100644
> > > --- a/drivers/iio/adc/dln2-adc.c
> > > +++ b/drivers/iio/adc/dln2-adc.c
> > > @@ -560,7 +560,7 @@ static int
> > > dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)  
> > 
> > Flow has changed here as well..  
> > >               mutex_unlock(&dln2->mutex);
> > >       }
> > > 
> > > -     return iio_triggered_buffer_postenable(indio_dev);
> > > +     return 0;
> > >  }
> > > 
> > >  static int dln2_adc_triggered_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > > @@ -585,7 +585,7 @@ static int
> > > dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
> > >               return ret;
> > >       }
> > > 
> > > -     return iio_triggered_buffer_predisable(indio_dev);
> > > +     return 0;
> > >  }
> > > 
> > >  static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {  
> > 
> > ...
> > 
> >   
> > > diff --git a/drivers/iio/chemical/atlas-ph-sensor.c
> > > b/drivers/iio/chemical/atlas-ph-sensor.c
> > > index a406ad31b096..8fed75f9e95d 100644
> > > --- a/drivers/iio/chemical/atlas-ph-sensor.c
> > > +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> > > @@ -305,10 +305,6 @@ static int atlas_buffer_postenable(struct iio_dev
> > > *indio_dev)
> > >       struct atlas_data *data = iio_priv(indio_dev);
> > >       int ret;
> > > 
> > > -     ret = iio_triggered_buffer_postenable(indio_dev);
> > > -     if (ret)
> > > -             return ret;
> > > -
> > >       ret = pm_runtime_get_sync(&data->client->dev);
> > >       if (ret < 0) {
> > >               pm_runtime_put_noidle(&data->client->dev);
> > > @@ -323,10 +319,6 @@ static int atlas_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > >       struct atlas_data *data = iio_priv(indio_dev);
> > >       int ret;
> > >   
> > 
> > Hmm. This one is doing mix and match. I'll guess it's safe to fix that
> > up.
> >   
> > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (ret)
> > > -             return ret;
> > > -
> > >       ret = atlas_set_interrupt(data, false);
> > >       if (ret)
> > >               return ret;
> > > diff --git a/drivers/iio/gyro/st_gyro_buffer.c
> > > b/drivers/iio/gyro/st_gyro_buffer.c
> > > index a5377044e42f..21501ffd879e 100644
> > > --- a/drivers/iio/gyro/st_gyro_buffer.c
> > > +++ b/drivers/iio/gyro/st_gyro_buffer.c
> > > @@ -51,10 +51,6 @@ static int st_gyro_buffer_postenable(struct iio_dev
> > > *indio_dev)
> > >       if (err < 0)
> > >               goto st_gyro_buffer_postenable_error;
> > >   
> > 
> > Same as the accel version.
> >   
> > > -     err = iio_triggered_buffer_postenable(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_gyro_buffer_postenable_error;
> > > -
> > >       return err;
> > > 
> > >  st_gyro_buffer_postenable_error:
> > > @@ -68,10 +64,6 @@ static int st_gyro_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > >       int err;
> > >       struct st_sensor_data *gdata = iio_priv(indio_dev);
> > > 
> > > -     err = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_gyro_buffer_predisable_error;
> > > -
> > >       err = st_sensors_set_axis_enable(indio_dev,
> > > ST_SENSORS_ENABLE_ALL_AXIS);
> > >       if (err < 0)
> > >               goto st_gyro_buffer_predisable_error;
> > > diff --git a/drivers/iio/humidity/hdc100x.c
> > > b/drivers/iio/humidity/hdc100x.c
> > > index 066e05f92081..959d7e17d471 100644
> > > --- a/drivers/iio/humidity/hdc100x.c
> > > +++ b/drivers/iio/humidity/hdc100x.c
> > > @@ -286,7 +286,7 @@ static int hdc100x_buffer_postenable(struct iio_dev
> > > *indio_dev)
> > >       if (ret)
> > >               return ret;  
> > 
> > I think the earlier part of this should be in preenable, but haven't
> > checked
> > properly.  Definitely can't just change it like this given there
> > are comments about ordering requirements ;)
> >   
> > > 
> > > -     return iio_triggered_buffer_postenable(indio_dev);
> > > +     return 0;
> > >  }
> > > 
> > >  static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
> > > @@ -294,11 +294,6 @@ static int hdc100x_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > >       struct hdc100x_data *data = iio_priv(indio_dev);
> > >       int ret;
> > > 
> > > -     /* First detach poll func, then reset ACQ mode. OK to disable
> > > buffer */
> > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (ret)
> > > -             return ret;
> > > -
> > >       mutex_lock(&data->lock);
> > >       ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
> > > 0);
> > >       mutex_unlock(&data->lock);
> > > diff --git a/drivers/iio/industrialio-buffer.c
> > > b/drivers/iio/industrialio-buffer.c
> > > index cd5bfe39591b..d09a9223a5b0 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -24,8 +24,10 @@
> > > 
> > >  #include <linux/iio/iio.h>
> > >  #include "iio_core.h"
> > > +#include "iio_core_trigger.h"
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/iio/buffer.h>
> > > +#include <linux/iio/trigger.h>
> > >  #include <linux/iio/buffer_impl.h>
> > > 
> > >  static const char * const iio_endian_prefix[] = {
> > > @@ -915,6 +917,7 @@ static int iio_enable_buffers(struct iio_dev
> > > *indio_dev,
> > >       indio_dev->active_scan_mask = config->scan_mask;
> > >       indio_dev->scan_timestamp = config->scan_timestamp;
> > >       indio_dev->scan_bytes = config->scan_bytes;
> > > +     indio_dev->currentmode = config->mode;
> > > 
> > >       iio_update_demux(indio_dev);
> > > 
> > > @@ -950,28 +953,32 @@ static int iio_enable_buffers(struct iio_dev
> > > *indio_dev,
> > >                       goto err_disable_buffers;
> > >       }
> > > 
> > > -     indio_dev->currentmode = config->mode;
> > > +     ret = iio_trigger_attach_poll_func(indio_dev);
> > > +     if (ret)
> > > +             goto err_disable_buffers;
> > > 
> > >       if (indio_dev->setup_ops->postenable) {
> > >               ret = indio_dev->setup_ops->postenable(indio_dev);
> > >               if (ret) {
> > >                       dev_dbg(&indio_dev->dev,
> > >                              "Buffer not started: postenable failed
> > > (%d)\n", ret);
> > > -                     goto err_disable_buffers;
> > > +                     goto err_detach_pollfunc;
> > >               }
> > >       }
> > > 
> > >       return 0;
> > > 
> > > +err_detach_pollfunc:
> > > +     iio_trigger_detach_poll_func(indio_dev);
> > >  err_disable_buffers:
> > >       list_for_each_entry_continue_reverse(buffer, &indio_dev-  
> > > >buffer_list,  
> > >                                            buffer_list)
> > >               iio_buffer_disable(buffer, indio_dev);
> > >  err_run_postdisable:
> > > -     indio_dev->currentmode = INDIO_DIRECT_MODE;
> > >       if (indio_dev->setup_ops->postdisable)
> > >               indio_dev->setup_ops->postdisable(indio_dev);
> > >  err_undo_config:
> > > +     indio_dev->currentmode = INDIO_DIRECT_MODE;
> > >       indio_dev->active_scan_mask = NULL;
> > > 
> > >       return ret;
> > > @@ -1006,7 +1013,7 @@ static int iio_disable_buffers(struct iio_dev
> > > *indio_dev)
> > >                       ret = ret2;
> > >       }
> > > 
> > > -     indio_dev->currentmode = INDIO_DIRECT_MODE;
> > > +     iio_trigger_detach_poll_func(indio_dev);  
> > 
> > This doesn't seem right. In the setup path
> > iio_trigger_detach_poll_func is called just before post_enable, so I'd
> > expect to
> > see this just after pre_disable for it to be balanced.
> > 
> > This has crossed the individual buffer disables.
> >   
> > > 
> > >       if (indio_dev->setup_ops->postdisable) {
> > >               ret2 = indio_dev->setup_ops->postdisable(indio_dev);
> > > @@ -1016,6 +1023,7 @@ static int iio_disable_buffers(struct iio_dev
> > > *indio_dev)
> > > 
> > >       iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
> > >       indio_dev->active_scan_mask = NULL;
> > > +     indio_dev->currentmode = INDIO_DIRECT_MODE;
> > > 
> > >       return ret;
> > >  }
> > > diff --git a/drivers/iio/industrialio-trigger.c
> > > b/drivers/iio/industrialio-trigger.c
> > > index ce66699c7fcc..d50761717dbe 100644
> > > --- a/drivers/iio/industrialio-trigger.c
> > > +++ b/drivers/iio/industrialio-trigger.c
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/slab.h>
> > > 
> > >  #include <linux/iio/iio.h>
> > > +#include <linux/iio/buffer.h>
> > >  #include <linux/iio/trigger.h>
> > >  #include "iio_core.h"
> > >  #include "iio_core_trigger.h"
> > > @@ -242,12 +243,17 @@ static void iio_trigger_put_irq(struct
> > > iio_trigger *trig, int irq)
> > >   * the relevant function is in there may be the best option.
> > >   */
> > >  /* Worth protecting against double additions? */
> > > -static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> > > -                                     struct iio_poll_func *pf)
> > > +int iio_trigger_attach_poll_func(struct iio_dev *indio_dev)
> > >  {
> > > +     struct iio_trigger *trig = indio_dev->trig;
> > > +     struct iio_poll_func *pf = indio_dev->pollfunc;
> > > +     bool notinuse;
> > >       int ret = 0;
> > > -     bool notinuse
> > > -             = bitmap_empty(trig->pool,
> > > CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > > +
> > > +     if (indio_dev->currentmode != INDIO_BUFFER_TRIGGERED)
> > > +             return 0;
> > > +
> > > +     notinuse = bitmap_empty(trig->pool,
> > > CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > > 
> > >       /* Prevent the module from being removed whilst attached to a
> > > trigger */
> > >       __module_get(pf->indio_dev->driver_module);
> > > @@ -290,14 +296,19 @@ static int iio_trigger_attach_poll_func(struct
> > > iio_trigger *trig,
> > >       return ret;
> > >  }
> > > 
> > > -static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> > > -                                      struct iio_poll_func *pf)
> > > +int iio_trigger_detach_poll_func(struct iio_dev *indio_dev)
> > >  {
> > > +     struct iio_trigger *trig = indio_dev->trig;
> > > +     struct iio_poll_func *pf = indio_dev->pollfunc;
> > > +     bool no_other_users = false;
> > >       int ret = 0;
> > > -     bool no_other_users
> > > -             = (bitmap_weight(trig->pool,
> > > -                              CONFIG_IIO_CONSUMERS_PER_TRIGGER)
> > > -                == 1);
> > > +
> > > +     if (indio_dev->currentmode != INDIO_BUFFER_TRIGGERED)
> > > +             return 0;
> > > +
> > > +     if (bitmap_weight(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER)
> > > == 1)
> > > +             no_other_users = true;
> > > +
> > >       if (trig->ops && trig->ops->set_trigger_state && no_other_users)
> > > {
> > >               ret = trig->ops->set_trigger_state(trig, false);
> > >               if (ret)
> > > @@ -434,18 +445,16 @@ static ssize_t iio_trigger_write_current(struct
> > > device *dev,
> > >                       goto out_trigger_put;
> > >       }
> > > 
> > > -     indio_dev->trig = trig;
> > > 
> > > -     if (oldtrig) {
> > > +     if (indio_dev->trig) {
> > >               if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
> > > -                     iio_trigger_detach_poll_func(oldtrig,
> > > -                                                  indio_dev-  
> > > >pollfunc_event);  
> > > +                     iio_trigger_detach_poll_func(indio_dev);
> > >               iio_trigger_put(oldtrig);
> > >       }
> > > +     indio_dev->trig = trig;
> > >       if (indio_dev->trig) {
> > >               if (indio_dev->modes & INDIO_EVENT_TRIGGERED)
> > > -                     iio_trigger_attach_poll_func(indio_dev->trig,
> > > -                                                  indio_dev-  
> > > >pollfunc_event);  
> > > +                     iio_trigger_attach_poll_func(indio_dev);
> > >       }
> > > 
> > >       return len;
> > > @@ -758,17 +767,3 @@ void iio_device_unregister_trigger_consumer(struct
> > > iio_dev *indio_dev)
> > >       if (indio_dev->trig)
> > >               iio_trigger_put(indio_dev->trig);
> > >  }
> > > -
> > > -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
> > > -{
> > > -     return iio_trigger_attach_poll_func(indio_dev->trig,
> > > -                                         indio_dev->pollfunc);
> > > -}
> > > -EXPORT_SYMBOL(iio_triggered_buffer_postenable);
> > > -
> > > -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
> > > -{
> > > -     return iio_trigger_detach_poll_func(indio_dev->trig,
> > > -                                          indio_dev->pollfunc);
> > > -}
> > > -EXPORT_SYMBOL(iio_triggered_buffer_predisable);
> > > diff --git a/drivers/iio/light/gp2ap020a00f.c
> > > b/drivers/iio/light/gp2ap020a00f.c
> > > index 44b13fbcd093..24d4a57b41be 100644
> > > --- a/drivers/iio/light/gp2ap020a00f.c
> > > +++ b/drivers/iio/light/gp2ap020a00f.c
> > > @@ -1423,12 +1423,8 @@ static int gp2ap020a00f_buffer_postenable(struct
> > > iio_dev *indio_dev)
> > >               goto error_unlock;
> > > 
> > >       data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> > > -     if (!data->buffer) {
> > > +     if (!data->buffer)
> > >               err = -ENOMEM;
> > > -             goto error_unlock;
> > > -     }
> > > -
> > > -     err = iio_triggered_buffer_postenable(indio_dev);  
> > 
> > Again, a fairly definite no.  The buffer is probably better off being
> > allocated
> > as part of data anyway. Not sure on the rest.  
> > > 
> > >  error_unlock:
> > >       mutex_unlock(&data->lock);
> > > @@ -1443,10 +1439,6 @@ static int gp2ap020a00f_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > > 
> > >       mutex_lock(&data->lock);
> > > 
> > > -     err = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (err < 0)
> > > -             goto error_unlock;
> > > -
> > >       for_each_set_bit(i, indio_dev->active_scan_mask,
> > >               indio_dev->masklength) {
> > >               switch (i) {
> > > @@ -1468,7 +1460,6 @@ static int gp2ap020a00f_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > >       if (err == 0)
> > >               kfree(data->buffer);
> > > 
> > > -error_unlock:
> > >       mutex_unlock(&data->lock);
> > > 
> > >       return err;
> > > diff --git a/drivers/iio/light/isl29125.c
> > > b/drivers/iio/light/isl29125.c
> > > index ed38edcd5efe..5fdfce92019b 100644
> > > --- a/drivers/iio/light/isl29125.c
> > > +++ b/drivers/iio/light/isl29125.c
> > > @@ -230,10 +230,6 @@ static int isl29125_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > >       struct isl29125_data *data = iio_priv(indio_dev);
> > >       int ret;
> > > 
> > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (ret < 0)
> > > -             return ret;
> > > -  
> > 
> > Another to check.  
> > >       data->conf1 &= ~ISL29125_MODE_MASK;
> > >       data->conf1 |= ISL29125_MODE_PD;
> > >       return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
> > > @@ -242,7 +238,6 @@ static int isl29125_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > > 
> > >  static const struct iio_buffer_setup_ops isl29125_buffer_setup_ops = {
> > >       .preenable = isl29125_buffer_preenable,
> > > -     .postenable = &iio_triggered_buffer_postenable,
> > >       .predisable = isl29125_buffer_predisable,
> > >  };
> > > 
> > > diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
> > > index 205e5659ce6b..c31ed0c640e9 100644
> > > --- a/drivers/iio/light/tcs3414.c
> > > +++ b/drivers/iio/light/tcs3414.c
> > > @@ -257,10 +257,6 @@ static int tcs3414_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > >       struct tcs3414_data *data = iio_priv(indio_dev);
> > >       int ret;
> > > 
> > > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (ret < 0)
> > > -             return ret;  
> > 
> > Another one that needs checking but 'probably' fine.  
> > > -
> > >       data->control &= ~TCS3414_CONTROL_ADC_EN;
> > >       return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
> > >               data->control);
> > > @@ -268,7 +264,6 @@ static int tcs3414_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > > 
> > >  static const struct iio_buffer_setup_ops tcs3414_buffer_setup_ops = {
> > >       .preenable = tcs3414_buffer_preenable,
> > > -     .postenable = &iio_triggered_buffer_postenable,
> > >       .predisable = tcs3414_buffer_predisable,
> > >  };
> > > 
> > > diff --git a/drivers/iio/magnetometer/st_magn_buffer.c
> > > b/drivers/iio/magnetometer/st_magn_buffer.c
> > > index 37ab30566464..570975200955 100644
> > > --- a/drivers/iio/magnetometer/st_magn_buffer.c
> > > +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> > > @@ -32,25 +32,13 @@ int st_magn_trig_set_state(struct iio_trigger
> > > *trig, bool state)
> > >   
> > 
> > I'll guess the flow here is the same as the accel driver.  
> > >  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
> > >  {
> > > -     int err;
> > >       struct st_sensor_data *mdata = iio_priv(indio_dev);
> > > 
> > >       mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> > > -     if (mdata->buffer_data == NULL) {
> > > -             err = -ENOMEM;
> > > -             goto allocate_memory_error;
> > > -     }
> > > -
> > > -     err = iio_triggered_buffer_postenable(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_magn_buffer_postenable_error;
> > > +     if (mdata->buffer_data == NULL)
> > > +             return -ENOMEM;
> > > 
> > >       return st_sensors_set_enable(indio_dev, true);
> > > -
> > > -st_magn_buffer_postenable_error:
> > > -     kfree(mdata->buffer_data);
> > > -allocate_memory_error:
> > > -     return err;
> > >  }
> > > 
> > >  static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
> > > @@ -59,12 +47,7 @@ static int st_magn_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > >       struct st_sensor_data *mdata = iio_priv(indio_dev);
> > > 
> > >       err = st_sensors_set_enable(indio_dev, false);
> > > -     if (err < 0)
> > > -             goto st_magn_buffer_predisable_error;
> > > -
> > > -     err = iio_triggered_buffer_predisable(indio_dev);
> > > 
> > > -st_magn_buffer_predisable_error:
> > >       kfree(mdata->buffer_data);
> > >       return err;
> > >  }
> > > diff --git a/drivers/iio/potentiostat/lmp91000.c
> > > b/drivers/iio/potentiostat/lmp91000.c
> > > index 90e895adf997..268da7992ff5 100644
> > > --- a/drivers/iio/potentiostat/lmp91000.c
> > > +++ b/drivers/iio/potentiostat/lmp91000.c
> > > @@ -295,7 +295,6 @@ static int lmp91000_buffer_predisable(struct
> > > iio_dev *indio_dev)
> > > 
> > >  static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
> > >       .preenable = lmp91000_buffer_preenable,
> > > -     .postenable = iio_triggered_buffer_postenable,  
> > 
> > huh?  We attach but never detach?  That one needs following up as it
> > is probably broken.
> >   
> > >       .predisable = lmp91000_buffer_predisable,
> > >  };
> > > 
> > > diff --git a/drivers/iio/pressure/st_pressure_buffer.c
> > > b/drivers/iio/pressure/st_pressure_buffer.c
> > > index 99468d0a64e7..4cb8239f2599 100644
> > > --- a/drivers/iio/pressure/st_pressure_buffer.c
> > > +++ b/drivers/iio/pressure/st_pressure_buffer.c
> > > @@ -37,25 +37,13 @@ static int st_press_buffer_preenable(struct iio_dev
> > > *indio_dev)
> > > 
> > >  static int st_press_buffer_postenable(struct iio_dev *indio_dev)
> > >  {
> > > -     int err;
> > >       struct st_sensor_data *press_data = iio_priv(indio_dev);
> > > 
> > >       press_data->buffer_data = kmalloc(indio_dev->scan_bytes,
> > > GFP_KERNEL);
> > > -     if (press_data->buffer_data == NULL) {
> > > -             err = -ENOMEM;
> > > -             goto allocate_memory_error;
> > > -     }
> > > -
> > > -     err = iio_triggered_buffer_postenable(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_press_buffer_postenable_error;
> > > -
> > > -     return err;
> > > +     if (press_data->buffer_data == NULL)
> > > +             return -ENOMEM;
> > > 
> > > -st_press_buffer_postenable_error:
> > > -     kfree(press_data->buffer_data);
> > > -allocate_memory_error:
> > > -     return err;
> > > +     return 0;
> > >  }
> > > 
> > >  static int st_press_buffer_predisable(struct iio_dev *indio_dev)
> > > @@ -63,13 +51,8 @@ static int st_press_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > >       int err;
> > >       struct st_sensor_data *press_data = iio_priv(indio_dev);
> > > 
> > > -     err = iio_triggered_buffer_predisable(indio_dev);
> > > -     if (err < 0)
> > > -             goto st_press_buffer_predisable_error;
> > > -
> > >       err = st_sensors_set_enable(indio_dev, false);
> > > 
> > > -st_press_buffer_predisable_error:
> > >       kfree(press_data->buffer_data);
> > >       return err;
> > >  }
> > > diff --git a/drivers/iio/pressure/zpa2326.c
> > > b/drivers/iio/pressure/zpa2326.c
> > > index 81d8f24eaeb4..2c4295087a36 100644
> > > --- a/drivers/iio/pressure/zpa2326.c
> > > +++ b/drivers/iio/pressure/zpa2326.c  
> > 
> > Now I'm just leaving this here as needs more investigation...
> >   
> > > @@ -1271,11 +1271,6 @@ static int zpa2326_postenable_buffer(struct
> > > iio_dev *indio_dev)
> > >                       goto err;
> > >       }
> > > 
> > > -     /* Plug our own trigger event handler. */
> > > -     err = iio_triggered_buffer_postenable(indio_dev);
> > > -     if (err)
> > > -             goto err;
> > > -
> > >       return 0;
> > > 
> > >  err:
> > > @@ -1294,7 +1289,6 @@ static int zpa2326_postdisable_buffer(struct
> > > iio_dev *indio_dev)
> > >  static const struct iio_buffer_setup_ops zpa2326_buffer_setup_ops = {
> > >       .preenable   = zpa2326_preenable_buffer,
> > >       .postenable  = zpa2326_postenable_buffer,
> > > -     .predisable  = iio_triggered_buffer_predisable,
> > >       .postdisable = zpa2326_postdisable_buffer
> > >  };
> > > 
> > > diff --git a/drivers/iio/proximity/sx9500.c
> > > b/drivers/iio/proximity/sx9500.c
> > > index ff80409e0c44..73335e61b350 100644
> > > --- a/drivers/iio/proximity/sx9500.c
> > > +++ b/drivers/iio/proximity/sx9500.c  
> > 
> > Fairly sure this is safe, but separate patch to move it first is needed
> > before
> > this change.
> >   
> > > @@ -707,8 +707,6 @@ static int sx9500_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > >       struct sx9500_data *data = iio_priv(indio_dev);
> > >       int ret = 0, i;
> > > 
> > > -     iio_triggered_buffer_predisable(indio_dev);
> > > -
> > >       mutex_lock(&data->mutex);
> > > 
> > >       for (i = 0; i < SX9500_NUM_CHANNELS; i++)
> > > @@ -730,7 +728,6 @@ static int sx9500_buffer_predisable(struct iio_dev
> > > *indio_dev)
> > > 
> > >  static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {
> > >       .preenable = sx9500_buffer_preenable,
> > > -     .postenable = iio_triggered_buffer_postenable,
> > >       .predisable = sx9500_buffer_predisable,
> > >  };
> > >   

