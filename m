Return-Path: <linux-iio+bounces-12529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3D9D6982
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFFF161680
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8D210FB;
	Sat, 23 Nov 2024 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1anw5te"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70429CE5;
	Sat, 23 Nov 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732373916; cv=none; b=N0nRBZBKWxy2QAKlkuPS9a8niKmORWYPSyqY4KalMORxfkIBiqAKgueLzksqce1BWU2u2FFedxo7Wy4ed3Wx+HmDBSl8pLSquRRTq/mySyHgSvPbASkd6afzR9omQDC3jRVK++HGshyha7/D0a8sQ60HMs4gGPsff3CDU4R3eGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732373916; c=relaxed/simple;
	bh=fePRNcWEVJfCGoNE6LOoO08Ja7WkMo1ZjtftsC4OT0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgippGypR0rHzi9tGsbfh15NR1SqCCiWXltUup+qTXvFBMBPC6Lhf+w5j3Olv6ePywerhcqmt1UnhBD4FgGRSvfMEWy/BTaeLRzFVuB/7PIllqbW7FcrHmw7oT5YDxwqNYLKJkPT0YX/rtJn7yIJAch8kqT43ZNyR77eThyfii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1anw5te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FF3C4CECD;
	Sat, 23 Nov 2024 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732373913;
	bh=fePRNcWEVJfCGoNE6LOoO08Ja7WkMo1ZjtftsC4OT0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1anw5teZjEeiVEVuQSiCeqfnbiMzYwI5uaP38F9q3SrezgE92Nim8e2UNJCnH3kb
	 BvG2cPKzs/fyv/UCxHqQIKvEDQZqgrzmqLWeoIANuTz9HiYyCS1EOKm33+PAjA4k9V
	 3m3/N7eDBMkr6ygocMdAO6x6uoqjkVaJBeqSXZU0/kn6fFtN9JX+sriTxFpnpg8mkk
	 qEOpfHaodmd0ew7EfXa9xabws5kEWEASbbHMFOHP+UsHpCUwytni3Zbb1H5P3h1IdC
	 sI0yCkLbF37UsEKWLMZItpivyOr9sIsrA5jgcI7aOQLnYSR9UE+M78KHrmgmEW6Ctl
	 j37KREXc1coHg==
Date: Sat, 23 Nov 2024 14:58:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 rickard.andersson@axis.com, kernel@axis.com
Subject: Re: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241123145825.769e1ea0@jic23-huawei>
In-Reply-To: <303bd71a-bb38-4afa-a9e2-046425084b69@axis.com>
References: <20241106120036.986755-1-perdaniel.olsson@axis.com>
	<20241106120036.986755-3-perdaniel.olsson@axis.com>
	<20241109150955.7526c416@jic23-huawei>
	<303bd71a-bb38-4afa-a9e2-046425084b69@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 16:35:18 +0100
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> On 11/9/24 16:09, Jonathan Cameron wrote:
> > On Wed, 6 Nov 2024 13:00:36 +0100
> > Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:
> >   
> >> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> >>
> >> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>  
> > Hi Per-Daniel
> > 
> > Main comment in here is that the ABI is standard (though oddly
> > missing in some cases from the main ABI doc). Annoyingly the
> > docs build process (try make htmldocs) does not work if there
> > are multiple entries for the same ABI, so we need to ensure that
> > the documentation for common ABI is in just one place.
> > That makes device specific ABI docs tricky, so instead we tend
> > to use extra rst files in Documentation/iio/ to provide more details.
> > 
> > Jonathan
> >   
> Hi Jonathan,
> 
> Thank you for your code comments, I will fix those in the next version.
> I have been trying to understand what I should do in
> Documentation/ABI/testing/sysfs-bus-iio but I don't really get it. See
> my questions below.
> 
> / P-D
> 
> >   
> >> ---
> >>  .../ABI/testing/sysfs-bus-iio-light-opt4060   |   66 +
> >>  drivers/iio/light/Kconfig                     |   13 +
> >>  drivers/iio/light/Makefile                    |    1 +
> >>  drivers/iio/light/opt4060.c                   | 1282 +++++++++++++++++
> >>  4 files changed, 1362 insertions(+)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
> >>  create mode 100644 drivers/iio/light/opt4060.c
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060 b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
> >> new file mode 100644
> >> index 000000000000..187e750602ee
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
> >> @@ -0,0 +1,66 @@
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw  
> > 
> > Huh... This is general ABI but not present in the sysfs-bus-iio
> > where it should be.  There are some control parameters on these channels
> > but not the actual channels.
> > 
> > Please add them there instead of in a device specific file.
> > Also group the 3 colors together as done for intensity_x, _y, _z
> >  
> 
> So you want me to add 4 lines for in_intensity_X_raw where X is red, green,
> blue and clear? Should I add those together with a description in the end of
> the file or some place where I find similar definitions? The closest I can
> find is in_intensityY_raw (line 1629 in the version of the file I'm looking at).
> I also can't find the entries for in_intensity_red/green/blue_scale? I can find
> in_intensity_x/y/z_scale but those were added in a commit for the as73211 driver
> and as far as I can understand from the driver, x, y and z are coordinates and

xyz are color spaces coordinates for CIE XYZ color space. Which admittedly gets
confusing when we use XYZ for index numbers in this file.

> not some kind of unknown variables in that context. I'm sorry for what I assume
> are really stupid questions, but I just don't get it...
No problem.  There are often no 'right' rules for this, just better and worse
options!
> 
> Basically I think I need to add the following 7 lines to the file:
> 
> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw
> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
> What:    /sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
> 
> Is that correct? Should the _raw ones be added in the groups starting on line 1629?
yes.
> Should the _scale ones be added to the group starting on line 469?
yes.
> 
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Unit-less raw value for red intensity.
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Decimal value for the red component of the light. The value
> >> +		is normalized to give the relative red component
> >> +		independently of the light intensity.  
> > 
> > I'm not sure I understand this text.   Also why Decimal?
> > Maybe something like:
> > 
> > "Scales the raw value so that for a particular test light source, typically
> > white, the measurement intensity is the same across different colour channels."
> >   
> 
> Your text is also not totally correct, but probably better. The parameters are
> first scaled the way you describe but then divided by the sum of the 3 RGB channels.
> This to give an estimate of the color ratio between the three color components
> independently of the light intensity. A decimal value between 1.0 and 0 will be
> returned. Is this the type of oddity that should be documented in an rst file, the
> way you described further down?
Hmm. A divide by the sum is unfortunate.  The only common case for this is
quarternions (where the 4 elements are normalized).

I suggest you don't divide through, just leave that for userspace to do
if it wishes.  Fine to document that procedure in an rst file though if you like.

> 
> >>  The raw value for red
> >> +		is multiplied by 2.4 before being normalized, this to adapt
> >> +		to the relative sensitivity of the red filter of the sensor.
> >> +		The factor for green is 1.0 and the factor for blue is 1.3.  
> > An unfortunately characteristic of the ABI docs is we can't have duplication so
> > once this is moved to the general docs this detail will have to go in favour
> > of generality.  You could add a little 'footnote' to the entry to say that
> > for this particular device the meaning is this.
> > 
> >   
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Unit-less raw value for green intensity.
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Decimal value for the green component of the light. The
> >> +		value is normalized to give the relative green component
> >> +		independently of the light intensity. The raw value for
> >> +		green is multiplied by 1.0 before being normalized, this to
> >> +		adapt to the relative sensitivity of the green filter of
> >> +		the sensor. The factor for red is 2.4 and the factor for
> >> +		blue is 1.3.
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Unit-less raw value for blue intensity.
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Decimal value for the blue component of the light. The
> >> +		value is normalized to give the relative blue component
> >> +		independently of the light intensity. The raw value for
> >> +		blue is multiplied by 1.3 before being normalized, this to
> >> +		adapt to the relative sensitivity of the blue filter of the
> >> +		sensor. The factor for red is 2.4 and the factor for green
> >> +		is 1.0.
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Unit-less raw value for clear intensity.
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_input  
> > This is already in the main ABI doc.   
> >> +KernelVersion:
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Lux value for the light illuminance. The value is
> >> +		calculated using the wide spectrum green channel and
> >> +		multiplied by 2.15e-3.  
> > It may be worth capturing these details in an rst file under 
> > Documentation/iio/  Just remember to add an entry in the index.rst file
> > there so that they get included in the docs buidl.
> >  
> 
> Ok, I can describe this in an rst file.

Great,

Sorry for slow reply. Things got a bit busy for a week or so!

Jonathan

>  
> ...


