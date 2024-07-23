Return-Path: <linux-iio+bounces-7819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39003939D0B
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FF62829FB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D914C5BA;
	Tue, 23 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p9qxGzt3"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FE14AD3E;
	Tue, 23 Jul 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725161; cv=none; b=ex0aBNg/NoAMW5AqP0XYQwsaQO8r6PkxAxCVMeEzTzOrCGsT43q7LPML216nTHosjnmwHDBYufXHhsNbR9b6qAsfJVfN4u49FywsRsdgEFu3YPeZpObO/2YWlX29H1rZnz3oHBPnCxDuE/EJ124ULNPY271TY8LV81MX1PPikNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725161; c=relaxed/simple;
	bh=vuB9BvBovznV2C5TzKywXf/pl325gqX7cPXFdfLvaOg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpWBZSGqpJm7c6aImDjAT0bYQl42BozUvBmcwoNy4eVnJBwjVcBOnOSE/wmOQ34u5TwN2AH8MzTnoRIcZuDeYiXhPGbyGdgYM+wDLhsv6A1kzxOmSM0CwIGK/ZZErp1EwS+KlJZfkPMkzUhvNexG4pKlhMegog7M7otmIdAZt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p9qxGzt3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721725158; x=1753261158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vuB9BvBovznV2C5TzKywXf/pl325gqX7cPXFdfLvaOg=;
  b=p9qxGzt3cqVKDiYi3/oZ5tYoGVYBz9Nxaux5IWGCKmuWisTbo76DFvyZ
   V8fcyV8Gb5c5QZJjjupqsKH9dobAIG0pCws7w+OK9GHR7TLQAc3Wnq6Jd
   0WX3OcRLnEbWz6MQepNQLONCZrLmWmAe/tt96FU7onl1Ao+N2MdBZt+AU
   7QcXRMKU7iVCPTtBrBDh2JVc2qMyV76WA3frbWFEh2ssNIQVQedEGwfEp
   n/VGv+zFX2qHgxZ4kSsLs8igYyId97aB5maVstE9+7ADt5qCVBZxfxt0a
   zbzRn3Gs1pbE0jp4PzKHVxKz5AXRdMg/g2NxyXxxg4Hm1I/MQ6BVYcj9/
   Q==;
X-CSE-ConnectionGUID: RDjQsaNRTDa14ayDCi8WyQ==
X-CSE-MsgGUID: DGp6JnEZQhSDYcZqLRRLZA==
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="asc'?scan'208";a="32331318"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2024 01:59:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jul 2024 01:58:56 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Jul 2024 01:58:54 -0700
Date: Tue, 23 Jul 2024 09:58:30 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: David Lechner <dlechner@baylibre.com>
CC: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
Message-ID: <20240723-cabbie-opossum-6e551fe246f2@wendy>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jAXlsA67pT68+om8"
Content-Disposition: inline
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>

--jAXlsA67pT68+om8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 04:57:07PM -0500, David Lechner wrote:
> There is a recap at the end of this cover letter for those not familiar
> with the previous discussions. For those that are, we'll get right to
> the changes since the last version.
>=20
> In RFC v2, most of the discussion was around the DT bindings, so that
> is what has mostly changed since then. I think we mostly settled on
> what properties are needed and where they should go. There are probably
> still some details to work out (see PATCH 5/9 for more discussion) but
> I think we have the big-picture stuff figured out.

Thanks for the updates. I'm on holiday until rc2, so it'll not be until
then that I can really take a look at this. Figured I'd let you know
rather than just ignore you...

--jAXlsA67pT68+om8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp9wtgAKCRB4tDGHoIJi
0s45AP9fxybG2w4dniKJn5EQfbg7XWUzv0R5Hz9l8jkGqFRNfAEAkQTzWUaDvaud
zdW3eay7nRJpxkBvMtV5Akz9ADBayA8=
=nC48
-----END PGP SIGNATURE-----

--jAXlsA67pT68+om8--

