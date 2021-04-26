Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7AE36B166
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 12:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhDZKPC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 06:15:02 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:38363 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232173AbhDZKPB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Apr 2021 06:15:01 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.20.143])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id DDA44A25FE9F;
        Mon, 26 Apr 2021 12:14:18 +0200 (CEST)
Received: from localhost (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Apr
 2021 12:14:18 +0200
Date:   Mon, 26 Apr 2021 12:10:13 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jic23@kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] iio: sps30: separate core and interface specific code
Message-ID: <YIaRhdyy79/KyIV+@arch>
References: <20210425135546.57343-1-tomasz.duszynski@octakon.com>
 <20210425135546.57343-2-tomasz.duszynski@octakon.com>
 <38d5438d-7e00-ed5d-ed33-01ff04e26f33@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <38d5438d-7e00-ed5d-ed33-01ff04e26f33@metafoo.de>
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG4EX1.emp2.local (172.16.2.31) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 10555030155743353940
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddukedgvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtheevtefhffduteejfedtkeeuheejgeejvdetfffgveekffefgeffueeghefgjeenucfkpheptddrtddrtddrtddpkeelrdejtddrvddvuddrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 25, 2021 at 05:16:14PM +0200, Lars-Peter Clausen wrote:
> On 4/25/21 3:55 PM, Tomasz Duszynski wrote:
> > Move code responsible for handling i2c communication to a separate file.
> > Rationale for this change is preparation for adding support for serial
> > communication.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
>
> Hi,
>
> The whole series looks really great. Couple of small comments inline.
>
> > [...]
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index 10bb431bc3ce..82af5f62fbc6 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -133,8 +133,6 @@ config SENSIRION_SGP30
> >   config SPS30
> >   	tristate "SPS30 particulate matter sensor"
> > -	depends on I2C
> > -	select CRC8
> >   	select IIO_BUFFER
> >   	select IIO_TRIGGERED_BUFFER
> >   	help
> > @@ -144,6 +142,17 @@ config SPS30
> >   	  To compile this driver as a module, choose M here: the module will
> >   	  be called sps30.
> > +config SPS30_I2C
> > +	tristate "SPS30 particulate matter sensor I2C driver"
> > +	depends on SPS30 && I2C
> > +	select CRC8
> Since the base module is not very useful without any of the drivers enabled,
> what you can do here is, make the base module non-user-selectable, e.g.
> remove the description text after the tristate and then do a `select SPS30`
> both here from he I2C module and the serial module.

Right. Current form was helpful in debugging and eventually I forgot to
change it to something reasonable. Thanks for catching this.

> > +	help
> > +	  Say Y here to build support for the Sensirion SPS30 I2C interface
> > +	  driver.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called sps30_i2c.
> > +
> >   config VZ89X
> >   	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
> >   	depends on I2C
> > diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> > index fef63dd5bf92..41c264a229c0 100644
> > --- a/drivers/iio/chemical/Makefile
> > +++ b/drivers/iio/chemical/Makefile
> > @@ -17,4 +17,5 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
> >   obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
> >   obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> >   obj-$(CONFIG_SPS30) += sps30.o
> > +obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
> >   obj-$(CONFIG_VZ89X)		+= vz89x.o
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> > index 7486591588c3..ec9db99e324c 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > [...]
> > +EXPORT_SYMBOL(sps30_probe);
> EXPORT_SYMBOL_GPL()

Ack.

> >   MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> >   MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor driver");
> > diff --git a/drivers/iio/chemical/sps30.h b/drivers/iio/chemical/sps30.h
> > new file mode 100644
> > index 000000000000..d2b7140fdeb4
> > --- /dev/null
> > +++ b/drivers/iio/chemical/sps30.h
> > @@ -0,0 +1,73 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _SPS30_H
> > +#define _SPS30_H
> > +
> > +struct sps30_state;
> > +struct sps30_ops {
> > +	int (*start_meas)(struct sps30_state *state);
> > +	int (*stop_meas)(struct sps30_state *state);
> > +	int (*read_meas)(struct sps30_state *state, int *meas, int num);
> > +	int (*reset)(struct sps30_state *state);
> > +	int (*clean_fan)(struct sps30_state *state);
> > +	int (*read_cleaning_period)(struct sps30_state *state, int *period);
> > +	int (*write_cleaning_period)(struct sps30_state *state, int period);
>
> The interface for {read,write}_cleaning_period() should use __be32, since
> that is what is being passed around.
>
> I was a bit confused when reviewing the uart driver why we can just memcpy
> an int into the output buffer without endianess problems.
>

Agree that indeed might be confusing at first read since as you said
all endianess conversions are handled in core and other components just
take everything verbatim - which isn't that obvious.

> > +	int (*show_info)(struct sps30_state *state);
> > +};
> > +
> [...]
