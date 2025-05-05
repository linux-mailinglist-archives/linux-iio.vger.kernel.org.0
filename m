Return-Path: <linux-iio+bounces-19113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEFBAA97B5
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9237A6B66
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47B25DD1E;
	Mon,  5 May 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoxXpH/s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA66201004;
	Mon,  5 May 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746459852; cv=none; b=TSLxG/0OTHyHM/npQl29kATYj3U9VY2vr/8W/dRP+yeO/aYZsVhPB48Fl2NqKgodXfLHPUK+H9B9Aq5lrA296LGKn4z3L40Bno7yhJGHLbu2WfW8WhSw8mFDhhBjZOe/RcVCnrPLiG5kyIZnxyiHcyNGRioT6RTl6MQe0MmnrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746459852; c=relaxed/simple;
	bh=QS8dg5Szhy9yOKcqWeqbeXZjnglqgCLYD3ZcvqvMcCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9n3zbiYS+Z1H5uoskumOXqr0Azah8bEEdyaAd3CZEGqJRwaZrc+nIwid56UPhIOyyMn0KNSGR31r5jYgPtmOtZb3Hk7HPXV6R1VqSb6USzak/HkTwK3khzjwUWdXxz500qBvrlKlXXPFRwTUV+S8w0XlVyo0BhXVmjmTzKd+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoxXpH/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF991C4CEF0;
	Mon,  5 May 2025 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746459851;
	bh=QS8dg5Szhy9yOKcqWeqbeXZjnglqgCLYD3ZcvqvMcCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hoxXpH/smgixxZOLB0h6+9wBw4YUKoDsFKZMkbhcm75sdDJqdHdm/Ry3geaytxpw6
	 nAMzU92gh2z5OYXm+mqnIZ79WAu9iHGmXCjMApTJkCH9cunE8YMRhSAd/IXVP5Dvdx
	 ft8a9nHz8Q/23pZNN0+m+DfeDFSwNki6KttQLWuwzvbQt+x2+gJ87fxPm15yZny4xQ
	 v+mr1vkhPwLsUQjG9VpkNJLsAdTK9GPg0NrcKTm/punInWGZA/p8/UPA20n5Cy6t2J
	 6/gJX9WadHwzzCrFCq8DOXD6GlqPBbleWgsTq8sE/GHmk8KLIlz+wy585Ygu8G4FdD
	 M3YxbZ4tYLL0Q==
Date: Mon, 5 May 2025 16:44:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: Re: [PATCH v6 01/11] dt-bindings: trigger-source: add generic GPIO
 trigger source
Message-ID: <20250505164401.64cd3da7@jic23-huawei>
In-Reply-To: <f76579f8aa040125568c044c86761211a2e2f5ae.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
	<f76579f8aa040125568c044c86761211a2e2f5ae.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 21:12:02 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Inspired by pwm-trigger, create a new binding for using a GPIO
> line as a trigger source.
> 
> Link: https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-3-e48a489be48c@baylibre.com/

David, given you did the pwm one, maybe give this a quick look.

Maybe it's worth generalising to cover all trigger sources in MAINTAINERS?

Thanks. Otherwise I obviously need a DT review before taking this and maybe the GPIO
element suggests Linus W or Bartosz might be other good reviewers?

Jonathan

> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v6 Changes:
> * Changed description.
> * Fixed typos and replaced GPIO pin with GPIO line.
> * Added link reference for pwm-trigger.
> 
> v5 Changes:
> * New patch in v5.
> ---
>  .../bindings/trigger-source/gpio-trigger.yaml | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml b/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> new file mode 100644
> index 000000000000..1331d153ee82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/trigger-source/gpio-trigger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic trigger source using GPIO
> +
> +description: A GPIO used as a trigger source.
> +
> +maintainers:
> +  - Jonathan Santos <Jonathan.Santos@analog.com>
> +
> +properties:
> +  compatible:
> +    const: gpio-trigger
> +
> +  '#trigger-source-cells':
> +    const: 0
> +
> +  gpios:
> +    maxItems: 1
> +    description: GPIO to be used as a trigger source.
> +
> +required:
> +  - compatible
> +  - '#trigger-source-cells'
> +  - gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    trigger {
> +        compatible = "gpio-trigger";
> +        #trigger-source-cells = <0>;
> +        gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +    };


