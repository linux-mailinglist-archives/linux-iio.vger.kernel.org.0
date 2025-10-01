Return-Path: <linux-iio+bounces-24608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DCBAF5BC
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E2F189B1D5
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D508726B2CE;
	Wed,  1 Oct 2025 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cdrQs0tf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1921B9E2
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302731; cv=none; b=cSzg3ozLnjobqFGIjW6oji6hIwlpgEUJ9u2xhl68+UhSG/HyzhIjZ8cMYRO406QnReCLzTezponj4mWhj2WCxFGCw37g8GjD6JucXDwUofFyhH6gtiCGCwGTn5uerVkUBZKOSb3H4xvTunXb2vEY/FYF3wNqkXPotXYg1IUGMA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302731; c=relaxed/simple;
	bh=t7LQvWDoawtcjynybyV6CpESEqmrVI+X1jX9CcdZPZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcJt3BlrdjjQzLCJedZPrRHNUaqIacLr+1u6sghIn/s6bvY1GB7Fy5Ppc2/hlz3qmvW27WjOtHzpUvSvQVcPqh+uTSpJxuMEjUW53VCnj6i7ysZTum/b+sxmUsgRjN9soa7ISXe8NJ8vAPU7Tw39h3GGN+xHPgVDtSuxjSaIOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cdrQs0tf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 283DEC0245E;
	Wed,  1 Oct 2025 07:11:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7227606BF;
	Wed,  1 Oct 2025 07:12:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 82FD1102F1854;
	Wed,  1 Oct 2025 09:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759302725; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GnVI4ZR4JkJ5vv9WaP33l3msfPu596SbGWUzbRdFAx4=;
	b=cdrQs0tfjiD2vmtme9KllctTecE2Rl9XGw801EbGjiI6ek+2YXXUv586pPfLCdZ4B/hcvn
	EaiO/8Vvgtl1Mv9E/TN+suIX8xnA6W4i6UM50/Zl+a/MrO9Ez98fL9gtawa5ARotKhvPot
	8LM7VFkEXsonjXF6GmRwLFcthj9PVEPfd7HzrsjWVhIQjdyis2xLzSk1AAX5XJkYt49WEM
	X8CGD863aML1KQvQBMVNrRZvBJYHCMJrkjZlrq2Af3yztGrqVxuCIY0zeb74+ri0mlnEiL
	CM4NdfXn51oPYdPQkBA6dbdhTZxlysutzPXNGth1iKOe9gSxRIpBKdlPnm97Ow==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject:
 Re: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology LTM8054
 regulator
Date: Wed, 01 Oct 2025 09:11:51 +0200
Message-ID: <5926760.DvuYhMxLoT@fw-rgant>
In-Reply-To: <20250927-spoon-yearning-c1a8df796173@spud>
References:
 <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <5331035.LvFx2qVVIh@fw-rgant> <20250927-spoon-yearning-c1a8df796173@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6197909.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart6197909.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Date: Wed, 01 Oct 2025 09:11:51 +0200
Message-ID: <5926760.DvuYhMxLoT@fw-rgant>
In-Reply-To: <20250927-spoon-yearning-c1a8df796173@spud>
MIME-Version: 1.0

On Sunday, 28 September 2025 00:31:05 CEST Conor Dooley wrote:
...
> > > 
> > > > +  lltc,fb-voltage-divider:
> > > Why does this property have a ?linear? vendor prefix?
> > > Shouldn't it be adi to match the other property and compatible?
> > 
> > This component was originally from Linear Technology, before it was
> > acquired by Analog Devices. The new properties and compatibles have the
> > Analog Devices prefix, but the "fb-voltage-divider" property is already
> > used by the LTC3676 and LTC3589 regulators, so I left the Linear
> > Technology prefix for this one to avoid introducing a new property just
> > to specify a vendor prefix change.
> > 
> > I don't have a strong opinion about this though.
> 
> Do they share the same driver?

They do not. However, they use it in the exact same way, and I would've
liked to factor out the handling of this property in a future patch. This
would also make it easier to handle other types of feedback pin circuits
and have a generic binding for "regulators using a feedback pin connected
to some kind of analog circuit".

For example:

Vout----+      
        |      
        |      
       +++     
       | |     
       | | Rtop
       | |     
       +++     
        |      
        |      
 FB ----+      
        |      
     +--+--+   
     |  |  |   
     |  |  |CCS
     +--v--+   
        |      
        |      
       -+-     
        -      
 
This is all speculation at this point though, so I don't mind changing the
property to "adi,fb-voltage-divider" and handling the different compatibles
when it comes to it.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart6197909.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjc1DcACgkQKCYAIARz
eA6qTg/+Kkilr24s4UFOMInNmOfoTXbYDRNnY1G9d2/sXjYcwqNTtmnoK/iwyuta
wsf8Aw9kycn8Daw1ra4fAdARNjHU/ky1ciPZPDRqRcuhgSoyxP2TbKHDjoKBYIBK
KhOx9Ow267KOnJRooUbhNdX0CRwOr6PgPc2qE1ZQatDKriNc1SRkeGarUqdeyITq
GBMGJi/uhMMVgrjsXRxGaDiDjZT9PxGGc7lGoOq0/QxdOPsFfuJmzgH/1MY6jj7b
qRePQELC4N4So3jAGvUZgqWS+o2A7EOMGXO9MBSOi9oUwFQODYMWD1+a4QEAQN7t
lM15POGGAhxTb2406ez8chEMamBOr+CU2Q7zsCrJfYc4+2D3qPhojxm2WAb44dOq
x+qJS88Su6lA/b8DRUcxuem7EUSUpjKTXy2g4ox4FBbfxZqr+J4tws7xBp/wpBv9
jsw20G74ycrru6povudm5ge5P7XVQF9BArHxjW++vNMdE9Dd0+2cqn8eZhu8rXlh
qVQDOLzGINZUccX0b/QeA2G2JmQ3Sb/FCZQuLA/CTyNIZLF0yjPXg9MR02/hNBR9
JI/IQ8Y/thn6+1TtAzDRPRJWzkMbJAnCXYRs92d4IRpxdbthytgI5OXN10j2H9gr
nMS3sbxSbsJRGOmMCwuRjuki6DcHcmUZFvpg83QKJ5+oxiWuUtg=
=/Mf9
-----END PGP SIGNATURE-----

--nextPart6197909.lOV4Wx5bFT--




