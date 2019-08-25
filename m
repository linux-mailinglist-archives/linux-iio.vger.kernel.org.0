Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6679C528
	for <lists+linux-iio@lfdr.de>; Sun, 25 Aug 2019 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfHYRe3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Aug 2019 13:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbfHYRe3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Aug 2019 13:34:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B05F1206E0;
        Sun, 25 Aug 2019 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754468;
        bh=WO+3ENPxcm8UpJ/ITlfunHNEAzG0dL5yYF8f/ynsdP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1TVk4S8nmiYDkVK20XGpX/mgNlXNy0RtLWxX5VyNnpv4NLtK35HwK5Yr4X/tNa36j
         Ne6O1f6aCKaL28zR2TDx4qWYzJi0WYDr5P9msMfkajX9acFC2Dgy6HBhPNu8sKzOD9
         1esjhbajEhLqT4W8UnMNWt4Rt2XNcgLxetTUF/EY=
Date:   Sun, 25 Aug 2019 18:34:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
Message-ID: <20190825183422.2ae51895@archlinux>
In-Reply-To: <20190821090858.GC13516@localhost.localdomain>
References: <20190813073533.8007-1-martin.kepplinger@puri.sm>
        <20190813073533.8007-3-martin.kepplinger@puri.sm>
        <20190819094845.GB17835@localhost.localdomain>
        <6c739681-d46e-b4f7-9831-bdf1e9bcd540@puri.sm>
        <20190821090858.GC13516@localhost.localdomain>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 11:08:58 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > >> The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (separately
> > >> supported in iio/magnetometer/st_magn*) are located on a separate i2c addresses
> > >> on the bus.
> > >>
> > >> For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9ds1.pdf
> > >>
> > >> Treat it just like the LSM6* devices and, despite it's name, hook it up
> > >> to the st_lsm6dsx driver, using it's basic functionality.
> > >>
> > >> accelerometer and gyroscope are not independently clocked. It runs at the gyro
> > >> frequencies if both are enabled, see chapter 7.12 of the datasheet.
> > >> We could have handled this as a single IIO device but we have split
> > >> it up to be more consistent with the other more flexible devices.
> > >>
> > >> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>  
> > > 
> > > Hi Martin,
> > > 
> > > most of comments are nitpicks (inline), the only issue I can see here is we can enable
> > > hw fifo for lsm6ds0/lsm9ds1 and read_fifo routine pointer is not currently
> > > initialized so we will end up with a NULL pointer dereference. Since we will
> > > need a different update FIFO routine for lsm6ds0/lsm9ds1 I am adding an
> > > update_fifo function pointer in fifo_ops in order to fix this issue.
> > > 
> > > Regards,
> > > Lorenzo
> > >   
> > >> ---  
> 
> [...]
> 
> > > 
> > > should be called 'lsm9ds1_imu' since lsm9ds1 is a 9-axis device? what do you
> > > think?
> > >   
> > >>  
> > >>  enum st_lsm6dsx_hw_id {
> > >>  	ST_LSM6DS3_ID,
> > >> @@ -37,6 +38,7 @@ enum st_lsm6dsx_hw_id {
> > >>  	ST_LSM6DSR_ID,
> > >>  	ST_LSM6DS3TRC_ID,
> > >>  	ST_ISM330DHCX_ID,
> > >> +	ST_LSM9DS1_ID,  
> > > 
> > > same here..ST_LSM9DS1_IMU_ID  
> > 
> > I wouldn't add "imu" to the actual part name, see below...
> >   
> > >   
> > >>  	ST_LSM6DSX_MAX_ID,
> > >>  };
> > >>    
> 
> [...]
> 
> > >> +};
> > >> +  
> > > 
> > > why not st_lsm6ds0_gyro_channels?  
> > 
> > Would be ok with me. I'll remember this if I do a new iteration.
> >   
> > >   
> 
> [...]
> 
> > >> index 15c6aa5b6caa..2f1b30ff083b 100644
> > >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > >> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
> > >>  		.compatible = "st,ism330dhcx",
> > >>  		.data = (void *)ST_ISM330DHCX_ID,
> > >>  	},
> > >> +	{
> > >> +		.compatible = "st,lsm9ds1",  
> > > 
> > > same here, what is the right compatible string? "st,lsm9ds1 or
> > > "st,lsm9ds1_imu"?  
> > 
> > well, I'm open for this change, but "imu" doesn't really mean much
> > technically, so I would stick with the device name. "imu" is not part of
> > the "part" name...
> >   
> 
> I have not a strong opinion on it but IMU means 'Inertial Measurement Unit' and
> it used to indicate a device that runs a combination of accelerometer and
> gyroscope. I think using LSM9DS1 as device name it is weird since I would
> expect even the magn in this case (all supported devices by st_lsm6dsx are just
> IMU). I am not sure if "st,lsm9ds1_imu" is the right compatible string but I
> would indicate this node does not run a magn device.
> 
> @Jonathan: what do you think?

Hmm. Not totally obvious what to do here.  We need a name that makes it
clear this only supports part of the device.  IMU gets used for cases
including the magnetometer by some manufacturers, so not ideal, but
perhaps it's the best we can do.

Jonathan

> 
> Regards,
> Lorenzo
> 
> > >   
> > >> +		.data = (void *)ST_LSM9DS1_ID,
> > >> +	},
> > >>  	{},
> > >>  };
> > >>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> > >> @@ -99,6 +103,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
> > >>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> > >>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> > >>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> > >> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
> > >>  	{},
> > >>  };
> > >>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> > >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > >> index a8430ee11310..421ce704f346 100644
> > >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > >> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
> > >>  		.compatible = "st,ism330dhcx",
> > >>  		.data = (void *)ST_ISM330DHCX_ID,
> > >>  	},
> > >> +	{
> > >> +		.compatible = "st,lsm9ds1",
> > >> +		.data = (void *)ST_LSM9DS1_ID,
> > >> +	},
> > >>  	{},
> > >>  };
> > >>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> > >> @@ -99,6 +103,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
> > >>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> > >>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> > >>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> > >> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
> > >>  	{},
> > >>  };
> > >>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
> > >> -- 
> > >> 2.20.1
> > >>  
> >   

