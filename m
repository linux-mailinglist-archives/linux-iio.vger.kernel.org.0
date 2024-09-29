Return-Path: <linux-iio+bounces-9864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F49894DD
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D160B2341C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F791155730;
	Sun, 29 Sep 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlbta1E5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFA3D96D;
	Sun, 29 Sep 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606852; cv=none; b=VyE1Lw+yOkWCQ0xBpXVc5SGZ5r1U1Y+hDTRrOHmUAwfQRyQvM/b4gpTlpSImRxy70Z2DKOVMSTKiMcoVmcNkLVxydHviCF4ug+4j4cUekwOm8TKGFwq+XG0Ck5SYWLBdBlyi3ehAHsg8zU7E0FBmFsOs6ovqYge2+aJk1vxbXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606852; c=relaxed/simple;
	bh=RtcJqKRkF52DRcn46Cbmx3cQhW9g61yKufaLaMDAvDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFNcb6UU0PmJ5SMjR/+YYha1bBda8qk07J5hcx4jpmya7cV7b20HS8ccoCsKKzqbSJ6/mVWTtpUWi/HRhl9lh7oLPd1UNWsyMF0D9qXjIaqnAqKHQW3CbXw1PapjUy+d6kWistIRxqwOJ1kz+wvm3gW/VUEiv7cdsZw/Hqc0Io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlbta1E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07226C4CEC5;
	Sun, 29 Sep 2024 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727606851;
	bh=RtcJqKRkF52DRcn46Cbmx3cQhW9g61yKufaLaMDAvDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qlbta1E54hDdFqK/AITVIf95Xk1qDgq8xl2FJFmZ9DCXWCKGZbmRguM2+LaJXh8y6
	 pWWugIpcqitbQ4vD19ZNxwF+rwmC9h4jV1dQErMUmPB9llkeOBJ3WTxbTtVHvG9Uik
	 fjploEG32mQ9WhdvF5p4pMtYKcpFd42ObafucH5m76brSJ8+lY5vnSgeb5PSbxzAOP
	 bOUdy0kd5NfRDJV+BE49Wh+s7Xu6EadIjw+mAFEwVicWrnltEZw9ynr8OBt7g78a8y
	 LgzueFQ7ECOgJ+pBj0GzAmVkxX3V1HlmHIDLEsk7CCJ1V7imLrYjB+lMBiiul/pWA7
	 mFykZ3VGlNFAQ==
Date: Sun, 29 Sep 2024 19:47:23 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Vignesh Raghavendra <vigneshr@ti.com>, Judith Mendez <jm@ti.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Enable eQEP DT support for Sitara K3 platforms
Message-ID: <ZvkwOwjnmDD8qKL7@ishi>
References: <20240924220700.886313-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OUFaQb3KW0RrQgw3"
Content-Disposition: inline
In-Reply-To: <20240924220700.886313-1-jm@ti.com>


--OUFaQb3KW0RrQgw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 05:06:55PM -0500, Judith Mendez wrote:
> Git rebased the series since due to merge conflicts, part of the
> series was not merged. Also dropped the patches that were already
> merged.
>=20
> This patch series adds eQEP DT nodes for K3 Sitara devices:
> - AM62x
> - AM62ax
> - AM62px
> - AM64x
>=20
> Changes since v5:
> - Drop patch 1/8, 2/8, 8/8 since they have been merged
>=20
> v5: https://lore.kernel.org/linux-devicetree/20240612135538.2447938-1-jm@=
ti.com/
> v4: https://lore.kernel.org/linux-devicetree/20240610144637.477954-1-jm@t=
i.com/
> v3: https://lore.kernel.org/linux-devicetree/20240607162755.366144-1-jm@t=
i.com/
> v2: https://lore.kernel.org/linux-devicetree/20240523231516.545085-1-jm@t=
i.com/
> v1: https://lore.kernel.org/linux-devicetree/20240418221417.1592787-1-jm@=
ti.com/
>=20
> Judith Mendez (5):
>   arm64: dts: ti: k3-am62-main: Add eQEP nodes
>   arm64: dts: ti: k3-am62a-main: Add eQEP nodes
>   arm64: dts: ti: k3-am62p-main: Add eQEP nodes
>   arm64: dts: ti: k3-am64-main: Add eQEP nodes
>   arm64: dts: ti: k3-am64x-sk: Enable eQEP
>=20
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 27 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 27 +++++++++++++++++++
>  .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 27 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 27 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 17 ++++++++++++
>  5 files changed, 125 insertions(+)
>=20
> --=20
> 2.46.0
>=20

I recall last time these needed to go via the TI SoC/arm64 tree [^1]. Is
that still the case, or do you want me to pick these up now via the
Counter tree?

William Breathitt Gray

[^1]: https://lore.kernel.org/all/d595b624-ef18-4aac-ab2c-bd36a8c4de3d@ti.c=
om/

--OUFaQb3KW0RrQgw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZvkwOwAKCRC1SFbKvhIj
K4nMAQDyoI71+zbieWI6XkGWOv7f3wIXmBY6Yn3FQ4+Slqzb2AD+Pd8GXuLV7WTx
PdMblT5DAFSL937SsLzffg71+tBZHQs=
=MhGE
-----END PGP SIGNATURE-----

--OUFaQb3KW0RrQgw3--

