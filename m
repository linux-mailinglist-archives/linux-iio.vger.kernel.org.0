Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05E02D8F27
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgLMRrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgLMRrF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:47:05 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25BE922BF5;
        Sun, 13 Dec 2020 17:46:23 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:46:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] iio: set default trig->dev.parent
Message-ID: <20201213174619.105576fd@archlinux>
In-Reply-To: <CA+U=DsrXhK_R-Xu-k-3V+-6CbiDuHX5kfGXLUiXLV2TLouxeUg@mail.gmail.com>
References: <20201210204211.967018-1-gwendal@chromium.org>
        <20201210204211.967018-2-gwendal@chromium.org>
        <CA+U=DsrXhK_R-Xu-k-3V+-6CbiDuHX5kfGXLUiXLV2TLouxeUg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Dec 2020 09:45:58 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Dec 10, 2020 at 10:42 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > When allocated with [devm_]iio_trigger_alloc(), set trig device parent to
> > the device the trigger is allocated for by default.
> >
> > It can always be reassigned in the probe routine.
> >
> > Change iio_trigger_alloc() API to add the device pointer to be coherent
> > with devm_iio_trigger_alloc, using similar interface to
> > iio_device_alloc().
Agreed. Might be quicker to do the name change at the end of this
patch series though as far fewer reference to deal with.

Thanks,

Jonathan

> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/accel/bma180.c                    |  3 +-
> >  drivers/iio/adc/ad_sigma_delta.c              |  4 +--
> >  drivers/iio/adc/at91_adc.c                    |  3 +-
> >  drivers/iio/adc/xilinx-xadc-core.c            |  4 +--
> >  .../common/hid-sensors/hid-sensor-trigger.c   |  4 +--
> >  .../common/st_sensors/st_sensors_trigger.c    |  4 +--
> >  drivers/iio/gyro/itg3200_buffer.c             |  3 +-
> >  drivers/iio/industrialio-trigger.c            | 31 ++++++++++++-------
> >  drivers/iio/trigger/iio-trig-hrtimer.c        |  2 +-
> >  drivers/iio/trigger/iio-trig-interrupt.c      |  2 +-
> >  drivers/iio/trigger/iio-trig-loop.c           |  2 +-
> >  drivers/iio/trigger/iio-trig-sysfs.c          |  3 +-
> >  include/linux/iio/trigger.h                   |  3 +-
> >  13 files changed, 36 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index 6b74c2b04c15..0526021a1aed 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -1041,7 +1041,7 @@ static int bma180_probe(struct i2c_client *client,
> >         indio_dev->info = &bma180_info;
> >
> >         if (client->irq > 0) {
> > -               data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> > +               data->trig = iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> >                         indio_dev->id);
> >                 if (!data->trig) {
> >                         ret = -ENOMEM;
> > @@ -1056,7 +1056,6 @@ static int bma180_probe(struct i2c_client *client,
> >                         goto err_trigger_free;
> >                 }
> >
> > -               data->trig->dev.parent = dev;
> >                 data->trig->ops = &bma180_trigger_ops;
> >                 iio_trigger_set_drvdata(data->trig, indio_dev);
> >                 indio_dev->trig = iio_trigger_get(data->trig);
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> > index 86039e9ecaca..c0ec61592283 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -477,7 +477,8 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
> >         struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
> >         int ret;
> >
> > -       sigma_delta->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> > +       sigma_delta->trig = iio_trigger_alloc(&sigma_delta->spi->dev,
> > +                                               "%s-dev%d", indio_dev->name,
> >                                                 indio_dev->id);
> >         if (sigma_delta->trig == NULL) {
> >                 ret = -ENOMEM;
> > @@ -498,7 +499,6 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
> >                 sigma_delta->irq_dis = true;
> >                 disable_irq_nosync(sigma_delta->spi->irq);
> >         }
> > -       sigma_delta->trig->dev.parent = &sigma_delta->spi->dev;
> >         iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
> >
> >         ret = iio_trigger_register(sigma_delta->trig);
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 9b2c548fae95..d4f5358bf22b 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -606,12 +606,11 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
> >         struct iio_trigger *trig;
> >         int ret;
> >
> > -       trig = iio_trigger_alloc("%s-dev%d-%s", idev->name,
> > +       trig = iio_trigger_alloc(idev->dev.parent, "%s-dev%d-%s", idev->name,
> >                                  idev->id, trigger->name);
> >         if (trig == NULL)
> >                 return NULL;
> >
> > -       trig->dev.parent = idev->dev.parent;
> >         iio_trigger_set_drvdata(trig, idev);
> >         trig->ops = &at91_adc_trigger_ops;
> >
> > diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> > index f93c34fe5873..8d2f7dfbc069 100644
> > --- a/drivers/iio/adc/xilinx-xadc-core.c
> > +++ b/drivers/iio/adc/xilinx-xadc-core.c
> > @@ -708,12 +708,12 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
> >         struct iio_trigger *trig;
> >         int ret;
> >
> > -       trig = iio_trigger_alloc("%s%d-%s", indio_dev->name,
> > +       trig = iio_trigger_alloc(indio_dev->dev.parent,
> > +                               "%s%d-%s", indio_dev->name,
> >                                 indio_dev->id, name);
> >         if (trig == NULL)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       trig->dev.parent = indio_dev->dev.parent;
> >         trig->ops = &xadc_trigger_ops;
> >         iio_trigger_set_drvdata(trig, iio_priv(indio_dev));
> >
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > index ff375790b7e8..7988e59b2f70 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > @@ -257,14 +257,14 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
> >                 return ret;
> >         }
> >
> > -       trig = iio_trigger_alloc("%s-dev%d", name, indio_dev->id);
> > +       trig = iio_trigger_alloc(indio_dev->dev.parent,
> > +                                       "%s-dev%d", name, indio_dev->id);
> >         if (trig == NULL) {
> >                 dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
> >                 ret = -ENOMEM;
> >                 goto error_triggered_buffer_cleanup;
> >         }
> >
> > -       trig->dev.parent = indio_dev->dev.parent;
> >         iio_trigger_set_drvdata(trig, attrb);
> >         trig->ops = &hid_sensor_trigger_ops;
> >         ret = iio_trigger_register(trig);
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > index 0507283bd4c1..23d8ec7160fc 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > @@ -127,7 +127,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> >         unsigned long irq_trig;
> >         int err;
> >
> > -       sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
> > +       sdata->trig = iio_trigger_alloc(sdata->dev, "%s-trigger",
> > +                                       indio_dev->name);
> >         if (sdata->trig == NULL) {
> >                 dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
> >                 return -ENOMEM;
> > @@ -135,7 +136,6 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> >
> >         iio_trigger_set_drvdata(sdata->trig, indio_dev);
> >         sdata->trig->ops = trigger_ops;
> > -       sdata->trig->dev.parent = sdata->dev;
> >
> >         irq_trig = irqd_get_trigger_type(irq_get_irq_data(sdata->irq));
> >         /*
> > diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> > index 1c3c1bd53374..af0aaa146f0c 100644
> > --- a/drivers/iio/gyro/itg3200_buffer.c
> > +++ b/drivers/iio/gyro/itg3200_buffer.c
> > @@ -113,7 +113,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
> >         int ret;
> >         struct itg3200 *st = iio_priv(indio_dev);
> >
> > -       st->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> > +       st->trig = iio_trigger_alloc(&st->i2c->dev, "%s-dev%d", indio_dev->name,
> >                                      indio_dev->id);
> >         if (!st->trig)
> >                 return -ENOMEM;
> > @@ -127,7 +127,6 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
> >                 goto error_free_trig;
> >
> >
> > -       st->trig->dev.parent = &st->i2c->dev;
> >         st->trig->ops = &itg3200_trigger_ops;
> >         iio_trigger_set_drvdata(st->trig, indio_dev);
> >         ret = iio_trigger_register(st->trig);
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index 583bb51f65a7..83006d1f7eea 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -516,8 +516,10 @@ static void iio_trig_subirqunmask(struct irq_data *d)
> >         trig->subirqs[d->irq - trig->subirq_base].enabled = true;
> >  }
> >
> > -static __printf(1, 0)
> > -struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> > +static __printf(2, 0)
> > +struct iio_trigger *viio_trigger_alloc(struct device *dev,
> > +                                      const char *fmt,
> > +                                      va_list vargs)
> >  {
> >         struct iio_trigger *trig;
> >         int i;
> > @@ -526,6 +528,7 @@ struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> >         if (!trig)
> >                 return NULL;
> >
> > +       trig->dev.parent = dev;
> >         trig->dev.type = &iio_trig_type;
> >         trig->dev.bus = &iio_bus_type;
> >         device_initialize(&trig->dev);
> > @@ -561,13 +564,23 @@ struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
> >         return NULL;
> >  }
> >
> > -struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
> > +/**
> > + * iio_trigger_alloc - Allocate a trigger
> > + * @dev:               Device to allocate iio_trigger for  
> 
> I think 'parent'  would be a better variable name for this.
> And the description could be something like 'Parent device for this trigger'
> I'd also propagate the name change in the entire 'industrialio-trigger.c' file.
> 
> > + * @fmt:               trigger name format. If it includes format
> > + *                     specifiers, the additional arguments following
> > + *                     format are formatted and inserted in the resulting
> > + *                     string replacing their respective specifiers.
> > + * RETURNS:
> > + * Pointer to allocated iio_trigger on success, NULL on failure.
> > + */
> > +struct iio_trigger *iio_trigger_alloc(struct device *dev, const char *fmt, ...)
> >  {
> >         struct iio_trigger *trig;
> >         va_list vargs;
> >
> >         va_start(vargs, fmt);
> > -       trig = viio_trigger_alloc(fmt, vargs);
> > +       trig = viio_trigger_alloc(dev, fmt, vargs);
> >         va_end(vargs);
> >
> >         return trig;
> > @@ -588,12 +601,6 @@ static void devm_iio_trigger_release(struct device *dev, void *res)
> >
> >  /**
> >   * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
> > - * @dev:               Device to allocate iio_trigger for
> > - * @fmt:               trigger name format. If it includes format
> > - *                     specifiers, the additional arguments following
> > - *                     format are formatted and inserted in the resulting
> > - *                     string replacing their respective specifiers.
> > - *
> >   * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
> >   * automatically freed on driver detach.
> >   *
> > @@ -601,7 +608,7 @@ static void devm_iio_trigger_release(struct device *dev, void *res)
> >   * Pointer to allocated iio_trigger on success, NULL on failure.
> >   */
> >  struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> > -                                               const char *fmt, ...)
> > +                                          const char *fmt, ...)
> >  {
> >         struct iio_trigger **ptr, *trig;
> >         va_list vargs;
> > @@ -613,7 +620,7 @@ struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> >
> >         /* use raw alloc_dr for kmalloc caller tracing */
> >         va_start(vargs, fmt);
> > -       trig = viio_trigger_alloc(fmt, vargs);
> > +       trig = viio_trigger_alloc(dev, fmt, vargs);
> >         va_end(vargs);
> >         if (trig) {
> >                 *ptr = trig;
> > diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> > index f59bf8d58586..3591bbbedf0c 100644
> > --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> > +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> > @@ -122,7 +122,7 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
> >         if (!trig_info)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       trig_info->swt.trigger = iio_trigger_alloc("%s", name);
> > +       trig_info->swt.trigger = iio_trigger_alloc(NULL, "%s", name);
> >         if (!trig_info->swt.trigger) {
> >                 ret = -ENOMEM;
> >                 goto err_free_trig_info;
> > diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> > index 94a487caf421..f746c460bf2a 100644
> > --- a/drivers/iio/trigger/iio-trig-interrupt.c
> > +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> > @@ -45,7 +45,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
> >
> >         irq = irq_res->start;
> >
> > -       trig = iio_trigger_alloc("irqtrig%d", irq);
> > +       trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
> >         if (!trig) {
> >                 ret = -ENOMEM;
> >                 goto error_ret;
> > diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> > index 4a00668e3258..96ec06bbe546 100644
> > --- a/drivers/iio/trigger/iio-trig-loop.c
> > +++ b/drivers/iio/trigger/iio-trig-loop.c
> > @@ -84,7 +84,7 @@ static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
> >         if (!trig_info)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       trig_info->swt.trigger = iio_trigger_alloc("%s", name);
> > +       trig_info->swt.trigger = iio_trigger_alloc(NULL, "%s", name);
> >         if (!trig_info->swt.trigger) {
> >                 ret = -ENOMEM;
> >                 goto err_free_trig_info;
> > diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
> > index e09e58072872..b861ee1bc79a 100644
> > --- a/drivers/iio/trigger/iio-trig-sysfs.c
> > +++ b/drivers/iio/trigger/iio-trig-sysfs.c
> > @@ -149,7 +149,7 @@ static int iio_sysfs_trigger_probe(int id)
> >                 goto out1;
> >         }
> >         t->id = id;
> > -       t->trig = iio_trigger_alloc("sysfstrig%d", id);
> > +       t->trig = iio_trigger_alloc(&iio_sysfs_trig_dev, "sysfstrig%d", id);
> >         if (!t->trig) {
> >                 ret = -ENOMEM;
> >                 goto free_t;
> > @@ -157,7 +157,6 @@ static int iio_sysfs_trigger_probe(int id)
> >
> >         t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
> >         t->trig->ops = &iio_sysfs_trigger_ops;
> > -       t->trig->dev.parent = &iio_sysfs_trig_dev;
> >         iio_trigger_set_drvdata(t->trig, t);
> >
> >         init_irq_work(&t->work, iio_sysfs_trigger_work);
> > diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> > index cad8325903f9..089e1961810c 100644
> > --- a/include/linux/iio/trigger.h
> > +++ b/include/linux/iio/trigger.h
> > @@ -161,7 +161,8 @@ void iio_trigger_poll_chained(struct iio_trigger *trig);
> >
> >  irqreturn_t iio_trigger_generic_data_rdy_poll(int irq, void *private);
> >
> > -__printf(1, 2) struct iio_trigger *iio_trigger_alloc(const char *fmt, ...);
> > +__printf(2, 3) struct iio_trigger *iio_trigger_alloc(struct device *dev,
> > +                                                    const char *fmt, ...);
> >  void iio_trigger_free(struct iio_trigger *trig);
> >
> >  /**
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >  

