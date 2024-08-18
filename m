Return-Path: <linux-iio+bounces-8569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D503955BDC
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 09:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3441F21841
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C982168B7;
	Sun, 18 Aug 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J62pEbGg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3D17BA0
	for <linux-iio@vger.kernel.org>; Sun, 18 Aug 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723967434; cv=none; b=tI7K+3h4WqS0tucg8W024xKyya8V5jjSY18Q1srVcnEfrOJ77KhfZzUqpFyIbPwSG1aRF7JmxdyZ4tdWGrM5lL6pIq1xMvBleqAXAWnhZAi2kirzkPnunl+Lf8xHK6Hm6PDJ9P42QKYi3mD6uPVSVnIbLDusAnS0JEuGGNCDpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723967434; c=relaxed/simple;
	bh=1pOEg6WRULQgkgic42j0aMhYi28NGYo+U14lJiCz4mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWo5Ach1WWMxPIfWFIAf7g5CN5y3Vxaj/P8UclmijroWQ/hHNG1aaYiA4hAAsSaUgUqpsFNHTkRcGmBMqsJxAtzeDxw3Ic5SdJoRRorz0Bg0pJn91rYnW8QYLiA7KI2clmej1HIt42hAbT3z1hO93tLCy3Ejjrl3+j+IBHaLyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J62pEbGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91767C32786;
	Sun, 18 Aug 2024 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723967433;
	bh=1pOEg6WRULQgkgic42j0aMhYi28NGYo+U14lJiCz4mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J62pEbGgMx901fCST54rJlZHI5Gea+5LNGu5Hlyf5Abr7IAFvuAmR25nLiEb9hDVQ
	 Gfy/grg10EPm31K3wsjDQqqV+lz4J0Xpmr/+9p4vd+gvvgXbqySJttv95FGPeqtG9U
	 mHghBwI3GtF6VK44VOQ7Covgo0shYuAa1dAsjxbUMgvkeg3bOXGWiSRYnZEztD0AKR
	 GWtbwdEzTN4iD+p4wMFpgt2G/H6SCdI5Dgsj4KE+3spaWvpJ7b7W7gcTZDNYAQyDOo
	 XgkT6kiWY8jnDwYpFI9qDQHu3RAEOBApynJVo/X4nVDaIm+w2ZGH3cwY5JgCvyI2R+
	 7a9MGo1X5VrZQ==
Date: Sun, 18 Aug 2024 09:50:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Okba Slatnia <okbaslatnia@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: st_lsm6dsx minor issue
Message-ID: <ZsGnxBpYxihXxtC5@lore-rh-laptop>
References: <CANArCKRKt4-Epxw6KCmrtRZNKBKTLT78m9Rq0__3GG9BJMh6ig@mail.gmail.com>
 <20240817174630.1c24bb02@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Yi86gNH5O7cTjyQ"
Content-Disposition: inline
In-Reply-To: <20240817174630.1c24bb02@jic23-huawei>


--6Yi86gNH5O7cTjyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 8 Aug 2024 15:27:33 +0200
> Okba Slatnia <okbaslatnia@gmail.com> wrote:
>=20
> > Hi all,

Hi Okba,

> >=20
> > I'm building a yocto firmware based on Linux kernel version 5.15.148
> > and i'm facing a little limitation or problem preventing me from
> > changing the value of the sampling_frequency of the accelerator:
> > /sys/bus/iio/devices/iio:device0/sampling_frequency
> > despite i'm following the
> > /sys/bus/iio/devices/iio:device0/sampling_frequenc_available for the
> > possible values.
> > for the info , i can successfully change the sampling_frequency on
> > another yocto firmware based on Linux kernel version 4.19 and despite
> > keeping the same kernel flags confs i'm still facing this issue , i
> > made sure it's not an access right issue because i can change other
> > files in the same path with same access rights.

Can you please provide more details about the issue? Are you able to change
gyro sample frequency? Is the sensor-hub enabled?

Regards,
Lorenzo

> >=20
> > Can you please help me and tell me if I missed anything ?
> > Thanks in advance.
> > Best Regards.
> > --
> > Okba
>=20
> +CC Lorenzo on basis maybe he's seen this before?
>=20
> Jonathan
>=20
> >=20
>=20

--6Yi86gNH5O7cTjyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZsGnwQAKCRA6cBh0uS2t
rN3iAQC3d40v2jkmQpSSIUWPYQfACnW7+LDin6nNWXKu6y1vvgD/ZpE2B0qmgBcT
wrwG32Atw80SUaA8P7TrXKLHlS1/DAE=
=2+5M
-----END PGP SIGNATURE-----

--6Yi86gNH5O7cTjyQ--

