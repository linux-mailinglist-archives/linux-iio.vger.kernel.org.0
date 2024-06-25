Return-Path: <linux-iio+bounces-6906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DE2916D75
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DE28EF44
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246E116FF52;
	Tue, 25 Jun 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxzO1ouV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C71169AE4;
	Tue, 25 Jun 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330591; cv=none; b=KTbaNL/YySfRlpY+oTM7EJYFWf5jZpIMm0EQ5Xs5UPHfdvxWG3R7n3fbIgYartGmexsjMR9fxXE8mnHcLn6WGSiV2BV2C0+p3AlYO/RBWH60bhGosQn5+tuvVDhaFeoeeE/m4l9K/ihwr2QtYCvECjEdAPin/imDhRA2L+3djpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330591; c=relaxed/simple;
	bh=AnM9JXgP30+9hiiORTRUz9U2KnMYrFQxbEn/z6IU0kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBuyo7f08TGmdVBOeNZ9TLKUKhvmqgsCVfkyq0C1ZZYd8FtdXWKx5K+ucL1sn6hXRP2dZtygfgo5pQJzaKcMO+CIQRcSao/qfaVHRBGzldcp/rQArol5gc+axQqrJ+qF+Kz1vh8dWCIWEjCaItClN/rRf79lmqpGINqAum6LTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxzO1ouV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE393C32781;
	Tue, 25 Jun 2024 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330591;
	bh=AnM9JXgP30+9hiiORTRUz9U2KnMYrFQxbEn/z6IU0kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MxzO1ouVaoqReTGGEkZedGg9Uufd15gfhRjAdMPSY4mSwbMINhomCe8ivv67lOooI
	 oP9n7qHG5Np3an4JPOXDGtcm5HQ1w4iyIYmIvh2nPRacQ9njztVify/nZo/c+wpK6m
	 +atXSwg6MF02oQWlpoGfL5GZ4LqnRiYuX/s+1u9Xawsu6F/OGDTXIEDW/E/qHMMPFr
	 ftPEW+EpW52juma0ny6b92ZTOVIpFul/Ej2XHkovNR+yGglOiVZE2oWKfkyHoFQGxi
	 UFODlGV2IdD3NXOUWLooGNLaAi1rTjOXfB546+U9gzsrMO1BcGm2Ui1r8VAjmiKnnL
	 L7+ADdl3hPL7Q==
Date: Tue, 25 Jun 2024 16:49:46 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
Message-ID: <20240625-resolute-evident-120c2b494095@spud>
References: <20240624-iio-adc-ad4695-v3-0-a22c302f06bf@baylibre.com>
 <20240624-iio-adc-ad4695-v3-1-a22c302f06bf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FDA6XUPjNT97sviP"
Content-Disposition: inline
In-Reply-To: <20240624-iio-adc-ad4695-v3-1-a22c302f06bf@baylibre.com>


--FDA6XUPjNT97sviP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 05:01:53PM -0500, David Lechner wrote:
> Add device tree bindings for AD4695 and similar ADCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> Note, this may trigger a DT build warning "common-mode-channel: missing
> type definition" if the builder doesn't include the recently added
> common-mode-channel property [1]. This should be safe to ignore (passes
> make dt_binding_check locally).

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--FDA6XUPjNT97sviP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrnGgAKCRB4tDGHoIJi
0tHIAP4x82JMWQquYAjaQ+zUZW+CYrOeM9D7Z/BdMOd8OlkHlQEA1gw87fxpyOgj
8oP4O/PQb7YTXNGBM2GE3Bkr2JuScQM=
=VpyM
-----END PGP SIGNATURE-----

--FDA6XUPjNT97sviP--

