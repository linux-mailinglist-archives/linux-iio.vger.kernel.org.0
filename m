Return-Path: <linux-iio+bounces-3962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5B2893BB2
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782E0281C50
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061323FE3F;
	Mon,  1 Apr 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCnUH7D7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E833F8F1;
	Mon,  1 Apr 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979990; cv=none; b=b4zBFKnUePODtYCngDEEzNyCMp2l+wYz4Vaho+NP6WEcCKdMSrdzIbaGxWf2Sv5d2eXgZfGM9lHieRQHo8IGmUtfT73iX6usIyBjwuvsoAi4s7CmTv4ms6xXQuP4CcHCju7HOmZAAzYL9ex265FfCd6H/ZoSCr/q+TyHEYdSeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979990; c=relaxed/simple;
	bh=sV0XZSPvZPbAbNUqylJMx3DNrWErD8RB4RKfAswervc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dES7nVkyFXJguXqREh2PV5lC4PT9neORlpIUVhCKKfeOLIeG9dpbAZ7B35ssI8ewX723T08tnly8jLH2nQgiVHL5AufTrIVYQ5AsuYmwPBEYc3Cmn0fAAgpN7Z0XbMFeHHwBtFF7raB4Xk1pVkZZ1bZsPBHySVzI9BdsCzWBVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCnUH7D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15547C433F1;
	Mon,  1 Apr 2024 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711979990;
	bh=sV0XZSPvZPbAbNUqylJMx3DNrWErD8RB4RKfAswervc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCnUH7D7idhMJd/3gXXoIZ9GCJg2XQkKNCPdzCnVtNQKOk1FAbd98Jy5cXV2lJfBF
	 Cq/Lp6I8MDPsPWJtj4X4pcGLYWs4LZy0JQH9hEFJgKRkZdJux7vK8a9SXcsEny813o
	 5Mop/WBQnSINVJwyiiZ9qbshUmq7YwwHCpx4YiM+nE4QbLa1deOr0aYvTnsXX6xxp3
	 /kF0S2bQ86o+V+Kv4td6L6P1FHn+pHJncVEOS5AstrVt25HVRnigzGXc6M7vCMmgRD
	 8aDefFLEUq4OREfT6H0IN6bujZ71dx6Y6ouHJNlyxx9lXRAaTvz+nsfP2cm5wcClyW
	 zhtt0gbvG7x9Q==
Date: Mon, 1 Apr 2024 08:59:48 -0500
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 06/10] dt-bindings: iio: dac: add bindings doc for AXI
 DAC driver
Message-ID: <20240401135948.GA349128-robh@kernel.org>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
 <20240328-iio-backend-axi-dac-v1-6-afc808b3fde3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-iio-backend-axi-dac-v1-6-afc808b3fde3@analog.com>

On Thu, Mar 28, 2024 at 02:22:30PM +0100, Nuno Sa wrote:
> This adds the bindings documentation for the AXI DAC driver.

Bindings are for h/w blocks, not 'drivers'.

Reword the subject to only say 'bindings' once.


> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 62 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 +++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> new file mode 100644
> index 000000000000..1018fd274f04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,axi-dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AXI DAC IP core
> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +
> +description: |
> +  Analog Devices Generic AXI DAC IP core for interfacing a DAC device
> +  with a high speed serial (JESD204B/C) or source synchronous parallel
> +  interface (LVDS/CMOS).
> +  Usually, some other interface type (i.e SPI) is used as a control
> +  interface for the actual DAC, while this IP core will interface
> +  to the data-lines of the DAC and handle the streaming of data into
> +  memory via DMA.
> +
> +  https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,axi-dac-9.1.b
> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: tx

You don't need *-names if there is only 1 entry.

> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#io-backend-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - dmas
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dac@44a00000 {
> +        compatible = "adi,axi-dac-9.1.b";
> +        reg = <0x44a00000 0x10000>;
> +        dmas = <&tx_dma 0>;
> +        dma-names = "tx";
> +        #io-backend-cells = <0>;
> +        clocks = <&axi_clk>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7287cf44869..2137eb452376 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1399,6 +1399,13 @@ F:	sound/soc/codecs/adav*
>  F:	sound/soc/codecs/sigmadsp.*
>  F:	sound/soc/codecs/ssm*
>  
> +ANALOG DEVICES INC AXI DAC DRIVER
> +M:	Nuno Sa <nuno.sa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> +
>  ANALOG DEVICES INC DMA DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  S:	Supported
> 
> -- 
> 2.44.0
> 

