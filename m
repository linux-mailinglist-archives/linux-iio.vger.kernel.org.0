Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B0D44EC5E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 19:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhKLSD5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 13:03:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235429AbhKLSD4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 13:03:56 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C86461057;
        Fri, 12 Nov 2021 18:01:04 +0000 (UTC)
Date:   Fri, 12 Nov 2021 18:05:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Message-ID: <20211112180551.5bdc29c8@jic23-huawei>
In-Reply-To: <20211112175625.4a9f393d@jic23-huawei>
References: <20211109123127.96399-1-antoniu.miclaus@analog.com>
        <20211109123127.96399-5-antoniu.miclaus@analog.com>
        <20211112175625.4a9f393d@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Nov 2021 17:56:25 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 9 Nov 2021 14:31:27 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add initial ABI documentation for admv8818 filter sysfs interfaces.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-filter-admv8818 | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> > new file mode 100644
> > index 000000000000..7fa5b0819055
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> > @@ -0,0 +1,60 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_high_pass_3db_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The cut-off frequency of the ADMV8818 high pass filter. The value is scaled using
> > +		the `out_altvoltageY_scale` attribute so that GHz frequencies are valid inputs,
> > +		The accepted range of values for the frequencies is between 1.75GHz and 19.9GHz.
> > +
> > +		The default value for the scale is 1000000, therefore MHz frequency values are
> > +		passed as input.  
> 
> I don't think this ABI really works unfortunately.  What we are talking here is a bunch of
> selectable filters and one high pass + one low pass filter max can be enabled at a time.
> 
> So two options, we either have simply a single
> out_altvoltage_filter_low_pass_3db_frequency
> out_altvoltage_filter_high_pass_3db_frequency
> Probably both with index 0 and index free channels are a silly idea given it's fine to just have
> one with index 0.
> 
> or if there is sufficient reason to setup a selectable set of options then
> we could look at indexed filters and a _symbol type selection which may seem
> odd but generalises fairly well from Phase Shift Keying type symbol stuff we
> have had before (though still in staging because no one has cleaned the drivers
> up yet).

Ignore this comment.  You have already done what I'm suggesting and I didn't read you docs
closely enough. Sorry about that!

However, this is generic, move it to the main sysfs-bus-iio docs rather than in here.

Snag is that we have to provide the values in Hz as that's what the ABI already has defined.

If we have to define ways to deal with all the zeros as they don't fit in existing path then
we can add those to the core.

Jonathan

> 
> 
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_low_pass_3db_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The cut-off frequency of the ADMV8818 low pass filter. The value is scaled using
> > +		the `out_altvoltageY_scale` attribute so that GHz frequencies are valid inputs,
> > +		The accepted range of values for the frequencies is between 2.05GHz and 18.85GHz.
> > +
> > +		The default value for the scale is 1000000, therefore MHz frequency values are
> > +		passed as input.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Scale high pass and lowpass filter frequency values to Hz.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode_available
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Reading this returns the valid values that can be written to the
> > +		on_altvoltage0_mode attribute:
> > +
> > +		- auto -> enable/register the clock rate notifier  
> 
> Hmm I'm wondering about the usecases of this.
> 
> If this is being used with a clk device, then I think only the notifier option makes much
> sense.  If it's not a clk that linux is aware of then manual makes more sense.
> 
> > +		- manual -> disable/unregister the clock rate notifier
> > +		- bypass -> bypass LPF/HPF and disable/unregister the clock rate notifier  
> 
> This should be separate enable for the two filters though I think we've use the value 0
> to mean this in the past.  The bypasses look to be per filter anyway, so a single
> mode is insufficiently flexible.
> 
> In the vast majority of cases, mode attributes are not used because they are always device
> specific and hence generic code has no idea what to do with them.
> 
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_mode
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		This attribute configures the filter mode.
> > +		Reading returns the actual mode.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_bandwidth_3db_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Store the band pass bandwidth frequency value applied.
> > +		Reading returns the bandwidth frequency scaled.  
> 
> The device has no concept of bandpass that I can find so why are we introducing it?
> Let the user set the two filters to achieve this result.  Userspace can do the maths for us :)
> 
> > +
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_band_pass_center_frequency
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Store the band pass center frequency value applied.
> > +		Reading returns the center frequency scaled.  
> 

