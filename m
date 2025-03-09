Return-Path: <linux-iio+bounces-16592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E90A585CF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9545916A774
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311B1DE89A;
	Sun,  9 Mar 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLE73B1p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E31FB3;
	Sun,  9 Mar 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741537642; cv=none; b=i1qk7LJXHTkXNHwXqyEvlHD7FPjTyFc9t/E3h5pVK2NzmOFRZBnwjibGiD7NbD34oKkMasrrrE12Nsirvz0lRNL4Kd67ZpbtITKj57nht5aHPDFXtjQbydW7pTr/65khWUg5eFc78d4/STmZ3tlad7Abg138o0Aul7oGdhIHxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741537642; c=relaxed/simple;
	bh=8e/5ur58bSJgjkeEWsX6y+bon511MWJmlit6ItFUr44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=En0wJOyaz/Cfsv2VpIIllkso7pHcgdMLJ2xorFA+HrFkFFXljo3PCLh0rs8j7IkTXhX1A7bXMQjscyzmeeq+wgRDbLaBbkR6BfOSAu5KemWXgsgEkpnlVbxzsFuM54XVugDLFFwMJqti1Mc8IQZeeoXAQAbeSa2v2MrbqMJ4ki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLE73B1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD451C4CEE3;
	Sun,  9 Mar 2025 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741537641;
	bh=8e/5ur58bSJgjkeEWsX6y+bon511MWJmlit6ItFUr44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TLE73B1pWA7tLK0ZFvJAd6SZQ0+zb8v7ZZHS+pdowbvX5g8M7qwMBUvVPGlOMtSld
	 CjAvEU7VkvuZMQ3ufQM9+PELBDa007eVxDCfgJNpQa1+dpIc5WwxjWowcbAiMjZaHH
	 CK+GuQ5wvLrTl8CYS93+UZ9LJD6GkoCb6B9jYyv5wFhXNVnGUgall9PMnsJF/vgdOq
	 S1uiGU6HxzseHnYtTAlpMVGaxIJnOlAN/91pldT4SbCQX4AQMVICnyfftg2QL6tUt7
	 LxS1CIECknIaPNsDLm3lLCd6ZSB7Xcbk38x3K+AGF4R7qb9nBreCt6ppPYIYhSLQ+r
	 2Mt246D1SOFgQ==
Date: Sun, 9 Mar 2025 16:27:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/2] iio: accel: adis16203: cleanup and standardization
Message-ID: <20250309162716.753286c2@jic23-huawei>
In-Reply-To: <CAGd6pzO492FA4bijFgkGvusrbqo2mkT=kpkY150Xg-nMfHrpZw@mail.gmail.com>
References: <20250305155712.49833-2-simeddon@gmail.com>
	<20250308144357.20f24fa6@jic23-huawei>
	<20250308144944.668d79b5@jic23-huawei>
	<CAGd6pzO492FA4bijFgkGvusrbqo2mkT=kpkY150Xg-nMfHrpZw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Mar 2025 11:18:18 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> On Sat, 8 Mar 2025 at 20:19, Jonathan Cameron <jic23@kernel.org> wrote:
> > =20
> > > I'm not going to apply these because I think you correct
> > > identified that the device support should just be added
> > > to the adis16201 driver and this one dropped.
> > > Good thing you were more awake on this than me ;)
> > > =20
> > Sorry - wrong person. =20
>=20
> Well, I=E2=80=99ll assume these won't be getting applied.

Yes, sorry you wasted your time on this!

Jonathan

>=20
> Siddharth Menon
>=20


