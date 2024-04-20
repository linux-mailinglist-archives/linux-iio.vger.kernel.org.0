Return-Path: <linux-iio+bounces-4401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC88ABC20
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 17:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28F3281B25
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE427737;
	Sat, 20 Apr 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nliXy8Bd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90520DCC;
	Sat, 20 Apr 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713625456; cv=none; b=Duj0UErphLftKMnd/oYeJRTeIJXEVRinS79SXHBWJ9Tmpu6jiSAeI+mymyTdG2n+ujQZl7T9JTFAx5eYxo7Fs6/iZ5ZRRUag8czRXnx0tMRIcQgIhlsJZUTQkb+7WfHo7hvlAQ+MzADNA7Rcp5sIC62ZfaPAgwa7fKUnjJPDB44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713625456; c=relaxed/simple;
	bh=sOXikMt7fviqLp9McB77G/nTgFckTp+Le1oSAGvNfe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dts7HMUGySQUzPDqD+HEKAi7alt8PPlT4+rJ9fRNu8ar3NTyegUjBN76Klw2egQAKNLZQmIt4Xw1YvgFgbjxzdrSp82MkhqM3eIA9hMUmiH0JxULR+qYKfLDusAEjtVebH+mTG6LtRjCIncbeQVvs19GMyGLeI8HlZztqtmXM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nliXy8Bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35A8C072AA;
	Sat, 20 Apr 2024 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713625456;
	bh=sOXikMt7fviqLp9McB77G/nTgFckTp+Le1oSAGvNfe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nliXy8BdaBv/2/BoF3UI50z8VhWnGYZwQPkAS3CXFlVSo++4O98XPDTD3lYVJ9W3z
	 Ud4Ik0BStMed6EjCvEQ6r7YVB0WZbNIoWUzY8K01pokFyL6Ks+10dzScbtuJuM7so8
	 6sC2q6hP2a0VDyGOcZtpVq4zgfaVQ5flkHlcoGr3E0fv6D2kjUCVbv9ecLJLq3nmI4
	 nvyy7l30YPxnjIkOG0LQkcGvXyI9/SwFKTv0oVkyIgplJT0rqb00EyL3kYFeyVCd4S
	 WI9GsjkWj+KGlFvzyzNfT+zzgOPBYoQ+0lElUCoQRzWJirE1CC8JFnPycqZi0ApqHY
	 3YTSNHboWgECA==
Date: Sat, 20 Apr 2024 16:04:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 3/8] dt-bindings: adc: axi-adc: add clocks property
Message-ID: <20240420160404.57bd835d@jic23-huawei>
In-Reply-To: <20240419-ad9467-new-features-v1-3-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
	<20240419-ad9467-new-features-v1-3-3e7628ff6d5e@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 17:36:46 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Add a required clock property as we can't access the device registers if
> the AXI bus clock is not properly enabled.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Fix, or doesn't matter until this series?

Obviously should have been in the binding anyway, but whether
it matters already affects whether this should go to stable or not.

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index 3d49d21ad33df..e1f450b80db27 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -28,6 +28,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +
>    dmas:
>      maxItems: 1
>  
> @@ -48,6 +51,7 @@ required:
>    - compatible
>    - dmas
>    - reg
> +  - clocks
>  
>  additionalProperties: false
>  
> @@ -58,6 +62,7 @@ examples:
>          reg = <0x44a00000 0x10000>;
>          dmas = <&rx_dma 0>;
>          dma-names = "rx";
> +        clocks = <&axi_clk>;
>          #io-backend-cells = <0>;
>      };
>  ...
> 


