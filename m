Return-Path: <linux-iio+bounces-27873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA8D38536
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1F18301AAB9
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538F39E6D4;
	Fri, 16 Jan 2026 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8/IOx3X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30B8348479;
	Fri, 16 Jan 2026 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590073; cv=none; b=L0iS/2XJ90vYPF95WcSsfRFaNq79L+HRosCmkN2r/fXh+k58af/MCqsS8RpyH62eBUW6zK6EdgDun6X3P7hKWwh3nkkiUNB3XErdxNGXGlf2c35PocLfEzFOgixb9MqUDwQGGcq088mLXjoZ7EXf2o/BDUmK86d6AMjmSqiBAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590073; c=relaxed/simple;
	bh=BGypM29OFRA9X1JSsv3JMYLxhZfLOCLx+WtXO1e3QAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7iNOEf+lDU8H8jCbhIcvv8cMIehwIzPAAYtc91+hs13bSG3cjcmA+Dfu3FQRF1cYvHa5rl5uSbMxcFEqTeOVbUoq3dPZQQ4Tkddc0EdiMI0urmi4B29wdgT49e+R8o2aM0H8/iE6XUOUA4JB85rMzz7ReWPGxkx74SYQg/gdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8/IOx3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E23DC19424;
	Fri, 16 Jan 2026 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768590073;
	bh=BGypM29OFRA9X1JSsv3JMYLxhZfLOCLx+WtXO1e3QAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i8/IOx3XYq6t5phSAHp53oPdi1invuCo7R7bNn4v5rcwQodjHCQX8is5O9BerJGTO
	 rU7ZZWuIOyjzoc8yyBJsHkd1ZQYHlfSalRZDP69eMh0z+Iaa2iJDZjfSqMKT1Rg0Kd
	 ETLY/n6Fc3D8dsMdx3YZZcZq3ACWKIgDlEs3qXpCXPDZbGfSw9ZiBuaSVYv+PZuY17
	 Jfo71pduDfkIJ4dDsm0QbuKcQEZP1UIDOg/Z+AVoz6nNWr4QkkmTwx/UMmCVvbsvZ1
	 1Q6Kyfa7jYtX2iPBJQof1Q4nJ8SK84eYpPvafP9no9xJtSZEkSqxAcfpij1nJXwIUi
	 d6qKa2SQhkhwQ==
Date: Fri, 16 Jan 2026 19:01:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, Andi Shyti <andi.shyti@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 2/7] units: Add HZ_PER_GHZ definition
Message-ID: <20260116190102.50908d50@jic23-huawei>
In-Reply-To: <aWpYwJUp7Wl0s_Qe@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
	<20260116-adf41513-iio-driver-v4-2-dbb7d6782217@analog.com>
	<aWpYwJUp7Wl0s_Qe@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 17:26:56 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> +Cc: Andi
>=20
> On Fri, Jan 16, 2026 at 02:32:21PM +0000, Rodrigo Alencar via B4 Relay wr=
ote:
> >=20
> > New PLL IIO driver supports output frequency of several GHz.
> > The new define helps to constraint DT properties and frequency
> > calculation parameters. =20
>=20
> There is already pending patch to add this in I=C2=B2C host controller su=
bsystem.
> On one hand the conflict, if any, is easy to resolve (the other patch adds
> a couple of comments). On the other we are at almost rc6 and it seems DT =
people
> are not happy about something, which would mean that the series most like=
ly
> will miss next merge window.

Linus is planning an rc8 so this 'might' merge this cycle.

https://lore.kernel.org/all/CAHk-=3Dwib+MG0grZgub=3DSkCpPnNXPFE1nHsDpFQz1sB=
wOsrV_VQ@mail.gmail.com/

>=20
> So, the solutions are:
> - do nothing and resolve conflicts, if any
> - define this constant locally in the respective IIO driver and drop it a=
fter merge

Do that and shout about it in the patch description.  If I merge this next
cycle I can clean up.

> - postpone this series to the next cycle (effectively drop this patch)
> - ask Andi to provide an immutable branch / tag with I=C2=B2C host patches
> - ask Andi to provide the only that patch in immutable tag / branch, but =
it
>   will require him to rebase his tree
>=20
> I'm skeptical about last two options on the grounds on how the IIO works =
and
> possible rebase requirement (which is not good to have).

Not worth it for a single define.  I do have a request out for an i3c fix
that effectively the same request, but that's for breakage that otherwise
requires ifdef magic to work around (which I'll still do if no progress
in a few days).=20

Thanks for highlighting this Andy. Whilst I saw the i2c series, I've
slept since then so might well have forgotten that!

Jonathan


>=20
> I leave it to you and the respective maintainers to make a final decision.
>=20
> > diff --git a/include/linux/units.h b/include/linux/units.h
> > index 00e15de33eca..06870e9e90b8 100644
> > --- a/include/linux/units.h
> > +++ b/include/linux/units.h
> > @@ -27,6 +27,7 @@
> > =20
> >  #define HZ_PER_KHZ		1000UL
> >  #define HZ_PER_MHZ		1000000UL
> > +#define HZ_PER_GHZ		1000000000UL
> > =20
> >  #define KHZ_PER_MHZ		1000UL
> >  #define KHZ_PER_GHZ		1000000UL =20
>=20


