Return-Path: <linux-iio+bounces-6512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B890D700
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BBF1F248F4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1474070;
	Tue, 18 Jun 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHP2taep"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2E46450;
	Tue, 18 Jun 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723637; cv=none; b=N/Z0ziRvpgasSfzQGG5iv7ueVuo3GVtnPyUvI4mAVo9AnNjP63LX9f7JbfM5mHPC7LZ76a8Z6+rQNebxL+3kKiHYqXFhwIYW4MdNlgD7adfT/zkFB4ccbJjmjeGY3m9OlI5FxciGNBPLMic9/kIm4rZlgrxLZZbIWUQZkeGtS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723637; c=relaxed/simple;
	bh=kWLzasd2Jv00eh2+ymMa0JXWplIZ46GqFdb45PLJiMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5aCnSILlS5h9aMKCToku/5XbaHIKTtOBarJPq0LR7byjHpGEZA0LfFKyNWl4TY2dwxwH0PhsV+9J84VCU/WKfpczHv85zDpDhnflWgVC9q9cc3DWLBtawK/1fy5U9ST6UMhBuDl5ZcpTRcktCwyx11XxaInXHXNyfFeBgtkHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHP2taep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C53C3277B;
	Tue, 18 Jun 2024 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718723637;
	bh=kWLzasd2Jv00eh2+ymMa0JXWplIZ46GqFdb45PLJiMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHP2taepLHd1qo2ZO3Fqo5kv42Y7HWK3Hvd4M9y2nQyamYsR5YFzzeg2qxzZaGeZB
	 7ZdRPOggnESPB72uGTfHtxrMYHUu9VivKEp62sFDgqw7t40OShbPhAyEmDwSujTM8L
	 jlpJkJIwACiMEUKiXkgrJQS2ImsfaBlG+vo6JUZgmmw/lV7Tg1gZIUY4HFTjPIb/Xu
	 UntfmSZN5WNXqR1Es9Jto/136eADuj73gdLn4T7FL3k9ui8XrhCxUm86sueii4+W/r
	 4Va9iKPlphFGvUY/fnde6a6Ahqk1mQxQRXUSHs0ZoEeLJo/FfhR8SRt6a7bbMF/DSc
	 Cfl1P7hqIRE+g==
Date: Tue, 18 Jun 2024 16:13:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Beniamin Bia <beniamin.bia@analog.com>,
	Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 5/9] dt-bindings: iio: adc: adi,ad7606: add conditions
Message-ID: <20240618-oval-parish-d3fa2925a52a@spud>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
 <20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5RfIUh1XSeALXwP5"
Content-Disposition: inline
In-Reply-To: <20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com>


--5RfIUh1XSeALXwP5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 02:02:37PM +0000, Guillaume Stols wrote:
> Since the driver supports several parts that present differences in
> their layout and behaviour, it is necessary to describe the differences
> from one chip to another.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

Didn't check the datasheets etc, but the idea seems fine.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--5RfIUh1XSeALXwP5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGkMAAKCRB4tDGHoIJi
0uuRAQDKe7NGr+QttzraeOK/Mn2fd3DeTWHkSvdEF08jeWiJrQEAq3JGceQRF1er
TIsn2ohwSS8GsuZvboHa/TJMt53V2As=
=jxd4
-----END PGP SIGNATURE-----

--5RfIUh1XSeALXwP5--

