Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A03107E69
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 13:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKWMuh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 07:50:37 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44070 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfKWMuh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2019 07:50:37 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Nov 2019 07:50:36 EST
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 523AE9E7BB5;
        Sat, 23 Nov 2019 12:41:37 +0000 (GMT)
Date:   Sat, 23 Nov 2019 12:41:35 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [v3 7/9] iio: max31856: add support for runtime-configuring the
 thermocouple type
Message-ID: <20191123124135.32ddd243@archlinux>
In-Reply-To: <20191123124019.33908147@archlinux>
References: <20191111153517.13862-1-andrea.merello@gmail.com>
        <20191120144756.28424-1-andrea.merello@gmail.com>
        <20191120144756.28424-8-andrea.merello@gmail.com>
        <20191123124019.33908147@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 23 Nov 2019 12:40:19 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 20 Nov 2019 15:47:54 +0100
> Andrea Merello <andrea.merello@gmail.com> wrote:
> 
> > The sensor support various thermocouple types (e.g. J, K, N, ...). The
> > driver allows to configure this parameter using a DT property.
> > 
> > This is useful when i.e. the thermocouple is physically tied to the sensor
> > and it is usually not removed, or when it is at least known in advance
> > which sensor will be connected to the circuit.
> > 
> > However, if the user can randomly connect any kind of thermocouples (i.e.
> > the device exposes a connector, and the user is free to connect its own
> > sensors), it would be more appropriate to provide a mechanism to
> > dynamically switch from one thermocouple type to another. This can be i.e.
> > handled in userspace by a GUI, a configuration file or a program that
> > detects the thermocouple type by reading a GPIO, or a eeprom on the probe,
> > or whatever.
> > 
> > This patch adds a IIO attribute that can be used to override, at run-time,
> > the DT-provided setting (which serves as default).
> > 
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: Colin Ian King <colin.king@canonical.com>
> > Cc: Patrick Havelange <patrick.havelange@essensium.com>
> > Cc: Matt Weber <matthew.weber@rockwellcollins.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > Cc: Chuhong Yuan <hslester96@gmail.com>
> > Cc: Daniel Gomez <dagmcr@gmail.com>
> > Cc: linux-iio@vger.kernel.org
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>  
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 
One immediate tweak from my own build tests.  Missing static on the 
types array. I've fixed up.

Jonathan

> thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/temperature/max31856.c | 41 +++++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> > index 8457ca9ae326..4952e89c00bb 100644
> > --- a/drivers/iio/temperature/max31856.c
> > +++ b/drivers/iio/temperature/max31856.c
> > @@ -6,6 +6,7 @@
> >   * Copyright (C) 2018-2019 Rockwell Collins
> >   */
> >  
> > +#include <linux/ctype.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/err.h>
> > @@ -53,7 +54,8 @@ static const struct iio_chan_spec max31856_channels[] = {
> >  	{	/* Thermocouple Temperature */
> >  		.type = IIO_TEMP,
> >  		.info_mask_separate =
> > -			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
> > +			BIT(IIO_CHAN_INFO_THERMOCOUPLE_TYPE),
> >  		.info_mask_shared_by_type =
> >  			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)
> >  	},
> > @@ -75,6 +77,10 @@ struct max31856_data {
> >  	int averaging;
> >  };
> >  
> > +const char max31856_tc_types[] = {
> > +	'B', 'E', 'J', 'K', 'N', 'R', 'S', 'T'
> > +};
> > +
> >  static int max31856_read(struct max31856_data *data, u8 reg,
> >  			 u8 val[], unsigned int read_size)
> >  {
> > @@ -232,6 +238,9 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >  		*val = 1 << data->averaging;
> >  		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > +		*val = max31856_tc_types[data->thermocouple_type];
> > +		return IIO_VAL_CHAR;
> >  	default:
> >  		ret = -EINVAL;
> >  		break;
> > @@ -240,6 +249,18 @@ static int max31856_read_raw(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > +static int max31856_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +				      struct iio_chan_spec const *chan,
> > +				      long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > +		return IIO_VAL_CHAR;
> > +	default:
> > +		return IIO_VAL_INT;
> > +	}
> > +}
> > +
> >  static int max31856_write_raw(struct iio_dev *indio_dev,
> >  			      struct iio_chan_spec const *chan,
> >  			      int val, int val2, long mask)
> > @@ -259,7 +280,24 @@ static int max31856_write_raw(struct iio_dev *indio_dev,
> >  		data->averaging = msb;
> >  		max31856_init(data);
> >  		break;
> > +	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > +	{
> > +		int tc_type = -1;
> > +		int i;
> > +
> > +		for (i = 0; i < ARRAY_SIZE(max31856_tc_types); i++) {
> > +			if (max31856_tc_types[i] == toupper(val)) {
> > +				tc_type = i;
> > +				break;
> > +			}
> > +		}
> > +		if (tc_type < 0)
> > +			return -EINVAL;
> >  
> > +		data->thermocouple_type = tc_type;
> > +		max31856_init(data);
> > +		break;
> > +	}
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -356,6 +394,7 @@ static const struct attribute_group max31856_group = {
> >  static const struct iio_info max31856_info = {
> >  	.read_raw = max31856_read_raw,
> >  	.write_raw = max31856_write_raw,
> > +	.write_raw_get_fmt = max31856_write_raw_get_fmt,
> >  	.attrs = &max31856_group,
> >  };
> >    
> 

