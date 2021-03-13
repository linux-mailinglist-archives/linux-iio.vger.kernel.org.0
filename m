Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82990339FCE
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhCMSSN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 13:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233635AbhCMSSN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 13:18:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F08A64EAE;
        Sat, 13 Mar 2021 18:18:12 +0000 (UTC)
Date:   Sat, 13 Mar 2021 18:18:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] iio: Set default trigger device parent
Message-ID: <20210313181809.3683c23d@archlinux>
In-Reply-To: <CAHp75VeLqcocDCTPe+oQQdUqYnCU9Nw1Ch4KVUhRYTAHObuT9A@mail.gmail.com>
References: <20210309011816.2024099-1-gwendal@chromium.org>
        <CAHp75VeLqcocDCTPe+oQQdUqYnCU9Nw1Ch4KVUhRYTAHObuT9A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Mar 2021 12:04:21 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Mar 9, 2021 at 3:18 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Each drivers are setting trig->dev.parent to a common value - usually.  
> 
> "Each driver is"
> 
> > Move that in boiler plate code.
> >
> > The first patch set the parent pointer, the next is an automatic change
> > with spatch.
> > The remaining ones are straightforward manual changes.  
> 
> Few nit-picks here and there, overall LGTM
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
@Gwendal.  Please make sure to pick up tags from earlier versions.
I've gone back and added this for the series as I happened to notice.

Thanks,

Jonathan

> 
> > Few drivers remain:
> > drivers/iio/adc/at91-sama5d2_adc.c
> > drivers/iio/adc/mxs-lradc-adc.c
> > trigger parent set to iio device instead of its parent.
> >
> > drivers/iio/adc/dln2-adc.c
> > trigger parent not set.
> >
> > drivers/iio/gyro/mpu3050-core.c
> > trigger allocated for iio device but parent set to iio device parent.
> >
> > drivers/iio/imu/bmi160/bmi160_core.c
> > drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > trigger allocated for iio device but parent set to mapped register device holder. Looks like iio device parent.
> >
> > drivers/iio/trigger/stm32-lptimer-trigger.c
> > drivers/iio/trigger/stm32-timer-trigger.c
> > trigger allocated for device, but parent set to device parent.
> >
> > Gwendal Grignou (8):
> >   iio: set default trig->dev.parent
> >   iio: fix devm_iio_trigger_alloc with parent.cocci
> >   iio: adis_trigger: Remove code to set trigger parent
> >   iio: gp2ap020a00f: Remove code to set trigger parent
> >   iio: lmp91000: Remove code to set trigger parent
> >   iio: chemical: atlas: Remove code to set trigger parent
> >   iio: as3935: Remove code to set trigger parent
> >   iio: xilinx-xadc: Remove code to set trigger parent
> >
> >  drivers/iio/accel/adxl372.c                   |  2 --
> >  drivers/iio/accel/bma180.c                    |  3 +-
> >  drivers/iio/accel/bmc150-accel-core.c         |  1 -
> >  drivers/iio/accel/kxcjk-1013.c                |  2 --
> >  drivers/iio/accel/mma8452.c                   |  1 -
> >  drivers/iio/accel/mxc4005.c                   |  1 -
> >  drivers/iio/accel/stk8312.c                   |  1 -
> >  drivers/iio/accel/stk8ba50.c                  |  1 -
> >  drivers/iio/adc/ad7606.c                      |  1 -
> >  drivers/iio/adc/ad7766.c                      |  1 -
> >  drivers/iio/adc/ad7768-1.c                    |  1 -
> >  drivers/iio/adc/ad_sigma_delta.c              |  6 ++--
> >  drivers/iio/adc/at91_adc.c                    |  3 +-
> >  drivers/iio/adc/max1027.c                     |  1 -
> >  drivers/iio/adc/xilinx-xadc-core.c            |  1 -
> >  drivers/iio/chemical/atlas-sensor.c           |  1 -
> >  drivers/iio/chemical/ccs811.c                 |  1 -
> >  drivers/iio/chemical/scd30_core.c             |  1 -
> >  .../common/hid-sensors/hid-sensor-trigger.c   |  4 +--
> >  .../common/st_sensors/st_sensors_trigger.c    |  4 +--
> >  drivers/iio/gyro/adxrs290.c                   |  1 -
> >  drivers/iio/gyro/bmg160_core.c                |  2 --
> >  drivers/iio/gyro/fxas21002c_core.c            |  1 -
> >  drivers/iio/gyro/itg3200_buffer.c             |  3 +-
> >  drivers/iio/health/afe4403.c                  |  1 -
> >  drivers/iio/health/afe4404.c                  |  1 -
> >  drivers/iio/humidity/hts221_buffer.c          |  1 -
> >  drivers/iio/imu/adis_trigger.c                | 10 ++----
> >  drivers/iio/imu/kmx61.c                       |  1 -
> >  drivers/iio/industrialio-trigger.c            | 36 +++++++++++--------
> >  drivers/iio/light/gp2ap020a00f.c              |  1 -
> >  drivers/iio/light/rpr0521.c                   |  1 -
> >  drivers/iio/light/si1145.c                    |  1 -
> >  drivers/iio/light/st_uvis25_core.c            |  1 -
> >  drivers/iio/light/vcnl4000.c                  |  1 -
> >  drivers/iio/light/vcnl4035.c                  |  1 -
> >  drivers/iio/magnetometer/bmc150_magn.c        |  1 -
> >  drivers/iio/magnetometer/rm3100-core.c        |  1 -
> >  drivers/iio/potentiostat/lmp91000.c           |  3 +-
> >  drivers/iio/pressure/zpa2326.c                |  1 -
> >  drivers/iio/proximity/as3935.c                |  1 -
> >  drivers/iio/proximity/sx9310.c                |  1 -
> >  drivers/iio/proximity/sx9500.c                |  1 -
> >  drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
> >  drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
> >  drivers/iio/trigger/iio-trig-loop.c           |  2 +-
> >  drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
> >  include/linux/iio/iio.h                       |  2 +-
> >  include/linux/iio/trigger.h                   |  3 +-
> >  49 files changed, 42 insertions(+), 81 deletions(-)
> >
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >  
> 
> 

