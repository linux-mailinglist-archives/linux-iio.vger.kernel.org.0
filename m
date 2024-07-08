Return-Path: <linux-iio+bounces-7436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A692A2B1
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A138E1C2190B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071B84A4E;
	Mon,  8 Jul 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dJ9+nW/o"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6F770ED;
	Mon,  8 Jul 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441437; cv=none; b=WYsn3JU5u4HuVW4TczxOGC+HYlG/uQoW6XoTFfLw7G5MrH7i1TRICEqGqBsD/nbhECY1aTAKLy1asbwYfBUH3M5Qt33fA+lLluhy3DoncBFr2QaG7LB44kgAOja3yXmgfTIJFLYZSS8lwg+6vpvojkLwWf/8t5zY5k+zCfeGQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441437; c=relaxed/simple;
	bh=InWFRraJhjJs8nNqG5Zk68Lze7SlKIkvLxXki5G6lTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEwp/MTmHSe3MLU4DSjLtE+vwvVyd2QY6roZQV0lud7yLLU09/L9F3expBCPQvUcPSOvxRZ2JYoGouHGdl2+etb0iiENH+Wnfm6iwbBiJLmOEHb3Hw5qRKX68ELUJUTMulugGqPcg8a+xZqlQAXyjufsP7alW3BFh94SB5Kx66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dJ9+nW/o; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7847540006;
	Mon,  8 Jul 2024 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720441427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JsbKApEK51Bmx24wtoB9YLZiYCpQ37ANs0wnRzdLyY=;
	b=dJ9+nW/o+fVVXF1/oX60X3/1FFNguSv7QqTgpSH6ISm1XaTz7AKXh9iLkm92nIsZXzGC/D
	JV+ZzNriHyLW5xA3/ERIvMSATBKDgZ5ZUQDrrUYZXAE+RlXyy9Q7Cvb61DbjBZ5oUVREy6
	zXwEvCvGD6Walndgld/sFqpFxVKTamIihqLHfUYpuqKboPZjfr9LN+Th5MGVrzwqQqRFKy
	HHM6DPQQjQkmMeqT+jabUeQ/nTyNPIPqbYahiPHOXbliqyUwrXWDBEMeYdtp8E9H5PXPuM
	Tev+LzF9Ibbq9vbj/L/RXYdvcthJKR5KlTkvK0adv+6LvGRSUKAqBEr/8VEgfQ==
Date: Mon, 8 Jul 2024 14:23:44 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Thomas Bonnefille
 <thomas.bonnefille@bootlin.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc:
 sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
Message-ID: <20240708142344.47da466e@xps-13>
In-Reply-To: <304b7bb1-d315-4147-820b-1ec0aa63e759@kernel.org>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
	<20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
	<20240705-unaired-pesticide-4135eaa04212@spud>
	<6b5459fd-2873-4c26-b986-882413b8d95b@bootlin.com>
	<20240706-remote-undergo-3b9dfe44d16f@spud>
	<20240708083011.058d0c57@xps-13>
	<304b7bb1-d315-4147-820b-1ec0aa63e759@kernel.org>
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

Hi Krzysztof,

krzk@kernel.org wrote on Mon, 8 Jul 2024 09:33:04 +0200:

> On 08/07/2024 08:30, Miquel Raynal wrote:
> > Hi Conor,
> >  =20
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    oneOf:
> >>>>> +      - items:
> >>>>> +          - enum:
> >>>>> +              - sophgo,cv1800b-saradc
> >>>>> +          - const: sophgo,cv18xx-saradc   =20
> >>>>
> >>>> I don't think the fallback here makes sense. If there's other devices
> >>>> with a compatible programming model added later, we can fall back to=
 the
> >>>> cv1800b. =20
> >=20
> > I'm sorry but isn't this slightly disagreeing with the "writing
> > bindings" doc pointed in v1? It says,
> >=20
> > * DO use fallback compatibles when devices are the same as or a subset
> >   of prior implementations.
> >=20
> > I believe we fall in the "devices are the same" category, so I would
> > have myself wrote a similar binding here with a compatible matching
> > them all, plus a hardware-implementation-specific compatible as well;
> > just in case. =20
>=20
> Fallback from one model to another. There is no "another" model here,
> but wildcard. There is no such device as cv18xx, right?

No there is not. But I don't think there is a "base" model either.
Just multiple SoCs named cv18<something> with apparently the same ADC.

So actually I guess the discussion here is about the wildcard
compatible. It feels strange to me to have no generic compatible either
with a wildcard or with a "base" implementation (because there is
probably none). So I guess the solution here is to just list a single
specific compatible in the end.

Thanks,
Miqu=C3=A8l

