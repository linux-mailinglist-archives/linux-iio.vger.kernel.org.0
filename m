Return-Path: <linux-iio+bounces-25031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD40BD3B91
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 16:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601194F5B40
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F4309F12;
	Mon, 13 Oct 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="SQiWrv33"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99828D83E
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366797; cv=none; b=fbky5kEKX/GZnj3MUN/y5SPfIKt+Ul/WExHD9y6x/F8sSAGCV43T94Ooo372cDJEmBz5prid1+8cU1FJbln1rE7ZA8bf/MIylr1lqG6Tmlr9RYw89Oq1gC4wUAgr0m4q604TC+91g2vKHYnZ3YZN2V2wkjqF760x2YDdpo16P+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366797; c=relaxed/simple;
	bh=i0caL2/K0vfgpmRIPc4Twix71y134aBoZmXSlgChjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jefMjdd+/1nyGH13vIOsVcAZO6Y30ESKGZoizxuIlz+nTxYytwx64BZZTq1gDC0KAabgP6RtQyHOCFSnltRbsfCDAaryyIYJMNGXJePQHn2fpdj6nCxulMfP/nhPE9yL8pjUhgiMPrhlwnurycnwBJmZLIMrKRxgoPPFiDWVB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=SQiWrv33; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 45A61104CBC9
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 20:16:23 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 45A61104CBC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1760366783; bh=i0caL2/K0vfgpmRIPc4Twix71y134aBoZmXSlgChjMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQiWrv33vbQsEAyNyoD3Z6avy8+liHJmj2aUoMMehy3tsp56yK0wfggvkunZvvjcf
	 O4gmngaJm3QjxU/LpiBwAjk00I8spg+hj6NufdVHl9ygjzTj4inBygeEiBUUhtN091
	 OR7EkOq6D8vImZvgMCk1rmEdMR17SLtsyFHRhij0=
Received: (qmail 21217 invoked by uid 510); 13 Oct 2025 20:16:23 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.373675 secs; 13 Oct 2025 20:16:23 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 13 Oct 2025 20:16:20 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id CE417360077;
	Mon, 13 Oct 2025 20:16:19 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 8A51E1E81578;
	Mon, 13 Oct 2025 20:16:19 +0530 (IST)
Date: Mon, 13 Oct 2025 20:16:14 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 2/2] iio: pressure: adp810: Add driver for adp810 sensor
Message-ID: <20251013-144614-1551316@bhairav-test.ee.iitb.ac.in>
References: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
 <8c202e7ccd332b26217d529a7a73b7a3ef0726ea.1760184859.git.akhilesh@ee.iitb.ac.in>
 <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdGJfMALGOFvkOW=JZ0yHE2QbRSzNs2Xd42-Weec1GmQw@mail.gmail.com>

On Sat, Oct 11, 2025 at 05:10:58PM +0300, Andy Shevchenko wrote:

Hi Andy,
Thank you for your time and valuable feedback.
Addressed all of them with best of my understanding.
Kindly check my comments on "regmap usage" and "__packed" usage
decisions below.

Sharing v2 of the series with these improvements and fixes.

Regards,
Akhilesh

> On Sat, Oct 11, 2025 at 3:25 PM Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:
> >
> > Add driver for Aosong adp810 differential pressure and
> > temperature sensor. This sensor provides I2C interface for
> 
> an I²C

Fixed.

> 
> > reading data. Calculate CRC of the data received using standard
> > crc8 library to verify data integrity.
> >
> > Tested on TI am62x sk board with sensor connected at i2c-2
> 
> Missing period at the end.

Fixed.

> 
> ...
> 
> > +AOSONG ADP810 DIFFERENTIAL PRESSURE SENSOR DRIVER
> > +M:     Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > +L:     linux-iio@vger.kernel.org
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
> > +F:     drivers/iio/pressure/adp810.c
> 
> Some tools will report an orphaned yaml file if you apply patch 1
> without patch 2.

ACK. checkpatch.pl did show me the warning.

> 
> ...
> 
> > +config ADP810
> > +       tristate "Aosong adp810 differential pressure and temperature sensor"
> > +       depends on I2C
> > +       select CRC8
> > +       help
> > +         Say yes here to build adp810 differential pressure and temperature
> > +         sensor driver. ADP810 can measure pressure range up to 500Pa.
> > +         It supports I2C interface for data communication.
> 
> Same as in the commit message.

Fixed grammer and missing article.

> 
> > +         To compile this driver as a module, choose M here: the module will
> > +         be called adp810
> 
> ...
> 
> >  obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> >  obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> > +obj-$(CONFIG_ADP810) += adp810.o
> 
> Is Makefile ordered in terms of files and/or configuration options?

Sure. Added adp810 at alphabetically correct place.
While at it, I also corrected order of few other enteries.

> 
> 
> > +#include <linux/module.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/crc8.h>
> 
> Please,
> 1) keep it alphabetically ordered;
> 2) follow the IWYU (Include What You Use) principle.

Sure. Fixed it.

> 
> ...
> 
> > +/* Time taken in ms by sensor to do measurements after triggering.
> 
> /*
>  * Wrong multi-line comment format. You
>  * may use this as a reference.
>  */
> 

Fixed multiline comment format.

> > + * As per datahseet, 10ms is sufficient but we define 30 for better margin
> 
> datasheet
> 
> Please, respect grammar and punctuation, i.e. again as in the commit
> message you made a mistake.

Fixed.

> 
> ...
> 
> > +#define ADP810_MEASURE_LATENCY         30
> 
> What's the unit of this value?

It is milliseconds.
Redefined this macro as ADP810_MEASURE_LATENCY_MS for better clarity.

> 
> ...
> 
> This needs a comment to explain the choice of this. E.g., reference to
> the Datasheet section / chapter.
> 
> > +#define ADP810_CRC8_POLYNOMIAL         0x31

Added reference to the section from datasheet with small explanation.

> 
> ...
> 
> > +struct adp810_read_buf {
> > +       u8 dp_msb;
> > +       u8 dp_lsb;
> > +       u8 dp_crc;
> > +       u8 tmp_msb;
> > +       u8 tmp_lsb;
> > +       u8 tmp_crc;
> > +       u8 sf_msb;
> > +       u8 sf_lsb;
> > +       u8 sf_crc;
> > +} __packed;
> 
> Why __packed?

Yes. This is the structure used as a buffer to store sensor values read.
Each entry in this structure should be contiguous in the memory because
reference of this structure will be passed to i2c_master_recv() to
receive and fill the data.
__packed will avoid any compiler generated paddings in the structure to
force alignments on certain architectures. We do not want these paddings
and want our struct members to be sequentially ordered as shown, with
no padding and size of the struct should also be 9 bytes as only 9 bytes of
data should be read from the sensor as per the specification.

I could have used array here. But I preferred strcture for better
readability of the code as one can easily see what values are expected
from sensor while reading and in which order.

> 
> ...
> 
> > +struct adp810_data {
> > +       struct i2c_client *client;
> > +       /* Use lock to synchronize access to device during read sequence */
> > +       struct mutex lock;
> > +};
> 
> Is there a deliberate choice to not use regmap I²C APIs?

Yes. I explored that possibility. However this sensor follows simple I2C
client protocol. It does not expose the concept of I2C registers. It
does not follow smbus. Specifically, while reading the measurement from
the sensor, we need to only send the device address with read bit on the bus,
and start reading 9 bytes following that. That is, no register address
should be sent. I am not sure if regmap API has some hack to achive
similar because these APIs expect register addresses to read/write which
this sensor does not follow. Hence using raw i2c functions. I also
thought regmap abstraction is not needed here as this sensor has very
limited commands to send and not many command/configurations.

> 
> ...
> 
> > +       /* Wait for sensor to aquire data */
> 
> Spell-check. Also the comment is semi-useless, add the reference to
> the datasheet or even cite a part of it to explain this.

Sure.

> 
> > +       msleep(ADP810_MEASURE_LATENCY);
> 
> ...
> 
> > +       mutex_lock(&data->lock);
> > +       ret = adp810_measure(data, &buf);
> > +       mutex_unlock(&data->lock);
> > +
> > +       if (ret) {
> > +               dev_err(&indio_dev->dev, "Failed to read from device\n");
> > +               return ret;
> > +       }
> 
> Instead, include cleanup,h and use scoped_guard() (and possible
> guard()() in some other places, but first answer why not regmap).

ACK. Used scoped_guard() to cleanly handle resource locks here.

> 
> ...
> 
> > +       case IIO_CHAN_INFO_RAW:
> > +               switch (chan->type) {
> > +               case IIO_PRESSURE:
> > +                       *val = buf.dp_msb << 8 | buf.dp_lsb;
> 
> Those have to be properly defined to begin with, i.e. __be16. With
> that done, use existing conversion helpers from asm/byteorder.h.
> 
> > +                       return IIO_VAL_INT;
> > +               case IIO_TEMP:
> > +                       *val = buf.tmp_msb << 8 | buf.tmp_lsb;
> 
> Ditto and so on...
> 
> > +                       return IIO_VAL_INT;
> > +               default:
> > +                       return -EINVAL;
> > +               }

Agree. We should use standard helpers.
Used be16 along with get_unalinged_be16() to improve this part.

> 
> ...
> 
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return -EINVAL;
> 
> Why is dead code required?

Removed dead code.

> 
> ...
> 
> > +       mutex_init(&data->lock);
> 
> devm

Nice catch.
Fixed this resource leak which can happen upon module unload.
As I do not have .remove callback with distroy mutex in it,
yes this is needed.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Regards,
Akhilesh



