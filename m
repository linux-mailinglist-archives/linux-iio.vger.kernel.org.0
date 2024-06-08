Return-Path: <linux-iio+bounces-6061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F7901253
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599FD1F220E1
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8D17967A;
	Sat,  8 Jun 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7X0HodN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7E1FBB;
	Sat,  8 Jun 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717860430; cv=none; b=RD2GuVILYJmcx0rBiYIlxSJK+CKm6LjZmMGoaANORaMh1tg2iPKFRBhLPVJr4fmelWnRvUvpT6X1WNsKHx3zHprzE/UuA9szq51vLPj6Xrq158DTGfbCNnZwk61tFzBzxt113DnUXh/js7ybGYpBsZ17qUqRayzYR0w6Q8AzkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717860430; c=relaxed/simple;
	bh=HqxKqrF6NdA4tO9n7xPACAmfKZHrHqPzpej+VnzOCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJ/hN55r2KyewEVFRXEbkRbYlHZb3R6tpqyRrnE9khuARh6e0T0MkqQctdb61UK5EkcFTTuQiWROOTCeycaphdu3/efY0ifE4e4EpWEvtuBSJCl/Z7PKB3r8uwkfV4b4y3C9Q0iEwfkuRaPEUGdXdWILZfXOASP172zkkEb98Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7X0HodN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B18BC2BD11;
	Sat,  8 Jun 2024 15:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717860429;
	bh=HqxKqrF6NdA4tO9n7xPACAmfKZHrHqPzpej+VnzOCLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7X0HodNqv90N8UjF1zUvxC9P4G/Njtk+Xx8FtDfcFUkE3L0ZypOMUs8uU/5qEcZp
	 dUjakglbA7p+NmJS0CRp/e2vZ6pAKVhBVMQMCh3wTsmHEoYERzYlRqhKGHaoev+FRB
	 B8xPV/irkYm+hrKDqw9pcka+AryRJgAFhide37W/IiLSae/1p0aN5f47OIgn1TE0cM
	 jYzOZfZSDeb9g+U2eMlhjMLZtXlfv/Gp5lRj60e7xo3rnLxN+XJ1hsRCptqAT+gtZr
	 PtvEn/Lt4htY6BBgg3HCp6rC6FpfD9RXgDn1lJDfq4sW21K/n90WZzbOVvjDGhYuUh
	 c4fgBQwEtx29A==
Date: Sat, 8 Jun 2024 16:27:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, ivan.orlov0322@gmail.com, javier.carrasco.cruz@gmail.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: ROHM BH1745
Message-ID: <20240608162701.2e6fe36f@jic23-huawei>
In-Reply-To: <20240606162948.83903-1-muditsharma.info@gmail.com>
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 17:29:41 +0100
Mudit Sharma <muditsharma.info@gmail.com> wrote:

> Add ROHM BH1745 - 4 channel I2C colour sensor's dt-bindings.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Hi Mudit,

I'd like to see the vcc-supply in here from the start.

Thanks,

Jonathan


> ---
> v3->v4:
> - No changes
> v2->v3:
> - Move 'additionalProperties' after 'required' block
> - Remove block style indicator '|' from description
> v1->v2:
> - Fix yaml issue: Make `maintainers` a list
> 
>  .../bindings/iio/light/rohm,bh1745.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
> new file mode 100644
> index 000000000000..d5338a0af6b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/rohm,bh1745.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BH1745 colour sensor
> +
> +maintainers:
> +  - Mudit Sharma <muditsharma.info@gmail.com>
> +
> +description:
> +  BH1745 is an I2C colour sensor with red, green, blue and clear
> +  channels. It has a programmable active low interrupt pin.
> +  Interrupt occurs when the signal from the selected interrupt
> +  source channel crosses set interrupt threshold high/low level.
> +
> +properties:
> +  compatible:
> +    const: rohm,bh1745
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
There are some historical bindings that are missing supplies, but
for everything recent we have tried to document them from the first.
So this should have

  vcc-supply: true

> +
> +required:
> +  - compatible
> +  - reg
    - vcc-supply

Even though the regulator framework will provide you with a dummy regulator,
the binding reflects that the device definitely needs power.

Note that there are nice devm_regulator_get_enable() and similar to deal
with turning the power on at driver load (I guess that doesn't do anything on
your board) and off at driver remove.  Ideally the driver should use
that.  There have been many occasions in the past (all a while back)
where we didn't add power supply control from the start and had to add
it soon after when it turned out some board didn't default to power
on for the sensors.

Thanks,

Jonathan

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        colour-sensor@38 {
> +            compatible = "rohm,bh1745";
> +            reg = <0x38>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +
> +...


