Return-Path: <linux-iio+bounces-8501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52841953754
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF27328300D
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5323D1AD3F3;
	Thu, 15 Aug 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhMRsPja"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850C1AAE07;
	Thu, 15 Aug 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736051; cv=none; b=Jrs8p+XntojdQGb/BceW1kjJ60Pu4CzXnyC6T7gyoveVBvZRQy9AlRHYd86aVp2u86I6ldJapu27xdF1RR59XXaN2iybxQyBoJ/sVJhJviZKxFQas46hBU54rGjr10t76PgpLxunRL276kcOoFaev+kjHUXYIH73Y5/7j+ES5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736051; c=relaxed/simple;
	bh=lO/9DG6p8dkE/mRXmkVdf2FJVv6R7pNeWYDyNd1GwmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRPvYRHD94iHZUj2eMiI8w2G+hdsxxupv4LaQ1jlZt3iD6bYqMvz2lY7pPNtDRA7OvzxN+ivkXa5G5oZQY8WO5gVoxnmbdS/vsMyCu32avKFBXYoo8BjDXqPrihcFqMKfBGf6VXzOmQUrpLEkLJm1xKMTxkmMyI6TyYa93DThis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhMRsPja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A4C32786;
	Thu, 15 Aug 2024 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736050;
	bh=lO/9DG6p8dkE/mRXmkVdf2FJVv6R7pNeWYDyNd1GwmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhMRsPjaEpmbIIqFmyYCbzZ2albnw4QrOQeo8GqZyQbUhmQrLR5Y1jNuJkUVgDkUC
	 HlqDHuNYtB9lb3rck0vWOxVXpTBYH+OOMbVQfy7+TmAjrb2Z0gg62/nLHd/DYXfWev
	 /18c0yK6cN9+u4331rzvepO+VpGG2+rJSjt+DvLZP8HV2wUJJtq9Wd9fS+ijC+KsIo
	 vROukEUbpJ/Df30LZB95yfp7cYVIPlkzK1K0mOsQwoUiJ1b1Kyw/25ki93JA4PwZnG
	 coPDevqCSSp4FTJm7DmEtsgnfZ0WO0Ne6b5/Y8sTlZMFi2ctEux1O2zExnGZ3+ZtCt
	 6N9utmHsJVuhA==
Date: Thu, 15 Aug 2024 16:34:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dima.fedrau@gmail.com,
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com,
	Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: smi240: devicetree binding
Message-ID: <20240815-upright-roamer-cd6b16883350@spud>
References: <20240815152545.7705-1-Jianping.Shen@de.bosch.com>
 <20240815152545.7705-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rfmtV2sie2C4bBFp"
Content-Disposition: inline
In-Reply-To: <20240815152545.7705-2-Jianping.Shen@de.bosch.com>


--rfmtV2sie2C4bBFp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 05:25:44PM +0200, Jianping.Shen@de.bosch.com wrote:
> From: Shen Jianping <Jianping.Shen@de.bosch.com>
>=20
> dt-bindings: iio: imu: smi240: add sensor dt-binding
> Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>

There should be a blank line between the body of the commit message and
the signoff. That said, the body here just repeats $subject - but really
should be something more like the description in the binding.

--rfmtV2sie2C4bBFp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4f7QAKCRB4tDGHoIJi
0qV+APwNeprNeGIjAiBeAqGMKqtQpbypLkgbrpQ7xDG8AKZ1VQEAxklwVYhYBvh0
2n25hWLBCmwN9F0Q+0NkAaFXd4GJlg8=
=bxa9
-----END PGP SIGNATURE-----

--rfmtV2sie2C4bBFp--

