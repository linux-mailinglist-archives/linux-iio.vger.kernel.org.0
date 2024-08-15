Return-Path: <linux-iio+bounces-8502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D054B953770
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84080287E59
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FA61AD9E8;
	Thu, 15 Aug 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Q167X+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8011AD3F7;
	Thu, 15 Aug 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736302; cv=none; b=T9crKeWtUjzlA61kVRSyKROwL9iPcWec9qp6pbc8Ma5Mdp20Gj81YEJL1ktwPt7mmYGmohOkpfutg6yw+4Ny8GXmnppHhNrYU4lmD4wjyKWsuO5VCwWUqs+hibAVgaLPIpaFMX+IwYR6WJhXUPdYAOAxImIuE5sn8vJjMAJq1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736302; c=relaxed/simple;
	bh=uvYOueyd/O7doWyK4k7P+xgwA4/lGDlRYMCAp97HxOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFuPDmPkU0efNoKH7wLDFlGTqLeLGr4251T0X90uWuF5ejgvARzGQYkeO+5gTolmy1zXQeelNEqCivhy35tp8xlvMgK//MLYBTFPWiXzr/xk6+hGv6W8iYo9ZTsuYzskW8gsJtpvUCaDbLzECge/DmigVg1cM60/eDdZ0kGaSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5Q167X+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E71C32786;
	Thu, 15 Aug 2024 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736302;
	bh=uvYOueyd/O7doWyK4k7P+xgwA4/lGDlRYMCAp97HxOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G5Q167X+Egk3zwVnT0SzVeEPZT4RF7I0sPso5bwTJlxktLRLi3X/6mVCoAbUmwlUo
	 ySMYImQ2ixZaIAIrR1LL/z1xVZ+18x3+FUmtG0S6+URa7tVzYPgZt3xACIKKMa+KiB
	 VR84/cOrJIYaEDZB3lVlnVASaOE+XHgARlitBBtyXW9RjOhP4E7veROkVgKckvSV3Z
	 xRDYFjueRLBnULFJxRrui0p6oMPf6NdMv5xE6crZQa0dIPqyp4rzbfU5fGmbRJ9o/R
	 32E9IHjujG2DMoYXqmjQWPVJqD4maR2ddlkc+prgv9R0bTKX+bJdMPWFU2r34CMBgZ
	 7waMKPf2YVZqQ==
Date: Thu, 15 Aug 2024 16:38:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: smi240: devicetree binding
Message-ID: <20240815-backboned-ashen-2f1319439953@spud>
References: <20240815152545.7705-1-Jianping.Shen@de.bosch.com>
 <20240815152545.7705-2-Jianping.Shen@de.bosch.com>
 <20240815-upright-roamer-cd6b16883350@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9+vdIffJMGR60qI6"
Content-Disposition: inline
In-Reply-To: <20240815-upright-roamer-cd6b16883350@spud>


--9+vdIffJMGR60qI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 04:34:05PM +0100, Conor Dooley wrote:
> On Thu, Aug 15, 2024 at 05:25:44PM +0200, Jianping.Shen@de.bosch.com wrot=
e:
> > From: Shen Jianping <Jianping.Shen@de.bosch.com>
> >=20
> > dt-bindings: iio: imu: smi240: add sensor dt-binding
> > Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
>=20
> There should be a blank line between the body of the commit message and
> the signoff. That said, the body here just repeats $subject - but really
> should be something more like the description in the binding.

Crap, I meant to say that with a fixed commit message,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--9+vdIffJMGR60qI6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4g6QAKCRB4tDGHoIJi
0hxDAQCTqGOhLFMQnT3yUhpk5NpcDtU2iR18YQe5X97G6Ef7ogD9Eu+y/ApYD67q
8PQmVOMK6Pqmws4YK3SmPMh4GqETUws=
=0muT
-----END PGP SIGNATURE-----

--9+vdIffJMGR60qI6--

