Return-Path: <linux-iio+bounces-5286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D78CEFCB
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C8C2814EE
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2883CA3;
	Sat, 25 May 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkL1V6X/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AE4EB51;
	Sat, 25 May 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716650638; cv=none; b=k7cfmCKzE3/hzj9PiB9fIChFvfuo4j877d4QRBwEw2urGvmtz3RPdVP7gcpY/7MGQpd4lJ/4ZbLNTD7e9NaKWco9vtVupkA5sAC55mTtjPxuYECCWwMrn+SQoNBx4apsfJLxRH8doJjUy9mtbqh/u33DVddSpAvkpXOuI0ogDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716650638; c=relaxed/simple;
	bh=hWex0/0EDFdU/EG8w6h6Es7v4FQycOVdAAznlCeBeTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8LEmD4lgkMsYY97PlOZC8xcjCZhxwl9uYHjVpcsS+ysrodldcpAea/zFN6lFWM5adnvnhPJmPbePePphZ3XttlXdGNOILS1o548CXzCDA1PQRtjJMTFUwRBzkyexbLT70iQbp/jL+oaXnG+7MOJ4F5nt7BC1XTwNqVDKA7BdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkL1V6X/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C5DC2BD11;
	Sat, 25 May 2024 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716650637;
	bh=hWex0/0EDFdU/EG8w6h6Es7v4FQycOVdAAznlCeBeTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkL1V6X/oNXEsr099GOqomLQ5Fa3bk6UX5V7XtHOGdLU8QQYydARcKOxHFFbbFoHk
	 f1ZJF/LZkCueJeuATzmD/uEyEWDerQGwlKicH3o/yifUkpZCaM+9oKXbWuFGUPHYCn
	 iFMpgasccP7bFAvv7l6VdW7ha/1Qn1DGTBa7ii6ZJHX64eMFEF/oNqxPLgVbJEhSuT
	 BRwEWXLwGAidEwjZZLVU21yDPSURSKsu9t46bys3BuUAWLWqSCkg3/vje5RW239sIt
	 hy3WJTXAQ5aMeVQMm3bBGaWBFg3iWQOf494CWdAZKBMDyfNP1vURd00+HDPRHEyv1Z
	 giEcyZovW03VA==
Date: Sat, 25 May 2024 16:23:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Judith Mendez <jm@ti.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	William Breathitt Gray <william.gray@linaro.org>,
	David Lechner <david@lechnology.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
Message-ID: <20240525-tall-cultural-1a3f181d39ac@spud>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-3-jm@ti.com>
 <20240524-wrecker-busybody-2c082b87ddef@spud>
 <57e4f7b1-2955-4dd5-b9d9-f3b1f27aab75@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8je3ZeGf7UWWQx7L"
Content-Disposition: inline
In-Reply-To: <57e4f7b1-2955-4dd5-b9d9-f3b1f27aab75@ti.com>


--8je3ZeGf7UWWQx7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 04:30:32PM -0500, Judith Mendez wrote:
> On 5/24/24 1:38 PM, Conor Dooley wrote:
> > On Thu, May 23, 2024 at 06:15:10PM -0500, Judith Mendez wrote:
> > > Add new compatible ti,am62-eqep for TI K3 devices. If a device
> > > uses this compatible, require power-domains property.
> > >=20
> > > Since there is only one functional and interface clock for eqep,
> > > clock-names is not really required. The clock-name also changed
> > > for TI K3 SoCs so make clock-names optional for the new compatible
> > > since there is only one clock that is routed to the IP.
> >=20
> > Really the clock should be named after the function it has in the IP
> > block - it looks like "sysoutclk" is more likely the name of the clock
> > routed to the IP rather than the role it has?
>=20
> It is the name of the clock, though id like to keep sysclkout for
> backwards compatibility, even though the name is confusing.

FWIW, I was not suggesting that it be renamed.

Thanks,
Conor.

--8je3ZeGf7UWWQx7L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlICiAAKCRB4tDGHoIJi
0t6iAQClRgCyK+bzcV2T6gg6WUEarZMXaD9E9NT/lqh7PJoeSAEArxBbuYcL8wXg
TQbhTBU5CK6YWmRE9K233SaqLbSV7gw=
=MmSb
-----END PGP SIGNATURE-----

--8je3ZeGf7UWWQx7L--

