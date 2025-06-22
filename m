Return-Path: <linux-iio+bounces-20866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EFBAE306A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB3716F828
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7448D1E32A2;
	Sun, 22 Jun 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbL8yiRv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D272AE8E;
	Sun, 22 Jun 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750602790; cv=none; b=ExtrwZxprFUZo2/LtOJefSIdYf3frTaDX8UFI3apV1I/B0IRNh+M3CtB2zbnme8Obz8B6S0M/Gr0M7E7QXHV880q/WMSNhzHxkIy2LOR+1Jx8bXAbXSmZk1relau8IJCjmrqCZ5ASbSiWE9HlcikBw9UDDyrqaOzzgH2eJnfmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750602790; c=relaxed/simple;
	bh=3dlyKJD0z+pFUMdsFsEMYNWzCsL+KbP/zbEsyU8JwLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFQ/+6BqeyDNBy2DMfZrJg1DwjX+4lUkb7J5MEoi+zG/443GVL/9Dg4Qg9w+REZcJ8c1Co5nURgPzsR5it4+2XX7NX/R0kqMHJu/USSmqWuI6WuUGY9WvpW7oVtUOHdri2SgqV0R1LxC764xWbLYGF9ZDjP/bKzcUuJtN0HO0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbL8yiRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2125AC4CEE3;
	Sun, 22 Jun 2025 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750602789;
	bh=3dlyKJD0z+pFUMdsFsEMYNWzCsL+KbP/zbEsyU8JwLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HbL8yiRvXqbMqLTVVLe8SWa4dvnDT9yx0jmW5+aqhUH4TtZ5pc7HtPpah7E2PplL5
	 pCmiuV/DWJybPz5li0+xs4fEn5hdpVZnY4CuJUGBXCJuqJXR2kMaeNaUw4rmSu4qOt
	 GFOZ+8JBbYq2xIeitMOjzToIpk8p3T4MfBJIqIb4HuibDGVVUMRQqOEeR1XBdpbWe3
	 F7qVE3fJBp33lumF6POUrcT0rtwX/SYmX6cGd7/MNjGeZE+syykDXqokeFCpUTpd+A
	 nYVx7uxMv1z8ikUMnMtg4g6RBpYWGNUkSx3IXCq/Xj9wm0wLIZA1K7y/hH6p/IqTMY
	 hdxrJCXl+LL4g==
Date: Sun, 22 Jun 2025 15:33:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <20250622153301.4af0ffb9@jic23-huawei>
In-Reply-To: <CAFXKEHYDSZbuKpu7_Kj52paqdZFw_iFK8YCX+LxMHv7PNCu3sQ@mail.gmail.com>
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
	<20250616-bmi270-events-v3-1-16e37588604f@gmail.com>
	<20250622124426.60c71eb1@jic23-huawei>
	<CAFXKEHYDSZbuKpu7_Kj52paqdZFw_iFK8YCX+LxMHv7PNCu3sQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Jun 2025 14:11:22 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan, thank you so much, but.. actually, I still prepared
> actually still another v6. I was about to send it in today (just
> finished tests). Might be still some bugfixes, and I guess if any
> possible, I'd prefer v6 patches over v5.
>=20
> Let me know, or I send it in anyway and you might consider v6? BTW
> adxl345 also should follow later today. Already prepared, but going
> over the tests..
>=20
Series confusion?  This particular thread is about Gustavo's series
for the bmi270.

> Best,
> L
>=20
> On Sun, Jun 22, 2025 at 1:44=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 16 Jun 2025 20:53:09 -0300
> > Gustavo Silva <gustavograzs@gmail.com> wrote:
> > =20
> > > Add a channel for enabling/disabling the step counter, reading the
> > > number of steps and resetting the counter.
> > >
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com> =20
> >
> > Hi.
> >
> > Given this is ready to go and independent of later patches:
> > Applied to the togreg branch of iio.git and pushed out as testing
> > for 0-day to take a poke at it and see what we missed.
> >
> > Thanks,
> >
> > Jonathan
> > =20
>=20


