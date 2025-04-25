Return-Path: <linux-iio+bounces-18625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CDEA9C0D9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C11464992
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22488230BDC;
	Fri, 25 Apr 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXV9W0y0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021417A2EE;
	Fri, 25 Apr 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569346; cv=none; b=qo8vDzbZZXxZRD2hp6MXw7N3CR5/y4QXty9Lp35gtbowzam8bu0HzPUMAeeNNkltQ+//ASQdUwTgjg+T50agoFaS7ZZoSpIUTznrODYzMxv0VXLRN4MoKWRSpNfnJZdCIEl4jPBiij6CsJnq7UvJhNESaj5GovVjstkMVkQH5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569346; c=relaxed/simple;
	bh=+CE+X15AAaCeDTUxmGCqYcAhzi2wknEruYG/dvqSPRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH/vI+YomZ3hpysnjieAIWuMzf9Q7teEOmGFSf5qSAbviOzLSvbVAdHdnZfnYvWUQ/YQLgB96Uu6p28POR7QwmLbm582nwA4Av2sMzAR2qpP1PkSayht7lZJYQmw5I3vpbalr02YJCHAiLMv4rxv221E4Xeh9Ls40nCsw9UdbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXV9W0y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA9AC4CEE4;
	Fri, 25 Apr 2025 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745569346;
	bh=+CE+X15AAaCeDTUxmGCqYcAhzi2wknEruYG/dvqSPRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TXV9W0y0dpOfYs7DR7HZkh78YkG6Mzg7Zd+saejig0kqo/BVPBN2wG9WkS3n5ZQOl
	 4Nfdwj2uwdYJ+RCDcdwk9/56DUuo3V60taysMbXiOCyYi5nEpi+dKCzG7ktY6kQ+Ld
	 1ut18lt7b7QG46eOzOdWVdDw5bPy4oSIHgE1pb8qae5OVFBt72cr/8dL2ON+PBp3fJ
	 QijKayN6PGXxf7eK6HAGqyk/8fGXwo6PwI5VnxVO1Awi5rX1Bo7CwIa9VPpWtt03Ti
	 rPoCCRQHmlqEoLWb7mhIKITpV/E73kcQU+IsKIda6fnXOiZkolHSo6gy+RFgZaRN9z
	 A4WodpL7my0wg==
Date: Fri, 25 Apr 2025 09:22:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Gyeyoung Baek <gye976@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <20250425092217.1ed00827@jic23-huawei>
In-Reply-To: <aAfSUjFh_eB8Dtl2@smile.fi.intel.com>
References: <20250420181015.492671-1-gye976@gmail.com>
	<20250420181015.492671-4-gye976@gmail.com>
	<CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
	<CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com>
	<CAKbEzns_cve+=8wQu2poVx5ZFr8zfUyMajmEz_YpSCDxffQXyg@mail.gmail.com>
	<aAfSUjFh_eB8Dtl2@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Apr 2025 20:30:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 22, 2025 at 05:38:56PM +0900, Gyeyoung Baek wrote:
> > On Mon, Apr 21, 2025 at 4:24=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote: =20
> > > On Sun, Apr 20, 2025 at 10:21=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote: =20
> > > > On Sun, Apr 20, 2025 at 9:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail=
.com> wrote: =20
>=20
> ...
>=20
> > > > > --- a/drivers/iio/chemical/Makefile
> > > > > +++ b/drivers/iio/chemical/Makefile =20
> > > =20
> > > > >  obj-$(CONFIG_SPS30_I2C) +=3D sps30_i2c.o
> > > > >  obj-$(CONFIG_SPS30_SERIAL) +=3D sps30_serial.o
> > > > >  obj-$(CONFIG_VZ89X)            +=3D vz89x.o
> > > > > +obj-$(CONFIG_WINSEN_MHZ19B) +=3D mhz19b.o =20
> > > >
> > > > Preserve order. =20
> > >
> > > Ah, I see it's ordered but by Kconfig, Why do you have WINSEN in the
> > > option and no such thing in the filename? I would drop that from the
> > > config option. =20
> >=20
> > I followed the 'vendor_device' naming pattern seen in examples like
> > 'CONFIG_SENSEAIR_SUNRISE_CO2' =20
>=20
> Interesting... Now I understand why the above was pulled without any comm=
ent,
> because the vendor and device names start with the same letter 'S'!

These vendor + driver things originally (IIRC) snuck in with driver
moves from misc etc a long time ago and I've never really enforced having
them or not properly since then :(

I prefer not having the company in these but it is a fairly random
choice with little real justification either way.

Jonathan

>=20
> > But I'll drop the vendor prefix in the next patch, thanks. =20
>=20


