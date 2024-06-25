Return-Path: <linux-iio+bounces-6874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A427A915F18
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 08:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F3284646
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 06:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6C1465A4;
	Tue, 25 Jun 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WD8d0zBn"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE0146583;
	Tue, 25 Jun 2024 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298458; cv=none; b=jjyQRNnqqUC0XP7e7iV715KXvVtrpjASgSlvKz0Uth0zUE1DFW6MXEAbhIgWxrSrZMPLdow58RUHiTa6PqK127oWQrjShD4AjP7SKOqFIz3JteZ9xju1P49tnNcJRfpsoIZJZe0DQ6XJoKdo7s09mqBWbir5H7YyYdOh3HcEa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298458; c=relaxed/simple;
	bh=GLy9r6s4JKJPpiiGmmqfmYHHn2czjjzX19kmNfcD+c8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO1kcNvNrDHiQJBw86lOyhll/YkSetikmdoSs2ZGqeyT1oY8mCbYsGT28fD/2eUpyEUAVYLltPGzTISYGcLaDo3TNLyS8ievpNrVYch6r0zlAYg05PeuxIKksHeHMeq7w2GdqmopOl9BhMu0HKVW3Zun1yaNAqLJtAUVf965GUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WD8d0zBn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719298455; x=1750834455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GLy9r6s4JKJPpiiGmmqfmYHHn2czjjzX19kmNfcD+c8=;
  b=WD8d0zBntm5tISZ0ENQRj5NrCMiEuTAtCvMxD5GuRdXfUII0BfBHM4oE
   QwP4Vjdcxdf2goPhJZ27dyYWxNadUD0f+PiZ1E03L5nejjY8Aqmj+it4M
   f3nWJLlVTNjBu3irXVsRd4GWqq6e+9fMgfd3/sbXSXPEdUt9miZ38Ask3
   iSeWi2HF6v2QHQ6afyPlM38IOqp/GzwobKaI6+gdDOKaIfBI7Ao62St/a
   P+2xWeWKFfSQnLhBFsPPt8SdpV9b/OcUyMfDFLNbeVzdnM65p+EtPMR58
   HnH9Y2p/9GQoimx1q9dk5r0JNAbBxPMrd7oAgGOXoaiJ9v9EY/hh0teXz
   A==;
X-CSE-ConnectionGUID: KXhBoKx+S7moHFrVMENI0g==
X-CSE-MsgGUID: /nUaxC2FQSKFDYiv18kmpg==
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="asc'?scan'208";a="259332112"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2024 23:54:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 24 Jun 2024 23:53:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 24 Jun 2024 23:53:32 -0700
Date: Tue, 25 Jun 2024 07:53:23 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Yasin Lee <yasin.lee.x@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<yasin.lee.x@outlook.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>, Conor Dooley
	<conor@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
Message-ID: <20240625-basis-greedily-483c1518026a@wendy>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-2-b1d65b221811@gmail.com>
 <d77a4777-d282-4004-895a-7809abf68130@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fgvME+BqevhmvgA1"
Content-Disposition: inline
In-Reply-To: <d77a4777-d282-4004-895a-7809abf68130@kernel.org>

--fgvME+BqevhmvgA1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 07:48:52AM +0200, Krzysztof Kozlowski wrote:
> On 25/06/2024 04:15, Yasin Lee wrote:
> > A capacitive proximity sensor
> >=20
> > Acked-by: Conor Dooley <conor@kernel.org>

And I _never_ provide tags with my kernel.org address in them, so this
didn't happen either :)

> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> What? How did this happen? Where - provide lore links to prove it?
>=20
> NAK
>=20
> > Reported-by=EF=BC=9A "Rob Herring (Arm)" <robh@kernel.org>
>=20
> No, drop.
>=20
> > Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

--fgvME+BqevhmvgA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnppVgAKCRB4tDGHoIJi
0rwlAQDc2qSV0UY7uzZfVUDuRlAFNt1Sz25uc4OoBh7Dr1XagQEA/AVHBJbsfot4
xaq7sqPUXc3M51vzcFyUStEEyZMCgAw=
=V3J8
-----END PGP SIGNATURE-----

--fgvME+BqevhmvgA1--

