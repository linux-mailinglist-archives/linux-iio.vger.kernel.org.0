Return-Path: <linux-iio+bounces-18268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8973EA93A40
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB621B6783F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C91DFDB8;
	Fri, 18 Apr 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSTcSLeW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0163823DE;
	Fri, 18 Apr 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744992075; cv=none; b=GXvn7THySI8IUAW+Opxd3OgbaEZnPQbxB0sgEWfNU8tqOqWf+TXTHbGeefGbGKj2p08q/2kRbbZhExZM41xVShy9oJMBVZIIKI7+AVvbkzFcM1I8GXk9e51rCCjrqkGfSXbGfeeHzvPa5vX6NeVOJRDN8wqyzSwFWfIeieYFFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744992075; c=relaxed/simple;
	bh=DYwb7eWpfr6BQ7HNxfTbsypBw5GxqpDFpqSEoCMRKhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnIfby6vmX7g4122CqphaaB3pRYSmLOFFKIk/V1Xc5KKg97aba1bJvSAEib8iDk1oiqshcenlvpn69RAl6BjEZZJHPZYlVC4gI+TQeX4Ty1RaaRYFR4/+rUoA4p2HWaPzuymsjBG7zfbpMDW5azWGAqYImIaTAKvJEaZi4hBGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSTcSLeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DAEC4CEE2;
	Fri, 18 Apr 2025 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744992074;
	bh=DYwb7eWpfr6BQ7HNxfTbsypBw5GxqpDFpqSEoCMRKhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uSTcSLeWHb85LXGcadG02ULZRThOocshwHx3LjbJDUSXROAFXCgzcJH/MWwdRhXcS
	 O/D0KJGdxRuLhFxRw5+7/9n646l6OAhKE3t4VUiZrASnXdktNO/d3oh1gLdE+YK1WZ
	 MRGobnKlDQD82O5YL5iGxeHHFJ7+5zv8jaIN8uJffvAt0Q+uFpUGSgOsTMhmp/ZEIX
	 mUnxpRg5F35JM8FL9Euf8V5MxrCc98fLzCpYuZwTuQhCOi7WMuiZRuleGDOV5OKZ2K
	 Qr48n3eXwBh5mh1P628amAD4F6vxGmw7i6Bs/fTGDep3dLns7SSjWnU26Zr2qqUXya
	 A2zyxIMHpMT6g==
Date: Fri, 18 Apr 2025 17:01:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Victor.Duicu@microchip.com>
Cc: <Marius.Cristea@microchip.com>, <andy@kernel.org>,
 <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250418170107.2fa397e7@jic23-huawei>
In-Reply-To: <b3ffdcd05578742b3b992102e7930ac123ee7d51.camel@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
	<20250415132623.14913-2-victor.duicu@microchip.com>
	<20250415185200.396d6356@jic23-huawei>
	<b3ffdcd05578742b3b992102e7930ac123ee7d51.camel@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Apr 2025 11:40:53 +0000
<Victor.Duicu@microchip.com> wrote:

> On Tue, 2025-04-15 at 18:52 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Tue, 15 Apr 2025 16:26:22 +0300
> > <victor.duicu@microchip.com> wrote:
> >  =20
> > > From: Victor Duicu <victor.duicu@microchip.com>
> > >=20
> > > This is the devicetree schema for Microchip MCP998X/33 and
> > > MCP998XD/33D Multichannel Automotive Temperature Monitor Family. =20
> > Hi Victor,
> >  =20
> Hi Jonathan,
>=20
> > Please state briefly here in what way the parts are incompatible
> > as a justification for no fallback compatibles.=C2=A0 Quite a bit
> > of that will become apparent when you enforce validity of parameters
> > as suggested below.
> >  =20
> I am a bit confused, could you elaborate a bit on this point? Are you
> asking if the chips mcp9982, 83, 84 etc. are compatible among each
> other?

yes. It makes it easier for binding review to just have statement in the
patch description of how they are different in ways the driver needs
to know about.  Can be simple things like 'only some devices have X'
or they have differing numbers of channels.


>=20
>=20
> > Various comments inline. =20
> > >=20
> > > Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> > > --- =20
> >  =20
> ...
> >  =20
> > > +
> > > +=C2=A0 microchip,extended-temp-range:
> > > +=C2=A0=C2=A0=C2=A0 description: |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Set the chip to work in the extended =
temperature range -64
> > > degrees C to 191.875 degrees C.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Omit this tag to set the default rang=
e 0 degrees C to
> > > 127.875 degrees C
> > > +=C2=A0=C2=A0=C2=A0 type: boolean =20
> >=20
> > I'm curious.=C2=A0 Why does this belong in the DT binding?
> >  =20
>=20
> Regarding microchip,extended-temp-range, my perspective is that the
> user knows beforehand which specific range of temperatures he needs.
> For example, if the device to be measured is a freezer, the user would
> be interested in temperatures below 0 degrees C. If we monitor a CPU,
> the user would be interested in temperatures above 0 degrees C.

Maybe - though also easy to control from userspace by making the
offset writeable.
>=20
> > > +
> > > +=C2=A0 microchip,beta-channel1:
> > > +=C2=A0=C2=A0=C2=A0 description: |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The beta compensation factor for exte=
rnal channel 1 can be
> > > set
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 by the user, or can be set automatica=
lly by the chip.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If one wants to enable beta autodetec=
tion, omit this tag.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Please consult the documentation if o=
ne wants to set a
> > > specific beta.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If anti-parallel diode operation is e=
nabled, the default
> > > value is set
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and can't be changed.
> > > +=C2=A0=C2=A0=C2=A0 type: boolean =20
> >=20
> > Why is this a hardware thing that belongs in dt?=C2=A0 Enforce the
> > constraint
> > in the schema rather than text.
> >  =20
>=20
> With respect to the beta parameter, it is directly affected by the
> hardware part used. For example a CPU diode would require a different
> beta (that could be known by the manufacturer of the device and not
> know by the final user) as opposed to a diode connected transistor
> (that could be easily measured by the end user).
>=20
> However, I remain open to the idea of moving temperature range and
> channel betas to user space if you think it is better that way.

For the betas I was more curious about why the dt needs to distinguish
between a manual setting and autodetection.  When is autodetection
a bad idea for example?

Jonathan

>=20
> Kind regards,
> Victor Duicu
> ...
> > >  =20
> >  =20
>=20


