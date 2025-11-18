Return-Path: <linux-iio+bounces-26305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E7C6B2F2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E42B84E068A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090223612C0;
	Tue, 18 Nov 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRRScBS4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA42D73B3;
	Tue, 18 Nov 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490095; cv=none; b=T66JlxWNcd0AWOou0hJ37pbrPmvy22z3Of/SgV/VnifDNZTbfanQWqodt2xmvDdGgJ6rMQ8VE/ST2vIDUd/f8m1iOTAmRcgtQYlpGPn3i2anezGXWcafkN6wunv4sZC9/k7dLE3sfZYHCnb78Zd1d2xiwJCA2YA55PEWb3RMVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490095; c=relaxed/simple;
	bh=Fvj9Is61OV+e3ElVBAkyzZeH2CVH6THAfO+WE8VMwgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPMR8mYYpAQ3u2aRzoDQsRny1oEshHtD5buwKEF/fdwo5wjaFfL/6AS3XDHTttWiUdDQmJhprmlZfcRPrh1rzVjO8cW+8zlrza6tEzt29GbXLpd2EnlKBK4AB44eZSHKwwCpTy8RcFnZFQKnHFLimzFqnnV5lmhGFctnz//SU30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRRScBS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D302C116B1;
	Tue, 18 Nov 2025 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763490094;
	bh=Fvj9Is61OV+e3ElVBAkyzZeH2CVH6THAfO+WE8VMwgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IRRScBS4J4zvhpkyyW8epwfFdfxZySY0yTIoxQU403lKYPa8YJW4csuMi/BPqEXA5
	 oBpawnz2JdYqiYXh6Lez6DmB1XkcIKF4jI4Btcn+C7GqTEV+5oyVirD+n8Ska7S/yD
	 x+y+gP0jVW2kXKxS81shZCh/1zy6hHrbkJUYttbjyMhk67Wop1VrmMSm+KgBJGmMkC
	 KJVqaP9mRRYwIR4Rvk2YC5+bkir0wtF49u56K2zNoDYxbRXu3plPcaJ1izeYPr0w4f
	 vVi6nX1eANi9RJDETz6AD35E6uzGWfJ5RAFWcOy2vM2Pl49bZdPln4EZXe26/WO76X
	 y31/O53MNfIfQ==
Date: Tue, 18 Nov 2025 18:21:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Hans de Goede
 <hansg@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: add processed write API
Message-ID: <20251118182123.73431d96@jic23-huawei>
In-Reply-To: <CAHp75Vd8x0MydzuEYFM7aaiaO3igF2NjJ_aVTfWVKUoQ-q21Fg@mail.gmail.com>
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
	<20251106-ltm8054-driver-v3-2-fd1feae0f65a@bootlin.com>
	<aQzHtqFEIA5E0ikO@smile.fi.intel.com>
	<2330439.iZASKD2KPV@fw-rgant>
	<CAHp75Vd8x0MydzuEYFM7aaiaO3igF2NjJ_aVTfWVKUoQ-q21Fg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 17:30:09 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Nov 18, 2025 at 5:16=E2=80=AFPM Romain Gantois
> <romain.gantois@bootlin.com> wrote:
> > On Thursday, 6 November 2025 17:07:18 CET Andy Shevchenko wrote: =20
> > > On Thu, Nov 06, 2025 at 03:11:47PM +0100, Romain Gantois wrote: =20
>=20
> ...
>=20
> > > > +EXPORT_SYMBOL_GPL(iio_write_channel_processed_scale); =20
> > >
> > > Can we start using namespaced exports? =20
> >
> > Sounds good, but won't it look strange to have only
> > iio_write_channel_processed_scale() use a namespaced export? =20
>=20
> Nope, somebody needs to start this mission, everybody so far has this
> excuse :-) I think now it's time.
Choose a namespace that is narrow, so only covers the consumer interface
IIO_CONSUMER perhaps works. I haven't thought much about it so feel
free to propose something else!

J
>=20


