Return-Path: <linux-iio+bounces-18198-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC22A92216
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEB83AE7E8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 15:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AD8253F39;
	Thu, 17 Apr 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="b2to7UCe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E9253330
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905477; cv=none; b=XBAbWwio84QpqC2MehD0WtxZ8UcOYVAnDDZjbX+Vwl8lZiPczcv5j+LL1/eAAnZhGYgWNuPO8XVSq3FasbOSs/1+u1vQsrTOBK1wHAOTNPggE6rCQ2R19NTOgonp/o/k6gFMpyab0cWQnKgWmIEagvs4MIR+bJHlQSjmot/nEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905477; c=relaxed/simple;
	bh=oqpZymM7yF3tIuS4VpohAgmdi+lxdVuXMSrd7IogELc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mgy3IdZDGp737Uw/SxMjGm8x+ytGfR0xJpZROfF3rxBpphX7/eD7Zf/guzB7ueEL8a/0Z0Gwj7tPmMdMNs0Q5mLqhC24zG6P6ANBkJtDxwtwORwLxVR3k6zZOsmpzDpRHxd72TszSIZmFV2mzdYwU1t1nok2ACYnkt16IA+EYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=b2to7UCe; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 27A80240029
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 17:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1744905474; bh=oqpZymM7yF3tIuS4VpohAgmdi+lxdVuXMSrd7IogELc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=b2to7UCeekGueffdpZ/leT7csXcA2zK4YGfuK2vZOy4IXM/V9HzsYlKeh5Iau22yl
	 OnJpO9HTVobzqtpNMw0m2diedEjJLQ45WyDzf1Q/ZRf1JlklfHCA9frNSqcnse2+T+
	 aYulrX2yWU5CGYdHONx5R8snxu2lEq7JMWF8yZfx7A9bNkHI3+mX0tIn1LRJ/9V5DJ
	 wybiHglCRQwNF489x1C0CnhgemYllWhpaWliANIjLFLOoGu2/z8HRL4id98OZNZuWQ
	 e/fUZLOKlTk9C1e23WIH0Gwb1dEJzeZqGYqlWON/8L/MIv2cNTzyWbgBMYqUM82UZH
	 NLhexUnFx0VOQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZdjGS1Zy1z9rxB;
	Thu, 17 Apr 2025 17:57:52 +0200 (CEST)
Message-ID: <2cc70f19c1b001ea7f2cf0632618d060f69faef0.camel@posteo.net>
Subject: Re: [PATCH] iio: frequency:: Remove unused parameter from data
 documentation
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com
Date: Thu, 17 Apr 2025 15:57:48 +0000
In-Reply-To: <56edfb88d3f31939fb343149bfad436f24671f9d.camel@posteo.net>
References: <20250417143220.572261-1-gshahrouzi@gmail.com>
	 <56edfb88d3f31939fb343149bfad436f24671f9d.camel@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 15:53 +0000, Charalampos Mitrodimas wrote:
> On Thu, 2025-04-17 at 10:32 -0400, Gabriel Shahrouzi wrote:
> > The AD9832 driver uses the Common Clock Framework (CCF) to obtain
> > the
> > master clock (MCLK) frequency rather than relying on a frequency
> > value
> > passed from platform data.
> >=20
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> > =C2=A0drivers/staging/iio/frequency/ad9832.h | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/staging/iio/frequency/ad9832.h
> > b/drivers/staging/iio/frequency/ad9832.h
> > index 98dfbd9289ab8..d0d840edb8d27 100644
> > --- a/drivers/staging/iio/frequency/ad9832.h
> > +++ b/drivers/staging/iio/frequency/ad9832.h
> > @@ -13,7 +13,6 @@
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * struct ad9832_platform_data - platform specific information
> > - * @mclk:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0master clock in Hz
>=20
> Hi Gabriel,
>=20
> This seems to be a leftover from
> 566564e80b0ed23ffa4c40f7ad4224bf3327053a ("staging: iio: ad9832: use
> clock framework for clock reference")

That said, a Fixes: tag might be helpful?

>=20
>=20
>=20
> > =C2=A0 * @freq0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0power up freq0 tuning word in Hz
> > =C2=A0 * @freq1:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0power up freq1 tuning word in Hz
> > =C2=A0 * @phase0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0power up phase0 value [0..4095] correlates
> > with 0..2PI
>=20
>=20


