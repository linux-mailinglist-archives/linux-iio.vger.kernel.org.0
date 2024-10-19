Return-Path: <linux-iio+bounces-10800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E7B9A4F11
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 17:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256291F21B87
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E91E7DA62;
	Sat, 19 Oct 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4U4fHrf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6E26AFB;
	Sat, 19 Oct 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729351186; cv=none; b=NRuffgh3862bs5xSKMtZ3821bwm6cGazeFMEZVvjLAG+7OjhVbbe1Chd+69BCgdOqXNz1qpnMhPJYoeSJYREr8hVR1Srjjf0PYFjuqz6GkI2zKbRQDIczhywDClHVCGe+TDQkK+pBil0bcZKskBfSH1gYVsy5iUmcDJF0x75KVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729351186; c=relaxed/simple;
	bh=n38Cn7znuna16E9x6S68VuKzbnu4jWCKLsCooMGMjmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idFFmKkVCdCp9PFkR+sV9EeynrEDerhF3vsKrISYVpYebzJ55Xgd+H9WiS9TQGMWn7ZN8wl8CXgMBN6875WV4YwWJfw26OtZ1wvVHfG7ZWkslcm08qhOMXY0Rv05pTPegbmx7lIy2ErfH5ygS5nbKtn95Z9Uy+sUDngifmJDphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4U4fHrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E10BC4CEC5;
	Sat, 19 Oct 2024 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729351185;
	bh=n38Cn7znuna16E9x6S68VuKzbnu4jWCKLsCooMGMjmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4U4fHrf4MFpP4Woru/os5HbLA69o9+QmbFzJ7tmdE+fmbG3P++XFfjjmTFUc4XQn
	 kzZICvSswx0W955NrJIGyYmhTzeCqDfEyoNJh231/9rDejVrrN5SP9OVW+vv7gcLPl
	 vi3wPjFmC2kjErNA90DCbEz0fSXegoci9mvaonBvusQkAnCNRCKVDHtttkqbatixlW
	 dAvMBOhaTznpEPXMKYAK7KcA7KKMSfOI1lL+RC+XguO1+t3i45KJJMLHlzoqoEd+9T
	 Ok2CmBmxlqK8y57GC0cM7zqMeEP394I99kbSu7YDYkMWUQbqXfU9kTUarOWxj3C/cl
	 ncwe3Rr4Qk4tA==
Date: Sat, 19 Oct 2024 16:18:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: add high-speed platform
 driver
Message-ID: <20241019161855.32078709@jic23-huawei>
In-Reply-To: <61cf3072af74a8b2951c948ddc2383ba1e55954d.camel@gmail.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-7-eeef0c1e0e56@baylibre.com>
	<c3d55f78-5a54-49f8-b6a1-4ed0f24f8666@baylibre.com>
	<8642bdb546c6046e8fe1d20ef4c93e70c95c6f71.camel@gmail.com>
	<2815c8b0-e2ad-47cb-b5aa-00297cf57899@baylibre.com>
	<781cf5fa075e13260e1b20f5acadb70bd8107cd0.camel@gmail.com>
	<23dafe91-2733-4ed6-901a-d324749d11b2@baylibre.com>
	<61cf3072af74a8b2951c948ddc2383ba1e55954d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > >  =20
> > > >=20
> > > > Re: the other recent discussions about getting too many
> > > > callbacks. Instead of a dedicated function like this, we
> > > > could make a set of generic functions:
> > > >=20
> > > > iio_backend_{g,s}et_property_{s,u}(8, 16, 32, 64}()
> > > >  =20
> > >=20
> > > Hmm interesting approach. I don't dislike it. Kind of a generic gette=
r/setter
> > > thingy.
> > > We could then still have optional inline helpers that would call the =
generic
> > > functions with the proper enum value.
> > >  =20
> > > > that take an enum parameter for the property. This way,
> > > > for each new property, we just have to add an enum member
> > > > instead of creating a get/set callback pair.
> > > >=20
> > > > Unrelated to this particular case, but taking the idea even
> > > > farther, we could also do the same with enable/disable
> > > > functions. We talked before about cutting the number of
> > > > callbacks in half by using a bool parameter instead of
> > > > separate enable/disable callbacks. But we could cut it down
> > > > even more by having an enum parameter for the thing we are
> > > > enabling/disabling. =20
> > >=20
> > > If we don't get too strict about types it could even fall into the ab=
ove u8
> > > category.
> > >=20
> > > Instead of lot of new simple ops we just grow an enum. =20
> >=20
> > Sure. For that matter, maybe try to just stick with 32-bit
> > for everything to keep it simple. Probably will eventually
> > need 64-bit for some things, but might be able to get away
> > with avoiding 8 and 16-bit.
> >  =20
>=20
> Agreed. Anyways, nothing that I will take care in the near future (I woul=
d first like
> for things to stabilize a bit). That said, if you want (or anybody else),=
 feel free
> to send the patches :)

Definitely don't do the many size versions.  Large signed integers
are nice and flexible. Maybe just go s64 from the start.

Jonathan

>=20
> - Nuno S=C3=A1
>=20


