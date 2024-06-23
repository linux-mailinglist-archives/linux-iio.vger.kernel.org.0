Return-Path: <linux-iio+bounces-6764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E72913C6F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EE5B20E40
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE401822C1;
	Sun, 23 Jun 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCh1b5hc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02467604F;
	Sun, 23 Jun 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156822; cv=none; b=DEWOs3W4xEWP4M9r3OPjzQiV4KRo4Ii74m0Uz6H5PL1hDcmKc3gnyylv0R3Qj8exTshAQFOnmdxHMTmPeq8YMqMIKCBKWvZ6uAFPloS9xy2q9/xPIWY9IXlIZtuN/4jCJxdaU0ZrlUz1emjpxGJwMK85NEYTb2X62oFN3D2HLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156822; c=relaxed/simple;
	bh=bfFto2ncoUowlKKjzjx5Nx6tMeHjLXCfsgMk8Wd0Gyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIzaD2Y4ldw2XdTeai7EiWO2c59BY1weUWG9YtcfsSDPCehcq0yHETXOQJTGy6lfwSecdQX9MpvYRu4OMohW4xs1jOycLSirHc3dKwUSAu/ujiGQ+n2mmk3ymcrEDlgPf9S7ZDoum5hpnn8iGL81H8PbHaAFIVdP/B1TN6fDquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCh1b5hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004C7C2BD10;
	Sun, 23 Jun 2024 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719156821;
	bh=bfFto2ncoUowlKKjzjx5Nx6tMeHjLXCfsgMk8Wd0Gyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCh1b5hcIVUdqsm+XIR8GO1UihMDMZJlffjN0EiF5tKiEQHT4LUkgT3vCU7iQWVBS
	 fsk+kKsDD0cskJiGUe9lnxnEtcw0Z/QWUIE/nBQ1PeM/6JAtJVMeFmw6YrX/wEIWLX
	 lCeP0Z3IspBFhAA5nDFT+sy3OH6bzDKpQbEPTvQJHQdtlu3aiAMKmwy+cRPBTTHsAX
	 2PHqnHgwqBNE6JDo0dJtLiSsYj30ZHbT5L4xi76Lb7YL5emJ6x/p5ByUW5z2ikYZo+
	 nU97l8Gz4il27IGnxxenKoC0qdgNaOQ5v2w2XqiUjvGdMBUO1CEnqBgvCShXyKMy4F
	 wxvTNvOHvl8vQ==
Date: Sun, 23 Jun 2024 16:33:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 5/9] dt-bindings: iio: adc: adi,ad7606: add conditions
Message-ID: <20240623163330.7a9fd911@jic23-huawei>
In-Reply-To: <20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
	<20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:02:37 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Since the driver supports several parts that present differences in
> their layout and behaviour, it is necessary to describe the differences
> from one chip to another.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
I'd rather see the numbers / descriptions changed in this patch so
that it is clear why instead of the earlier documentation only patch.

If that is really hard to do, just make sure that patch description calls
out that it will briefly be inconsistent.

Otherwise LGTM
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 50 +++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index e480c9a7c7ca..65d6ca5843d7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -55,7 +55,8 @@ properties:
>        Must be the device tree identifier of the CONVST pin(s). This logic input
>        is used to initiate conversions on the analog input channels. As the line
>        is active high, it should be marked GPIO_ACTIVE_HIGH.
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    reset-gpios:
>      description:
> @@ -91,7 +92,8 @@ properties:
>        GPIO_ACTIVE_HIGH. On the AD7616, there are 2 pins, and if the 2 pins are
>        tied to a logic high, software mode is enabled, otherwise one of the 3
>        possible range values is selected.
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    adi,oversampling-ratio-gpios:
>      description:
> @@ -123,6 +125,50 @@ required:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad7616
> +    then:
> +      properties:
> +        adi,first-data-gpios: false
> +        standby-gpios: false
> +        adi,range-gpios:
> +          maxItems: 2
> +    else:
> +      properties:
> +        adi,range-gpios:
> +          maxItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7605-4
> +              - adi,ad7616
> +    then:
> +      properties:
> +        adi,oversampling-ratio-gpios: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7605-4
> +              - adi,ad7606-4
> +              - adi,ad7606-6
> +              - adi,ad7606-8
> +    then:
> +      properties:
> +        adi,sw-mode: false
> +    else:
> +      properties:
> +        adi,conversion-start-gpios:
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>  
>  examples:
> 


