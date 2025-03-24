Return-Path: <linux-iio+bounces-17258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8924A6E3E3
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 21:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999AD16EB1D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454E1ACEDD;
	Mon, 24 Mar 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX86WUMR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E6157A46;
	Mon, 24 Mar 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846643; cv=none; b=dP/eKlpe3fReBsgrwvL2oj0oxHvYJM+bVYeySDd7+/dv/xpYlxb5povpDLYhXzE52RmwaXrbt+6Hj+JYe9x7JH+EumjzOR+wBkpIWQhMRkdBCx3/tmW/abaALffyXYJ7MaMXMjxKAgfhFrzvEA8mEC/UMGXSHkcFxNCE+v95zyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846643; c=relaxed/simple;
	bh=ie7dgcF0HLYNml0Wy9ypJVeYl+H6beLlTvb10+aHHxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwRUDyUPiAyFYWUM+VyWQk048kNTdAWm2Bbe7deVD1IP9ZmjNVK+IxSlBHQ/cBmtmVU7TQie+aLXWa+qHMcRT3rYf6AMBGehjpDWvhicYVzNg1lATakhhGYIHGLirnX44WT1BpKzHvLBchMnE+939OeMJajnR5UViupnQbuD0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX86WUMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966D8C4CEDD;
	Mon, 24 Mar 2025 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742846642;
	bh=ie7dgcF0HLYNml0Wy9ypJVeYl+H6beLlTvb10+aHHxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SX86WUMR4kUX6X3vDW+96ykYaI0EMXLT7qb033ai/TNdlFcnRFdi2NFNti8IcwwK0
	 FyNrzCpO3D4P+R5pfFicM0zD6UIIufKnRMMY7Xx8Iq9+C6n/1HWuwrc73D+v3YTHqn
	 41UAFhJwa8eMv82GoxMl568ei1H7UhwxHAZKOHBdBtP4LWAQxTthx/ZeyclI4+bJI4
	 1FnJF6ZU1o5dOOeFawjJ5eTdWwVN7ak98lByZDDo6sWMzmjwvlWwqHt4jsA34MgDW3
	 I4ICaxVLwRAqNZ2bbgu4glJHvIXggSItRvYxKo8iSMZibCbBTny8x68raTjH5xHDSn
	 Mfr2VHpyxSfoQ==
Date: Mon, 24 Mar 2025 15:04:01 -0500
From: Rob Herring <robh@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: iio: adc: add ad7405
Message-ID: <20250324200401.GA691400-robh@kernel.org>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-5-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324090813.2775011-5-pop.ioan-daniel@analog.com>

On Mon, Mar 24, 2025 at 11:07:59AM +0200, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7405.yaml          | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> new file mode 100644
> index 000000000000..e312fa0cdb05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7405.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7405 family
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +
> +description: |
> +  Analog Devices AD7405 is a high performance isolated ADC, 1-channel,
> +  16-bit with a second-order Σ-Δ modulator that converts an analog input signal
> +  into a high speed, single-bit data stream.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7405.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7701.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7702.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM7703.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7405
> +      - adi,adum7701
> +      - adi,adum7702
> +      - adi,adum7703
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  clocks:
> +    maxitems: 1
> +
> +  io-backends:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vdd1-supply
> +  - vdd2-supply
> +  - clocks
> +  - io-backends
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    adc {
> +       #address-cells = <1>;
> +        #size-cells = <0>;
> +        compatible = "adi,ad7405";
> +        clocks = <&axi_clk_gen 0>;
> +        vdd1-supply = <&vdd1>;
> +        vdd2-supply = <&vdd2>;
> +        io-backends = <&iio_backend>;
> +    };
> +...
> \ No newline at end of file

Fix this.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


