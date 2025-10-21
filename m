Return-Path: <linux-iio+bounces-25302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 414ABBF4AB0
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 07:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6C904E5C07
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 05:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001325A2BB;
	Tue, 21 Oct 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="o4DJZCgX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDD222564
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761025893; cv=none; b=fYZSFVNjpO9CRaCm64SOGjufzDFNeB8+oMWZFqpU5Eh/92/NxT5oDsRa7YnBHQepFRJivnLTMopge2Bs/xKeKl91V3Wt+hS3b+gNt33v/SSjAp6Vu6x1kiEz4aZuKH4O9dtbsRjB2uu9T75vyBObpvqL3Wp/hqt3RM2ZcXg5+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761025893; c=relaxed/simple;
	bh=ZIEtBExJkOm/Si6gWrjEFano0vuqhBJRpgdw3kmE10c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuG8MTqgeTnTXKxFqBXRGxijokvLjhJ2xH7wPp8z1tTpIhOZWLG2OWFN8G07i8cug+l254um1ZG3h+QnPYJdCO+X3NZW/YA0btoS22DtvPJ0UewaP2FGuF4sJRmY8nhIpTh8qhO9fIq2cnbHjnbbb1s24AmPJ9S1w/D0CcB7pZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=o4DJZCgX; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 1F1EB100905F
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 11:15:52 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 1F1EB100905F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761025552; bh=ZIEtBExJkOm/Si6gWrjEFano0vuqhBJRpgdw3kmE10c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4DJZCgXHp/LsHPqB0PPQMQq2OCJkSMj1QdsoDiWqqInYNUuogDChoDqujIyRdDg7
	 pgqOxFyonY1D8ykxSzG4uuGw+D7EPnwvLKlc2UDz0AiYWVFtqJFg7GEuaA8Y8Q3ahH
	 UTd5EdmwFvr9wNZt2eYT1gjeTVL0WhvvYQDQazY0=
Received: (qmail 22433 invoked by uid 510); 21 Oct 2025 11:15:52 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.503469 secs; 21 Oct 2025 11:15:52 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 21 Oct 2025 11:15:48 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 9549736008E;
	Tue, 21 Oct 2025 11:15:47 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 7B7731E81391;
	Tue, 21 Oct 2025 11:15:47 +0530 (IST)
Date: Tue, 21 Oct 2025 11:15:42 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v2 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251021-54542-354166@bhairav-test.ee.iitb.ac.in>
References: <cover.1760374257.git.akhilesh@ee.iitb.ac.in>
 <0b72866f4e5ac28c78f6d683a1ca659a4239b68e.1760374257.git.akhilesh@ee.iitb.ac.in>
 <20251018174746.4a76af1d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018174746.4a76af1d@jic23-huawei>

On Sat, Oct 18, 2025 at 05:47:46PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Oct 2025 22:32:35 +0530
> Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> 
> > Add driver for Aosong adp810 differential pressure and temperature sensor.
> > This sensor provides an I2C interface for reading data.
> > Calculate CRC of the data received using standard crc8 library to verify
> > data integrity.
> > 
> > Tested on TI am62x sk board with sensor connected at i2c-2.
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> 
> A few comments inline and it seems your rebase when wrong and you've
> picked up unrelated build file changes.
> 
> Thanks
> 
> Jonathan

Hi Jonathan, Thanks for the review, I will share v3 addressing these comments.

Regards,
Akhilesh

> 
> > diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> > index 6482288e07ee..a21443e992b9 100644
> > --- a/drivers/iio/pressure/Makefile
> > +++ b/drivers/iio/pressure/Makefile
> > @@ -5,6 +5,7 @@
> >  
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_ABP060MG) += abp060mg.o
> > +obj-$(CONFIG_ADP810) += adp810.o
> >  obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
> >  obj-$(CONFIG_BMP280) += bmp280.o
> >  bmp280-objs := bmp280-core.o bmp280-regmap.o
> > @@ -15,6 +16,7 @@ obj-$(CONFIG_DPS310) += dps310.o
> >  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
> >  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
> >  obj-$(CONFIG_HP03) += hp03.o
> > +obj-$(CONFIG_HP206C) += hp206c.o
> >  obj-$(CONFIG_HSC030PA) += hsc030pa.o
> >  obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
> >  obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
> > @@ -34,11 +36,9 @@ obj-$(CONFIG_SDP500) += sdp500.o
> >  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
> >  st_pressure-y := st_pressure_core.o
> >  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> > +obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> > +obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> >  obj-$(CONFIG_T5403) += t5403.o
> > -obj-$(CONFIG_HP206C) += hp206c.o
> 
> Rebase gone wrong I assume.  

These are intentional changes.

This addresses Andy's suggestion in v1, to keep entries alphabetically
arranged in Makefile. Along with adp810 location, fixed other files as well
hp206 and st_pressure_* to make entries alphabetically arranged in
the entire Makefile.

> 
> >  obj-$(CONFIG_ZPA2326) += zpa2326.o
> >  obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
> >  obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
> > -
> > -obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> > -obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> > diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> > new file mode 100644
> > index 000000000000..c2f3b5f7a1f9
> > --- /dev/null
> > +++ b/drivers/iio/pressure/adp810.c
> > @@ -0,0 +1,212 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2025 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > + *
> > + * Driver for adp810 pressure and temperature sensor
> > + * Datasheet:
> > + *   https://aosong.com/userfiles/files/media/Datasheet%20ADP810-Digital.pdf
> > + */
> > +
> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/unaligned.h>
> This is a very small set of includes.  Please follow include what you use (IWYU)
> principles (loosely - there are a few headers that never make sense to include
> directly).  So I'd definitely expect things like mutex.h here.
> dev_printk.h etc.

ACK.
Added mutex.h, dev_printk.h along with other includes - cleanup.h,
device.h, iio/types.h, mod_devicetable.h to follow IWYU.

> 
> > +
> > +#include <linux/iio/iio.h>
> 
> > +
> > +static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	struct device *dev = &client->dev;
> > +	int ret;
> > +	u16 trig_cmd = ADP810_TRIGGER_COMMAND;
> > +
> > +	/* Send trigger to the sensor for measurement */
> > +	ret = i2c_master_send(client, (char *)&trig_cmd, sizeof(u16));
> 
> sizeof(trig_cmd)
> 
> I think it is vanishingly unlikely to matter but in theory i2c_master_send()
> could return 1 and only one byte made it to device.
> So it's common to have 
> 	if (ret < 0)...
> 		....
> 	if (ret != sizeof(trig_cmd))
> 		....
> 

Agree. This is a good corner case. Handled as per the suggestion above.

> > +	if (ret < 0) {
> > +		dev_err(dev, "Error sending trigger command\n");
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Wait for the sensor to acquire data. As per datasheet section 5.3.1,
> > +	 * wait for at least 10ms before reading measurements from the sensor.
> > +	 */
> > +	msleep(ADP810_MEASURE_LATENCY_MS);
> > +
> > +	/* Read sensor values */
> > +	ret = i2c_master_recv(client, (char *)buf, sizeof(*buf));
> > +	if (ret < 0) {
> 
> Same potential issue for short reads as for the write above.
> 
> I don't recall seeing anything to say we either got full length or
> error code but maybe that changed at somepoint to make this interface easier to use.

ACK. Did similar implementation as _send() for error handling.

> 
> 
> > +		dev_err(dev, "Error reading from sensor\n");
> > +		return ret;
> > +	}
> > +
> > +	/* CRC checks */
> > +	crc8_populate_msb(crc_table, ADP810_CRC8_POLYNOMIAL);
> > +	if (buf->dp_crc != crc8(crc_table, (u8 *)&buf->dp, 0x2, CRC8_INIT_VALUE)) {
> > +		dev_err(dev, "CRC error for pressure\n");
> > +		return -EIO;
> > +	}
> > +
> > +	if (buf->tmp_crc != crc8(crc_table, (u8 *)&buf->tmp, 0x2, CRC8_INIT_VALUE)) {
> > +		dev_err(dev, "CRC error for temperature\n");
> > +		return -EIO;
> > +	}
> > +
> > +	if (buf->sf_crc != crc8(crc_table, (u8 *)&buf->sf, 0x2, CRC8_INIT_VALUE)) {
> > +		dev_err(dev, "CRC error for scale\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp810_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct adp810_data *data = iio_priv(indio_dev);
> > +	struct device *dev = &data->client->dev;
> > +	struct adp810_read_buf buf = {0};
> 
> Not a big thing but slight preference for { }.

Sure. Will use { } insteaed of {0}.

> It's a messy thing wrt to the c spec which never talked about holes
> and this construct until recently.  However the kernel has build tests
> that verify that all compilers will zero the holes with the { }
> syntax and that is what the C standards folk have put in the spec now
> as meaning whole structure including holes.

Good to know the background of this. Thanks.

> 
> > +	int ret;
> > +
> > +	scoped_guard(mutex, &data->lock) {
> > +		ret = adp810_measure(data, &buf);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to read from device\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	switch (mask) {
> 

