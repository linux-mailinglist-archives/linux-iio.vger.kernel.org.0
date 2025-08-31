Return-Path: <linux-iio+bounces-23535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE7B3D407
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1220189A0DE
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAA269CE6;
	Sun, 31 Aug 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSfY/9d0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2F21FF24;
	Sun, 31 Aug 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756652910; cv=none; b=CnPEUcyQ07LlX06ztfFhT3s1yQzvOOFfrka1+fPSmmQ9XaDUXVOUdRxM8iOIllt6hrWD9oa9Fa1BrQb8mn6gQcankkjAUWDR4UkYEHJeM5vJkiH8/t7Y53K3CeE04LIpxmGMUez+R321gg60qJszAJAkN8GMm5VuowR//1uP+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756652910; c=relaxed/simple;
	bh=fa5z2uHFvFsznLuoes9NBoTyZMgT7SX4uoYDU6rQe2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SehHKBSFbbiKQRqEQOQrZb6Y4BHUMo78DDjh1R2Kuvv5T1R98yg3zCVOxb4SkWooYTjWkNlwFVSX5646tv+htTiHg6FW3Au36Leg3Grh+VRl/IET/UN9IboNIwylxTBw89Snhq6J2/A3vMmVSYTsNJ5L1lEjF14IIhgUxMclmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSfY/9d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD28C4CEED;
	Sun, 31 Aug 2025 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756652909;
	bh=fa5z2uHFvFsznLuoes9NBoTyZMgT7SX4uoYDU6rQe2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSfY/9d00kiTuL8IOI8INhTPrldan9VuoEzXMbndR+UFT8Uq9TjmwTXKIvQcD/xa/
	 TCaS4IPSjmWRUcdF5LUtmsCU3oAspUaB1pytslgrPVSK9t5JgoAnde6EnmgVieJprh
	 EwIvP7K3Y+aXqB8uEXorWEFdqX1pRYwyp+Xx+9ql2vJf+dX5KtMENaeknDp/9YjSh8
	 vLt3jt2ff67pJ0yU6ZyXyN1gkc6kBa36ZnHWKblISBGzCk/bF8NK6H+K24KO/wyYaR
	 uO/xJXvNNuojPV820CQwjlw4YEtjtYCgKGTlbD5HGkjGxEtgKZmjSnff39LaYwIH1y
	 WipsJ39m4fb+w==
Date: Sun, 31 Aug 2025 16:08:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
Message-ID: <20250831160821.041ce895@jic23-huawei>
In-Reply-To: <CAE3SzaTNoQujrR_h212XLpBbBWddzmSJb9bbUOFmDTBv20p7Ag@mail.gmail.com>
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
	<20250825152608.6468c27b@jic23-huawei>
	<CAE3SzaR14zWWM_g-H4C76+6fBDotuAux7n2V1g94R2xLFQZOYQ@mail.gmail.com>
	<20250830190806.7dd92eb9@jic23-huawei>
	<CAE3SzaTNoQujrR_h212XLpBbBWddzmSJb9bbUOFmDTBv20p7Ag@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Aug 2025 01:19:39 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> On Sat, Aug 30, 2025 at 11:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Tue, 26 Aug 2025 02:29:12 +0530
> > Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> > Normally we'd check the register to find out what whether the event
> > is enabled or not.  If we are asking for the state it is already in
> > then just return having done nothing.  If bus reads are an overhead
> > worth avoiding regcache will ensure we only do it once.
> >
> > Then if we are doing something, do the runtime pm get / put as appropri=
ate. =20
>=20
> Hi Jonathan,
> I looked into the code of multiple drivers. Almost every other driver
> uses a flag
> inside driver specific data structure to denote whether events are enable=
d or
> disabled. Some use masks to mark which events are enabled in case multiple
> types of events are supported.
> For eg: bmc150, fxls8962af, kxcjk1013, ad7173, ad7291, ad799x, hi8435,
> max1363, nct7201, pac1921, palmas_adc, bd79124, ads1015, ad5421, bmg160,
> bmi323, inv_mpu6050, and the list goes on. I see this in at least 30+ dri=
vers,
> maybe more.
>=20
> On the other hand, regcache is used by only 4-5 drivers.
>=20
> On the basis of the above arguments, I am strongly advocating the usage of
> irq_enabled flag in ltr390_data. Moreover, using register read to
> determine existing
> event config every time we do event configuration, seems to be an unneces=
sary
> burden on the bus and increases lines of code which I am finding it tough=
 to
> convince myself for.

Alright I'll give in on this though I consider the regcache approach
superior in this case. It might also be applicable to a number of the above
but they are old drivers on the whole and I'm not going to pursue changing
this in those.  Some of those are IIRC conversions from pre regmap code
where they just didn't go as far as replacing the existing driver specific
state caching.

Anyhow, not worth arguing about.

Jonathan


>=20
> Having said that, I have prepared a v3. Kindly give your feedback on it.
>=20
> Thanks,
> Akshay.


