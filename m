Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08A458351
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 13:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhKUMah convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 21 Nov 2021 07:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhKUMah (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 07:30:37 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478216023E;
        Sun, 21 Nov 2021 12:27:31 +0000 (UTC)
Date:   Sun, 21 Nov 2021 12:32:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Message-ID: <20211121123225.5776c510@jic23-huawei>
In-Reply-To: <CY4PR03MB3399908F8ED22DF23C89A09E9B999@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-5-antoniu.miclaus@analog.com>
        <20211112175625.4a9f393d@jic23-huawei>
        <CY4PR03MB3399908F8ED22DF23C89A09E9B999@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Nov 2021 14:43:16 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> Hello Jonathan,
Hi Antoniu
> 
> --
> Antoniu Miclăuş
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Friday, November 12, 2021 7:56 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: robh+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 4/4] iio:filter:admv8818: Add sysfs ABI documentation
> > 
> > [External]
> > 
> > On Tue, 9 Nov 2021 14:31:27 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >   
> > > Add initial ABI documentation for admv8818 filter sysfs interfaces.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-filter-admv8818 | 60 +++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-  
> > admv8818  
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818  
> > b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818  
> > > new file mode 100644
> > > index 000000000000..7fa5b0819055
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> > > @@ -0,0 +1,60 @@
> > > +What:  
> > 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_high_pass_3
> > db_frequency  
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		The cut-off frequency of the ADMV8818 high pass filter. The  
> > value is scaled using  
> > > +		the `out_altvoltageY_scale` attribute so that GHz frequencies  
> > are valid inputs,  
> > > +		The accepted range of values for the frequencies is between  
> > 1.75GHz and 19.9GHz.  
> > > +
> > > +		The default value for the scale is 1000000, therefore MHz  
> > frequency values are  
> > > +		passed as input.  
> > 
> > I don't think this ABI really works unfortunately.  What we are talking here is
> > a bunch of
> > selectable filters and one high pass + one low pass filter max can be enabled
> > at a time.
> > 
> > So two options, we either have simply a single
> > out_altvoltage_filter_low_pass_3db_frequency
> > out_altvoltage_filter_high_pass_3db_frequency
> > Probably both with index 0 and index free channels are a silly idea given it's
> > fine to just have
> > one with index 0.
> > 
> > or if there is sufficient reason to setup a selectable set of options then
> > we could look at indexed filters and a _symbol type selection which may
> > seem
> > odd but generalises fairly well from Phase Shift Keying type symbol stuff we
> > have had before (though still in staging because no one has cleaned the
> > drivers
> > up yet).
> > 
> >   
> > > +
> > > +What:  
> > 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_low_pass_3
> > db_frequency  
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		The cut-off frequency of the ADMV8818 low pass filter. The  
> > value is scaled using  
> > > +		the `out_altvoltageY_scale` attribute so that GHz frequencies  
> > are valid inputs,  
> > > +		The accepted range of values for the frequencies is between  
> > 2.05GHz and 18.85GHz.  
> > > +
> > > +		The default value for the scale is 1000000, therefore MHz  
> > frequency values are  
> > > +		passed as input.
> > > +
> > > +What:  
> > 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale  
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Scale high pass and lowpass filter frequency values to Hz.
> > > +
> > > +What:  
> > 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode_available  
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Reading this returns the valid values that can be written to  
> > the  
> > > +		on_altvoltage0_mode attribute:
> > > +
> > > +		- auto -> enable/register the clock rate notifier  

Probably want to separate this description from the 'how'

So "auto -> Adjust bandpass filter to track changes in input clock rate."
or something along those lines.

> > 
> > Hmm I'm wondering about the usecases of this.
> > 
> > If this is being used with a clk device, then I think only the notifier option
> > makes much
> > sense.  If it's not a clk that linux is aware of then manual makes more sense.
> >   
> > > +		- manual -> disable/unregister the clock rate notifier
> > > +		- bypass -> bypass LPF/HPF and disable/unregister the clock  
> > rate notifier
> > 
> > This should be separate enable for the two filters though I think we've use
> > the value 0
> > to mean this in the past.  The bypasses look to be per filter anyway, so a
> > single
> > mode is insufficiently flexible.
> > 
> > In the vast majority of cases, mode attributes are not used because they are
> > always device
> > specific and hence generic code has no idea what to do with them.
> >   
> 
> As I mentioned also in the dt-bindings comments, these attributes were added  
> because they were requested by the users of the application in which this part
> was involved.
> 
> If you think these attributes/properties are way too custom, I can drop them.
> 
> Same goes for the bandwidth attribute.

If that's the most common use case then it's fine to keep them in my view.

Bypass is disabling a particular filter though so we should express it like that.
out_altvotage0_low_pass_filter_en etc

Also I think a single 1/0 attribute called something like

out_altvoltage0_filter_auto_en

which, when set makes the control parameters read only.



> 
> > > +
> > > +What:  
> > 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode  
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		This attribute configures the filter mode.
> > > +		Reading returns the actual mode.
> > > +
> > > +What:  
> > 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_
> > bandwidth_3db_frequency  
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Store the band pass bandwidth frequency value applied.
> > > +		Reading returns the bandwidth frequency scaled.  
> > 
> > The device has no concept of bandpass that I can find so why are we
> > introducing it?
> > Let the user set the two filters to achieve this result.  Userspace can do the
> > maths for us :)

Definitely expose the two filters separately. The auto path can control them
appropriately but if things have moved to userspace control then I think
exposing each filter is a better bet.  Given we should be able to disable them
independently it's more than possible a user will want just a low pass or just
a high pass filter depending on their application.

> >   
> > > +
> > > +
> > > +What:  
> > 	/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_
> > center_frequency  
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Store the band pass center frequency value applied.
> > > +		Reading returns the center frequency scaled.  
> 

