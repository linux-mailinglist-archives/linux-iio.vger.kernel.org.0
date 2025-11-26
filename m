Return-Path: <linux-iio+bounces-26487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB14C8AE50
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 17:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6E564ED758
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D633D6D9;
	Wed, 26 Nov 2025 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqHUyOBg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440533A719
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173700; cv=none; b=iS0dP+DbLpfmYqGXBuVFibaS9BLhtmR2GE4GMffrPLiB6u/H0/LGhQizmNUm9ndrpXSYl/eLw88r7OpV2xaqURktA+IDpUahTB3HsEMvaZlAA6sW6VvJkjK5QB68AVbJMYazk2t21q22UYNsOX5xtC5eMdw2fwB9D0Vtg36rtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173700; c=relaxed/simple;
	bh=wRQ3hhxr8ynwsumdaV3tuxpgPBo2pa1cIS9EqkVPA9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7u0lebpWnCmHUgEgqQudkBiJLHXmlHjE+oZ+LnrOIykMMxVgaegbySdFKNpHjPh1qfRwXoaCzegOFovDecEcwmjuYWOZK/dR4OcU02o64OnDoIgKa35HO+HVOuQW6VxebZfjf0SwcTMIqwdyDNgdezU7OzzHBqFv683aQQb1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqHUyOBg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632d9326so41405055e9.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764173697; x=1764778497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jnrJZ3DV6tiJN7SO227QEgRI6iBE+6hMDjYZLi5jdY=;
        b=fqHUyOBgwQTXv0gxb36c6vfiVOrI4688BEnQkIJOEexfDicAyH4yamDJEhBH6eJIyt
         iCCUfwHU5hEjmlOjvIaeCbpQ7SprYT2eh2JQamjWv+jEOUAaPMibIgIwLWZX4azYy4vl
         jTuUYaPiWL4U8ER1rwsHo1VtVWigj6cG1eiHIDWpY0tEd2FcK7c3T4dYVDU8UJB6DffV
         SIcNQ/36W9BTbkGYh93QBwTrY5pbB8G0oIKyTom7EyEq3Ko/PBYXIjISJJF6ymMcy/m/
         yT4iCwHF5Q+yOYKdI2yN5FjLdXNVZLuKLVLKGJCbIaXKuM4MGcZ++i3pVcRVOXcyxFdX
         5IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764173697; x=1764778497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jnrJZ3DV6tiJN7SO227QEgRI6iBE+6hMDjYZLi5jdY=;
        b=qOaKjkQBvLbwC5mtU9C0YRj0cCEF9TIsVUUJBx/87SrVXpHgTiJClzhP4eqmTUTApn
         P/OuZG/9ZAXCRKKmsshU5gQpxymVxgNnSaW+d/+prCgK5tg0NcwClvWhZfBWKb6eYap2
         EBDjSyNz9ju0DbpzTCskZlCAAt3fEisEJe4nu22X76IN5i0z0zXFl+w1Kn+pgDizv3CW
         sfG0k0ryPfUuZlgMIMbqQLPwNLkah4kA4Zy4kvu45xDXUj0ASRNcRS1SxvLnJAEPhNgR
         9tmlvNIMGdkqyBOhY1KiQr5JzJ5WRbElBe1n5jNeGTYB4yjVH0wFwyEEuzfnDn5UGu/Q
         JHPw==
X-Forwarded-Encrypted: i=1; AJvYcCVLm4V+48lKkNB8gIzscZjsMbyyuhd6ayuVBqfu0+PIR5X5YWFbh6pUKfgDcc08ZfbQdSs4SjwC4ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaet3vFZ7FRm6Mp9N4VLIk37nhKNpCkse3P461BaMsEQzD9gF
	cAnpaiBIjdAXuvmDX2KGLHeHZ0hkwNI2gF6Cs0bAsdMRGBHmdBIdU/lT
X-Gm-Gg: ASbGncsvRXwOOlEMqyRNb/52XWlBSoyc+2ilL/8yImBJH69hFvwtmkNJDNuEnvd6SNE
	vCHL7Qr8ETlXMD0pPQCN+08IVR24k/FTYsrGYZVEAOZ+kcHieTpKRflw1o92ms+/4zc1EDMAaBY
	soNm6dqmkQt0RbN8SH1r5GhGS0WNc8sfZc4Bli/Sbxns2k9MegcG/UcKR3zFDHamrYTqtBP3k/8
	+JhGKfYu1+VgE7/2hsfkoJxdZOWFAeYnx/TtkS2LVe3Yk5GCZyLCEzc6KXsm3KRz5x8lGbVkSOl
	k+bVi1IGdpzD9fdox9Cm/uGW31/xDx4sLBSbNu9kG4Mo+G72TFx4XSaOdAmQd34qtuTJactCenI
	vr7tL1CAp2huM9/Bxml4Uh795MuQaAsMzK1g053EkKBtIWkN214wnbzd/75zfwfSsBNMBJHlJxS
	FAEfWVXaKfxFrIQQRCW9VOQXW3lyQBJMwcG+glG6jc8/6SfcsSYPDqaL1IST7cmoD5NSXtEBl8Y
	W2cIQ==
X-Google-Smtp-Source: AGHT+IF2T4LsAtdee1NZuFFVfKlipt4/KBH4/Ccs99ShvPJ6a7TsSLGj+qx1/tjpI53mxG7Y1vFGYA==
X-Received: by 2002:a05:600c:1994:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-477c0176437mr210285655e9.4.1764173696176;
        Wed, 26 Nov 2025 08:14:56 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:1025:ba00:55dc:4ccc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c44dcsm49350765e9.11.2025.11.26.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:14:55 -0800 (PST)
Date: Wed, 26 Nov 2025 17:14:54 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <uajoey6nl4nb5kbymadsd36lftg5atbhyjhp3bgu5plhuvc2ca@5h4wn5qobjg6>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-1-a375609afbb7@analog.com>
 <20251125-marvellous-camel-of-kindness-d274ee@kuoka>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-marvellous-camel-of-kindness-d274ee@kuoka>

On Tue, Nov 25, 2025 at 10:50:59AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 24, 2025 at 10:18:00AM +0100, Jorge Marques wrote:
Hi Krzysztof,
> > Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> > monitor capabilities SAR ADCs. Each variant of the family differs in
> > resolution. The device contains two outputs (gp0, gp1). The outputs can
> > be configured for range of options, such as threshold and data ready.
> > The device uses a 2-wire I3C interface.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 123 +++++++++++++++++++++
> >  MAINTAINERS                                        |   6 +
> >  2 files changed, 129 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> > new file mode 100644
> > index 0000000000000..a25af66dd64d2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> > @@ -0,0 +1,123 @@
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
> > +    description:
> > +      The interrupt pins are digital outputs that can be configured at runtime
> > +      as multiple interrupt signals. Each can be configured as GP_INTR, RDY,
> > +      DEV_EN, logic low, logic high and DEV_RDY (GP1 only). RDY is the
> > +      active-low data ready signal, indicates when new ADC data are ready to
> > +      read. DEV_EN synchronizes the enable and power-down states of signal
> > +      chain devices with the ADC sampling instant. DEV_RDY is an active-high
> > +      signal that indicates when the device is ready to accept serial interface
> > +      communications. In GP_INTR mode, the interrupt outputs one of the
> > +      threshold detection interrupt signals (MIN_INTR, MAX_INTR or either).
> > +    minItems: 1
> 
> So the wire/pin can be physically disconnected?
> 
Yes, the device can yield those interrupts as through I3C
In-Band-Interrupts (IBI), which are messages sent in the I3C bus by the
target (this device). I consider as a fallback, because the overhead for
those bus interrupts are much higher. The user can have all interrupts
as IBIs, and re-use the pins as generic GPOs.
> > +    items:
> > +      - description:
> > +          gp0, interrupt line for GP0 pin, cannot be configured as DEV_RDY.
> 
> Write concise statements - duplicating gp0 is not helping. "GP0 pin,
> cannot be configured as DEV_RDY."
> 
> "GP1 pin, can be configured to any setting."
> 
> 
Ok
> > +      - description:
> > +          gp1, interrupt line for GP1 pin, can be configured to any setting.
> > +
> > +  interrupt-names:
> 
> Why this is not matching interrupts in number of items?
> 
Is missing

    minItems: 1

thanks,
> > +    items:
> > +      - const: gp0
> > +      - const: gp1
> > +
> > +  gpio-controller:
> > +    description:
> > +      Marks the device node as a GPIO controller. GPs not listed in
> > +      interrupt-names are exposed as a GPO.
> 
> "not listed as interrupts are..."
> 
Ack.
> > +
> > +  '#gpio-cells':
> > +    const: 2
> > +    description:
> > +      The first cell is the GPIO number and the second cell specifies
> > +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> 
> Best regards,
> Krzysztof
> 

Best regards,
Jorge

