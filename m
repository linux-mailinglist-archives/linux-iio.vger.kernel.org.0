Return-Path: <linux-iio+bounces-19947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC19AC42B1
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3544B3A6D76
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF61218E97;
	Mon, 26 May 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oci25Iw7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21A288DB;
	Mon, 26 May 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274949; cv=none; b=UTOCJJ5JRJQBXwo3oft7j5uQepDOt6J8O1lkrzwZWhnMW5SJJOvX+J4o133dT1NQCCNxuN0GV+jW6eECThWVV4VKOtyMrlTPpG4hIrUFqoZAtQcr3xahlCdVAOMwPbQ9ZjHRGV+YamwpvJZOZwEPkzy3XCQYQ++Zk1awC/KjCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274949; c=relaxed/simple;
	bh=qS06HAU2Ci7YnW1f4F114KPUB3jPs6XZjrbv1n35RWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqmatlN07FSHEyCMwoV5y/wHFipZr05PnViGOgouAnjqn0+vFVjV4G4gzgY01I+frNbvg0gpVCkBnFR0sFI7fnXc5gUCwR8gzxdOkKj5J1ffgbZa7haPS56v9lcQKrrWKjJQCuMK7vxcVKVaEno7Q1oQdS/zgYahsbo+Lq2nGgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oci25Iw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09C9C4CEE7;
	Mon, 26 May 2025 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748274949;
	bh=qS06HAU2Ci7YnW1f4F114KPUB3jPs6XZjrbv1n35RWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oci25Iw7cICH9wSYAVHcMpPZAobINJcYhC0ocbLxrFW9SpyyJHy61pMBQlLNi5C24
	 jMcALgExK51zd9RrSF/gdo/TgBplSDkJeUi8IraM99Hl+drKRgMy0q2qre4dwRjRQ9
	 q6y+N5iKgcXPkj4VW01/a4YDpXcUGef+yA3CEuoQMsZlo+dPVDEfahVu285Bgi4QPR
	 A1jCae8wbF0MSyrlRjAaMpZ+x/I2AcbOeJdi8ueknLEJPHji7aum/2BgUYgpLOsYYM
	 WVjuk9LzQE9mY1VEyeMbwi4vQDa2DHchTWUL646/Iok1I9p6I0ctuozgrRAQBZpYoJ
	 +63jfYDEguVYg==
Date: Mon, 26 May 2025 16:55:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: adc: st,spear600-adc: txt to yaml
 format conversion.
Message-ID: <20250526-overtake-charger-6c5ffcc2bc09@spud>
References: <20250522204130.21604-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LmK9+h1hO9uXVFdC"
Content-Disposition: inline
In-Reply-To: <20250522204130.21604-1-rodrigo.gobbi.7@gmail.com>


--LmK9+h1hO9uXVFdC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 05:37:16PM -0300, Rodrigo Gobbi wrote:
> Straight forward conversion from spear-adc.txt into yaml format.
>=20
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--LmK9+h1hO9uXVFdC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDSPAAAKCRB4tDGHoIJi
0oauAQDC2i3XwsjInSgkRG4ihMN85z6WwylF17vm4QnQ0bOwUwD/QvmkaQDqD859
lPXenQgZI10wenbzgy2vMCa279YpRQk=
=fIq6
-----END PGP SIGNATURE-----

--LmK9+h1hO9uXVFdC--

