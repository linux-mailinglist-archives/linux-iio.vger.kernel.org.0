Return-Path: <linux-iio+bounces-23953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF5AB51F66
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 19:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A81BC1225
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A82737F2;
	Wed, 10 Sep 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPdkph+x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCE29A2;
	Wed, 10 Sep 2025 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526499; cv=none; b=jBCVTSB/JB260ddeMJAcUIYefSvdV+ComkcFRv84ffAuZsNQx1Jdm0gk+KsmGxIdqHLy772dokSBOG0TOSKOCweia1rM5xALZC6lVH5wGsZeag+fFoP916JwQCmVP998bOVg5KKlP7/vDQuXNGoBw9jQ18yrizzLCvOoE6oRO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526499; c=relaxed/simple;
	bh=yodsL3noDTGmBFHR90KbCJnz5Ar5YAZILQ6cTmd6h3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOKHqEPxzAYWZ276j8IJ/Esm+ImvTIe0jNwkPqs2yqItWERPOwriK3BshLl99NGdXIlu3zM0ll1YYHVRqSGvYnCh20g0Qbtb3KFRmXJv3xBElJJytChsDh541P1ACjpV3VEL8wCwDrLMyeJprvBIicc6XgLQKp2WVqVWQx50W/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPdkph+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFDCC4CEEB;
	Wed, 10 Sep 2025 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757526498;
	bh=yodsL3noDTGmBFHR90KbCJnz5Ar5YAZILQ6cTmd6h3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BPdkph+xLLXcjILvTHWvXViSXhsIgY9s/t5Sc3QDpPnJwZMxRxrwN7chVKtWEpp3P
	 A/wF86j3EnQvKHE4kto1CGuMITg8RZA+EWRsqnbAazbZT3weung1sJc7QIwInrtZnS
	 TUjuV74n8/UUpVcstCK8/80WYbyMQlWLW7a8EaqrxgutqYSYFjYAqZMlSotQ7yakpy
	 onnhD1fWkZbKwFEvGfNComH6/AlK8hNifL4tvV4inS4SdIe595oDK9MX7vCsxaI2aW
	 hz2E0NrAiiMbZJVeeASs3hTP9CDgLEghCYtLEHaA0iYGdVsMMbJSjPPUp+r8kuuw/H
	 DASH1MBJ4g2TQ==
Date: Wed, 10 Sep 2025 18:48:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: iio: accel: bosch,bma220 setup
 SPI clock mode
Message-ID: <20250910184809.34a7328e@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-2-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-2-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:07 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Assert CPOL for a high-idle clock signal and CPHA for sampling on the
> trailing (rising) edge.
> 
> Quoting from the datasheet:
> 
>  "During the transitions on CSB, SCK must be high. SDI and SDO are driven
>  at the falling edge of SCK and should be captured at the rising edge of
>  SCK."
> 
> The sensor does not function with the default SPI clock mode.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Perhaps this one deserves a fixes tag? I'm not 100% sure for
dt-bindings that are broken like this.

> ---
> ChangeLog:
> - split out from a bigger patch file
> ---
>  Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> index da047258aca3d84e8b2cbe92a9c98309236fe7ae..0e27ec74065acca611e63309d6ae889b8a3134ce 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> @@ -20,6 +20,9 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  spi-cpha: true
> +  spi-cpol: true
> +
>    vdda-supply: true
>    vddd-supply: true
>    vddio-supply: true
> @@ -44,6 +47,8 @@ examples:
>              compatible = "bosch,bma220";
>              reg = <0>;
>              spi-max-frequency = <2500000>;
> +            spi-cpol;
> +            spi-cpha;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
>          };
> 


