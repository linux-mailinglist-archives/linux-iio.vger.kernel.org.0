Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA39363833
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 00:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhDRWV6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhDRWV6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 18:21:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501FEC06174A;
        Sun, 18 Apr 2021 15:21:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id w186so12604163wmg.3;
        Sun, 18 Apr 2021 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b1YVAgbZ/bJCK9jBNrYIDdxg8Fy9MB17IwZezyLYd3w=;
        b=tTMC5xNpUq8ZnHUzrxhZMImBsKCGL6rzsSaZ+PRZd44Uir5PY44M8zEx/dkj10xgJG
         qPrSXr1DjXvoOGwVOoY8eeOFOxEreLSg/wNv3Dq46y4gSSXgMiHirBaQw/cIRG9V/JD/
         96E9h15mgBdkqxNf7y/kGocP/YkZG6y6pe2+8zPJXIlHLYRLquUUssbyxuYKRFx9CY2f
         bEqFfR9X4kjh1EsCoI4E9EB/cMyUgxU3YLqKpn+fOUjz8LA1DxYAPjUoP8zC5Y5D9OgK
         ZyIVho/BfPSlhTSx5fxXAFCrQsk6BWLILMmbJAFBmP2k6YcAT56eTD3bfCbzzNUq7nPY
         bQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b1YVAgbZ/bJCK9jBNrYIDdxg8Fy9MB17IwZezyLYd3w=;
        b=CUmjuKhPkHihj1FAXwcQsaoRlrVz+/t+qz5q1g956a4bHM5h3vibT4+2lWnKqMdwMP
         VHIviUNpogNJW3OwSXji8jN30Cg9DAbXT2i2VpufPprrOaXRptanXunWIqQJN8gLAte1
         1TkD46jY02pdJGiHR3K4wQBlJNuvZ9paAzRb/Ur9WCw8wpNL5gw4K8hFhzhNVE+TagYQ
         nIu/GovJDdYWuG/rraVZ9vv9JLTTaDqOmsS+w1bt57oQ6Dql0N42U4aOvdSXsNBY82+i
         pbNlpVulXDnt45SW83m20p1j9dg/8ZLrBSvdwM8cEz1lhec3yfjwtR4IewjMpwC6J4H6
         pN1w==
X-Gm-Message-State: AOAM533eeAhTMmcmsP8nKVeS7IusEr+N0FS7KSLrPzesjm3qqVhuHVSV
        +rtxu3PonRdf7JypbAmStaA=
X-Google-Smtp-Source: ABdhPJxAvoRh2+pYY2j1QweAewIhzehos5+KnGrIsqfkWg1Arp+JIi3/3OzpLcJGr4nzXMao1dWxWA==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr18765817wmh.154.1618784486091;
        Sun, 18 Apr 2021 15:21:26 -0700 (PDT)
Received: from pop-os.localdomain ([2a01:4b00:8534:a300:35c9:f774:7b2:b3ba])
        by smtp.gmail.com with ESMTPSA id m14sm19692645wrh.28.2021.04.18.15.21.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Apr 2021 15:21:25 -0700 (PDT)
Date:   Sun, 18 Apr 2021 23:21:24 +0100
From:   Joe Sandom <joe.g.sandom@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     andy.shevchenko@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] Added AMS tsl2591 driver implementation
Message-ID: <20210418222124.gexyh6zt6bwkwo53@pop-os.localdomain>
References: <20210416174902.9036-1-joe.g.sandom@gmail.com>
 <20210418100830.6d7bc975@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418100830.6d7bc975@jic23-huawei>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 18, 2021 at 10:08:30AM +0100, Jonathan Cameron wrote:
> On Fri, 16 Apr 2021 18:49:01 +0100
> Joe Sandom <joe.g.sandom@gmail.com> wrote:
> 
> > Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
> > 
> > This driver supports configuration via device tree and sysfs.
> > Supported channels for raw infrared light intensity,
> > raw combined light intensity and illuminance in lux.
> > The driver additionally supports iio events on lower and
> > upper thresholds.
> > 
> > This is a very-high sensitivity light-to-digital converter that
> > transforms light intensity into a digital signal.
> > 
> > Datasheet: https://ams.com/tsl25911#tab/documents
> > Signed-off-by: Joe Sandom <joe.g.sandom@gmail.com>
> 
> Hi Joe,
> 
> I was in two minds about whether to just apply this and roll in the below
> suggestions + those Andy made or whether to ask you to do a v9.
> 
> The naming and units things below are complex enough that I'm not 100% sure
> I'd get the right so please take a look and clean up those last few
> corners!
> 
> Thanks,
> 
> Jonathan
> 
Thanks for the comments Jonathan. All good points! happy to clean up the
last few bits in v9. I'll aim to get this out over the next few days.

Thanks,

Joe
> 
> > ---
> > Changes in v8;
> > - tsl2591_write_raw() - goto after tsl2591_set_als_gain_int_time() not necessary
> > - tsl2591_read_event_value() and tsl2591_write_event_value() - break instead of goto in default case
> > - Introduced tsl2591_info_no_irq iio_info structure which is used when the interrupt is disabled. 
> >   This variant doesn't expose anything that can't be used when the interrupt is disabled
> > - Corrected ordering of includes for <asm/unaligned.h>
> > - Renamed TSL2591_FVAL_TO_ATIME to TSL2591_MSEC_TO_ATIME
> > - Renamed TSL2591_ATIME_TO_FVAL to TSL2591_ATIME_TO_MSEC
> > - Changed TSL2591_STS_ALS* defines to all use BIT for consistency
> > - Use (BIT(4) - 1) instead of value from list for TSL2591_PRST_ALS_INT_CYCLE_MAX
> > - Cleaned up a few blank lines that were unneccesary
> > - Use sysfs_emit() instead of snprintf() in tsl2591_in_illuminance_period_available_show()
> > - Use err_unlock branch instead of err to be clear on mutex_unlock cases
> > - Tidied up use of goto err_unlock in tsl2591_read_raw() to be consistent with other functions
> > 
> > NOTE;
> > - tsl2591_set_als_lower_threshold() and tsl2591_set_als_upper_threshold() forward declaration needed
> >   because tsl2591_set_als_lower_threshold() calls tsl2591_set_als_upper_threshold() and vice versa
> > 
> >  drivers/iio/light/Kconfig   |   11 +
> >  drivers/iio/light/Makefile  |    1 +
> >  drivers/iio/light/tsl2591.c | 1227 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 1239 insertions(+)
> >  create mode 100644 drivers/iio/light/tsl2591.c
> > 
> 
> ...
> 
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index ea376deaca54..d10912faf964 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
> >  obj-$(CONFIG_TCS3414)		+= tcs3414.o
> >  obj-$(CONFIG_TCS3472)		+= tcs3472.o
> >  obj-$(CONFIG_TSL2583)		+= tsl2583.o
> > +obj-$(CONFIG_TSL2591)		+= tsl2591.o
> >  obj-$(CONFIG_TSL2772)		+= tsl2772.o
> >  obj-$(CONFIG_TSL4531)		+= tsl4531.o
> >  obj-$(CONFIG_US5182D)		+= us5182d.o
> > diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> > new file mode 100644
> > index 000000000000..4f9c5e19ee35
> > --- /dev/null
> > +++ b/drivers/iio/light/tsl2591.c
> > @@ -0,0 +1,1227 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2020 Joe Sandom <joe.g.sandom@gmail.com>
> 
> Update perhaps?
> 
> > + *
> > + * Datasheet: https://ams.com/tsl25911#tab/documents
> > + *
> > + * Device driver for the TAOS TSL2591. This is a very-high sensitivity
> > + * light-to-digital converter that transforms light intensity into a digital
> > + * signal.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/sysfs.h>
> > +
> > +#include <asm/unaligned.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +/* ADC integration time, field value to time in ms */
> > +#define TSL2591_MSEC_TO_ATIME(x) (((x) + 1) * 100)
> 
> Naming here seems backwards.   I'd assume that at MSEC_TO_ATIME
> function went msecs -> atime but it seems to be doing the opposite.
> 
> > +/* ADC integration time, time in ms to field value */
> > +#define TSL2591_ATIME_TO_MSEC(x) (((x) / 100) - 1)
> > +
> 
> ...
> 
> > +
> > +/*
> > + * Period table is ALS persist cycle x integration time setting
> > + * Integration times: 100ms, 200ms, 300ms, 400ms, 500ms, 600ms
> > + * ALS cycles: 1, 2, 3, 5, 10, 20, 25, 30, 35, 40, 45, 50, 55, 60
> > + */
> > +static const char * const tsl2591_als_period_list[] = {
> > +	"0.1 0.2 0.3 0.5 1.0 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0",
> > +	"0.2 0.4 0.6 1.0 2.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0",
> > +	"0.3 0.6 0.9 1.5 3.0 6.0 7.5 9.0 10.5 12.0 13.5 15.0 16.5 18.0",
> > +	"0.4 0.8 1.2 2.0 4.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0 22.0 24.0",
> > +	"0.5 1.0 1.5 2.5 5.0 10.0 12.5 15.0 17.5 20.0 22.5 25.0 27.5 30.0",
> > +	"0.6 1.2 1.8 3.0 6.0 12.0 15.0 18.0 21.0 24.0 27.0 30.0 33.0 36.0",
> > +};
> > +
> > +static const int tsl2591_int_time_available[] = {
> > +	100, 200, 300, 400, 500, 600,
> 
> As mentioned below, these should be in seconds and I think here they are in milisecs.
> 
> > +};
> 
> ...
> 
> 
> > +static int tsl2591_wait_adc_complete(struct tsl2591_chip *chip)
> > +{
> > +	struct tsl2591_als_settings settings = chip->als_settings;
> > +	struct i2c_client *client = chip->client;
> > +	int delay;
> > +	int val;
> > +	int ret;
> > +
> > +	delay = TSL2591_MSEC_TO_ATIME(settings.als_int_time);
> > +	if (!delay)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Sleep for ALS integration time to allow enough time
> 
> Strangely short lines; perhaps rewrap?
> 
> > +	 * for an ADC read cycle to complete. Check status after
> > +	 * delay for ALS valid.
> > +	 */
> > +	msleep(delay);
> > +
> > +	/* Check for status ALS valid flag for up to 100ms */
> > +	ret = readx_poll_timeout(tsl2591_check_als_valid, client,
> > +				 val, val == TSL2591_STS_VAL_HIGH_MASK,
> > +				 TSL2591_DELAY_PERIOD_US,
> > +				 TSL2591_DELAY_PERIOD_US * TSL2591_ALS_STS_VALID_COUNT);
> > +	if (ret)
> > +		dev_err(&client->dev, "Timed out waiting for valid ALS data\n");
> > +
> > +	return ret;
> > +}
> > +
> 
> ...
> 
> > +
> > +static int tsl2591_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	struct i2c_client *client = chip->client;
> > +	int ret;
> > +
> > +	pm_runtime_get_sync(&client->dev);
> > +
> > +	mutex_lock(&chip->als_mutex);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (chan->type != IIO_INTENSITY) {
> > +			ret = -EINVAL;
> > +			goto err_unlock;
> > +		}
> > +
> > +		ret = tsl2591_read_channel_data(indio_dev, chan, val, val2);
> > +		if (ret < 0)
> > +			goto err_unlock;
> > +
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		if (chan->type != IIO_LIGHT) {
> > +			ret = -EINVAL;
> > +			goto err_unlock;
> > +		}
> > +
> > +		ret = tsl2591_read_channel_data(indio_dev, chan, val, val2);
> > +		if (ret < 0)
> > +			break;
> > +
> > +		ret = IIO_VAL_INT_PLUS_MICRO;
> > +		break;
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		if (chan->type != IIO_INTENSITY) {
> > +			ret = -EINVAL;
> > +			goto err_unlock;
> > +		}
> > +
> > +		*val = TSL2591_MSEC_TO_ATIME(chip->als_settings.als_int_time);
> 
> My gut feeling was that integration time should be in seconds, not milliseconds.
> Seems our documentation on this is lacking, though there are other integration_time
> entries that are stated as being in seconds.  I haven't checked all the
> drivers, but the first few I looked at do have this in seconds.
> The vast majority of IIO units effectively the base SI unit.  Exceptions exist
> where we (unwisely) decided to try and match hwmon, or where the particular thing
> being measured is always so small in the base units that it gets silly.
> 
> Documentation/ABI/testing/sysfs-bus-iio
> 
> If you fancy improving the docs as a follow up patch to make the unit more explicit
> that would be great, if not I'll get to it at some point.
> 
> 
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		if (chan->type != IIO_INTENSITY) {
> > +			ret = -EINVAL;
> > +			goto err_unlock;
> > +		}
> > +
> > +		*val = tsl2591_gain_to_multiplier(chip->als_settings.als_gain);
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +err_unlock:
> > +	mutex_unlock(&chip->als_mutex);
> > +
> > +	pm_runtime_mark_last_busy(&client->dev);
> > +	pm_runtime_put_autosuspend(&client->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int tsl2591_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	struct tsl2591_chip *chip = iio_priv(indio_dev);
> > +	u32 int_time;
> > +	u8 gain;
> > +	int ret;
> > +
> > +	mutex_lock(&chip->als_mutex);
> 
> It isn't particularly important but i would have been inclined to tighten
> the scope of this mutex lock so that it only covered the parts of
> this code that touch state rather than the conversions and range checks.
> 
> Up to you however on whether you bother at this stage!
> 
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		int_time = tsl2591_als_time_to_fval(val);
> > +		if (int_time < 0) {
> > +			ret = int_time;
> > +			goto err_unlock;
> > +		}
> > +		ret = tsl2591_compatible_int_time(chip, int_time);
> > +		if (ret < 0)
> > +			goto err_unlock;
> > +
> > +		chip->als_settings.als_int_time = int_time;
> > +		break;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		gain = tsl2591_multiplier_to_gain(val);
> > +		if (gain < 0) {
> > +			ret = gain;
> > +			goto err_unlock;
> > +		}
> > +		ret = tsl2591_compatible_gain(chip, gain);
> > +		if (ret < 0)
> > +			goto err_unlock;
> > +
> > +		chip->als_settings.als_gain = gain;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto err_unlock;
> > +	}
> > +
> > +	ret = tsl2591_set_als_gain_int_time(chip);
> > +
> > +err_unlock:
> > +	mutex_unlock(&chip->als_mutex);
> > +	return ret;
> > +}
> > +
> 
> ...
> 
> > +
> > +static const struct iio_info tsl2591_info = {
> > +	.event_attrs = &tsl2591_event_attribute_group,
> > +	.read_raw = tsl2591_read_raw,
> > +	.write_raw = tsl2591_write_raw,
> > +	.read_avail = tsl2591_read_available,
> > +	.read_event_value = tsl2591_read_event_value,
> > +	.write_event_value = tsl2591_write_event_value,
> > +	.read_event_config = tsl2591_read_event_config,
> > +	.write_event_config = tsl2591_write_event_config,
> > +};
> > +
> > +static const struct iio_info tsl2591_info_no_irq = {
> > +	.event_attrs = &tsl2591_event_attribute_group,
> 
> Why have event attributes if no irq and hence no events?
> 
> > +	.read_raw = tsl2591_read_raw,
> > +	.write_raw = tsl2591_write_raw,
> > +	.read_avail = tsl2591_read_available,
> > +};
> > +
> 
> ...
> 
> > +
> > +static int tsl2591_probe(struct i2c_client *client)
> > +{
> > +	struct tsl2591_chip *chip;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> > +		dev_err(&client->dev,
> > +			"I2C smbus byte data functionality is not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	chip = iio_priv(indio_dev);
> > +	chip->client = client;
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	if (client->irq) {
> > +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +						NULL, tsl2591_event_handler,
> > +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +						"tsl2591_irq", indio_dev);
> > +		if (ret) {
> > +			dev_err(&client->dev, "IRQ request error %d\n", -ret);
> 
> dev_err_probe() as that won't print an error message if you get a deferred probe
> error (and so will come around again later). That could happen here if the
> irq chip driver hasn't loaded yet.
> 
> > +			return -EINVAL;
> > +		}
> > +		indio_dev->info = &tsl2591_info;
> > +	} else {
> > +		indio_dev->info = &tsl2591_info_no_irq;
> > +	}
> > +
> > +	mutex_init(&chip->als_mutex);
> > +
> > +	ret = i2c_smbus_read_byte_data(client,
> > +				       TSL2591_CMD_NOP | TSL2591_DEVICE_ID);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev,
> > +			"Failed to read the device ID register\n");
> > +		return ret;
> > +	}
> > +	ret = FIELD_GET(TSL2591_DEVICE_ID_MASK, ret);
> > +	if (ret != TSL2591_DEVICE_ID_VAL) {
> > +		dev_err(&client->dev, "Device ID: %#04x unknown\n", ret);
> > +		return -EINVAL;
> > +	}
> > +
> > +	indio_dev->channels = tsl2591_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(tsl2591_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->name = chip->client->name;
> > +	chip->events_enabled = false;
> > +
> > +	pm_runtime_enable(&client->dev);
> > +	pm_runtime_set_autosuspend_delay(&client->dev,
> > +					 TSL2591_POWER_OFF_DELAY_MS);
> > +	pm_runtime_use_autosuspend(&client->dev);
> > +
> > +	/*
> > +	 * Add chip off to automatically managed path and disable runtime
> > +	 * power management. This ensures that the chip power management
> > +	 * is handled correctly on driver remove. tsl2591_chip_off() must be
> > +	 * added to the managed path after pm runtime is enabled and before
> > +	 * any error exit paths are met to ensure we're not left in a state
> > +	 * of pm runtime not being disabled properly.
> > +	 */
> > +	ret = devm_add_action_or_reset(&client->dev, tsl2591_chip_off,
> > +				       indio_dev);
> > +	if (ret < 0)
> > +		return -EINVAL;
> > +
> > +	ret = tsl2591_load_defaults(chip);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to load sensor defaults\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = i2c_smbus_write_byte(client, TSL2591_CMD_SF_CALS_NPI);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to clear als irq\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> 
> ...
