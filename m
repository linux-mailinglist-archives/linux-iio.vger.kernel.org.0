Return-Path: <linux-iio+bounces-13248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609739E8743
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4526D164309
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6601B189B83;
	Sun,  8 Dec 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIYqvgdW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB81EA65;
	Sun,  8 Dec 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682237; cv=none; b=TCD0rtYO55RL4yrt6SnBjUowd8B5nCdajTLCeXqFhTvgAmM63vIgREQOZqvRkvVy3Q0Zen1Z3ejERifbNHxceItEgalL1a6fzsa6fQFYiT9v20XyGFI475/HEBmO/GjDilqKxqlCNHV8UFz7OcKGa6GoV1Mv/cjAzfbFZBxMWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682237; c=relaxed/simple;
	bh=kRfzs/jstU21gicAWkoqBnY6u4oTZCfCNOe93GcN/nE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eftpq1S6tOlwOvnzEwSsc1qxQ7BrsbgYHx7Cr93QeWV1JcA4xkSM4vBLhJZnnXJavOhJ4tYG5Qrslqig9AdYEdtiK73yA5xyOMSR+OXeQ8hXNvxq4Q5mpJh+cVC+19TnNlUwHEfj/MOcG7zF5RJr+j+mNrUy9IndGPbVep6mbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIYqvgdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4874DC4CED2;
	Sun,  8 Dec 2024 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733682236;
	bh=kRfzs/jstU21gicAWkoqBnY6u4oTZCfCNOe93GcN/nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EIYqvgdWqhwzjDICf1PC8YbxkHDRKso2sjLJ4fNaTvXwaz1Nfzpk/6htg13c8vb/c
	 1i/qiwNAibaMZMvhgl3rMuaqNYOT4Y4ZDgympIcoeZrQ71htleE/+epUOwrMcRpM9N
	 lsFlVxWdcfo4MyVyB7UQZ0VHt+iwHguNiUy0WevhPs8g3ejocagSfgnerrarVE9Vds
	 zwQShb6gTKzswAxbKT6B7j9V/TpgWXYoY4BTFMEMb9EiXd2vfPbMzwKJZ/MCGnjJUI
	 YvTGoOa5QI52ux8fO0R2EPOAqrwMnQd3NY//Tg95AEHZ0gO3TdTraqFpdpqjt4yQr6
	 GPd8bCcUR2rWg==
Date: Sun, 8 Dec 2024 18:23:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor
 Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 06/10] iio: adc: ad_sigma_delta: Fix a race condition
Message-ID: <20241208182346.423bfd06@jic23-huawei>
In-Reply-To: <CAHp75Vei1g6iL0qWV2Y7+L4M+kJyLfUDoWd0HiXRbAWqQSR0qQ@mail.gmail.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
	<9e6def47e2e773e0e15b7a2c29d22629b53d91b1.1733504533.git.u.kleine-koenig@baylibre.com>
	<20241208124205.5b297fa4@jic23-huawei>
	<CAHp75Vei1g6iL0qWV2Y7+L4M+kJyLfUDoWd0HiXRbAWqQSR0qQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Dec 2024 15:05:38 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Dec 8, 2024 at 2:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> > On Fri,  6 Dec 2024 18:28:38 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote: =20
>=20
> ...
>=20
> > From sparse.
> >
> > drivers/iio/adc/ad_sigma_delta.c:205:13: warning: context imbalance in =
'ad_sd_disable_irq' - wrong count at exit
> > drivers/iio/adc/ad_sigma_delta.c:218:13: warning: context imbalance in =
'ad_sd_enable_irq' - wrong count at exit
> >
> > I saw your discussion with Linus on this...
> >
> > https://lore.kernel.org/all/CAHk-=3DwiVDZejo_1BhOaR33qb=3Dpny7sWnYtP4JU=
bRTXkXCkW6jA@mail.gmail.com/
> >
> > So I guess we just treat that as a false positive and move on. =20
>=20
> I'm wondering if sparse annotation __acquire and __release may help here.=
..

The complaint is (I think) about guard(spinlock_irqsave)
so I'm not immediately sure how.





