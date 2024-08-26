Return-Path: <linux-iio+bounces-8800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BBF95EF64
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44A02864BB
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D9155A56;
	Mon, 26 Aug 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhlGO01t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1125153812;
	Mon, 26 Aug 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670239; cv=none; b=oOjnm9Bd6yVwCq1Fz8GRbs87zNF3k7wCzqggi4oULe3gkWVXpstRiE06MPb6wlvHXq7JYsZiFBjKN/RaCUxKaqNIPbV33rzplYJogO8O+/QyOfmSfM3PbV5E+Exl165XkjND9vzlAugF3yeLbHmYPUupg/iYJdNWj4eIB8ghPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670239; c=relaxed/simple;
	bh=OlyAXzRvuO4yYBEj4K8fRdwk4ykPuE/zrbhWgKpz3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xa2qxzxIORoABcYeYrAo3z5qyX0w1XFrBCIY4E8zBoG2WiC2m6WqRVbZ3joUD2T2j/phodm524LI7/n2Is86MpswUPmxq6KW20HjHx161VzIlLA+oKLhwmgIz9ygab6pSnWRr60gqetOt2kKVCkgNdnPcvaGZRAn4MexfrRzlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhlGO01t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF827C51405;
	Mon, 26 Aug 2024 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724670239;
	bh=OlyAXzRvuO4yYBEj4K8fRdwk4ykPuE/zrbhWgKpz3c4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhlGO01t5uX9Xdixb7XX8dVEe7YC49Rtcpj6BsxCoZgtn1NSGAsvhsVNpQm+Zi/Oj
	 /Gyh0zp/t8Ya6FA97tqI8PUA0eRna4gfdqhgS6LIp4hF7Xz16FZBLalJcRjSXz1yQa
	 6o+gKylEus7grffFWrVaGXfSmF5Naw25H+Ne5fTJQp8950Y5EnA+e8i8LdBvxZqYcQ
	 QTTVYdzgfYemRJgrn/dK39Nf4r5jJtsq48jmrfCTrEPYC703r72tvAavcAiLF5IAwy
	 0nwq8tI5qSmWjIiDmjcno+4iA8HTxfUCqsODXbr+8jyDn2MsNktJ0iv2X4DNCoAECO
	 jhMEHvWZ26hzQ==
Date: Mon, 26 Aug 2024 12:03:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 quentin.schulz@free-electrons.com, mripard@kernel.org,
 tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 jonathan.cameron@huawei.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH V4 11/15] mfd: axp20x: Add ADC, BAT, and USB
 cells for AXP717
Message-ID: <20240826120342.503bef41@jic23-huawei>
In-Reply-To: <172433485381.1334876.7027428905035727559.b4-ty@kernel.org>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
	<20240821215456.962564-12-macroalpha82@gmail.com>
	<172433485381.1334876.7027428905035727559.b4-ty@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 14:54:13 +0100
Lee Jones <lee@kernel.org> wrote:

> On Wed, 21 Aug 2024 16:54:52 -0500, Chris Morgan wrote:
> > Add support for the AXP717 PMIC to utilize the ADC (for reading
> > voltage, current, and temperature information from the PMIC) as well
> > as the USB charger and battery.
> >=20
> >  =20
>=20
> Applied, thanks!
>=20
> [11/15] mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
>         commit: e1043ad46060c181ffb8f981ccb25d9f698b2f09
>=20
Hi Lee, patch 12 is dependent on this because of the header
additions.

If you don't mind can you pick up 1, 8 and 12
(all the IIO ones)?  Otherwise they'll have to wait for next
cycle. Guessing too late to ask for an IB?

I haven't checked but the later power supply ones may have
the same block.

Thanks,

Jonathan
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>=20


