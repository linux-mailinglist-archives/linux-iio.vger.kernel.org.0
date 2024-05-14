Return-Path: <linux-iio+bounces-5049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED0E8C5B68
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 20:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC67F1F2215B
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45499180A8E;
	Tue, 14 May 2024 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyWuKSyg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA31E504;
	Tue, 14 May 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713047; cv=none; b=eLn7R6Ro19/9f+Hb0OuPgzyrHk1RdGUl3T9thz5dHSVcgb91GQJadG8Efk/F6+fY4uQUYi2ek5ELp1QImkNP/eLrhcIjyODNZlkJskdkiQE2jxWwdgayszEnG4jWf+XTLDtGD3cccaugT+Xcx67mLfgwQBZaNDg02XQ4FZhzej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713047; c=relaxed/simple;
	bh=NGECqLQ6/jvDeZTmP0NvXfyLq4I2e6cVGpTeteoUZvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwtsQPIXiadQXdsBDfTaYQ21FJjfJU5PLm3+MC1hxyZh2MUFuzsfDVWsvfHSjnjnYaFOkj3HyOGJYYpUhdcPvIUTA2e3/TcuSZBlry7RNX1c5MeBdpiL/4d94tQc9hZpcx3ieArZUHCni5t/klUW+VMO5HgT2XAY3KFiFsVMXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyWuKSyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D15C2BD10;
	Tue, 14 May 2024 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715713046;
	bh=NGECqLQ6/jvDeZTmP0NvXfyLq4I2e6cVGpTeteoUZvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyWuKSygJ7Zjp2AZ8QQOsNRNOezzC1aNsdPsRBduZSd9nmjDaTOoS0cWcp4xZwL+8
	 twCEmpS68TeCc0t0J+pXInyG+AvK/Al+iDvDEyDCGouZYb4rRHn3vJCaeqivbyuEAK
	 cYmJC3rj/bEteujr6n9e4+gGVB2ibTH0MOk6Xp2NZbPcMgMYPRRR4BJAuSxoHYIZcS
	 88xJVrZmeccH+OpxdkZyG2ghI+ehLh/hlRAk64ua3Tkgt1mMETqVcMW2lAB8tdfNsO
	 ceAbj4/zWUWMaZKHzzt0KOEFJ/Eofcjw4Nk7kkZFTYPkaYO5ng9tJiNBCfCavSP4/+
	 JNQWmzQdZgyjg==
Date: Tue, 14 May 2024 19:57:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, jic23@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
	nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v8 4/6] dt-bindings: iio: adc: Add single-channel property
Message-ID: <20240514-ethics-uproot-1d239f4dc63c@spud>
References: <20240514120222.56488-1-alisa.roman@analog.com>
 <20240514120222.56488-5-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7D6/euG1CVrhYXYt"
Content-Disposition: inline
In-Reply-To: <20240514120222.56488-5-alisa.roman@analog.com>


--7D6/euG1CVrhYXYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 03:02:20PM +0300, Alisa-Dariana Roman wrote:
> Devices that have both single-ended channels and differential channels
> cause a bit of confusion when the channels are configured in the
> devicetree.
>=20
> Clarify difference between these two types of channels for such devices
> by adding single-channel property alongside diff-channels. They should
> be mutually exclusive.
>=20
> Devices that have only single-ended channels can still use reg property
> to reference a channel like before.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--7D6/euG1CVrhYXYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkO0DwAKCRB4tDGHoIJi
0kFSAP9BbRjbo1NI4a+hoQeO6UfjuZbw13BuES4H/4mWpQOO5wD9FivkSkUj23ST
L/eU9eYRsBzHC/CT379ugCCySZk2sgI=
=IxBX
-----END PGP SIGNATURE-----

--7D6/euG1CVrhYXYt--

