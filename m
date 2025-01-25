Return-Path: <linux-iio+bounces-14560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD5A1C2F7
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D478E1694A9
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9281E7C2F;
	Sat, 25 Jan 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmkHrxQ9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1ED192B74;
	Sat, 25 Jan 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737805751; cv=none; b=hnSxO6N+8wmLNYHikAGl9XDA+yL9bZdac6rkzCjXZpYPRLtm6WeVmtFV/7eFjkLp6/0AtBEWU2NJ4LUcJ4Az3kLbegPzGG7D6ZyEzJaM3HPfH5P61C975p/NsPLM4oCEzqvVJ5kXaoMSBvltDEdoYynm+Y2BRXFdtkCG3I0ytno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737805751; c=relaxed/simple;
	bh=yCUeazd3g4B/ikkT6nfgnGUjC9G5Zv1g5PeBuFQcBBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv2ko031vTH7/1UYD+6AHybC+k0LohhvmcDv3n/N1RRt/lL8Io3vYPIcrCZcK4G1Yy9g81eIvD4qGXX1zl+pRtx40J308YLejnV+TIE/enTLYlskkfpDd+K4k9i8IvFlllhfQCVeEWn4Erk/AkesuXqWzWFMvpWQTXiF8DvLtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmkHrxQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8449EC4CED6;
	Sat, 25 Jan 2025 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737805750;
	bh=yCUeazd3g4B/ikkT6nfgnGUjC9G5Zv1g5PeBuFQcBBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmkHrxQ9ml+c3HVmDPgTBaRmZm7pjTq/l+EEuQ3uEEljDhkDFRTHtD3XC2VkFW7l5
	 xpe7bzXHsmBpWDY2SyIoey6gpdsMhPKtHxS1/t5MaWxgs7WypfJ/gBVi0Q1W/1NGWX
	 fBMhYWqo6TP20AnTVVxEscA0XU/0UsfAN7gKLGKl4lL6a6b8wsRfigeFe1XOXqDV34
	 mr1ISeJmSYfjOey9jtBMk8c+vQpwS8TFaZ1LGdFANNfXLPDhaMa/IpPyYznpbATRU/
	 W8QNo1TbXoq4HWmbgN8YCcAs7NIr0b/jjyVsj7pDFPbUgxd6SIWHqHLVByIYVVD2+C
	 hOFbHK99DhiSQ==
Date: Sat, 25 Jan 2025 11:49:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Philipp Jungkamp <philipp@jungkamp.dev>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
 "ribalda@chromium.org"	 <ribalda@chromium.org>, "mpearson-lenovo@squebb.ca"
 <mpearson-lenovo@squebb.ca>, "jikos@kernel.org" <jikos@kernel.org>,
 "linux-input@vger.kernel.org"  <linux-input@vger.kernel.org>,
 "Jonathan.Cameron@huawei.com"  <Jonathan.Cameron@huawei.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org" 
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org" 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple
 channels
Message-ID: <20250125114900.4ed8621f@jic23-huawei>
In-Reply-To: <8a77584accb194c2bb1553cf07611211ea864c67.camel@jungkamp.dev>
References: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org>
	<20241219171718.2af17d6d@jic23-huawei>
	<CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
	<45ae61a978e7d4ea34502604a6d508f14c29303b.camel@intel.com>
	<TYZPR03MB599406F8035E6322E6B66CBFBD1F2@TYZPR03MB5994.apcprd03.prod.outlook.com>
	<8fed2747-c419-454a-bb72-43f158b4f081@app.fastmail.com>
	<ae3c8b20a3de94e67a9679ff4bf2b672f8c9b66a.camel@intel.com>
	<8a77584accb194c2bb1553cf07611211ea864c67.camel@jungkamp.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 14:55:07 +0100
Philipp Jungkamp <philipp@jungkamp.dev> wrote:

> Hello,
>=20
> that LISS sensor was from a patch that I had introduced. It's not
> connected officially to Lenovo.
>=20
> It's a HPD HID sensor on the Lenovo Yoga 9 14IAP7 that exports binary
> values on the human presence HID usage that is monitored by
> hid-sensor-prox.
>=20
> I had tried to get it working with iio-sensor-proxy to expose it over
> dbus and use it in e.g. a GNOME shell extension to lock the screen when
> there is no human presence detected. But my MRs were never merged and
> due to private struggles I lost interest in pushing them further.
>=20
> https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/3=
64
> https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/3=
64
>=20
> Regards,
> Philipp Jungkamp
Thanks Philipp,

So my impression is no one (other than you!) will notice the ABI change.

I'll queue the patch for after the merge window.  That means
there is still time to shout if anyone disagrees!

Jonathan

>=20
>=20
> On Mon, 2025-01-13 at 20:03 +0000, Pandruvada, Srinivas wrote:
> > On Mon, 2025-01-13 at 14:49 -0500, Mark Pearson wrote: =20
> > > Note - switched to my open-source friendly email account (avoid the
> > > Lenovo address, especially for mailing lists, it's Outlook based
> > > and
> > > can't cope).
> > >=20
> > > On Mon, Jan 13, 2025, at 2:19 PM, Mark Pearson wrote: =20
> > > > Subject: [External] Re: [PATCH v2] iio: hid-sensor-prox: Split=20
> > > > difference from multiple channels
> > > >=20
> > > > On Sat, 2025-01-11 at 10:17 +0100, Ricardo Ribalda wrote: =20
> > > > > Hi Jonathan
> > > > >=20
> > > > > Happy new year!
> > > > >=20
> > > > > Friendly ping about this patch so we can change the ABI before
> > > > > the
> > > > > kernel release happens
> > > > >=20
> > > > > On Thu, 19 Dec 2024 at 18:17, Jonathan Cameron
> > > > > <jic23@kernel.org>
> > > > > wrote: =20
> > > > > >=20
> > > > > > On Mon, 16 Dec 2024 10:05:53 +0000
> > > > > > Ricardo Ribalda <ribalda@chromium.org> wrote:
> > > > > >  =20
> > > > > > > When the driver was originally created, it was decided that
> > > > > > > sampling_frequency and hysteresis would be shared_per_type
> > > > > > > instead
> > > > > > > of shared_by_all (even though it is internally shared by
> > > > > > > all).
> > > > > > > Eg:
> > > > > > > in_proximity_raw
> > > > > > > in_proximity_sampling_frequency
> > > > > > >=20
> > > > > > > When we introduced support for more channels, we continued
> > > > > > > with
> > > > > > > shared_by_type which. Eg:
> > > > > > > in_proximity0_raw
> > > > > > > in_proximity1_raw
> > > > > > > in_proximity_sampling_frequency
> > > > > > > in_attention_raw
> > > > > > > in_attention_sampling_frequency
> > > > > > >=20
> > > > > > > Ideally we should change to shared_by_all, but it is not an
> > > > > > > option,
> > > > > > > because the current naming has been a stablished ABI by
> > > > > > > now.
> > > > > > > Luckily we
> > > > > > > can use separate instead. That will be more consistent:
> > > > > > > in_proximity0_raw
> > > > > > > in_proximity0_sampling_frequency
> > > > > > > in_proximity1_raw
> > > > > > > in_proximity1_sampling_frequency
> > > > > > > in_attention_raw
> > > > > > > in_attention_sampling_frequency
> > > > > > >=20
> > > > > > > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for
> > > > > > > more
> > > > > > > channels")
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org> =20
> > > > > >=20
> > > > > > I got lost somewhere in the discussion.=C2=A0 This is still an =
ABI
> > > > > > change compared
> > > > > > to original interface at the top (which is the one that has
> > > > > > been
> > > > > > there
> > > > > > quite some time).
> > > > > >=20
> > > > > > However we already had to make one of those to add the index
> > > > > > that
> > > > > > wasn't there
> > > > > > for _raw. (I'd missed that in earlier discussion - thanks for
> > > > > > laying out the
> > > > > > steps here!) =20
> > > >=20
> > > > Didn't realize this. I don't see proximity sensor use in the
> > > > mainline
> > > > Linux distro user space, so it will affect only some private user
> > > > space
> > > > programs.
> > > > Adding Mark to see if it affects Lenovo Sensing solution as there
> > > > was
> > > > specific custom sensor added to this driver for Lenovo.
> > > >  =20
> > >=20
> > > Can I get some pointers to what sensor that is please?
> > > We've been asking for the HID support drivers, but it isn't
> > > available
> > > yet to my knowledge. Would the MIPI camera work tie into this? =20
> > No.
> >  =20
> > >=20
> > > If I can get details on what the sensor is I'll go and check what
> > > is
> > > impacted.
> > >  =20
> > This is a custom sensor exported via Intel ISH
> >=20
> > =C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Lenovo Intelligent S=
ensing Solution (LISS)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* human presence */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .tag =3D "LISS",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .luid =3D "0226000171AC0081",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .model =3D "VL53L1_HOD Sensor",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .manufacturer =3D "ST_MICRO",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .check_dmi =3D true,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .dmi.matches =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_M=
ATCH(DMI_SYS_VENDOR, "LENOVO"),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> >=20
> > Question is what Lenovo user space is using this sensor?
> >=20
> > Thanks,
> > Srinivas
> >  =20
> > > Thanks
> > > Mark =20
> >  =20
>=20


