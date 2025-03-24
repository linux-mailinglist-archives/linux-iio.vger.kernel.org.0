Return-Path: <linux-iio+bounces-17259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E906DA6E47E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 21:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD501896A41
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1259C1D63E4;
	Mon, 24 Mar 2025 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFuZW06F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE3B1C8623;
	Mon, 24 Mar 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848275; cv=none; b=mXbG0om92lrnyHqic56jvy5oFZnrXej5DzYc+z7mvDPS/MLTxgMLn7AQqbCsaTkfrBpj7YerY7tWAynJK+9G/mMZs2LF9aKd71wHV9WY7r8uNhlKwUfaoSnJrK+QmE1ylv+HUBaSAneDG/8kfOeXB/pirA3cKUSV3zLRoGzEYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848275; c=relaxed/simple;
	bh=XZ2Yktl6mmKJfiTNy+Z4/IvVxFgIZo5WawcMrRO2Vbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R404G8+9RMjnRIEfAyMdsu+7JZfBshzi2cKj+OgLFmGgCFQE+iFz0h7x23LUepwSVlJcb4kutUck2VTF0LB3qDfC2slj5XJ44bd0NR+EdBNHTTLlxDslHQe6GXdhLaynx6coCCeIii6Ci+VHPPADYwbYk1QdwK10nTB3NMtcQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFuZW06F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC1FC4CEDD;
	Mon, 24 Mar 2025 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742848275;
	bh=XZ2Yktl6mmKJfiTNy+Z4/IvVxFgIZo5WawcMrRO2Vbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFuZW06FF/l/+XccYW9mOLm0/T/y+rQ5Qey1sx5gf4IDaXAPgVGHQnHICkOj2UmZU
	 PDykSuBwUEVADe6TdOjuKw5QO577NinlTsZimjhVNndV+uT/QF2NWLD0KNSrhsi0MI
	 KO6BpOsq9Hl8egajcNvUPEudOv9SNJhFWRHqJQFRyzT1WHtvDIrlMg9stNwULybj+M
	 BrUElG7Trs8lG1eluh+AtsXNGzvNnGeOi0P7Dlji1cjRBLjpqvGDXDk+yLmDF92QVM
	 HY89MNPoMV56QNAw8di8kHyUcASHkvgva7nx0zVefH0OjCTcc2EeKbkkR51Kcbzo7D
	 YfL6AJQifexgw==
Date: Mon, 24 Mar 2025 15:31:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	devicetree@vger.kernel.org,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Anshul Dalal <anshulusr@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Robert Budai <robert.budai@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: Use unevaluatedProperties for SPI
 devices
Message-ID: <174284827311.819192.14616231717400662961.robh@kernel.org>
References: <20250324125313.82226-1-krzysztof.kozlowski@linaro.org>
 <20250324125313.82226-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125313.82226-2-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:53:13 +0100, Krzysztof Kozlowski wrote:
> SPI devices should use unevaluatedProperties:false instead of
> additionalProperties:false, to allow any SPI device properties listed in
> spi-peripheral-props.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml      | 2 +-
>  Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml      | 2 +-
>  Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml      | 2 +-
>  .../devicetree/bindings/iio/dac/microchip,mcp4821.yaml          | 2 +-
>  Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml    | 2 +-
>  .../devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml    | 2 +-
>  .../devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


