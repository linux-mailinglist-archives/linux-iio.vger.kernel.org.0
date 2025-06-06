Return-Path: <linux-iio+bounces-20275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F77AD069A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8B53B21F0
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C68289E3A;
	Fri,  6 Jun 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU290Q0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A678F2F;
	Fri,  6 Jun 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227081; cv=none; b=M5MryAdyhWAbvClFwBqee9TywImvcDx41SP2HCjrWjpaTBggbOMMlyQm4qw8VFbqua8ozqZNx0nyieuZ+14E9CkdmWE397XPF6ZMJ+dwisS4kswCq8a6QwoVNgikqXKmpy7CpPzV5kWrglDtpmz36pSRlalDY7CPTyqKOhYUNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227081; c=relaxed/simple;
	bh=Xf9kmEEuLAigJEs+1EdF+1tvIYHiWd48C3uxpyoKTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtH234RBBnrNdiBPz7WAx4yayM0OWIbrk9fshh6aSo7Fm2RYaDs47oI801eH1jr0JY5WJUDr52FORZDgTAG9EIftgPbjjLMpbJ3pWGEUtoPXRE/PsIN8EfZoXFIBtntqx1wjOXoMfjv8EM60JRRL7gswgx0xJuzr/antzxUME9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU290Q0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE14C4CEEB;
	Fri,  6 Jun 2025 16:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749227080;
	bh=Xf9kmEEuLAigJEs+1EdF+1tvIYHiWd48C3uxpyoKTI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU290Q0G/h5Ed78E2BzJTMwLLTvS4tqe7v5CG0thtqv7Yfx7q4mYtW5sGJkyjYs5/
	 JAPYqfOZ+C+VtX6ixRzidSzk9Mt5VINGk1FJW6Req27BNa8L1YiKaTrqUPDGvcRXWE
	 /lPUt9ck1HBSovEfqVylPgIyjRIZPpH5HD9BBoXwBvTXJLGswfK+XQaIjanjQcjFP+
	 WHzdTzQIlOa/PLFjLsDD93vzppJN1o6+nQsVREJEYSh6PYRe86z1+PVMv4TKSRBiTr
	 mdVhKhTaXvNuUOz2T8hMyszteh4+m0Ka8aJ9skrCjmy1kqttmkMiL93n8nebgqlpoD
	 xCDk29IQqdjZw==
Date: Fri, 6 Jun 2025 17:24:36 +0100
From: Conor Dooley <conor@kernel.org>
To: marius.cristea@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC194X
Message-ID: <20250606-olympics-limeade-fcf2421950d0@spud>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
 <20250606093929.100118-2-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lAMn5b7hs5L2diVG"
Content-Disposition: inline
In-Reply-To: <20250606093929.100118-2-marius.cristea@microchip.com>


--lAMn5b7hs5L2diVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2025 at 12:39:28PM +0300, marius.cristea@microchip.com wrote:

David had a bunch of comments, so much to say, but..

> +  interrupt-names:
> +    description:
> +      alert1 indicates a HIGH or LOW limit was exceeded.
> +      alert2 indicates a THERM limit was exceeded.

You should be able to merge this description into the items list,

> +    items:
> +      - const: alert1

by adding description: into these

> +      - const: alert2

e.g.
 items:
   - const: sdmmc-3v3
     description: pad configuration for 3.3 V
   - const: sdmmc-1v8
     description: pad configuration for 1.8 V
   - const: sdmmc-3v3-drv
     description: pull-up/down configuration for 3.3 V
   - const: sdmmc-1v8-drv
     description: pull-up/down configuration for 1.8 V


--lAMn5b7hs5L2diVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEMWRAAKCRB4tDGHoIJi
0jnNAQCd79bl5UCEVJAis5y+8/ZqK2oNBPKpx0uJBqWl6FPJsQD/SqITyMib8f/4
N6lHcU6V3hbqjSWReVFsE635OzZ5QwA=
=P++d
-----END PGP SIGNATURE-----

--lAMn5b7hs5L2diVG--

