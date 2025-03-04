Return-Path: <linux-iio+bounces-16353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D7A4E1FC
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358F4179DA1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD60A27602F;
	Tue,  4 Mar 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9bOT7G9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112526B09A;
	Tue,  4 Mar 2025 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099622; cv=none; b=nFszoYNyaV9H6SeCfTp4kR4In1Q7Y7prpqpARPMXO+YmsI7x/yMOLNI8806IyCD6MGRGJyTWjsEKErfAcnt3DWT+kn2v3UR/P2lD+R83/p3GCkOGya1gQxyHlaY4tX1fxtvpYqBLHmBsF13YSK5Ym6+X2XMlB8zLoe/+cvhrZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099622; c=relaxed/simple;
	bh=rI+BVkT7Y2vGYeVP6jOXfszRKe3HLug8swUeKiDdZ2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulv8O3SYCSHwp9bv0Yo31mFJSpnauQNGear2lDHwklhIITihgt8M8UlYBoWHIT54sVtazuBacMVrP/7Z/h+Tg+b5R8dx1kigpoXBRYr2yTCRGGYPZRQiNN3iCGnXJc0zrOIE4vbyD12WA2KOUL58Z26sjCkunDNwvxQGZV0BcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9bOT7G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD0DC4CEE7;
	Tue,  4 Mar 2025 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741099621;
	bh=rI+BVkT7Y2vGYeVP6jOXfszRKe3HLug8swUeKiDdZ2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9bOT7G9DGWcpw9B82UNVqOf3fzPTab4W0+jJ11PCHXDgeuFvcudBecTiFLVBdZni
	 rHV7ZvwklvbtY6HBm8LSSkfOLRcfQLIceMTB5paPOXFK48evlciiUrcYu6nprTwyPY
	 +cT6mt0pPjZ+2yVUVA9dp0j1YqRk+J7pbXrDFtgWx4i+GoB450j/vGRLT1e5Cf5Fxe
	 K5zerKk94DFg+qJmXED0I/o3HBH5JDwVz5lSanRZXZ4Svk+RGsDIU4SKzxbzyQUYO6
	 iU7/u7PGrSj3G8Dg6UGvRHpUaGHQZYzP3WfZhI1VQyyxX7+oHpWMghaIMllEj3dJfR
	 vUI1FW/rIRHmA==
Date: Tue, 4 Mar 2025 14:46:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonas Karlman <jonas@kwiboo.se>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: rockchip_saradc: Add support for RK3528
Message-ID: <20250304144648.29f376f9@jic23-huawei>
In-Reply-To: <11022969.nUPlyArG6x@diego>
References: <20250227184058.2964204-1-jonas@kwiboo.se>
	<20250227184058.2964204-3-jonas@kwiboo.se>
	<11022969.nUPlyArG6x@diego>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Mar 2025 12:51:47 +0100
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Am Donnerstag, 27. Februar 2025, 19:40:51 MEZ schrieb Jonas Karlman:
> > The Successive Approximation ADC (SARADC) in RK3528 uses the v2
> > controller and support:
> > - 10-bit resolution
> > - Up to 1MS/s sampling rate
> > - 4 single-ended input channels
> > - Current consumption: 0.5mA @ 1MS/s
> >=20
> > Add support for the 4 channels of 10-bit resolution supported by SARADC
> > in RK3528.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se> =20
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
>=20
Not sure why but I can't reply to cover letter.  Anyhow, replying here
instead.  Applied patches 1-2 to iio.git / togreg which I'll push out
a testing for 0-day to poke at it.

Thanks,

Jonathan

>=20


