Return-Path: <linux-iio+bounces-8881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF7964AB1
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7654281915
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35F1B29D7;
	Thu, 29 Aug 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9hPUymU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112943ADE;
	Thu, 29 Aug 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946865; cv=none; b=p70AiZ06B2svwRPlZlEi/Hq0ljI4R+zdQEUJ8YtTFiIhemKlLmo2bkvCK0v8+QnJ40kWAXAIEbi0RaiR7ayKkIDXfzVrD4ShBB5hOBeundoVjHFAE+wm6TrzMtKDv8Rs0X4QPyZLRfb5Wqrt8AyMQyJnBCiFOWwTVhtXptlQVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946865; c=relaxed/simple;
	bh=2q+OiF406XPSjiUS7iYMlpB+7HKrq4ShozAQkTfjXRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/dLjDIqpx5Vof0Qn7U2KIcAkEx9OFwr1OM1tc7EXo/8L8z/XNGYSbd302SsqoFO8Sb17a4D5UArBF5Oc5uQYhPHW/q3smXs3uQal6N/94NywCg9AMZ/tH1/EvoyFUApPuy0NNzbyeA8Uwcmr0cCfYdeRXomknNCLaGG3Ny8yKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9hPUymU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8F1C4CEC1;
	Thu, 29 Aug 2024 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724946864;
	bh=2q+OiF406XPSjiUS7iYMlpB+7HKrq4ShozAQkTfjXRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9hPUymUxrstMDsTKs13AgZR65chtL7fPFcSn+MTLCIUPKk1JCwPQkFNpYO9VrxfG
	 7ImlPiq3O0GAXn2hPJ8ElZoZUWrGPhUqeRnmhX2IuAaGnWoVzM/5j+i22Ml5SfBf/m
	 Hp63XIGSLbt08fE9NtXOPYY3Vb8KSQAIjWBSr4zi5XYMoyBte/sCOqM1Pq2UxDzeu/
	 sQtDFT5jORQ++a8mPrRJLZ17exCsxxAnjsrIG9vkXwHAuzKI19rvH7KeRAzR60Z8Dr
	 Sv4xfODowvi9ruzUOjjwdsS6vBcEjkqPyX1G1U42RRNXeROeiJZdhZp8f3F6ZltPp/
	 M3SC66xg/xiRw==
Date: Thu, 29 Aug 2024 16:54:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: adc: sophgo,cv1800b-saradc: Add
 Sophgo CV1800B SARADC
Message-ID: <20240829-impolite-excretory-298dcd984e76@spud>
References: <20240829-sg2002-adc-v5-0-aacb381e869b@bootlin.com>
 <20240829-sg2002-adc-v5-1-aacb381e869b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JOvC/K7N02Ne9hmR"
Content-Disposition: inline
In-Reply-To: <20240829-sg2002-adc-v5-1-aacb381e869b@bootlin.com>


--JOvC/K7N02Ne9hmR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 02:31:50PM +0200, Thomas Bonnefille wrote:
> The Sophgo CV1800B SARADC is a Successive Approximation ADC that can be
> found in the Sophgo CV1800B SoC.
>=20
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--JOvC/K7N02Ne9hmR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtCZqgAKCRB4tDGHoIJi
0tmFAQDuCBgWolSZSmmwKxidXOgVFEyAkp03nE56bxdV/mnZ1wEApMNmjk0lPQTq
OX3+1Bnc1D5utxnITTTEbgufgpj3LQM=
=hASc
-----END PGP SIGNATURE-----

--JOvC/K7N02Ne9hmR--

