Return-Path: <linux-iio+bounces-10818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2069A5437
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 15:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D653D1F22318
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817B5192597;
	Sun, 20 Oct 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5DmkMHH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6EF18E028;
	Sun, 20 Oct 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729429607; cv=none; b=muA50x3M5vNYSolMX89fM/CFE0itSbicZrphDK7lhWQBGAeo3v2hnXJ9Dj/RKH472dV1LOBumm5hW/16cqRp8K6Rvv2zqcCPrMZRDjT5gguiw1XosTxT4zwr0EWavhR/Hkiy8wr8+SYTgmtNh74b8K6qRVWtsS5lriauhH5rjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729429607; c=relaxed/simple;
	bh=rJkN2LmjEfZtyrGYUxVJjoKuUab90WdADJAUc1YAX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5JSbIKVIb6cGfCN2+i3gnPHCxf3NejRoSwAhd2M6jPYSZD0N4QC/fGSSG5iwyIHf+Y+JN2zeGf9G40IFVJK1k1D6InvLRLXmlZ3zAe/HlsXgEn6t5K13aa+nbezuFO9QVjuAFDG10S0n/1+nAZcTuxhL8iPGbMRWXERTz2DxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5DmkMHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BDCC4CEC6;
	Sun, 20 Oct 2024 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729429606;
	bh=rJkN2LmjEfZtyrGYUxVJjoKuUab90WdADJAUc1YAX9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N5DmkMHHyEnX+k4L6VrhVSf8NTe/KqZFzB37KnASDzjq7k+eS9vWmd2lH08doHiri
	 1JTGCocxkLMLo48i5Kh4oZf0rDQTLPCKnHncbHIknpVcNWsiypbKa+QMVPKRfJkQ+w
	 DVybkPmZOMXFLegXkVwEK6w/AXgDAROXHbHv2zasnGiS4KnKEuZhgKoaeimuectaO+
	 v6dEkWHVYTIvMniO6iSFvZ0ci6IkSOyssLSbXC9IRxPkHXglyzSycjUktO1vMJJAlk
	 eLtL6U8hGFeDJWJt7nlZBXWxxyIkP+rn7eRaNwL7Kzw6rc6fvdq20UJt24nky1Iapo
	 ShZapHpijiPsA==
Date: Sun, 20 Oct 2024 14:06:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
Message-ID: <20241020140638.127a9dbf@jic23-huawei>
In-Reply-To: <20241017-add-performance-tuning-configuration-v3-1-e7289791f523@gmail.com>
References: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
	<20241017-add-performance-tuning-configuration-v3-1-e7289791f523@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 18:36:44 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> When hardware design introduces significant sensor data noise,
> performance can be improved by adjusting register settings.

Questions inline. Mostly around why these controls belong in DT.
What do they have to do with hardware / wiring etc rather than being
appropriate for userspace controls.

So almost all are definite no to being suitable for device tree bindings.

Jonathan


> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 195 +++++++++++++++++++++
>  1 file changed, 195 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> index 64ce8bc8bd36..af419a3335eb 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> @@ -28,6 +28,189 @@ properties:
>  
>    vdd-supply: true
>  
> +  tyhx,dither:
> +    description: Enable spread spectrum function.

Why not turn this on all the time?  The datasheet I found suggests
this is to reduce EMI.

> +    type: boolean
> +
> +  tyhx,chop:
> +    description: Enable chop function.

No idea what this is in a proximity sensor. The datasheet says no more than you have here.
Without more info very hard to review this one.

> +    type: boolean
> +
> +  tyhx,odr:
> +    description: |
> +      Defines the sensor scanning period. The values range from 0x00 to 0x1F,
> +      corresponding to the following periods.

Userspace should be controlling this not DT.
+ it already does I think. So not appropriate for DT.
If you need a default add a udev script to set it.




> +      Val: Period
> +      0x00: Min (no idle time)
> +      0x01: 2 ms
> +      0x02: 4 ms
> +      0x03: 6 ms
> +      0x04: 8 ms
> +      0x05: 10 ms
> +      0x06: 14 ms
> +      0x07: 18 ms
> +      0x08: 22 ms
> +      0x09: 26 ms
> +      0x0A: 30 ms
> +      0x0B: 34 ms
> +      0x0C: 38 ms
> +      0x0D: 42 ms
> +      0x0E: 46 ms
> +      0x0F: 50 ms
> +      0x10: 56 ms
> +      0x11: 62 ms
> +      0x12: 68 ms
> +      0x13: 74 ms
> +      0x14: 80 ms
> +      0x15: 90 ms
> +      0x16: 100 ms
> +      0x17: 200 ms
> +      0x18: 300 ms
> +      0x19: 400 ms
> +      0x1A: 600 ms
> +      0x1B: 800 ms
> +      0x1C: 1000 ms
> +      0x1D: 2000 ms
> +      0x1E: 3000 ms
> +      0x1F: 4000 ms
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x00
> +    maximum: 0x1F
> +
> +  tyhx,range:
> +    description: |
> +      Defines the full-scale range for each channel.
> +      The values correspond to the following full-scale ranges.
> +      Val: Full Scale
> +      0x0: 1.25pF
> +      0x1: 2.5pF
> +      0x2: 3.75pF
> +      0x3: 5pF
> +      0x4: 0.625pF

This one 'might' be appropriate in DT if the value it should take reflects
sensing plate design etc connected to the chip.  Is that the case here?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +  tyhx,avg:
> +    description: |

This and next both appear to be oversampling in IIO userspace controls.
Not appropriate for DT as it is a policy decision trading off effective
data rate against noise.  The datasheet doesn't provide enough information
for me to understand what the difference is.
Maybe OSR is considered to be increase in sampling that doesn't affect the
scanning period, whereas averaging is multiple sampling periods?



> +      Defines the ADC averaging value for each channel.
> +      The values correspond to the following averages.
> +      Val: Avg Number
> +      0x0: 1
> +      0x1: 2
> +      0x2: 4
> +      0x3: 8
> +      0x4: 16
> +      0x5: 32
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +  tyhx,osr:
> +    description: |
> +      Defines the ADC oversampling rate (OSR) for each channel.
> +      The values correspond to the following OSR.
> +      Val: OSR
> +      0x0: 16
> +      0x1: 32
> +      0x2: 64
> +      0x3: 128
> +      0x4: 256
> +      0x5: 512
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +  tyhx,sample-num:
> +    description: |
So this is coupled with scanning period given above, but is again
not suitable for DT as it is a policy choice that userspace should be
controlling.

> +      Defines the ADC sample frequency.
> +      The sample frequency can be calculated with the following formula:
> +      Fsample = 1.0 / ( sample_num * 200ns ),
> +      where `sample_num` is the value in the register in decimal.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x00
> +    maximum: 0xFF
> +
> +  tyhx,integration-num:
> +    description: The integration number should be the same as the `sample-num` above.
If we were considering the previous one, then why have this as well?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x00
> +    maximum: 0xFF
> +
> +  tyhx,lp-alpha:
> +    description: |
> +      Defines the coefficient for the first-order low pass filter for each channel.
> +      The values correspond to the following coefficients.

Map this to userspace filter controls.  Note that userspace is not going to figure
out the filter design so you need to map it to 3DB points.
Not suitable for device tree.


> +      Val: Coefficient
> +      0x0: 1
> +      0x1: 1/2
> +      0x2: 1/4
> +      0x3: 1/8
> +      0x4: 1/16
> +      0x5: 1/32
> +      0x6: 1/64
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +  tyhx,bl-up-alpha:
> +    description: |
> +      Defines the up coefficient of the first-order low pass filter for each channel.
> +      The values correspond to the following coefficients.
> +      Val: Coefficient
> +      0x0: 0
> +      0x1: 1
> +      0x2: 1/2
> +      0x3: 1/4
> +      0x4: 1/8
> +      0x5: 1/16
> +      0x6: 1/32
> +      0x7: 1/64
> +      0x8: 1/128
> +      0x9: 1/256
> +      0xA: 1/512
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +  tyhx,bl-down-alpha:
> +    description: |
> +      Defines the down coefficient of the first-order low pass filter for each channel.
> +      The values correspond to the following coefficients.
> +      Val: Coefficient
> +      0x0: 0
> +      0x1: 1
> +      0x2: 1/2
> +      0x3: 1/4
> +      0x4: 1/8
> +      0x5: 1/16
> +      0x6: 1/32
> +      0x7: 1/64
> +      0x8: 1/128
> +      0x9: 1/256
> +      0xA: 1/512
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5
> +    maxItems: 5
> +
> +  tyhx,drdy-interrupt:
> +    description: Enable the interrupt function of each channel when the conversion is ready.
userspace control.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x00
> +    maximum: 0x1F
> +
> +  tyhx,int-high-num:
> +    description: Defines the Proximity persistency number (Near).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x1
> +    maximum: 0xF
> +
> +  tyhx,int-low-num:
> +    description: Defines the Proximity persistency number (Far).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x1
> +    maximum: 0xF
> +
>    "#address-cells":
>      const: 1
>  
> @@ -65,6 +248,18 @@ examples:
>          interrupt-parent = <&pio>;
>          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
>          vdd-supply = <&pp1800_prox>;
> +        tyhx,odr = <0x17>;
> +        tyhx,range = <0x4 0x4 0x4 0x4 0x4>;
> +        tyhx,avg = <0x3 0x3 0x3 0x0 0x0>;
> +        tyhx,osr = <0x4 0x4 0x4 0x0 0x0>;
> +        tyhx,sample-num = <0x65>;
> +        tyhx,integration-num = <0x65>;
> +        tyhx,lp-alpha = <0x2 0x2 0x2 0x2 0x2>;
> +        tyhx,bl-up-alpha = <0x8 0x8 0x8 0x8 0x8>;
> +        tyhx,bl-down-alpha = <0x1 0x1 0x1 0x1 0x1>;
> +        tyhx,drdy-interrupt = <0x1F>;
> +        tyhx,int-high-num = <0x1>;
> +        tyhx,int-low-num = <0x1>;
>  
>          #address-cells = <1>;
>          #size-cells = <0>;
> 


