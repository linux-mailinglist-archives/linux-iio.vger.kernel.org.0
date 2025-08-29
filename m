Return-Path: <linux-iio+bounces-23392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F4B3C1F7
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A125A64A74
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A01D341AAD;
	Fri, 29 Aug 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="AknN3tTe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F7238C0A;
	Fri, 29 Aug 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756489270; cv=none; b=KQwI5xcaeEEG3u3rIlCPd/jp9QD7xPsKd6amfOoTWrmoumVHLaQBQpht5VD1rEVoMrco40wxtdxa2aCMpkr0W1rhIKxZo/Xuao5v1i56XJvUP4SJeNeatgBEUeZS5Qip4aGc1KMMKgl4jNqeE1vrQFdNyBXAFy6Ydmf9E2Sx3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756489270; c=relaxed/simple;
	bh=cdPXKwjDZ+OMsho9T432TTp8LngI56q9YQbOvdhHIzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETle3YxSaczthHDwrIrSnRZ/C8FaeWR8+PqhYoJLhIF9o2E+ol+W+PByIxkv5GfzPrGsNcHSWBk9rYAtN5R+Gw7CHGi+38PECyt8ydFSykgSIh72MYoFKyfDNnejTOHG8Ipo+BKdG9AUCRKjh70txFoJ9iLwET8qLqgnt/Ea8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=AknN3tTe; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=40UIIGTecOqbR9yJwV9OkcAwYu0p3HODEAy0v18VNWY=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756489242; v=1; x=1756921242;
 b=AknN3tTew5c/jn397+FXi+GcHLsXjLk90XF/n4FNlTa6qZQATuw8sGp/UzOaB2e+N64YnKiR
 W9BnRSRY2gCcqea1mwBkexjw4RYoM06RNupSQcjOF/uvMBizDVqxcpsfIyK0MDd62A1DI/IBqHt
 ay6PhsWKcoI6VVGh++Cw6Hbjo22O8HMmuISzJHBSnBGGB45ciqNQo9cUwvTFx2qSI/3Q26A/Sqw
 cAV8WDb4bnDMyUk8a+BVb6j6AtSrm/kBuPkU3s2No8UzKQiRzWGJ+tEPTv5BdYBcX7L+cdH9K80
 ljxOYQPnpJ54EHc5ZpNeRisJvZAD4UUroaShetLR1kF2Q==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 7707aac5; Fri, 29 Aug 2025 19:40:42 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 Lee Jones <lee@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Date: Fri, 29 Aug 2025 19:40:41 +0200
Message-ID: <2453108.NG923GbCHz@radijator>
In-Reply-To: <20250829172730.000079b5@huawei.com>
References:
 <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
 <20250829172730.000079b5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 29 August 2025 18:27:30 Central European Summer Time Jonathan Ca=
meron wrote:
> On Fri, 29 Aug 2025 00:17:41 +0200
>=20
> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> wrote:
> > +	iio->name =3D "88pm886-gpadc";
> > +	iio->dev.parent =3D dev;
> > +	iio->dev.of_node =3D parent->of_node;
>=20
> Done in core code.
> https://elixir.bootlin.com/linux/v6.16.3/source/drivers/iio/industrialio-=
core.
> c#L2044 __iio_device_register() so unless you use it before that call
> shouldn't need this.
>=20
> I'm not sure what it is used for though.

It was to explicitly bind the ADC (specifically, its IO channels) to
the PMIC devicetree node. However, since the core does this already,
will drop.

Regards,
=2D-
Duje




