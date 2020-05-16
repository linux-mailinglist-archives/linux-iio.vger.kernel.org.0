Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A191D6266
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgEPPuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPPuD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:50:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE2420727;
        Sat, 16 May 2020 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589644202;
        bh=hhy3Rx5Ua0JE3z3fSJo5xllDQdIaYvzcHljCDwp2hhc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g6Qldw4v2VsyLxn3pAuJEYfYac96RqAzfRLt0DeeFvUybBiIPNtarqL5e5wyZorpv
         vktZNcUwy4kPRC5a1Rqrzg0ad8AyGnWW5AxKcJ/VDso7R9TxnfB9ui/vKWKY3JDZ+J
         7Knxh+wMHq0/XYEG7ZBgdOZofa3MtbdDf3xC9G/I=
Date:   Sat, 16 May 2020 16:49:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio: Add in_illumincance vectors in different
 color spaces
Message-ID: <20200516164958.453c8469@archlinux>
In-Reply-To: <CAPUE2uvT4zf9xR7Bq12xB3W_r_Sm=qG3g7PQ9VWfP8j92894EQ@mail.gmail.com>
References: <20200506230324.139241-1-gwendal@chromium.org>
        <20200506230324.139241-2-gwendal@chromium.org>
        <20200508161635.00006cd2@Huawei.com>
        <CAPUE2uvT4zf9xR7Bq12xB3W_r_Sm=qG3g7PQ9VWfP8j92894EQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 May 2020 21:10:40 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Fri, May 8, 2020 at 8:16 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 6 May 2020 16:03:22 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Illuminance in the title.  Plus I'm still arguing these
> > aren't illuminance values.
> >
> > The Y value is illuminance but X and Z definitely aren't.
> > RGB needs to stick to intensity - like the other existing
> > RGB sensors.
> >
> > Gah.  XYZ and IIO is a mess.
> >
> > I suppose we could introduce a new type and have
> > in_illumiance_raw
> > in_chromacity_x_raw
> > in_chromacity_z_raw but chances of anyone understanding what we
> > are on about without reading wikipedia is low...
> >
> > Sigh.  Unless someone else chips in, I'm inclined to be lazy and rely
> > on documentation to let in_illuminance_x,y,z be defined as being
> > cie xyz color space measurements.
> >
> > It seems slighlty preferable to defining another type for these,
> > though I suspect I'll regret this comment when some adds
> > cie lab which was always my favourite colour space :)
> >
> >
> >  
> > > Define 2 spaces for defining color coming from color sensors:
> > > RGB and XYZ: Both are in lux.
> > > RGB is the raw output from sensors (Red, Green and Blue channels), in
> > > addition to the existing clear channel (C).  
> >  
> > > The RGBC vector goes through a matrix transformation to produce the XYZ
> > > vector. Y is illumincance, and XY caries the chromaticity information.
> > > The matrix is model specific, as the color sensor can be behing a glass
> > > that can filter some wavelengths.
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > ---
> > > New in v2.
> > >
> > >  Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index d3e53a6d8331b..256db6e63a25e 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -1309,6 +1309,33 @@ Description:
> > >               Illuminance measurement, units after application of scale
> > >               and offset are lux.
> > >
> > > +What:                /sys/.../iio:deviceX/in_illuminance_red_raw
> > > +What:                /sys/.../iio:deviceX/in_illuminance_green_raw
> > > +What:                /sys/.../iio:deviceX/in_illuminance_blue_raw
> > > +KernelVersion:       5.7
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             Illuminance measuremed in red, green or blue channels, units
> > > +             after application of scale and offset are lux.  
> >
> > No they aren't.  Units are some magic intensity at some magic wavelength.
> >  
> > > +
> > > +What:                /sys/.../iio:deviceX/in_illuminance_x_raw
> > > +What:                /sys/.../iio:deviceX/in_illuminance_y_raw
> > > +What:                /sys/.../iio:deviceX/in_illuminance_z_raw
> > > +KernelVersion:       5.7
> > > +Contact:     linux-iio@vger.kernel.org
> > > +Description:
> > > +             lluminance measured in the CIE 1931 color space (XYZ).
> > > +             in_illuminance_y_raw is a measure of the brightness, and is
> > > +             identical in_illuminance_raw.  
> >
> > That is fair enough.
> >  
> > > +             in_illuminance_x_raw and in_illuminance_z_raw carry chromacity
> > > +             information.
> > > +             in_illuminance_x,y,z_raw are be obtained from the sensor color
> > > +             channels using color matching functions that may be device
> > > +             specific.
> > > +             Units after application of scale and offset are lux.  
> >
> > True for Y, not for X and Z which don't have 'units' as such.  
> Indeed,I have difficulty mapping what comes from the sensor after
> adapting to an acceptable universal entity.
> 
> The goal of the sensor is to measure the ambient correlated color
> temperature (CCT), based on the x and y of the CIE xyY color space.
> Given x and y are defined as x = X / (X + Y +Z) and y = X / (X + Y +
> Z), X, Y and Z must have the same units.

The issue here is that illuminance is an unusual thing.   To go
for an analogy.  It's like measuring the volume of something at a
particular temperature.  However, it's only defined at that temperature.
You can divide it by other volumes at other temperatures and get all sorts
of interesting quantities and  much like volume the indeed have
the same units, but that unit is not lux (which is unit of illuminance).
The reason being illuminance is like defining volume at 0 degree centigrade.

Illuminance is only defined for that particular set of frequencies
and is not defined otherwise.

If we'd called our light input something other than illuminance 
- say 'in_light_raw' then we could play fast and loose with units
perhaps but we didn't.  We deliberately used intensity to represent
all light measurements other than the one specific one that is illuminance.

So we should stick to intensity really which was chosen specifically
to 'not carry' the weird characteristics that illuminance has. It deliberately
makes no statement about frequency sensitivity etc.

In a past life I did a lot of work machine vision so am familiar with
most of the standard colour spaces and what they were trying to do
when defining them.  Personally always like CieLAB because you can
basically use it to get rid of shadows :)  Maths to compute it
is however fairly crazy.

Jonathan
 
> 
> CCT(x,y) is computed in user space, for example using this
> approximation (https://en.wikipedia.org/wiki/Color_temperature#Approximation).
> 
> Gwendal.
> 
> 
> >  
> > > +             The measurments can be used to represent colors in the CIE
> > > +             xyY color space  
> >
> > XYZ
> >  
> > > +
> > >  What:                /sys/.../iio:deviceX/in_intensityY_raw
> > >  What:                /sys/.../iio:deviceX/in_intensityY_ir_raw
> > >  What:                /sys/.../iio:deviceX/in_intensityY_both_raw  
> >
> >  

