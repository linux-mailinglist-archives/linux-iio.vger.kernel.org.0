Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7479B363499
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhDRK0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 06:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhDRK0b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 06:26:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D2561090;
        Sun, 18 Apr 2021 10:26:00 +0000 (UTC)
Date:   Sun, 18 Apr 2021 11:26:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@deviqon.com, Thomas Deutschmann <whissi@gentoo.org>
Subject: Re: [PATCH] iio: hid-sensors: select IIO_TRIGGERED_BUFFER under
 HID_SENSOR_IIO_TRIGGER
Message-ID: <20210418112632.0eda314c@jic23-huawei>
In-Reply-To: <a42df6ba1c5d87b2094bb133e27f35331a507221.camel@linux.intel.com>
References: <20210414084955.260117-1-aardelean@deviqon.com>
        <a42df6ba1c5d87b2094bb133e27f35331a507221.camel@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Apr 2021 09:58:33 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Wed, 2021-04-14 at 11:49 +0300, Alexandru Ardelean wrote:
> > During commit 067fda1c065ff ("iio: hid-sensors: move triggered buffer
> > setup into hid_sensor_setup_trigger"), the
> > iio_triggered_buffer_{setup,cleanup}() functions got moved under the
> > hid-sensor-trigger module.
> > 
> > The above change works fine, if any of the sensors get built.
> > However, when
> > only the common hid-sensor-trigger module gets built (and none of the
> > drivers), then the IIO_TRIGGERED_BUFFER symbol isn't
> > selected/enforced.
> > 
> > Previously, each driver would enforce/select the IIO_TRIGGERED_BUFFER
> > symbol. With this change the HID_SENSOR_IIO_TRIGGER (for the
> > hid-sensor-trigger module) will enforce that IIO_TRIGGERED_BUFFER
> > gets
> > selected.
> > 
> > All HID sensor drivers select the HID_SENSOR_IIO_TRIGGER symbol. So,
> > this
> > change removes the IIO_TRIGGERED_BUFFER enforcement from each driver.
> > 
> > Fixes: 067fda1c065ff ("iio: hid-sensors: move triggered buffer setup
> > into hid_sensor_setup_trigger")
> > Reported-by: Thomas Deutschmann <whissi@gentoo.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>  
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git.

Always good to see the autobuilders can find corners no one sane would ever
hit :)

Jonathan

> 
> > ---
> >  drivers/iio/accel/Kconfig              | 1 -
> >  drivers/iio/common/hid-sensors/Kconfig | 1 +
> >  drivers/iio/gyro/Kconfig               | 1 -
> >  drivers/iio/humidity/Kconfig           | 1 -
> >  drivers/iio/light/Kconfig              | 2 --
> >  drivers/iio/magnetometer/Kconfig       | 1 -
> >  drivers/iio/orientation/Kconfig        | 2 --
> >  drivers/iio/pressure/Kconfig           | 1 -
> >  drivers/iio/temperature/Kconfig        | 1 -
> >  9 files changed, 1 insertion(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index cceda3cecbcf..8b1723635cce 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -229,7 +229,6 @@ config DMARD10
> >  config HID_SENSOR_ACCEL_3D
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID Accelerometers 3D"
> > diff --git a/drivers/iio/common/hid-sensors/Kconfig
> > b/drivers/iio/common/hid-sensors/Kconfig
> > index 24d492567336..2a3dd3b907be 100644
> > --- a/drivers/iio/common/hid-sensors/Kconfig
> > +++ b/drivers/iio/common/hid-sensors/Kconfig
> > @@ -19,6 +19,7 @@ config HID_SENSOR_IIO_TRIGGER
> >  	tristate "Common module (trigger) for all HID Sensor IIO
> > drivers"
> >  	depends on HID_SENSOR_HUB && HID_SENSOR_IIO_COMMON &&
> > IIO_BUFFER
> >  	select IIO_TRIGGER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to build trigger support for HID sensors.
> >  	  Triggers will be send if all requested attributes were read.
> > diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> > index 5824f2edf975..20b5ac7ab66a 100644
> > --- a/drivers/iio/gyro/Kconfig
> > +++ b/drivers/iio/gyro/Kconfig
> > @@ -111,7 +111,6 @@ config FXAS21002C_SPI
> >  config HID_SENSOR_GYRO_3D
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID Gyroscope 3D"
> > diff --git a/drivers/iio/humidity/Kconfig
> > b/drivers/iio/humidity/Kconfig
> > index 6549fcf6db69..2de5494e7c22 100644
> > --- a/drivers/iio/humidity/Kconfig
> > +++ b/drivers/iio/humidity/Kconfig
> > @@ -52,7 +52,6 @@ config HID_SENSOR_HUMIDITY
> >  	tristate "HID Environmental humidity sensor"
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	help
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 33ad4dd0b5c7..917f9becf9c7 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -256,7 +256,6 @@ config ISL29125
> >  config HID_SENSOR_ALS
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID ALS"
> > @@ -270,7 +269,6 @@ config HID_SENSOR_ALS
> >  config HID_SENSOR_PROX
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID PROX"
> > diff --git a/drivers/iio/magnetometer/Kconfig
> > b/drivers/iio/magnetometer/Kconfig
> > index 5d4ffd66032e..74ad5701c6c2 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -95,7 +95,6 @@ config MAG3110
> >  config HID_SENSOR_MAGNETOMETER_3D
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID Magenetometer 3D"
> > diff --git a/drivers/iio/orientation/Kconfig
> > b/drivers/iio/orientation/Kconfig
> > index a505583cc2fd..396cbbb867f4 100644
> > --- a/drivers/iio/orientation/Kconfig
> > +++ b/drivers/iio/orientation/Kconfig
> > @@ -9,7 +9,6 @@ menu "Inclinometer sensors"
> >  config HID_SENSOR_INCLINOMETER_3D
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID Inclinometer 3D"
> > @@ -20,7 +19,6 @@ config HID_SENSOR_INCLINOMETER_3D
> >  config HID_SENSOR_DEVICE_ROTATION
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID Device Rotation"
> > diff --git a/drivers/iio/pressure/Kconfig
> > b/drivers/iio/pressure/Kconfig
> > index 689b978db4f9..fc0d3cfca418 100644
> > --- a/drivers/iio/pressure/Kconfig
> > +++ b/drivers/iio/pressure/Kconfig
> > @@ -79,7 +79,6 @@ config DPS310
> >  config HID_SENSOR_PRESS
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	tristate "HID PRESS"
> > diff --git a/drivers/iio/temperature/Kconfig
> > b/drivers/iio/temperature/Kconfig
> > index c5482983f568..f20ae3c963cb 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -45,7 +45,6 @@ config HID_SENSOR_TEMP
> >  	tristate "HID Environmental temperature sensor"
> >  	depends on HID_SENSOR_HUB
> >  	select IIO_BUFFER
> > -	select IIO_TRIGGERED_BUFFER
> >  	select HID_SENSOR_IIO_COMMON
> >  	select HID_SENSOR_IIO_TRIGGER
> >  	help  
> 

