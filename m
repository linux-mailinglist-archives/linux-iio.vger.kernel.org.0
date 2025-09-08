Return-Path: <linux-iio+bounces-23874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3965AB48513
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 09:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1D0189CE71
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600A02E7BDE;
	Mon,  8 Sep 2025 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxLHterW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182132E7BD2;
	Mon,  8 Sep 2025 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316325; cv=none; b=MycEZeyqFqLo1+vfuvUJL6ivDRDTWJOA2bgd/7l0QT+lVfrLnYexovsdX3Gppx7OI7okbujlAHRPN5Ytpj0vSZNiySZ8+4NuxtwI66rHp3OASqis6/hTI/LtT42xELz/p5Ys3bTH1To5q0V5g9YWoTGOG3uLEEW7MxATgnM+pDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316325; c=relaxed/simple;
	bh=tfUD4cZap8iblsBtwT6LKWNgLg4ecyHluh4fnWBjsJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6Y5k0pNJeyt/vpw+sy2Tw2KEkT+xAHg3GkZL1sOIeRB/+3TcPgCBig7/hTXmYNosmvlfFOu4RRG2+ru7ZHu2GuBjdqBaEh+yQkddWNtTA8PONkVplDhXfiXbzKzpwKN6FQ2+yRhFp+QaXnuDE9+JWdFEcDCjqSGfgVdPoB54ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxLHterW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E93C4CEF1;
	Mon,  8 Sep 2025 07:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757316324;
	bh=tfUD4cZap8iblsBtwT6LKWNgLg4ecyHluh4fnWBjsJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KxLHterWcrUQ8sZfCtvkK8C8RtfeMh5cfNbrByFBIx3w+xM36+V6fmEhyMznYHZXI
	 G9Pjh2WE044gJey7w4nufU22hOMwtpZRUfouDF0NVY6LSE5z+5fgtDeHQez+yqY+kw
	 6fJ3BTTATn81bLLLHjkGucw069Xaa+cYnkQy/XzWE3ZhIaQVhDtrtDaudlW5yTFSnU
	 aMKXzLPGT6dvpVyKsmhv/GRNbM8FnxYDCXOZr3qVJS5RDrcRQVPl3rsjiGfZXyCYAK
	 x8OxvjFTAwVFDdU3mI2ppdWkm2hqehW/glem0cvyn61NcLKfb2TXDBQU2vTFO2TvpW
	 fsAoWfoa9chIg==
Date: Mon, 8 Sep 2025 09:25:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: magnetometer: Infineon TLV493D
 3D Magnetic sensor
Message-ID: <20250908-belligerent-garrulous-bandicoot-a4add8@kuoka>
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
 <20250906-tlv493d-sensor-v6_16-rc5-v6-1-b1a62d968353@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906-tlv493d-sensor-v6_16-rc5-v6-1-b1a62d968353@gmail.com>

On Sat, Sep 06, 2025 at 02:07:56PM +0530, Dixit Parmar wrote:
> Document the bindings for Infineon TLV493D Low-Power 3D Magnetic Sensor
> controlled by I2C interface. Main applications includes joysticks, control
> elements (white goods, multifunction knops), or electric meters (anti-
> tampering).
> Drop duplicate entry for infineon,tlv493d from trivial-devices.yaml as
> its documented in this separate dt-binding file now.
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


