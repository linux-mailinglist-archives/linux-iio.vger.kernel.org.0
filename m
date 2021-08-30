Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF633FBAA7
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbhH3RKA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 13:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238010AbhH3RJ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 13:09:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F34D60F23;
        Mon, 30 Aug 2021 17:09:03 +0000 (UTC)
Date:   Mon, 30 Aug 2021 18:12:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: ABI: docs: Document Senseair Sunrise ABI
Message-ID: <20210830181214.203ff714@jic23-huawei>
In-Reply-To: <20210830162411.pnr57ih2x7tfnqbv@uno.localdomain>
References: <20210822184927.94673-1-jacopo@jmondi.org>
        <20210822184927.94673-4-jacopo@jmondi.org>
        <20210829175748.6c4e9a20@jic23-huawei>
        <20210830162411.pnr57ih2x7tfnqbv@uno.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Aug 2021 18:24:11 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> Hi Jonathan,
> 
> On Sun, Aug 29, 2021 at 05:57:48PM +0100, Jonathan Cameron wrote:
> > On Sun, 22 Aug 2021 20:49:27 +0200
> > Jacopo Mondi <jacopo@jmondi.org> wrote:
> >  
> > > Add documentation for the sysfs attributes of the sunrise_co2 driver.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > > ---
> > >  .../sysfs-bus-iio-chemical-sunrise-co2        | 51 +++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
> > > new file mode 100644
> > > index 000000000000..1a252f616652
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
> > > @@ -0,0 +1,51 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_calibration_mode_available
> > > +Date:		August 2021
> > > +KernelVersion:
> > > +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> > > +Description:
> > > +		Reading returns the list of the possible calibration modes.
> > > +		Available options:
> > > +		- 'factory_calibration': Restore factory calibration
> > > +		- 'background_calibration': Calibration using target value
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration_mode
> > > +Date:		August 2021
> > > +KernelVersion:
> > > +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> > > +Description:
> > > +		Reading returns the currently selected calibration mode.
> > > +		Writing sets the desired calibration mode to one of the values
> > > +		returned by 'in_concentration_calibration_mode_available'
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_calibration
> > > +Date:		August 2021
> > > +KernelVersion:
> > > +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> > > +Description:
> > > +		Writing '1' triggers a calibration cycle according to the mode
> > > +		set int 'in_concentration_co2_calibration_mode'.  
> > Why not just have two attributes:
> >
> > 	in_concentration_co2_calibration_factory
> > 	in_concentration_co2_calibration_background
> > and have writing 1 to the appropriate one start that type of calibration?
> >
> > Feels like that would be a simpler interface.  
> 
> Please see my reply in the driver's patch.
> With an ack to the fact the chip supports 5 calibration modes and we
> might end up with one attribute for each, I'll change.

5 attrs is fine.

> 
> >  
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_error_status_available
> > > +Date:		August 2021
> > > +KernelVersion:
> > > +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> > > +Description:
> > > +		Reading returns the list of possible chip error status.
> > > +		Available options are:
> > > +		- 'error_fatal': Analog front-end initialization error
> > > +		- 'error_i2c': Read/write to non-existing register
> > > +		- 'error_algorithm': Corrupted parameters
> > > +		- 'error_calibration': Calibration has failed
> > > +		- 'error_self_diagnostic': Internal interface failure
> > > +		- 'error_out_of_range': Measured concentration out of scale
> > > +		- 'error_memory': Error during memory operations
> > > +		- 'error_no_measurement': Cleared at first measurement
> > > +		- 'error_low_voltage': Sensor regulated voltage too low
> > > +		- 'error_measurement_timeout': Unable to complete measurement
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_error_status  
> >
> > Some of these are not 'technically' channels specific, so I'd argue this should be shared_by_all
> > and hence error_status only.  
> 
> You know, it's kind of a mixed bag of errors.
> 
> I thought as most apply to calibration/concentration it made sense to
> have them separate, but I can change this to be shared indeed.

It's obscure and custom so I don't really care.  Up to you.
> 
> >
> > One day we will have a nice general way of reporting such errors, but that's not an IIO question
> > as such so we can probably cope with this.
> >
> >  
> > > +Date:		August 2021
> > > +KernelVersion:
> > > +Contact:	Jacopo Mondi <jacopo@jmondi.org>
> > > +Description:
> > > +		Reading returns the current chip error status.  
> >  

