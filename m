Return-Path: <linux-iio+bounces-14204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC41DA0A96D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC42D7A358A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B9F1B4244;
	Sun, 12 Jan 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg0DMTUO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF741B412C;
	Sun, 12 Jan 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736687432; cv=none; b=eVgtCK1c5eSMdlmi3Lx62jOaQMq17Rzf+EKNmeybfagadxQ3KtTI/AKavWV/3tfuV0hAXQXG2Tw5uZaYx2Msqu3PFzCX/xO9t/FUxPvpj31QGts804H0mefBH/qdgvDs2e0OjbXdYm+AXrJy6GYtG0GVr6A3hWzV0QZhpICMGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736687432; c=relaxed/simple;
	bh=ysjZ5IJlw7eJ62zdCOogSMFUW49AmFyKgZVlZj8mgc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHgwjvkJ1fe2e6j9Dg36U8dgx7UqUAIzZN8/sAra1FgpXs4br2EBRqomQ5qCL0lruJ+CASywx5PY0N3/1P4fPdB+ruvrMqHI+OytaY5ZcNwSOi/y86byvR7fAoVPQOVcu6PinyJC6xuuMHJBTMMuiCqo3E0tt4tP/YxsiGyE1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg0DMTUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3DAC4CEDF;
	Sun, 12 Jan 2025 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736687431;
	bh=ysjZ5IJlw7eJ62zdCOogSMFUW49AmFyKgZVlZj8mgc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kg0DMTUOcJsmx33Vj15AoDuuEoyrHGJuf5eia6N6jYBkmRFqmUDp7tZ5RzUiwX5xD
	 +hXQWnPvlXx9Izr3+CuWNMbB9cLoXoruJOl1j5zxLzTqk2ENoo4UzwdS5Hbd6atWnI
	 BkbT+brYpLHQsAqaj8EcBHm1A/wKAoIN28E9xOzyKX4hfmb+I7s9DhQtd1JArEiCoL
	 IB0xH5A1Xn5rf4B+4ZfvqyqBYDHwFEBtZPngEsysR3xtBy840HN3yJNYDAg75wuPj0
	 CPpldolfILE+iMotGgH0rD6MG6wH07mSmGgRNufhQTReTn5x0XHF5PWUqPWiUV97+c
	 ICLRamMpOwf5w==
Date: Sun, 12 Jan 2025 13:10:21 +0000
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
Message-ID: <20250112131021.5601aaea@jic23-huawei>
In-Reply-To: <20250112122047.1e1978e0@jic23-huawei>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<f78c3dee381b23c17787f1e2bc9c5667741d407b.1736201898.git.Jonathan.Santos@analog.com>
	<58ea1899-05be-4743-911b-77a56f08c347@baylibre.com>
	<Z4L9PKKNfonI/4E2@JSANTO12-L01.ad.analog.com>
	<20250112122047.1e1978e0@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 12 Jan 2025 12:20:47 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 11 Jan 2025 20:22:36 -0300
> Jonathan Santos <jonath4nns@gmail.com> wrote:
>=20
> > On 01/07, David Lechner wrote: =20
> > > On 1/7/25 9:24 AM, Jonathan Santos wrote:   =20
> > > > Add ABI documentation specific to the ad7768-1 device, detailing
> > > > the decimation_rate attribute for better clarity and usability.
> > > >=20
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-bus-iio-adc-ad7768-1          | 13 +++++++++=
++++
> > > >  1 file changed, 13 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7=
768-1
> > > >=20
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1 b=
/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > > > new file mode 100644
> > > > index 000000000000..065247f07cfb
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > > > @@ -0,0 +1,13 @@
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate_available
> > > > +KernelVersion:
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Reading returns a range of possible decimation rate values.
> > > > +
> > > > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate
> > > > +KernelVersion:
> > > > +Contact:	linux-iio@vger.kernel.org
> > > > +Description:
> > > > +		Sets up the decimation rate for the digital filter. This can
> > > > +		directly impact in the final sampling frequency. Reading returns
> > > > +		the decimation rate. Writing sets the decimation rate.   =20
> > >=20
> > > If this only affects the filter, I would suggest to add `filter_` to =
the
> > > beginning of the attribute names.
> > >=20
> > > Also, an explanation of how to interpret the numbers would be helpful=
. It looks
> > > like a unitless number that acts a sort of a multiplier or divider, b=
ut that
> > > part isn't so clear to me.=20
> > >=20
> > > Or...
> > >=20
> > > Since the decimation rate affects the -3dB point of the filters we co=
uld use
> > > the standard IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY instead of i=
ntroducing
> > > a new attribute.   =20
> >=20
> > Well, here the -3dB cutoff depends on the ODR, which is determined by b=
oth the MCLK
> > divider and decimation rate.
> >=20
> > Wideband: -3dB at 0.433 =C3=97 ODR
> > Sinc5: -3dB at 0.204 =C3=97 ODR
> > Sinc3: -3dB at 0.2617 =C3=97 ODR
> >=20
> > If we use _filter_low_pass_3db_frequency to control the decimation and =
_sampling_frequency
> > to control the MCLK divider, wouldn=E2=80=99t it be confusing for one t=
o always affect the other?
> > A different ODR would result in a different cutoff, and vice versa. =20
>=20
> We should definitely not have a filter control changing sampling frequenc=
y (which tends to
> be a more common control for users to fiddle with).  However the other wa=
y around is
> fine.  So for a given _sampling_frequency present via
> in_xx_filter_low_pass_3db_frequency_available the list of
> possible 3db frequencies and use them to configure the decimation.
>=20
> >=20
> > Would something like <type>[_name]_oversampling_ratio make more sense? =
Let me know what you think =20
>=20
> I'd rather not if we can avoid that new ABI, but it is is better than a n=
ew term
> like decimation_rate.
Reading the code I realised I'd misunderstood this question.
Yes for controlling decimation via oversampling.  Decimation (to me at leas=
t)
means 'ignoring' data but seems here it means averaging it.

Controls should be in order of preference
sampling_frequency (try to keep this constant as others chagnes - if you ha=
ve to because of range issues,
  tweak it) This is the rate we get data at after filter.
oversampling_ratio (again try to keep constant) - controls samples taken pe=
r output one.
_3db_frequency - anything left to control on the filter, or just a RO outpu=
t of what it currently means.

Jonathan



>=20
> Jonathan
>=20
> >  =20
>=20
>=20


