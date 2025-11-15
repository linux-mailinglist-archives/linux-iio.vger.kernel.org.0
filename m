Return-Path: <linux-iio+bounces-26238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDCDC6092E
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7552B354A06
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA23019A6;
	Sat, 15 Nov 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKKQ3bD5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F561FFE;
	Sat, 15 Nov 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227552; cv=none; b=bnWbtmz7EFSM2PakItNreIiHQS/EPFu9ZmgGA84OzuAkh6uGPyuqdXKvGNoKhpGJJodxO5+yHeHediT6i41IEUTJUCyqb81+Jr8a/HJOI73Pwfad46Q/u9lgIjf9rKeXbl3PcPZMHeWf+LoNrwaii4TPRP/40/+70G2o9CfQnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227552; c=relaxed/simple;
	bh=LEb65hH+pPpondCKsU7vxXQGwoO+ddVN/H+2Wqn5LhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+/wU34Szx2gzmNHF2dPfgPlezetGH8QR1rcV2DUKktYCrJqY4Bi8i/TsdYF2R05IDItQ1mgemqojg50jOKzhAFpuUBAM8pS9mPtmzhucR7WUjv9afcd0EcmPdQwk3AOOnk0AGFAJTJd93Tj+ZTxpp1rcvKV9JegGpvDxDTVX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKKQ3bD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48337C116B1;
	Sat, 15 Nov 2025 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763227552;
	bh=LEb65hH+pPpondCKsU7vxXQGwoO+ddVN/H+2Wqn5LhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKKQ3bD5/WXtLThRnU1P5MCA0OXvSzw0itUoT2TntcIe4WChjcGjTZXDYTMS55P0b
	 crhhc4zFwwFEDyEI9CDqGvrPaY/PO+RNhf3ySTDWy/zWlO/Dab16Xt1i0Hmxg8iCyC
	 JnnfUF+Mh9oZE6r1ZVjotwutcIL5772nKy67v4mlfTwhiBfcryOCCVbOF/uWT8dOsW
	 r0rZvJNvIJOG0YC7CHnhfKZQReidgnZ1ITsvVJQjF5iUvGnGX3cFO955vfxLWrCuBv
	 NZmh+uG8NX4oHOpcSPePhZ/yU1Fosnrq7Mfa+EhWB08T3epytvsxS72zcEPskmkvSR
	 yYwKnGO4570ZQ==
Date: Sat, 15 Nov 2025 17:25:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: frequency: adf4377: add clk provider
Message-ID: <20251115172546.4b2fd06f@jic23-huawei>
In-Reply-To: <20251114120908.6502-2-antoniu.miclaus@analog.com>
References: <20251114120908.6502-1-antoniu.miclaus@analog.com>
	<20251114120908.6502-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 12:09:07 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

Title should be dt-bindings: iio: frequency: ...


> Add support for clock provider.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf4377.yaml   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> index 5f950ee9aec7..dab1591a36b3 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> @@ -40,6 +40,12 @@ properties:
>      items:
>        - const: ref_in
>  
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
>    chip-enable-gpios:
>      description:
>        GPIO that controls the Chip Enable Pin.
> @@ -99,4 +105,18 @@ examples:
>              clock-names = "ref_in";
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        frequency@0 {
> +            compatible = "adi,adf4378";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            clocks = <&adf4378_ref_in>;
> +            clock-names = "ref_in";
> +            #clock-cells = <0>;
> +            clock-output-names = "adf4378_clk";
> +        };
> +    };
>  ...


