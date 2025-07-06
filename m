Return-Path: <linux-iio+bounces-21393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914BAFA48D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0684E189E936
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC71F5828;
	Sun,  6 Jul 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du7bI8mF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829272AE96;
	Sun,  6 Jul 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751799011; cv=none; b=KLHpIbhu5McUnE2R65jZwG0vBoGk41OLLbcddPUEXck8b4SyUYbLHMTGr4yYjRTzY4NvVcWqx7OlzyBo/i63gP90c25j6Hqr0Lp8sA+OV1aaVXZArh8O6XBCR1DeXDnB5uZCCPcoVXLS+1JCGje34jbldRRSLLNjSCga6BrMB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751799011; c=relaxed/simple;
	bh=rnlOCsOx8oCuPmV5KoaTeoAVYCzmPUH79UN0xUbYiqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez7Cye3PC42v+IgKuAKqyDg6ksxKyfrIBxDnXH7ALkDYdH6EHrsGMVJ86zgg4rdw2NsaJjfg62U8yXXuvuqWGDmqrO/1xkChVaLH6RAM50qtHZy+VWgfDZ3kAaZl5K5pUTnfURF1TzS4NaBVgp2sNF5SvLUSnMUYArZIkvt4L6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du7bI8mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B18C4CEED;
	Sun,  6 Jul 2025 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751799011;
	bh=rnlOCsOx8oCuPmV5KoaTeoAVYCzmPUH79UN0xUbYiqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Du7bI8mF3pklE/y4wUYkC+0Swb4+ZE1tnVHV1pau0A5sSa61VWSBKWpVL2czGSeqq
	 lP9A1hKIDFXO8GV8cQzZ9UFCY1b3qqlB4jivrH9tEhHRkfQVs77ulQopLiVkBrFmUL
	 xygqxKpX2s3I2hgb/HIHeLDXRvw+8w0X4nIcS7R+KBibZ1DZr1tRQg7LLmZENCi1RQ
	 i9wXQrwxnKEabvFeT8ncG/gVoLFQ7WrYHy0I5X308DLRppzRgCYb3QLYZCSCjNegV7
	 thYQv774XI2xsFTcmojrX3GNRaoF60dcqZuLOLdkFeFxKfwC7Ku0Jp630Sz7PWde2R
	 WCiV6kOCHacVw==
Date: Sun, 6 Jul 2025 11:50:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: akshay bansod <akbansd@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <20250706115003.5752261c@jic23-huawei>
In-Reply-To: <2413481.ElGaqSPkdT@mbox>
References: <20250703053900.36530-1-akbansd@gmail.com>
	<aGaIMjkYBmfMmCBn@smile.fi.intel.com>
	<2413481.ElGaqSPkdT@mbox>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 03 Jul 2025 22:28:13 +0530
akshay bansod <akbansd@gmail.com> wrote:

> On Thursday, 3 July 2025 10:12=E2=80=AFpm +0530 Andy Shevchenko wrote:
> > On Thu, Jul 03, 2025 at 11:08:59AM +0530, Akshay Bansod wrote: =20
> > > Update the sysfs interface for sampling frequency and scale attribute=
s.
> > > Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> > > and recommended for use in sysfs. =20
> >=20
> > 'must' is stronger than 'recommendation'.
> > Of has the documentation been changed lately?
> >=20
> > ...
> >  =20
> > > st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev, =20
> >  =20
> > >  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> > >  	for (i =3D 0; i < odr_table->odr_len; i++)
> > > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> > > -				 odr_table->odr_avl[i].milli_hz / 1000,
> > > -				 odr_table->odr_avl[i].milli_hz % 1000);
> > > +		len +=3D sysfs_emit_at(buf, len, "%d.%03d ",
> > > +				     odr_table->odr_avl[i].milli_hz / 1000,
> > > +				     odr_table->odr_avl[i].milli_hz % 1000);
> > >  	buf[len - 1] =3D '\n'; =20
> >=20
> > My gosh, this is error prone. I'm wondering when some CIs will start to
> > complain on this line. But this was already before your change...
> >  =20
> I'm planning to drop It entirely or should I replace it with another `sys=
fs_emit_at()` ?
> I've seen other device driver returning space terminated buffers. Maybe I=
'm overlooking
> something.

It is rather ugly currently but not a bug as such as we know we don't actua=
lly run
out of space in the page (it would just overwrite last byte in that case so=
 odd
output, but not a bug) and that we always print something so just as you su=
ggest
sysfs_emit_at(buf, len - 1, "\n"); is safe.  It also checks under and overf=
low
so that safe + hopefully won't trip up static analysis tools.

>=20
> > >  	return len; =20
> >=20
> > ...
> >  =20
> > >  	fs_table =3D &hw->settings->fs_table[sensor->id];
> > >  	for (i =3D 0; i < fs_table->fs_len; i++)
> > > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> > > -				 fs_table->fs_avl[i].gain);
> > > +		len +=3D sysfs_emit_at(buf, len, "0.%09u ",
> > > +				     fs_table->fs_avl[i].gain);
> > >  	buf[len - 1] =3D '\n'; =20
> >=20
> > Ditto.
> >=20
> >  =20
>=20
> regards,
> Akshay Bansod
>=20
>=20
>=20
>=20


