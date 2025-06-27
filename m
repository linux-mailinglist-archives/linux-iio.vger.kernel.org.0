Return-Path: <linux-iio+bounces-21008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1622BAEC082
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 22:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06B81C458DD
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E022E9743;
	Fri, 27 Jun 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl75e3BH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7F212D97;
	Fri, 27 Jun 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054394; cv=none; b=mSK/STpPSdxMOr/FPXM5owd/P2sg+SFiIbZALslxsK2x2TU4kxyrzOTeuXb5O+jqr+PNYpAYodyQPDCEcH/6c/QWc5sl/YYKVgCOAWcnrZk1OcjpuU8+YJLr2125rDD3+LL3OmUvSb00cTZAkVfG+wwQN/mzMxPvucL4qjQfB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054394; c=relaxed/simple;
	bh=4mRsa86Oo0RFDcooBdEjv4m67WRLaTXVEDibhrLW7SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/e1eSWbacYi9qgJWYusqOXIyuhawaXAnLPJ3WZybY7ll28Hb8ZRlp4m+NP6bQ/jH+jPfs3cWk9g14hVyzQPZG38rkivsLVoiZ+U5u1zVmqKU8l2uK4oASsDHvZd6Q31DdrClDFK6Ar662UUAh8Ac/Az5V7DxV4a6auTCUBqzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl75e3BH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A629EC4CEE3;
	Fri, 27 Jun 2025 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054393;
	bh=4mRsa86Oo0RFDcooBdEjv4m67WRLaTXVEDibhrLW7SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jl75e3BHTr61OF4y9Ruh5ZrjXbWeATtjFLcSR4SLt8Y7t+ldMj3iilKEXNTROseP8
	 ugBzgD8m/W+9q1q/+7hHmEiV4mwrPx6vyQfXxuxjMMAJtUdhN63fzVt6KiBr+cixed
	 95ljvUeD31tVeHd9TBFjpPnlda4XFeel3/f8THBjIFion7z6/iQpVqAy+NfCzHWMOE
	 jwf/vNK9/PPg0Peon5qT+yPaCwTRowUFGMWp+/cFRdb2Nel1A+UlM3R8vv3H2nx0tC
	 EraGgWC2idAENTo3Cf6NN3DY2jRcpJsz+Ri6C2Xu8RHkscCP2Ou2ItrUSSsIkAXiBz
	 DucY2roYat2dQ==
Date: Fri, 27 Jun 2025 14:59:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-spi@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 6/9] dt-bindings: trigger-source: add ADI Util
 Sigma-Delta SPI
Message-ID: <175105439247.4081173.1981785333834339523.robh@kernel.org>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-6-0766f6297430@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-6-0766f6297430@baylibre.com>


On Fri, 20 Jun 2025 17:20:12 -0500, David Lechner wrote:
> Add new binding for the ADI Util Sigma-Delta SPI FPGA IP Core.
> 
> This is used to trigger a SPI offload based on a RDY signal from the
> ADC while masking out other signals on the same line.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../trigger-source/adi,util-sigma-delta-spi.yaml   | 49 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 54 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


