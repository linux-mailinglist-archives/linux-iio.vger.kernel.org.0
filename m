Return-Path: <linux-iio+bounces-24402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D096B99A49
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF887A3D9C
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBCD2FF178;
	Wed, 24 Sep 2025 11:47:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162102FF672
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714470; cv=none; b=bL99pufG+6S7to2JrcNIGcIz2TDlVOdv6ycp8grIx7WT6SnjRvS6SWzgSPLGlEvYy1lDwPhENHshRiIZyEAXngP+dnAEUR3od0YbNKNS/lJ5P4asLSa/IvhVK3FgXwb17WNir3xhqX5b7pnUUVgYuA4EfMzyFdYDR1rl5Y9WWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714470; c=relaxed/simple;
	bh=F2T9cBlXa2Aul5PaZEk7a5BmBGQxeyNBSTLZ+tD9rX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEUDGzamFKAV+Bv5HrVRQdlO8Vew2tk+yIOG6Y0V21mDS0KglQRrAPMRjOHqG80Gv3Hil594QHHqIylPyeNXraIID6DOsRbdRNhIri/3ctVKuFCwRET5tcFahSgMV+bSw62XH02VNsJFUVP0eB/1xQdwOFY8s7NwWRj375VKBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-90dd3b43f8eso709768241.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 04:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714464; x=1759319264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXddTGI8uaXfvwfDYhb5Vv63RMQiOgf8BHFZrk9FEJU=;
        b=YumJ8W+0GyJHXvTg20cXysHl8WIc/CHnikfvpoRkbTy0vxghnGs4ELGBpFLvdhCxy8
         Kc8M3aDm54toYEczyjSglGAKGfZDakWr1JKG8p/YISOWv9n6XfSE0/u/OrwGiANFWoED
         Ex+ntrYISynIYHXnHN1rniPh7meIQLIiLirZfuuqZCmehpgr64PvEsw5YDoxqiqYlDHZ
         xysbR0OSDLkMC3AG8gIIeZeo7Lfh87Ouh4ijfZcwXYK4SqKNB4cxoflDKWdao+bICQHD
         E6GjsABUgn+Yn3oixZJFX266TaS7SCHQrqLzTGSBViSjzmes/8+c0/V/BOu/qcqZkNQz
         gXgg==
X-Forwarded-Encrypted: i=1; AJvYcCUYeUFq9UY9hV/mUXezSfKjJsgKoo0Aeh4vbbV4eJGDK80HmZ1TN/zAmqKzK8b4+HIqQe4PsFnA1gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpREOWuO1o1SEn1/U6LeQaKnnKZr6slOSsvJ+3/wKpIyFY559g
	6lolkaqkAq5dIRV7EzwfJTF8KWWYeLuIedhaid3TbcIPACXbhHQEG1riLmi0sD6b
X-Gm-Gg: ASbGnctjBhpxZ+EXJPIEnLT4gsCxUxpOFtRE+nO/pyuZyHIcjasO1VRgbv7FS11x7Tx
	xGZzMIivkYHZus2EjKpOBUugkALg7U3MHyXQ/nSDdveaYWf/96DsndN/ChZWNe0SRaRm27A7hf9
	hiPOE2FWQOiDErYN2yXG+o8ZKO7m6VbLydhhb5Cg+PtFDhxAwXphJq4WLw3hEg2CI/LALZrXadQ
	4THJcHGzC9I6KtNKYKuB5Jvxfdy3vUwAmO28ia+u/L1YxkLG9cA+B/wTKgwmFlXw/udy9XrV7Fk
	Xv0wbngTGpViKtB/xjEFunF57tGXeZhkTGP/HLqOBQxhd+a4tTGN3AeIsJCwYctStqOkNateOfa
	r+IsSmYFaDGBetqBHRLKVkbd9Eu8UQ3+advGMT8kY7STXyUePG1cPs6wX52Vi
X-Google-Smtp-Source: AGHT+IHByRo4wEcKZj24d3T7C7RjpN5ijzoASv1eHyW6MeNSYD7vTUJ04tyn4h6l1bI5suDDT4/foA==
X-Received: by 2002:a05:6102:3588:b0:521:ed06:1fd2 with SMTP id ada2fe7eead31-5a579454303mr2201199137.16.1758714463692;
        Wed, 24 Sep 2025 04:47:43 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e82e3771sm2733691241.22.2025.09.24.04.47.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:47:42 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-583a520bd81so2231431137.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 04:47:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQArvn/JbCe8TXkEzd0o4aINpiWJLqMMEbivbvjj83N3aX5fcEm2EYS9yw8bHanIteE2sEwNAa4Ls=@vger.kernel.org
X-Received: by 2002:a05:6102:50a5:b0:59d:458d:b629 with SMTP id
 ada2fe7eead31-5a57a7cbc00mr1938022137.30.1758714461166; Wed, 24 Sep 2025
 04:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
 <CAMuHMdVEDJZ6wdGZs_CDs=jLPV1u382o6=cZ1HfKQOffGf7jGw@mail.gmail.com> <TYWPR01MB88052A16F01666B693EE28E3851CA@TYWPR01MB8805.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB88052A16F01666B693EE28E3851CA@TYWPR01MB8805.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 13:47:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_-F5S+PvPOpvJ9nE9uhR+nGsK8m3fum9OUn3r9PKJWw@mail.gmail.com>
X-Gm-Features: AS18NWBGLDA1OtvFhfhRzZsHpYufqx92wigmowEKITBkUz8CBA3NmIgNrG3GBeU
Message-ID: <CAMuHMdV_-F5S+PvPOpvJ9nE9uhR+nGsK8m3fum9OUn3r9PKJWw@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "magnus.damm" <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 24 Sept 2025 at 13:33, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > On Tue, 23 Sept 2025 at 18:06, Cosmin Tanislav
> > <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> > > Document the A/D 12-Bit successive approximation converters found in the
> > > Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
> > >
> > > RZ/T2H has two ADCs with 4 channels and one with 6.
> > > RZ/N2H has two ADCs with 4 channels and one with 15.
> > >
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> > > @@ -0,0 +1,170 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > http://devicetree.org/schemas/iio/adc%252
> > Frenesas%2Cr9a09g077-adc.yaml%23&data=05%7C02%7Ccosmin-
> > gabriel.tanislav.xa%40renesas.com%7C8c536bc422b9440a018708ddfb401335%7C53d82571da1947e49cb4625a166a4a2a
> > %7C0%7C0%7C638942974801495945%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiO
> > iJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=0zAY5VARxHP%2FN0wV7Gv1%2B9DZi%2Bg8JzBbi%
> > 2BkzCDdN59M%3D&reserved=0
> > > +$schema: http://devicetree.org/meta-
> > schemas%2Fcore.yaml%23&data=05%7C02%7Ccosmin-
> > gabriel.tanislav.xa%40renesas.com%7C8c536bc422b9440a018708ddfb401335%7C53d82571da1947e49cb4625a166a4a2a
> > %7C0%7C0%7C638942974801538982%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiO
> > iJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=VlYwNJVc7W%2BnLFKHf%2FG2Gk0HfWSsQ58cR0a8
> > fQpckwE%3D&reserved=0
> > > +
> > > +title: Renesas RZ/T2H / RZ/N2H ADC12
> > > +
> > > +maintainers:
> > > +  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > > +
> > > +description: |
> > > +  A/D Converter block is a successive approximation analog-to-digital converter
> > > +  with a 12-bit accuracy. Up to 15 analog input channels can be selected.
> >
> > The documentation for several registers talks about bitmasks for ch0-ch15,
> > so the actual hardware block supports up to 16 channels.
>
> Maybe the hardware block can support up to 16 channels, but on T2H,
> which uses a 729-pin FCBGA pacakge, ADC2 only exposes 6 channels,
> and on N2H, which uses a 576-pin FCBGA package, ADC2 only exposes 15
> channels. On both of them, only 4 channels are exposed for ADC0 and
> ADC1. As of this moment, this binding describes the ADC hardware blocks
> of T2H and N2H, why would we use 16 here?

Because the description at the top describes the hardware block,
not the restrictions in the integration in specific SoCs.

> > > +  renesas,max-channels:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Maximum number of channels supported by the ADC.
> > > +      RZ/T2H has two ADCs with 4 channels and one with 6 channels.
> > > +      RZ/N2H has two ADCs with 4 channels and one with 15 channels.
> >
> > According to the documentation, both SoCs have three instances?
>
> Yes, both SoCs have three instances and (obviously) we've tested all
> of them, as they're exposed on the evaluation board, as defined in
> the dts patches in this series.

My apologies, I misread.

> > > +patternProperties:
> > > +  "^channel@[0-9a-e]$":
> >
> > 0-9a-f
> >
>
> 15 channels max for N2H, which is where 0-9a-e comes from. f is not valid.
> Do you want to document 16 channels on the presumption that the hardware
> block has 16 channels, even though only up to 15 are ever exposed out of
> any SoC currently supported?

Exactly...

> This can be amended when/if we add support
> for an SoC with 16 channels using the same ADC IP.

We can do that later, more churn...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

