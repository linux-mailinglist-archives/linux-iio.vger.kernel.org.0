Return-Path: <linux-iio+bounces-7373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05352929296
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C51F21C8F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C1E5FEE6;
	Sat,  6 Jul 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmGsk8hN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5E482C6;
	Sat,  6 Jul 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262001; cv=none; b=AHyMShCLN6m80LGspqfiebGCa27npRKB/Kxk+q3pO1+ochBCVKx9OIRPsSo9Dn3+rT7pvrROn4TLruqcADVYIWivsaeqGaj35y7nMZNs6Kzct6ae9tkfgtkMfrL79IHn5wxZokL5Fi9IJu6Ra0E30s2wCurmXlV0a41ua388IZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262001; c=relaxed/simple;
	bh=9mn5sKetYkjg8XAGBF2C+fUaflC2c2AHyRdi6dvBgHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqGVQ1gWZqAA+uG+ycp1Btz8JZH68eqoo/3wmT/+sXPBsMkZ8/5mS+0kjG2sqJoAynd7B0sxLzy7bx1IuMHNgL4yL1FHbT1/JvO1z15vSEdzPXmlMtCzvP0C+Sg1+b791gGQIZxpuZA0X4unoUqCK9T0ixmqOYrOeTsgJXKPP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmGsk8hN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B28C2BD10;
	Sat,  6 Jul 2024 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720262000;
	bh=9mn5sKetYkjg8XAGBF2C+fUaflC2c2AHyRdi6dvBgHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DmGsk8hNV9Yw2Pfn6CS4h/RQewJsdb/9lnJDw5H7OifNCKK2LcvBZRC/fGEqyhWyI
	 /PVN7sFN38tLQOtdWL2uKGlGx/7bMyhKKd7BKxPmKHAzsK/Gn0P5yIF1Z5HRp9d2ZJ
	 nCwhY9Kq/trEzXapOMuV4wW3n/bkNStWJQc7A+EGsuYtoVB0kFuYaPbfmmOwh6JliW
	 H3oVVc92sutumR9ZdnljbwOTKfr0/CPopkb9K0qZO4Krm6YYB0D7ng6KJS8joCfg6d
	 zVcPnwBLCiPCSZQztvdo/0+isyQ1jptNX8uJ/hNg05xy+PTyB4ouvAaxQY6SJ8Iq1g
	 +9cs0ntJLsXWw==
Date: Sat, 6 Jul 2024 11:33:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa via B4 Relay  <devnull+nuno.sa.analog.com@kernel.org>,
 nuno.sa@analog.com, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH 00/20] iio: make masklength __private (round 1)
Message-ID: <20240706113311.43812bd2@jic23-huawei>
In-Reply-To: <c13f761e08cbe3c5021be34f5da774e44037c9a8.camel@gmail.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
	<20240702212652.01241fc2@jic23-huawei>
	<c13f761e08cbe3c5021be34f5da774e44037c9a8.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 03 Jul 2024 09:10:58 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-07-02 at 21:26 +0100, Jonathan Cameron wrote:
> > On Tue, 02 Jul 2024 18:02:32 +0200
> > Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >  =20
> > > Hi Jonathan,
> > >=20
> > > Here it goes the first round of what we discussed in [1] about
> > > annotating .masklength as __private. Patches should be fairly simple =
so
> > > hopefully I did not messed up much...
> > >=20
> > > Note that in core, there's one place where we're still directly writi=
ng
> > > into .masklength (when it's effectively set). The plan is then to
> > > directly use ACCESS_PRIVATE() in there in the same patch where we mark
> > > .masklength as __private. =20
> >=20
> > Makes sense. Series looks good to me, but I'll not pick it up just yet.
> > I've tagged a like second 6.11 pull request, so this is probably 6.12 m=
aterial
> > unless things go particularly smoothly and Greg takes an additional last
> > minute one as there is one set waiting for a fix that is in char-misc
> > but not yet iio-togreg.
> >=20
> > Jonathan
> >  =20
>=20
> Yeah, looks sane to me. Advantage of going in 6.12 is that (likely) we'' =
get all
> the conversions done.

Given I'm not planning to send another pull request (no time for suitable
testing in linux-next etc) for 6.11 I've started queuing up as probable
6.12 material.

Usual process applies at this stage - I won't be pushing out as togreg
until I can rebase on rc1.

Applied and pushed out as testing for now with the typo Alexandru
pointed out in adxl372 fixed up.

Jonathan
>=20
> - Nuno S=C3=A1
> >  =20
>=20


