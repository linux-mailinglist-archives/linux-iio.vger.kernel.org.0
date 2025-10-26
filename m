Return-Path: <linux-iio+bounces-25445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E0C0ADAC
	for <lists+linux-iio@lfdr.de>; Sun, 26 Oct 2025 17:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172203B3BC3
	for <lists+linux-iio@lfdr.de>; Sun, 26 Oct 2025 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74C5253950;
	Sun, 26 Oct 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDlLHUmG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABB242D79
	for <linux-iio@vger.kernel.org>; Sun, 26 Oct 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496522; cv=none; b=lwGjMB3l87VfzrUkJo7aPdHcKpzO89Uws2D3sjaRM5x37dNSSmuvsmv2EAevtAKBsON9sN0NcdsjRuPdJxOwkttKvi7ZuuTRuI8I5x1Hwh3dqwa17Ka33C0vQUWcsVwjJhbLLqdMk5twrlyTc9B/oDWly07dua9NkRqlkwKEXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496522; c=relaxed/simple;
	bh=yt7o8v/fe1j3j05XnolAR9NoT6jX+EKYzwXle+WCACM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxygOhK+erKRmvuGWwlDU+SVY2y36md3T0aoinWTdmoEop/PtUz15ME9d5MNDjcZ4ZeKUD3sBOImRKnrtsvgcEUu6Wkg8HqP95PDwKI+Ffj/gltJYPETM0VYqNiYWFZAbOISy0vO1SJa1xfAxAlW+3IVs7ULJEfYLDpk/D621Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDlLHUmG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so36081865e9.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Oct 2025 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761496518; x=1762101318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WGifvjdmNS6BAEGIP9IVWYOc5+AwrG3zJ9VQpVMyno=;
        b=lDlLHUmGIy8q97s0fezXKIQs8tH8MdqaKzPiBFBOCKn1A6yGhHPATyHd8pPfyJyqIm
         bEaKAiQfF1u4ydC9OvdQYmKxsTdMqQ80VYWbzlrnu1ZBOvnq6MsuapLEJA7Pjad9u7Zx
         Un7Z/Cb3qGEzyUUiOAQYmOogXLVn5yRDiTgTUUuoZJJZerdQk1/z7/m6pWMJLWUwgVX+
         lorEp9FfUzJrR0UfImA73QyLF056MYACCVYkHjTKfJSj9STdezqsbZtN5fPCDhN/BGXP
         6P4s5V3nBWiPqcYeFvmmqtr0ck2FOAptbZU/Y1ZbKhQfVrrdnw1jQZaEZq/1HFghamds
         hxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761496518; x=1762101318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WGifvjdmNS6BAEGIP9IVWYOc5+AwrG3zJ9VQpVMyno=;
        b=O9dMo3yBsX7buCb+VOwJEt5jSbQLrZgF9z9NoKm3intcBmjmbNgRruFX6QzP9SHC1B
         hLYl8drsyo24Go5PIEuA4t3pArzKB0kYHbQ0YZ3zMsZHn+DJBXnS1mU3fj3YSAg4YkVk
         V5yUmKUSlkNN5aI9XcPjXmkhapinzbGYCCfoJtTL9fBqHoz4ud7UAd4PK/z0jM8OtkFv
         FKzQpaZ3c6piccCrSr096hGs4OTerChOtlgxQ9eGEtg5e4QNva03debsPcl/Qr/CanU4
         epVWUMrW3t76JDnTyZs/dfQFh2UYvP79kfMwW6HzB8EPVE3AtvmiqRSCY05xiLsZIlfM
         PdFA==
X-Forwarded-Encrypted: i=1; AJvYcCVu3ZZE1SbQNHX1XEZLHsCAJYlXR6KY2BUIMWOX52SFqulbjgi9sUde6Iv6N67tn7HLpPJdewYps/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzowTC9EZjesZJMLPAlzXQfHdXgXcwlT7Uv+8EmgCDNdZjR6t
	M2sB+JlsQsBozdSHKFNjcNH9Q62TqzxmKTPozdt2xIyOLuuOkTqinmm1
X-Gm-Gg: ASbGncsb1siH+9zV/gQ85tUPAQTauToTxFgte0xZVPXBbjEvmmCliBOxblH6xtIBEeX
	L0N5QLTlY/e+D6VC+V06E4p8YHgVRYxCN+On9xNu60WoqipNAVC8Fs9MmBAsl6ivhoTcAlr3sYQ
	k3IgrtcPkchHRviOovcfKUBB0BPUHH+3vNqfRzDxNA+eS/Fac+sKqPNPSmBMZkgmTSR8PURldVp
	vEBzzSa6VSU7tf/h03GyiLmGLhKYiaj2WVm0G1olPzr9JPlV5n1soBrJrYexxi8zo+z+d8XnAno
	OD4MfED5ObibHzmuKEVgIfpN4omf1aFhKPdksYSjMpthlwCgunt+37hjppCBzApljSGvy90eaG2
	BaUuQHCUsjGcbaWEAwOcjiJuVsVRd0mkHQ+XjQnmO1sScSavWTx1kyBrQEztqut/F7WJwiMqkk6
	ezn8WOGg==
X-Google-Smtp-Source: AGHT+IFWThCoxvJcBgUUBwLjwSDOlnnjJ96A1ZyZiJrxwSGOXtXBwlKYTWbldGijLHbHluRqRdy+6g==
X-Received: by 2002:a05:600d:438b:b0:475:dbb5:23a2 with SMTP id 5b1f17b1804b1-475dbb5250amr21853355e9.16.1761496518265;
        Sun, 26 Oct 2025 09:35:18 -0700 (PDT)
Received: from home0.fritz.box ([2001:a61:123e:4501:d88:2861:1686:c41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcbb4001sm45138865e9.0.2025.10.26.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 09:35:17 -0700 (PDT)
Date: Sun, 26 Oct 2025 17:35:15 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <lyu4x54r7dmtj4hcggsgzupcz6vzmflubm5bq2zafxgnyhjako@a74xbq3d6tyd>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-1-0f8ce7fef50c@analog.com>
 <20251013-step-quaintly-c58d8a1a460b@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-step-quaintly-c58d8a1a460b@spud>

On Mon, Oct 13, 2025 at 08:50:31PM +0100, Conor Dooley wrote:
> On Mon, Oct 13, 2025 at 09:27:59AM +0200, Jorge Marques wrote:
> > Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> > monitor capabilities SAR ADCs. Each variant of the family differs in
> > granuality. The device contains two outputs (gp0, gp1). The outputs can
> > be configured for range of options, such as threshold and data ready.
> > The device uses a 2-wire I3C interface.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 83 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  6 ++
> >  2 files changed, 89 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..dcf86088fc4f32de7ad681561a09bad2755af04c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2024 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad4062.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD4062 ADC family device driver
> > +
> > +maintainers:
> > +  - Jorge Marques <jorge.marques@analog.com>
> > +
> > +description: |
> > +  Analog Devices AD4062 Single Channel Precision SAR ADC family
> > +
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4060.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4062.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad4060
> > +      - adi,ad4062
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: gp0
> > +        description: Signal coming from the GP0 pin.
> > +      - const: gp1
> > +        description: Signal coming from the GP1 pin.
Hi Conor,
> 
> Please move the descriptions to the interrupts property, by creating an
> items list there. I think more information should probably be provided
> about them, than just "signal coming from", perhaps referencing the
> ability for what the signal actually represents being controllable at
> runtime.

I will add a short description of all mode that can be configured to
during runtime. Since both can be configured to any mode except gp0 as
dev_rdy, I will add an description to Interrupts, and then for each
item, just say that for gp0 cannot be dev_rdy, aka:

  interrupts:
    description:
      The interrupt pins are digital outputs that can be configured at runtime
      as multiple interrupt signals. Each can be configured as GP_INTR, RDY,
      DEV_EN, logic low, logic high and DEV_RDY (GP1 only). RDY is the
      active-low data ready signal, indicates when new ADC data are ready to
      read. DEV_EN synchronizes the enable and power-down states of signal
      chain devices with the ADC sampling instant. DEV_RDY is an active-high
      signal that indicates when the device is ready to accept serial interface
      communications. In GP_INTR mode, the interrupt outputs one of the
      threshold detection interrupt signals (MIN_INTR, MAX_INTR or either).
    minItems: 1
    items:
      - description:
          gp0, interrupt line for GP0 pin, cannot be configured as DEV_RDY.
      - description:
          gp1, interrupt line for GP1 pin, can be configured to any setting.

  interrupt-names:
    items:
      - const: gp0
      - const: gp1

> 
> > +
> > +  vdd-supply:
> > +    description: Analog power supply.
> > +
> > +  vio-supply:
> > +    description: Digital interface logic power supply.
> > +
> > +  ref-supply:
> > +    description: |
> > +      Reference voltage to set the ADC full-scale range. If not present,
> > +      vdd-supply is used as the reference voltage.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - vio-supply
> > +
> > +allOf:
> > +  - $ref: /schemas/i3c/i3c.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i3c {
> > +        #address-cells = <3>;
> > +        #size-cells = <0>;
> > +
> > +        ad4062: adc@0,2ee007c0000 {
> 
> Remove the ad4062 label here, since there are no users.

Ack.

> 
> Cheers,
> Conor.
> 
> pw-bot: changes-requested
> 
Best regards,
Jorge
> > +            reg = <0x0 0x2ee 0x7c0000>;
> > +            vdd-supply = <&vdd>;
> > +            vio-supply = <&vio>;
> > +            ref-supply = <&ref>;
> > +
> > +            gp1-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
> > +            gp0-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
> > +            interrupt-parent = <&gpio>;
> > +            interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> > +                         <0 1 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-names = "gp0", "gp1";
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f090c2f6e63a0d255a025885cc4573f5802ef159..afbfaeba5387b9fbfa9bf1443a059c47dd596d45 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1400,6 +1400,12 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> >  F:	Documentation/iio/ad4030.rst
> >  F:	drivers/iio/adc/ad4030.c
> >  
> > +ANALOG DEVICES INC AD4062 DRIVER
> > +M:	Jorge Marques <jorge.marques@analog.com>
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> > +
> >  ANALOG DEVICES INC AD4080 DRIVER
> >  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> >  L:	linux-iio@vger.kernel.org
> > 
> > -- 
> > 2.49.0
> > 



