Return-Path: <linux-iio+bounces-7457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090E92B106
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 09:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C91C21CC0
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 07:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330B13BC30;
	Tue,  9 Jul 2024 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ceyuq7Ny"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D051DA303;
	Tue,  9 Jul 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510057; cv=none; b=BtDLx5/dMiXstK0VmC94lAOGMuEE1I4U8lwvMBrsa4JWnfmOUQrSyxURmCqfbzNDNgILpBUTV+33DhRp/7dHbUsT/MhBCJC/W/GE/UvgYALNuIU6lCr9GBF4nEZYNJtJeD3b39R6iLY7Av8W+G+tX2TgWyHTcPYOmWe47iyok8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510057; c=relaxed/simple;
	bh=XSbWc+QmMsURRHs5VQZCMpBJk/ZJQzofXzukTl77Teg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttnNosACUTP7LvbqOiZSYfyZ5vJJRFfXBbOBffFJmcl4FA49shf9v6h1jeRa/ErkdjxVymj7H81YnFuuIQLk3wOpDUC2nzsQyzo5lh7SzGrYQCA/tneVjZTssqheEkHTyPQxt1iNFVmUmNkscaXqSgcLRjCNg58jgEf2cXWrRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ceyuq7Ny; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22E2D24000B;
	Tue,  9 Jul 2024 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720510046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HibcTUfYnEmcYJNR1chZFfn71QJWTGsOoH5RNfwQefg=;
	b=Ceyuq7NyzSiJ0uMtuQPS2sSe0gfh1H5majfQZpQXoUjWx3QxtXz9+4GoC721Xm7Lb07AOj
	72FNsBvyOpq9AlTa3A7OakQk8ZGSJ81B5t9w+LvVjQYYV8jluE0b3svt+hH6YgYF1Ecf/C
	KE2ukLJ8yebR/x0u28u7StSBV/Odz+R8a0z5n3pGrkAtslcJxyw6VlM12zIw+jcIsT+/7Y
	xSJKjKN6A8OaZYGr3syfyCBDgz1EyOp6cgB7caZOJMX0VxbP1MmJAXA4d6capMNp98tueB
	8GNQGPFeTGs62oKyfIIj2XJsxc3Z1GApmK0C/ZuI8nAUZ/N457aBibvSVJpzcA==
Date: Tue, 9 Jul 2024 09:27:22 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc:
 sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
Message-ID: <20240709092722.1a3a2482@xps-13>
In-Reply-To: <20240708165719.000021b9@Huawei.com>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
	<20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
	<20240705-unaired-pesticide-4135eaa04212@spud>
	<6b5459fd-2873-4c26-b986-882413b8d95b@bootlin.com>
	<20240706-remote-undergo-3b9dfe44d16f@spud>
	<20240708083011.058d0c57@xps-13>
	<304b7bb1-d315-4147-820b-1ec0aa63e759@kernel.org>
	<20240708142344.47da466e@xps-13>
	<20240708165719.000021b9@Huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Jonathan,

> > > > * DO use fallback compatibles when devices are the same as or a sub=
set
> > > >   of prior implementations.
> > > >=20
> > > > I believe we fall in the "devices are the same" category, so I would
> > > > have myself wrote a similar binding here with a compatible matching
> > > > them all, plus a hardware-implementation-specific compatible as wel=
l;
> > > > just in case.   =20
> > >=20
> > > Fallback from one model to another. There is no "another" model here,
> > > but wildcard. There is no such device as cv18xx, right? =20
> >=20
> > No there is not. But I don't think there is a "base" model either.
> > Just multiple SoCs named cv18<something> with apparently the same ADC.
> >=20
> > So actually I guess the discussion here is about the wildcard
> > compatible. It feels strange to me to have no generic compatible either
> > with a wildcard or with a "base" implementation (because there is
> > probably none). So I guess the solution here is to just list a single
> > specific compatible in the end.
>=20
> It comes from long experience of silicon vendors not being consistent
> with part naming.

Oh, agreed :-)

>  Far too often we've had a nice generic wild card
> entry and along comes the vendor with a new part in the middle
> of that range that is completely incompatible.  Then we end up with
> people assuming the wildcard means it will work and a bunch of bug
> reports.  Hence no wild cards, just define first supported part as your
> 'base' and go from there.

I see what you mean. I must admit I'm not a big fan of naming
compatibles (and drivers) after a working base rather than a good
enough wildcard, but I do understand your point and kind of agree with
it actually.

> It's even more fun when a vendor driver papers over the differences
> and so it 'works', but the upstream one doesn't.  In extreme case
> because a different driver entirely is required.
>=20
> So basically we don't trust silicon vendors :)
> Speaking as someone who works for one - I think that's entirely
> reasonable!!

Haha <3

Thanks (once again) for your valuable inputs!
Miqu=C3=A8l

