Return-Path: <linux-iio+bounces-25141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0873BE325D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 13:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E982C189799D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596A31CA5E;
	Thu, 16 Oct 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcNzu12O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FEE3164C5
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615177; cv=none; b=UAaK+k9Gzkjoc7IoHmW6z/4VsNeyN41oW8Dh8g5kS3z3o//bVignvmIpP0oe/wJmcQHaL5120xdwpXHeObHfVkUxjbbdtZ0PsHYZDcIDgYPV2AZevVvMAZOWSLPTd0CLOYz8e5e5k3D7nwuzxECWKMq6btLkPCEDsoNtJLpPIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615177; c=relaxed/simple;
	bh=PZizulifq2HVUabPYk3xuoVBwllBTb+3Td/PKhrD1JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ioj2mpk/CYgjomRiMXbRtUToRv5LMaIOI0XG2TrRpuNI2plOqWXl+jKTT9H5nG216kZmODGNsM1Vbgqo8T4PDtBLUwYy7Ym4MvZexua7lu5u/j/tikBGLBVrq0wudxeR2qHU/2V1qakueKKQh4+uMEJqalZG5Hg7b6CQpxLAGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcNzu12O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31CCC19421
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615177;
	bh=PZizulifq2HVUabPYk3xuoVBwllBTb+3Td/PKhrD1JE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PcNzu12ObRZcpna9g12fDshV2MGmXlk/nlZt9J4Gmm043u2IUfqaTpUe0NLoqIKXo
	 ZlOKwamdwLQcC5ORXKB8Kbz9mW/Hct4sNahJjIhD2GdahXO9nYqNgAIJfR14rdXCMH
	 lsXZR9vtIdbNSvtgHlbwubvbcL0NHyYAsJ7PFHhCITmFYDrI6WrIr6e0ocfKJBJGJN
	 3oaa0V192M4SNay3eMc1xqzXIh/HbyOrp4+L20JAFAjy4iuV70bP1B6iETxSb5AgiO
	 RMncC0YTj5H9ZvUET8qpbQn5gk2t5usy9+o82XELbU/+otfNr6E7Zz3riSI5j9wfUA
	 ivumbrsVbUZGQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so116883366b.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 04:46:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAOF4P0AoFneTJNe7vTEtoBrphRXHfuZyVGB9gwZbSkBc/7By0tmFVk2enc41q4Wtu+pbIL0M/bnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlIThmHLaaKEL5RVq5Vlb41piGQgyLr1Ya5NoVGm8sDZjj2qR
	kIKi0Wj3uB6q9/55EeYSgo1ohb2BseAqtJ3D2ky0SW2KiwykQieLZZD09qmeZDvbKJ08PQLXt4L
	mSOGi2I/lEUZFvblGjvQynJ9f4q0/gg==
X-Google-Smtp-Source: AGHT+IG/cukXQVGNzPUMXsg5+RoCAkU44f3RdQmcvQZOd/ZrFBQ7UEz32fqOhzDQMAOYnE1PB3ZCi0DPIcgQtV+P3zk=
X-Received: by 2002:a17:907:7e96:b0:b3d:d6be:4cbe with SMTP id
 a640c23a62f3a-b50aa8a9063mr3962097166b.18.1760615174961; Thu, 16 Oct 2025
 04:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org> <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
In-Reply-To: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 16 Oct 2025 06:46:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
X-Gm-Features: AS18NWBW0tx10CGZVgmCxHc_hmn_UbUIH_yG162ZfRbVO05hKCLDAYOsOpbWm_A
Message-ID: <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 2:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote:
> > yamllint has gained a new check which checks for inconsistent quoting
> > (mixed " and ' quotes within a file). Fix all the cases yamllint found
> > so we can enable the check (once the check is in a release). Use
> > whichever quoting is dominate in the file.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
> Thanks for your patch!
>
> Since you are mentioning mixed quotes, is one or the other preferred?

I have a slight preference for single quotes.

> Shouldn't we try to be consistent across all files?

I don't particularly care to change 915 files. And if the tools don't
enforce it, I'm not going to do so in reviews.

> > --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> > @@ -129,7 +129,7 @@ additionalProperties:
> >
> >      - type: object
> >        additionalProperties:
> > -        $ref: "#/additionalProperties/anyOf/0"
> > +        $ref: '#/additionalProperties/anyOf/0'
> >
> >  examples:
> >    - |
> > @@ -190,7 +190,7 @@ examples:
> >
> >              sdhi0_pins: sd0 {
> >                      groups =3D "sdhi0_data4", "sdhi0_ctrl";
> > -                    function =3D "sdhi0";
> > +                    function =3D "sdhi0';
>
> Huh?

One too many search and replace. Fixed.

Rob

