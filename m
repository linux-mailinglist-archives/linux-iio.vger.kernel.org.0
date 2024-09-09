Return-Path: <linux-iio+bounces-9365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104F97100A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AE01F22C38
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F271AD5C1;
	Mon,  9 Sep 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHpKd5Y/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2022081;
	Mon,  9 Sep 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867926; cv=none; b=eGHtyz+VHJSGGJ0Ch6O3vw4hEH720vYBKQVN1t95ih2hl/CNu4dQ3fC22J0yPaIaQ29/ggEnc24/qi3E3U9N6hUjF5VRgKbtiTTBliqaslfBtCsF9fzqReiqYmXlhOIsdQUNA+wCwrxjIqWXDToKLX3bY8AKMjniBD6nlAvog1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867926; c=relaxed/simple;
	bh=98wllfeOjQQOsjMIWtvuLiG8VAzd5cCOmswCZsBuOWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJ/tdp31J+Loj3ksI/XlDucSAclzPtFvjbjeSLxE4Xvt5XcRwo0NEKHCKzmFKc4vPHkN6A5h00lWCwARCGN0NzL3IpVF7NBkBIngAF1+iQmGFzxVlHAAH3u852jQAkv8hp/d7s9GODeqLXJC8q/h1YO4RbgDSZGb+YKpD392+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHpKd5Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9CBC4CEC5;
	Mon,  9 Sep 2024 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725867924;
	bh=98wllfeOjQQOsjMIWtvuLiG8VAzd5cCOmswCZsBuOWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHpKd5Y/V3O48F+S3tN2AaqN4z/c5/Y1W/1t/tW/BS5Lr1mNGI/uYlXn0w/LgLm79
	 mdaqWqJVkkzzjmoFakgzDNW0/C+FvYsBzb/TNWnYG+wqS4DJdSSzXDqTMlHTqeHWb1
	 F2Hp5SPc0QI8L/60zM7+CGsr6xT3bunjxehvPN8Y7+arrOY9aTbBPYmIMD5rNGeGuV
	 /GhSRN2zvjosfV9sah8j2+NBquJRPLKhSSztnfNQtHy1EI8brLmu8F9Oq9UQK6KY/c
	 ET+wuXhvMJigZVDL5OceZqCJc6nnCC0n7C2UF5zTECspN/GGfa9YjKq77omD7IbbZp
	 7MyZKyqTVM+QA==
Date: Mon, 9 Sep 2024 08:44:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, mitrutzceclan@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 0/3] Add support for AD4113
Message-ID: <20240909084444.5b515bb1@jic23-huawei>
In-Reply-To: <20240908114143.414a9367@jic23-huawei>
References: <20240812-ad4113-v3-0-046e785dd253@analog.com>
	<20240817111902.2ed6b98a@jic23-huawei>
	<20240908114143.414a9367@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Sep 2024 11:41:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 17 Aug 2024 11:19:02 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Mon, 12 Aug 2024 11:13:13 +0300
> > Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.o=
rg> wrote:
> >  =20
> > > This patch series adds support for the AD4113 ADC within the existing
> > > AD7173 driver.
> > >=20
> > > The AD4113 is a low power, low noise, 16-bit, =CE=A3-=CE=94 analog-to=
-digital
> > > converter (ADC) that integrates an analog front end (AFE) for four
> > > fully differential or eight single-ended inputs.
> > >=20
> > > The part is not released yet and the documentation is not public.
> > > Register map is identical to AD4114 besides the lower width data
> > > register and the GPIO register.
> > >=20
> > > Particularities of this model:
> > > - 16 bit data register
> > > - no temperature sensor
> > > - no current inputs
> > > - input buffers
> > > - internal reference
> > > - external reference REF-/REF+
> > > - no second external reference REF2-/REF2+
> > > - no AVDD2 supply
> > > - 2 GPIO pins with config bits starting at a higher position in regis=
ter
> > > - 8 VINx inputs with voltage divider
> > > - 16 channel registers and 8 setup registers
> > >=20
> > > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>   =20
> > Hi.
> >=20
> > Series is fine, but I don't yet have the fix=20
> > [PATCH] iio: adc: ad7173: Fix incorrect compatible string
> > in the upstream of my togreg branch.
> >=20
> > Hence this will have to wait a little while for that to be present.
> > Otherwise this will create a fiddly merge for linux-next etc. =20
>=20
> Tree juggling didn't go entirely according to plan so unfortunately
> this has slipped back to next cycle unless there is a delay in the
> 6.12 merge window opening.
>=20
> Sorry about that, and I'll make sure to queued it up nice and early
> after rc1.
Applied now.  Given Linus wasn't super clear on whether he plans to
do an rc8 I might still send a speculative pull request in case
there is a delay.  If so I'll do that in a few days after this
as first sat in my testing branch for 0-day to look then togreg
branch hence Linux-next for a day or two after that.

Jonathan

>=20
> >=20
> > Jonathan
> >  =20
> > > ---
> > > Changes in v3:
> > > - lowercase chip ID
> > > - add patch to correctly order chip IDs defines
> > > - picked up RB and ACK tags
> > > - Link to v2: https://lore.kernel.org/r/20240809-ad4113-v2-0-2a70c101=
a1f4@analog.com
> > >=20
> > > Changes in v2:
> > > - correctly set realbits and storagebits to 16 in iio_chan_spec
> > > - describe bindings restrictions in commit message due to lack of
> > >   sufficient diff context
> > > - describe model differences better in cover letter
> > > - Link to v1: https://lore.kernel.org/r/20240807-ad4113-v1-0-2d338f70=
2c7b@analog.com
> > >=20
> > > ---
> > > Dumitru Ceclan (3):
> > >       dt-bindings: adc: ad7173: add support for ad4113
> > >       iio: adc: ad7173: order chipID by value
> > >       iio: adc: ad7173: add support for ad4113
> > >=20
> > >  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    |  3 ++
> > >  drivers/iio/adc/ad7173.c                           | 38 ++++++++++++=
++++++++--
> > >  2 files changed, 39 insertions(+), 2 deletions(-)
> > > ---
> > > base-commit: 1c61e13d7dc9003662bd7fd6064dfea67e64b014
> > > change-id: 20240725-ad4113-baa63ff99245
> > >=20
> > > Best regards,   =20
> >=20
> >  =20
>=20
>=20


