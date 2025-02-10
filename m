Return-Path: <linux-iio+bounces-15294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC3A2F84E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05BE188346E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428B255E4A;
	Mon, 10 Feb 2025 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN2pH9Uj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79525E446;
	Mon, 10 Feb 2025 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214842; cv=none; b=avJ/B35RcYehrFxxrMuKwQ+Ngw+ZlOYankrrGNAR8PW8jPeh2SWYGNmyKt8pSBqLIqq1pqrpYn1NF/zWyMzj1YThserPocNghNfi9X0kWN68Pc0NOrvx7B/IEWVu3kWURGuEP+l0Ij/BgSfyNDfN57KCusOQ6ZdmSLCChyN+7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214842; c=relaxed/simple;
	bh=YcW+2eFFzbmPCe3JhfvRYhPVBqbOEm6Ln8AAUcfHWF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VV2fTJGW1Uex9bbtFpj6AD42yJATAHzzyEt2a7k9N5YqAejzmVIo8msFxQedXpx+hBTdUEIENnILZK8aMzUyFxB4U7lqqXZD7rPFDcczRBQfq0UoYvKtWdH7JpC7Oc3vTwlymvJ6Q33G5V8nvugXwo7QEmTRk9IBzOJ+S1EuDpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN2pH9Uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B205C4CED1;
	Mon, 10 Feb 2025 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739214841;
	bh=YcW+2eFFzbmPCe3JhfvRYhPVBqbOEm6Ln8AAUcfHWF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hN2pH9UjA/vcFMiM+zn7sTlyHQC6ygzsCHEEgCX8baLutXCQGmO8E1+jLfms1uWO2
	 8SacABlvN4wwnieogv5vR4ncHap4ESDHFWwNzEbADT4wzUL9XDsgr8bI92n3iqy1uZ
	 2hW4yP/ga3MkJ2ND813k6UA6CNOotO91QXdsgYJrs/+TX53UdMsnMfO2RtNGNE0gWo
	 b37rwhXnitMmi6lB35HtHgPfnOCZBQ3QaFG/mBnoal9G2aM9rSrEPwdIwT/G5Z9/DH
	 jFXR7GVrS7VAwJ2RIaVBxsuGcVtzcOAYDhRN5GmhNpZzNTCSxiycDugW2y+MqkaC5A
	 6UUCd+g0qXejQ==
Date: Mon, 10 Feb 2025 19:13:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello  <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich	 <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron	 <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: adi-axi-dac: drop io_mode check
Message-ID: <20250210191353.2a5fcd4b@jic23-huawei>
In-Reply-To: <2ae962c19bc9d180dabf52e256a1d6bf215f9bf0.camel@gmail.com>
References: <20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-863a4b2af4ea@baylibre.com>
	<20250208154521.193da461@jic23-huawei>
	<2ae962c19bc9d180dabf52e256a1d6bf215f9bf0.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2025 10:05:47 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2025-02-08 at 15:45 +0000, Jonathan Cameron wrote:
> > On Thu, 06 Feb 2025 09:36:14 +0100
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >  =20
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Drop mode check, producing the following robot test warning:
> > >=20
> > > smatch warnings:
> > > drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode()
> > > =C2=A0 warn: always true condition '(mode >=3D 0) =3D> (0-u32max >=3D=
 0)'
> > >=20
> > > The range check results not useful since these are the only
> > > plausible modes for enum ad3552r_io_mode.
> > >=20
> > > Fixes: 493122c53af1 ("iio: dac: adi-axi-dac: add bus mode setup")
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com> =20
> > Ah. I missed this.=C2=A0 Anyhow made the same change directly so all is=
 well
> > than ends well!
> >  =20
>=20
> Hi Angelo, Jonathan,
>=20
> I wanted to reply to this one when I saw it but I haven't done right away=
 and
> then totally forgot. Sorry about that!
>=20
> I don't really agree with the "fix" in this patch. AFAIU, smatch is compl=
aining
> since the enum is apparently defaulting to an unsigned type which means d=
oing
> the >=3D 0 check is useless. But we should keep the upper bound...

Why? It's an enum so unless we are messing around with deliberate casts the
compiler should always be able to spot this. The check may be needed on a f=
uture
date if we add more types to that enum.

So I agree the check wasn't terrible and perhaps acted as hardening but it
isn't strictly speaking doing anything today.

Jonathan


>=20
> - Nuno S=C3=A1
>=20


