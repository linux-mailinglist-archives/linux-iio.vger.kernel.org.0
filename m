Return-Path: <linux-iio+bounces-12525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9F9D6968
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43C0281AC4
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADA17588;
	Sat, 23 Nov 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlLGrl/S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088FA94A;
	Sat, 23 Nov 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732371869; cv=none; b=CVjSk3Q/K6jexvGE8XvNGrw1a6O+CzbAO/rhJjpCf4t3A4CmKAavAdnIk4MgAEB4TrV8VuxHxr/yVj7h6bEVxB9Hp6kcTTkK1SsF/IKGIBot9gJK611/YVisWIq/VSw0xcFFZKAJrn+yPiGZEOowv1iWLMIcaxg929bQQg45Zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732371869; c=relaxed/simple;
	bh=21pet+UbnZk6M3WD2Has0vbe6ZaGqUROrqpc2l3qUsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dc4z7G+NuUnRb/NdP/2Pa9Tye4BTiR3NUSMX4PfO0+wEo32Xi3gjMgJR8QNp7SY/7aM/0UjhoYrgkd14ajjlKdOnkAyuPdVb9E/eobundPrw7yLvzm1/fLGwRhydl2DcHenKuTYayWQ79csPP6K4qr53Qvkqckb0lqeflgaq9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlLGrl/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B42C4CECD;
	Sat, 23 Nov 2024 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732371868;
	bh=21pet+UbnZk6M3WD2Has0vbe6ZaGqUROrqpc2l3qUsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qlLGrl/Sxh4V5iTvEvoIndXr3fLiXPcpnWq36jinpfJMek0gUV8WBqlgEgwO6w/7b
	 1lMdze9qt+fYnZ3Apfd3X+xVz5k/Pd1HIjYa7l3fglPUocwUkvi6sMJ/AvBVceIMce
	 6hoYBAu4eUMCoDlVDuq6lXtT6U+wIcUdCYQg/GBNZpi9KYd4N0ndOLXNeJtKQx3+YX
	 R+O+LENwqTJx4+LdTSm7PHAHRLtXJjCD9imM7V2+/Y/kCWBX0/BeZYZp3FQ7G/LfYE
	 gNJ6vgnA9yZK/e35ossF2QBPTybvBhBa6DMPaFrUr57FearHEgYJxE2k2/0qcNihdG
	 AOZLsISR8MtvQ==
Date: Sat, 23 Nov 2024 14:24:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: adc: ad7124: Make it work on de10-nano
Message-ID: <20241123142420.7e20992a@jic23-huawei>
In-Reply-To: <fsx4mtvhqfoszazxflokargabseia2vs44necuuvinyhw5ggjf@c73ibquopv42>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
	<fsx4mtvhqfoszazxflokargabseia2vs44necuuvinyhw5ggjf@c73ibquopv42>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Nov 2024 19:12:22 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> On Mon, Oct 28, 2024 at 05:07:49PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > this is iteration v2 to make ad7124 work on de10-nano. (Implicit) v1 is
> > available at
> > https://lore.kernel.org/linux-iio/20241024171703.201436-5-u.kleine-koen=
ig@baylibre.com.
> >=20
> > The changes since v1:
> >=20
> > - Write 0 instead of 0x0001 to disable channels. While 0x0001 is the
> >   reset default value for these registers (apart from the channel 0 one)
> >   there is no sensible reason to use that value (i.e.
> >   AD7124_CHANNEL_AINP(0) | AD7124_CHANNEL_AINM(1)) as the value is
> >   reprogrammed before use anyhow. This addresses the feedback that the
> >   magic value 0x0001 should better be constructed using register bit
> >   field defintions.
> >=20
> > - Add maxItems: 1 to the new property defined in the binding patch (Krz=
ysztof)
> >=20
> > - Rename property to rdy-gpios (Rob)
> >=20
> > - Use rdy-gpios only for gpio reading and continue using the usual irq
> >   defintion for the interrupt (Jonathan). I was surprised I can use bot=
h the
> >   GPIO as input and the matching irq.
> >=20
> > - patch #1 is new, and use GPIO_ACTIVE_LOW in the gpio descriptor
> >   instead of 2.
> >=20
> > Jonathan voiced concerns about the reliability of this solution and
> > proposed to implement polling. I'm convinced the solution implemented
> > here is robust, so I see no need to implement polling today.
> >=20
> > Still open questions:
> >=20
> >  - Is rdy-gpios the right name. The line is named =CC=85R=CC=85D=CC=85Y=
, so maybe nrdy-gpios? Or
> >    nRDY-gpios? =20
>=20
> David said that rdy-gpios looks right in combination with the
> GPIO_ACTIVE_LOW flag. Makes sense to me to negate only in a single
> location.
>=20
> >  - Jonathan wanted some input from ADI about this series and the
> >    hardware details. =20
>=20
> I think the hardware is understood now reasonably well and from the
> discussion with tglx it's also clear that the issue is expected and
> fixed at the right place. Although probably not all hardware
> configurations can benefit from the modification, I still consider this
> a beneficial modification because it allows at least some (most?)
> machines to use the irq instead of polling.

Agreed. Sorry for slow response; day job got too busy for a while.

>=20
> There is a patch series on the list for ad7124
> (https://lore.kernel.org/linux-iio/cover.1731404695.git.u.kleine-koenig@b=
aylibre.com/)
> that for now didn't get feedback, and I found another race condition in
> the sigma_delta driver helper and now wonder how to proceed here. If we
> agree in general that the rdy-gpios patches are ok to be applied, I'd
> base the fix for the latest race condition on top of these. Should I
> better collect all in-flight patches in a single series, or just post
> the new patches (with a proper --base=3D parameter to format-patch)?

Subject to perhaps adding a little more docs to the DT patch to strongly
encourage use of the GPIO binding if IRQ controller capable (or double wire=
d)

Make sure those patches were you feel a fixes tag is appropriate go first
(which incidentally includes patch 4 from this series and some or
all of other series).

Given we are very early in the cycle I'll pick the fixes up and get them
upstream soon after rc1 then we can queue up the bulk of this which is=20
a little complex to consider a fix as material for next merge window.
We can think about backporting after that.

Jonathan

>=20
> Best regards
> Uwe


