Return-Path: <linux-iio+bounces-17651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E29A7CB0F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DED3B5238
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A619AD5C;
	Sat,  5 Apr 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARaMUjFY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB61BC2A;
	Sat,  5 Apr 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743874769; cv=none; b=CxgTTXYfjfPS8VAKr8Qhsg7jn/DDsdVJypIm5c/1cC8HrzBQDA/frAN0fo0bXe3hk44mAv5M8Jonxu5b+xr93bon0+CYdbtodWJBplkUgtnKa7UQ6B11oBg+26V+gsf1PQzFciD6bYkL/EjsPnS2lRW9dALe0SSy/HMrkefiaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743874769; c=relaxed/simple;
	bh=r7hWoeiWW6+IyVGlW22CCvHlBvsdxJ1PRdcqEFGKY1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjRLBL6kDlOZhhMqsg09nmZYUamO/F1fRDEcKdESLdaCCxgsgjdp9e/rxAlfHhMDHNjhBkUBe8YDrU3lXcL8dXSplKp6sJJmeQmdp53OQAligPLCiw6rlloXYV3VxltiN3wQpG983doWeKreVkInDnuMGOQobewgBtMQIOgH5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARaMUjFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E00DC4CEE4;
	Sat,  5 Apr 2025 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743874769;
	bh=r7hWoeiWW6+IyVGlW22CCvHlBvsdxJ1PRdcqEFGKY1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ARaMUjFYbVb+6iNrDv+AxvX1dx9XG+fr2pXdZ23BATscdMqNjesQYDlcKPQzVabdM
	 k7jCW3axNQxPP+BWCfLssjWnD5PXNpNLWGQshVKxyCAJc+XB288FWQlSHSrr2m0DLW
	 nKbPxALiBa5shPzGSphebQ3S4rnCsowZfFCrCxN/jGfpwTTEQ48lDaW2eWW5RFynHd
	 ia4LVOyGh83UaWig+D+Xg8K7drZo0/t27bjr+wYGfn/psAfjwA0kMjHIvxPqLIP53F
	 TxORJpp2N0Vajd1JBDDjaYk36xoDlCwfTSOF42ocoeoyrCrxvebC93QCP4Mt5LYSM5
	 Tt8syFqNZpeqg==
Date: Sat, 5 Apr 2025 18:39:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7944: drop bits_per_word hack
Message-ID: <20250405183924.5b3eff1f@jic23-huawei>
In-Reply-To: <1f6116071b20846d07406a613d77fd45e5353690.camel@gmail.com>
References: <20250331-iio-adc-ad7944-drop-bits_per_word-hack-v1-1-2b952e033340@baylibre.com>
	<1f6116071b20846d07406a613d77fd45e5353690.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 01 Apr 2025 10:11:40 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-03-31 at 14:29 -0500, David Lechner wrote:
> > Remove setting bits_per_word in SPI xfers without data. The shortcoming
> > that this was working around was fixed in the SPI controller driver, so
> > it is no longer necessary. And we don't need this to be cargo-culted to
> > new drivers.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

