Return-Path: <linux-iio+bounces-7592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D989930566
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E181F2209F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675EC7E57C;
	Sat, 13 Jul 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYjiP49S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6941C77;
	Sat, 13 Jul 2024 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720869292; cv=none; b=N5w2yq6BqLqUY+ucXHlSQhm2ohKbPtE21zRF9vyPXZWtGbSbm0CEaF+hPWcn5GK2s82ysOm+cBefUUlIrEb5i0mfBggjAVh7GmmYxYHMs2ot4LTZavx4Slu+SOdQF25QZEKDszi2esfqhZXwgQvk+5prYmlaH/ClkRBDBGIooDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720869292; c=relaxed/simple;
	bh=AVTWECknh32vjkZvl6c1yiioF+Jv7m0uf7e+eThQ778=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxkASaFUgAwNJJ6FEGEJWMcSs5w3p0WnRXLCfPrRuOMlZyMwIzpeHdKVE0jf3mcqRBM6tKN/FAwH8O04MRaEulsTfPnwXYFkVOePzPNcokh/yxQw3OcMfnwPPn95HLydkndSlVW3b4J80OhhibVn2/5SH09qha8f1SsrIunMoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYjiP49S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30ADC32781;
	Sat, 13 Jul 2024 11:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720869291;
	bh=AVTWECknh32vjkZvl6c1yiioF+Jv7m0uf7e+eThQ778=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LYjiP49SSjcozMPDbKiuzNGFUJv845ugVw7D7QTvog6QwouHFREDf1+33/2CVKi5U
	 tXmPMdzKKPdoseJz5FJ/RfkpFBR0QxL0RD8jVQdulVmoAjxM9frqa7B4oq+QD2WwZH
	 Tj2UuqRIFnNWfxKj3/vqzekMJlxrAYJP+76S7vdJKEz+KtKU444T0Icpuz2dhKCvtL
	 6Aiietj0t2W+2gT8BDJgcEfDBabkdWlwMeUHdGpwKxW8I4WsKH1tri9YUBffndTfDx
	 rLh+mABXjqdoD01wfc4yAPqxM1O6XdByXtOyfavnj8AVB3x9boBID0M5AVPUuXTOXB
	 frO5M7Wk4ikMQ==
Date: Sat, 13 Jul 2024 12:14:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: humidity: add ENS21x sensor
 family
Message-ID: <20240713121442.0fa8ed2c@jic23-huawei>
In-Reply-To: <20240710-ens21x-v3-1-4e3fbcf2a7fb@thegoodpenguin.co.uk>
References: <20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk>
	<20240710-ens21x-v3-1-4e3fbcf2a7fb@thegoodpenguin.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 14:24:04 +0100
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk> wrote:

> Add device tree documentation for ENS21x family of temperature and
> humidity sensors
> 
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
> ---
>  .../bindings/iio/humidity/sciosense,ens21x.yaml    | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
> new file mode 100644
> index 000000000000..425d3b57f701
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/sciosense,ens21x.yaml#

Normally we don't allow wild cares in binding names, but in this case the
datasheet uses this wild cards, so I guess we have strong guarantees
the manufacturer won't slip something else in the gaps.

Even with that in mind I'd rather this was sciosense,ens210.yaml

As much as anything as to not provide more precedence for wild cards in binding
names that might lead people astray when they don't have such strong guarantees.

Otherwise looks fine to me.

Jonathan


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ScioSense ENS21x temperature and humidity sensor
> +
> +maintainers:
> +  - Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
> +
> +description: |
> +  Temperature and Humidity sensor.
> +
> +  Datasheet:
> +    https://www.sciosense.com/wp-content/uploads/2024/04/ENS21x-Datasheet.pdf
> +    https://www.sciosense.com/wp-content/uploads/2023/12/ENS210-Datasheet.pdf
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sciosense,ens210a
> +              - sciosense,ens211
> +              - sciosense,ens212
> +              - sciosense,ens213a
> +              - sciosense,ens215
> +          - const: sciosense,ens210
> +      - const: sciosense,ens210
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       temperature-sensor@43 {
> +           compatible = "sciosense,ens210";
> +           reg = <0x43>;
> +       };
> +    };
> +...
> +
> 


