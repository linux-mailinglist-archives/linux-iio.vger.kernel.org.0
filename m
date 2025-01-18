Return-Path: <linux-iio+bounces-14472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71AA15E4B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 18:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC331885E9E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B6E19307F;
	Sat, 18 Jan 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPrcDgVb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F3A92F;
	Sat, 18 Jan 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737220678; cv=none; b=jSthIy504H3lMwEjydHIO8G4ZZWjm8RAjM6z7uIdLVqm0T6G/Q3XT9pC4i2chOlxZ655qFNPstxV2jZkagzKNoZBAmDwo6ujSeOSFGnu0j2t/85KcjSLTMKZnKehXS2LM1CPlhhZxY0a+vhf90D5ekzkuv9GPRdUWp2mHaRO0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737220678; c=relaxed/simple;
	bh=dqsisWcqACFWjPr1zMfqxbk90fmPlfYiLtRx60A6R44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTpRTAr81u9qyvEEX8Vqi+UAmWTQDNEQmgOxcYCflNaiJOHI6Rj3N15DOio/N+qTlXCSsYRhQLflzMgTD+OSlp7uKSHoIMkbUlCLgLbwuufP48Kh3pmoM2gchisMW+GHJ3/bXMTAYqJfyT+l7+4CxHpjCPMZ1aJ17I0WgTaSPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPrcDgVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C11C4CED1;
	Sat, 18 Jan 2025 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737220677;
	bh=dqsisWcqACFWjPr1zMfqxbk90fmPlfYiLtRx60A6R44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bPrcDgVb5ouZnubtBXRmarBUcpxmxHAB21n7zt8WUJnIyBiBjS4wuosCiobtGtzcZ
	 WFPq1dX4xQeCDxEQlgWEhUjLGDGJ85HPYi7d5GUxO8Nr1iimWKrrN1qL7ghoD2pMAs
	 cXqUlqG2Qt4G52yzKGIGcGul8SpLSGNUnCbYYY4SpKPCk9qT1LOpSNbldOH1J0XF7I
	 MedTJMoKBBoEdPHNNHotSQAs0abfLL9TbVE2RS/Od1Z0LXHEzVBnEBWWqpan3Asj0P
	 Nps7qLYMYerzAebINuN1uB24c8syCHLJNDM0K2rc0TVzO87J8sR5rqmNXVKTuOmPp1
	 FlkxCddd/Vmwg==
Date: Sat, 18 Jan 2025 17:17:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Mudit Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gts: Simplify available scale table build
Message-ID: <20250118171751.4d966c98@jic23-huawei>
In-Reply-To: <20250111124224.008b826a@jic23-huawei>
References: <Z1_rRXqdhxhL6wBw@mva-rohm>
	<20241220192118.3e9ba7f9@jic23-huawei>
	<9c07b71a-160f-4336-8a8d-cad7003e4b68@gmail.com>
	<a49a57c0-e3fa-4d4a-aec7-be8f7a681f3b@gmail.com>
	<b25638fb-15c1-4270-ab26-769be0ce57c9@tweaklogic.com>
	<20250111124224.008b826a@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Jan 2025 12:42:24 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 11 Jan 2025 14:47:28 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>=20
> > On 11/1/25 00:56, Matti Vaittinen wrote: =20
> > > On 22/12/2024 11:24, Matti Vaittinen wrote:   =20
> > >> On 20/12/2024 21:21, Jonathan Cameron wrote:   =20
> > >>> On Mon, 16 Dec 2024 10:56:37 +0200
> > >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > >>>   =20
> > >>>> Make available scale building more clear. This hurts the performan=
ce
> > >>>> quite a bit by looping throgh the scales many times instead of doi=
ng
> > >>>> everything in one loop. It however simplifies logic by:
> > >>>> =C2=A0 - decoupling the gain and scale allocations & computations
> > >>>> =C2=A0 - keeping the temporary 'per_time_gains' table inside the
> > >>>> =C2=A0=C2=A0=C2=A0 per_time_scales computation function.
> > >>>> =C2=A0 - separating building the 'all scales' table in own functio=
n and doing
> > >>>> =C2=A0=C2=A0=C2=A0 it based on the already computed per-time scale=
s.
> > >>>>
> > >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>   =20
> > >>> Looks good to me, but I want to leave it on list a while before app=
lying.
> > >>> Ideal if it gets some tested-by or other tags before I pick it up.
> > >>> As always, this is fiddly code, so the more eyes the better!   =20
> > >>
> > >> Please, let it wait until the Christmas has passed. I got informatio=
n we might be getting some testing before the year changes :)   =20
> > >=20
> > > Well, the year changed and no tested-by tags emerged. I suppose my so=
urces weren't right at this time.
> > >=20
> > > Yours,
> > >  =C2=A0=C2=A0=C2=A0=C2=A0-- Matti   =20
> > Hi Matti,
> >=20
> > Hope you had a good Christmas and new year. After my US trip, it took m=
e some time
> > to come to terms that I have to work for a living!
> >=20
> > The code works fine. I tested it with apds9306 driver with stm32mp157-d=
k2 board.
> >=20
> > Tested-by: subhajit.ghosh@tweaklogic.com
> >=20
> > Just want to report something else which may not be related to this.
> > When I tried to cross-compile with linux-gnueabi-gcc version 12.2.0 wit=
h Linux kernel 6.1.28, I got the following errors:
> >    CC [M]  /home/subhajit/opensource_contributions/apds9306/apds9306_ba=
ckport/./drivers/iio/industrialio-gts-helper.o
> > /tmp/ccn9UpwF.s: Assembler messages:
> > /tmp/ccn9UpwF.s:22: Error: junk at end of line, first unrecognized char=
acter is `I'
> > ...
> > ...
> >=20
> > I had to remove the double quotes from the macros for all symbol export=
s:
> > EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, "IIO_GTS_HELPER");
> > to
> > EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);
> >=20
> > However the x86_64 native build of the mainline kernel 6.13.0-rc6 on my=
 laptop went just fine with this patch.
> >=20
> > Regards,
> > Subhajit Ghosh =20
>=20
> Hi Subhajit,
>=20
> You've run into a tree wide change wrt to those quote that went in just a=
fter rc1 of this cycle.
> The error message is less than helpful and we've spent all cycle fixing t=
hese up :(
>=20
> Anyhow this is expected if backporting.
>=20
> Jonathan
>=20
Applied to the testing branch of iio.git. I'll be rebasing on rc1 once it
is available and then push this out as normal togreg branch.

Thanks

Jonathan

>=20
>=20


