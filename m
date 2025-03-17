Return-Path: <linux-iio+bounces-16951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F568A64BC8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60503A8E0C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7512356AF;
	Mon, 17 Mar 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZtT7gJk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77D4221D90;
	Mon, 17 Mar 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209235; cv=none; b=jvCGjyIprUgk0vneRx0oUAsFO2ljVjNcuqn78C0gm/QBbrGB6H/4zhGmOxam+3bHA9xgVWqk9NnoSuCsvuhHK/DjqDs9picTrJE+nBG57xGdQMnXdHJIznpJFpeqiWc8YmrTuoB6sdKh9hXF5/EDREIp/zZRsDUH2bUOGDXZTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209235; c=relaxed/simple;
	bh=cIaIJPwYqOlCSjrnyIzd9vFpecO2RJ2/gkUxMvk8lC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jV8+WNsil4OrL5xcCRdD2yIrUUggthD/mWuTmQRysHDHyMvD/vRex2XF6w8HY7J8E/n+q9SJCoGSQOMmZBc3P0PTihettvzPd57bwZz2IrGK3DG6vokqMvJG2xYI2l6DgQDo/R4l9N7Z4vkEQxVFyFFqClWHmEz0jz9dl5yJN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZtT7gJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E363C4CEE3;
	Mon, 17 Mar 2025 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742209234;
	bh=cIaIJPwYqOlCSjrnyIzd9vFpecO2RJ2/gkUxMvk8lC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZtT7gJkXFBW3k13ZwFE6PnSSSuaNGfQ7UyVPsMJrv2zWOqEJDtxCOvQ25Ubq6RXd
	 wrQhN0GziufdmwGSzPxrK2YWxwVDI6ZxmhSmRg/KG6zty2rrLtgdpbWq+J3KFLovrG
	 djAa5zU5SIR/6YF0SPqcTZIzJGBhBwuW+tCC8l+qcaP26blNu1DKSccpYHLKj7lpvd
	 qsSZfqaIJR2kYor99/8nKLGxJH0UGxYESFTmfYTJ2EggQ02owV24gAyaztQ/lZyzCR
	 bsnl2hYzHhSOoV7WJ9wL92luMmj4ZaXcJH4Vf1ImyM848ruOkxBwePZ8JzTWuTBaLr
	 hUgItkkUJk5ww==
Date: Mon, 17 Mar 2025 11:00:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 mazziesaccount@gmail.com, subhajit.ghosh@tweaklogic.com,
 muditsharma.info@gmail.com, arthur.becker@sentec.com,
 ivan.orlov0322@gmail.com
Subject: Re: [PATCH 1/3] dt-bindings: iio: light: veml6046x00: add color
 sensor
Message-ID: <20250317110012.2ad89cb9@jic23-huawei>
In-Reply-To: <20250316113131.62884-2-ak@it-klinger.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
	<20250316113131.62884-2-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 12:31:29 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add a new compatible for Vishay high accuracy RGBIR color sensor
> veml6046x00.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/light/vishay,veml6046x00.yaml         | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
> new file mode 100644
> index 000000000000..3207800fc539
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/vishay,veml6046x00.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Vishay VEML6046X00 High accuracy RGBIR color sensor
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description:
> +  VEML6046X00 datasheet at https://www.vishay.com/docs/80173/veml6046x00.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - vishay,veml6046x00
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        color-sensor@29 {
> +            compatible = "vishay,veml6046x00";
> +            reg = <0x29>;
> +            vdd-supply = <&vdd_reg>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
Need an include for this I think.  Make sure to test build your
bindings following the instructions in the bot message.

Thanks,

Jonathan

> +        };
> +    };
> +...


