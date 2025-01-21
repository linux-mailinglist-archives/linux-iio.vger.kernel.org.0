Return-Path: <linux-iio+bounces-14519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4358A1830B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 18:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795881887B3B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761D1F5428;
	Tue, 21 Jan 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ooj2ZU11"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5A1509BF;
	Tue, 21 Jan 2025 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481046; cv=none; b=KicGmvZjv8aahv1uYtHpYnPOL7MgtConOke10EH52dVqgfzEMUbftllkIc/JBZVR8HIx5SQXDy/YEJ5+zNnZgaI2kW6ysnVc2TTTTlUYZLBX5FakJNBBKQ1+uS3bNzEwcVDtGQwgtdjP3O0thmResu2nzBR0sVAAcsKXY7IHiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481046; c=relaxed/simple;
	bh=M0dAojh5b0bEXayBAowkpRAjqHmf9Q6ZScrftwswwTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUW58dp+6pooqnPed9DmlvzX/19CdeCTJn5+Mzmr2wr68qq0b/4F8hEJsrZExWCB0tMWmGO1dxSAAL+DFUaYFi4kdU1uC2AXlQmZqAyaHfKVYRn52bGq5WltiGDQXmpqUx4tWZAWnxULjDOIOQax19VO3ZINjFMncooq481tGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ooj2ZU11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394BDC4CEDF;
	Tue, 21 Jan 2025 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737481046;
	bh=M0dAojh5b0bEXayBAowkpRAjqHmf9Q6ZScrftwswwTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ooj2ZU11ai2s9ftPZHHkfIlBuW1FZcU07KKEMHxYkCS9z6T31BZGY2tYUgahgwSqg
	 lycHOyrSN3bcDcW89GXbpz5F0ZyuKnPjWvnxu3m9HamPPOTD8Mu29vZAAk2B48qOte
	 B/HCUEcVN0R2Iq1SWs03hMd/EucQPsmuPOcgTkmpcK8h/EeWZlPvA+IOdJmmJwtGqo
	 vMs0Pz/k/yj70L2IE0x2iOikrjjn8efwDqTyPivztNLFPNUXQIZ8iqmHG/Jn3DPp0G
	 bebXvXkxbd0jN+s9ozvtACyD3kBw/VtOOiyKuXnjx1YIH9aHliytsbbxkXMmARbXr5
	 PzNI1AMKUMpTw==
Date: Tue, 21 Jan 2025 17:37:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: amplifiers: add ADA4255
Message-ID: <20250121-subfloor-untimely-825e3aa54dbf@spud>
References: <20250120105429.183004-1-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xDB1p92nrrQXPlio"
Content-Disposition: inline
In-Reply-To: <20250120105429.183004-1-demonsingur@gmail.com>


--xDB1p92nrrQXPlio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2025 at 12:54:24PM +0200, Cosmin Tanislav wrote:
> +  avdd-supply: true
> +  dvdd-supply: true
> +  vddcp-supply: true
> +  vocm-supply: true

> +required:
> +  - compatible
> +  - reg

Why are the supplies not marked as required? I would imagine that at
least the first two are needed for operation?

--xDB1p92nrrQXPlio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4/bUAAKCRB4tDGHoIJi
0viTAP4jNbUKhNwSyi2+KDRTyegc9eE9ZVUR+5I0BLg4zIJ27gD/bHv/O0eZbWkD
fyKlQEEjnaQ8W5YG0ZYAuUEFV/H7rwY=
=C7gC
-----END PGP SIGNATURE-----

--xDB1p92nrrQXPlio--

