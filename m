Return-Path: <linux-iio+bounces-13243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC389E872E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB34B1648BE
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A5158862;
	Sun,  8 Dec 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYwD5WdL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B54690;
	Sun,  8 Dec 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681106; cv=none; b=rVbAyuuLUP/oFLVt8TDx3WbShG2yeaGcZfCOkRwDkgxumiz76r87nLDN/ft5F2oVsYh5ZuYC5FAvI6eVPxmkTiDGSVOgs/oQD/j8V4bH+IHeuG/6QS9hg1bYEp+HblHiPlOsj+C1FoC4W6wTnkkZjJFYiKoPgsHJaus0RTrx/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681106; c=relaxed/simple;
	bh=dCUHW7JoJsw+WsUdPX4UiJ+l0r2TQrtjo0bPPRvnEIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCr/SjlL+/afD7tD2L94x1rIzeCOaaCBqfXZ2mwfPcbjiOrPLWoZQ8MiRBdWadvvUcrQpI1F54tkpO4twuKhb2X8WGNTijCniL+6t5Ym8N2oDc3F2rXigHm4FA5mgpJ1IKGE/De4m233EUbmoAyf2u8BKceqB7QjD/9KCXzteR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYwD5WdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12366C4CED2;
	Sun,  8 Dec 2024 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733681106;
	bh=dCUHW7JoJsw+WsUdPX4UiJ+l0r2TQrtjo0bPPRvnEIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HYwD5WdLAoT+4/DAqLBJt8XmRd8V2IxbpPcq2e7T2d+rPhM9EwbmA8JwMBNirRhBF
	 UdR3MsXCe0sQEN5wbUdKzxIep+2bufvEvDW+nywWSLhHH6GeKLyzHWtX9zD38K2FAK
	 npsXAiXtskbuNedb9CXmfu1lr3nIdfyFh+QN/sJX8BYunKa5f2aFJ0BgJqwaVvFfAb
	 1XAg3RceJ/o3/VSyHeXRF8OXCxHmdPkT7eDq1nLtXadMAoNohKMOec1totvkac2sim
	 0kQmNa1l6DC4Khgjx4TVGAxhWXVoEKzj/5ke87t49cUexvt2ywihKyNjXnQs9jvu94
	 x7KwqEgl4wDMw==
Date: Sun, 8 Dec 2024 18:04:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de, Guillaume Ranquet
 <granquet@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 1/1] Documentation: ABI: IIO: Re-add
 filter_type/filter_mode
Message-ID: <20241208180457.11c01806@jic23-huawei>
In-Reply-To: <Z073UvHZToWl88f9@debian-BULLSEYE-live-builder-AMD64>
References: <b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com>
	<52513d34-8484-4c4b-8f87-29cbbdcefc06@baylibre.com>
	<Z073UvHZToWl88f9@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 09:19:30 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/02, David Lechner wrote:
> > On 12/2/24 12:22 PM, Marcelo Schmitt wrote:  
> > > The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
> > > in_voltage-voltage_filter_mode_available attributes to user space.
> > > The ad7779 driver exports filter_type and filter_type_available.
> > > Add (back again) documentation for filter_type/filter_mode attributes.
> > > 
> > > Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Digressing a bit away from the specific ABI used by ad4130 and ad7779,
> > > the sinc3/4/5 filters are called `filter_mode` in ad4130 driver while other
> > > drivers (ad7779, ad7124, ad7768-1) call sinc3/4/5 filters a `filter_type`.
> > > Datasheets use the term `filter type`.
> > > 
> > > Depending on the particular ADC chip/design, the sinc3/4/5 filter configuration
> > > may have an impact on the output data rate (ODR) (which is equivalent to the
> > > sampling frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff
> > > frequency of the filter (`_low_pass_3db_frequency` attributes), or settling
> > > time.
> > > 
> > > ad7768-1 sets sinc3/4/5 according to the sampling_frequency attribute. No
> > > filter_type attribute.
> > > 
> > > ad7173 sets the filter_type according to sampling_frequency too, though it
> > > looks like support for only one filter type is implemented.
> > > 
> > > ad7124 sets sinc3/4/5 filters according to a filter_low_pass_3db_frequency
> > > attribute so it doesn't export filter type attributes to user space.
> > > Missing `in_voltageY-voltageZ_filter_low_pass_3db_frequency` documentation?
> > > follow up patch?  
> > 
> > cc: Guillaume and Uwe since they are working on these last two drivers
> > currently. Maybe something they could address?
> >   
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index f83bd6829285..704c9033cb5b 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -2268,6 +2268,20 @@ Description:
> > >  		An example format is 16-bytes, 2-digits-per-byte, HEX-string
> > >  		representing the sensor unique ID number.
> > >  
> > > +What:		/sys/bus/iio/devices/iio:deviceX/filter_type
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> > > +voltageY_filter_type_available
> > > +KernelVersion:	6.1
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Set the filter mode of the channel. When the filter mode
> > > +		changes, the in_voltageY-voltageZ_sampling_frequency and
> > > +		in_voltageY-voltageZ_sampling_frequency_available attributes
> > > +		might also change to accommodate the new filter mode.
> > > +		If the current sampling frequency is out of range for the new
> > > +		filter mode, the sampling frequency will be changed to the
> > > +		closest valid one.  
> > 
> > I think it can be safely assumed that changing any IIO attribute can
> > cause any other to change, so we probably don't need to mention the
> > sampling frequency interaction here, especially since it doesn't apply
> > to every possible user of these attributes.  
> 
> Besides these filter attributes, the _offset attribute was allowed to change
> after a change in _scale for a different driver so I'm also thinking IIO
> attribute changes are allowed to cause updates to other device attributes.

They are.  There is no practical way to design an ABI where that doesn't
happen unfortunately. We try to keep the changes as intuitive as possible
(so don't change unless we have to, find nearest value etc) where it is
reasonably easy to do.


> The description above is roughly the same that was removed in 01bb12922b60.
> Can think of something more accurate if that would be appreciated.
> 
> Jonathan, let me know if you prefer to re-add ABI doc as it was or if we
> can re-add an updated version of it.
I'm fine with updating in the same patch.

> 
> > 
> > Some other useful things to add instead:
> > * Mention that the values are the same as the ones listed in the
> >   "..._available" attribute docs.  
> Sure, will do if going to update the ABI description.
> 
> > * We should deprecate one of the names and recommend the other for
> >   future drivers to use. Since "type" is used more than once and
> >   "mode" only once, it seems natural to keep using "type" going
> >   forward.  
> Agree.

If mode is only used once, perhaps move it to a driver specific file?
Fine to cross reference to the main file from there.

Jonathan

> 
> >   
> > > +
> > >  What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> > >  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> > >  KernelVersion:	6.1
> > >   


