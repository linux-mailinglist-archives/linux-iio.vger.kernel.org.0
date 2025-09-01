Return-Path: <linux-iio+bounces-23601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F26EB3EDA1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 20:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FF71B2000E
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C7324B04;
	Mon,  1 Sep 2025 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/07/UZc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE030E831;
	Mon,  1 Sep 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749908; cv=none; b=SmST95dprRXp55eiR8Vx/noNRSmRTsfHH1ami4HAE28xgJ5pKnKCZVBr4my2Lny9khpvzjaMgAX/c17RjdizVv4YJJ7QokAzqtD7PRU9jfvHBA3e4lyn+XkMRxT2U5ZBCyBI05ZPAny0GOFBMOCMaw7qPRW4ZMeEEkmL15aENGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749908; c=relaxed/simple;
	bh=2TBg+9XTm5fgkyWMdfNaMN7GEbqHr7rJyqT+6fjyW0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nt4a0T003cyIvvSQu5tmS7QaTPMCT0voHzMDblqYNjz3zJ2HU5V79xNy+jclQ/LC6eIaqlo5vlBl/5TfxVjjwE0vbzhgihZnOfhlhE3YbUgusnxCH7G51ldRhLidjeeeAADJZHyKoCfF2knnbZEui91x9eCMuiy+/9LPvy0GC4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/07/UZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0506C4CEF0;
	Mon,  1 Sep 2025 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756749908;
	bh=2TBg+9XTm5fgkyWMdfNaMN7GEbqHr7rJyqT+6fjyW0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/07/UZcrU80RB8/ASWEollgpk6RQD5iMnqx/2z7Ga4mJw6CCAvax9egMy7aV56eO
	 ExOyJKt0TWV/IQca1LIE5DH9239AAoDWZuCGir50BVZobD9/OAsuHTfAB4ebStakBA
	 L340IlSf5hsRW+b3gfHJgVoTPnlJTylNduF//pPqRjiqOcyde5a1q9PtF60Lb82VmC
	 4gX+fDWX5xl8btQSQB/tOdwq37Jsy1WNRg18gt7asNOMGIF41LKmP8Hbq0r2B2PPYK
	 SqBLHJ1U5xZBA7E3KAJtH4BltNU01tVaog4HMp/2dTbLgtt9j6D6K1SPOpOlJLvggl
	 wpkzqpC8Iygqw==
Date: Mon, 1 Sep 2025 19:04:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lee Jones
 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Karel Balej
 <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC
 ADC
Message-ID: <20250901190458.3c2853a0@jic23-huawei>
In-Reply-To: <aLWU3AwC37jpV9W_@smile.fi.intel.com>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
	<20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
	<DCGUXTSZ8B9G.2S2Q2JXYMBSRY@matfyz.cz>
	<5048048.31r3eYUQgx@radijator>
	<aLWU3AwC37jpV9W_@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Sep 2025 15:43:08 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Aug 31, 2025 at 10:19:38PM +0200, Duje Mihanovi=C4=87 wrote:
> > On Sunday, 31 August 2025 21:24:54 Central European Summer Time Karel B=
alej wrote: =20
> > > Duje Mihanovi=C4=87, 2025-08-31T12:33:05+02:00: =20
>=20
> ...
>=20
> > > > +	iio->dev.of_node =3D dev->parent->of_node; =20
> > >=20
> > > Didn't you mean to drop this since Jonathan pointed out that it's done
> > > by the core? =20
> >=20
> > Actually I have found that device tree consumers fail to get their IO
> > channels without this line, so I left it. =20
>=20
> because the passed device is not parent?

Good point. I missed it seems to be going up another level.
Absolutely fine to override in that case.

>=20
> In any case this line is problematic. Use device_set_node() instead with =
the
> proper dev_fwnode() parameter.
>=20


