Return-Path: <linux-iio+bounces-14186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0696CA0A90A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037EB1661F8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5031B0F36;
	Sun, 12 Jan 2025 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB4ppEoz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F442A1B2;
	Sun, 12 Jan 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684458; cv=none; b=If8CYNTwB5itMm7cQeriGMPVOxJkBmSj1f2M7ypJnimIRZTwKJaPbiYEKPIohfth8iQ4WmEBlTtg/upBC3YXIkFS0pWVfJH/SOR7dSdFgCzbO2ONWEUD2OD0B+BAcOlg4U4ovAYePvBsTzlULlj431u6ghwb96JUT8kJkp0IwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684458; c=relaxed/simple;
	bh=op/9zIUF5tYmNVE5XwFVyNhTb7m8mZ98vMCGcvlhJ80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tM7CwpXOGRUVBddKikyJcOWMlGz+DWxJ4PPQIVFKwAl1xpJu3MNmzM2Q7D1e54u/s/fS/XtiIqdbHzAB583cl9BH2l0+nrSriRFHuSg9Ii3xjO0Ni1GjOCR239baEVQjvonXahXkr4sMUFmtL4KwmbPyLIHukTFLCFyUc3Vjh7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB4ppEoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C4C4CEDF;
	Sun, 12 Jan 2025 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684457;
	bh=op/9zIUF5tYmNVE5XwFVyNhTb7m8mZ98vMCGcvlhJ80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KB4ppEoz+mxj/iBGrXsHkUaJnMn3Bz6bpAQILNyHNyeTGM5cocJH2S+lLXfQpmAAw
	 0B0UvnDKsR28DJ17AILc8R1jIxxSdpR+xjlIvt1cmHQV2h4EtnLuR/Sg+6auOE8VmO
	 Ydj0FK1eY07QHSodblLcHinJlEwJhJ3ddZAiXbVD/mhgp+i3cGx+SEnz6YUqONGrOz
	 jdZ1xK24ITZqT4Re/X3YDX9aAKN95Chi80iDwWQUYcuExLY9fNs0FvuSiJi9SBv3Yu
	 bXyYZ3ZoFRxPoLsUA5UXAKFWOk3jTIaWdE8EUoeL8J4+rUANVr3nO9OgmLBk6srpM0
	 V6ZwfslCdba2g==
Date: Sun, 12 Jan 2025 12:20:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 58ea1899-05be-4743-911b-77a56f08c347@baylibre.com, David Lechner
 <dlechner@baylibre.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 03/15] Documentation: ABI: testing: ad7768-1: Add
 device specific ABI documentation.
Message-ID: <20250112122047.1e1978e0@jic23-huawei>
In-Reply-To: <Z4L9PKKNfonI/4E2@JSANTO12-L01.ad.analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<f78c3dee381b23c17787f1e2bc9c5667741d407b.1736201898.git.Jonathan.Santos@analog.com>
	<58ea1899-05be-4743-911b-77a56f08c347@baylibre.com>
	<Z4L9PKKNfonI/4E2@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Jan 2025 20:22:36 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 01/07, David Lechner wrote:
> > On 1/7/25 9:24 AM, Jonathan Santos wrote: =20
> > > Add ABI documentation specific to the ad7768-1 device, detailing
> > > the decimation_rate attribute for better clarity and usability.
> > >=20
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > >  .../ABI/testing/sysfs-bus-iio-adc-ad7768-1          | 13 +++++++++++=
++
> > >  1 file changed, 13 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad776=
8-1
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1 b/D=
ocumentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > > new file mode 100644
> > > index 000000000000..065247f07cfb
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > > @@ -0,0 +1,13 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate_available
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Reading returns a range of possible decimation rate values.
> > > +
> > > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Sets up the decimation rate for the digital filter. This can
> > > +		directly impact in the final sampling frequency. Reading returns
> > > +		the decimation rate. Writing sets the decimation rate. =20
> >=20
> > If this only affects the filter, I would suggest to add `filter_` to the
> > beginning of the attribute names.
> >=20
> > Also, an explanation of how to interpret the numbers would be helpful. =
It looks
> > like a unitless number that acts a sort of a multiplier or divider, but=
 that
> > part isn't so clear to me.=20
> >=20
> > Or...
> >=20
> > Since the decimation rate affects the -3dB point of the filters we coul=
d use
> > the standard IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY instead of int=
roducing
> > a new attribute. =20
>=20
> Well, here the -3dB cutoff depends on the ODR, which is determined by bot=
h the MCLK
> divider and decimation rate.
>=20
> Wideband: -3dB at 0.433 =C3=97 ODR
> Sinc5: -3dB at 0.204 =C3=97 ODR
> Sinc3: -3dB at 0.2617 =C3=97 ODR
>=20
> If we use _filter_low_pass_3db_frequency to control the decimation and _s=
ampling_frequency
> to control the MCLK divider, wouldn=E2=80=99t it be confusing for one to =
always affect the other?
> A different ODR would result in a different cutoff, and vice versa.

We should definitely not have a filter control changing sampling frequency =
(which tends to
be a more common control for users to fiddle with).  However the other way =
around is
fine.  So for a given _sampling_frequency present via
in_xx_filter_low_pass_3db_frequency_available the list of
possible 3db frequencies and use them to configure the decimation.

>=20
> Would something like <type>[_name]_oversampling_ratio make more sense? Le=
t me know what you think

I'd rather not if we can avoid that new ABI, but it is is better than a new=
 term
like decimation_rate.

Jonathan

>=20


