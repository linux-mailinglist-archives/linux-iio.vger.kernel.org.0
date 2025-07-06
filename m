Return-Path: <linux-iio+bounces-21395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4DCAFA4A3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430753A38D4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567F202963;
	Sun,  6 Jul 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKKbMx3y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72717BCE;
	Sun,  6 Jul 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751799207; cv=none; b=Po5bti9fAVv5aAP0lqm6N0ScmurEFr2TbtZygcZGo298/CUJgIuv8VpxFuhJbGDQDpw9lYPR5vfU+ZosIgBxbpAWQO6fNMVshomXMX9b4fDNCsBhtJ2UfUo8ahmPatAq67imNTVk8h5wBvJtuq3MrjeC2Xi6VReTE1P2ws+DzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751799207; c=relaxed/simple;
	bh=W5pY1T+zdlN10wL2RQ9+j6hVOu2Gs8GqVwOufukVdok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRU/Q54p2Dzw1eeP0u+onQ0qtT+oZ27+xfRjEnSrfDv5VF3JY/tOy8tjnsrTfUdTHXMB9C1vyRp/JPQQbnIRUcsWi5cczudl+nik4v8xCl1OUgN1wqpbqjaVtfiFjVROhoHzwE8WM9NETgchc9NsK9TjtSM+BmR4+QdMceYCA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKKbMx3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F426C4CEED;
	Sun,  6 Jul 2025 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751799207;
	bh=W5pY1T+zdlN10wL2RQ9+j6hVOu2Gs8GqVwOufukVdok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DKKbMx3yhrxxgII+dWmdbDaE5uLMwSGpds5xKOpZcL2W27400mFASVTCP9j6hZXDE
	 petvVi4bbRyuuoA8lHLplwkOEpy+pcyx62JANh4XA5ChYoDhcmDmOCn4NoFfVZZcAI
	 An8u9/jaoaDSGvy2uQ4BQN6IHtIeq7k/0G30SHR0bJfF02gsQUtSBVjJS25c/VoXVo
	 4+U1Glk25mPXmUth0Qpp/9Oq+PfVHxhGe3Vl5jPjvTOzWwXpOSs9C6L0wvDJzyIa9z
	 etkCYQb+JwTUXaY7eTVDHmrkJEPARM/1qtj906Hi3f09zrJ8BY3nUkQD5+uC50Dcxs
	 NkQwhFd0PulWg==
Date: Sun, 6 Jul 2025 11:53:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <kernel@axis.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: proximity: Add Nicera
 D3-323-AA PIR sensor
Message-ID: <20250706115319.4f663960@jic23-huawei>
In-Reply-To: <19a2744cebaee57fe5349986094168524baa9838.1751636734.git.waqar.hameed@axis.com>
References: <cover.1751636734.git.waqar.hameed@axis.com>
	<19a2744cebaee57fe5349986094168524baa9838.1751636734.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 18:14:38 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Nicera D3-323-AA is a PIR sensor for human detection. It has two GPIOs
> for detection and data communication.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  .../iio/proximity/nicera,d3323aa.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
> new file mode 100644
> index 000000000000..65d9b44fcd5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/nicera,d3323aa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nicera D3-323-AA PIR sensor
> +
> +maintainers:
> +  - Waqar Hameed <waqar.hameed@axis.com>
> +
> +description: |
> +  PIR sensor for human detection.
> +  Datasheet: https://www.endrich.com/Datenbl%C3%A4tter/Sensoren/D3-323-AA_e.pdf
> +
> +properties:
> +  compatible:
> +    const: nicera,d3323aa
> +
> +  vdd-supply:
> +    description:
> +      Supply voltage (1.8 to 5.5 V).
> +
> +  vout-clk-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO for clock and detection.
> +      After reset, the device signals with two falling edges on this pin that it
> +      is ready for configuration (within 1.2 s).
> +      During configuration, it is used as clock for data reading and writing (on
> +      data-gpios).
> +      After all this, when device is in operational mode, it signals on this pin
> +      for any detections.

Don't start a new line for a new sentence. 

> +
> +  data-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO for data reading and writing. This is denoted "DO (SI)" in datasheet.
> +      During configuration, this pin is used for writing and reading
> +      configuration data (together with vout-clk-gpios as clock).
> +      After this, during operational mode, the device will output serial data on
> +      this GPIO.
> +
> +required:
> +  - compatible
> +  - vdd-supply
> +  - vout-clk-gpios
> +  - data-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    proximity {
> +        compatible = "nicera,d3323aa";
> +        vdd-supply = <&regulator_3v3>;
> +        vout-clk-gpios = <&gpio 78 GPIO_ACTIVE_HIGH>;
> +        data-gpios = <&gpio 76 GPIO_ACTIVE_HIGH>;
> +    };
> +...


