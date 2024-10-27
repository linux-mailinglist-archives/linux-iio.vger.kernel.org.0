Return-Path: <linux-iio+bounces-11412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39C9B2092
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 21:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3936B1F2332D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 20:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915718452C;
	Sun, 27 Oct 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uk2Sd+A6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3418130D;
	Sun, 27 Oct 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062183; cv=none; b=EveVcbd4WqwClptnBefDXDCuA5i8G742GbXRn2SHY74WBjwvbXjuGguJnyzpvXeoROMIfiLXS+6Z8mLFH6hU8QBfU/D+bWgaqQ6e/ZFuVe8qLgcP9t3FB49ce+Z+R34eRYN+wMpELmGy2lN3aG52T1aQ7eI4sphJLgB4rSQXy1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062183; c=relaxed/simple;
	bh=gWHS4yYCmSkWQhhth3FD4IBgIX0f9ljMZpO0puYfgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGKfIVfsFcCYFT16yxZkJ5ab/SAQGZ3WXBGJrHBqgpbj2mA61+jPXLx5uNqBvk92G0sOK3fJVvtt4iQd4Uxn45f7KYD3mT3qkyURceds6lA/mzFMn0+417NCR33kUjE+SyBxA46HR8R0Jasydw2hpdKYQHsxie+0ZMVvhiw+RRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk2Sd+A6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E3AC4CEC3;
	Sun, 27 Oct 2024 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062182;
	bh=gWHS4yYCmSkWQhhth3FD4IBgIX0f9ljMZpO0puYfgWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uk2Sd+A6aWiy5/T2J8ZkIWhAW2oGNco/YjQjDWU7ZR544AYjh/nEQrw0UKrFsESjl
	 zpJB0aw9eS/cylJNAK9sap5VGQFSCU3tbuNftQ3UbX9RViPc9ZbIoQiChYms/5HTsB
	 KSTaHC0TlIkqjOVcaV910IEWb7pngZeBPzwBtxlCjSFGaTokFw87nqCfOH3ZvKRiAe
	 pDL2ONA+Gbo2yQ/f9ZP78PI7lrcWwIhRFw0dbY8sCUbwvKsrmsHM0TcxcRU3VnuVm2
	 U9geGfRV0AcmSLWUSDNtxDaSKzWjLnhapziv8wjZ7yLwAEM2+F53r5hZxCuXChcCzo
	 n9idVAn120xXQ==
Date: Sun, 27 Oct 2024 21:49:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
Message-ID: <7fzvrs2ifpypin75w3bxnbi7w6v6ekidqruxb6glpkgc3kf4m3@mqjocck74n6g>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
 <20241024171703.201436-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241024171703.201436-6-u.kleine-koenig@baylibre.com>

On Thu, Oct 24, 2024 at 07:17:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> For the AD7124 chip the logical irq line (=CC=85R=CC=85D=CC=85Y) is physi=
cally on the same
> pin as the spi MISO output (DOUT) and so reading a register might
> trigger an interrupt. For correct operation it's critical that the
> actual state of the pin can be read to judge if an interrupt event is a
> real one or just a spurious one triggered by toggling the line in its
> MISO mode.
>=20
> Allow specification of an "interrupt-gpios" property instead of a plain
> interrupt. The semantic is that the GPIO's interrupt is to be used as
> event source and reading the GPIO can be used to differentiate between a
> real event and one triggered by MISO.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 35ed04350e28..feb3a41a148e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -37,6 +37,9 @@ properties:
>      description: IRQ line for the ADC
>      maxItems: 1
> =20
> +  interrupt-gpios:
> +    description: GPIO reading the interrupt line

Missing constraints, maxItems

Best regards,
Krzysztof


