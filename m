Return-Path: <linux-iio+bounces-4649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93668B62E3
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 21:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FCB1C21AD6
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725A12D203;
	Mon, 29 Apr 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptk09T5/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10512B14F;
	Mon, 29 Apr 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420277; cv=none; b=ZUzzP9xDVPVK/7BtLgPCGxtMBXJXJ/EVhZAWMTiftyQDERPfgvUIUWp5firnbZ+ZqJCgj7LVFxkCeoIdcnPOkAl/Xljtaaz5jhvunWVolUm2GbNCi4Z/nt9WnYcf8stT4DEwNlmM9n96aVo2t3FrjNbMLNRVQehZkqmSVsAMs80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420277; c=relaxed/simple;
	bh=uxUkF45id5GJmcE+d0fHhd0Guc9UjGrm+AtJEcYumRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPu1D8mJKtSYY6Rr69DNo9KW9CTce7uU7Yop3cCr+TVH/tJt8toxAGKgG9T/x9Hjc1j0BCH9wfF2w7JQNYKPeUT9uWaeo8y+N5IrMElugROxK7DjJmh1EYeW2rZ4e+JBD7U1hw7F9JVB177TnyQ2oVF0+PiPVwtZZm+VCq56cnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptk09T5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5C2C113CD;
	Mon, 29 Apr 2024 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714420276;
	bh=uxUkF45id5GJmcE+d0fHhd0Guc9UjGrm+AtJEcYumRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ptk09T5/T0t8lmkNOomvMoUenRWjQrKLzd91yCy4ZDU8CEw0WzzMrqb78dC4JAw8m
	 KLiXu6nocqF/yjW3mQs1xNsbdOtqMWpfiVUOVWELZsIewAys3ANBsPE5RA2MLEoNdH
	 BB+wFxEwFNdua/Nic5330BwU5k3B2C8T+MzBipR+ulNjpMgFyIPWCZGCXZF2Tj4XEe
	 AbbzxAtDBjVBfhYOip1Jrvlb63nmzkqufVAvsmhuvhBVcNUIRusrE0mE+BYnjBbLiS
	 Z/LqS5o2GVq+3Zg6HlURcKDheCSAYqYCquWx0MpuFPZX0xjBe6HwTY99J5OYNMDORZ
	 sNG6DYU9qVoMQ==
Date: Mon, 29 Apr 2024 20:51:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 7/7] iio: adc: ad9467: support digital interface
 calibration
Message-ID: <20240429205103.69d5388b@jic23-huawei>
In-Reply-To: <b988e9b88eb7589ed38a5f50a2b1ad10007fa1ce.camel@gmail.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
	<20240426-ad9467-new-features-v2-7-6361fc3ba1cc@analog.com>
	<20240428183231.644857bd@jic23-huawei>
	<b988e9b88eb7589ed38a5f50a2b1ad10007fa1ce.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Apr 2024 09:24:21 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2024-04-28 at 18:32 +0100, Jonathan Cameron wrote:
> > On Fri, 26 Apr 2024 17:42:16 +0200
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > To make sure that we have the best timings on the serial data interfa=
ce
> > > we should calibrate it. This means going through the device supported
> > > values and see for which ones we get a successful result. To do that,=
 we
> > > use a prbs test pattern both in the IIO backend and in the frontend
> > > devices. Then for each of the test points we see if there are any
> > > errors. Note that the backend is responsible to look for those errors.
> > >=20
> > > As calibrating the interface also requires that the data format is di=
sabled
> > > (the one thing being done in ad9467_setup()), ad9467_setup() was remo=
ved
> > > and configuring the data fomat is now part of the calibration process.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> >=20
> > One trivial comment.
> >=20
> > I'd have picked up the whole series, but it feels too big to do on a Su=
nday
> > when you only posted on Friday.=C2=A0 Hence, lets let it sit for at lea=
st
> > a few more days to see if others have comments. =20
>=20
> Yeah, I kind of waited till the last moment to see if you had any importa=
nt
> comment (on the first version open discussions) that could affect v2 :).
> >=20
> > It might not make this cycle as a result.=C2=A0=C2=A0 I've picked up th=
e 2 fixes
> > today to increase the chances those make it.
> >=20
> > Jonathan
> >=20
> >  =20
> > > =C2=A0static int ad9467_read_raw(struct iio_dev *indio_dev,
> > > =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > > =C2=A0			=C2=A0=C2=A0 int *val, int *val2, long m)
> > > @@ -345,7 +606,9 @@ static int ad9467_write_raw(struct iio_dev *indio=
_dev,
> > > =C2=A0{
> > > =C2=A0	struct ad9467_state *st =3D iio_priv(indio_dev);
> > > =C2=A0	const struct ad9467_chip_info *info =3D st->info;
> > > +	unsigned long sample_rate;
> > > =C2=A0	long r_clk;
> > > +	int ret;
> > > =C2=A0
> > > =C2=A0	switch (mask) {
> > > =C2=A0	case IIO_CHAN_INFO_SCALE:
> > > @@ -358,7 +621,23 @@ static int ad9467_write_raw(struct iio_dev *indi=
o_dev,
> > > =C2=A0			return -EINVAL;
> > > =C2=A0		}
> > > =C2=A0
> > > -		return clk_set_rate(st->clk, r_clk);
> > > +		sample_rate =3D clk_get_rate(st->clk);
> > > +		/*
> > > +		 * clk_set_rate() would also do this but since we would
> > > still
> > > +		 * need it for avoiding an unnecessary calibration, do it
> > > now.
> > > +		 */
> > > +		if (sample_rate =3D=3D r_clk)
> > > +			return 0;
> > > +
> > > +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > > +			ret =3D clk_set_rate(st->clk, r_clk);
> > > +			if (ret)
> > > +				return ret;
> > > +
> > > +			guard(mutex)(&st->lock);
> > > +			ret =3D ad9467_calibrate(st); =20
> > 			return ad9467_calibrate(st); =20
> > > +		} =20
> > 		unreachable();
> >=20
> > not totally elegant but I think the early return makes more sense and we
> > should
> > just use an unreachable() to squash the resulting compiler warning.
> >  =20
>=20
> As you might remember I'm not a big fan of the unreachable() but also no =
strong
> feelings about it :). Do you expect a v3 for this or is this something yo=
u can
> fix up while applying (assuming no other things pop by)?=20

I changed my mind and didn't bother adjusting this.

I've queued this up and pushed it out as testing on basis I can always drop
it again if reviews come in within the next 2-3 days, but in meantime I can
let 0-day have at it.

Jonathan

>=20
> - Nuno S=C3=A1
> >  =20


