Return-Path: <linux-iio+bounces-21934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F396EB10538
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361CB7BD0DA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318EE2750E2;
	Thu, 24 Jul 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR8wZUg2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D917996;
	Thu, 24 Jul 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347787; cv=none; b=KH0g7ZxG5R+TeI2Dv402p20gtozTAD/6HPNwJakSHHfcr5jDFEA5wB4wVSaEEhm7aetnLvYSMNXbTTeCDe7suDAw7/rr1WPDPE+gmCrJ/bcfUOvF/RcdkIhTRr9yvKRHFWhu6C++QxfB9SZWz5zsfbMwJZAjhgJ1M7wKvFKJN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347787; c=relaxed/simple;
	bh=PxzwG0gXXRflyI0Y8xrQQzzEp28aI6sOScugqA9mOV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqx20Dx9Mre9wWC6lql+VosWP6ckfs57IbC60+t7eqZ68qOp21iBvxYXiGC1S8ZsrQhWSJKveKnXsQehM8AUc/YEGiEPh+rWHtYLgoQ2hdVnk7VC8AwmVAAmjwgyjyj822mSmTCyatHphB3g74vabJ+GeniQS9hC7mjiKf33Xc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR8wZUg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EDFC4CEED;
	Thu, 24 Jul 2025 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753347785;
	bh=PxzwG0gXXRflyI0Y8xrQQzzEp28aI6sOScugqA9mOV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qR8wZUg23F2cxVS3krxhN76dgS+hR3IcRYzEchL0nchepTuFECZQ+BQ+YUxEioiWC
	 yWAE9lOT+ZQdH98r4gdjZshTVnXf5FtDp1ZL1KsozBiR5zHDHViAh+eJudJekhYwSs
	 HbvXFhC7W7gX1AiZNbeVkfs4n0DodB/xaqLCjFS+pN3fG5AWCpuzwvCp4V6zJLahsZ
	 s+mBaGmwOAk6/UIotFUX/Xh6cLGaHe8XkZ33T0SfSqhxv4e6R1LvSejgNzamMddams
	 gGazOgyCR3QPJvTp5Zx20BvlIsgjB2c27A0Mu9E7OJDDyw0aTdQtRbGe0X1TXiFZnk
	 vMZ+oJYzzCdOA==
Message-ID: <184bf60f-f803-48a0-a854-badc14584e53@kernel.org>
Date: Thu, 24 Jul 2025 11:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support.
To: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, peterz@infradead.org,
 jstephan@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com, carlos.song@nxp.com,
 xiaoning.wang@nxp.com, haibo.chen@nxp.com
References: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 10:39, Lakshay Piplani wrote:
> Add bindings for the NXP P3T175x (P3T1755/P3T1750)
> digital temperature sensor, supporting both I2C &
> I3C interfaces.
> 


Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Subject: drop full stop.

> +properties:
> +  compatible:
> +    enum:
> +      - nxp,p3t1755
> +      - nxp,p3t1750

Keep the list sorted.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      In I2C mode, the device supports up to 32 static addresses.
> +      In I3C mode, the 'reg' property encodes a triplet of
> +      <static-address BCR PID> used for device matching.
> +      Static address is optional if matching is done via PID.
> +
> +  nxp,interrupt-mode:
> +    type: boolean
> +    description: |
> +      Enables interrupt mode (TM = 1), where alerts are latched until
> +      cleared by a register read.
> +      Required for IBI support over I3C. On I2C, both interrupt and
> +      comparator mode support events.

Both properties are redundant because they are implied by the bus, no?

> +
> +  nxp,alert-active-high:
> +    type: boolean
> +    description: |
> +      Only applicable for I2C mode.
> +      Sets the polarity of ALERT pin to active high, if true.

Why are you encoding standard interrupt flags as a new property?

> +      Ignored in I3C mode (which uses IBI signaling).
> +
> +  nxp,fault-queue:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 6]
> +    description: |
> +      Number of consecutive temperature limit
> +      violations required before an alert is triggered.
> +      valid values:- 1, 2, 4 or 6.
> +      If unspecified, hardware default (2) is used.

Why would that be board level configuration?

> +
> +  assigned-address:

:true

and that's it... unless you want to make sure it has a type also for I2C
case? How other I3C device binding solve it?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x1
> +    maximum: 0xff
> +    description: |
> +      Dynamic address to be assigned to this device. In case static address is
> +      present (first cell of the reg property != 0), this address is assigned
> +      through SETDASA. If static address is not present, this address is assigned
> +      through SETNEWDA after assigning a temporary address via ENTDAA.

But for sure no need to duplicate common schema.

> +
> +required:
> +  - compatible
> +  - reg
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
> +        temp-sensor@48 {
> +            compatible = "nxp,p3t1755";
> +            reg = <0x48>;
> +            nxp,interrupt-mode;
> +            nxp,fault-queue = <6>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> +
> +  - |
> +    i3c {
> +      #address-cells = <3>;
> +      #size-cells = <0>;
> +      temp-sensor@48,236152a00 {
> +        reg = <0x48 0x236 0x152a00>;
> +        assigned-address = <0x50>;
> +      };
> +    };
> +
> +  - |
> +    i3c {

Drop this example.


Best regards,
Krzysztof

