Return-Path: <linux-iio+bounces-13794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE59FC5CD
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 15:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F5D1882614
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8554D1BE23F;
	Wed, 25 Dec 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkycINAe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED51C07C9;
	Wed, 25 Dec 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735136619; cv=none; b=Af23PTn1FM5oKgmOv80T8RJOxs3N6WcFVDwwiLNnEml9Vt9k6XbJeNthl1QWBNABxbKbxlSt+6Nnu3KSt3CpQHDIdd8VIk13vS74ORpP4mgZ0Imne+jX4cTXqFTf1qwM0KEZfV0yMocz46eMA8qDetKg3vlWp2zfqBWQ6vggjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735136619; c=relaxed/simple;
	bh=RO6AIaAioWJRmTpmW+m5oE4b42tK5y58gI00fOTNNCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIJz5hFFXnmmRue2SZbInri0xFNlu6O5NO2Pouc7GwpoRJW1x6NZtBw0mpcBWgkUd2Anvgc8T44gWJCj/gxPtOgfNMorZ2l/O/644NThhY45II0430YbNYgz6x+BiwsF1AowXHK0MpsoRW92JH6EtF74tdHtn1ONjESpu+pOKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkycINAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9B8C4CECD;
	Wed, 25 Dec 2024 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735136618;
	bh=RO6AIaAioWJRmTpmW+m5oE4b42tK5y58gI00fOTNNCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkycINAe7DzN/wUMDFXwX1XwLuXkNg9EvpFwsPEBlqrvg5m+f1rs3+RhteVJigvG+
	 VyY8vAX7t8YZTty2rcLprTbN3uKnoC4xcbMdrvMwa0ILeVzQeGDGHJaJpgTdST8/5l
	 8xC+t4FXtGQDg3QK46CeKEmW6+gkbgAkX+B573ZnWxxTluv5vXvw6sleN3ZeqIihIb
	 Wy/RZcM+PyMCqnyJFyQ5GhEq/IrCpFgv6TDofLuCvT5eR1vLRvLWNGdi90hD9ll2uR
	 DyqJca91Ve4Zr0vrGnW8KEmYGxzWxFMGu2WuXPdM2OUmx7mX1JyPbQevujOY1gNi1E
	 I2ICrbnS70RUA==
Date: Wed, 25 Dec 2024 14:23:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lanzano.alex@gmail.com,
	jagathjog1996@gmail.com, trabarni@gmail.com, danila@jiaxyga.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] dt-bindings: iio: imu: add missing property type
Message-ID: <20241225-economy-jailbird-b798ef7f50c4@spud>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/DZEfzmxF6A3lL6+"
Content-Disposition: inline
In-Reply-To: <20241219234745.58723-1-vassilisamir@gmail.com>


--/DZEfzmxF6A3lL6+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 12:47:42AM +0100, Vasileios Amoiridis wrote:
> It seems that some drivers miss the "type: boolean" under the
> drive-open-drain property, so add it.
>=20
> Vasileios Amoiridis (3):
>   dt-bindings: iio: imu: bmi160: add boolean type for drive-open-drain
>   dt-bindings: iio: imu: bmi270: add boolean type for drive-open-drain
>   dt-bindings: iio: imu: bmi323: add boolean type for drive-open-drain

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--/DZEfzmxF6A3lL6+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2wVZgAKCRB4tDGHoIJi
0sm0AP9HOHJL3SR/D8dkG2v4r5sJoaxaNn++O86N+7jjTZ3dhQD/Zn1RKFonqb6k
gMSlLpdAkvZjmOT7Ya+tskXBScfCXwo=
=OXii
-----END PGP SIGNATURE-----

--/DZEfzmxF6A3lL6+--

