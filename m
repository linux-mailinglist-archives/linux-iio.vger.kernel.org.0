Return-Path: <linux-iio+bounces-24950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA76BD0327
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46D304E69E4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81D727B359;
	Sun, 12 Oct 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcrscV4W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE918E377;
	Sun, 12 Oct 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278298; cv=none; b=EuZZe2FXsQZTuJgjsYXV7SoDcyD/4jMljrjq3OIBtWWu/M6BUiF7bzqQoxzOllcIUhVV4jQSepbt9QXhatDoOcou/vtYXwGCnDM4Cc0m0EsPdFIZZcaBG0ASaLuOWSrVyG7Ip+JmPr5QBzq6Z6xwS9g5SD4HimVvmBXET5RD9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278298; c=relaxed/simple;
	bh=cpelgZlbzwGj7MhV3R29pEzBYDKWbCZbtyCbea316yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIwyZ8eqExCff7CjYyB6Xmn7s7eID+ur8Bw/NXX3ZpPBciSINoLdXup5B6kyulX+8OqBWGgK0W7IM0AREEACiqG+b0zrgjL56Z9fvqylpHiJ4N+emPazvQTM8MrmyZnz1cJeqLnvaYRjFiPM5ORCoD12+DszARJhYjMdidwmSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcrscV4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858A9C4CEFE;
	Sun, 12 Oct 2025 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760278298;
	bh=cpelgZlbzwGj7MhV3R29pEzBYDKWbCZbtyCbea316yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tcrscV4W83if8LTwyuRjmTM5YSu2pAwlGYVJc6W+mqxxmoWztAVEB/OouUnTjgP+s
	 B6r7P9zVfVCBwYqievXwiBX6z4HX6uI6/alEoaypZfU+uBIVTQ7+3EIt922+phIAle
	 2QVVx1iBqIv/1hsmOXHGBFO24PqPmFxCXGhbJ3XN/GIRadQj6BZf8sInj6UCOLCich
	 BzAfl+DwJPqdqeB4pu/D0xFSUIxEToNkBWfEYtuTWQVEkcF8k4ZqFfbhNI1GTYli7+
	 TYbEsRet2MPTglesbsumJKR/62qZGsa3AQS7V2QQeflhc+Om9XgouT/oxPnSVmYHVG
	 RRbH/lsQvL6VQ==
Date: Sun, 12 Oct 2025 15:11:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 matt@ranostay.sg, skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width
 property
Message-ID: <20251012151130.797450e3@jic23-huawei>
In-Reply-To: <CAHc1_P7MU=BYf_8sbZqikpXpfuvAtLNJ2E_hmi-50ohoh+gQcg@mail.gmail.com>
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
	<20251004015623.7019-2-raskar.shree97@gmail.com>
	<20251004141231.632c311d@jic23-huawei>
	<CAHc1_P7MU=BYf_8sbZqikpXpfuvAtLNJ2E_hmi-50ohoh+gQcg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 08:34:03 +0530
Shrikant <raskar.shree97@gmail.com> wrote:

> On Sat, Oct 4, 2025 at 6:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sat,  4 Oct 2025 07:26:22 +0530
> > Shrikant Raskar <raskar.shree97@gmail.com> wrote:
> > =20
> > > The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
> > > 800us, 1600us). These settings affect measurement resolution and power
> > > consumption. Until now, the driver always defaulted to 1600us.
> > >
> > > Introduce a new device tree property `maxim,pulse-width` that allows
> > > users to select the desired pulse width in microseconds from device
> > > tree.
> > >
> > > Valid values are: 200, 400, 800, 1600.
> > >
> > > This prepares for driver changes that read this property and configure
> > > the SPO2 register accordingly.
> > >
> > > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com> =20
> > Hi Shrikant,
> >
> > Explain why this is in some way related to characteristics of how the
> > system containing this chip is built (wiring, lenses etc).  Otherwise
> > this might instead be something that should be controlled from userspace
> > not firmware.
> >
> > Also, give a little more on why we care about controlling it at all.
> > Is there a usecase where power use of this chip matters?  Mostly I'd ex=
pect
> > it to be in measurement equipment with relatively short measuring perio=
ds.
> >
> > Jonathan =20
> Hi Jonathan,
>=20
> Thanks for the feedback.
>=20
> The pulse width configuration is indeed dependent on the hardware integra=
tion
> of the MAX30100. It affects how much optical energy the LEDs emit per sam=
ple,
> which in turn depends on physical factors such as:
>=20
>  - The type and thickness of the optical window or lens covering the sens=
or
>  - The distance between the LED and photodiode
>  - The reflectivity of the skin/contact surface
>=20
> For example:
>  - A smartwatch/wearable ring with a thin glass window can operate
> with 200=E2=80=93400 =C2=B5s pulses to
>    save power, while
>  - A medical-grade pulse oximeter or a sensor mounted behind a thicker
>    protective layer may require 800=E2=80=931600 =C2=B5s for reliable sig=
nal amplitude.
>=20
> I believe it would be appropriate to describe these fixed,
> board-specific characteristics in the Device Tree,
> since they are determined by the hardware design rather than being
> runtime or user-controlled parameters.
>=20
> Would it be okay if I send v2 of the patch with the above explanation
> included in the commit message?
Hi Shrikant,

I'd have this excellent detail + examples summarised in the patch descripti=
on
and also a small amount of description in the actual binding even if that j=
ust says
something like
   Description:
     Pulse width in... . Appropriate pulse width is dependant on factors
     such as optical window absorption, distances and expected reflectivity
     of skin / contact surface.
That's just a quick mash up of what you have above, feel free to not use th=
is
particular text!=20

The inclusion of target surface reflectivity in there makes me thing that
for some applications we may also need userspace tweaking or some algorithm=
ic
way to increase or decrease the value according to skin characteristics. Ho=
wever
I guess maybe it isn't that sensitive.

Jonathan

>=20
> Thanks and regards,
> Shrikant


