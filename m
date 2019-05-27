Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9352B19E
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0JzR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 05:55:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35440 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0JzQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2019 05:55:16 -0400
Received: from laptop-1.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 634CD260CB2;
        Mon, 27 May 2019 10:55:14 +0100 (BST)
Message-ID: <3af7925c5dad281774b6d12826770cbefb32ea09.camel@collabora.com>
Subject: Re: [PATCH v2 2/3] iio: common: cros_ec_sensors: add sysfs
 attribute for frequencies
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@collabora.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 May 2019 11:55:11 +0200
In-Reply-To: <20190526184507.45c54053@archlinux>
References: <cover.1558601329.git.fabien.lahoudere@collabora.com>
         <f1891f9da2e9362a4efebf0ebce487b9584d4f5a.1558601329.git.fabien.lahoudere@collabora.com>
         <20190526184507.45c54053@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le dimanche 26 mai 2019 à 18:45 +0100, Jonathan Cameron a écrit :
> On Thu, 23 May 2019 11:07:36 +0200
> Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> 
> > In order to provide minimum and maximum frequencies for each
> > sensors,
> > we use a standard API (sampling_frequency_available) to provide
> > them
> > to userland.
> > As cros_ec_sensors_core_init do not manage default attrs, we change
> > the signature to let all kind of sensors to provide "struct
> > iio_info"
> > with their callback. This change impact drivers using that
> > function.
> > 
> > Then cros_ec_* sensors provides frequencies range in sysfs like
> > this:
> > [min step max]
> > 
> > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> When I was pointing at the _available syntax I was meaning that
> the ideal is to implement this using the associated callbacks rather
> than as a custom sysfs attribute.
> 

Sorry, I misunderstood. Let me retry with that callback implemented.

> > ---
> >  .../common/cros_ec_sensors/cros_ec_sensors.c  |  6 +--
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 38
> > +++++++++++++++++++
> >  drivers/iio/light/cros_ec_light_prox.c        |  6 +--
> >  drivers/iio/pressure/cros_ec_baro.c           |  6 +--
> >  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +-
> >  5 files changed, 50 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > index 17af4e0fd5f8..a0ecee15a6c8 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > @@ -172,7 +172,7 @@ static int cros_ec_sensors_write(struct iio_dev
> > *indio_dev,
> >  	return ret;
> >  }
> >  
> > -static const struct iio_info ec_sensors_info = {
> > +static struct iio_info ec_sensors_info = {
> >  	.read_raw = &cros_ec_sensors_read,
> >  	.write_raw = &cros_ec_sensors_write,
> >  };
> > @@ -195,11 +195,11 @@ static int cros_ec_sensors_probe(struct
> > platform_device *pdev)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  
> > -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> > +	ret = cros_ec_sensors_core_init(pdev, indio_dev,
> > &ec_sensors_info,
> > +					true);
> >  	if (ret)
> >  		return ret;
> >  
> > -	indio_dev->info = &ec_sensors_info;
> >  	state = iio_priv(indio_dev);
> >  	for (channel = state->channels, i = CROS_EC_SENSOR_X;
> >  	     i < CROS_EC_SENSOR_MAX_AXIS; i++, channel++) {
> > diff --git
> > a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index ac53ea32c1b1..08fb5d3dc7b5 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/common/cros_ec_sensors_core.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> >  #include <linux/iio/kfifo_buf.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/kernel.h>
> > @@ -86,8 +87,42 @@ static int
> > cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> >  	return ret;
> >  }
> >  
> > +/**
> > + * cros_ec_sensors_read_freq() - sysfs function to get available
> > frequencies
> > + * @dev: Device structure for this device.
> > + * @attr: Description of the attribute.
> > + * @buf: Incoming string
> > + *
> > + * The later modes are only relevant to the ring buffer - and
> > depend on current
> > + * mode. Note that data sheet gives rather wide tolerances for
> > these so integer
> > + * division will give good enough answer and not all chips have
> > them specified
> > + * at all.
> > + **/
> > +static ssize_t cros_ec_sensors_read_freq(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> > +
> > +	return snprintf(buf, PAGE_SIZE, "[%d 1 %d]\n", state->min_freq,
> > +			state->max_freq);
> Whilst it is a bit more fiddly I would much prefer if this was done
> with
> the info_mask_shared_by_all_available bit mask in the iio_dev and
> providing
> the read_avail callback.
> 
> The original reason to introduce this form was as part of trying to
> (far too slowly) kill off as much hand defined ABI as possible. 
> Ultimate aim is to make the IIO interface optional for cases where
> the channels are mostly being used by other consumer drivers rather
> than
> being directly consumed by userspace.  To do that we need all of
> these elements to be easily accessible from the consumer hooks.
> 
> 
> 
> > +}
> > +
> > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(cros_ec_sensors_read_freq);
> > +
> > +static struct attribute *cros_ec_sensors_attributes[] = {
> > +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static const struct attribute_group
> > cros_ec_sensors_attribute_group = {
> > +	.attrs = cros_ec_sensors_attributes,
> > +};
> > +
> >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> >  			      struct iio_dev *indio_dev,
> > +			      struct iio_info *info,
> >  			      bool physical_device)
> >  {
> >  	struct device *dev = &pdev->dev;
> > @@ -149,6 +184,9 @@ int cros_ec_sensors_core_init(struct
> > platform_device *pdev,
> >  		}
> >  	}
> >  
> > +	info->attrs = &cros_ec_sensors_attribute_group;
> > +	indio_dev->info = info;
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
> > diff --git a/drivers/iio/light/cros_ec_light_prox.c
> > b/drivers/iio/light/cros_ec_light_prox.c
> > index 308ee6ff2e22..1772e339cf14 100644
> > --- a/drivers/iio/light/cros_ec_light_prox.c
> > +++ b/drivers/iio/light/cros_ec_light_prox.c
> > @@ -161,7 +161,7 @@ static int cros_ec_light_prox_write(struct
> > iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > -static const struct iio_info cros_ec_light_prox_info = {
> > +static struct iio_info cros_ec_light_prox_info = {
> >  	.read_raw = &cros_ec_light_prox_read,
> >  	.write_raw = &cros_ec_light_prox_write,
> >  };
> > @@ -184,11 +184,11 @@ static int cros_ec_light_prox_probe(struct
> > platform_device *pdev)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  
> > -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> > +	ret = cros_ec_sensors_core_init(pdev, indio_dev,
> > +					&cros_ec_light_prox_info,
> > true);
> >  	if (ret)
> >  		return ret;
> >  
> > -	indio_dev->info = &cros_ec_light_prox_info;
> >  	state = iio_priv(indio_dev);
> >  	state->core.type = state->core.resp->info.type;
> >  	state->core.loc = state->core.resp->info.location;
> > diff --git a/drivers/iio/pressure/cros_ec_baro.c
> > b/drivers/iio/pressure/cros_ec_baro.c
> > index 034ce98d6e97..cd3be0f16226 100644
> > --- a/drivers/iio/pressure/cros_ec_baro.c
> > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > @@ -107,7 +107,7 @@ static int cros_ec_baro_write(struct iio_dev
> > *indio_dev,
> >  	return ret;
> >  }
> >  
> > -static const struct iio_info cros_ec_baro_info = {
> > +static struct iio_info cros_ec_baro_info = {
> >  	.read_raw = &cros_ec_baro_read,
> >  	.write_raw = &cros_ec_baro_write,
> >  };
> > @@ -130,11 +130,11 @@ static int cros_ec_baro_probe(struct
> > platform_device *pdev)
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  
> > -	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> > +	ret = cros_ec_sensors_core_init(pdev, indio_dev,
> > &cros_ec_baro_info,
> > +					true);
> >  	if (ret)
> >  		return ret;
> >  
> > -	indio_dev->info = &cros_ec_baro_info;
> >  	state = iio_priv(indio_dev);
> >  	state->core.type = state->core.resp->info.type;
> >  	state->core.loc = state->core.resp->info.location;
> > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h
> > b/include/linux/iio/common/cros_ec_sensors_core.h
> > index 32fd08bbcf52..f170a72ac08d 100644
> > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > @@ -114,12 +114,14 @@ struct platform_device;
> >   * cros_ec_sensors_core_init() - basic initialization of the core
> > structure
> >   * @pdev:		platform device created for the sensors
> >   * @indio_dev:		iio device structure of the device
> > + * @info:		iio info structure with read and write callback
> >   * @physical_device:	true if the device refers to a physical
> > device
> >   *
> >   * Return: 0 on success, -errno on failure.
> >   */
> >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> > -			      struct iio_dev *indio_dev, bool
> > physical_device);
> > +			      struct iio_dev *indio_dev, struct
> > iio_info *info,
> > +			      bool physical_device);
> >  
> >  /**
> >   * cros_ec_sensors_capture() - the trigger handler function

