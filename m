Return-Path: <linux-iio+bounces-14577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFCA1C3BE
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 15:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CD6188774E
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21B282F1;
	Sat, 25 Jan 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh2huSgs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A21CF96;
	Sat, 25 Jan 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737815091; cv=none; b=nA9Hx31uRdeVMETnk8mrQNwYFD1zhRAJk3Qt0bCJXhlBsnlgTJj+L85Yd2y5jdgW4wsAxJPciLy/f4tvwoyAgbO5jRm1bLH/qSycJqVxwt4FVAeU03MVw5oZWlwqCxfBYCNEFnTKy2HFAUkWftriew1Gj5ZwJJ9LDakv/W23yQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737815091; c=relaxed/simple;
	bh=4ZpfPj5tJ1/E4YnacI0pM0eJjvTsk+r0AC0QYhR1V4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8u9brXuzMBRQKKSLJzjcjQyA0NcAaB1j6uB/eIc5fzujS4iE0Ig4V2q0cjx25yNApNLfGkljVtdykEjtknDdJoCoVuhIy2IfBQLrxfSClGGbf2jMw0tr7JehBiwf410szm83XrrEQgJBNiJHLz6dun4omki0T//p645U3gSWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh2huSgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FF6C4CED6;
	Sat, 25 Jan 2025 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737815090;
	bh=4ZpfPj5tJ1/E4YnacI0pM0eJjvTsk+r0AC0QYhR1V4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sh2huSgs6K0O6CPaBqwgScWIeQLP3nikmh0Lulxpf0Ms3uTIP70NR+Qd2fxgib4kh
	 tK1/hPpT02Fxrc4mMeH1I6QFM3UCqaxR3j1noXb20rsvVgdqmBXFt9qONXW1FpKi4n
	 Nu4dJBXrj4msKAPQV2xkaLql99METXEvuNrVHeYntRBYDq7ljerVWdC1KNO8YiUy5h
	 1AeysdaCxti3HlkTF70IpSEnAN6lPyDZcZShplVYOgsWpLhjA6aEUFtrd4Na3925PC
	 5QqP/oYLGfPvvEZtDiCySxXmQ5zHbZF88en3UsM+ppEKCQY0gBROTDmb8fkNV1JAAa
	 GIIVIguqkVY+Q==
Date: Sat, 25 Jan 2025 14:24:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add AD7191
Message-ID: <20250125142436.5e0b8661@jic23-huawei>
In-Reply-To: <20250122132821.126600-2-alisa.roman@analog.com>
References: <20250122132821.126600-1-alisa.roman@analog.com>
	<20250122132821.126600-2-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 15:20:39 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7191.yaml          | 175 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 182 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> new file mode 100644
> index 000000000000..c0a6bed7a9cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7191 ADC device driver
Not a "device driver" so drop that bit or say 'binding' instead.

> +
> +maintainers:
> +  - Alisa-Dariana Roman <alisa.roman@analog.com>
> +
> +description: |
> +  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
> +  found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7191
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Optionally, either a crystal can be attached externally between MCLK1 and
> +      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> +      pin. If absent, internal 4.92MHz clock is used.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: AVdd voltage supply
> +
> +  dvdd-supply:
> +    description: DVdd voltage supply
> +
> +  vref-supply:
> +    description: Vref voltage supply
> +
> +  odr-gpios:
> +    description: |
> +      ODR1 and ODR2 pins for output data rate selection. Should be defined if
> +      adi,odr-state is absent.
> +    maxItems: 2

minItems also 2? i guess we aren't coping with situation of one pin wired
until some board designer decides to do that.


> +
> +  adi,odr-state:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should be present if ODR pins are pin-strapped. Value corresponds to:
> +      0: 120 Hz (ODR1=0, ODR2=0)
> +      1: 60 Hz (ODR1=0, ODR2=1)
> +      2: 50 Hz (ODR1=1, ODR2=0)
> +      3: 10 Hz (ODR1=1, ODR2=1)
> +      If defined, odr-gpios must be absent.
> +    enum: [0, 1, 2, 3]
> +
> +  pga-gpios:
> +    description: |
> +      PGA1 and PGA2 pins for gain selection. Should be defined if adi,pga-state
> +      is absent.
> +    maxItems: 2
minItems here as well I think.

> +
Jonathan

