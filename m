Return-Path: <linux-iio+bounces-801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF380BB52
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAE3280E4A
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246911C9D;
	Sun, 10 Dec 2023 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqVhAuj7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEBD11725;
	Sun, 10 Dec 2023 13:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59B8C433C8;
	Sun, 10 Dec 2023 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702216178;
	bh=1XDcde1nT6h/mhKX1U8yI+hFvRKUQSwKWXMpIAW718Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CqVhAuj7HtHzXxwYzJ8KKGtJY5m9gO88bSyziTt3Cd3WpB53sdy4YuC5/KI3HA4X+
	 5ZUrgHB52fdsNzE9sdGyMIhqEmTMyIKRv/doimHOdlyCEjb2AOCiGhR1zsDJXV0JrP
	 yD2dLL1rTtsdB9d1dA9XUsHRx5tTacSX6q8NrCelzsfsIB4LLYFNvdjwSxe55ytKz+
	 6DDe1Kg2ZzjRqyfHTA4EYV+w7MFydplhYL8zeCMrZWZsJVQ/GhSlZGAD+eeBEG+nSl
	 TrbeCwRCgyDKBrnJtYcwC6XBOnzhoRtKkPuqfEdcwOL/XuwvVgIM5GMgvoX3Zp3LrN
	 1B9NCnJKqZcwg==
Date: Sun, 10 Dec 2023 13:49:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add binding for AD7380 ADCs
Message-ID: <20231210134932.0bb429f1@jic23-huawei>
In-Reply-To: <20231208-ad7380-mainline-v1-1-2b33fe2f44ae@baylibre.com>
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
	<20231208-ad7380-mainline-v1-1-2b33fe2f44ae@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Dec 2023 09:51:40 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a binding specification for the Analog Devices Inc. AD7380
> family of ADCs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

Comments inline.  A question for Mark Brown on the 2-wire bit..
Do we have existing DT bindings for devices with parallel spi data
outputs?

> ---
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 102 +++++++++++++++++++++
>  MAINTAINERS                                        |   9 ++
>  2 files changed, 111 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> new file mode 100644
> index 000000000000..e9a0b72cd9d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
...


> +  * https://www.analog.com/en/products/ad7380.html
> +  * https://www.analog.com/en/products/ad7381.html
> +  * https://www.analog.com/en/products/ad7383.html
> +  * https://www.analog.com/en/products/ad7384.html

> +  adi,sdo-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ 1-wire, 2-wire ]
> +    description:
> +      In 1-wire mode, the SDOA pin acts as the sole data line and the SDOB/ALERT
> +      pin acts as the ALERT interrupt signal. In 2-wire mode, data for input A
> +      is read from SDOA and data for input B is read from SDOB/ALERT (and the
> +      ALERT interrupt signal is not available).

This is fun...  If I understand correctly 2-wire requires two SPI buses (or a complex
spi controller that does parallel serial channels).  What would description for that
look like in DT and can we not establish what is wanted here from that bus description
rather than an adi specific property?

Seems a bit like parallel-memories.

Mark, any insights into what we should do to describe this?

> +
> +  vcc-supply:
> +    description: A 3V to 3.6V supply that powers the chip.
> +
> +  vlogic-supply:
> +    description:
> +      A 1.65V to 3.6V supply for the logic pins.
> +
> +  refio-supply:
> +    description:
> +      A 2.5V to 3.3V supply for the external reference voltage. When omitted,
> +      the internal 2.5V reference is used.
> +
> +  interrupts:
> +    description:
> +      When the device is using 1-wire mode, this property is used to optionally
> +      specify the ALERT interrupt.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,sdo-mode

Could define a default of 1-wire?  Simplifies things a little in the bindings.

> +  - vcc-supply
> +  - vlogic-supply



