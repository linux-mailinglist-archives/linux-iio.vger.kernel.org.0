Return-Path: <linux-iio+bounces-25142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D3BE3468
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C1415005EA
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CF32D434;
	Thu, 16 Oct 2025 12:11:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D632D7C8
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616718; cv=none; b=m7DrqfyvUIjS3nfZ5HA/GqUL8nH1j4xUJtJmnt/5S3OwRlekBBCaQTonLEuV/5qmMYrlhEw/q+Y6mhdZu0aAGXbLfD6qoYdpbqG83KWo9mQPNfjCZVl/r7M8GzA7PkEGPp48SS10uRKY45XIpQydxTJs4no+lukMV1T7GiWggEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616718; c=relaxed/simple;
	bh=Qljm2z2l5uF20OnzQWwo+pu0aWLXVl3TFALx6BWruW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lP9jZM5bDNkcr2wIy3NCXCude+OnTdbGteLKhiP/S/pSi7iNmlVL70NSpUzDdyz3QvqJJArmYKqwYYflc1j2pk6adqJ/zCtBfk341geRQyMBkb0ODN5ijCAhI4mLO01eIj7M0bnh2qZ1WMKmf/aDhczSxgRBqB8v2WGZbVMPoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88e68c0a7bfso136151785a.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 05:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760616716; x=1761221516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3GThzLUFjGbl3VuQITKYi7/BLSw+ups+ZHEY60Y/84=;
        b=RMZWVtYTLryK4KXYAslrk90C8kH9YFGJqZd4IMjiaLEReiqkDWL48889eIjtLbFJO1
         WWPPqo7k/nCEBvE7Z9Lt5T9ZsZkjCxvKPQK8U5fnH0ZMzQ529/9NkwBHSy1HDcFmPWC3
         SoRglWf9vEYa2edZZyeNFGIgV1SJVG6Vy+W7F/bN6HklMcXbH8XVrUe2ZlwExxDShEGM
         dWs/ZLUwyxR/D8EtexUiQfK+EBlYdID7rKjOCDI3H1VBWMQwiXD4Eqhw6ormU4lOyPEY
         TggBlPmh1P2k+ZScGL67EBVLZm6QStAYMKWYiWOR1+l7rvB08QQm0OldWJaLYOU4jK5y
         yYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzPvQTkzd4dkeIQhXwW1/dDWj6K6qehJGWLttVHYsTF6LvAF7ZwYgZiz7IHE8nbCrI9NNJVsAC7W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZ5GTyqf74hE3ddzUSfy/FIwPCuciG7Fp3pNMGxzYGwomcayc
	53QGBXWIBkDaM8vK1Y/jh0QvylP9/W8/7Cx3h0k8S7Bqr/RAoVp+gs88G26RMmC1
X-Gm-Gg: ASbGnctSYI0/gyngjLrSrbvXMWtRd36dz3GBMDoN5A2OS33fC9YJJ1mOP5YLgj+VyFx
	t5kT9lyE7C9xuhL+VzrlGjnXQxym1K3OgdPLVddMXT0FC2RDC6rKF6zHbD9a1vEr2O/bZHNpk7T
	NF8Z+OTFI92QSxMQaZNZlbXiffRow5Doo6otCPtLlkVSWksKOIp8qsaIujpGygn671fagKlUdQ5
	zOL2xXdnx3CNvsbGjzlOhuDAhY+rnOOulQ+WERU6hKRd2zaxl9YWnf79+7CkFQqCwiEpYwkuagD
	eavEx8l8YYLMlNiFQDbG1eS9C2+yPc/LVVORxlmArLM9vrX/OBRyUqHccU6VHDeWgN2TlH4DyXq
	Z45yVVXPn2uLxFVXRtQGR6KJEe54hfZhhQnP1GI7sprSRITBOLReTSm7J/XPY+aLhEWkFUF/Oty
	KcS6jC66MO1PMF9b7ltiPFCZcMb5Bj4JtBFjuExG83WtiIyR9QNCK9oJ1HeU4=
X-Google-Smtp-Source: AGHT+IErBuGEyCFYe06loOdRpQCuHOk9RXjnH4WhnLeeceGKanhTabgQTxX2q4reqG9ho0iwV6KtOA==
X-Received: by 2002:a05:620a:480a:b0:849:7f36:bbc with SMTP id af79cd13be357-8835410ea30mr4261777285a.63.1760616715798;
        Thu, 16 Oct 2025 05:11:55 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f35c65276sm188889585a.20.2025.10.16.05.11.55
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 05:11:55 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-791fd6bffbaso11356386d6.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 05:11:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3DZdAQwukkMTN/eP/NWOH14+gjIK+18UyWNjVpQ/BPrBRc2QIxemhJxqEYoywvNFU/6GKeCWd2YE=@vger.kernel.org
X-Received: by 2002:a05:6102:6c2:b0:4fb:ebe1:7db1 with SMTP id
 ada2fe7eead31-5d5e220448dmr12281536137.12.1760616407229; Thu, 16 Oct 2025
 05:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org> <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
 <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
In-Reply-To: <CAL_JsqL1KL4CvnxF5eQG2kN2VOxJ2Fh1yBx9=tqJEWOeg0DdzQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 14:06:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUZaL6qyuTZPoRc11WSuqcoRUFNksXZNJoijTeL+vfKQ@mail.gmail.com>
X-Gm-Features: AS18NWBH0cbPp0cJrT4sY267e4E8JBEuMEr4tkAtjK9DVXEqfelKr3ZBbd1AYGI
Message-ID: <CAMuHMdUUZaL6qyuTZPoRc11WSuqcoRUFNksXZNJoijTeL+vfKQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: Rob Herring <robh@kernel.org>
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

Hi Rob,

On Thu, 16 Oct 2025 at 13:46, Rob Herring <robh@kernel.org> wrote:
> On Thu, Oct 16, 2025 at 2:57=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote=
:
> > > yamllint has gained a new check which checks for inconsistent quoting
> > > (mixed " and ' quotes within a file). Fix all the cases yamllint foun=
d
> > > so we can enable the check (once the check is in a release). Use
> > > whichever quoting is dominate in the file.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > Since you are mentioning mixed quotes, is one or the other preferred?
>
> I have a slight preference for single quotes.

OK, so outside human-readable descriptions, there should only be double
quotes in property values, i.e. on lines ending with a comma or a
semicolon.  Sounds like that can be scripted, or validated by scripting.

> > Shouldn't we try to be consistent across all files?
>
> I don't particularly care to change 915 files. And if the tools don't
> enforce it, I'm not going to do so in reviews.

Fair enough.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

