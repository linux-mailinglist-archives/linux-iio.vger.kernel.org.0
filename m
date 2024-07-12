Return-Path: <linux-iio+bounces-7534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50092F9BF
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 13:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8AE1C2184B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603916B384;
	Fri, 12 Jul 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ty1kIG97"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17722BB15;
	Fri, 12 Jul 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720785317; cv=none; b=m+hYrByABN4nVW59fbcw3mYNDgNC9obOVK0x0CZJpjXvPR8HDUxzxuWxWYxzGgm+UUtvjQW5iFRjmZsMex2EuSCDU1ugYrVgqm6SoSJM6zG0JthGx1yp9BMrPFOPsDlXd5N3kED5nu004QqfkExRqz+IDeFT9PpC8BZX7avg/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720785317; c=relaxed/simple;
	bh=fq00OrXm4ESVMWuGZ9q3xU0NyJQJ344Ed3WenbJSvWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYFPXIZIvhclCjFWv5ydtHJYUUvIyLqeoUXq4LNkXR8JP+OhdhZOypQddmXpJewKjKpVHVzuTb+VdaEK8ZIz+fToYQrUbflbBYh4K/DqZftoypifR8rswYS6MZ2dSI0mkqbL5DdjPuCK/6Y3AY/ohGx42wmjuCbiPl0mBr31xtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ty1kIG97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27700C32782;
	Fri, 12 Jul 2024 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720785317;
	bh=fq00OrXm4ESVMWuGZ9q3xU0NyJQJ344Ed3WenbJSvWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ty1kIG97eg7DRj8rQBBQzrL88UKim2tOOZ3Lq4+89HBWUv9y1dB8ZDKswGAZwzGq9
	 GKcoPGcmjhqDhz3K4Q0vaYHWgI+EDwpdQKu3i5FZDxoXPA1rrk48gIEyurRSIGhLDJ
	 sgs8rYsE2aaXiJm3//QNSXqJWGEJg9bZvlp7kgoKS9LxpG1nq2Aoy0YdW9wBdAUT2K
	 K7b6KeZbjuIyBJeEn6UiW0V0ElZ+I1oa5FtKnnTr+UAWkSqT0WHh/xPVDg886p48zR
	 rG8t/WtKffMOuBlfpIK/itw+E8n40LAshM1PZ2ohHRZA0uu6jep4qCiyf9WIoN4QHI
	 DKNYESZXvPtTA==
Message-ID: <c466de06-cbc3-4ce7-90fe-4decc6e0fb89@kernel.org>
Date: Fri, 12 Jul 2024 13:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: Add YAML to Awinic proximity
 sensor
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: liweilei@awinic.com, kangjiajun@awinic.com
References: <20240712113200.2468249-1-wangshuaijie@awinic.com>
 <20240712113200.2468249-2-wangshuaijie@awinic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240712113200.2468249-2-wangshuaijie@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 13:31, wangshuaijie@awinic.com wrote:
> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> Add the awinic,aw96xxx.yaml file to adapt to the awinic proximity sensor driver.
> Addressing the issues raised in the previous version.
> 1. Add a description about the hardware device.
> 2. Remove inappropriate configuration items.
> 3. Modify the formatting issues.

That's commit msg or changelog? Don't mix both. Read submitting patches.

> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  .../iio/proximity/awinic,aw96xxx.yaml         | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
> new file mode 100644
> index 000000000000..459cb1644d3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/awinic,aw96xxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic's AW96XXX capacitive proximity sensor
> +
> +maintainers:
> +  - Shuaijie Wang <wangshuaijie@awinic.com>
> +
> +description: |
> +  Awinic's AW96XXX proximity sensor.
> +  The specific absorption rate (SAR) is a metric that measures
> +  the degree of absorption of electromagnetic radiation emitted by wireless
> +  devices, such as mobile phones and tablets, by human tissue.
> +  In mobile phone applications, the proximity sensor is primarily used to detect
> +  the proximity of the human body to the phone. When the phone approaches the human body,
> +  it will actively reduce the transmit power of the antenna to keep the SAR within a safe
> +  range. Therefore, we also refer to the proximity sensor as a SAR sensor.

Wrap at 80 (see Coding style).

> +
> +properties:
> +  compatible:
> +    enum:
> +      - awinic,aw96103
> +      - awinic,aw96105
> +      - awinic,aw96303
> +      - awinic,aw96305
> +      - awinic,aw96308
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Generated by the device to announce that a close/far
> +      proximity event has happened.
> +    maxItems: 1
> +
> +  awinic,sar-num:

Drop the property. I already asked.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Set the number of the SAR(Specific Absorption Rate) sensor.
> +      It is set to 0 if one awinic sar chip is used.
> +      If two awinic sar chips are used, awinic,sar-label in the first
> +      awinic-sar should be set to 0 and awinic,sar-label in the second
> +      awinic-sar should be set to 1.
> +      In an application where a device utilizes multiple proximity sensors,
> +      it is used to retrieve the names of the register configuration files
> +      that the drivers need to load. For example: aw963xx_reg_0.bin/aw963xx_reg_1.bin
> +
> +  awinic,regulator-power-supply:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> +    description:
> +      Choose if you want to use a regulator to power the chip. Then the
> +      vccX-supply has to be set.
> +
> +  vcc0-supply:
> +    description:
> +      Optional regulator for chip, 1.7V-3.6V.
> +      If two awinic sar chips are used, the first regulator
> +      should set the ID to vcc0-supply and the second regulator
> +      should set the ID to vcc1-supply.
> +
> +  awinic,channel-use-mask:

Aren't there existing IIO properties like this?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The mask of channels used.
> +      Configure according to the specific chip channel used.
> +      Bit[31:0] Each bit represents a channel.
> +      If the customer uses ch0 and ch2, then channel_use_mask=<0x05>
> +      For a 3-channel chip, the maximum value is 0x07;
> +      For a 5-channel chip, the maximum value is 0x1F;
> +      For a 8-channel chip, the maximum value is 0xFF;
> +
> +  awinic,monitor-esd:
> +    type: boolean
> +    description:
> +      Choose if you want to monitor ESD.

Why this is a choice? How does this describe hardware.

> +
> +  awinic,pin-set-inter-pull-up:
> +    type: boolean
> +    description:
> +      Choose if you want to set the interrupt pin to internal pull-up.
> +
> +  awinic,using-pm-ops:

NAK, drop all such OS policies.

> +    type: boolean
> +    description:
> +      Choose if you want to change the chip mode on suppend and resume.
> +
> +  awinic,use-plug-cail:> +    type: boolean
> +    description:
> +      Choose If you want to perform calibration when plugging and unplugging the charger.

And why this is board dependent?

> +
> +  awinic,irq-mux:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [2, 5]
> +    description:
> +      You only need to set this configuration item if you are using AW96308 adn AW96305BFOR.
> +      If CS2 is used as the interrupt pin, this item should be set to 2.
> +      If CS5 is used as the interrupt pin, this item should be set to 5.
> +


Best regards,
Krzysztof


