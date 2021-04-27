Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2512636CA2C
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhD0RQR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235512AbhD0RQQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Apr 2021 13:16:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 912F761076;
        Tue, 27 Apr 2021 17:15:31 +0000 (UTC)
Date:   Tue, 27 Apr 2021 18:16:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/9] iio: core: move @id from struct iio_dev to struct
 iio_dev_opaque
Message-ID: <20210427181616.7b9dbbae@jic23-huawei>
In-Reply-To: <CA+U=DsphYadw-288yaxoyGr0RX41QxQYjf1NjEhEPYFtXMhe3A@mail.gmail.com>
References: <20210426174911.397061-1-jic23@kernel.org>
        <20210426174911.397061-2-jic23@kernel.org>
        <CA+U=DsphYadw-288yaxoyGr0RX41QxQYjf1NjEhEPYFtXMhe3A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 27 Apr 2021 10:44:29 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Apr 26, 2021 at 8:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Continuing from Alexandru Ardelean's introduction of the split between
> > driver modifiable fields and those that should only be set by the core.
> >
> > This could have been done in two steps to make the actual move after
> > introducing iio_device_id() but there seemed limited point to that
> > given how mechanical the majority of the patch is.
> >  
> 
> The way I was thinking [initially] about moving this, is to somehow
> try to unify/generalize the {devm_}iio_trigger_alloc() function.
> It looks like the IIO device ID is needed only there.
> Maybe there is a good solution for this; maybe if we just provide the
> fmt string, and have a convention that the IIO device name and ID are
> filled in.
> Though that's tricky.

With hindsight we should have standardized the IIO trigger naming
suffix, but we can't do it now and I think we have cases with multiple
elements in their format string so it would be non obvious.

Mostly it's the last element but not in at91-adc where it's in the
middle of two other parameters.

> 
> But this iio_device_id() getter is also a good approach for now.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/accel/adxl372.c                   |  4 ++--
> >  drivers/iio/accel/bma180.c                    |  2 +-
> >  drivers/iio/accel/bmc150-accel-core.c         |  4 ++--
> >  drivers/iio/accel/kxcjk-1013.c                |  4 ++--
> >  drivers/iio/accel/mma8452.c                   |  2 +-
> >  drivers/iio/accel/mxc4005.c                   |  2 +-
> >  drivers/iio/accel/stk8312.c                   |  2 +-
> >  drivers/iio/accel/stk8ba50.c                  |  2 +-
> >  drivers/iio/adc/ad7606.c                      |  3 ++-
> >  drivers/iio/adc/ad7766.c                      |  3 ++-
> >  drivers/iio/adc/ad7768-1.c                    |  3 ++-
> >  drivers/iio/adc/ad_sigma_delta.c              |  2 +-
> >  drivers/iio/adc/at91_adc.c                    |  4 ++--
> >  drivers/iio/adc/dln2-adc.c                    |  3 ++-
> >  drivers/iio/adc/ina2xx-adc.c                  |  3 ++-
> >  drivers/iio/adc/ti-ads131e08.c                |  2 +-
> >  drivers/iio/adc/xilinx-xadc-core.c            |  2 +-
> >  .../buffer/industrialio-triggered-buffer.c    |  2 +-
> >  drivers/iio/chemical/atlas-sensor.c           |  2 +-
> >  drivers/iio/chemical/ccs811.c                 |  2 +-
> >  drivers/iio/chemical/scd30_core.c             |  3 ++-
> >  .../common/hid-sensors/hid-sensor-trigger.c   |  2 +-
> >  drivers/iio/gyro/adxrs290.c                   |  2 +-
> >  drivers/iio/gyro/bmg160_core.c                |  4 ++--
> >  drivers/iio/gyro/fxas21002c_core.c            |  2 +-
> >  drivers/iio/gyro/itg3200_buffer.c             |  2 +-
> >  drivers/iio/gyro/mpu3050-core.c               |  2 +-
> >  drivers/iio/health/afe4403.c                  |  2 +-
> >  drivers/iio/health/afe4404.c                  |  2 +-
> >  drivers/iio/imu/adis_trigger.c                |  3 ++-
> >  drivers/iio/imu/bmi160/bmi160_core.c          |  3 ++-
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  2 +-
> >  drivers/iio/imu/kmx61.c                       |  2 +-
> >  drivers/iio/industrialio-core.c               | 24 +++++++++++++++----
> >  drivers/iio/industrialio-triggered-event.c    |  2 +-
> >  drivers/iio/light/acpi-als.c                  |  3 ++-
> >  drivers/iio/light/rpr0521.c                   |  2 +-
> >  drivers/iio/light/si1145.c                    |  2 +-
> >  drivers/iio/light/vcnl4000.c                  |  3 ++-
> >  drivers/iio/light/vcnl4035.c                  |  2 +-
> >  drivers/iio/magnetometer/bmc150_magn.c        |  2 +-
> >  drivers/iio/magnetometer/rm3100-core.c        |  2 +-
> >  drivers/iio/potentiostat/lmp91000.c           |  3 ++-
> >  drivers/iio/pressure/zpa2326.c                |  3 ++-
> >  drivers/iio/proximity/as3935.c                |  3 ++-
> >  drivers/iio/proximity/sx9310.c                |  2 +-
> >  drivers/iio/proximity/sx9500.c                |  2 +-
> >  include/linux/iio/iio-opaque.h                |  2 ++
> >  include/linux/iio/iio.h                       |  4 ++--
> >  49 files changed, 87 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> > index 9c9a896a872a..fc9592407717 100644
> > --- a/drivers/iio/accel/adxl372.c
> > +++ b/drivers/iio/accel/adxl372.c
> > @@ -1223,14 +1223,14 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
> >                 st->dready_trig = devm_iio_trigger_alloc(dev,
> >                                                          "%s-dev%d",
> >                                                          indio_dev->name,
> > -                                                        indio_dev->id);
> > +                                                        iio_device_id(indio_dev));
> >                 if (st->dready_trig == NULL)
> >                         return -ENOMEM;
> >
> >                 st->peak_datardy_trig = devm_iio_trigger_alloc(dev,
> >                                                                "%s-dev%d-peak",
> >                                                                indio_dev->name,
> > -                                                              indio_dev->id);
> > +                                                              iio_device_id(indio_dev));
> >                 if (!st->peak_datardy_trig)
> >                         return -ENOMEM;
> >
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index b8a7469cdae4..68d91a70de03 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -1045,7 +1045,7 @@ static int bma180_probe(struct i2c_client *client,
> >
> >         if (client->irq > 0) {
> >                 data->trig = iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> > -                       indio_dev->id);
> > +                                              iio_device_id(indio_dev));
> >                 if (!data->trig) {
> >                         ret = -ENOMEM;
> >                         goto err_chip_disable;
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> > index 04d85ce34e9f..62a164a7b852 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -1470,9 +1470,9 @@ static int bmc150_accel_triggers_setup(struct iio_dev *indio_dev,
> >                 struct bmc150_accel_trigger *t = &data->triggers[i];
> >
> >                 t->indio_trig = devm_iio_trigger_alloc(dev,
> > -                                       bmc150_accel_triggers[i].name,
> > +                                                      bmc150_accel_triggers[i].name,
> >                                                        indio_dev->name,
> > -                                                      indio_dev->id);
> > +                                                      iio_device_id(indio_dev));
> >                 if (!t->indio_trig) {
> >                         ret = -ENOMEM;
> >                         break;
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index ff724bc17a45..283e6a3feffc 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1404,7 +1404,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
> >                 data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> >                                                            "%s-dev%d",
> >                                                            indio_dev->name,
> > -                                                          indio_dev->id);
> > +                                                          iio_device_id(indio_dev));
> >                 if (!data->dready_trig) {
> >                         ret = -ENOMEM;
> >                         goto err_poweroff;
> > @@ -1413,7 +1413,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
> >                 data->motion_trig = devm_iio_trigger_alloc(&client->dev,
> >                                                           "%s-any-motion-dev%d",
> >                                                           indio_dev->name,
> > -                                                         indio_dev->id);
> > +                                                         iio_device_id(indio_dev));
> >                 if (!data->motion_trig) {
> >                         ret = -ENOMEM;
> >                         goto err_poweroff;
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index 4d307dfb9169..464a6bfe6746 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -1461,7 +1461,7 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
> >
> >         trig = devm_iio_trigger_alloc(&data->client->dev, "%s-dev%d",
> >                                       indio_dev->name,
> > -                                     indio_dev->id);
> > +                                     iio_device_id(indio_dev));
> >         if (!trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> > index fb3cbaa62bd8..98c7f5f59011 100644
> > --- a/drivers/iio/accel/mxc4005.c
> > +++ b/drivers/iio/accel/mxc4005.c
> > @@ -433,7 +433,7 @@ static int mxc4005_probe(struct i2c_client *client,
> >                 data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> >                                                            "%s-dev%d",
> >                                                            indio_dev->name,
> > -                                                          indio_dev->id);
> > +                                                          iio_device_id(indio_dev));
> >                 if (!data->dready_trig)
> >                         return -ENOMEM;
> >
> > diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> > index 60aecfa9fd92..aeab108c457d 100644
> > --- a/drivers/iio/accel/stk8312.c
> > +++ b/drivers/iio/accel/stk8312.c
> > @@ -552,7 +552,7 @@ static int stk8312_probe(struct i2c_client *client,
> >                 data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> >                                                            "%s-dev%d",
> >                                                            indio_dev->name,
> > -                                                          indio_dev->id);
> > +                                                          iio_device_id(indio_dev));
> >                 if (!data->dready_trig) {
> >                         ret = -ENOMEM;
> >                         goto err_power_off;
> > diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> > index 7cf9cb7e8666..3e7cf23be7e1 100644
> > --- a/drivers/iio/accel/stk8ba50.c
> > +++ b/drivers/iio/accel/stk8ba50.c
> > @@ -448,7 +448,7 @@ static int stk8ba50_probe(struct i2c_client *client,
> >                 data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> >                                                            "%s-dev%d",
> >                                                            indio_dev->name,
> > -                                                          indio_dev->id);
> > +                                                          iio_device_id(indio_dev));
> >                 if (!data->dready_trig) {
> >                         ret = -ENOMEM;
> >                         goto err_power_off;
> > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > index 0af0bb4d5a7f..0a60ecc69d38 100644
> > --- a/drivers/iio/adc/ad7606.c
> > +++ b/drivers/iio/adc/ad7606.c
> > @@ -663,7 +663,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
> >         }
> >
> >         st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> > -                                         indio_dev->name, indio_dev->id);
> > +                                         indio_dev->name,
> > +                                         iio_device_id(indio_dev));
> >         if (!st->trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> > index 1e41759f3ee5..236a455aaa18 100644
> > --- a/drivers/iio/adc/ad7766.c
> > +++ b/drivers/iio/adc/ad7766.c
> > @@ -248,7 +248,8 @@ static int ad7766_probe(struct spi_device *spi)
> >
> >         if (spi->irq > 0) {
> >                 ad7766->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > -                       indio_dev->name, indio_dev->id);
> > +                                                     indio_dev->name,
> > +                                                     iio_device_id(indio_dev));
> >                 if (!ad7766->trig)
> >                         return -ENOMEM;
> >
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index c945f1349623..41752777e96c 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -626,7 +626,8 @@ static int ad7768_probe(struct spi_device *spi)
> >         }
> >
> >         st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > -                                         indio_dev->name, indio_dev->id);
> > +                                         indio_dev->name,
> > +                                         iio_device_id(indio_dev));
> >         if (!st->trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> > index e777ec718973..69b979331ccd 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -477,7 +477,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
> >
> >         sigma_delta->trig = iio_trigger_alloc(&sigma_delta->spi->dev,
> >                                               "%s-dev%d", indio_dev->name,
> > -                                             indio_dev->id);
> > +                                             iio_device_id(indio_dev));
> >         if (sigma_delta->trig == NULL) {
> >                 ret = -ENOMEM;
> >                 goto error_ret;
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 0b5f0c91d0d7..5a7d3a3a5fa8 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -547,7 +547,7 @@ static int at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
> >                 char *name = kasprintf(GFP_KERNEL,
> >                                 "%s-dev%d-%s",
> >                                 idev->name,
> > -                               idev->id,
> > +                               iio_device_id(idev),
> >                                 triggers[i].name);
> >                 if (!name)
> >                         return -ENOMEM;
> > @@ -626,7 +626,7 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
> >         int ret;
> >
> >         trig = iio_trigger_alloc(idev->dev.parent, "%s-dev%d-%s", idev->name,
> > -                                idev->id, trigger->name);
> > +                                iio_device_id(idev), trigger->name);
> >         if (trig == NULL)
> >                 return NULL;
> >
> > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> > index 0d53ef18e045..16407664182c 100644
> > --- a/drivers/iio/adc/dln2-adc.c
> > +++ b/drivers/iio/adc/dln2-adc.c
> > @@ -649,7 +649,8 @@ static int dln2_adc_probe(struct platform_device *pdev)
> >         indio_dev->setup_ops = &dln2_adc_buffer_setup_ops;
> >
> >         dln2->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> > -                                           indio_dev->name, indio_dev->id);
> > +                                           indio_dev->name,
> > +                                           iio_device_id(indio_dev));
> >         if (!dln2->trig) {
> >                 dev_err(dev, "failed to allocate trigger\n");
> >                 return -ENOMEM;
> > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > index 2ae54258b221..a4b2ff9e0dd5 100644
> > --- a/drivers/iio/adc/ina2xx-adc.c
> > +++ b/drivers/iio/adc/ina2xx-adc.c
> > @@ -843,7 +843,8 @@ static int ina2xx_buffer_enable(struct iio_dev *indio_dev)
> >                 chip->allow_async_readout);
> >
> >         task = kthread_create(ina2xx_capture_thread, (void *)indio_dev,
> > -                             "%s:%d-%uus", indio_dev->name, indio_dev->id,
> > +                             "%s:%d-%uus", indio_dev->name,
> > +                             iio_device_id(indio_dev),
> >                               sampling_us);
> >         if (IS_ERR(task))
> >                 return PTR_ERR(task);
> > diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> > index 0060d5f0abb0..5dcf1e9294d7 100644
> > --- a/drivers/iio/adc/ti-ads131e08.c
> > +++ b/drivers/iio/adc/ti-ads131e08.c
> > @@ -844,7 +844,7 @@ static int ads131e08_probe(struct spi_device *spi)
> >         }
> >
> >         st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > -               indio_dev->name, indio_dev->id);
> > +               indio_dev->name, iio_device_id(indio_dev));
> >         if (!st->trig) {
> >                 dev_err(&spi->dev, "failed to allocate IIO trigger\n");
> >                 return -ENOMEM;
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > index 6914c1900ed0..198d2916266d 100644
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -743,7 +743,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
> >         int ret;
> >
> >         trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
> > -                                     indio_dev->id, name);
> > +                                     iio_device_id(indio_dev), name);
> >         if (trig == NULL)
> >                 return ERR_PTR(-ENOMEM);
> >
> > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > index ebb4520ac291..f77c4538141e 100644
> > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > @@ -56,7 +56,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
> >                                                  indio_dev,
> >                                                  "%s_consumer%d",
> >                                                  indio_dev->name,
> > -                                                indio_dev->id);
> > +                                                iio_device_id(indio_dev));
> >         if (indio_dev->pollfunc == NULL) {
> >                 ret = -ENOMEM;
> >                 goto error_kfifo_free;
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> > index 56ba6c82b501..d10f921b233a 100644
> > --- a/drivers/iio/chemical/atlas-sensor.c
> > +++ b/drivers/iio/chemical/atlas-sensor.c
> > @@ -640,7 +640,7 @@ static int atlas_probe(struct i2c_client *client,
> >         indio_dev->modes = INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE;
> >
> >         trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> > -                                     indio_dev->name, indio_dev->id);
> > +                                     indio_dev->name, iio_device_id(indio_dev));
> >
> >         if (!trig)
> >                 return -ENOMEM;
> > diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> > index 886e96496dbf..847194fa1e46 100644
> > --- a/drivers/iio/chemical/ccs811.c
> > +++ b/drivers/iio/chemical/ccs811.c
> > @@ -491,7 +491,7 @@ static int ccs811_probe(struct i2c_client *client,
> >                 data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
> >                                                          "%s-dev%d",
> >                                                          indio_dev->name,
> > -                                                        indio_dev->id);
> > +                                                        iio_device_id(indio_dev));
> >                 if (!data->drdy_trig) {
> >                         ret = -ENOMEM;
> >                         goto err_poweroff;
> > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> > index d89f117dd0ef..9fe6bbe9ee04 100644
> > --- a/drivers/iio/chemical/scd30_core.c
> > +++ b/drivers/iio/chemical/scd30_core.c
> > @@ -640,7 +640,8 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
> >         struct iio_trigger *trig;
> >         int ret;
> >
> > -       trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name, indio_dev->id);
> > +       trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> > +                                     iio_device_id(indio_dev));
> >         if (!trig) {
> >                 dev_err(dev, "failed to allocate trigger\n");
> >                 return -ENOMEM;
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index 95ddccb44f1c..5a7b3e253e58 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -256,7 +256,7 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
> >         }
> >
> >         trig = iio_trigger_alloc(indio_dev->dev.parent,
> > -                                "%s-dev%d", name, indio_dev->id);
> > +                                "%s-dev%d", name, iio_device_id(indio_dev));
> >         if (trig == NULL) {
> >                 dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
> >                 ret = -ENOMEM;
> > diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> > index cec5e1f17c22..3e0734ddafe3 100644
> > --- a/drivers/iio/gyro/adxrs290.c
> > +++ b/drivers/iio/gyro/adxrs290.c
> > @@ -589,7 +589,7 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
> >
> >         st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev, "%s-dev%d",
> >                                                  indio_dev->name,
> > -                                                indio_dev->id);
> > +                                                iio_device_id(indio_dev));
> >         if (!st->dready_trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> > index b11ebd9bb7a4..26a9ed5770c6 100644
> > --- a/drivers/iio/gyro/bmg160_core.c
> > +++ b/drivers/iio/gyro/bmg160_core.c
> > @@ -1137,14 +1137,14 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >                 data->dready_trig = devm_iio_trigger_alloc(dev,
> >                                                            "%s-dev%d",
> >                                                            indio_dev->name,
> > -                                                          indio_dev->id);
> > +                                                          iio_device_id(indio_dev));
> >                 if (!data->dready_trig)
> >                         return -ENOMEM;
> >
> >                 data->motion_trig = devm_iio_trigger_alloc(dev,
> >                                                           "%s-any-motion-dev%d",
> >                                                           indio_dev->name,
> > -                                                         indio_dev->id);
> > +                                                         iio_device_id(indio_dev));
> >                 if (!data->motion_trig)
> >                         return -ENOMEM;
> >
> > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> > index 1a20c6b88e7d..5af7b48ff01a 100644
> > --- a/drivers/iio/gyro/fxas21002c_core.c
> > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > @@ -852,7 +852,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
> >
> >         data->dready_trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> >                                                    indio_dev->name,
> > -                                                  indio_dev->id);
> > +                                                  iio_device_id(indio_dev));
> >         if (!data->dready_trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> > index af0aaa146f0c..04dd6a7969ea 100644
> > --- a/drivers/iio/gyro/itg3200_buffer.c
> > +++ b/drivers/iio/gyro/itg3200_buffer.c
> > @@ -114,7 +114,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
> >         struct itg3200 *st = iio_priv(indio_dev);
> >
> >         st->trig = iio_trigger_alloc(&st->i2c->dev, "%s-dev%d", indio_dev->name,
> > -                                    indio_dev->id);
> > +                                    iio_device_id(indio_dev));
> >         if (!st->trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> > index ac90be03332a..131e6f54948e 100644
> > --- a/drivers/iio/gyro/mpu3050-core.c
> > +++ b/drivers/iio/gyro/mpu3050-core.c
> > @@ -1049,7 +1049,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
> >         mpu3050->trig = devm_iio_trigger_alloc(&indio_dev->dev,
> >                                                "%s-dev%d",
> >                                                indio_dev->name,
> > -                                              indio_dev->id);
> > +                                              iio_device_id(indio_dev));
> >         if (!mpu3050->trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> > index 1fa8d51d5080..d4921385aaf7 100644
> > --- a/drivers/iio/health/afe4403.c
> > +++ b/drivers/iio/health/afe4403.c
> > @@ -521,7 +521,7 @@ static int afe4403_probe(struct spi_device *spi)
> >                 afe->trig = devm_iio_trigger_alloc(afe->dev,
> >                                                    "%s-dev%d",
> >                                                    indio_dev->name,
> > -                                                  indio_dev->id);
> > +                                                  iio_device_id(indio_dev));
> >                 if (!afe->trig) {
> >                         dev_err(afe->dev, "Unable to allocate IIO trigger\n");
> >                         ret = -ENOMEM;
> > diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> > index e1476bf79fe2..d8a27dfe074a 100644
> > --- a/drivers/iio/health/afe4404.c
> > +++ b/drivers/iio/health/afe4404.c
> > @@ -528,7 +528,7 @@ static int afe4404_probe(struct i2c_client *client,
> >                 afe->trig = devm_iio_trigger_alloc(afe->dev,
> >                                                    "%s-dev%d",
> >                                                    indio_dev->name,
> > -                                                  indio_dev->id);
> > +                                                  iio_device_id(indio_dev));
> >                 if (!afe->trig) {
> >                         dev_err(afe->dev, "Unable to allocate IIO trigger\n");
> >                         ret = -ENOMEM;
> > diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> > index fa5540fabacc..48eedc29b28a 100644
> > --- a/drivers/iio/imu/adis_trigger.c
> > +++ b/drivers/iio/imu/adis_trigger.c
> > @@ -62,7 +62,8 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
> >         int ret;
> >
> >         adis->trig = devm_iio_trigger_alloc(&adis->spi->dev, "%s-dev%d",
> > -                                           indio_dev->name, indio_dev->id);
> > +                                           indio_dev->name,
> > +                                           iio_device_id(indio_dev));
> >         if (!adis->trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > index 290b5ef83f77..b63bd7e5e5e5 100644
> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > @@ -785,7 +785,8 @@ int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
> >         int ret;
> >
> >         data->trig = devm_iio_trigger_alloc(&indio_dev->dev, "%s-dev%d",
> > -                                           indio_dev->name, indio_dev->id);
> > +                                           indio_dev->name,
> > +                                           iio_device_id(indio_dev));
> >
> >         if (data->trig == NULL)
> >                 return -ENOMEM;
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > index de8ed1446d60..e21ba778595a 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -238,7 +238,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
> >         st->trig = devm_iio_trigger_alloc(&indio_dev->dev,
> >                                           "%s-dev%d",
> >                                           indio_dev->name,
> > -                                         indio_dev->id);
> > +                                         iio_device_id(indio_dev));
> >         if (!st->trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> > index fc5a60fcfec0..d3e06ce99c1e 100644
> > --- a/drivers/iio/imu/kmx61.c
> > +++ b/drivers/iio/imu/kmx61.c
> > @@ -1264,7 +1264,7 @@ static struct iio_trigger *kmx61_trigger_setup(struct kmx61_data *data,
> >                                       "%s-%s-dev%d",
> >                                       indio_dev->name,
> >                                       tag,
> > -                                     indio_dev->id);
> > +                                     iio_device_id(indio_dev));
> >         if (!trig)
> >                 return ERR_PTR(-ENOMEM);
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 022198c32e32..c16b8f344c93 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -169,6 +169,20 @@ static const char * const iio_chan_info_postfix[] = {
> >         [IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> >         [IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
> >  };
> > +/**
> > + * iio_device_id() - query the unique ID for the device
> > + * @indio_dev:         Device structure whose ID is being queried
> > + *
> > + * The IIO device ID is a unique index used for example for the naming
> > + * of the character device /dev/iio\:device[ID]
> > + */
> > +int iio_device_id(struct iio_dev *indio_dev)
> > +{
> > +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +
> > +       return iio_dev_opaque->id;
> > +}
> > +EXPORT_SYMBOL_GPL(iio_device_id);
> >
> >  /**
> >   * iio_sysfs_match_string_with_gaps - matches given string in an array with gaps
> > @@ -1588,7 +1602,7 @@ static void iio_dev_release(struct device *device)
> >
> >         iio_device_detach_buffers(indio_dev);
> >
> > -       ida_simple_remove(&iio_ida, indio_dev->id);
> > +       ida_simple_remove(&iio_ida, iio_dev_opaque->id);
> >         kfree(iio_dev_opaque);
> >  }
> >
> > @@ -1631,14 +1645,14 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
> >         mutex_init(&indio_dev->info_exist_lock);
> >         INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
> >
> > -       indio_dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> > -       if (indio_dev->id < 0) {
> > +       iio_dev_opaque->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> > +       if (iio_dev_opaque->id < 0) {
> >                 /* cannot use a dev_err as the name isn't available */
> >                 pr_err("failed to get device id\n");
> >                 kfree(iio_dev_opaque);
> >                 return NULL;
> >         }
> > -       dev_set_name(&indio_dev->dev, "iio:device%d", indio_dev->id);
> > +       dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id);
> >         INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
> >         INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
> >
> > @@ -1892,7 +1906,7 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
> >                 cdev_init(&indio_dev->chrdev, &iio_event_fileops);
> >
> >         if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface) {
> > -               indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
> > +               indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), iio_dev_opaque->id);
> >                 indio_dev->chrdev.owner = this_mod;
> >         }
> >
> > diff --git a/drivers/iio/industrialio-triggered-event.c b/drivers/iio/industrialio-triggered-event.c
> > index 53da9ab17a62..4bedc65c9fe3 100644
> > --- a/drivers/iio/industrialio-triggered-event.c
> > +++ b/drivers/iio/industrialio-triggered-event.c
> > @@ -37,7 +37,7 @@ int iio_triggered_event_setup(struct iio_dev *indio_dev,
> >                                                        indio_dev,
> >                                                        "%s_consumer%d",
> >                                                        indio_dev->name,
> > -                                                      indio_dev->id);
> > +                                                      iio_device_id(indio_dev));
> >         if (indio_dev->pollfunc_event == NULL)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> > index 30393f08e082..260f96ea5f3c 100644
> > --- a/drivers/iio/light/acpi-als.c
> > +++ b/drivers/iio/light/acpi-als.c
> > @@ -206,7 +206,8 @@ static int acpi_als_add(struct acpi_device *device)
> >         indio_dev->channels = acpi_als_channels;
> >         indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
> >
> > -       als->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name, indio_dev->id);
> > +       als->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> > +                                          iio_device_id(indio_dev));
> >         if (!als->trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> > index 033578f444e4..7e332de0e6a5 100644
> > --- a/drivers/iio/light/rpr0521.c
> > +++ b/drivers/iio/light/rpr0521.c
> > @@ -985,7 +985,7 @@ static int rpr0521_probe(struct i2c_client *client,
> >                 /* Trigger0 producer setup */
> >                 data->drdy_trigger0 = devm_iio_trigger_alloc(
> >                         indio_dev->dev.parent,
> > -                       "%s-dev%d", indio_dev->name, indio_dev->id);
> > +                       "%s-dev%d", indio_dev->name, iio_device_id(indio_dev));
> >                 if (!data->drdy_trigger0) {
> >                         ret = -ENOMEM;
> >                         goto err_pm_disable;
> > diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> > index 9b5c99823943..3fb52402fcc3 100644
> > --- a/drivers/iio/light/si1145.c
> > +++ b/drivers/iio/light/si1145.c
> > @@ -1243,7 +1243,7 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
> >         int ret;
> >
> >         trig = devm_iio_trigger_alloc(&client->dev,
> > -                       "%s-dev%d", indio_dev->name, indio_dev->id);
> > +                       "%s-dev%d", indio_dev->name, iio_device_id(indio_dev));
> >         if (!trig)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 2f7916f95689..4a61865d01cd 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -998,7 +998,8 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
> >         struct iio_trigger *trigger;
> >
> >         trigger = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> > -                                        indio_dev->name, indio_dev->id);
> > +                                        indio_dev->name,
> > +                                        iio_device_id(indio_dev));
> >         if (!trigger)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> > index ae87740d9cef..691a54b763e1 100644
> > --- a/drivers/iio/light/vcnl4035.c
> > +++ b/drivers/iio/light/vcnl4035.c
> > @@ -507,7 +507,7 @@ static int vcnl4035_probe_trigger(struct iio_dev *indio_dev)
> >
> >         data->drdy_trigger0 = devm_iio_trigger_alloc(
> >                         indio_dev->dev.parent,
> > -                       "%s-dev%d", indio_dev->name, indio_dev->id);
> > +                       "%s-dev%d", indio_dev->name, iio_device_id(indio_dev));
> >         if (!data->drdy_trigger0)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> > index 00f9766bad5c..d75b437a43f2 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -915,7 +915,7 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
> >                 data->dready_trig = devm_iio_trigger_alloc(dev,
> >                                                            "%s-dev%d",
> >                                                            indio_dev->name,
> > -                                                          indio_dev->id);
> > +                                                          iio_device_id(indio_dev));
> >                 if (!data->dready_trig) {
> >                         ret = -ENOMEM;
> >                         dev_err(dev, "iio trigger alloc failed\n");
> > diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> > index dd811da9cb6d..4df5887fd04c 100644
> > --- a/drivers/iio/magnetometer/rm3100-core.c
> > +++ b/drivers/iio/magnetometer/rm3100-core.c
> > @@ -575,7 +575,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> >
> >                 data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
> >                                                          indio_dev->name,
> > -                                                        indio_dev->id);
> > +                                                        iio_device_id(indio_dev));
> >                 if (!data->drdy_trig)
> >                         return -ENOMEM;
> >
> > diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> > index 8a9c576616ee..1948e2d22c27 100644
> > --- a/drivers/iio/potentiostat/lmp91000.c
> > +++ b/drivers/iio/potentiostat/lmp91000.c
> > @@ -323,7 +323,8 @@ static int lmp91000_probe(struct i2c_client *client,
> >         }
> >
> >         data->trig = devm_iio_trigger_alloc(dev, "%s-mux%d",
> > -                                           indio_dev->name, indio_dev->id);
> > +                                           indio_dev->name,
> > +                                           iio_device_id(indio_dev));
> >         if (!data->trig) {
> >                 dev_err(dev, "cannot allocate iio trigger.\n");
> >                 return -ENOMEM;
> > diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> > index a93411216aee..89295c90f801 100644
> > --- a/drivers/iio/pressure/zpa2326.c
> > +++ b/drivers/iio/pressure/zpa2326.c
> > @@ -1408,7 +1408,8 @@ static int zpa2326_init_managed_trigger(struct device          *parent,
> >                 return 0;
> >
> >         trigger = devm_iio_trigger_alloc(parent, "%s-dev%d",
> > -                                        indio_dev->name, indio_dev->id);
> > +                                        indio_dev->name,
> > +                                        iio_device_id(indio_dev));
> >         if (!trigger)
> >                 return -ENOMEM;
> >
> > diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> > index edc4a35ae66d..dc20fe81232c 100644
> > --- a/drivers/iio/proximity/as3935.c
> > +++ b/drivers/iio/proximity/as3935.c
> > @@ -404,7 +404,8 @@ static int as3935_probe(struct spi_device *spi)
> >         indio_dev->info = &as3935_info;
> >
> >         trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> > -                                     indio_dev->name, indio_dev->id);
> > +                                     indio_dev->name,
> > +                                     iio_device_id(indio_dev));
> >
> >         if (!trig)
> >                 return -ENOMEM;
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index 327ebb7ddbb9..175f3b7c61d7 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1473,7 +1473,7 @@ static int sx9310_probe(struct i2c_client *client)
> >
> >                 data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> >                                                     indio_dev->name,
> > -                                                   indio_dev->id);
> > +                                                   iio_device_id(indio_dev));
> >                 if (!data->trig)
> >                         return -ENOMEM;
> >
> > diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> > index a87f4a8e4327..3e4ddb2e8c2b 100644
> > --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -946,7 +946,7 @@ static int sx9500_probe(struct i2c_client *client,
> >                         return ret;
> >
> >                 data->trig = devm_iio_trigger_alloc(&client->dev,
> > -                               "%s-dev%d", indio_dev->name, indio_dev->id);
> > +                               "%s-dev%d", indio_dev->name, iio_device_id(indio_dev));
> >                 if (!data->trig)
> >                         return -ENOMEM;
> >
> > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> > index 32addd5e790e..e66b029d99de 100644
> > --- a/include/linux/iio/iio-opaque.h
> > +++ b/include/linux/iio/iio-opaque.h
> > @@ -6,6 +6,7 @@
> >  /**
> >   * struct iio_dev_opaque - industrial I/O device opaque information
> >   * @indio_dev:                 public industrial I/O device information
> > + * @id:                        used to identify device internally
> >   * @event_interface:           event chrdevs associated with interrupt lines
> >   * @attached_buffers:          array of buffers statically attached by the driver
> >   * @attached_buffers_cnt:      number of buffers in the array of statically attached buffers
> > @@ -26,6 +27,7 @@
> >   */
> >  struct iio_dev_opaque {
> >         struct iio_dev                  indio_dev;
> > +       int                             id;
> >         struct iio_event_interface      *event_interface;
> >         struct iio_buffer               **attached_buffers;
> >         unsigned int                    attached_buffers_cnt;
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index f2d65e2e88b6..569861d5887a 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -488,7 +488,6 @@ struct iio_buffer_setup_ops {
> >
> >  /**
> >   * struct iio_dev - industrial I/O device
> > - * @id:                        [INTERN] used to identify device internally
> >   * @driver_module:     [INTERN] used to make it harder to undercut users
> >   * @modes:             [DRIVER] operating modes supported by device
> >   * @currentmode:       [DRIVER] current operating mode
> > @@ -523,7 +522,6 @@ struct iio_buffer_setup_ops {
> >   *                     **MUST** be accessed **ONLY** via iio_priv() helper
> >   */
> >  struct iio_dev {
> > -       int                             id;
> >         struct module                   *driver_module;
> >
> >         int                             modes;
> > @@ -559,6 +557,8 @@ struct iio_dev {
> >         void                            *priv;
> >  };
> >
> > +int iio_device_id(struct iio_dev *indio_dev);
> > +
> >  const struct iio_chan_spec
> >  *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
> >  /**
> > --
> > 2.31.1
> >  

