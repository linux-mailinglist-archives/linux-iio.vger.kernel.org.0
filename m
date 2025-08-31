Return-Path: <linux-iio+bounces-23554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C3B3D523
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 22:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C48E3AB8B5
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6D2343C7;
	Sun, 31 Aug 2025 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="YVCcbFoV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45051800;
	Sun, 31 Aug 2025 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756671609; cv=none; b=r0g638Ku87wa5f/Sd1hrJ1n0/BvaGzMdyBkn6+rNNsc9eZkA8bzCRIAhloBQLJsmOvFsW5XNOdAqlqr9UG06lduG5NGRpARMVkNAOPDpOT/EAjmGDpDVo/r9eR9dOccwpBGRZopZWTb29OaneOl49yC3fpbfc6yy1EI9xQUdXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756671609; c=relaxed/simple;
	bh=Eztkgqasrr3tp+2Po7FkxiGL8NvaiTzrdahHrqIENvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZEezMH2aS7Pp+rfXPnamOSyHUzTo+8bNpqxZA9CofAHDHVMF4akUjwquaEdQGfDZI8PAu0MIXRBUCJjrYpIp5eelYN+dF4ZeQdo3/iRuGC+PKf3cE5FIraqYxS1hsd4t6zSbIXPz8rEAhkByCdrmgJdYjzghcmlBMSzZwmPgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=YVCcbFoV; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=5E/qq69WaMm1+sPFsk2MUenEpIc7gZe6asPlEmhr1uE=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756671580; v=1; x=1757103580;
 b=YVCcbFoVLrmyErxA+QT3H3iINJC/pgCeCF6FTe+MHwFRPxTjQxeGKMgzToLUCATKsUwvDdf1
 iCrN0K5IZqX0zYQng763w9qYm5vEPE09RVUbLo12pii895gmebmJ4yFcb7SHpM2C8Wfw17U1Ui0
 fJDx+9mdT6HyMh0JulMSZ8vmFnxMCva9+B1uv7WfWsYQlgbELC+ju8FTDwdrheUTIV/o8ntLWr6
 oSVarzbgGWIvo4QVWZ9TOHqODq7bGwPRYHCyDRAaCZYSVsOlVJoJ91uhdEm/j5VKVjheThDR0/f
 UCjFE1tajshcP5dZYgOcWhmvV53AmzqDOATzMx0vIa+bw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id bb4c9503; Sun, 31 Aug 2025 22:19:40 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Karel Balej <balejk@matfyz.cz>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Date: Sun, 31 Aug 2025 22:19:38 +0200
Message-ID: <5048048.31r3eYUQgx@radijator>
In-Reply-To: <DCGUXTSZ8B9G.2S2Q2JXYMBSRY@matfyz.cz>
References:
 <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
 <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
 <DCGUXTSZ8B9G.2S2Q2JXYMBSRY@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, 31 August 2025 21:24:54 Central European Summer Time Karel Balej=
 wrote:
> Duje Mihanovi=C4=87, 2025-08-31T12:33:05+02:00:
> > +	if (IS_ERR(page))
> > +		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC
> > page\n"); +
> > +	gpadc->map =3D devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
> > +	if (IS_ERR(gpadc->map))
> > +		return dev_err_probe(dev, PTR_ERR(gpadc->map),
> > +				     "Failed to initialize GPADC regmap\n");
> > +
> > +	iio->name =3D "88pm886-gpadc";
> > +	iio->dev.of_node =3D dev->parent->of_node;
>=20
> Didn't you mean to drop this since Jonathan pointed out that it's done
> by the core?

Actually I have found that device tree consumers fail to get their IO
channels without this line, so I left it.

Regards,
=2D-
Duje



