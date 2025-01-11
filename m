Return-Path: <linux-iio+bounces-14126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA24CA0A39F
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C1F188B8DE
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774B19DF98;
	Sat, 11 Jan 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4kWioCA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706EE19D898;
	Sat, 11 Jan 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736599356; cv=none; b=HFjozH0E9aySEE30p4tJaR/kB/kWkxc+fUkTlz+UsoqfP/zIX85QVq4qvRqmtPlKbRwp2u1VSChyY861bqMYWOuOO0kgdYHpd4474r9kz9nf9k0ypkfO0M2Y+ZjgjFQhYiAgKOL2h4SkPJw4DnZy/ClxAuJH6F/99y+F0gkWUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736599356; c=relaxed/simple;
	bh=XZthtrMbzkRMJY6YGyuBSg7i/WROOOVS1c+PSKk9piU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cc0KNc0/YmkfoZQCzICOsztfLjRsX5wt1q/c9YnkLnatotSmbGZdGJr9ACe1zW28DmHfYdyTCYoElNfz8EPfNrG3gSRkV7M9U7O4WLgnC6Bjtaf7iI1QskpI9w4A4XWVw4sxxW3yMsG+uyX0vyADrxGYXuqUY8WFyREERH3QmAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4kWioCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F19C4CED2;
	Sat, 11 Jan 2025 12:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736599356;
	bh=XZthtrMbzkRMJY6YGyuBSg7i/WROOOVS1c+PSKk9piU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4kWioCAAuutVRuFgKUWpmdUVhHrZt79rle52NT/DAvNqK4QgsT33YLejLSTVTgLE
	 Q2nbzqQNPHMsrW3zlWY7Ot73yG5NcJwgy2VsBckfxGbA+Ra8l694vpRd6iuWQ6G6Uy
	 4azkUvx9JfuScUr8plPVSVNMFUaAvk4Ow/AEJ8HuMBLKN7eUkEi+uVFnZLJpGBVSA6
	 tzf5c0ampX6oL5nx3tknBv1B2w0fPyff7BdjbQWCh8HneG8NYK9XOcoVXOGHPJV3tN
	 c7FAilV2+JYU00/8yssmLfgkVrFROkEWg7of4OTAu4FxEhE/hmhXLNCuqPQX5hv7y0
	 5bat1xBCJ54Ug==
Date: Sat, 11 Jan 2025 12:42:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Mudit Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gts: Simplify available scale table build
Message-ID: <20250111124224.008b826a@jic23-huawei>
In-Reply-To: <b25638fb-15c1-4270-ab26-769be0ce57c9@tweaklogic.com>
References: <Z1_rRXqdhxhL6wBw@mva-rohm>
	<20241220192118.3e9ba7f9@jic23-huawei>
	<9c07b71a-160f-4336-8a8d-cad7003e4b68@gmail.com>
	<a49a57c0-e3fa-4d4a-aec7-be8f7a681f3b@gmail.com>
	<b25638fb-15c1-4270-ab26-769be0ce57c9@tweaklogic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Jan 2025 14:47:28 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 11/1/25 00:56, Matti Vaittinen wrote:
> > On 22/12/2024 11:24, Matti Vaittinen wrote: =20
> >> On 20/12/2024 21:21, Jonathan Cameron wrote: =20
> >>> On Mon, 16 Dec 2024 10:56:37 +0200
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>> =20
> >>>> Make available scale building more clear. This hurts the performance
> >>>> quite a bit by looping throgh the scales many times instead of doing
> >>>> everything in one loop. It however simplifies logic by:
> >>>> =C2=A0 - decoupling the gain and scale allocations & computations
> >>>> =C2=A0 - keeping the temporary 'per_time_gains' table inside the
> >>>> =C2=A0=C2=A0=C2=A0 per_time_scales computation function.
> >>>> =C2=A0 - separating building the 'all scales' table in own function =
and doing
> >>>> =C2=A0=C2=A0=C2=A0 it based on the already computed per-time scales.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com> =20
> >>> Looks good to me, but I want to leave it on list a while before apply=
ing.
> >>> Ideal if it gets some tested-by or other tags before I pick it up.
> >>> As always, this is fiddly code, so the more eyes the better! =20
> >>
> >> Please, let it wait until the Christmas has passed. I got information =
we might be getting some testing before the year changes :) =20
> >=20
> > Well, the year changed and no tested-by tags emerged. I suppose my sour=
ces weren't right at this time.
> >=20
> > Yours,
> >  =C2=A0=C2=A0=C2=A0=C2=A0-- Matti =20
> Hi Matti,
>=20
> Hope you had a good Christmas and new year. After my US trip, it took me =
some time
> to come to terms that I have to work for a living!
>=20
> The code works fine. I tested it with apds9306 driver with stm32mp157-dk2=
 board.
>=20
> Tested-by: subhajit.ghosh@tweaklogic.com
>=20
> Just want to report something else which may not be related to this.
> When I tried to cross-compile with linux-gnueabi-gcc version 12.2.0 with =
Linux kernel 6.1.28, I got the following errors:
>    CC [M]  /home/subhajit/opensource_contributions/apds9306/apds9306_back=
port/./drivers/iio/industrialio-gts-helper.o
> /tmp/ccn9UpwF.s: Assembler messages:
> /tmp/ccn9UpwF.s:22: Error: junk at end of line, first unrecognized charac=
ter is `I'
> ...
> ...
>=20
> I had to remove the double quotes from the macros for all symbol exports:
> EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, "IIO_GTS_HELPER");
> to
> EXPORT_SYMBOL_NS_GPL(iio_gts_total_gain_to_scale, IIO_GTS_HELPER);
>=20
> However the x86_64 native build of the mainline kernel 6.13.0-rc6 on my l=
aptop went just fine with this patch.
>=20
> Regards,
> Subhajit Ghosh

Hi Subhajit,

You've run into a tree wide change wrt to those quote that went in just aft=
er rc1 of this cycle.
The error message is less than helpful and we've spent all cycle fixing the=
se up :(

Anyhow this is expected if backporting.

Jonathan



