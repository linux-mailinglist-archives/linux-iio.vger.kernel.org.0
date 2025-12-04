Return-Path: <linux-iio+bounces-26718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0ECA206F
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 01:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C53300E3DF
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 00:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94C7081A;
	Thu,  4 Dec 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Zx/SlHSg"
X-Original-To: linux-iio@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E267398FB3;
	Thu,  4 Dec 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764807487; cv=none; b=NFLcYd9mgkhB/8iXRjUNu9vqx0bcC7/sXbTQWCBUcWjb8lpk5uIKH+OqGji1bmY3ds65i12QRgg/NuIjV3MvZQ+SoJ9ShLCI9AzsEpEFMA6Mw9sOLCVZ30ITnuBDWye3JWxu6AypLk+woivpPjJVitomNfo7X188/uJ3NNPgJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764807487; c=relaxed/simple;
	bh=Fbh3Fa9yoPoJ/6NTYsDU1H5iGd6Y63WPGr7HHZCcnjo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DLJpTCMbYf/DyEWtb7MKGOJfK+78Qrirq9j4IDGbhpyamelwIYLWnxBvqDlpX2D5czmqLOR7G0CkKHsOPaCii/fDs2lPqgeZINP/+IIrZwzFR11OeealL5VhtEAR98savnKGR2PLyg4dumbWBw0WvMjUrAokOxEqnPS1yEVc77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Zx/SlHSg; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764807481;
	bh=DiKjyODImd+3MTY2CNHyrF9IEQSIMhmYQ/J9yfDpGKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zx/SlHSgLsakbqP/0cgTNfxLGYmuJYFStBJPlFs3ocQEgwyuNPep8M73z3EOkjAFR
	 AiX6fGe0mhbgoBI/puIFEX//t47++cXSjH3yBamd85DZB0E3j9ByBvq+MQeKL8ncwd
	 2mrPw5/6wGY0W9lZY8a9FJQJLaGPWI8ieEzVnuGEcr5oj3G6NY9XB2KstX/Q3+Z3tC
	 5FudiuzpXx0ExteuH4UdTqivAvO+JQNGP7Zmz9Soy5Ad9CZmoyExUayQMeNE12ZGLT
	 qtNuH7IZzh1AX3D9lRs/d7AQovrv2tOAfYp0ReIOJwT89EN7H9JfIyBFv6rh46lDPO
	 eeh4YPy4S+AaQ==
Received: from [192.168.68.115] (unknown [180.150.112.216])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 53C44706D2;
	Thu,  4 Dec 2025 08:17:58 +0800 (AWST)
Message-ID: <16428df229c494c807ddc75009feffe219f11a22.camel@codeconstruct.com.au>
Subject: Re: [PATCH v11 1/6] i3c: Add HDR API support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Frank Li <Frank.Li@nxp.com>, Alexandre Belloni	
 <alexandre.belloni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
  Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-iio@vger.kernel.org,
 joshua.yeong@starfivetech.com, 	devicetree@vger.kernel.org,
 linux@roeck-us.net
Date: Thu, 04 Dec 2025 10:47:57 +1030
In-Reply-To: <20251106-i3c_ddr-v11-1-33a6a66ed095@nxp.com>
References: <20251106-i3c_ddr-v11-0-33a6a66ed095@nxp.com>
	 <20251106-i3c_ddr-v11-1-33a6a66ed095@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Frank,

On Thu, 2025-11-06 at 12:36 -0500, Frank Li wrote:
> Rename struct i3c_priv_xfer to struct i3c_xfer, since private xfer in the
> I3C spec refers only to SDR transfers. Ref: i3c spec ver1.2, section 3,
> Technical Overview.
>=20
> i3c_xfer will be used for both SDR and HDR.
>=20
> Rename enum i3c_hdr_mode to i3c_xfer_mode. Previous definition need match
> CCC GET_CAP1 bit position. Use 31 as SDR transfer mode.
>=20
> Add i3c_device_do_xfers() with an xfer mode argument, while keeping
> i3c_device_do_priv_xfers() as a wrapper that calls i3c_device_do_xfers()
> with I3C_SDR for backward compatibility.
>=20
> Introduce a 'cmd' field in struct i3c_xfer as an anonymous union with
> 'rnw', since HDR mode uses read/write commands instead of the SDR address
> bit.
>=20
> Add .i3c_xfers() callback for master controllers. If not implemented, fal=
l
> back to SDR with .priv_xfers(). The .priv_xfers() API can be removed once
> all controllers switch to .i3c_xfers().
>=20
> Add 'mode_mask' bitmask to advertise controller capability.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Why not add hdr mode in struct i3c_priv_xfer because mode can't be mixed =
in
> one i3c transfer. for example, can't send a HDR follow one SDR between
> START and STOP.
>=20
> i3c_priv_xfer should be treat as whole i3c transactions. If user want sen=
d
> HDR follow SDR, should be call i3c_device_do_priv_xfers_mode() twice,
> instead put into a big i3c_priv_xfer[n].
>=20
> change in v9
> - fix typo Deprecated
> - remove reduntant master->ops->priv_xfers check.
>=20
> change in v8
> - new API use i3c_xfer instead of i3c_priv_xfer.
>=20
> change in v7
> - explicit set enum I3C_HDR_* to value, which spec required.
> - add comments about check priv_xfers and i3c_xfers
>=20
> change in v5-v6
> - none
>=20
> change in v4
> - Rename enum i3c_hdr_mode to i3c_xfer_mode.
>=20
> change in v3
> - Add Deprecated comment for priv_xfers.
>=20
> change in v2
> - don't use 'priv_' since it is refer to sdr mode transfer in spec.
> - add 'mode_mask' indicate controller's capibility.
> - add helper function to check master's supported transfer mode.
> ---
> =C2=A0drivers/i3c/device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 27 +++++=
+++++++++++++++-------
> =C2=A0drivers/i3c/internals.h=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0drivers/i3c/master.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +++++=
+++++++++-----
> =C2=A0include/linux/i3c/device.h | 40 +++++++++++++++++++++++++++++------=
-----
> =C2=A0include/linux/i3c/master.h |=C2=A0 4 ++++
> =C2=A05 files changed, 70 insertions(+), 26 deletions(-)
>=20

*snip*

> =C2=A0
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index 7f136de4b73ef839fb4a1837a87b1aebbddbfe93..7f7738041f3809e538816e94f=
90b99e58eb806f9 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -39,20 +39,25 @@ enum i3c_error_code {
> =C2=A0};
> =C2=A0
> =C2=A0/**
> - * enum i3c_hdr_mode - HDR mode ids
> + * enum i3c_xfer_mode - I3C xfer mode ids
> =C2=A0 * @I3C_HDR_DDR: DDR mode
> =C2=A0 * @I3C_HDR_TSP: TSP mode
> =C2=A0 * @I3C_HDR_TSL: TSL mode
> + * @I3C_SDR: SDR mode (NOT HDR mode)
> =C2=A0 */
> -enum i3c_hdr_mode {
> -	I3C_HDR_DDR,
> -	I3C_HDR_TSP,
> -	I3C_HDR_TSL,
> +enum i3c_xfer_mode {
> +	/* The below 3 value (I3C_HDR*) must match GETCAP1 Byte bit position */
> +	I3C_HDR_DDR =3D 0,
> +	I3C_HDR_TSP =3D 1,
> +	I3C_HDR_TSL =3D 2,
> +	/* Use for default SDR transfer mode */
> +	I3C_SDR =3D 0x31,

0x31 is 49 - is that really what you intend here? For instance,
building this patch for ARM32 produces:

   In file included from ../include/linux/bits.h:5,
                    from ../include/linux/ratelimit_types.h:5,
                    from ../include/linux/printk.h:9,
                    from ../include/asm-generic/bug.h:31,
                    from ../arch/arm/include/asm/bug.h:60,
                    from ../include/linux/bug.h:5,
                    from ../drivers/i3c/device.c:9:
   ../drivers/i3c/device.c: In function =E2=80=98i3c_device_get_supported_x=
fer_mode=E2=80=99:
   ../include/vdso/bits.h:7:40: warning: left shift count >=3D width of typ=
e [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   ../drivers/i3c/device.c:272:68: note: in expansion of macro =E2=80=98BIT=
=E2=80=99
     272 |         return i3c_dev_get_master(dev->desc)->this->info.hdr_cap=
 | BIT(I3C_SDR);
         |                                                                 =
   ^~~

Should this be decimal 31, rather than hex 31?

Andrew

