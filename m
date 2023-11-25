Return-Path: <linux-iio+bounces-339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395337F8B29
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8351C20B8A
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DF2111A5;
	Sat, 25 Nov 2023 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF2HsCYM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422191171B;
	Sat, 25 Nov 2023 13:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F718C433C8;
	Sat, 25 Nov 2023 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700920225;
	bh=ExqPDaAaDFGikMpcUR8jEv5p97UUd1YLtOLKKfLhU10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rF2HsCYMUDWG7ZbEHvKLtH+iLRfFlviiHlVOsE7Wv/3YhMlQvqeRFKgI2ngby0YsS
	 xZHS/kGMTNpvcdcDLWanlTixFNAgJqtS1y+sKkJBnIJZHq7SXdnnrE21nYXzJmotza
	 pYkkn7N7FiE//NgMJmR6M0zRW/McgFj+rOvzwfBz4H4e32nSkkMTobp2dPQneZw0XZ
	 GKcCUzgr0XOjFtNKqw+2UnsWax709685JUqzIuUqmg+29DtHODZB/qoSAnK1nVDsnJ
	 +frBiWyKOi7scL/hJzvrUGZVSNmr0m4FA+Zp+EzNoKiZxjgs0kqdP0XOFIHdy4q8rx
	 3hYwzoL1SnJ+A==
Date: Sat, 25 Nov 2023 13:50:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Anshul Dalal <anshulusr@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: add ltr390
Message-ID: <20231125135017.30936eef@jic23-huawei>
In-Reply-To: <20231117074554.700970-1-anshulusr@gmail.com>
References: <20231117074554.700970-1-anshulusr@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 13:15:52 +0530
Anshul Dalal <anshulusr@gmail.com> wrote:

> Add binding for Lite-On LTR390 which is an Ambient/UV light sensor that
> communicates over i2c with an address of 0x53.
> 
> Datasheet:
>   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
> 
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> ---
> 
> Changes for v2:
> - Added missing properties in the example
> ---
>  .../bindings/iio/light/liteon,ltr390.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
> new file mode 100644
> index 000000000000..5d98ef2af74d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr390.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/liteon,ltr390.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lite-On LTR390 ALS and UV Sensor
> +
> +description: |
> +  The Lite-On LTR390 is an ALS (Ambient Light Sensor) and a UV sensor in a
> +  single package with i2c address of 0x53.
> +
> +  Datasheet:
> +    https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-390UV_Final_%20DS_V1%201.pdf
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - liteon,ltr390
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      Level interrupt pin with open drain output.
> +      The sensor pulls this pin low when the measured reading is greater than
> +      some configured threshold.
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
Same comment on vdd-supply here as in the other drivers.
Not vital, but contention has become to add any supplies to required that
have to be turned on, whether or not the kernel cares about them.
Note I'd prefer drivers to use the trivial
devm_regulator_get_enable() call anyway to turn them on at probe and
off at remove. That's simple enough to do without needing testing with real
controllable regulators.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@53 {
> +            compatible = "liteon,ltr390";
> +            reg = <0x53>;
> +            interrupts = <18 IRQ_TYPE_EDGE_FALLING>;
> +            vdd-supply = <&vdd_regulator>;
> +        };
> +    };


