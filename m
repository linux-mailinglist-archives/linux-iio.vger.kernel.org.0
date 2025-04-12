Return-Path: <linux-iio+bounces-18015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C79A86E18
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663C3173496
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C451F9EC1;
	Sat, 12 Apr 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOrrINKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778E2A8D0;
	Sat, 12 Apr 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744474771; cv=none; b=BcObSKLx2q3d9aPgU2AmqC06aVdAYQCKZ/T7momgT2DyhWKATjeSzAeWjLuurScVYPxltb78+P2nvUNEbRzyeFooLaftQzjikJ8QAcRXQS7I9kT1csZmhh6U8EFydVsfXjc/KyAeO8TmeY0V/eoTSsc9T0GKgfroAwmzBzX7PYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744474771; c=relaxed/simple;
	bh=41lcGdogk8QxjXxifMc4aVyEcFCDTgOMIQ5Ie8YuTlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQLFF+8CdM2urO3XF64KB6LV/BXRqvrCh8Jj7GtVqhxq2wGHEN/uoDD7ZNAYwjM2EHEiIN+hyVVzqahFaLDMCstwLjrtRRcEUR0Izdbjlkvofe0uoQgsKprdWZGInq4aBXTMRvJrq5cG242xGJ+YS1u5ZJ3iUD3mXdfjtzwGprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOrrINKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F27EC4CEE3;
	Sat, 12 Apr 2025 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744474770;
	bh=41lcGdogk8QxjXxifMc4aVyEcFCDTgOMIQ5Ie8YuTlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOrrINKaw10qWfM81OVLsNlnlRo+RanvSzanZMKBbrjmxh8wNWD6Zn2f3jgtWX8Ta
	 3HWHS68W3xCdK/tzmgrOJVeBIFCoj5l1QLOIr/JgpcBd5lZEt7Sh6sU40FCsWoOBlm
	 xnb0AWTGZCe1ygnNLVlszwqcFvipZUlIqstIVfirId+GV0CX4NB/eN0d8ta0ElYqim
	 vioVCqrYMtpZHS8YgSaygAEARk9RyqhiCvwsAjkeHybB2wC0EZi7R2Td9IKwMQdm53
	 snrv6uOVo3iGsQ7DGbImPUVm0HTJFbd6tQD0Hx1YCpS7Xh6Jmtu7rd/vqNJvTzv9Ux
	 9Olzku7n4uAsA==
Date: Sat, 12 Apr 2025 17:19:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ana-Maria Cusco
 <ana-maria.cusco@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1 2/7] iio: adc: Add basic support for AD4170
Message-ID: <20250412171920.531993c1@jic23-huawei>
In-Reply-To: <Z_k3e1DfxmcJgQeu@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
	<5f79007f0b9f9f67360d04fb904b6a59111a4ebe.1744200264.git.marcelo.schmitt@analog.com>
	<9c115086bd574b6c778a093143ebf54e14d7202b.camel@gmail.com>
	<Z_k3e1DfxmcJgQeu@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 12:38:35 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Nuno, thank you for your review.
> I've already applied most of your suggestions.
> Also providing answers to some questions inline.
>=20
> Thanks
>=20
> On 04/10, Nuno S=C3=A1 wrote:
> > Hi Marecelo,
> >=20
> > First, superficial look...
> >=20
> > On Wed, 2025-04-09 at 09:24 -0300, Marcelo Schmitt wrote: =20
> > > From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > >=20
> > > Add support for the AD4170 ADC with the following features:
> > > - Single-shot read.
> > > - Analog front end PGA configuration.
> > > - Digital filter and sampling frequency configuration.
> > > - Calibration gain and offset configuration.
> > > - Differential and pseudo-differential input configuration.
> > >=20
> > > Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> > > Co-developed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > --- =20
> ...
> > > +	ret =3D ad4170_set_channel_enable(st, chan->address, true);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	reinit_completion(&st->completion); =20
> >=20
> > I would do the above right before wait_for_completion_timeout()... =20
>=20
> Ack. Changed accordingly.
Hi Marcelo,

A general efficiency comment.  If you agree with a comment, no
need to reply.  Better to crop that bit of the thread out and
reply only to those parts where there is more to add.

Cuts down on what reviewers need to read!  We assume anything
you don't comment on is something you are happy with changing as
suggested!

I normally only point this out to people who are sending a lot
of code as it's just not worth it for one time contributors.
So bad luck you get me being fussier ;)


> > > +	ret =3D devm_regulator_get_enable_read_voltage(dev, "refin1n");
> > > +	if (ret < 0 && ret !=3D -ENODEV)
> > > +		return dev_err_probe(dev, ret, "Failed to get REFIN- voltage.\n");
> > > +
> > > +	/* Negative supplies are assumed to provide negative voltage */
> > > +	st->vrefs_uv[AD4170_REFIN1N_SUP] =3D ret =3D=3D -ENODEV ? -ENODEV :=
 -ret; =20
> >=20
> > Maybe to early for me but the comment does not make it clear to me why =
the negation?
> > Won't the regulator return a negative voltage? =20
>=20
> devm_regulator_get_enable_read_voltage(), regulator_get_voltage(), and an=
ything
> about reading the regulator voltage returns either a positive voltage val=
ue or
> a negative error code. I couldn't find out how to read a negative voltage=
 with
> regulator API. So, for now, this is making the simplifying assumption that
> the negative end of external reference supplies is always below GND level=
 (even
> though they could be positive).

Hmm. We went around this a long time back but I can't remember what the out=
come was...
https://lore.kernel.org/linux-iio/544AC56F16B56944AEC3BD4E3D59177137546EF3F=
C@LIMKCMBX1.ad.analog.com/=20
looks like the thread.

Take a look at dac/ad5791.c for example of a negative reference

Michael might remember more of that discussion than I do!

Jonathan



