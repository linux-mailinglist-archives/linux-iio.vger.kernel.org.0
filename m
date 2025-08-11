Return-Path: <linux-iio+bounces-22608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80A2B21694
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 22:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2343D1A24096
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 20:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22F2DCBFC;
	Mon, 11 Aug 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL4oCX7r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E54EB38;
	Mon, 11 Aug 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944577; cv=none; b=ZSaoZetNdPcq6EbgLZjPYO8J0s0pNZNvxqLqsxrgtDHlmrR9+bvXLhIsEqDy3IEDqse1b3n4XksW1ZCjLrD+3F8VPNZaEQ+otDOXSwsQnZU6IS8DLB6jb+wIas7qzCKmQkZBuXoYniIB4rrYBs5zQ8itEZfo/jB01yC6txQ8Vkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944577; c=relaxed/simple;
	bh=MGbXEJllcmiA1o9/olIkysp980KeZrJPHmr5Txjw5k8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REFsE9FYMTt+0En6aSygq/a6DtJNsZSlEudvTQWDYnqyJ9wqQBp9k7oKR3Ajzy7HYtSf9RtnNN5UUKyqGsC3/7zcKrIAGEkT+GnWXmyKd++yjY7KLSgONht+NUXJY5gh5kLXph/99G7lhQOS2KC1eh48ZZTLrnKlrXOQG5jnqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL4oCX7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A05C4CEED;
	Mon, 11 Aug 2025 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754944576;
	bh=MGbXEJllcmiA1o9/olIkysp980KeZrJPHmr5Txjw5k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EL4oCX7rtG5UihKG9SQ5sqFlv77mUXIz6Rehh0p3+ZYjCeMdAq+bHS+rxRaGe72Mz
	 /NVmSHN8CxxPsmvMSv87WcxQO3mChyr3+Me2G+EuePC2odJioPnawuK2hZQ3gy4M7S
	 QAi6REtuzVzsQVz7JcthYlLgHcGgzDm6PAmP+Z5gmLoMTaNRbFWECmsgLVLyRXSpP3
	 2m9lzhMMFjpnG7B5ZjUHU1lbJWepJXdXrkuitFlx6EmLwdgXhuwE1WhQreDTY9ZZ52
	 4bn6lrvKQ8FpjmBJfdj1L4DnLYVLjfEABuJ1PbT0rrZiEcIKbHwfOFrXtp2z9/zVUA
	 uucV5V4fPmy7Q==
Date: Mon, 11 Aug 2025 21:36:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: change invalid data error to
 EBUSY
Message-ID: <20250811213607.7bf4b91c@jic23-huawei>
In-Reply-To: <CAHp75Vcw5Q_ENzEJvH2+xHmPD-DUPAEaOOD2QoiCXoh7UiQJxQ@mail.gmail.com>
References: <20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com>
	<CAHp75Vcw5Q_ENzEJvH2+xHmPD-DUPAEaOOD2QoiCXoh7UiQJxQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Aug 2025 14:35:00 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 8, 2025 at 9:40=E2=80=AFAM Jean-Baptiste Maneyrol via B4 Relay
> <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
> >
> > Temperature sensor returns the temperature of the mechanical parts
> > of the chip. If both accel and gyro are off, temperature sensor is =20
>=20
> the temperature
>=20
> > also automatically turned off and return invalid data. =20
>=20
> returns
>=20
> > In this case, returning EBUSY error code is better then EINVAL and =20
>=20
> -EBUSY
> than
> -EINVAL
>=20
> > indicates userspace that it needs to retry reading temperature in
> > another context. =20
>=20
> ...
>=20
> > +       /*
> > +        * Temperature data is invalid if both accel and gyro are off.
> > +        * Return EBUSY in this case. =20
>=20
> -EBUSY
>=20
> > +        */
> >         if (*temp =3D=3D INV_ICM42600_DATA_INVALID)
> > -               ret =3D -EINVAL;
> > +               ret =3D -EBUSY;
> >
> >  exit:
> >         mutex_unlock(&st->lock); =20
>=20
> ...
>=20
> No need to resend just for the above, I hope Jonathan tweaks this
> whilst applying.
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> (assuming typos and signs are fixed)
>=20

Tweaked an applied to the fixes-togreg branch of iio.git.
I've not marked this explicitly for stable as it's a kind of weird
sort of 'fix'.  If anyone wants is backported, then maybe we can consider
that once it's upstream

Jonathan

