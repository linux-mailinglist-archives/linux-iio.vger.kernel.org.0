Return-Path: <linux-iio+bounces-22832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6693B28E9E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D76189BC3A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388BD2E3705;
	Sat, 16 Aug 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVMjWvT6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FA2D46CA
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355822; cv=none; b=uuV3jhWBRPD3UpCzLnBd65yeshpJ9CND4oxDvqBkCGAcLgjMRFNRP3DqbR0agcvopa0BtcPwpNAbY5PmgbE/jAncq4xPd9a5xvYstFYxFFlIZiOiomHbEU/wq7RkH0T/0KZlWnXyzvdpZNehznReDTvt+NcAcWZzWtWnuneM1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355822; c=relaxed/simple;
	bh=U9ghDi7DCpcNknX7qWRvmGHzEFOkfdcEPTWfuQONGtk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuWREZ5m7XnB1SnXZ43xStzc7NZyHJGBwRUue9mkmOFNwdSzo+R+wgp5Gr89SlbfnLdKEpft3gn4VveIxe7mrniY8TujpIrb1mukj1Tj5TRB5G6ywhsxO8qrsqWc06cQrbNHH6T5FPl2iiCbUioyeSbhksnhwAAkV5DHR9zZZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVMjWvT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54CFC4CEEF;
	Sat, 16 Aug 2025 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355821;
	bh=U9ghDi7DCpcNknX7qWRvmGHzEFOkfdcEPTWfuQONGtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVMjWvT6+z1MNYUgsmLnSRFFwBL8wVWhurqjLojLZUjkqI8Y1L1ge6FnA9/Sfnp9t
	 FqyzLZC3Wf27U6ixlUK+pZliPnbFAUWOpodj7RDdE4uahmdWZJPZoqQ/ElUyLFn5vG
	 Yo3/uBl1EeEA9c/a9Enkw46AI589eeUJbbo7EKJNN1fVFCsEpOLUjiiJwa59UbIypi
	 RlP/P18R7V728/hMIPNHM2+MBU0mHz5lBukHjVlj1Iy8PeL3LIad5e7QVdvUZNS5vc
	 mPGF31V7J9dZQuTZYj0DMk5nZ50cAjcWfqHKuvK4bNg4nh4DIoh9SDc4/axVN9wkwS
	 jmAstBK8cARXA==
Date: Sat, 16 Aug 2025 15:50:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/16] iio: light: acpi-als: Use a structure for layout
 of data to push to buffer.
Message-ID: <20250816155011.032c03f6@jic23-huawei>
In-Reply-To: <CAHp75Vd3czzACQy4k1fUaFea9+ZG+y2dnz_3kcbG+x2g6xw_9g@mail.gmail.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-7-jic23@kernel.org>
	<CAHp75Vd3czzACQy4k1fUaFea9+ZG+y2dnz_3kcbG+x2g6xw_9g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 3 Aug 2025 21:24:13 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 2, 2025 at 6:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > Using a structure makes the padding and alignment rules explicit,
> > removing the need for a comment.
> >
> > Also move the storage to the stack as it is only 16 bytes. =20
>=20
> ...
>=20
> > -/*
> > - * The event buffer contains timestamp and all the data from
> > - * the ACPI0008 block. There are multiple, but so far we only
> > - * support _ALI (illuminance): One channel, padding and timestamp.
> > - */
> > -#define ACPI_ALS_EVT_BUFFER_SIZE               \
> > -       (sizeof(s32) + sizeof(s32) + sizeof(s64)) =20
>=20
> IIUC this definition is named in a bit ambiguous way. This size is
> related to the driver for ACPI light sensor, but it doesn't mean that
> size is derived from any of the ACPI specification, killing that is a
> right thing to do, hence I like this patch very much.
>=20
Applied.

J


