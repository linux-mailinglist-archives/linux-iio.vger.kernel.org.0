Return-Path: <linux-iio+bounces-18725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A25EA9E275
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F105A4768
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479A1FE44A;
	Sun, 27 Apr 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h660gqwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974719066B
	for <linux-iio@vger.kernel.org>; Sun, 27 Apr 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745749427; cv=none; b=qt78mkFYG4PeKBJsy8qXfqYGTfHjjuqx4L36S9YoXOv7AX37cxQiZrlIr5kl+jvFwzsx01QEumB/nIDYJZ9LYNrHp5FfB4A5/5YLdUhMlch8jM/95dHenFgQ401AVWxPu+upNOOZGW+QFzf4OQdKpIMLdEI872da+hHxMLd7i7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745749427; c=relaxed/simple;
	bh=Lc1m5d0EG1nNCpi/JWFeM/g9CTv5gayEqXiqKd4vW54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8GHEZr6FUxmSCOV2S/P5hQhvJog+B/kNWkvpbOXsOs/a/9q3IEU9c5sxb/KkIpkoay1I0AiIVsqc/2yE7kLPAYiW3Yr3w/Zzm7B7E8ci3IrXsQ9r9+yaSvdHtKCia57yeovQtY46L47o7Er7zHq3wbrjrW0xIjxoa0AKYNDsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h660gqwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D241CC4CEE3;
	Sun, 27 Apr 2025 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745749427;
	bh=Lc1m5d0EG1nNCpi/JWFeM/g9CTv5gayEqXiqKd4vW54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h660gqwC0C9uQxjVbxGAKQKhSx2bhAwAYmAZEZA+X0bVVKYSe1wGdSLomQIBeAe8E
	 8F6tLIfkQcnbMTjmUDBhWZEIKwvc65MRegeo5d6Q0oCLgZRCqCoqNGMefiP5epm2S6
	 Fqt13xUWSNO09lAQ2dILoHdILNAsK8VzybDyO/03Kd+/ORa2w5d5NDPn/t5EI89dpP
	 ee0yi66uixKL0/eaE0j+MZhVhGo0EosZ/bvmCCMiROcdFeh4vTYZw91Wq6HQcw28Cg
	 1cCQxnnexhHCNoa7ewhj5LnMJ+MiURtNpwZWJRZIyIVg9XkqpTX9z5hSCL5vaPNTIo
	 7hf3A89Sr2IfQ==
Date: Sun, 27 Apr 2025 11:23:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
Message-ID: <20250427112343.207918cd@jic23-huawei>
In-Reply-To: <CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
	<20250426160009.161b9f08@jic23-huawei>
	<CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Apr 2025 18:00:07 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sat, Apr 26, 2025 at 12:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
>=20
> > As a trivial test, just reorder max11607_mode_list[] it might fix your =
warning. =20
>=20
> I appreciate your suggestion.
>=20
> If I rearrange it like this (only added single channel entries), I
> don't see any warnings:
>=20
> static const enum max1363_modes max11607_mode_list[] =3D {
> _s0, _s1, _s2, _s3,
> s0to1, s2to3,
> s0to2,
> s0to3,
> };
>=20
> However, whenever the differential channels' definitions are inserted,
> the warnings reappear.
>=20
> > If you can dump the available_modes table that is generated that might =
let
> > us see what is causing there to be so many warnings. =20
>=20
> What is an appropriate place to dump the available_modes table?

https://elixir.bootlin.com/linux/v6.14.4/source/drivers/iio/adc/max1363.c#L=
1460
There is where they are set.  Should show us if something weird is going on=
 with
what the checks are seeing vs something going wrong at the debug check.

J

>=20
> I am happy to test any debug patches if you could share them.
>=20
> Thanks,
>=20
> Fabio Estevam


