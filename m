Return-Path: <linux-iio+bounces-16565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3BA57B78
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8913ABCB9
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC2A1DE4E1;
	Sat,  8 Mar 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvtYpt2O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5781167DB7;
	Sat,  8 Mar 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741446661; cv=none; b=uVFrxMwpDlxEgxl94wpE5vs2W1cCN34E6Tj1VeRu7NLKXy8TbEKKZA60s2/tLORXwO21HAKh6WytRD3ZPgpk5sftpCvXCO2OHpu/7BjYnfcChvL0nunS5tRJ1xNUhCJJq41nw5xsaunno6iOuY/jhyZbmdx6jZ/kTOVgVpbM3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741446661; c=relaxed/simple;
	bh=ArA+yLm4KsLMoiCtKbk73+ZCs0tt3dk6SWQpgTyh7Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtdKKSZeumoa7Bojw/hYqq7D5zMXFMaeJIJKKKdKCSAYL9m/is/UzxOS5wpFueA9BNAGwKwmYtafPcJ1JjWxAbjFJlF4Dazfz5VMCusHvhauGjsTieoQhveQtGEOPcSUbYLrcBcQ8NBDjCxFjMa0NyMuy+aY7+FVYVSWikbA/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvtYpt2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DA8C4CEE0;
	Sat,  8 Mar 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741446660;
	bh=ArA+yLm4KsLMoiCtKbk73+ZCs0tt3dk6SWQpgTyh7Yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvtYpt2OnDCsxhUdjByS+dIxKO3hFGcMlVP2T3Q7Gyl819+nyxpzRrw1RwC8PRHwf
	 Os2Kmjv8d2mbE/vkYxxbilxk4Fn4FpY8cZUSievaMW7h+sHtpJReofCPWrGlaxaqS6
	 DM1I6bs4YIscBHvZ9JbU31tBwzaPTD+1mvwShY4buRcSqsmmhcjBJZAE+TEByz1t5L
	 4b3QnH/rtJOQvuCXvCXPc1ZLVBy9rmI6ds87feROih5QmAO863KQgYNyKmXrsCK86r
	 kAmEG4+movLZrzYPApbMvudx+1EASDWNs35H7AA1k8D9GfTg6BOyX56LKlENj0edKf
	 /4k/i+vavGlpQ==
Date: Sat, 8 Mar 2025 15:10:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <20250308151055.35cb809e@jic23-huawei>
In-Reply-To: <20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
	<20250306-iio-driver-ad4052-v1-2-2badad30116c@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 15:03:15 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> Add dt-bindings for AD4052 family, devices AD4050/AD4052/AD4056/AD4058,
> low-power with monitor capabilities SAR ADCs.
> Contain selectable oversampling and sample rate, the latter for both
> oversampling and monitor mode.
> The monitor capability is exposed as an IIO threshold either direction
> event.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4052.yaml    | 80 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..4602f1f0184d58f33883852ff6d76933758825f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4052.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4052 ADC family device driver
> +
> +maintainers:
> +  - Jorge Marques <jorge.marques@analog.com>
> +
> +description: |
> +  Analog Devices AD4052 Single Channel Precision SAR ADC family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4050.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4052.pdf
It's this data sheet that I opened.  Seems it describes things a bit
different that you have here.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4050
> +      - adi,ad4052
> +      - adi,ad4056
> +      - adi,ad4058
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Reference clock
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: threshold events.
> +      - description: device ready and data ready.

People have a nasty habit of wiring just one. So use
interrupt-names and let them come in any order.  The driver can require
both or a specific one if it likes, but in future we may need to make it
more flexible and the dt-binding should allow that.

They seem to be GP0 and GP1 on datasheet and don't have fixed roles
like this implies.

> +
> +  cnv-gpios:

Not the most self explanatory of names. I'd suggest a bit of help
text for this one.

> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 62500000
> +
> +  vdd-supply: true
> +  vdd_1_8-supply: true
As per other thread, supplies like this normally required and this
one at least doesn't seem to exist in the datasheet I randomly picked.

> +  vio-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +


