Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59746BCA19
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 16:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437071AbfIXOVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 10:21:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43690 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392451AbfIXOVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 10:21:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aragua)
        with ESMTPSA id 524CA28A164
Message-ID: <6b50bdff184e6af664b7a61e0a8a2cddc5718f0a.camel@collabora.com>
Subject: Re: [PATCH v2 1/1] counter: cros_ec: Add synchronization sensor
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 24 Sep 2019 16:20:51 +0200
In-Reply-To: <8abbe9360938ab851d16c2c1494ba56034775823.camel@collabora.com>
References: <cover.1566563833.git.fabien.lahoudere@collabora.com>
                 <d985a8a811996148e8cda78b9fe47bb87b884b56.1566563833.git.fabien.lahoudere@collabora.com>
                 <20190826095612.7455cb05@archlinux>
         <8abbe9360938ab851d16c2c1494ba56034775823.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

After some discussions and investigation, the timestamp is very
important for that sync driver.
Google team uses that timestamp to compare with gyroscope timestamp.

So the important data is timestamp and counter value is useless.
Just the event of counter increment is important to get a timestamp.

In that case, my idea was to just use an IIO driver with a single
channel with IIO_TIMESTAMP. We discuss this here and it seems
controversial.

So my question to Jonathan is if we have a timestamp coming from the EC
itself, can we consider this timestamp as a good IIO driver?

Any other idea is welcome, however Google team would like to manage
only IIO drivers if possible.

Thanks


Le jeudi 29 août 2019 à 13:10 +0200, Fabien Lahoudere a écrit :
> Le lundi 26 août 2019 à 09:56 +0100, Jonathan Cameron a écrit :
> > On Fri, 23 Aug 2019 14:41:27 +0200
> > Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> > 
> > > From: Gwendal Grignou <gwendal@chromium.org>
> > > 
> > > EC returns a counter when there is an event on camera vsync.
> > > This patch comes from chromeos kernel 4.4
> > > 
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > 
> > > CROS EC sync sensor was originally designed as an IIO device.
> > > Now that the counter subsystem will replace IIO_COUNTER, we
> > > have to implement a new way to get sync count.
> > 
> > I'm curious.  What is this counter used for?
> 
> It is a counter of a pin connected to a camera vsync.
> It is used to manage correct orientation of the camera when the
> gyroscope detect a change.
> 
> > This combined counter and iio driver isn't something we would
> > normally
> > want to support.  What is the reasoning behind doing both
> > interfaces?
> 
> That patch was originally designed using only IIO with IIO_count and
> IIO_TIMESTAMP channel. As IIO_COUNT is deprecated, we need to use the
> new counter subsystem. So I just split the driver in two part counter
> and iio timestamp.
> 
> However after your email I did some investigation and did not find
> any
> use of the timestamp for that sensor. Timestamp is just a common
> channel implemented on all CROS EC sensors.
> 
> So I think I will drop it now and if a timestamp is needed, I will
> probably restart the discussion about timestamp in the counter
> subsystemif that make sense to have one.
> 
> Thanks
> 
> Fabien
> 
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > ---
> > >  Documentation/driver-api/generic-counter.rst  |   3 +
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/counter/Kconfig                       |   9 +
> > >  drivers/counter/Makefile                      |   1 +
> > >  drivers/counter/counter.c                     |   2 +
> > >  drivers/counter/cros_ec_sensors_sync.c        | 208
> > > ++++++++++++++++++
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
> > >  drivers/mfd/cros_ec_dev.c                     |   3 +
> > >  include/linux/counter.h                       |   1 +
> > >  9 files changed, 235 insertions(+)
> > >  create mode 100644 drivers/counter/cros_ec_sensors_sync.c
> > > 
> > > diff --git a/Documentation/driver-api/generic-counter.rst
> > > b/Documentation/driver-api/generic-counter.rst
> > > index 8382f01a53e3..beb80714ac8b 100644
> > > --- a/Documentation/driver-api/generic-counter.rst
> > > +++ b/Documentation/driver-api/generic-counter.rst
> > > @@ -44,6 +44,9 @@ Counter interface provides the following
> > > available count data types:
> > >  * COUNT_POSITION:
> > >    Unsigned integer value representing position.
> > >  
> > > +* COUNT_TALLY:
> > > +  Unsigned integer value representing tally.
> > > +
> > >  A Count has a count function mode which represents the update
> > > behavior
> > >  for the count data. The Generic Counter interface provides the
> > > following
> > >  available count function modes:
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e60f5c361969..83bd291d103e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3902,6 +3902,13 @@ R:	Guenter Roeck <groeck@chromium.org>
> > >  F:	Documentation/devicetree/bindings/sound/google,cros-ec-
> > > codec.txt
> > >  F:	sound/soc/codecs/cros_ec_codec.*
> > >  
> > > +CHROMEOS EC COUNTER DRIVER
> > > +M:	Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > +M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> > > +L:	linux-iio@vger.kernel.org
> > > +S:	Maintained
> > > +F:	drivers/counter/cros_ec_sensors_sync.c
> > > +
> > >  CIRRUS LOGIC AUDIO CODEC DRIVERS
> > >  M:	Brian Austin <brian.austin@cirrus.com>
> > >  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> > > diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> > > index 2967d0a9ff91..22287f5715e5 100644
> > > --- a/drivers/counter/Kconfig
> > > +++ b/drivers/counter/Kconfig
> > > @@ -59,4 +59,13 @@ config FTM_QUADDEC
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called ftm-quaddec.
> > >  
> > > +config IIO_CROS_EC_SENSORS_SYNC
> > > +	tristate "ChromeOS EC Counter Sensors"
> > > +	depends on IIO_CROS_EC_SENSORS_CORE && IIO
> > > +	help
> > > +	  Module to handle synchronisation sensors presented by the
> > > ChromeOS EC
> > > +	  Sensor hub.
> > > +	  Synchronisation sensors are counter sensors triggered when
> > > events
> > > +	  occurs from other subsystems.
> > > +
> > >  endif # COUNTER
> > > diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> > > index 40d35522937d..6fe4c98a446f 100644
> > > --- a/drivers/counter/Makefile
> > > +++ b/drivers/counter/Makefile
> > > @@ -9,3 +9,4 @@ obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
> > >  obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
> > >  obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
> > >  obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
> > > +obj-$(CONFIG_IIO_CROS_EC_SENSORS_SYNC) += cros_ec_sensors_sync.o
> > > diff --git a/drivers/counter/counter.c
> > > b/drivers/counter/counter.c
> > > index 106bc7180cd8..53525b109094 100644
> > > --- a/drivers/counter/counter.c
> > > +++ b/drivers/counter/counter.c
> > > @@ -261,6 +261,7 @@ void counter_count_read_value_set(struct
> > > counter_count_read_value *const val,
> > >  {
> > >  	switch (type) {
> > >  	case COUNTER_COUNT_POSITION:
> > > +	case COUNTER_COUNT_TALLY:
> > >  		val->len = sprintf(val->buf, "%lu\n", *(unsigned long
> > > *)data);
> > >  		break;
> > >  	default:
> > > @@ -290,6 +291,7 @@ int counter_count_write_value_get(void *const
> > > data,
> > >  
> > >  	switch (type) {
> > >  	case COUNTER_COUNT_POSITION:
> > > +	case COUNTER_COUNT_TALLY:
> > >  		err = kstrtoul(val->buf, 0, data);
> > >  		if (err)
> > >  			return err;
> > > diff --git a/drivers/counter/cros_ec_sensors_sync.c
> > > b/drivers/counter/cros_ec_sensors_sync.c
> > > new file mode 100644
> > > index 000000000000..b6f5e2c6da9f
> > > --- /dev/null
> > > +++ b/drivers/counter/cros_ec_sensors_sync.c
> > > @@ -0,0 +1,208 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Driver of counter incremented after events on interrupt line
> > > in
> > > EC.
> > > + *
> > > + * Copyright 2018 Google, Inc
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/counter.h>
> > > +#include <linux/iio/common/cros_ec_sensors_core.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mfd/cros_ec.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#define DRV_NAME "cros-ec-sync"
> > > +
> > > +/*
> > > + * One channel for counter, the other for timestamp.
> > > + */
> > > +#define MAX_CHANNELS (1)
> > > +
> > > +/* State data for ec_sensors iio driver. */
> > > +struct cros_ec_sensors_sync_state {
> > > +	/* Shared by all sensors */
> > > +	struct cros_ec_sensors_core_state core;
> > > +	struct counter_device counter;
> > > +	struct iio_chan_spec channels[MAX_CHANNELS];
> > > +};
> > > +
> > > +static int cros_ec_sensors_sync_read(struct iio_dev *indio_dev,
> > > +				     struct iio_chan_spec const *chan,
> > > +				     int *val, int *val2, long mask)
> > > +{
> > > +	struct cros_ec_sensors_sync_state *st = iio_priv(indio_dev);
> > > +	u16 data;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&st->core.cmd_lock);
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		ret = cros_ec_sensors_read_cmd(indio_dev, BIT(0),
> > > &data);
> > > +		if (ret < 0)
> > > +			break;
> > > +		ret = IIO_VAL_INT;
> > > +		*val = data;
> > > +		break;
> > > +	default:
> > > +		ret = cros_ec_sensors_core_read(&st->core, chan, val,
> > > val2,
> > > +						mask);
> > > +		break;
> > > +	}
> > > +	mutex_unlock(&st->core.cmd_lock);
> > > +	return ret;
> > > +}
> > > +
> > > +static struct iio_info cros_ec_sensors_sync_info = {
> > > +	.read_raw = &cros_ec_sensors_sync_read,
> > > +	.read_avail = &cros_ec_sensors_core_read_avail,
> > > +};
> > > +
> > > +static struct counter_count cros_ec_sync_counts = {
> > > +	.id = 0,
> > > +	.name = "Cros EC sync counter",
> > > +};
> > > +
> > > +static int cros_ec_sync_cnt_read(struct counter_device *counter,
> > > +				struct counter_count *count,
> > > +				struct counter_count_read_value *val)
> > > +{
> > > +	s16 cnt;
> > > +	int ret;
> > > +	struct iio_dev *indio_dev = counter->priv;
> > > +	struct cros_ec_sensors_sync_state *const st =
> > > iio_priv(indio_dev);
> > > +	unsigned long data;
> > > +
> > > +	mutex_lock(&st->core.cmd_lock);
> > > +	ret = cros_ec_sensors_read_cmd(indio_dev, BIT(0), &cnt);
> > > +	mutex_unlock(&st->core.cmd_lock);
> > > +	if (ret != 0) {
> > > +		dev_warn(&indio_dev->dev, "Unable to read sensor
> > > data\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	data = (unsigned long) cnt;
> > > +	counter_count_read_value_set(val, COUNTER_COUNT_TALLY, &data);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct counter_ops cros_ec_sync_cnt_ops = {
> > > +	.count_read = cros_ec_sync_cnt_read,
> > > +};
> > > +
> > > +static char *cros_ec_loc[] = {
> > > +	[MOTIONSENSE_LOC_BASE] = "base",
> > > +	[MOTIONSENSE_LOC_LID] = "lid",
> > > +	[MOTIONSENSE_LOC_CAMERA] = "camera",
> > > +	[MOTIONSENSE_LOC_MAX] = "unknown",
> > > +};
> > > +
> > > +static ssize_t cros_ec_sync_id(struct counter_device *counter,
> > > +				  void *private, char *buf)
> > > +{
> > > +	struct iio_dev *indio_dev = counter->priv;
> > > +	struct cros_ec_sensors_sync_state *const st =
> > > iio_priv(indio_dev);
> > > +
> > > +	return snprintf(buf, PAGE_SIZE, "%d\n", st-
> > > > core.param.info.sensor_num);
> > > +}
> > > +
> > > +static ssize_t cros_ec_sync_loc(struct counter_device *counter,
> > > +				   void *private, char *buf)
> > > +{
> > > +	struct iio_dev *indio_dev = counter->priv;
> > > +	struct cros_ec_sensors_sync_state *const st =
> > > iio_priv(indio_dev);
> > > +
> > > +	return snprintf(buf, PAGE_SIZE, "%s\n", cros_ec_loc[st-
> > > > core.loc]);
> > > +}
> > > +
> > > +static struct counter_device_ext cros_ec_sync_cnt_ext[] = {
> > > +	{
> > > +		.name = "id",
> > > +		.read = cros_ec_sync_id
> > > +	},
> > > +	{
> > > +		.name = "location",
> > > +		.read = cros_ec_sync_loc
> > > +	},
> > > +};
> > > +
> > > +static int cros_ec_sensors_sync_probe(struct platform_device
> > > *pdev)
> > > +{
> > > +	struct cros_ec_sensors_sync_state *state;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct iio_chan_spec *channel;
> > > +	struct iio_dev *indio_dev;
> > > +	int ret;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	indio_dev->info = &cros_ec_sensors_sync_info;
> > > +	state = iio_priv(indio_dev);
> > > +
> > > +	if (state->core.type != MOTIONSENSE_TYPE_SYNC)
> > > +		return -EINVAL;
> > > +
> > > +	/* Initialize IIO device */
> > > +	channel = state->channels;
> > > +	channel->type = IIO_TIMESTAMP;
> > > +	channel->channel = -1;
> > > +	channel->scan_index = 1;
> > > +	channel->scan_type.sign = 's';
> > > +	channel->scan_type.realbits = 64;
> > > +	channel->scan_type.storagebits = 64;
> > > +
> > > +	indio_dev->channels = state->channels;
> > > +	indio_dev->num_channels = MAX_CHANNELS;
> > > +
> > > +	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> > > +
> > > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > > +					      cros_ec_sensors_capture,
> > > NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = devm_iio_device_register(dev, indio_dev);
> > 
> > Hmm. Wasn't expecting to see that here if it's a counter device.
> > 
> > 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Initialize counter device */
> > > +	state->counter.name = dev_name(&pdev->dev);
> > > +	state->counter.parent = &pdev->dev;
> > > +	state->counter.counts = &cros_ec_sync_counts;
> > > +	state->counter.num_counts = 1;
> > > +	state->counter.priv = indio_dev;
> > > +	state->counter.ops = &cros_ec_sync_cnt_ops;
> > > +	state->counter.ext = cros_ec_sync_cnt_ext;
> > > +	state->counter.num_ext = ARRAY_SIZE(cros_ec_sync_cnt_ext);
> > > +
> > > +	return devm_counter_register(&pdev->dev, &state->counter);
> > > +}
> > > +
> > > +static const struct platform_device_id
> > > cros_ec_sensors_sync_ids[]
> > > = {
> > > +	{ .name = DRV_NAME, },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(platform, cros_ec_sensors_sync_ids);
> > > +
> > > +static struct platform_driver
> > > cros_ec_sensors_sync_platform_driver
> > > = {
> > > +	.driver = {
> > > +		.name	= DRV_NAME,
> > > +		.pm	= &cros_ec_sensors_pm_ops,
> > > +	},
> > > +	.probe		= cros_ec_sensors_sync_probe,
> > > +	.id_table	= cros_ec_sensors_sync_ids,
> > > +};
> > > +module_platform_driver(cros_ec_sensors_sync_platform_driver);
> > > +
> > > +MODULE_DESCRIPTION("ChromeOS EC synchronisation sensor driver");
> > > +MODULE_ALIAS("platform:" DRV_NAME);
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git
> > > a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > index 805652250960..2bf183425eaf 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > @@ -22,6 +22,7 @@
> > >  static char *cros_ec_loc[] = {
> > >  	[MOTIONSENSE_LOC_BASE] = "base",
> > >  	[MOTIONSENSE_LOC_LID] = "lid",
> > > +	[MOTIONSENSE_LOC_CAMERA] = "camera",
> > >  	[MOTIONSENSE_LOC_MAX] = "unknown",
> > >  };
> > >  
> > > diff --git a/drivers/mfd/cros_ec_dev.c
> > > b/drivers/mfd/cros_ec_dev.c
> > > index 41dccced5026..1c5c2c38af88 100644
> > > --- a/drivers/mfd/cros_ec_dev.c
> > > +++ b/drivers/mfd/cros_ec_dev.c
> > > @@ -332,6 +332,9 @@ static void cros_ec_sensors_register(struct
> > > cros_ec_dev *ec)
> > >  		case MOTIONSENSE_TYPE_ACTIVITY:
> > >  			sensor_cells[id].name = "cros-ec-activity";
> > >  			break;
> > > +		case MOTIONSENSE_TYPE_SYNC:
> > > +			sensor_cells[id].name = "cros-ec-sync";
> > > +			break;
> > >  		default:
> > >  			dev_warn(ec->dev, "unknown type %d\n", resp-
> > > > info.type);
> > >  			continue;
> > > diff --git a/include/linux/counter.h b/include/linux/counter.h
> > > index a061cdcdef7c..1198e675306f 100644
> > > --- a/include/linux/counter.h
> > > +++ b/include/linux/counter.h
> > > @@ -488,6 +488,7 @@ enum counter_signal_value_type {
> > >  
> > >  enum counter_count_value_type {
> > >  	COUNTER_COUNT_POSITION = 0,
> > > +	COUNTER_COUNT_TALLY
> > >  };
> > >  
> > >  void counter_signal_read_value_set(struct
> > > counter_signal_read_value *const val,
> 
> 

