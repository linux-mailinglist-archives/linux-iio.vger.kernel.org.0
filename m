Return-Path: <linux-iio+bounces-11503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7129B3762
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCFF1F2377E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B81DF25C;
	Mon, 28 Oct 2024 17:11:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3113AD11;
	Mon, 28 Oct 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135515; cv=none; b=r/sPj5jeIXSOv0f2IcALRDXrCVqzsXhVg+Y4u7i+XljKRdSfF8p9Z7g9T5/bMPggcpQJBbhArAcgT+M+NQn5QyyL9/LnzgoRkc8RZZ6JTSu5NLAJfjrHsTznp81X4Vja6+rDecQE6R05K2Ru+tSssphI4T8lMFp4zDD/R26RM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135515; c=relaxed/simple;
	bh=ffodTM6IF0oBZFbsq4Qck8Pspk75k2WpADJL+sZmS3Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZiX1wFhmna7zk6HHDPv6Ty9mZsgoJ0FLcQsElkVlDVwYQ8o76ehfzoU/ej5C6BALPnhgqW5rMUE9EnRo7uRoSVaGqkw9aI0k0yhtWH8vXnCnU9FqEVDDLAQpwoZed1xMkVae712030Aw09MfeU1s3nb4/mG7EAR8/9F+dEG/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xcfy20k99z67wqY;
	Tue, 29 Oct 2024 01:09:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 50BB7140C72;
	Tue, 29 Oct 2024 01:11:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 18:11:48 +0100
Date: Mon, 28 Oct 2024 17:11:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Budai <robert.budai@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>, Antoniu Miclaus
	<antoniu.miclaus@analog.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Jagath Jog
 J" <jagathjog1996@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <robi_budai@yahoo.com>
Subject: Re: [PATCH 3/5] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20241028171146.0000676a@Huawei.com>
In-Reply-To: <20241028123550.9128-2-robert.budai@analog.com>
References: <20241028123550.9128-1-robert.budai@analog.com>
	<20241028123550.9128-2-robert.budai@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Oct 2024 14:35:43 +0200
Robert Budai <robert.budai@analog.com> wrote:

> From: Ramona Gradinariu <ramona.gradinariu@analog.com>
> 
> Document the ADIS16550 device devicetree bindings.
What is the difference between the 16550 and 16550w.
Need to give an indication here of why the need separate compatibles.
 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---
>  .../bindings/iio/imu/adi,adis16550.yaml       | 95 +++++++++++++++++++
>  MAINTAINERS                                   |  9 ++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> new file mode 100644
> index 000000000000..a4690b39f0bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> @@ -0,0 +1,95 @@
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
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: If not provided, then the internal clock is used.
> +
> +  adi,sync-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Configures the device SYNC pin.
> +    enum:
> +      - direct_sync
> +      - scaled_sync
More detail needed on this. I'm not sure why it belongs in DT and
can't be controlled based on clock input and requested sampling
frequency.  

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
> +          enum: [direct_sync, scaled_sync]
> +
> +    then:
> +      dependencies:
> +        adi,sync-mode: [ clocks ]
> +
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +additionalProperties: false
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a27407950242..4f45478d271a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1411,6 +1411,15 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>  F:	drivers/iio/imu/adis16475.c
>  
> +ANALOG DEVICES INC ADIS16550 DRIVER
> +M:	Nuno Sa <nuno.sa@analog.com>
> +M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> +
>  ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-hwmon@vger.kernel.org


