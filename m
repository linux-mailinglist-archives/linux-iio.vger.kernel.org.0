Return-Path: <linux-iio+bounces-21791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B21B0BB09
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 04:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6981896640
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 02:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA91E9B19;
	Mon, 21 Jul 2025 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RURl3D1h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBB76025;
	Mon, 21 Jul 2025 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066553; cv=none; b=dLwKZN9P5iO+Wk7c83tlV37jekrZ5V0428e/kL40l/p+MXALCj8Orn9N3aFNs1zIs5L9mwXFVD7lSxF/gr1wMD/XuBuKxjbrpp7OcI7s7IUDesKuEBz/dxJlne3bt6u3e8ojlAp3Lf6aX6oOWXilHcjwToXGHo5qnvWdpSQcCs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066553; c=relaxed/simple;
	bh=A9TfaQq6g4fpPuFG3zk9UUsbH8e0HjUsNBi7GH7YvJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6OFr0HRw0XXwrtZcdTi5elJA23OMLh0l5OEldXmtQBr43Plv2+fzaJFZMImWviusTrJRC35P7ckzUPtMsPaX87h//sZJbu2AIaoBYzRpgn7X42cpKA51T0fnZMaCFZtCzt2yVcQKKCFvXnwKyzRWTFsLO1Ldt6Dbt1uP6wjjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RURl3D1h; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1753066398;
	bh=l3w3kZ+rbtUg5hgkSE788X2h1S7cieDnuzEy3BkD9Ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RURl3D1hEbUOggxyugfW9BT08TsbeNAxgTh1z2nITPDR/Q6TmJZBZgRMD17G5cL0/
	 xSftPyzL9BAHlRdqRBp+0C2Ym1JGHBomg530DNDXEh99XqWw67QYsCdWtY/pfYlUXE
	 +51Jg+iaYFNHOormE/kl+puivlAyCp/ALR0/Kn9Rpee80zHlWCmmdy6McKu5tqPS51
	 LN8/NsSKAKjtSsMxUv29QXK+acxJKYK1ZHzu3zBd/QZvwPWRX+J8/YENhIsNkZ9Rrb
	 bDfqVkRKroH43kkDdNR86E7YROOnBKqHt8F1oZ/GxuU2Kc05z0EJUTtVB9hx6/TGf5
	 Vu3Ri62RYdQnA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bllMJ25ryz4wcd;
	Mon, 21 Jul 2025 12:53:15 +1000 (AEST)
Date: Mon, 21 Jul 2025 12:55:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Greg KH <greg@kroah.com>, Arnd Bergmann
 <arnd@arndb.de>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: linux-next: manual merge of the iio tree with the spi tree
Message-ID: <20250721125545.6db07df5@canb.auug.org.au>
In-Reply-To: <ca0be466-6673-425d-97ab-292791253a63@baylibre.com>
References: <20250703163824.2f08d866@canb.auug.org.au>
	<20250703093122.00000684@huawei.com>
	<b0b0443d-143f-4e41-b8b8-91c6726e838f@baylibre.com>
	<20250706115053.368ce9e9@jic23-huawei>
	<ca0be466-6673-425d-97ab-292791253a63@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wgLcO60fZwqhqxUyPp5Z9m.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wgLcO60fZwqhqxUyPp5Z9m.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 6 Jul 2025 11:15:14 -0500 David Lechner <dlechner@baylibre.com> wro=
te:
>
> On 7/6/25 5:50 AM, Jonathan Cameron wrote:
> > On Thu, 3 Jul 2025 07:28:07 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> >> On 7/3/25 3:31 AM, Jonathan Cameron wrote: =20
> >>> On Thu, 3 Jul 2025 16:38:24 +1000
> >>> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>>    =20
> >>>> Today's linux-next merge of the iio tree got a conflict in:
> >>>>
> >>>>   MAINTAINERS
> >>>>
> >>>> between commit:
> >>>>
> >>>>   e47a324d6f07 ("dt-bindings: trigger-source: add ADI Util Sigma-Del=
ta SPI")
> >>>>
> >>>> from the spi tree and commit:
> >>>>
> >>>>   0dd88eaa7126 ("dt-bindings: trigger-source: add generic GPIO trigg=
er source")
> >>>>
> >>>> from the iio tree.
> >>>>
> >>>> I fixed it up (see below) and can carry the fix as necessary. This
> >>>> is now fixed as far as linux-next is concerned, but any non trivial
> >>>> conflicts should be mentioned to your upstream maintainer when your =
tree
> >>>> is submitted for merging.  You may also want to consider cooperating
> >>>> with the maintainer of the conflicting tree to minimise any particul=
arly
> >>>> complex conflicts.
> >>>>   =20
> >>> Thanks Stephen,
> >>>
> >>> David, do you prefer these merged or kept as separate entries?   =20
> >>
> >> Ah, shoot, I forgot that we had added the gpio one and just made
> >> one section like this.
> >>
> >> I think it would make sense to also merge the new adi one with
> >> the reset to keep things compact.
> >> =20
> > Is there a path to do that cleanly given the multiple trees things are
> > coming from?  Maybe this is a let things resolve whatever way this cycle
> > and tidy up next? =20
>=20
> Agree, waiting seems the simplest option.
>=20
> >  =20
> >>>
> >>> I don't think it matters either way in practice though this is the
> >>> more complex merge (the other being just putting the blocks in order.
> >>>
> >>> We can put a note in the pull request on preference but ultimately Li=
nus
> >>> will resolve this however he prefers!=20
> >>>
> >>> Jonathan
> >>>
> >>>    =20
> >>>> --=20
> >>>> Cheers,
> >>>> Stephen Rothwell
> >>>>
> >>>> diff --cc MAINTAINERS
> >>>> index dd764b947dab,d0809d62ff48..000000000000
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@@ -25333,19 -25201,15 +25341,20 @@@ TRADITIONAL CHINESE DOCUMENTAT=
IO
> >>>>   M:	Hu Haowen <2023002089@link.tyut.edu.cn>
> >>>>   S:	Maintained
> >>>>   W:	https://github.com/srcres258/linux-doc
> >>>>  -T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
> >>>>  +T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
> >>>>   F:	Documentation/translations/zh_TW/
> >>>>  =20
> >>>> + TRIGGER SOURCE
> >>>> + M:	David Lechner <dlechner@baylibre.com>
> >>>> + S:	Maintained
> >>>> + F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.y=
aml
> >>>> + F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.ya=
ml
> >>>> +=20
> >>>>  +TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
> >>>>  +M:	David Lechner <dlechner@baylibre.com>
> >>>>  +S:	Maintained
> >>>>  +F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma=
-delta-spi.yaml
> >>>>  +
> >>>> - TRIGGER SOURCE - PWM
> >>>> - M:	David Lechner <dlechner@baylibre.com>
> >>>> - S:	Maintained
> >>>> - F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.ya=
ml
> >>>> -=20
> >>>>   TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
> >>>>   M:	Dan Williams <dan.j.williams@intel.com>
> >>>>   L:	linux-coco@lists.linux.dev   =20

This is now a conflict between the char-misc tree and the spi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/wgLcO60fZwqhqxUyPp5Z9m.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmh9rDEACgkQAVBC80lX
0GySkAf/fjk0UMRpWWchqAdo+Ps6HxpVLFdfeIOA3fn0uxuMgk90qJWSmnnzi/s0
kXoe2UvCGFAQVfjCQuU+T9W7mLdVr4s0H3YrJXwbTPKxSiljNyG1CN7ia0bsLotg
BSJTTrLwDv00P1ps74sBRxye0HitZeq4ApvNav3WVTzW2umUjzFBInWjoGp69aEy
LmRC8P23INTVKcEBmUIJYY5LPOpfGIP9rKDeAZHpo/XlXnq9avB6+4xA3M4hyLtW
fhxMHr2a2raQkWTcuXj5yfiRQVuzzF+xyKm9oubE24u+/4/n+tWdxDXdmSw+sQ8i
uvtXECB8ONdhVfKhK8CcoulTfTxjRQ==
=ScdC
-----END PGP SIGNATURE-----

--Sig_/wgLcO60fZwqhqxUyPp5Z9m.--

