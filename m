Return-Path: <linux-iio+bounces-26883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2B2CAB665
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8BCE3002E98
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC82F3C3E;
	Sun,  7 Dec 2025 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohz4t9QJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF642D248D;
	Sun,  7 Dec 2025 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765120307; cv=none; b=m73CHdrJ/jGO2xtUJsFyDCwEDJUeFavzaXEZ4LO3q1DPLLu57YNMIyJyM3j+MchHIOu3Sf+UE5anGlRANVP1jJC9RoZz4PB54+fn+xvZiMF3NjHG/nvaZF3gQ02IV893UaqfjT+0HALa5XD8o81zWPIzr1o97KKiAN3vwAnyz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765120307; c=relaxed/simple;
	bh=vWLeEQ+MWGlQz9737TaOg2yifz0oHXKlfxeIo6K3uq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b137X34nj9cHJBeZHJLqm+K6GtgCBX4RXVR4S7PmpH4xy4PzJoy7/DCxgexROXOp77E3CeV31IxclA81is4pPo1qrMnfyfx4YtCfB5y6g1syR4imr0G07A/HafeKc9LDj2gCxXYOcgGzrTkzidD4j+OEtemJeJ3GEA10uZw2AlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohz4t9QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE728C4CEFB;
	Sun,  7 Dec 2025 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765120305;
	bh=vWLeEQ+MWGlQz9737TaOg2yifz0oHXKlfxeIo6K3uq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ohz4t9QJQevkEL1CXJk8MV024ElCkD4IaDI8ylDN7A1W4ao+K549MKtZePTrigtxR
	 a9FpJ7iSKISY51Uq+GQji0hPuBsMd+7Z8lsrsaYFKT4+jKGaoTQO7Jgck4kuM8XMIE
	 KZ3vz9g66PaU7OtLYjjwkUYO5M0ZemT6e3An6H8agPa4a9FhOkQP6JK5lFi0KvegCh
	 LdUZq4L9b27nhFQeJkA0SF5+1Z1x2zhMzvgku5jAdlampEdJxWZMtSH7wnP4ywJib8
	 rVtdfR/5wzbfQsqMI++bOtBNzhVhnMr+5iOZh153iEhPMFY3Xxvf0jm2k5ennCRGBJ
	 OICWPeusmaBmw==
Date: Sun, 7 Dec 2025 15:11:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: imu: st_lsm6dsx: add event configurability on
 a per axis basis
Message-ID: <20251207151137.12d96c78@jic23-huawei>
In-Reply-To: <0da1f46640226ab52ef0a726a5110cc56b85cdd4.camel@baylibre.com>
References: <c1c7222b35a0a7bcddc5d88c92f64d2f2a75fdfd.camel@baylibre.com>
	<aQNueWesrf_vXO06@smile.fi.intel.com>
	<5b23d077d8882d6b2a2e66817b1b6bcebc6bb5a2.camel@baylibre.com>
	<aRxN_Gnsl0qq8wDn@black.igk.intel.com>
	<82bf13fd5ada664d9e4fdbc3ee453204e55d318b.camel@baylibre.com>
	<aR7Z19wgPksymwkw@black.igk.intel.com>
	<50107aecc446ba42e312b81e18a6ffe871fa3291.camel@baylibre.com>
	<aR8esn94zI140351@smile.fi.intel.com>
	<aR9ej_7o0te-HO8P@smile.fi.intel.com>
	<e448a6fdb420b0c0561ab2255820d2ba62f838a1.camel@baylibre.com>
	<aSAxjBCfiw-iCWhI@smile.fi.intel.com>
	<0da1f46640226ab52ef0a726a5110cc56b85cdd4.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 15:57:57 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> On Fri, 2025-11-21 at 11:31 +0200, Andy Shevchenko wrote:
> > On Fri, Nov 21, 2025 at 10:14:06AM +0100, Francesco Lavra wrote: =20
> > > On Thu, 2025-11-20 at 20:31 +0200, Andy Shevchenko wrote: =20
> > > > On Thu, Nov 20, 2025 at 03:59:18PM +0200, Andy Shevchenko wrote: =20
> > > > > On Thu, Nov 20, 2025 at 12:43:09PM +0100, Francesco Lavra wrote: =
=20
> > > > > > On Thu, 2025-11-20 at 10:05 +0100, Andy Shevchenko wrote: =20
> > > > > > > On Tue, Nov 18, 2025 at 12:01:57PM +0100, Francesco Lavra
> > > > > > > wrote: =20
> > > > > > > > On Tue, 2025-11-18 at 11:44 +0100, Andy Shevchenko wrote: =
=20
> > > > > > > > > On Mon, Nov 17, 2025 at 08:23:35PM +0100, Francesco Lavra
> > > > > > > > > wrote: =20
> > > > > > > > > > On Thu, 2025-10-30 at 15:56 +0200, Andy Shevchenko wrot=
e: =20
> > > > > > > > > > > On Thu, Oct 30, 2025 at 12:23:19PM +0100, Francesco
> > > > > > > > > > > Lavra
> > > > > > > > > > > wrote: =20
> > > > > > > > > > > > On Thu, 2025-10-30 at 10:24 +0200, Andy Shevchenko
> > > > > > > > > > > > wrote: =20
> > > > > > > > > > > > > On Thu, Oct 30, 2025 at 08:27:51AM +0100, Frances=
co
> > > > > > > > > > > > > Lavra
> > > > > > > > > > > > > wrote: =20
> >=20
> > ...
> >  =20
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_=
enable =3D hw->enable_event[event];
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_=
enable =3D state ? (old_enable |
> > > > > > > > > > > > > > BIT(axis))
> > > > > > > > > > > > > > :
> > > > > > > > > > > > > > (old_enable
> > > > > > > > > > > > > > &
> > > > > > > > > > > > > > ~BIT(axis));
> > > > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (=
!!old_enable =3D=3D !!new_enable) =20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > This is an interesting check. So, old_enable and
> > > > > > > > > > > > > new_enable
> > > > > > > > > > > > > are
> > > > > > > > > > > > > _not_
> > > > > > > > > > > > > booleans, right?
> > > > > > > > > > > > > So, this means the check test if _any_ of the bit
> > > > > > > > > > > > > was
> > > > > > > > > > > > > set and
> > > > > > > > > > > > > kept
> > > > > > > > > > > > > set or
> > > > > > > > > > > > > none were set
> > > > > > > > > > > > > and non is going to be set. Correct? I think a
> > > > > > > > > > > > > short
> > > > > > > > > > > > > comment
> > > > > > > > > > > > > would be
> > > > > > > > > > > > > good to have. =20
> > > > > > > > > > > >=20
> > > > > > > > > > > > old_enable and new_enable are bit masks, but we are
> > > > > > > > > > > > only
> > > > > > > > > > > > interested
> > > > > > > > > > > > in
> > > > > > > > > > > > whether any bit is set, to catch the cases where the
> > > > > > > > > > > > bit
> > > > > > > > > > > > mask
> > > > > > > > > > > > goes
> > > > > > > > > > > > from
> > > > > > > > > > > > zero to non-zero and vice versa. Will add a comment=
. =20
> > > > > > > > > > >=20
> > > > > > > > > > > If it's a true bitmask (assuming unsigned long type)
> > > > > > > > > > > then
> > > > > > > > > > > all
> > > > > > > > > > > this
> > > > > > > > > > > can be
> > > > > > > > > > > done
> > > > > > > > > > > via bitmap API calls. Otherwise you can also compare a
> > > > > > > > > > > Hamming
> > > > > > > > > > > weights of
> > > > > > > > > > > them
> > > > > > > > > > > (probably that gives even the same size of the object
> > > > > > > > > > > file,
> > > > > > > > > > > but
> > > > > > > > > > > !!
> > > > > > > > > > > instructions
> > > > > > > > > > > =C2=A0will be changed to hweight() calls (still a sin=
gle
> > > > > > > > > > > assembly
> > > > > > > > > > > instr on
> > > > > > > > > > > modern
> > > > > > > > > > > =C2=A0architectures). =20
> > > > > > > > > >=20
> > > > > > > > > > These are u8 variables, so we can't use the bitmap API.=
 =20
> > > > > > > > >=20
> > > > > > > > > OK. But hweight8() can still be used.
> > > > > > > > >  =20
> > > > > > > > > > And I don't
> > > > > > > > > > understand the reason for using hweight(), given that t=
he
> > > > > > > > > > !!
> > > > > > > > > > operators
> > > > > > > > > > would still be needed. =20
> > > > > > > > >=20
> > > > > > > > > No, you won't need !! with that. =20
> > > > > > > >=20
> > > > > > > > I still don't understand. Are you proposing to replace `if
> > > > > > > > (!!old_enable =3D=3D
> > > > > > > > !!new_enable)` with `if (hweight8(old_enable) =3D=3D
> > > > > > > > hweight8(new_enable))`?
> > > > > > > > That won't work, because we only need to check whether the
> > > > > > > > Hamming
> > > > > > > > weight
> > > > > > > > goes from zero to non-zero and vice versa. =20
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_enable =3D hw->enabl=
e_event[event];
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_enable =3D state ? (=
old_enable | BIT(axis)) :
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (old_enable & ~BIT(axis));
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!!old_enable =3D=3D =
!!new_enable)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > > >=20
> > > > > > > If I am not mistaken this will do exactly the same in a simpl=
er
> > > > > > > way.
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0old_enable =
=3D hw->enable_event[event];
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (state)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable | BIT(axis);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0new_enable =3D old_enable & ~BIT(axis);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ((new_enab=
le ^ old_enable) !=3D BIT(axis))
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0; =20
> > > > > >=20
> > > > > > This doesn't look right to me, if new_enable differs from
> > > > > > old_enable
> > > > > > by
> > > > > > just one bit (which it does), then the XOR result will always
> > > > > > have
> > > > > > this bit
> > > > > > (and no others) set, so (new_enable ^ old_enable) will always
> > > > > > equal
> > > > > > BIT(axis).
> > > > > > We are not checking if the bit was already set or clear, when
> > > > > > this
> > > > > > code
> > > > > > runs we already know that the bit is changing, what we are
> > > > > > checking
> > > > > > is
> > > > > > whether all bits are zero before or after this change. =20
> > > > >=20
> > > > > The check I proposed is to have a look for the cases when
> > > > > old_enable
> > > > > was 0 and
> > > > > the BIT(axis) is set and when the BIT(axis) was _the last_ bit in
> > > > > the
> > > > > mask that
> > > > > got reset. If it's not the case, the code will return 0. I think =
my
> > > > > check is
> > > > > correct.
> > > > >=20
> > > > > Should I write a test case? =20
> > > >=20
> > > > FWIW,
> > > > https://gist.github.com/andy-shev/afe4c0e009cb3008ac613d8384aaa6eb =
=20
> > >=20
> > > The code in your gist produces:
> > >=20
> > > Initial event: 0x92, new state: True for bit 0x20 =20
> >=20
> > Initial event is 10010010b, we assume that we got in the code when
> > required
> > state is to 'set' (True) with axis =3D 5 (means 00100000b when powered).
> >=20
> > The [-] are special cases just to show the algo.
> >  =20
> > > [-] 0x00 | 0x20 --> 1: handle =20
> >=20
> > If initial event is 0 we handle
> >=20
> > If _after_ that the bit 5 set (which is NOT the case in _this_
> > iteration),
> > we will stop handling. =20
>=20
> We have to stop handling not only if bit 5 is set, but also if any other
> bit is set after that.
>=20
> > > [0] 0x92 | 0x20 --> 1: handle =20
> >=20
> > So, it's again step 1. I _assumed_ that your code works and sets the bi=
t. =20
>=20
> Even if it's again step 1, this is not supposed to be handled, because
> there are bits already set in the current bitmask.
>=20
> Enabling an event source for an axis may need two registers to be set:
> 1) an axis-specific enable register
> 2) an event-specific enable register (global for all axes)
>=20
> If no events are enabled on any axis, when we enable the event source for
> axis X, we have to do both steps above; if then we enable the same event
> source for axis Y, we have to do just step 1 but not step 2; and that's
> what the (!!old_enable =3D=3D !!new_enable) check is supposed to do: to c=
heck
> if, after setting the axis-specific enable register, we have to set also
> the event-specific enable register. If I replace that check with
> ((new_enable ^ old_enable) !=3D BIT(axis)), then I'm doing both steps for
> every axis, which is unnecessary when enabling the event (because we don't
> need to set again the event-specific register after we set it for the fir=
st
> axis), and is wrong when disabling the event (because disabling the event
> for a single axis would inadvertently disable it globally (i.e. for all
> axes).
>=20
Obviously I've very late to this thread, but just thought I'd comment
that if the driver was using regcache (which might well make sense) then
I wouldn't bother with the check at all. The write to update the register
to the value already has wouldn't do anything other than a few trivial
operations to check the cache value matches.

Might be worth enabling the regcache part of regmap simply to avoid
having to care about corners like this.

Jonathan


