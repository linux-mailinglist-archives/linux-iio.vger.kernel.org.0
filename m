Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE69B6F491
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 20:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfGUSMB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 14:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfGUSMB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Jul 2019 14:12:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7427B20693;
        Sun, 21 Jul 2019 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563732719;
        bh=KHltdHqRERaJyaikRSsbvznYUbjxAYnQEyFVUUtwCmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C89MeE9T3Q6DViblKHi+FQEKmJeAxmEEZBRsZBySdgJ3dhZrirxJ/zRHPxYO00VzD
         auM1nrqQWDnBRXU4RzmXapggfL757rWg84gmZ2U4umt3ZnA+K67/E/whnEtP9RmjxJ
         gxysHZFIL93sLFNxBHzesdk065VtGRxdurfYSRTY=
Date:   Sun, 21 Jul 2019 19:03:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 10/11] iio: move 3-wire spi initialization to
 st_sensors_spi
Message-ID: <20190721190303.3c61b867@archlinux>
In-Reply-To: <20190721185836.7063ba7b@archlinux>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-11-denis.ciocca@st.com>
        <20190721185836.7063ba7b@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Jul 2019 18:58:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 18 Jul 2019 15:53:52 -0700
> Denis Ciocca <denis.ciocca@st.com> wrote:
> 
> > Some devices need to be configured with special bit in order to
> > use spi 3-wire. This was done during device identification phase.
> > Instead, let's move this part as spi specific.
> > Doing this the check_device_support function becomes a simple
> > device id check, so let's rename it.
> > 
> > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>  
> A sensible solution so applied to the togreg branch of iio.git and pushed
> out as testing for the autobuilders to play with it.
Actually, your split between this patch and the next went wrong.
I've fixed up around line 651.

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > Changes in v2:
> >  not there in v1.
> > 
> >  drivers/iio/accel/st_accel_core.c             |  4 +-
> >  drivers/iio/accel/st_accel_spi.c              |  4 +-
> >  .../iio/common/st_sensors/st_sensors_core.c   | 64 +++++-------------
> >  .../iio/common/st_sensors/st_sensors_spi.c    | 65 ++++++++++++++++++-
> >  drivers/iio/gyro/st_gyro_core.c               |  4 +-
> >  drivers/iio/gyro/st_gyro_spi.c                |  4 +-
> >  drivers/iio/magnetometer/st_magn_core.c       |  4 +-
> >  drivers/iio/magnetometer/st_magn_spi.c        |  4 +-
> >  drivers/iio/pressure/st_pressure_core.c       |  4 +-
> >  drivers/iio/pressure/st_pressure_spi.c        |  4 +-
> >  include/linux/iio/common/st_sensors.h         |  3 +-
> >  include/linux/iio/common/st_sensors_spi.h     |  4 +-
> >  12 files changed, 97 insertions(+), 71 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> > index 6fc490ffef7e..630909702a19 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -1183,9 +1183,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
> >  	if (err)
> >  		return err;
> >  
> > -	err = st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_accel_sensors_settings),
> > -					st_accel_sensors_settings);
> > +	err = st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_accel_power_off;
> >  
> > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> > index c0556db9d60a..8af7027d5598 100644
> > --- a/drivers/iio/accel/st_accel_spi.c
> > +++ b/drivers/iio/accel/st_accel_spi.c
> > @@ -124,7 +124,9 @@ static int st_accel_spi_probe(struct spi_device *spi)
> >  	adata = iio_priv(indio_dev);
> >  	adata->sensor_settings = (struct st_sensor_settings *)settings;
> >  
> > -	st_sensors_spi_configure(indio_dev, spi, adata);
> > +	err = st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> >  
> >  	err = st_accel_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> > index 3610ca9eaa87..40977d2ee400 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > @@ -608,31 +608,6 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
> >  }
> >  EXPORT_SYMBOL(st_sensors_read_info_raw);
> >  
> > -static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> > -			const struct st_sensor_settings *sensor_settings)
> > -{
> > -	struct st_sensor_data *sdata = iio_priv(indio_dev);
> > -	struct device_node *np = sdata->dev->of_node;
> > -	struct st_sensors_platform_data *pdata;
> > -
> > -	pdata = (struct st_sensors_platform_data *)sdata->dev->platform_data;
> > -	if (((np && of_property_read_bool(np, "spi-3wire")) ||
> > -	     (pdata && pdata->spi_3wire)) && sensor_settings->sim.addr) {
> > -		int err;
> > -
> > -		err = sdata->tf->write_byte(&sdata->tb, sdata->dev,
> > -					    sensor_settings->sim.addr,
> > -					    sensor_settings->sim.value);
> > -		if (err < 0) {
> > -			dev_err(&indio_dev->dev,
> > -				"failed to init interface mode\n");
> > -			return err;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  /*
> >   * st_sensors_get_settings_index() - get index of the sensor settings for a
> >   *				     specific device from list of settings
> > @@ -660,36 +635,30 @@ int st_sensors_get_settings_index(const char *name,
> >  }
> >  EXPORT_SYMBOL(st_sensors_get_settings_index);
> >  
> > -int st_sensors_check_device_support(struct iio_dev *indio_dev,
> > -			int num_sensors_list,
> > -			const struct st_sensor_settings *sensor_settings)
> > +/*
> > + * st_sensors_verify_id() - verify sensor ID (WhoAmI) is matching with the
> > + *			    expected value
> > + * @indio_dev: IIO device reference.
> > + *
> > + * Return: 0 on success (valid sensor ID), else a negative error code.
> > + */
> > +int st_sensors_verify_id(struct iio_dev *indio_dev)
> >  {
> >  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> > -	int i, err;
> > +	int err;
> >  	u8 wai;
> >  
> > -	i = st_sensors_get_settings_index(indio_dev->name,
> > -					  sensor_settings, num_sensors_list);
> > -	if (i < 0) {
> > -		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
> > -			indio_dev->name);
> > -		return i;
> > -	}
> > -
> > -	err = st_sensors_init_interface_mode(indio_dev, &sensor_settings[i]);
> > -	if (err < 0)
> > -		return err;
> > -
> > -	if (sensor_settings[i].wai_addr) {
> > +	if (settings->wai_addr) {
This 'settings' variable doesn't exist. Next patch uses
sdata->settings->wai_addr so I'm assuming that is correct choice here.

Thanks,

Jonathan

> >  		err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
> > -					   sensor_settings[i].wai_addr, &wai);
> > +					   sdata->sensor_settings->wai_addr,
> > +					   &wai);
> >  		if (err < 0) {
> >  			dev_err(&indio_dev->dev,
> >  				"failed to read Who-Am-I register.\n");
> >  			return err;
> >  		}
> >  
> > -		if (sensor_settings[i].wai != wai) {
> > +		if (sdata->sensor_settings->wai != wai) {
> >  			dev_err(&indio_dev->dev,
> >  				"%s: WhoAmI mismatch (0x%x).\n",
> >  				indio_dev->name, wai);
> > @@ -697,12 +666,9 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
> >  		}
> >  	}
> >  
> > -	sdata->sensor_settings =
> > -			(struct st_sensor_settings *)&sensor_settings[i];
> > -
> > -	return i;
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL(st_sensors_check_device_support);
> > +EXPORT_SYMBOL(st_sensors_verify_id);
> >  
> >  ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
> >  				struct device_attribute *attr, char *buf)
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> > index 2213843f02cb..a57cd648975c 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> > @@ -102,9 +102,68 @@ static const struct st_sensor_transfer_function st_sensors_tf_spi = {
> >  	.read_multiple_byte = st_sensors_spi_read_multiple_byte,
> >  };
> >  
> > -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> > -			struct spi_device *spi, struct st_sensor_data *sdata)
> > +/*
> > + * st_sensors_is_spi_3_wire() - check if SPI 3-wire mode has been selected
> > + * @spi: spi device reference.
> > + *
> > + * Return: true if SPI 3-wire mode is selected, false otherwise.
> > + */
> > +static bool st_sensors_is_spi_3_wire(struct spi_device *spi)
> > +{
> > +	struct device_node *np = spi->dev.of_node;
> > +	struct st_sensors_platform_data *pdata;
> > +
> > +	pdata = (struct st_sensors_platform_data *)spi->dev.platform_data;
> > +	if ((np && of_property_read_bool(np, "spi-3wire")) ||
> > +	    (pdata && pdata->spi_3wire)) {
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * st_sensors_configure_spi_3_wire() - configure SPI 3-wire if needed
> > + * @spi: spi device reference.
> > + * @settings: sensor specific settings reference.
> > + *
> > + * Return: 0 on success, else a negative error code.
> > + */
> > +static int st_sensors_configure_spi_3_wire(struct spi_device *spi,
> > +					   struct st_sensor_settings *settings)
> > +{
> > +	if (settings->sim.addr) {
> > +		u8 buffer[] = {
> > +			settings->sim.addr,
> > +			settings->sim.value
> > +		};
> > +
> > +		return spi_write(spi, buffer, 2);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * st_sensors_spi_configure() - configure SPI interface
> > + * @indio_dev: IIO device reference.
> > + * @spi: spi device reference.
> > + *
> > + * Return: 0 on success, else a negative error code.
> > + */
> > +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> > +			     struct spi_device *spi)
> >  {
> > +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> > +	int err;
> > +
> > +	if (st_sensors_is_spi_3_wire(spi)) {
> > +		err = st_sensors_configure_spi_3_wire(spi,
> > +						      sdata->sensor_settings);
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> >  	spi_set_drvdata(spi, indio_dev);
> >  
> >  	indio_dev->dev.parent = &spi->dev;
> > @@ -113,6 +172,8 @@ void st_sensors_spi_configure(struct iio_dev *indio_dev,
> >  	sdata->dev = &spi->dev;
> >  	sdata->tf = &st_sensors_tf_spi;
> >  	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
> > +
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL(st_sensors_spi_configure);
> >  
> > diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> > index 5cc63d41d855..4b87e79aa744 100644
> > --- a/drivers/iio/gyro/st_gyro_core.c
> > +++ b/drivers/iio/gyro/st_gyro_core.c
> > @@ -400,9 +400,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
> >  	if (err)
> >  		return err;
> >  
> > -	err = st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_gyro_sensors_settings),
> > -					st_gyro_sensors_settings);
> > +	err = st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_gyro_power_off;
> >  
> > diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
> > index bb7082055f85..b5c624251231 100644
> > --- a/drivers/iio/gyro/st_gyro_spi.c
> > +++ b/drivers/iio/gyro/st_gyro_spi.c
> > @@ -91,7 +91,9 @@ static int st_gyro_spi_probe(struct spi_device *spi)
> >  	gdata = iio_priv(indio_dev);
> >  	gdata->sensor_settings = (struct st_sensor_settings *)settings;
> >  
> > -	st_sensors_spi_configure(indio_dev, spi, gdata);
> > +	err = st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> >  
> >  	err = st_gyro_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> > index 43a49a52c81a..3f313aefece6 100644
> > --- a/drivers/iio/magnetometer/st_magn_core.c
> > +++ b/drivers/iio/magnetometer/st_magn_core.c
> > @@ -502,9 +502,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
> >  	if (err)
> >  		return err;
> >  
> > -	err = st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_magn_sensors_settings),
> > -					st_magn_sensors_settings);
> > +	err = st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_magn_power_off;
> >  
> > diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> > index a3045afc6b53..fbf909bde841 100644
> > --- a/drivers/iio/magnetometer/st_magn_spi.c
> > +++ b/drivers/iio/magnetometer/st_magn_spi.c
> > @@ -73,7 +73,9 @@ static int st_magn_spi_probe(struct spi_device *spi)
> >  	mdata = iio_priv(indio_dev);
> >  	mdata->sensor_settings = (struct st_sensor_settings *)settings;
> >  
> > -	st_sensors_spi_configure(indio_dev, spi, mdata);
> > +	err = st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> >  
> >  	err = st_magn_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> > index 35d80ff27464..a783fc075c26 100644
> > --- a/drivers/iio/pressure/st_pressure_core.c
> > +++ b/drivers/iio/pressure/st_pressure_core.c
> > @@ -698,9 +698,7 @@ int st_press_common_probe(struct iio_dev *indio_dev)
> >  	if (err)
> >  		return err;
> >  
> > -	err = st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_press_sensors_settings),
> > -					st_press_sensors_settings);
> > +	err = st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_press_power_off;
> >  
> > diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> > index 3e8c1ffe001e..7c8b70221e70 100644
> > --- a/drivers/iio/pressure/st_pressure_spi.c
> > +++ b/drivers/iio/pressure/st_pressure_spi.c
> > @@ -83,7 +83,9 @@ static int st_press_spi_probe(struct spi_device *spi)
> >  	press_data = iio_priv(indio_dev);
> >  	press_data->sensor_settings = (struct st_sensor_settings *)settings;
> >  
> > -	st_sensors_spi_configure(indio_dev, spi, press_data);
> > +	err = st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> >  
> >  	err = st_press_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> > index 17fbf3e9b013..566b955e2980 100644
> > --- a/include/linux/iio/common/st_sensors.h
> > +++ b/include/linux/iio/common/st_sensors.h
> > @@ -338,8 +338,7 @@ int st_sensors_get_settings_index(const char *name,
> >  				  const struct st_sensor_settings *list,
> >  				  const int list_length);
> >  
> > -int st_sensors_check_device_support(struct iio_dev *indio_dev,
> > -	int num_sensors_list, const struct st_sensor_settings *sensor_settings);
> > +int st_sensors_verify_id(struct iio_dev *indio_dev);
> >  
> >  ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
> >  				struct device_attribute *attr, char *buf);
> > diff --git a/include/linux/iio/common/st_sensors_spi.h b/include/linux/iio/common/st_sensors_spi.h
> > index 6020f7167859..90b25f087f06 100644
> > --- a/include/linux/iio/common/st_sensors_spi.h
> > +++ b/include/linux/iio/common/st_sensors_spi.h
> > @@ -13,7 +13,7 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/iio/common/st_sensors.h>
> >  
> > -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> > -			struct spi_device *spi, struct st_sensor_data *sdata);
> > +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> > +			     struct spi_device *spi);
> >  
> >  #endif /* ST_SENSORS_SPI_H */  
> 

