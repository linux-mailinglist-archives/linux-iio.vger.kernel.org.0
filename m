Return-Path: <linux-iio+bounces-3961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FC893A7D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765EC1F214EC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 11:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01312200D4;
	Mon,  1 Apr 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8IZSuox"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E71CA80;
	Mon,  1 Apr 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711969499; cv=none; b=FphI3xT9CvQY47TE2juV+x1hHdVqPDo3GFbdSf2mlBQQu3/YchiTdvlsCzP8pLCqCJ/hmWi3Lln5BjNiSN6xgW6iR+T45b5uCyXRqlfWwz4WBkk+9G+kbAfxQQ1QKAl5lOHicU5jpOlScfVAqDndpqE7AMUDBFRxmuhJypMfTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711969499; c=relaxed/simple;
	bh=wbtZnZNRzG00lE4ZHsrFfChA6qI7zlnMd624QHakRZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kicn6YwmqMSnFnevCpEkEV0cwgdSI7ZB7RpBR+59qH1QhUSzbpm9ugcT5lJbR7dTxiPxky2SbrhnCiz9F8CC6WDqmnuUb4UTxuWQUS70xwkrv01SGPmkZbmzeWgW7ZLh26C5VpawrP5MMa6Du0Br/4wF31QthRmiPq5VknEiyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8IZSuox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7D7C433F1;
	Mon,  1 Apr 2024 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711969499;
	bh=wbtZnZNRzG00lE4ZHsrFfChA6qI7zlnMd624QHakRZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8IZSuoxRJhu8qiI0bvQ+KWX6aLPoUDgT3FtRXWU+bZh4L9xCMQEI/6vN6WqgI37L
	 z/kNP6h8fxKgpwky/MZdfAWNdc/fnk4zlwhQVKAuz1auK4cbo8TPCKNdTiCjlaYQZB
	 osrOZw2s6AmpsFek5BgxBr35oNUfjFg4In1VJtRilRNrZMicJyNoa1M/LmRqDCbDIs
	 NjxtWEfbRv7EP4N1Hmk2pUrNmfSCKdTsPFDm5ibu2W6TR3NQEN0tET23tFwQLFLBzQ
	 QWtPGxdTu8QOiFRiAvsPXiNm5La3P950PAFt/74dc7+FMZIPBjqom9BsA7LUOsy+iv
	 NmOyB7Tr9dsnw==
Date: Mon, 1 Apr 2024 12:04:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: inv.git-commit@tdk.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: add icm42688 inside
 inv_icm42600
Message-ID: <20240401-marshy-derby-e22a469dd555@spud>
References: <20240329151535.712827-1-inv.git-commit@tdk.com>
 <20240329151535.712827-3-inv.git-commit@tdk.com>
 <20240329-fifth-earpiece-78daf4d943ce@spud>
 <20240330161012.0b49846a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JM0RkxI3fhX4QnJ4"
Content-Disposition: inline
In-Reply-To: <20240330161012.0b49846a@jic23-huawei>


--JM0RkxI3fhX4QnJ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 04:10:12PM +0000, Jonathan Cameron wrote:
> On Fri, 29 Mar 2024 15:49:26 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Fri, Mar 29, 2024 at 03:15:35PM +0000, inv.git-commit@tdk.com wrote:
> > > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > >=20
> > > Add bindings for ICM-42688-P chip.
> > >=20
> > > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com=
> =20
> >=20
> > My initial thought was that you're missing a sign-off, but is
> > "inv.git-commit@tdk.com" some system you have to bypass corporate email
> > garbage?
>=20
> Common enough setup, as long as the From: line matches the sign-off, git =
will
> ignore the email address used to send it when the patch is applied.

Yeah, I know how it works, I do it all the time. Even found, or rather
caused, a b4 bug where it would use the sending email in the eventual
commit rather than the author:
https://lore.kernel.org/tools/20230310192652.ymac3w2lucfdf34p@meerkat.local/

I'm just double checking that there's not a missing signoff. When I've
seen these corp-email-bypass accounts before people set a proper "from"
in git send-email so there's a name in it: "A Dev <inv.git-commit@tdk.com>"

--JM0RkxI3fhX4QnJ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgqU1wAKCRB4tDGHoIJi
0mx2AQCw3AX3o7N04ZQGuKrZUA7QMBjJ16z+Wc8PN3g4BZwoggEAip0s/vx2YKD2
FEJIJRvZt4AlQbPJZwvIRjSQVh5Fsg4=
=CSLb
-----END PGP SIGNATURE-----

--JM0RkxI3fhX4QnJ4--

