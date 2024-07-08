Return-Path: <linux-iio+bounces-7435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904592A26C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 14:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD71C213D2
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 12:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00C580046;
	Mon,  8 Jul 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SbSiXmim"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF67C6CE;
	Mon,  8 Jul 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440806; cv=none; b=mluhFxobBvOkEB90oiQsw2pjeKK1WB7MQVBQI/mGCz2N8I4KWHsd1rfhUooK0p+n8pqmqm1rHpXS4euvvbE8y2vh9EwQmunkLUlZLut0NpJisItvWryQ1BIZf94Uh3eeqdhotVD3QDnmzrxcjzSvbJ1O+XQ0NWYFS+IRRYKNWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440806; c=relaxed/simple;
	bh=+nJMkCqOAbHEuYD4KRDwUHDVHDHPJAlNGEhdDqx7/qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4XAbHCGpQkn1lPoBcljtQM9CcKCW/BfgUN5Lw7nZbXN8un3mSWKwU4YyFCvNQVLm1YsOzokmeqPIv7oU/iMH6JW4zs2zJn7n8ctSashPxgXyiaFVcGENISL4G+4XoZksIvjVN32RIs15ByTVhjX6sovub9ApdtAwBW4NLwWraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SbSiXmim; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720440803;
	bh=+nJMkCqOAbHEuYD4KRDwUHDVHDHPJAlNGEhdDqx7/qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbSiXmimyFUuGSDC5A88jA6/Sp379Ck5IBDs3T+nX0OoOfERpaUYUhRhdgjlp72Eo
	 goZOPifGZQLRL6Sqm9sO7IAsK2KCbRC4utsQKMzwfR5nfyjcG94Ttdu8EGwaLUL76J
	 lCX3Ihy5oXZ5OrhShMRYSodKQE81ubS7Sa328slifEpPQdQKqK5U8M9ralzY7yD8iI
	 ZR3GgBRYPhaHrG7rvXGF+Tr/2Ob7sDCOuM1yVII+yIF4uQMvCXFa6GdvSQmdwAV93p
	 au3I3NgflrrioZ59V57ZUA+8vZSZ4E8XmH8BO8v2H4mib7fASLEHjnmCV4xPqfPCo8
	 Qmh/wnkAMLNrQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1312C3780BFE;
	Mon,  8 Jul 2024 12:13:23 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B64771060623; Mon, 08 Jul 2024 14:13:22 +0200 (CEST)
Date: Mon, 8 Jul 2024 14:13:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	kernel@collabora.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
Message-ID: <u5gzxmapos2mo7rldarzdzp22wauuzcozywbynh2ryislqrtpw@cleln4mgilgy>
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650>
 <98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
 <20240707143759.7718e0f3@jic23-huawei>
 <1effec8c-8228-482b-b476-06838128adfa@kernel.org>
 <20240707150835.40db1897@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2n432feszofn6atr"
Content-Disposition: inline
In-Reply-To: <20240707150835.40db1897@jic23-huawei>


--2n432feszofn6atr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 07, 2024 at 03:08:35PM GMT, Jonathan Cameron wrote:
> > > 2) This is an ACPI binding, it just happens to use a DT compatible vi=
a the
> > >    PRP0001 mechanism. Yes, we strongly discourage people doing that in
> > >    shipping products but there have been other cases of it.
> >=20
> > OK, is this the case here?
>=20
> [...] If we can get an example of such a device that would help. [...]

The ALS is used by the Valve Steamdeck via ACPI + PRP0001 with the
bad compatible string.

-- Sebastian

--2n432feszofn6atr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaL194ACgkQ2O7X88g7
+ppYKg/+NFCpzVB6jazl4U6umaHiZINKxpLFPkdTfJDAYCUjvXEppNs/bkLqAO+a
Hl2Fj73XbjLXDW0fdZkq7NJn61Ss8LOGOorUeVJ1YMrG3vL2hGr/+2FBYkkotCUT
9Gp4LGhAGjDfxqNHK9l2Nt3c1gUMHEXgG6mW5kWRAAftcqjjB/qXoJb05WXWKztP
Hh1NclviMQlmkl7dFmibaX5hfI17A9R8BrV1vHZgucG45wH5gnSC9vmDVTcJIk6Y
pPy4g7/JdhXKcLpnYlOogfGDHL+BACEWkq6v23oM9mnnvPKwgs6g3BaMBgGqWSrO
iuj/dYS3skHCzdfhzx/OXch6FYN94XNzmbhwfpSNx9yl0P81dO/S6J9P8tFr0ssV
F+UgBSl7lR19WYH7Y7AczPPnDmJAbcYkWO0sB5bA714oLIv78Tt6++saRggSVEre
coG7LpKJU8ajlZxu6zOcH6F/VHzjtdQrndc8O41HgYAk9WLq3iFBrEE6sLu4pDon
/luZ79Ci/BT5vJOc/VZVteYhtbSEE7Px43CxcZmDu+3P3FAcMN1f6n0eu+c9DVbn
nrveDEaGDlacvSPkR5ywEioB1ottRcNs7bMfyTdRGIoeiXRqCDJLZo8B5tCVRhG/
zkB7ZHh7POv/wHAd2NCjKzyafyuGmUD6lBx2lJMELPpPfFWSNvU=
=GHr2
-----END PGP SIGNATURE-----

--2n432feszofn6atr--

