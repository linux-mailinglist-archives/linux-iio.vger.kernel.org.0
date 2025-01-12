Return-Path: <linux-iio+bounces-14229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F8A0AA9C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEDE3A7305
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C611BCA0E;
	Sun, 12 Jan 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKbi+8N+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2D1714B7;
	Sun, 12 Jan 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736696926; cv=none; b=t+n8HdphNfyEHmmAhj+bsFMQnCv38SEo5VgcWQy+vd6DrW+n6AE7Nzr6z2X7+RmVN/nHBbHStJskStTtwx456JF1TUwW2F9udN449YuJc1qtZdoSCp3WGApH5Yb06MAjTnusyanF+yC426+vlysrp2ObTKe4Pgt67pT9WNeYGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736696926; c=relaxed/simple;
	bh=TRmLNF/zsWGWfXzX0ZwU7gbwlpaHkbEbkAWudDeVirM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUPHq2LfmS6oSfEBz9xiNPs1vNLmrsyEoyy4vXuztm2Z1OEHRTR3UY6O+qOkcr76BrK2Z6D9wc20tV8zNBRMe7MooOQEv2wJlDWSA0L6/IGa5oAaMRlxa1x+NY7b7hx2tQbPNonA6ErU5/fGSes+S3kbpZsQMJdIHYmQJI7r7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKbi+8N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827E8C4CEDF;
	Sun, 12 Jan 2025 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736696926;
	bh=TRmLNF/zsWGWfXzX0ZwU7gbwlpaHkbEbkAWudDeVirM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lKbi+8N+vtfCY/Qg32UIZVlqLbBGcreQMWlkyPY4x2T3Zq69FIl42vBArFcnLy7Y0
	 bhLr0WcVeWd1GPeWwLj0mqI5Mps06o4krBJavOmGcITQziKTe3TTuATFF3upWUq1M1
	 05Uul37/Z3ogaYWbCYGZC5spSwTxsGoNr5Aa78OxXLHd0xAjfKsxYDOcIiwB0RrKE9
	 DWE9gh/PqPTHeRyDP5dh2Wwc/CkD0TnQ8OfeXvra6OK4IMyRik1VvBFHqW7akBL+M0
	 E4M/e2RXvuyzP78F4lifx9LOLRHwTsdXALZ3kU1n6UZAu8sA2b/PDq+xSOcqlW8mpF
	 SeoXaQ3Qs4vlA==
Date: Sun, 12 Jan 2025 15:48:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano
 <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20250112154836.47feeea8@jic23-huawei>
In-Reply-To: <20250110074254.38966-5-robert.budai@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
	<20250110074254.38966-5-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 09:42:52 +0200
Robert Budai <robert.budai@analog.com> wrote:

> Document the ADIS16550 device devicetree bindings.
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
> 
> 4:
> - applied styling changes to the bindings file
> - restricted sync-mode to intervals 1-2 
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       | 96 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> new file mode 100644
> index 000000000000..e7ccf3883e55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16550 and similar IMUs
> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Ramona Gradinariu <ramona.gradinariu@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16550
> +      - adi,adis16550w
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 15000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      RESET active low pin.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: If not provided, then the internal clock is used.
> +
> +  adi,sync-mode:
> +    description:
> +      Configures the device SYNC pin. The following modes are supported
> +      0 - output_sync
> +      1 - direct_sync
> +      2 - scaled_sync

A little more on these would be good.  They are 'weird' options
that are not commonly seen so help the reader out.

For scaled_sync don't we need information on the scale for it to be useful?
If we had that then a value of 1 would mean direct sync and wouldn't need
another control. 

I'm not fully understanding the usecases for this.

If we have a say a pulse per second input, the control of the scale should
be userspace anyway.  So maybe this maps to the input clock that we can elect to
use and control the effective frequency of by using scaled sync?

I'm not sure what pulse sync is. Grepping the datasheet didn't give me
anything that seemed related.   The sync pin is input only so I'm also
not sure on output sync.

> +      3 - pulse_sync
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 2

You describe 0 to 3 but only allow 1 or 2?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - spi-max-frequency
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        adi,sync-mode:
> +          const: 2
> +
> +    then:
> +      dependencies:
> +        adi,sync-mode: [ clocks ]
> +
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imu@0 {
> +            compatible = "adi,adis16550";
> +            reg = <0>;
> +            spi-max-frequency = <15000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            vdd-supply = <&vdd>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio>;
> +        };
> +    };
> +...



