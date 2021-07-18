Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DD3CC99C
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhGROly convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 18 Jul 2021 10:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhGROly (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 10:41:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3EE61183;
        Sun, 18 Jul 2021 14:38:54 +0000 (UTC)
Date:   Sun, 18 Jul 2021 15:41:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Baptiste Mansuy <bmansuy@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: --[[SPOOF or PHISHING]]--Re: --[[SPOOF or PHISHING]]--[PATCH]
 Add startup time for each chip using inv_mpu6050 driver
Message-ID: <20210718154118.54497fad@jic23-huawei>
In-Reply-To: <20210704183206.58b70627@jic23-huawei>
References: <20210621085731.9212-1-bmansuy@invensense.com>
        <BL0PR12MB5011C3AAC67AF825FAA86857C40A9@BL0PR12MB5011.namprd12.prod.outlook.com>
        <BL0PR12MB501195F97958F932724F11ECC4009@BL0PR12MB5011.namprd12.prod.outlook.com>
        <20210704183206.58b70627@jic23-huawei>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 4 Jul 2021 18:32:06 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 1 Jul 2021 07:43:15 +0000
> Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
> 
> > Hello Jonathan,
> > 
> > any news about this patch?
> > 
> > Thanks for your feedback,  
> 
> Looks fine to me, but we were very close to the merge window so I wasn't
> taking anything new.  I'll hopefully pick this up soon; just waiting for rc1
> so I have a nice place to rebase to.

Applied to the togreg branch of iio.git which will be pushed out as testing to
let 0-day see if it can find anything we missed before I push it out in a fashion
that I will ideally not rebase.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > JB
> > 
> > 
> > From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> > Sent: Monday, June 21, 2021 11:16
> > To: Baptiste Mansuy <bmansuy@invensense.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> > Subject: --[[SPOOF or PHISHING]]--Re: --[[SPOOF or PHISHING]]--[PATCH] Add startup time for each chip using inv_mpu6050 driver 
> >  
> >  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > Hello,
> > 
> > looks good for me, thanks for the patch.
> > 
> > Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > 
> > Thanks,
> > JB
> > 
> > From: Baptiste Mansuy <bmansuy@invensense.com>
> > Sent: Monday, June 21, 2021 10:57
> > To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>
> > Cc: Baptiste Mansuy <bmansuy@invensense.com>
> > Subject: --[[SPOOF or PHISHING]]--[PATCH] Add startup time for each chip using inv_mpu6050 driver 
> >  
> >  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > Add startup time for each chip familly. This allows a better behaviour of 
> > the gyro and the accel. The gyro has now the time to stabilise itself 
> > thus making initial data discarding for gyro irrelevant.
> > 
> > Signed-off-by: Baptiste Mansuy <bmansuy@invensense.com>
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 22 +++++++++++++++----
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 18 +++++++++++++--
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 15 ++-----------
> >  3 files changed, 36 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 6244a07048df..50be32b60f19 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -143,6 +143,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6050,
> >                  .fifo_size = 1024,
> >                  .temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_MPU6500_WHOAMI_VALUE,
> > @@ -151,6 +152,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 512,
> >                  .temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_MPU6515_WHOAMI_VALUE,
> > @@ -159,6 +161,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 512,
> >                  .temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_MPU6880_WHOAMI_VALUE,
> > @@ -167,6 +170,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 4096,
> >                  .temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_MPU6000_WHOAMI_VALUE,
> > @@ -175,6 +179,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6050,
> >                  .fifo_size = 1024,
> >                  .temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_MPU9150_WHOAMI_VALUE,
> > @@ -183,6 +188,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6050,
> >                  .fifo_size = 1024,
> >                  .temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6050_GYRO_STARTUP_TIME, INV_MPU6050_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_MPU9250_WHOAMI_VALUE,
> > @@ -191,6 +197,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 512,
> >                  .temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_MPU9255_WHOAMI_VALUE,
> > @@ -199,6 +206,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 512,
> >                  .temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_ICM20608_WHOAMI_VALUE,
> > @@ -207,6 +215,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 512,
> >                  .temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_ICM20609_WHOAMI_VALUE,
> > @@ -215,6 +224,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 4 * 1024,
> >                  .temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_ICM20689_WHOAMI_VALUE,
> > @@ -223,6 +233,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 4 * 1024,
> >                  .temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_ICM20602_WHOAMI_VALUE,
> > @@ -231,6 +242,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 1008,
> >                  .temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> > +               .startup_time = {INV_ICM20602_GYRO_STARTUP_TIME, INV_ICM20602_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_ICM20690_WHOAMI_VALUE,
> > @@ -239,6 +251,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 1024,
> >                  .temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> > +               .startup_time = {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_STARTUP_TIME},
> >          },
> >          {
> >                  .whoami = INV_IAM20680_WHOAMI_VALUE,
> > @@ -247,6 +260,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
> >                  .config = &chip_config_6500,
> >                  .fifo_size = 512,
> >                  .temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> > +               .startup_time = {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_STARTUP_TIME},
> >          },
> >  };
> >  
> > @@ -379,12 +393,12 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
> >                  sleep = 0;
> >                  if (en) {
> >                          if (mask & INV_MPU6050_SENSOR_ACCL) {
> > -                               if (sleep < INV_MPU6050_ACCEL_UP_TIME)
> > -                                       sleep = INV_MPU6050_ACCEL_UP_TIME;
> > +                               if (sleep < st->hw->startup_time.accel)
> > +                                       sleep = st->hw->startup_time.accel;
> >                          }
> >                          if (mask & INV_MPU6050_SENSOR_GYRO) {
> > -                               if (sleep < INV_MPU6050_GYRO_UP_TIME)
> > -                                       sleep = INV_MPU6050_GYRO_UP_TIME;
> > +                               if (sleep < st->hw->startup_time.gyro)
> > +                                       sleep = st->hw->startup_time.gyro;
> >                          }
> >                  } else {
> >                          if (mask & INV_MPU6050_SENSOR_GYRO) {
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > index 58188dc0dd13..c6aa36ee966a 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -149,6 +149,10 @@ struct inv_mpu6050_hw {
> >                  int offset;
> >                  int scale;
> >          } temp;
> > +       struct {
> > +               unsigned int accel;
> > +               unsigned int gyro;
> > +       } startup_time;
> >  };
> >  
> >  /*
> > @@ -320,11 +324,21 @@ struct inv_mpu6050_state {
> >  /* delay time in milliseconds */
> >  #define INV_MPU6050_POWER_UP_TIME            100
> >  #define INV_MPU6050_TEMP_UP_TIME             100
> > -#define INV_MPU6050_ACCEL_UP_TIME            20
> > -#define INV_MPU6050_GYRO_UP_TIME             35
> > +#define INV_MPU6050_ACCEL_STARTUP_TIME       20
> > +#define INV_MPU6050_GYRO_STARTUP_TIME        60
> >  #define INV_MPU6050_GYRO_DOWN_TIME           150
> >  #define INV_MPU6050_SUSPEND_DELAY_MS         2000
> >  
> > +#define INV_MPU6500_GYRO_STARTUP_TIME        70
> > +#define INV_MPU6500_ACCEL_STARTUP_TIME       30
> > +
> > +#define INV_ICM20602_GYRO_STARTUP_TIME       100
> > +#define INV_ICM20602_ACCEL_STARTUP_TIME      20
> > +
> > +#define INV_ICM20690_GYRO_STARTUP_TIME       80
> > +#define INV_ICM20690_ACCEL_STARTUP_TIME      10
> > +
> > +
> >  /* delay time in microseconds */
> >  #define INV_MPU6050_REG_UP_TIME_MIN          5000
> >  #define INV_MPU6050_REG_UP_TIME_MAX          10000
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > index e21ba778595a..28416a09c462 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -91,22 +91,11 @@ static unsigned int inv_scan_query(struct iio_dev *indio_dev)
> >  
> >  static unsigned int inv_compute_skip_samples(const struct inv_mpu6050_state *st)
> >  {
> > -       unsigned int gyro_skip = 0;
> > -       unsigned int magn_skip = 0;
> > -       unsigned int skip_samples;
> > -
> > -       /* gyro first sample is out of specs, skip it */
> > -       if (st->chip_config.gyro_fifo_enable)
> > -               gyro_skip = 1;
> > +       unsigned int skip_samples = 0;
> >  
> >          /* mag first sample is always not ready, skip it */
> >          if (st->chip_config.magn_fifo_enable)
> > -               magn_skip = 1;
> > -
> > -       /* compute first samples to skip */
> > -       skip_samples = gyro_skip;
> > -       if (magn_skip > skip_samples)
> > -               skip_samples = magn_skip;
> > +               skip_samples = 1;
> >  
> >          return skip_samples;
> >  }  
> 

