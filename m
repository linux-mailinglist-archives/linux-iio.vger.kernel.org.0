Return-Path: <linux-iio+bounces-7443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0C792A68E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D64E1C211DF
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32AD149DFD;
	Mon,  8 Jul 2024 15:57:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41425EC7;
	Mon,  8 Jul 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454246; cv=none; b=EvppT0JB0mHwqD0uAX0rmtRsOcs9+qkP6ZC5GURMmFrMAUOtKdqnJHcsW8rTzxlg56dllkUU3E1t7WydjYu1VZrbTjMRHG3Z7fZJC/gj6Bz08uHP5eWURSC2al8DE7RToTKv14yBjZjraaJ+J8QWIgE4+Urk8hrE6wHLsfpimyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454246; c=relaxed/simple;
	bh=CZH5/kjytJ3jx7EIEdxQVlVUXsBWoEKmLZ3ROVPx8k0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkAWF0ioHzro4+5SFrHFiajZqligxJ9vmyovCxAwbnU/WqsfUL9phXNRNVwC+rvZmCoTLi3LiuHDLNadw9KUltBZO8UnyI9MFcgxwP3/z+nUeuaWkSAqAdra9Cyo3AhYcLJjSCBWHiy+FN1/zgLXhpq9G3E8rJP72zCKGBkiwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WHpcw5ts8z6K5r4;
	Mon,  8 Jul 2024 23:56:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E4AF1400CF;
	Mon,  8 Jul 2024 23:57:20 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 16:57:19 +0100
Date: Mon, 8 Jul 2024 16:57:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>,
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
Message-ID: <20240708165719.000021b9@Huawei.com>
In-Reply-To: <20240708142344.47da466e@xps-13>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
	<20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
	<20240705-unaired-pesticide-4135eaa04212@spud>
	<6b5459fd-2873-4c26-b986-882413b8d95b@bootlin.com>
	<20240706-remote-undergo-3b9dfe44d16f@spud>
	<20240708083011.058d0c57@xps-13>
	<304b7bb1-d315-4147-820b-1ec0aa63e759@kernel.org>
	<20240708142344.47da466e@xps-13>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 8 Jul 2024 14:23:44 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Krzysztof,
>=20
> krzk@kernel.org wrote on Mon, 8 Jul 2024 09:33:04 +0200:
>=20
> > On 08/07/2024 08:30, Miquel Raynal wrote: =20
> > > Hi Conor,
> > >    =20
> > >>>>> +properties:
> > >>>>> +  compatible:
> > >>>>> +    oneOf:
> > >>>>> +      - items:
> > >>>>> +          - enum:
> > >>>>> +              - sophgo,cv1800b-saradc
> > >>>>> +          - const: sophgo,cv18xx-saradc     =20
> > >>>>
> > >>>> I don't think the fallback here makes sense. If there's other devi=
ces
> > >>>> with a compatible programming model added later, we can fall back =
to the
> > >>>> cv1800b.   =20
> > >=20
> > > I'm sorry but isn't this slightly disagreeing with the "writing
> > > bindings" doc pointed in v1? It says,
> > >=20
> > > * DO use fallback compatibles when devices are the same as or a subset
> > >   of prior implementations.
> > >=20
> > > I believe we fall in the "devices are the same" category, so I would
> > > have myself wrote a similar binding here with a compatible matching
> > > them all, plus a hardware-implementation-specific compatible as well;
> > > just in case.   =20
> >=20
> > Fallback from one model to another. There is no "another" model here,
> > but wildcard. There is no such device as cv18xx, right? =20
>=20
> No there is not. But I don't think there is a "base" model either.
> Just multiple SoCs named cv18<something> with apparently the same ADC.
>=20
> So actually I guess the discussion here is about the wildcard
> compatible. It feels strange to me to have no generic compatible either
> with a wildcard or with a "base" implementation (because there is
> probably none). So I guess the solution here is to just list a single
> specific compatible in the end.

It comes from long experience of silicon vendors not being consistent
with part naming.  Far too often we've had a nice generic wild card
entry and along comes the vendor with a new part in the middle
of that range that is completely incompatible.  Then we end up with
people assuming the wildcard means it will work and a bunch of bug
reports.  Hence no wild cards, just define first supported part as your
'base' and go from there.

It's even more fun when a vendor driver papers over the differences
and so it 'works', but the upstream one doesn't.  In extreme case
because a different driver entirely is required.

So basically we don't trust silicon vendors :)
Speaking as someone who works for one - I think that's entirely
reasonable!!

Jonathan

>=20
> Thanks,
> Miqu=E8l
>=20
>=20


