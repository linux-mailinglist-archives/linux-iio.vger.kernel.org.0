Return-Path: <linux-iio+bounces-23477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48FB3CDEE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B041BA398D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5202D97A5;
	Sat, 30 Aug 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Ktqxky"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599E2D979C;
	Sat, 30 Aug 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573769; cv=none; b=RxQtsoc6n965XG06cjYbM7TsKuLE5m0G7Y18cUhG94O5ubIgW9R3rWQ77rVjuvUjis2vtvfRoqSe61IuEd71AgQmaHpdZMPV7gGLqkutRWvQ1P59CwRdG2DYBxEwL+lf7HODUCw3NQnOBqDJXOPk9bWpiNssVFtJtO2C0A0yOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573769; c=relaxed/simple;
	bh=FtxPPyNuw4U9qVMKLMJMATKus4c7mqAcfqCTrBpLyno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0iks8Z3u++Mroizs7pMK5Qo9wEgDIwJjoduBc4awXLP3MHX2GPinqVANs11VtfBTnNjjRdc9PJ3Zx7fX/PpyKDgxa+qALHlZz8d01rNK60Y84TYeW9nJemNQvBl+0diNXgSJ08vgGrawnzL/zD+lPfh3tUD1WUH+Pu2iAZP4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/Ktqxky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33BCC4CEEB;
	Sat, 30 Aug 2025 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573769;
	bh=FtxPPyNuw4U9qVMKLMJMATKus4c7mqAcfqCTrBpLyno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m/KtqxkyZjy4qwZDnSviWqEoup0UG7NcO0GEPJPnAxu4mdk2h2lVPS5ZxnOzz0NQR
	 uASrHC9+i9RZ1DccEshPSN8+YMQ4tLh4Oubdm0gf7gZa0wqXO9OwUZJGvat9Eap69s
	 C83lRqQ4HvLq2+01ytws1tnMR1tS34v3w7AQS7l0dtvK44aObJcEgFjsC7gKj1qOKN
	 0d9UIuANFIFWwWcFqvRehILMfXL3Uc51Kf/XhYMzIi0lbhiSzvYlCn+NVSpAQr3mhG
	 lG2VCy3Uov74fTRP8ZW0vYtEL4yNC1L753EM7YU7mnwxBKZ7u0X3enOe9cLC9Ink3Z
	 gypKFGP0GNKHQ==
Date: Sat, 30 Aug 2025 18:09:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, lanzano.alex@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: ABI: document accel and roc event
 attributes
Message-ID: <20250830180920.7a65df94@jic23-huawei>
In-Reply-To: <20250830180534.24a8ad56@jic23-huawei>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
	<20250830115858.21477-3-gustavograzs@gmail.com>
	<CAHp75Vf13aqDJj2j7MtfLTAT2MW-S3+M7wtEXsG1Wh7EKfxJSQ@mail.gmail.com>
	<20250830180534.24a8ad56@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 18:05:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 30 Aug 2025 15:49:50 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs@gma=
il.com> wrote: =20
> > >
> > > Add accelerometer and rate of change event-related sysfs attributes
> > > exposed by the bmi270 driver.   =20
> >=20
> > Seems to me like the absent attributes that are already in the kernel,
> > should be added in the separate patch. =20
> Agreed that would be ideal.

Actually what did you mean by absent attributes?=20

This is documenting ABI that is part of the general 'scope' of the full
IIO ABI but which hasn't turned up before in this particular combination
(or possibly we missed updating docs when it did!)

Whether it is worth separating out any we know are in another driver is
an open question, but Gustavo hasn't called out any as being like that.
It's possible that these are all surfacing for the first time in this drive=
r.

Jonathan

> >=20
> > ...
> >  =20
> > > +What:          /sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising=
_en   =20
> >=20
> > Out of curiosity, is it for real? I mean & (ampersand) in the sysfs
> > attribute name? This is quite inconvenient for use in shells. =20
>=20
> Yup.
>=20
> Easy enough to escape...
>=20
> It's really wordy to express boolean relationships without using symbols.
> This has been in the ABI all the way back to the beginning I think.
>=20
> Jonathan
>=20
> >  =20
>=20


