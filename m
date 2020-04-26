Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765361B8F5B
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDZLMd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 07:12:33 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:50401 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgDZLMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 07:12:33 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.25])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id B070B5AE2A86;
        Sun, 26 Apr 2020 13:12:29 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sun, 26 Apr
 2020 13:12:29 +0200
Date:   Sun, 26 Apr 2020 13:11:04 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 4/6] Documentation: ABI: testing: scd30: document iio
 attributes
Message-ID: <20200426111104.GB3282@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-5-tomasz.duszynski@octakon.com>
 <alpine.DEB.2.21.2004221818490.26800@vps.pmeerw.net>
 <20200423155317.GB43448@arch>
 <20200425202057.5c8ad612@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200425202057.5c8ad612@archlinux>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 7826411728179190866
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrheejgdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehrohgshhdoughtsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 25, 2020 at 08:20:57PM +0100, Jonathan Cameron wrote:
> On Thu, 23 Apr 2020 17:53:17 +0200
> Tomasz Duszynski <tomasz.duszynski@octakon.com> wrote:
>
> > On Wed, Apr 22, 2020 at 06:40:17PM +0200, Peter Meerwald-Stadler wrote:
> > > On Wed, 22 Apr 2020, Tomasz Duszynski wrote:
> > >
> > > > Add documentation for sensor specific iio attributes.
> > >
> > > minor comments below
> >
> > Thanks.
> >
> > >
> > > > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-iio-scd30 | 97 +++++++++++++++++++
> > > >  1 file changed, 97 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-scd30 b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> > > > new file mode 100644
> > > > index 000000000000..0431a718447d
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> > > > @@ -0,0 +1,97 @@
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Given that sensor's CO2 measurement chamber has fixed volume
> > > > +		pressure changes will affect concentration readings. Writing
> > > > +		current ambient pressure here will allow senor to make necessary
> > >
> > > sensor
> > >
> >
> > Okay.
> >
> > > > +		adjustments. Upon reading previously set value is returned.
> > > > +		Units are millibars.
> > >
> > > unit for pressure in IIO is kilopascal (e.g.
> > > /sys/bus/iio/devices/iio:deviceX/in_pressure_raw)
> > >
> >
> > My thinking here was that since these are sensor specific attributes
> > they don't need to stick to iio conventions and millibars were somewhat
> > more natural to use. But I guess that's just matter of habit.
>
> You absolutely have to stick to standard units.  Userspace programs
> aren't going to come read your docs...
>
> For other sensors that take a calibration value like this we've reported
> them via an output channel.  For example the atlas-ph sensor has
> an 'output temp' channel used for this purpose.
>

Fair enough.

> It's not ideal or totally intuitive but it does let us avoid expanding
> the overall ABI.  The argument was something along the lines of
> 1) Imagine your sensor could control the pressure in the measurement space...
> 2) An output channel would provide the value to set it to.
> 3) Now instead we provide a means of saying 'what it is'
> 4) End result is we write a value and the pressure in the chamber is
>    that value :)
>
> As I said not ideal but the best we can do without having to define a lot
> of ABI just to deal with compensation factors.
>
> This is a rare case where I would document the 'standard' ABI in here
> to make the point that it is actually providing an estimate of the pressure
> not controlling it...
>
> >
> > So generally I am okay with reworking all attrs to accept values in iio
> > preferred units.
> >
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp_available
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		The range of available values in millibars represented as the
> > > > +		minimum value, the step and the maximum value, all enclosed in
> > > > +		square brackets.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/meas_interval
> > > > +Date:		January 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Amount of time between subsequent measurements. Writing this
> > > > +		attribute will change measurement interval. Upon reading
> > > > +		current measurement interval is returned. Units are seconds.
>
> Use the existing ABI sampling frequency which is sort of the inverse of this.
>

Was thinking about it but long periods in Hz simply don't look appealing :).

No other strong opinions so I'll rework that.

> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/meas_interval_available
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		The range of available values in seconds represented as the
> > > > +		minimum value, the step and the maximum value, all enclosed in
> > > > +		square brackets.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/asc
> Spends some characters to easy of understanding ;)
>
> auto_calib_proc_enable maybe?  Or can we get away with the 'somewhat standard
> calibration (it's used in at least one other driver IIRC)
>

Just self_calibration would do?

> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Writing 1 or 0 to this attribute will respectively activate or
> > > > +		deactivate automatic self calibration procedure. Upon reading 1
> > >
> > > deactivate automatic self calibration (asc) procedure
> > >
> >
> > That shouldn't be too difficult to realize what asc actually stands for after
> > reading this short description.
> >
> > > > +		is returned if asc is ongoing, 0 otherwise.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/frc
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Forced recalibration is used to compensate for sensor drifts
> > > > +		when a reference value of CO2 concentration in close proximity
> > > > +		to the sensor is available. Writing attribute will set frc
> > > > +		value. Upon reading current frc is returned. Units are
> > > > +		millibars.
>
> Could we implement this by just writing to the main channel value?
> Bit of a clunky ABI but sort of logically fits in my head given we are basically
> forcing the value we read to be this one?
>

So the similar to the pressure compensation. Okay.

> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/frc_available
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		The range of available values in millibars represented as the
> > > > +		minimum value, the step and the maximum value, all enclosed in
> > > > +		square brackets.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/temp_offset
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Sensor readings may be affected by ambient temperature.
> > > > +		Writing temperature offset will compensate for unwanted changes.
> > > > +		Note that written offset gets multiplied by a factor of 100
> > > > +		by a sensor internally.
> > > > +
> > > > +		For example, writing 10 here will correspond to 0.1 degree
> > > > +		Celsius.
>
> This sounds like a calibbias to me which is standard ABI.
>

Right, that could work.

> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/temp_offset_available
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		The range of available values in degrees Celsius represented as
> > > > +		the minimum value, the step and the maximum value, all enclosed
> > > > +		in square brackets.
>
> Wrong units for temperature (which is an odd one as we
> lifted them from hwmon before learning the error of our ways and starting to use
> SI units as the base).
>

Does calibbias have _available counterpart?

>
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/reset
> > > > +Date:		April 2020
> > > > +KernelVersion:	5.8
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Software reset mechanism forces sensor into the same state
> > > > +		as after powering up without the need for removing power supply.
> > > > +		Writing any value will reset sensor.
>
> Not seeing an argument here for why you might want to do that other than on
> power up or module probe to get the driver into a known state.
> So currently it's a no to this one - just don't expose it to userspace.
>

If one writes some odd configuration (though allowed) into sensor, for example
out of sheer curiosity and then writes the sane values back sensor needs some
time to recover (i.e start reporting valid measurements again).

So rationale here was that after reset sensor recovers immediately. I'd
say that reset is sometimes useful. Perhaps that could be exported by
means of iio debug api?

>
> > > >
> > >
> > > --
> > >
> > > Peter Meerwald-Stadler
> > > Mobile: +43 664 24 44 418
>
