Return-Path: <linux-iio+bounces-5126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E258C95AE
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2137A1F2153D
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3826751009;
	Sun, 19 May 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUbNx0OE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D050241;
	Sun, 19 May 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141263; cv=none; b=AXVvdH1Ev6fk73++VOo98VCDeffKCLbtySF2B9ZiLwk6VshZD1wvVwdf/ayQut+rlSGMmc0j6edTErss5YGVkqJ74vvrPJ8/nsUAj02AlptC6bTqdMCVNisxv6yUvlNvYR9bbaCkDXXxpv9NRmBPcsDejQSL2yqc0XZBP5RKv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141263; c=relaxed/simple;
	bh=/jo8GeTth/9/hplUAMkUi07J7bpnYBRtXA9PXGRzzSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrcRO15iLH9r1ahZvDUr/gz0Y4QoFuaU2Cqv/Dl1UxqqzuKH+eZHTwmtEKJ7nxScWdrGPQ0sc2ZEG0vHr3ivzUj0kE4csuZ/Sjr1LFPTvp8qONK8ST8J2soYnf4GyFsxbTYcKhJil7JDsBt3/tlX+04l47ZsrIp2dK8T6+3D53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUbNx0OE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A44C32781;
	Sun, 19 May 2024 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716141262;
	bh=/jo8GeTth/9/hplUAMkUi07J7bpnYBRtXA9PXGRzzSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YUbNx0OExesKeBQj6AOzIIfu8e/9FG949/uWqMAje/Jmuw3DEvKRALKR3HBYVzVhS
	 OXGvP3Gu80qme+zp59W2cxnfcL0vjtAoD2r1XCv+5l3bJHd6Jm6+eP2PxGiAgViDfS
	 J/JDNiWrGuF4oEz+6rYKgYk6auNomDc4mJsawOVvFIVKxuKMEZBt2NjjLUthjRSeoZ
	 oxA8b15c+PPJxA6OBCVJ7nGtoW+Kb/clbzgYaUKjP0DYTDTBTvrgTGjghE+4RvtI4E
	 Jb9Win239p115/bF1N83hDWUEHqR6MpbJKZ6f0R/s4uO04bm+OW1GOjnvfcISqqK+E
	 tae18yMfZP9Rw==
Date: Sun, 19 May 2024 18:54:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
Subject: Re: [PATCH v8 2/6] dt-bindings: iio: adc: ad7192: Add aincom supply
Message-ID: <20240519185405.30dce3aa@jic23-huawei>
In-Reply-To: <20240514120222.56488-3-alisa.roman@analog.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
	<20240514120222.56488-3-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 15:02:18 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> in pseudo-differential operation mode. AINCOM voltage represents the
> offset of corresponding channels.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Whilst I'm not sure we've totally bottomed out on how to describe
all combinations of pseudo-differential this seem reasonable for this
particular device and harmless against any proposals we have had so far.

Hence applied.


Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index 16def2985ab4..cf5c568f140a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -41,6 +41,11 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  aincom-supply:
> +    description: |
> +      AINCOM voltage supply. Analog inputs AINx are referenced to this input
> +      when configured for pseudo-differential operation.
> +
>    dvdd-supply:
>      description: DVdd voltage supply
>  
> @@ -117,6 +122,7 @@ examples:
>              clock-names = "mclk";
>              interrupts = <25 0x2>;
>              interrupt-parent = <&gpio>;
> +            aincom-supply = <&aincom>;
>              dvdd-supply = <&dvdd>;
>              avdd-supply = <&avdd>;
>              vref-supply = <&vref>;


