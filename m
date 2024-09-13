Return-Path: <linux-iio+bounces-9517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076A97863E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD081C22D63
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA783CD9;
	Fri, 13 Sep 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agJuqF9G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280E77F2F;
	Fri, 13 Sep 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246416; cv=none; b=eQ/63RY0dy95/YRz+u0ahLoO/+uwfTnt2aZSinuMLpIr6uRQ/QbyKDLNUVVMIsN+9SJsDp8aGZiLMNTii+AAyAmk8A3wZyWUid9y7zCzXs+KTNqmeuKG+j5xJGJ5INQhJesi5SmszA2ffOgvIHAsZZicwy9ib1uYO7svsOryotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246416; c=relaxed/simple;
	bh=UQna6N3rca0Eq4h7KEoBYpc7QNZk84q2FJ4iWavyrk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao5iP6NeY+GzfDDlGX50sfa7WT5DzIvrZ2McQVtSY8xD2s1OEc8IC1RKZ34iVx3CuLrMm9XMNKZsYSJCODPYLEIBWY80Ulox0x8ChY574TpeIIVvNgroTNhqTbNfxXqxkJkJGhUJUyf0uGjCm76nf51sNk7nphiF/Z5WC8X235Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agJuqF9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9918C4CECE;
	Fri, 13 Sep 2024 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726246416;
	bh=UQna6N3rca0Eq4h7KEoBYpc7QNZk84q2FJ4iWavyrk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agJuqF9GneXP+ygF724P/DV+U6Jtm3i85v4EowEqSKJ5hC1EAuTWgYSY3Lvhu752n
	 6yL1pYuNk+Qc6N17ShaZT0mf/iAqQIQfLo4Ng9BC9DJpxIr7hdHgxVwK2VzR16dz0u
	 vXVsUjgY+UUKBfnGrj1O58QIjQfqFNc8kELmdu4bet6zx3JwBP+d8TCwWz84FMbShm
	 uA0HycbdY4GMCCTgltkDEyoTmhPL3QXIQeZVEx+LsDissV3FTQVETHf7PiUoIapcVO
	 674bkAD1eQIllZb1MZZCbutMacNdzmUGAIROB6yZ3HPAQfKoMCog4HxhaWyaVZw7MA
	 pKsJwjtqP/LvA==
Date: Fri, 13 Sep 2024 17:53:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/7] dt-bindings: iio: light: veml6030: rename to add
 manufacturer
Message-ID: <20240913-reenact-unifier-f1b070d9fb38@spud>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
 <20240913-veml6035-v1-1-0b09c0c90418@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kVLNrKOYGCdWg8C9"
Content-Disposition: inline
In-Reply-To: <20240913-veml6035-v1-1-0b09c0c90418@gmail.com>


--kVLNrKOYGCdWg8C9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 03:18:56PM +0200, Javier Carrasco wrote:
> Follow the common pattern manufacturer,devicename.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--kVLNrKOYGCdWg8C9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuRuCwAKCRB4tDGHoIJi
0jhtAQDfHKxRoIKNtzmzvuYxRawyrbK3jHPJYrO+uPtlf8u0rQD+Kcez5JtE3X36
921S8Gg5fGRAaslC1FJaVw6CyDe48Q4=
=myUg
-----END PGP SIGNATURE-----

--kVLNrKOYGCdWg8C9--

