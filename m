Return-Path: <linux-iio+bounces-15415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EC1A31F91
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7133F16934B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2C1FF1D2;
	Wed, 12 Feb 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Vd4BWp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC41E9B04;
	Wed, 12 Feb 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343607; cv=none; b=ERVd4+Q2h8WGJPNNQ6zlyKPu2oROBocNILSKdmyqw354f1dw2NoYFtnwM06JBL6YYeF41K6Go9pe8+Hw9nP23ygtIhiy46Z6RleiDCv826kZpQBQYv3/F2PHJm3zNcLm4MnXUNrAvNodQ4owi/QaSHB+jx0Ao+YhK/szvR/tHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343607; c=relaxed/simple;
	bh=omI212O59QFslgZhVoctWrZt+GTeQzBaQFpXb9I54+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqUXH8optofw2+BEWuE3AFicjPXiPdb+x6urlKNZS26/TjiP+5zkiIVZE115XD0HlkKA0Bg39xiuuRXPUPg0Qu/2hXKuBzkQQ+0IrCVNjoBrxFR9WUDPfLHB5Ques5sFT6hyOgXi/wbdR2CNdgBGyP/pgkE3eBbSH8ByLi5pMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1Vd4BWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3824DC4CEDF;
	Wed, 12 Feb 2025 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739343607;
	bh=omI212O59QFslgZhVoctWrZt+GTeQzBaQFpXb9I54+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1Vd4BWpfSll5RkmGK4nVvzOkBxM8p0V7Cym06iUvEOCRTGAb1bNlKBN0dBzfyVd2
	 VwkBLawGgvuPpXe9X4Raku4RVloDCsir4dZSVzbTTc08SAAukuCYeRczzz5GpP+MSd
	 VPvVIxLHGun7ZyUNlrx/SxxZ0Pj/ZyWvjWLGbTa+C9fzQelQlK2ciPVaCD74/rcTuY
	 NiAeh4pU/Z9YUOalB+eaZ92Ba3l5A19LFN+2QLX1IJ6bipgnFugGa88BEukycYOCqR
	 xUIjsCpjfA8eahc+ocQ39u38vReztB972raOtNUjY5eQj5c40RMg+SrFXdTNr3Fmzk
	 PlIko8Uprx0cw==
Date: Wed, 12 Feb 2025 08:00:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20250212-arcane-quick-mackerel-15ba6b@krzk-bin>
References: <20250211175706.276987-1-robert.budai@analog.com>
 <20250211175706.276987-5-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211175706.276987-5-robert.budai@analog.com>

On Tue, Feb 11, 2025 at 07:57:01PM +0200, Robert Budai wrote:
> +  spi-max-frequency:
> +    maximum: 15000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,

Few nits here because you did not implement previous feedback:

s/Must be the device tree identifier of//
It cannot be anything else, right? So:

Active low RESET pin.

Second sentence is implementation detail, what if my krzkOS does not do
it in probe? Is binding incorrect in such case? No, so drop.

> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.

Line should be marked depending on the board layout. If there is
inverter, it won't be GPIO_ACTIVE_LOW. Just say this is active low.

> +    maxItems: 1
> +
> +  clocks:
> +    description: If not provided, then the internal clock is used.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - spi-max-frequency
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

And now we get back to previous feedback which was not implemented.
Please share the filename which follows such style/syntax without blank
lines, so I can fix it and people will not take it as an example.

> +additionalProperties: false

Here as well.

> +examples:

Best regards,
Krzysztof


