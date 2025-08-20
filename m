Return-Path: <linux-iio+bounces-23075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6899B2E71E
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 23:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A576C5E2C09
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F972E3386;
	Wed, 20 Aug 2025 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Usu88F+7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15C2DA77B;
	Wed, 20 Aug 2025 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723821; cv=none; b=JFgM/dxx8sv1yM1c9+gA/EYRi3ddAao4NYIkCZss2PLGjg9YpY/qmxwlkdByrJGyAqwcLiLsXLXtgX0vZlW9kXg8wlhPXuFb/nQa74UKdyHcKA7SgqVnU028UpHJHUpln0/ph5PYodXwt74VoCIt8Fyn4mF8aCjTkpK3gjOGM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723821; c=relaxed/simple;
	bh=UHRS/5442cN+9hgDiwQLbVU4zqoZSykqgQ4HXmO+aX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCdqAu2icvvN8Kv7q04xySeQfVpWM9uEhFBXKibQIa5vsPkjsFbOIrkqQNj9PxngdWsd/8U/XZtmJfh7Gz2IRCEFMl9s92WQ65+Ds+rEWNsMtQzwUmXznNnSCrhjp/qmLcXdIT7UeJ5a728Av5StYRjJ0r2kopG4IUE+SBfAXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Usu88F+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05074C116B1;
	Wed, 20 Aug 2025 21:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755723821;
	bh=UHRS/5442cN+9hgDiwQLbVU4zqoZSykqgQ4HXmO+aX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Usu88F+7mrW6caLPdTVs2182k3dpy4jNmv6ElSu099FIzVIXmaUD+nkJBF9pEuqHj
	 Hrc+fi5bwLXcEnUGGKImohOzOPs3HTFsTZdomIu2mXPmuq+Z37zJD38y8oC2nRkz0D
	 HivSRUzGuf4OpyRQwqsPPUviGtOXXMsi2GfQv9GLhOlU1a6wr1LsBCuP0QCXmHtz41
	 f2LM43rzRw4Yfd4LAXxohO/zenb5gHwrO3kC//+gR5PcjCdI+O0XPtePhx4sVMhO13
	 BDAyOFydbmQ4owcfPJiye9+v4pNJYETeogkB0IUaJdsf0nZsixNR00BYaUMCnUVTza
	 qX6KeTeD3OJng==
Date: Wed, 20 Aug 2025 16:03:40 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: adc: add ade9000
Message-ID: <20250820210340.GB986565-robh@kernel.org>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
 <20250815095713.9830-4-antoniu.miclaus@analog.com>
 <20250816175258.42286693@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250816175258.42286693@jic23-huawei>

On Sat, Aug 16, 2025 at 05:52:58PM +0100, Jonathan Cameron wrote:
> On Fri, 15 Aug 2025 09:56:36 +0000
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add devicetree bindings support for ade9000.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> 
> Hi Antoniu,
> Sorry I missed v3 last week. Garage door crisis ate up my review time!
> 
> A few minor comments inline.
> 
> Jonathan
> 
> > ---
> > changes in v4:
> >  - improve description formatting (remove unnecessary pipe symbols)
> >  - move $ref to end and remove allOf section for cleaner structure
> >  .../bindings/iio/adc/adi,ade9000.yaml         | 108 ++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > new file mode 100644
> > index 000000000000..bd374c0d57d4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2025 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering driver
> > +
> > +maintainers:
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +description: |
> > +  The ADE9000 s a highly accurate, fully integrated, multiphase energy and power
> 
> is a 
> 
> > +  quality monitoring device. Superior analog performance and a digital signal
> > +  processing (DSP) core enable accurate energy monitoring over a wide dynamic
> > +  range. An integrated high end reference ensures low drift over temperature
> > +  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
> > +  including a programmable gain amplifier (PGA) and an analog-to- digital
> analog-to-digital
> 
> > +  converter (ADC).
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ade9000
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 20000000
> > +
> > +  interrupts:
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: irq0
> > +      - const: irq1
> > +      - const: dready
> 
> I always forget how these work.  Does this allow me to say irq1 and dready
> are wired but not irq0? 
> 
> Similar to question on interrupts being required below, if it is plausible
> the driver could be modified to work with a lesser set, the binding should allow
> it.
> 
> > +
> > +  reset-gpios:
> > +    description:
> > +      Must be the device tree identifier of the RESET pin. As the line is
> > +      active low, it should be marked GPIO_ACTIVE_LOW.
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  vref-supply: true
> > +
> > +  clocks:
> > +    description: External clock source when not using crystal
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: clkin
> > +
> > +  "#clock-cells":
> > +    description:
> > +      ADE9000 can provide clock output via CLKOUT pin with external buffer.
> > +    const: 0
> > +
> > +  clock-output-names:
> > +    items:
> > +      - const: clkout
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> 
> As with interrupts, can we not use it at all if the reset line is tied
> to not reset?   Or is it a driver limitation (which is fine to have but shouldn't
> affect the binding).
> 
> > +  - interrupts
> > +  - interrupt-names
> My usual question on interrupts.  Is the device completely useless without them or
> is it just the case that we currently require them in the driver because we don't
> poll for completion as an alternative?  Fine to require them in the driver even
> if the binding doesn't require them.

That sounds to me the wrong way around. A driver is free to not require 
a property that the binding requires. They should only be not required 
if not hooking them up on the board design is valid (which would then 
imply a driver should be possible without them (or the h/w designer is 
incompetent)).

Rob

