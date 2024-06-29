Return-Path: <linux-iio+bounces-7039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8491CDE4
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E562D283111
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124938286A;
	Sat, 29 Jun 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov3iC2Nr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C04175A;
	Sat, 29 Jun 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675052; cv=none; b=tGBs4oudZlpKTH71M7gxV8A/OwRacO9NbXlfbMTOoz3z3RCdzGwSdGRpcNMBoSXO5kQcYt6K4gPbNlZBrRYVCV9NuBnRBTOMNVDC4OoFtYjZgY4ejd6jeF4ML2RDlk4hKdbznpppACD+mRR6OGko/1BwQrxCOe5tgDP0tMu6WdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675052; c=relaxed/simple;
	bh=T5g2MJScF2SnMwzHMmI6jH/lderd7VPwPuoFsvSu1gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJCTBHdbQvUSRbAAL8M1U6M1S9ockFDUtIA/BFZRrA5CSuzDZsUfX3WwLG08SFY9pxTaP4n7m9CfudB74GDXEiyu94ye/3CqfWu4tyFHRDz8tM9IFisqY0PPyTMJdZeBNsOU7b+Jume5eWNDyZ+18s4IrG/CMzpPXgUAcBplsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov3iC2Nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E9EC2BBFC;
	Sat, 29 Jun 2024 15:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719675052;
	bh=T5g2MJScF2SnMwzHMmI6jH/lderd7VPwPuoFsvSu1gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ov3iC2Nrb3diAWLv714jftirxWL0ofd7NLjLrrRrb6oBIZmzJxbcOnBhkOcBVKRe8
	 tQcoPDy2wRiY4yS7r2RxfYjhnJoq7EcEgR+JAv9oMLgLu01s1R0kAlveEQ+fmIntsr
	 bkgWWRZ8Eomk7h9CMKY5VULn4VWxmoV0dFkU+fIG5fuVpdAYz/CbpCLZMc1h7cteLm
	 7sv9OPSANMwxGhiWK3MliKdtAk4JEk3lzKiFOj+Ncc4gsQ2AyyzXwuZXlv04Vf2OxV
	 jmm0rAzHa9nHm8d1r3zjkkvGT7QyKH+DlpuJ0fJqwORhIapmWyimet21RLUr3z57C3
	 UEdTcXGQtRIIw==
Date: Sat, 29 Jun 2024 16:30:43 +0100
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
Subject: Re: [PATCH v2 05/10] dt-bindings: iio: adc: adi,ad7606: add supply
 properties
Message-ID: <20240629163043.5e96e80c@jic23-huawei>
In-Reply-To: <20240628-cleanup-ad7606-v2-5-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
	<20240628-cleanup-ad7606-v2-5-96e02f90256d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 14:48:23 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Add voltage supplies
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Trivial comment inline. No need to reroll for that though.

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 509970922cda..a1c38a5812f7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -35,6 +35,15 @@ properties:
>  
>    avcc-supply: true
>  
> +  vdrive-supply:
> +    description:
> +      Determines the voltage level at which the interface logic pins will
> +      operate.
> +
> +  refin-supply:
> +    description:
> +      The voltage supply for optional external reference voltage.
> +
>    interrupts:
>      description:
>        The BUSY pin falling edge indicates that the conversion is over, and thus
> @@ -106,9 +115,11 @@ required:
>    - reg
>    - spi-cpha
>    - avcc-supply
> +  - vdrive-supply
>    - interrupts
>    - adi,conversion-start-gpios
>  
> +
Unrelated white space change.  Remember to check patches for these.
If whitespace changes are needed have an additional patch that just does
that.

>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -130,6 +141,7 @@ examples:
>              spi-cpha;
>  
>              avcc-supply = <&adc_vref>;
> +            vdrive-supply = <&vdd_supply>;
>  
>              interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>              interrupt-parent = <&gpio>;
> 


