Return-Path: <linux-iio+bounces-25432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B38C08B69
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 07:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067E23A3D63
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 05:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC79299931;
	Sat, 25 Oct 2025 05:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="Tn7ohEY8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9F13B7A3
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370129; cv=none; b=QB3E7fHeCuiGyA8yco7gde4O3nH6zLz+Jn0xzsvOBd1gSP5DaROoCK/0hAlviCG9fuht4AqY2Feo3o4V7IfS49I/upAcSppw51rZ7LuefwXUmvmtaAz9SpGKSjaRMbfk03F6lQVG4LCUqyLwdX4LBv9bsddhm75EhuU49GmWk0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370129; c=relaxed/simple;
	bh=mshvFX8gTeHIgfSuCoYm6LRMqPkh1qpwHbgc7/LRtFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVk6gUeqbJ576rqs3GGASdlRbVaM86tTmKKQCMjO4g4XDz6A1EPmvxcMVC2DDchF3DgVHyuEm1/vrRS/v56qoOXXi5O/XxljjgL6RNaAYsYDseq9lPKvixdD7ms5u5IxQe/ZBuVl3VyRWmAi24m/SfW6Ve4tC/tQ/wCd9MhFdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=Tn7ohEY8; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 2B5AA104CBA7
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 10:58:41 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 2B5AA104CBA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761370121; bh=mshvFX8gTeHIgfSuCoYm6LRMqPkh1qpwHbgc7/LRtFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tn7ohEY8ikVyQrM5Z3PZK5LMn7xqN0e86MGhetZ+fZVpq5JWf59QZehnFWLz/arHe
	 WR85QqA9SXTF/y7TuDJcFhJERLJ/S8heIuIzRpRt/qWyxvPjMPyUQuxQTnOTOk8DDA
	 CTNuOmnR6n/CweqFEXmy0EwaxHsL77Et3bQDupW4=
Received: (qmail 14553 invoked by uid 510); 25 Oct 2025 10:58:41 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.652822 secs; 25 Oct 2025 10:58:41 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 25 Oct 2025 10:58:36 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 9D6B73414E9;
	Sat, 25 Oct 2025 10:58:35 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 5A3261E815D1;
	Sat, 25 Oct 2025 10:58:35 +0530 (IST)
Date: Sat, 25 Oct 2025 10:58:30 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v3 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251025-52830-939994@bhairav-test.ee.iitb.ac.in>
References: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
 <5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
 <aPek1GqhhyOWFfLG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPek1GqhhyOWFfLG@smile.fi.intel.com>

On Tue, Oct 21, 2025 at 06:20:52PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 21, 2025 at 11:20:30AM +0530, Akhilesh Patil wrote:
> > Add driver for Aosong adp810 differential pressure and temperature sensor.
> > This sensor provides an I2C interface for reading data.
> > Calculate CRC of the data received using standard crc8 library to verify
> > data integrity.
> 
> Thanks for an update! Looks almost good to me, some comments below.

Thanks for the below comments and suggestions.
Addressed them in v4.

Regards,
Akhilesh

> 
> ...
> 
> > +M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> 
> Putting it here makes checkpatch unhappy. If someone thinks that is a false
> positive of the tool, perhaps one needs to fix that.

This is being followed up in v1 thread.
https://lore.kernel.org/lkml/aPs6raLIcM3QbQXJ@smile.fi.intel.com/

> 
> > +F:	drivers/iio/pressure/adp810.c
> 
> ...
> 
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
> >  obj-$(CONFIG_ZPA2326) += zpa2326.o
> >  obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
> >  obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
> > -
> > -obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> > -obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> 
> I would split order fix into a separate change, but if maintainers are okay
> with this approach, I would not object.

Okay. Adding only adp810.o here. Will revert all other entries.
This will make this change logically connected to this series.

> 
> ...
> 
> > +#include <linux/cleanup.h>
> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/mutex.h>
> > +#include <linux/unaligned.h>
> 
> Something is still missing.

Added more include files as pointed out further below.

> 
> ...
> 
> > +struct adp810_read_buf {
> > +	__be16 dp;
> > +	u8 dp_crc;
> > +	__be16 tmp;
> > +	u8 tmp_crc;
> > +	__be16 sf;
> > +	u8 sf_crc;
> 
> All these types are provided in types.h

ACK. Added linux/types.h

> 
> > +} __packed;
> 
> ...
> 
> > +static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	struct device *dev = &client->dev;
> > +	int ret;
> > +	u16 trig_cmd = ADP810_TRIGGER_COMMAND;
> 
> Shouldn't this be __be16 or __le16? Or is that really a full 16-bit command?
> I have a gut feeling that this should be u8 x[2] = { ... }; instead.

Ohh yes. Nice catch !
This is 16 bit trigger command. We need to send 0x37 then 0x2d.
I defined trig_cmd = 0x2d37 which will work fine on little endian
systems, but will fail on big endian systems I think.
I use ARM v8-A configured in little endian, so did not catch this.
Let me use u8 trig_cmd[2] = {0x37, 0x2d} to make this architecture
agnostic.

> 
> > +	/* Send trigger to the sensor for measurement */
> > +	ret = i2c_master_send(client, (char *)&trig_cmd, sizeof(trig_cmd));
> > +	if (ret < 0) {
> > +		dev_err(dev, "Error sending trigger command\n");
> > +		return ret;
> > +	}
> > +	if (ret != sizeof(trig_cmd))
> > +		return -EIO;
> 
> -EIO is defined down from linux/errno.h.

ACK. Added linux/errno.h

> 
> > +	/*
> > +	 * Wait for the sensor to acquire data. As per datasheet section 5.3.1,
> > +	 * wait for at least 10ms before reading measurements from the sensor.
> > +	 */
> > +	msleep(ADP810_MEASURE_LATENCY_MS);
> > +
> > +	/* Read sensor values */
> > +	ret = i2c_master_recv(client, (char *)buf, sizeof(*buf));
> > +	if (ret < 0) {
> > +		dev_err(dev, "Error reading from sensor\n");
> > +		return ret;
> > +	}
> > +	if (ret != sizeof(*buf))
> > +		return -EIO;
> > +
> > +
> > +	if (buf->sf_crc != crc8(crc_table, (u8 *)&buf->sf, 0x2, CRC8_INIT_VALUE)) {
> > +		dev_err(dev, "CRC error for scale\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +	indio_dev->num_channels = ARRAY_SIZE(adp810_channels);
> 
> ARRAY_SIZE() is defined in a specific header.

ACK. Added linux/array_size.h

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

