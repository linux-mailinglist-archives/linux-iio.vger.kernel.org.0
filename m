Return-Path: <linux-iio+bounces-5006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29148C431A
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D22825F7
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6063B153BC0;
	Mon, 13 May 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQbhfASj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18397152180;
	Mon, 13 May 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609948; cv=none; b=o8Uwt9VCVlEzIDlnkzqBvdSVJ1K6g5Rf/uSQ0flhGNgYAZ9M1IZ4P2ViY3sb3crJVeMhZgxWhmorh6lYA+DNfsrPnjpFQKHqqeW+g7D9YBYj2cePqZtE6zcgGDf5BgIn+EQECIUJb7H7/Kj2G0ioCowLubLDJD8u5d9e4kgDw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609948; c=relaxed/simple;
	bh=PD4GwX3Z6iq20lzOHlzaVgnrNqVXh7Lp5OI62HCHswU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5qUK5V6Jm5CKbr2qAk0VEVFPkp69KXy2ivDHFEAhrSfWhNMt9v6lQzMeJWtFXMQTib3F5vYbglqBAMqITY8ze7Zr78OI7cgGE5mi3E8JUDoqXfzMGbv0dtDfErnaWZBoLh7OA4rVj1R7LBWAzqOUNwDWho/TgeKNY+sFNx5fWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQbhfASj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B27C4AF07;
	Mon, 13 May 2024 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715609947;
	bh=PD4GwX3Z6iq20lzOHlzaVgnrNqVXh7Lp5OI62HCHswU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQbhfASjvXHGTKOPtu1AmhG20WH02RT274WXbettv8w84cXwTK3rQJkJhKstTVkYq
	 Kp5vyE2u6UhcE1o64Qo4nJLlwTOkBEmOqIWPR/ofPWCTXwqqfYPUevvIj/qid8TnAm
	 GU1K7dX7dxfz6jauJpjAF/kvpab1CPjI04WIiUwuPYqb0mx2oxtYqratxHtpMuZLoA
	 ZwfUoqFOFhiT3M9cSj5O84lNHuJZO3o/DoBAxf+1tt3BddnTtZ2btt6nEHYVNd7TNU
	 IQPcesAJgDq5lPU2uzBhUc7uiXC7Bemjqlt8VEeFuo1hxLNnGPNUG9O4j4gxWRqmof
	 7FhuGta9uPONg==
Date: Mon, 13 May 2024 09:19:06 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,axi-adc: tweak example node
 name
Message-ID: <20240513141906.GA2534611-robh@kernel.org>
References: <20240510-b4-iio-axi-adc-dt-binding-tweak-v1-1-a1f633c4602c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-b4-iio-axi-adc-dt-binding-tweak-v1-1-a1f633c4602c@baylibre.com>

On Fri, May 10, 2024 at 04:04:38PM -0500, David Lechner wrote:
> It is always recommended to use generic node names for devicetree nodes.
> The documentation [1] of the AXI ADC IP core says "The most important
> part of the core is the Receiver PHY module.", so using phy as the node
> name seems appropriate.
> 
> [1]: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index e1f450b80db2..9cad4c439045 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -57,7 +57,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    axi-adc@44a00000 {
> +    phy@44a00000 {

phy should be used when there's #phy-cells which is not the case here. 
'adc' is somewhat standard. Or maybe it should be tied to 
#io-backend-cells.

Until we have something defined as ti what it should be, we should just 
leave node names alone.

Rob

