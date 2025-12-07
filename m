Return-Path: <linux-iio+bounces-26879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F02BCAB598
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2751A304A10E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9B02E9759;
	Sun,  7 Dec 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJvmZs3e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E52877DE;
	Sun,  7 Dec 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765115169; cv=none; b=nAXYI1l1Pq+fxavpBP24xolT6Zao6yWas0ZTkdihm4+dsKVNOo0hw7/lV1oJcEgZrZS/U4J+qZd2RrVEJLgqtSv8Ad9+zlWJ70hwGX1kzxM1p6DTbOTKH/nIRXAczFU9CtA8LOBM2m3iWo2xnCH+dncdYkPHPTKTKLzhu6IRkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765115169; c=relaxed/simple;
	bh=r/00iAWlY7SLMd+fAHNLHF5/Y87k58WdddwUGmEqjmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJZrmnKVnvU0S3Y+FTUx5FGD3d1wIRkZ1ZVA6UynFqstTRGNUEZA/+yLKQTtiK0A3yjefIJeub9ZQSoUKVFsS/p3QfgrHlh6zwKj2+isgCokPCqmaE0fPgXKFeqUvQhFh2IW3rB6EXpOgUdXMMex7sjYGoqABfZqxpOHe81KqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJvmZs3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24D3C4CEFB;
	Sun,  7 Dec 2025 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765115168;
	bh=r/00iAWlY7SLMd+fAHNLHF5/Y87k58WdddwUGmEqjmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NJvmZs3e8R/05oavHx11wtwRSUV2q9Lc7kg4swMmDaURdBFWgxVeES5NjG2jgYc/3
	 g+c3++HEPHFe8QQ+RgFclDS+9RvUn02+yL8Y7xSdZjW69Vw4mscT4Y+gmHzFYOosRI
	 yucEX5co+JGbeY5m6vcMaqibxW+Mlrsh2AB+QxaL/2tQtplHtL8GYoo3ewWsNllRKD
	 VlW5Yghl8x5WDRYwfDtmmug5CciVcDN37jiFa/4zihw/b0Szpcgn/MlnwBSchHMERs
	 0ftEhu6ulhDHpK6HyJsHi3TYotd108LscrEsVmnv422lUZAXFKgNCyIqGhkVgpemE8
	 6t8aMMfuPJwqQ==
Date: Sun, 7 Dec 2025 13:46:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Marius Cristea
 <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 stable@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: PAC1934: Fix clamped value in
 pac1934_reg_snapshot
Message-ID: <20251207134600.1afee57e@jic23-huawei>
In-Reply-To: <CAHp75VebjUo2JH49tmuOvgjKUbsUmZg0C461wwvL-bRaDd5C9Q@mail.gmail.com>
References: <20251202181307.510970-2-thorsten.blum@linux.dev>
	<CAHp75VebjUo2JH49tmuOvgjKUbsUmZg0C461wwvL-bRaDd5C9Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Dec 2025 20:47:37 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 2, 2025 at 8:13=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
> >
> > The local variable 'curr_energy' was never clamped to
> > PAC_193X_MIN_POWER_ACC or PAC_193X_MAX_POWER_ACC because the return
> > value of clamp() was not used. Fix this by assigning the clamped value
> > back to 'curr_energy'. =20
>=20
> ...
>=20
> >                         /* add the power_acc field */
> >                         curr_energy +=3D inc;
> >
> > -                       clamp(curr_energy, PAC_193X_MIN_POWER_ACC, PAC_=
193X_MAX_POWER_ACC);
> > +                       curr_energy =3D clamp(curr_energy, PAC_193X_MIN=
_POWER_ACC,
> > +                                           PAC_193X_MAX_POWER_ACC);
> >
> >                         reg_data->energy_sec_acc[cnt] =3D curr_energy; =
=20
>=20
> Hmm... Maybe
>=20
>                        reg_data->energy_sec_acc[cnt] =3D clamp(curr_energ=
y,
>                                            PAC_193X_MIN_POWER_ACC,
>                                            PAC_193X_MAX_POWER_ACC);
I went with aligning after ( and slightly longer than 80 char lines.
other combinations didn't seem to read quite as well to me.

Applied to the fixes-togreg branch of iio.git.  I'll probably sit on pushing
that out until I can rebase on rc1 however.

Jonathan

>=20
> ?
>=20


