Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C3136CA5A
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhD0RaY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0RaY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 13:30:24 -0400
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF448C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 10:29:40 -0700 (PDT)
Received: from [81.101.6.87] (port=33690 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1lbRWk-0008NX-Sk; Tue, 27 Apr 2021 18:29:39 +0100
Date:   Tue, 27 Apr 2021 18:30:20 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [RFC PATCH 1/7] iio:ABI docs: Fix up duplicate *_calibbias_*
 documentation for icm42600
Message-ID: <20210427183004.14fede9c@jic23-huawei>
In-Reply-To: <20210221160529.0012c931@archlinux>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-2-jic23@kernel.org>
        <20210221160529.0012c931@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 21 Feb 2021 16:05:29 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 17 Jan 2021 15:38:10 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> @Jean-Baptiste.
> 
> Whilst this is 'fairly obviously' fine, could you take a quick glance at it.
> I'm never keen to take my own patches without someone having agreed
> I haven't done anything particularly silly ;)

As these are still frustrating Mauro's attempt to get the docs to build
cleanly and it should be safe enough.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Jonathan

> 
> Jonathan
> 
> > 
> > This device has the unusual characteristic that the calibbias values
> > have well defined units (more commonly they are tweaks to a DAC)
> > Unfortunately the previous approach of having more specific documentation
> > in sysfs-bus-iio-icm42600 results in warnings during the documentation
> > build and random ordering in the resulting documentation.
> > 
> > To avoid this, add a note to the main documentation on this special
> > characteristic for the icm42600.   The _available for calibbias was
> > missing from the main sysfs-bus-iio docs so also add that, allowing
> > us to drop the icm42600 specific file.
> > 
> > Fixes
> > $ scripts/get_abi.pl validate warning:
> > Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  ./Documentation/ABI/testing/sysfs-bus-iio:394
> > Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  ./Documentation/ABI/testing/sysfs-bus-iio:395
> > Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  ./Documentation/ABI/testing/sysfs-bus-iio:396
> > Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  ./Documentation/ABI/testing/sysfs-bus-iio:397
> > Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  ./Documentation/ABI/testing/sysfs-bus-iio:398
> > Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  ./Documentation/ABI/testing/sysfs-bus-iio:399
> > 
> > Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio       | 13 ++++++++++++
> >  .../ABI/testing/sysfs-bus-iio-icm42600        | 20 -------------------
> >  2 files changed, 13 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index d957f5da5c04..d2dd9cc280f9 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -408,6 +408,19 @@ Contact:	linux-iio@vger.kernel.org
> >  Description:
> >  		Hardware applied calibration offset (assumed to fix production
> >  		inaccuracies).
> > +		icm42600: For this device values are real physical offsets
> > +		expressed in SI units (m/s^2 for accelerometers and rad/s
> > +		for gyroscope)/
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
> > +KernelVersion:  5.8
> > +Contact:        linux-iio@vger.kernel.org
> > +Description:
> > +		Available values of calibbias. Maybe expressed as either of:
> > +
> > +		- a small discrete set of values like "0 2 4 6 8"
> > +		- a range specified as "[min step max]"
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-icm42600 b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
> > deleted file mode 100644
> > index 0bf1fd4f5bf1..000000000000
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-icm42600
> > +++ /dev/null
> > @@ -1,20 +0,0 @@
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
> > -KernelVersion:  5.8
> > -Contact:        linux-iio@vger.kernel.org
> > -Description:
> > -		Hardware applied calibration offset (assumed to fix production
> > -		inaccuracies). Values represent a real physical offset expressed
> > -		in SI units (m/s^2 for accelerometer and rad/s for gyroscope).
> > -
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
> > -KernelVersion:  5.8
> > -Contact:        linux-iio@vger.kernel.org
> > -Description:
> > -		Range of available values for hardware offset. Values in SI
> > -		units (m/s^2 for accelerometer and rad/s for gyroscope).  
> 

