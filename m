Return-Path: <linux-iio+bounces-26490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB1C8B63B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B973A38AD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5043126C3;
	Wed, 26 Nov 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+bxsOO7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063630E0D3
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180589; cv=none; b=G24030XEn8HyxQNqSS0jiktspUNSxw8Znng7n+9dkANvTBScGQter+fUKHphcbnpGD32PsqmUJTdpxM6yKH0+jQNPgtaKSSDIiPkbbvJTRqICYmKkLKfXFlf0ahuSwqWWORz6U+7NkW7xCzOdEtq6mLV9PRTFu3FZlftCLN+G54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180589; c=relaxed/simple;
	bh=Pl+yKfdcpbnHNBgfdwLgsQzNi04Qp59rbffojHUtvvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cISEG6N3CjJ9+IJH6arEPn5bv0Ig0ua44pYaEEozFh7TEGZb9rBxl0cgHeheS1iPeORVRkqKp7YEiBphoeS7QoN3ih4V7LLVgwXJNlekpec2MxUuX+01qk3Kg/56FIZSF4vhR3huY43oaXmSL8vMHOhbEDkejAgPwrv+MY5oENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+bxsOO7; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b735ce67d1dso11343666b.3
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 10:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764180585; x=1764785385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4dMIuiXbdj1Ghp209aWq6HmHbI7usMy8vWMZGu6tlI=;
        b=K+bxsOO7liJcaLi1RZjDN5auSI3UB9FZJVDJj22sapVxUQHbOcu3flyFQyYaR/QXs/
         5gvjAo5fIuzyAQQA6MmrcBoTBpwnf+YO91brOO8n+x3kg3M8xsHDXWultNVfbE6tC0Rf
         G+wgTKTiwu37HZYckJ0IkhGVvgBL7P2Mar7ZQ/yyFXPFyFomYk/GU4hchhQkVBFzY5lt
         OVbxX5+ND6uU1xlN6IWqodaUoSHHQdE7wQtWgse/+U5RI0ev0os5dJgQIERPmh/Ir3Sh
         qIgNXEpJQjDGjQgjugLe8m3BZnnOlIfjf01RpAd+eLLF+50uyHRB/W7g0x+P2NmIpFoH
         i/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180585; x=1764785385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4dMIuiXbdj1Ghp209aWq6HmHbI7usMy8vWMZGu6tlI=;
        b=fIwRD20OqaonPWuSBpQCBVwKTa7oF4/gWbAKTbdHG1Launwjm0blA3V0cvkm32UUv3
         8gNFoNIK2o4p5yaehwe7spdb3V1OSVMDIjnn4XR8qDjapmVDaJKHqiUNV6IG/+sml5UD
         a1VNMUVC0+FzF1z5qrVQUoTOxThPeDD4cqR5BQZEcmNOiDI2iV3XWHtdJdEeOzb6VcZF
         FOJMfipHdViB9VJByYIoVBXWtF5gN86zUDMZy/r1ZjO9YIWbkpt17iieSyCNesVirHXk
         Eo15DA6oF/M9h6qk2NRIUPh+7uJNHLq1zogcpjbmoCK1aF69N/K114sLf8+3/EBuxMdl
         1vxw==
X-Forwarded-Encrypted: i=1; AJvYcCXbJi2zofRBGA0jzwQ8poIawptaF4P3hBCg+GlF5D/rf1ONRwhHeeKOJiYsSuMHilieZzOF5MfVm8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmmvqO+8bePCry+0v/6T0QKK5FSXXPrXEoB7V1hqQaLWsMbADS
	wB6IyQLc1XHZMeL3a1PylqedBvM7DCh59OQJm6ANzN0L+vNCZZFo6PCAc53Bcsj2w2tMX/7r+po
	EIf+4OiPADg3NXd5v9Zv3whgR8Ezo7wc=
X-Gm-Gg: ASbGncvaerg0hXPf9djMREYOZQdrge0vKbsfRqofLT7CsoiyTYOT1hw7/zj6FIl5JIM
	NJobJO1B1PuFeSHARCSraz8JnJCzbGNB+6QESGdP7I6eC60q3x+ScrC9jI3jCcb1cP1/9O83CZK
	M6HFphu+/6F2xipF6c33oGU9Q6oZv6KrbzHeuk7DaGBUWdyBVufN/wKGWaFceDbV6lgh6JXAPvC
	SQZ8EnKVBBA9x58coVxY4YFMj2rOSXLkoQSykFw62AZaf7kx6MT6/qwAomfRPTD7K9Wjlw=
X-Google-Smtp-Source: AGHT+IH+HlmAOTw2CSce++wE8x5JhFTmVazMIoknQT/7ds8vAe1ZtR5Rj4jFKDXMkvFFgAzvU/CtgT7sRfuTR+qM3ZI=
X-Received: by 2002:a17:907:7243:b0:b73:58a0:e064 with SMTP id
 a640c23a62f3a-b76c555e621mr710667366b.50.1764180585136; Wed, 26 Nov 2025
 10:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
 <20251126031440.30065-2-raskar.shree97@gmail.com> <20251126-cautious-eagle-from-sirius-83fe52@kuoka>
In-Reply-To: <20251126-cautious-eagle-from-sirius-83fe52@kuoka>
From: Shrikant <raskar.shree97@gmail.com>
Date: Wed, 26 Nov 2025 23:39:34 +0530
X-Gm-Features: AWmQ_bk58mdHNtxVl6yaaCuArnBV_9poCSojpOQdAuwGLsTd0Ny0Rq9z1SJ1M_Q
Message-ID: <CAHc1_P7+GzZLb3ak1V2n_jLiYWH0URHGYJQd-46zcSDYoB06SQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: proximity: Add YAML binding for
 RFD77402 ToF sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de, 
	neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:23=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Nov 26, 2025 at 08:44:38AM +0530, Shrikant Raskar wrote:
> > The RFD77402 driver has existed without a formal device tree binding
> > description. With the recent addition of Device Tree support and
> > interrupt handling in the driver, it is now necessary to document
> > the DT properties used for configuring the device.
>
> This is all irrelevant here. It does not matter for the bindings if the
> driver existed or not.
>
> Please rather document here the hardware.
>
> A nit, subject: drop second/last, redundant "YAML binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L18
> For sure don't use "YAML binding" - there is no such thing.
>
> >
> > Since the binding introduces the compatible string "rfdigital,rfd77402"=
,
> > the "rfdigital" vendor prefix is also added to vendor-prefixes.yaml.
>
> Also redundant, we can see the diff.
>
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> > ---
> >  .../iio/proximity/rfdigital,rfd77402.yaml     | 55 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >  2 files changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfd=
igital,rfd77402.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/rfdigital,=
rfd77402.yaml b/Documentation/devicetree/bindings/iio/proximity/rfdigital,r=
fd77402.yaml
> > new file mode 100644
> > index 000000000000..93deaa4e8b7a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd7740=
2.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/proximity/rfdigital,rfd77402.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RF Digital RFD77402 ToF sensor
> > +
> > +maintainers:
> > +  - Shrikant Raskar <raskar.shree97@gmail.com>
> > +
> > +description: |
>
> Do not need '|' unless you need to preserve formatting.
>
> > +  The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and dist=
ance
> > +  sensor providing up to 200 mm range measurement over an I2C interfac=
e.
> > +
> > +properties:
> > +  compatible:
> > +    const: rfdigital,rfd77402
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: |
>
> Same, also a bit odd wrapping of the text below
>
> > +      Generated by the device to announce that a new
> > +      measurement data is ready in result register.
> > +
> > +  vdd-supply:
> > +    description: Regulator that provides power to the sensor
> > +
> > +  vddio-supply:
> > +    description: Regulator providing I/O interface voltage
> > +
> > +required:
> > +  - compatible
> > +  - reg
>
> supplies should be required, devices rarely work without power. If you
> think hardware works without power, this is something unusual thus you
> should explain it in the commit msg.
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        proximity@4c {
> > +            compatible =3D "rfdigital,rfd77402";
> > +            reg =3D <0x4c>;
> > +            interrupt-parent =3D <&gpio>;
> > +            interrupts =3D <4 IRQ_TYPE_EDGE_FALLING>;
>
> Supplies
Thank you for reviewing the patch. I will update the dt-binding as
per the feedback and will share the v2 of the patch.

Regards,
Shrikant

