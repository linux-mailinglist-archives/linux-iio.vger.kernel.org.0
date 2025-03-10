Return-Path: <linux-iio+bounces-16692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184DAA5A421
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489B9174D7F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1391DDC07;
	Mon, 10 Mar 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK+VKOo2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9A15B971;
	Mon, 10 Mar 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636467; cv=none; b=pC4ETbW+j66UiogfeYD3b0qOqr/KySoTKvf55ORZZATV6xJkHGNFYfPQUE9uZlFGB++i0x0KXIygmgYnzLouGmVc0YKk2ytPFmyW7NnLFaKzhORMSYb7mYvAYp7olELu8jbqsPn32SlHoDqsvXHp488D0v1IU/+l3uDJ7E0g0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636467; c=relaxed/simple;
	bh=uANpkvGWIIW8f12l9ro96UF9wCNNNS8RNQcHCqRYa4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdhJjoIWwKyI/1qYmNLWZz5aKs5aHD+Wh7BdEBVHi5l/3YxvhwPRBzgzJO0BcpvUWttBvTYBt2B2iUz54zp0NV6xuMraVIiW2aUVQpujoY4xlq/DJFtn2QY0mkC8L7Nq7gwsEbo2b/LQZXskMBECPAljXvvLsqt0mpl0ecW0XAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK+VKOo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9316C4CEE5;
	Mon, 10 Mar 2025 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741636466;
	bh=uANpkvGWIIW8f12l9ro96UF9wCNNNS8RNQcHCqRYa4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gK+VKOo2t8FNXGr4nlVu7RzA9znmlql3EoRVj1oyb7epfzk4q1vekyxYLbDH5u3GW
	 Rq8pzdsX9as9Y+3nwK4DY8w5cMbobyFOqJFmYw3UbmXbgKhf/n/RqdWNujT+wHDNbo
	 MeKqv/l0pcdKbBALman7fYiVYp1I1pz2hyMhM46NiHVXS8cYHV2phcrcUBVH1cYOvi
	 n3l2o2IO31VSF3QXGkqbT8Vn2+AKpheUduuEvdgkve+MKWU2latn2l1DO7nGwkLz8G
	 yqgCEGo7dPIaFyyhybEjxrAbeLt5sw5inxd1r+nsT2gRUzz9J6BncmsZ6ZrCC9AH+p
	 W2SvYOC3k93xQ==
Date: Mon, 10 Mar 2025 19:54:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Message-ID: <20250310195416.6d8c64f2@jic23-huawei>
In-Reply-To: <e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
	<20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
	<CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
	<e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Mar 2025 21:49:24 +0100
Jorge Marques <gastmaier@gmail.com> wrote:

> > > +.. list-table:: Driver attributes
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Description
> > > +   * - ``in_voltage0_raw``
> > > +     - Raw ADC voltage value
> > > +   * - ``in_voltage0_oversampling_ratio``
> > > +     - Enable the device's burst averaging mode to over sample using
> > > +       the internal sample rate.
> > > +   * - ``in_voltage0_oversampling_ratio_available``
> > > +     - List of available oversampling values. Value 0 disable the bu=
rst
> > > +       averaging mode.
> > > +   * - ``sample_rate``
> > > +     - Device internal sample rate used in the burst averaging mode.
> > > +   * - ``sample_rate_available``
> > > +     - List of available sample rates. =20
> >=20
> > Why not using the standard sampling_frequency[_available] attributes? =
=20
> Because sampling_frequency is the sampling frequency for the pwm trigger
> during buffer readings.
> sample_rate is the internal device clock used during monitor and burst
> averaging modes.

For an ABI that is very vague and the two use cases seem to be logically
quite different.

Seems that for each trigger we have an oversampling ratio controlled number
of samples at this rate. It is unusual to be able to control oversampling
rate separately from the trigger clock, hence the lack of ABI.  If
we add something new for this it should something relating to oversampling.
oversampling_frequency perhaps.

For monitor mode, it is tied to the sampling frequency for most devices.
But there are exceptions.  E.g. the max1363. Trick is to make it an event
ABI property and hence under events/ rather than in the root directory.

In this case you'll have to store two values and write the appropriate
one into the register to suit a given operating mode.


>=20
> > > +
> > > +Threshold events
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +The ADC supports a monitoring mode to raise threshold events.
> > > +The driver supports a single interrupt for both rising and falling
> > > +readings.
> > > +
> > > +During monitor mode, the device is busy since other transactions
> > > +require to put the device in configuration mode first. =20
> >=20
> > This isn't so clear to me. Is this saying that events do not work
> > while doing a buffered read? Do you need to do need to read the
> > in_voltage0_raw input to trigger an event?
> >  =20
> No, the device monitor mode and trigger mode autonomously samples using t=
he
> internal clock set with the sample rate property.
> I rephrased that to:
>=20
>  The feature is enabled/disabled by setting ``thresh_either_en``.
>  During monitor mode, the device continuously operate in autonomous mode =
until
>  put back in configuration mode, due to this, the device returns busy unt=
il the
>  feature is disabled.
>=20
> The reasoning is that during configuration mode no ADC
> conversion is done, including if the previous mode was autonomous.
> If instead of return busy the driver hided this and resumed monitor mode
> after the access, a hidden (to the user) monitoring down-time would and
> thresholds crossings could be lost, undermining the feature.

hmm. This is a trade off between usability and precise matching of expectat=
ions.
=46rom your description does monitor mode only trigger if the threshold is
crossed or is it a level comparison?  If it's level I'd consider the
option of brief disabling.  Unlikely to be a problem interrupting things
in vast majority of usecases. Documentation can then express this issue.

>=20
> > > +SPI offload support
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +To be able to achieve the maximum sample rate, the driver can be use=
d with the
> > > +`AXI SPI Engine`_ to provide SPI offload support.
> > > +
> > > +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/a=
d4052_ardz/index.html =20
> >=20
> > This diagram show a PWM connected to the CNV pin on the ADC, but I
> > didn't see a pwms property in the DT bindings to describe this.
> >  =20
> It is not clear to me where the pwm property should be in the DT
> bindings, since the PWM node now belongs to the offload-capable SPI contr=
oller.
>=20
> > I didn't have time to read the full datasheet or look at the driver
> > code yet, but can do that next week. =20
> Ok, thank you for the review
>=20
> Jorge


