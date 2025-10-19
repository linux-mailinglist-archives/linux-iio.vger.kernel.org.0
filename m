Return-Path: <linux-iio+bounces-25266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D7BEE16B
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E8C189DCD0
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656F2DF707;
	Sun, 19 Oct 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyWAA6Pz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5E1922FD;
	Sun, 19 Oct 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864701; cv=none; b=HsL9gjLIy+LpG576glL5T/DRt7PZq6/urg+SjtqXRo0ZS2/mMFeIeZiChStnkuW3m1kggXRGTqqn5bvAl1fB6Wxh90IXdZg+yDeUBz0RboWrVBOnrY2IeqKxYJCts38R2kk5DCYP+GLxXVzkHOZzM7iX5SncSN2BIgzV3I8AJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864701; c=relaxed/simple;
	bh=9QA53RxxI3fDWWXDTSxIPob1VCQQzWfdPwsbqIB7Ekw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCx/s2vRvZ8VKONJFEbETblUuEWv/D5VlhYEDIpmuwN8nwMoyfEGjwXCK258M+MSSuEICDkJHqxKQLP3UY7Ft4m8tikRa2U1hNBNyajKUjFiDFFDdoPtNM01gwnEcfGdt6tyJQHpzyxR91THnFju0QTWpjiNyWg/9DLwQniGQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyWAA6Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBF6C4CEE7;
	Sun, 19 Oct 2025 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760864701;
	bh=9QA53RxxI3fDWWXDTSxIPob1VCQQzWfdPwsbqIB7Ekw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LyWAA6PzLnj/HWuVCoFkNBi9BjEzoo5YqActO5UBI73+j2tCMm7hzvJB5QSlj6ELm
	 y0dc2ztrizauYzndrAGF5khGSYyJU5N3rOZitNSoU816X9ZebYiJ1FyVwmvjz84Ern
	 bH/t8z0SG/kQgupjfjnzM6z5ZturKvCn/wn5D2sKrCTbaFy0RzqYg2tETOnkBQgshl
	 HaJpQqyAEMtVBXqOZ/7EBPBuTn/KYk1iacmPNCwQzucBY7HMwK3fVUabguhYgGzHr2
	 nqwWZRhcoi/vwr9VO9UCDmhKpNic5I20udlRl6G2zXQbdQ9pm02NpwdIa6n4noxnSE
	 FNgAbPXbRzlUg==
Date: Sun, 19 Oct 2025 10:04:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding support for PAC1711
Message-ID: <20251019100454.6bfbc3c7@jic23-huawei>
In-Reply-To: <20251015-pac1711-v1-1-976949e36367@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
	<20251015-pac1711-v1-1-976949e36367@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 13:12:15 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the device tree schema for Microchip PAC1711 single-channel power
> monitor with accumulator. The device uses 12-bit resolution for voltage and
> current measurements and 24 bits power calculations. The device supports
> one 56-bit accumulator register.
> 
> PAC1711 measures up to 42V Full-Scale Range.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1711.yaml        | 195 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 201 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..67edd778981c2f0ed21dda02f14e383a153169b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml

> +  microchip,vbus-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the voltage full
> +      scale range (FSR). The range should be set as <minimum, maximum> by
> +      hardware design and should not be changed during runtime.
> +
> +      The VBUS could be configured into the following full scale range:
> +        -  VBUS has unipolar 0V to 42V FSR (default)
> +        -  VBUS has bipolar -42V to 42V FSR
> +        -  VBUS has bipolar -21V to 21V FSR
> +    items:
> +      - enum: [-42000000, -21000000, 0]
> +      - enum: [21000000, 42000000]
> +
> +  microchip,vsense-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the current full
> +      scale range (FSR). The current is calculated by dividing the vsense
> +      voltage by the value of the shunt resistor. The range should be set as
> +      <minimum, maximum> by hardware design and it should not be changed during
> +      runtime.
> +
> +      The VSENSE could be configured into the following full scale range:
> +        -  VSENSE has unipolar 0 mV to 100V FSR (default)
> +        -  VSENSE has bipolar -100 mV to 100 mV FSR
> +        -  VSENSE has bipolar -50 mV to 50 mV FSR
> +    items:
> +      - enum: [-100000, -50000, 0]
> +      - enum: [50000, 100000]

These range setting things are common enough perhaps it's time to standardize
them as properties of channel sub nodes (the stuff in adc.yaml).

> +
> +  microchip,accumulation-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The Hardware Accumulator may be used to accumulate VPOWER, VSENSE or
> +      VBUS values for any channel. By setting the accumulator for a channel
> +      to accumulate the VPOWER values gives a measure of accumulated power
> +      into a time period, which is equivalent to energy. Setting the
> +      accumulator for a channel to accumulate VSENSE values gives a measure
> +      of accumulated current, which is equivalent to charge.
> +
> +      The Hardware Accumulator could be configured as:
> +       <0>  -  Accumulator accumulates VPOWER (default)
> +       <1>  -  Accumulator accumulates VSENSE
> +       <2>  -  Accumulator accumulates VBUS

This feels like a runtime thing to control. To be in DT it should be related
to the board wiring rather than being a choice between multiple things
being measured.

> +    maximum: 2
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - shunt-resistor-micro-ohms


