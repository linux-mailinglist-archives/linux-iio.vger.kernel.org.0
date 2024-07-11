Return-Path: <linux-iio+bounces-7525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475F92F249
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 00:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188931F21635
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9EE1A01AD;
	Thu, 11 Jul 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0MEtd9z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203414C596;
	Thu, 11 Jul 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738354; cv=none; b=iN+Oj5JpasIpUPIQJm2RPAX0SAVVKjaemk0n9ECe4TkITBL1PA77pkFTLrZjsJ200FT/3TgtRxhi3HWXgAsPzqoFSPoV/Ewf69pTSQNrEdq5aeJ5FH+QKf0wCdGoh+XfKVMBgjEqu1r+Rki7y68hWLaFPrf11k+/V/vdDIi5JDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738354; c=relaxed/simple;
	bh=ugeb1t/kYPmUZZZGlXStlfCKlqmxzM0Ncj8Ch2jZflQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lm6Cin0Vow/kBOj6En9J0FBwbKyuV1ZtJZWr32VHCR+HaGfHAkwd9qVRuq1X76BLtCA8RnPyG4rxOU9dFM0WEOY8keEJbJLPWyp4FRwPodc7Z6Zy27pyIpwZKet7lbjPkHnTheLPDsfFotgAU5wiKX270BxfPlwZRSs4fm335Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0MEtd9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF21FC116B1;
	Thu, 11 Jul 2024 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720738354;
	bh=ugeb1t/kYPmUZZZGlXStlfCKlqmxzM0Ncj8Ch2jZflQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D0MEtd9z4NCicAi3yAnq/KiYEoYQgQCyR5jSPbFt61t8uGixHGTJuGxcoMGNMphre
	 GUlxjQsqgQaSsPGytVCG55F7C7B0Rn6pyF7IBumY/i2xDN/UPxqAdLGjgIB0Llemo7
	 eDe1fT/o72SRDqXk2CMw3C6hjlmAcSYvb00otaDgRQqzt6NvOGeixb2qkU1i1fwyjw
	 m6knkLd2mpRTnXqaHVQJHVA6RauYC11eI5bYfEW8mfQJfcK4tG+hN9geyqP0bPEUu1
	 dDoc25ntmXtPzXOEqDsGYY6d0ujUAo8y6dB3rws19jq1Xu0BiPvmgFN4PQEWqV+Q1u
	 xwQ74uLmGV2IA==
Date: Thu, 11 Jul 2024 16:52:32 -0600
From: Rob Herring <robh@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
Message-ID: <20240711225232.GA3248170-robh@kernel.org>
References: <20240711114221.62386-1-kimseer.paller@analog.com>
 <20240711114221.62386-4-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711114221.62386-4-kimseer.paller@analog.com>

On Thu, Jul 11, 2024 at 07:42:18PM +0800, Kim Seer Paller wrote:
> Introduce a generalized DAC binding that can be used by DACs that have
> similar properties adding output-range-microamp and output-range-microvolt.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> new file mode 100644
> index 000000000000..a9787bbcd22b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IIO Common Properties for DAC Channels
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description:
> +  A few properties are defined in a common way for DAC channels.
> +
> +properties:
> +  $nodename:
> +    pattern: "^channel(@[0-9a-f]+)?$"
> +    description:
> +      A channel index should match reg.

Drop $nodename. That causes this to apply to every matching node and 
hence the failures.

It is also redundant because you define the node name where you 
reference dac.yaml.

Rob

