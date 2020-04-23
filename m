Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67C51B5FF9
	for <lists+linux-iio@lfdr.de>; Thu, 23 Apr 2020 17:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgDWPyo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Apr 2020 11:54:44 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:43253 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729435AbgDWPyo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2020 11:54:44 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.145])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 3F0B54F74541;
        Thu, 23 Apr 2020 17:54:41 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 23 Apr
 2020 17:54:40 +0200
Date:   Thu, 23 Apr 2020 17:53:17 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH 4/6] Documentation: ABI: testing: scd30: document iio
 attributes
Message-ID: <20200423155317.GB43448@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-5-tomasz.duszynski@octakon.com>
 <alpine.DEB.2.21.2004221818490.26800@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004221818490.26800@vps.pmeerw.net>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 13421008366491753717
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 22, 2020 at 06:40:17PM +0200, Peter Meerwald-Stadler wrote:
> On Wed, 22 Apr 2020, Tomasz Duszynski wrote:
>
> > Add documentation for sensor specific iio attributes.
>
> minor comments below

Thanks.

>
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-scd30 | 97 +++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-scd30 b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> > new file mode 100644
> > index 000000000000..0431a718447d
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-scd30
> > @@ -0,0 +1,97 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Given that sensor's CO2 measurement chamber has fixed volume
> > +		pressure changes will affect concentration readings. Writing
> > +		current ambient pressure here will allow senor to make necessary
>
> sensor
>

Okay.

> > +		adjustments. Upon reading previously set value is returned.
> > +		Units are millibars.
>
> unit for pressure in IIO is kilopascal (e.g.
> /sys/bus/iio/devices/iio:deviceX/in_pressure_raw)
>

My thinking here was that since these are sensor specific attributes
they don't need to stick to iio conventions and millibars were somewhat
more natural to use. But I guess that's just matter of habit.

So generally I am okay with reworking all attrs to accept values in iio
preferred units.

> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/pressure_comp_available
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The range of available values in millibars represented as the
> > +		minimum value, the step and the maximum value, all enclosed in
> > +		square brackets.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/meas_interval
> > +Date:		January 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Amount of time between subsequent measurements. Writing this
> > +		attribute will change measurement interval. Upon reading
> > +		current measurement interval is returned. Units are seconds.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/meas_interval_available
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The range of available values in seconds represented as the
> > +		minimum value, the step and the maximum value, all enclosed in
> > +		square brackets.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/asc
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Writing 1 or 0 to this attribute will respectively activate or
> > +		deactivate automatic self calibration procedure. Upon reading 1
>
> deactivate automatic self calibration (asc) procedure
>

That shouldn't be too difficult to realize what asc actually stands for after
reading this short description.

> > +		is returned if asc is ongoing, 0 otherwise.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/frc
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Forced recalibration is used to compensate for sensor drifts
> > +		when a reference value of CO2 concentration in close proximity
> > +		to the sensor is available. Writing attribute will set frc
> > +		value. Upon reading current frc is returned. Units are
> > +		millibars.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/frc_available
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The range of available values in millibars represented as the
> > +		minimum value, the step and the maximum value, all enclosed in
> > +		square brackets.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/temp_offset
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Sensor readings may be affected by ambient temperature.
> > +		Writing temperature offset will compensate for unwanted changes.
> > +		Note that written offset gets multiplied by a factor of 100
> > +		by a sensor internally.
> > +
> > +		For example, writing 10 here will correspond to 0.1 degree
> > +		Celsius.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/temp_offset_available
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		The range of available values in degrees Celsius represented as
> > +		the minimum value, the step and the maximum value, all enclosed
> > +		in square brackets.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/reset
> > +Date:		April 2020
> > +KernelVersion:	5.8
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Software reset mechanism forces sensor into the same state
> > +		as after powering up without the need for removing power supply.
> > +		Writing any value will reset sensor.
> >
>
> --
>
> Peter Meerwald-Stadler
> Mobile: +43 664 24 44 418
