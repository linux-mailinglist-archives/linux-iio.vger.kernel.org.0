Return-Path: <linux-iio+bounces-25270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F9CBEE34D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 12:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 889334E80D7
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70972620D2;
	Sun, 19 Oct 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKL090gj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194B1DE4F1;
	Sun, 19 Oct 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760870811; cv=none; b=MSrIA9IHXOr8epfuvRwPq3UbWf26DSEJPI/IutA+HGtqzE9wssNPtWCFVv4GSZQ8sBTJ1RK1Rs4vK9rzLVH/cuv7xLWdn3wJRPOc3EcIdKCtiUpF63eeoOLYxJ9JPEB7MpX4t7zID9lcpsRGuvkfERf5LTTetIN0InfItcnzRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760870811; c=relaxed/simple;
	bh=KbXlarnVycXcWyYQq6B2xYhrJQcYLL6YB3/BpmLBZhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3ol4gnckpYwikNJDWEBr9hDMfXsfQo57+iqalsA8Dt5tyuayF8i9yWZt1HNDYCzIqrqwBAoDWVzUnk+jQMNBP1HgqIYRtKzxO9qETzxu9Ta5uSV6cYth7aoggPdIMWZp0CVJKeR9URAlm99vSKuKdA13Z2Ks4N9N8Zis8KRIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKL090gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0212AC4CEE7;
	Sun, 19 Oct 2025 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760870811;
	bh=KbXlarnVycXcWyYQq6B2xYhrJQcYLL6YB3/BpmLBZhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sKL090gjC3DsbMBLvg+fJMATPWPPnOnfEl55t54HQKmTpAUWazHwL4XAz+IWb/3pf
	 j38KB92z++yGzG13Z/uXeoVP0ygSXYaXtOKRd1+8teiWsnY+Z1ABT6mFJT7hNZlNiy
	 K1BEwNe3LvORoK+9X0bcnVObxNemM65LgWkGKechywEUS9msaUW+pC3F7oNHltsMia
	 cHYiBtwHUm5saT9/GuePDv0+BKrADu8FSwMLhtdMNKCeMBTCYWdLXwjDaFc6VnMTva
	 fmS+2IrD/jZrJShVH+EFAnGrosrwI9NDGmPtlEn82N2rVjSSfSPfJk1USX7IGrkAST
	 fJ3ktLvjHPnhQ==
Date: Sun, 19 Oct 2025 11:46:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix array size for
 st_lsm6dsx_settings fields
Message-ID: <20251019114645.6e352caa@jic23-huawei>
In-Reply-To: <41f72463394e5e9110f5c889049e9592d3a8efa8.camel@baylibre.com>
References: <20251017173208.1261990-1-flavra@baylibre.com>
	<aPPOu431u8MPUN0p@smile.fi.intel.com>
	<41f72463394e5e9110f5c889049e9592d3a8efa8.camel@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Oct 2025 20:55:40 +0200
Francesco Lavra <flavra@baylibre.com> wrote:

> On Sat, 2025-10-18 at 20:30 +0300, Andy Shevchenko wrote:
> > On Fri, Oct 17, 2025 at 07:32:08PM +0200, Francesco Lavra wrote: =20
> > > The `decimator` and `batch` fields of struct st_lsm6dsx_settings
> > > are arrays indexed by sensor type, not by sensor hardware
> > > identifier; moreover, the `batch` field is only used for the
> > > accelerometer and gyroscope.
> > > Change the array size for `decimator` from ST_LSM6DSX_MAX_ID to
> > > ST_LSM6DSX_ID_MAX, and change the array size for `batch` from
> > > ST_LSM6DSX_MAX_ID to 2; move the enum st_lsm6dsx_sensor_id
> > > definition so that the ST_LSM6DSX_ID_MAX value is usable within
> > > the struct st_lsm6dsx_settings definition. =20
> >=20
> > ...
> >  =20
> > > +enum st_lsm6dsx_sensor_id {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_GYRO,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_ACC,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_EXT0,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_EXT1,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_EXT2, =20
> >=20
> >=20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_ID_MAX, =20
> >=20
> > Is it a termination entry? (Looks like that to me) Can we drop trailing
> > comma
> > while at it? =20
>=20
> Yes, it's a termination entry, I will drop the trailing comma.
>=20
> > > +}; =20
I tweaked it. So no need for new version.


