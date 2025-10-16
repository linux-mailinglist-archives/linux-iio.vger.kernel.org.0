Return-Path: <linux-iio+bounces-25153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06641BE47A2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6946D5869C8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A01FC0EF;
	Thu, 16 Oct 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjyQeO98"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732AC32D0FA
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630832; cv=none; b=U1Yhol6cqqaD3Cf7EnZsg+3mnkniUgnBm0Z56WDHzMSnAJHJn/0B931GP5I9akgnYzq1EKqNAfVyt5e9/AShji/44UJL3dSoSMnPLvOFPpHSNPEJ2+yOhVmPQQFktQD32W4oCCZynwy+t2KhmrBTMilBjCyYPTfV7+mbKnvxzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630832; c=relaxed/simple;
	bh=Vjr9YRqSTqtgmJiKQ524agy+ATb2FxOdcZqgwssjAqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RK7LZ7O9LGw2D/R+7TRid7VSMVykPaMkasrSPBEt0jiVWAF6yj6vk/9kxCCvtnwi+Tm5SnjMhF7r9osOjGs0yoGM1HyZjadmqmCvP8p6OGpnzV/KrI1cQGdVXGhRYcx7gbTpUtVp8+6A0kH1NbuM3ZTlxjVaRc7/FHZNf0SK2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjyQeO98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2FEC4CEFE
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630832;
	bh=Vjr9YRqSTqtgmJiKQ524agy+ATb2FxOdcZqgwssjAqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gjyQeO98N1+v0/URF99aBx/z8ZAnq3UKJU6NpkHELvJ36uYHKt4lmPSs2QAE7FwK+
	 sewCJPl1cr7l5be78bRAxqri000zxK/EScX2JQ4xjThRc2kWtT0iBOS8j7tNAtA1b4
	 AWxXUOSPYz+mlUwXNsp+ICUAZ0QVoFFE+0Gc8jKJViSdnewsKNdgQrc+FUoI8KRhh1
	 sZEMf3sD4TloKq3mUdm/gFjbgzvkP0kNKv+5VnwJF9aValAdVhO3KchYbLuFfnnZ/+
	 4K1T+NoBtsRDAT4pT6/Y6moRm2OCwGopIWsb8cSXjpwfjEFu1CAoJX2UfvPbIkz69R
	 nrLQqyrkx090g==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3ee18913c0so170208666b.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 09:07:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2BGr9CZnivc6cZm5rnXZb0ggeAaQg0hHt9AT26bVXAWAEEIRCaTO4FfqEqZskM2wGvt6LPhCSaXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UMsw4T+mNRGYiSTdfBt77WM45PTuADTk4MJzkfXC4+4z9ely
	TiYuWqHPHAoCCpnDNvwlRFimHHjkP66vQJQhtzCr//LeMyDTX8VhYlF0MsIf2zbv4dcxRmx9DSy
	6lm3qDmEvCBDcJkS9XAbNVjQ7CpGwTQ==
X-Google-Smtp-Source: AGHT+IEwUNFtjfemC+H8YbxetDx+/1UO/8iQ2gyCTnZPC0wHrc6i2JvE1D+ajYJoJm5ZfKz4z3qtGvXJ7TTBCQJq2aU=
X-Received: by 2002:a17:907:1c85:b0:b3e:5f20:888d with SMTP id
 a640c23a62f3a-b647304516amr61378866b.27.1760630830062; Thu, 16 Oct 2025
 09:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org> <aPERZ/IpjAhD2sen@lizhi-Precision-Tower-5810>
In-Reply-To: <aPERZ/IpjAhD2sen@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Thu, 16 Oct 2025 11:06:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCCBHp6vMvXdh39hpdiMg-3Kr3uB7KMFauCfYM7rYSWQ@mail.gmail.com>
X-Gm-Features: AS18NWCmaqStDDMgrLFaOkte03G1gDmgUst_qjRWdTXsAn_QVmilmfjOPWrs-c4
Message-ID: <CAL_JsqJCCBHp6vMvXdh39hpdiMg-3Kr3uB7KMFauCfYM7rYSWQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: Frank Li <Frank.li@nxp.com>
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

On Thu, Oct 16, 2025 at 10:38=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Oct 15, 2025 at 06:16:24PM -0500, Rob Herring (Arm) wrote:
> > yamllint has gained a new check which checks for inconsistent quoting
> > (mixed " and ' quotes within a file). Fix all the cases yamllint found
> > so we can enable the check (once the check is in a release). Use
> > whichever quoting is dominate in the file.
>
> Can we simple require only use one of " or ' to let everyone follow easil=
y?
> support both " or ' is unneccessary options.

I don't really care to fix 915 files. And don't send 100s of patches
for me to review either. Given we've got 5200 total, it's a good
chance folks will copy the preferred style.

Rob

