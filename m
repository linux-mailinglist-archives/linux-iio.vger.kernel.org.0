Return-Path: <linux-iio+bounces-14562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A9A1C2FC
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DEF1678E0
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5120766C;
	Sat, 25 Jan 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1qBFtUP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5623B0;
	Sat, 25 Jan 2025 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737806684; cv=none; b=BdYzepY64chHwDWuMCLkz/vE93kYCZj8k1qAWMu90B6pHUPHzbxoGDfmckW/PjgJrd1POI9Q14tGq2FskRmtSm+bKR3CeEiZ5+qdaldydJF7AIv9TnyJve0hE51fznO7A0j7IFPHezubsDgaRYk/A7KF3ZBL6begRpASB9Gt+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737806684; c=relaxed/simple;
	bh=MOSXOh1xAmN7BIrNA0Ol7IpUrWRn1SCp3+SxAjbsVyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maJRpKBQMLb5fF/V4mkpY+0za1LL+pXrUvEXaaZ23FvGHZmIsbO7krGpqARyjDHnIeAtRztAzves9kB1DTPWe0ojeciqo/9aAR8yb1mI7kHblW9oR0F2B1jH5/TnOHS3NP9pJnEijkdfIhuFa0VHTs0DT06hkXFvM2v32oHr3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1qBFtUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85227C4CED6;
	Sat, 25 Jan 2025 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737806683;
	bh=MOSXOh1xAmN7BIrNA0Ol7IpUrWRn1SCp3+SxAjbsVyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E1qBFtUPHatO/vadRVTHMGQ2XCfyMT+VTprV1GNHuhAbkA+ksYYFzpe3BWLk9pcUv
	 UD8PaJRTW2rL0raYcAFz90y4D330cr3y36s87cjr+0t4kNb0Ue+0XBScA2gOKjq3Ug
	 EF3Q/japWKtS/qIzmpkgFXS4G8PyDSo+THFT+sIIg5TjoBbUaCpFvMdPVodR7Mu/P5
	 wa+RUnIQ6q+uXvtX/SrKzABg4N4zePct83pe5CNJgNNUBcT8ZIM4Kv38Vp/jhZq6T1
	 FyLIvp3461jn6jRiB8jE1NGo9PUPjQOh4lSxj2906x9hwJXu8Yu+XIBP8Lie40dftb
	 oNg7l23h2ZOaw==
Date: Sat, 25 Jan 2025 12:04:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 corbet@lwn.net
Subject: Re: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
Message-ID: <20250125120435.626513d3@jic23-huawei>
In-Reply-To: <Z4wUPtDfnmQ53L0k@debian-BULLSEYE-live-builder-AMD64>
References: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
	<3bd58574-36c6-4102-ad7d-1aeff0e46a95@baylibre.com>
	<20250118155153.2574dbe5@jic23-huawei>
	<Z4wUPtDfnmQ53L0k@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


> > > > +1.2.2 Differential Unipolar Channels
> > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > +
> > > > +For **differential unipolar** channels, the analog voltage at the =
positive input
> > > > +must also be higher than the voltage at the negative input. Thus, =
the actual
> > > > +input range allowed to a differential unipolar channel is IN- to +=
VREF. Because
> > > > +IN+ is allowed to swing with the measured analog signal and the in=
put setup must
> > > > +guarantee IN+ will not go below IN- (nor IN- will raise above IN+)=
, most
> > > > +differential unipolar channel setups have IN- fixed to a known vol=
tage that does
> > > > +not fall within the voltage range expected for the measured signal=
. This leads
> > > > +to a setup that is equivalent to a pseudo-differential channel. Th=
us,
> > > > +differential unipolar channels are actually pseudo-differential un=
ipolar
> > > > +channels.   =20
> > >=20
> > > I don't think this is equevent to pseudo-differential unipolar. That =
one has
> > > a common mode voltage supply on the negative input. This one has a fu=
ll range
> > > signal on the negative input. This is the diagram I was expecting her=
e.
> > >=20
> > > ::
> > >=20
> > >   -------- VREF -------
> > >     =C2=B4 `       =C2=B4 `               +-------------------+
> > >   /     \   /     \   /        /                    |
> > >          `-=C2=B4       `-=C2=B4    --- <  IN+                |
> > >   ------ GND (0V) -----        |                    |
> > >                                |            ADC     |
> > >   -------- VREF -------        |                    |
> > >         =C2=B4 `       =C2=B4 `     --- <  IN-                |
> > >   \   /     \   /     \        \       VREF         |
> > >    `-=C2=B4       `-=C2=B4                +-------------------+
> > >   ------ GND (0V) -----                  ^       =20
> > >                                          |      =20
> > >                                   External VREF =20
> >=20
> > If it's unipolar, output must be positive which isn't true here.
> > Do we actually see differential unipolar except for the pseudo case with
> > common mode voltage?   Seems like a weird device. =20
>=20
> I don't think we have differential unipolar with IN- allowed to float (i.=
e. not
> set to a constant voltage). Haven't seen any of those. Can't think of how=
 we
> would support such thing either. See my reply to David for more thoughts =
on this.

Agreed it is an odd beast, but that doesn't mean we should necessarily write
text that implies it is always the same as pseudo-differential unipolar.

Meh you do say 'most' so fair enough.


Jonathan


