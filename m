Return-Path: <linux-iio+bounces-25253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3DBED839
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9513A52C4
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36E279908;
	Sat, 18 Oct 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AutLg8/Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE8225F99F
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814323; cv=none; b=NMJbgoMuM21hqaMZ6r9JAhuDypuENkJfc9NBMOv+ZQoboaZUengZ5nsBiOI6owEPts4psAtasWOaNNYrSjjdAtHyOpBZrf4IH/BBFkuk8gbum0eqFJmhT2xc3TlD0I54FPq7hhXYt7+sYOe1bq2ZqOZS7D7hXtVDAmfGulFnWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814323; c=relaxed/simple;
	bh=GlkRPCPhPzOU9mLCQrN+RQspS//dfiZHnMCrJx2XjUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fL8isprnySwSMg5UllIr4B9ly85eUwD4SW6cZw3qiKYi5+09r2MIoW/oC8LUblgWhurAJc+6sI4YmukivdRcspu/B1OXdf0GKqXrVjkFqDUF6VjcAHEcGgPBLLD85sPkcV8ciNgFRhK88gseYt2eVzPKU0bLTax7CDEwBkWhKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AutLg8/Y; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-650304a822aso634680eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760814320; x=1761419120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npvxteVAfIEKzMeytJ2WmNF7D4AAPzWxw0qzjoJdKTI=;
        b=AutLg8/YD91s2Pa5W48hZ3OrDxy/xKimxKdqmnQ9L9+1JudCP6yV0yTaPsTHLj9Ng6
         ayu5A1t4VTvR2u4O4BNdk4UZQdTgAQm38dyU9qLzekSonv6ChcNGevrmv735Owp1ibgJ
         b3qopqYRQMmPrWfBrDz9c6VcFRTp7gg0RafKw5fx+C6GTJ98hkRuPXE6qL0Nj9ThxvBx
         M55Dr/GnPxZ6AJ/IGHa49FGKcK5TM3g7w7fRQG7jygaIWPB06Omtdh+ZoQfK6TqmfGpc
         X1KelEdVtXe0T6BYZEMayKWX7AYx/89PpMW5VWQhEv2I2GVGBehpXaE2rr4/KaeTKGjB
         ZbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760814320; x=1761419120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npvxteVAfIEKzMeytJ2WmNF7D4AAPzWxw0qzjoJdKTI=;
        b=Q2+p0uKCu6+I/h3TS/JC0oXYuSJZ4TFRkeKTgp713yXghC/HelEnXbr/fXj6MsTnnQ
         9EA9YH39FoDQAdj0ru+0edTS9+PLBzbyv8b0ekUmSCMF97ixgATP6PclPd5Oq50+zWGA
         5y6dyC2OL1L21ePFPRYEal4vxg2Nk8WuAJhwFB6A81oKOAVG+Xj3+Uop5dm3lSzzYqe9
         6huQjOdzCBoT6ErRu4BHb93uMzTCFvkW3uNohi71B45wfJvTqXgLDQrjqhy+JjuNuEaU
         R/M5wMXiNe0048AOVVELVgB7GuSIv7C4bAFto+GYjJIzOGFLY4S7ats3y8WwFoSsOXg9
         mc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOz/JP4eqeIhoT+7mhoWVCxjGMLarncZ87mEw5zO626HVsoyKZsU7SOaYvbJEr15KtEDOL5To19gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8URkpK6xU9hneVS40D1CTmnY1ezO2allZdJbmhWikzPhNsU9Y
	EX/x9qmM1vv7z+6YVBi1tbjx9Maj9ZpolIgcoTyqzI4K+uFJHdBbw59TfR4tjZCFb+dSmyPGbiY
	6VmKZ9l5Sg4Yi/5pogxinCQUe9qAL0Zo=
X-Gm-Gg: ASbGncuanrSLRM4E4IJZSqUsK21G6oOtGZNXkcCCLvImIs7Wx/m2B+UvARoLER81in5
	SYFkBj6yHRqUiqoQ1qrpgMO+s2vvDJ66QqfWvsjKDrFUmslADvItC/pcibdgSNfsy1b8ILqdwxU
	6+9GeCuxX/oWvM6ka01WtMV8IEPkV1lsQa9zdFWLoTdsMAB4IKrptJj7SKuTI0gTKSTOqjAOlW0
	f8mWMYc+YfKwAFTeD6ATZ5iFOw9wVYiXd658bEMJAPMR/+KIN31Pfjt1tyhDnG4n7jjo+H8
X-Google-Smtp-Source: AGHT+IHn6bYHsxvnnBm5dSpuXWjNC+PBXDBTRxFzgYuC3xttEpimkJMntVWJZ0cZXwANZryVuMF0nNeTd369Q5XITzY=
X-Received: by 2002:a05:6871:6907:b0:349:de3c:bfc8 with SMTP id
 586e51a60fabf-3c98d0c7686mr2520732fac.31.1760814319754; Sat, 18 Oct 2025
 12:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 18 Oct 2025 14:05:08 -0500
X-Gm-Features: AS18NWBGMwSlAmXgBiXSGQWXCd5xrZTGccuKfzZwiw4wGpClNDZImruw46Wm-dA
Message-ID: <CABb+yY2u=XZFdoDrjjYFhARLoaxH4uTnT=GyFmsnV_U1aWn=UQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>, 
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

On Wed, Oct 15, 2025 at 6:20=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../arm/altera/socfpga-clk-manager.yaml       |  4 ++--
>  .../bindings/clock/nvidia,tegra124-car.yaml   |  8 ++++----
>  .../bindings/clock/nvidia,tegra20-car.yaml    |  6 +++---
>  .../devicetree/bindings/gpio/gpio-mxs.yaml    |  9 +++++----
>  .../bindings/gpio/snps,dw-apb-gpio.yaml       |  4 ++--
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 20 +++++++++----------
>  .../mailbox/qcom,apcs-kpss-global.yaml        | 16 +++++++--------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  2 +-
>  .../bindings/media/fsl,imx6q-vdoa.yaml        |  2 +-
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++--
>  .../devicetree/bindings/mfd/ti,twl.yaml       |  4 ++--
>  .../bindings/net/ethernet-switch.yaml         |  2 +-
>  .../pci/plda,xpressrich3-axi-common.yaml      |  2 +-
>  .../bindings/phy/motorola,cpcap-usb-phy.yaml  |  4 ++--
>  .../pinctrl/microchip,sparx5-sgpio.yaml       | 12 +++++------
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 10 +++++-----
>  .../bindings/pinctrl/qcom,pmic-mpp.yaml       |  6 +++---
>  .../bindings/pinctrl/renesas,pfc.yaml         |  4 ++--
>  .../bindings/pinctrl/renesas,rza1-ports.yaml  |  2 +-
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  2 +-
>  .../pinctrl/renesas,rzv2m-pinctrl.yaml        |  2 +-
>  .../bindings/power/renesas,sysc-rmobile.yaml  |  4 ++--
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  8 ++++----
>  .../soc/tegra/nvidia,tegra20-pmc.yaml         | 12 +++++------
>  24 files changed, 75 insertions(+), 74 deletions(-)
>
For the mailbox changes
  Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

