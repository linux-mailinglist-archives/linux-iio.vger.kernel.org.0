Return-Path: <linux-iio+bounces-25126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58455BE20D2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 09:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E9C3BC99C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE482FE569;
	Thu, 16 Oct 2025 07:57:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F742FA0DB
	for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601435; cv=none; b=aNulR+KExn1ca7mNon1Zqcc+jijoiwMEzhIGaCYrTkQ2NMzFZlIksyWrxKLZjUqBxN2bP44zDp3IvXehi1TwMDp61DssgiY92DS312Qkllwott35gDy305EN361x4vvYmQ+IjLNIgF1vh+CSoTychKFJ2fMoF73PrTXFd9+udi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601435; c=relaxed/simple;
	bh=1eGQTAnWNGY3mGah0Neq02H/T5/f9gtIvSd+fn8FW2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyPUltNDe4E8OKe62Mnvs1qLKZ0E6dEznnbZ1QpuRByi1dH7tFb5KowWhlwvKIjyYmV5uU+wUkrWZ5BfP9YJb8dR5esCfQXryqGBLH6qehZ+Ipo6wi1PMbbbQAqDDwj7r+gMl3rs8r9ipY80wS2Fxmr0JwYKK5wHCl1vXPmpQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54bbc2a8586so124772e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 00:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601432; x=1761206232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd9DhXGFTz7VluvF3CXaOYryMfT47ujx56ubcyYXsIw=;
        b=R/INNn8kig90JiPBhzIpP8OE0XwgKO0D7CMQUEPd0NVOOtaqONM/mB60E0kEg5Gomo
         nddmZsnx+JhyCJELSDqP0a9h+Af7iyrOpp/EUYFP4rmWW0aoJnh274X7twfJtAruiyNY
         hUfBtYa4Ob13QbpQY8C910/16I0GZUJgWrM9BGuL2wSG+C1UQ19L6lJr7yP0EI3btlvj
         h6UPEb30jeWRoz2mrPQELeYx09NhLlc2o6DDIloy9Pl620+xfSF5noCkFdl56E4oaFTM
         XPPTBGuW+bqxjIGsFNjY/5moTaBEqA4BbAhjX9JXnLO/GgrTJu/0qSqOu46bOZMr8U6b
         4+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXrrhfTIfIAPxEM1DxkNHLwrbIVSfqoQpE9bLaKkYYrpYXhJfJpEws24UgOjHzibabZIzhcSNIGRrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTjv9euMqPtdpy1+lmRY3NpnzyOg68xFWhUKHJiw0LyxvdlImN
	pKXrcfh+SKbi0mGM4sKXnePLyOk17hbiVh6dbxHfjgKfUyBkRL1i2LxtpWTIG7fi
X-Gm-Gg: ASbGncs2jkhqOAwM94eGu4H3puumLhoqqBkw26bF0vYvrKkOGt8EnA6W+njGlqcDJ21
	8cRjKy/f3u4nx0Ez0fnPL5G0GlFU/A6CqYWp0ELQUwH097uEVAzusUp4KheSoc4b8IjQ1pCdfg0
	KCPDxQ1D0CjbnBeXDDTVwmhErYLpcRGtu4McFI7iUCQnMd7QRXc+5GJ2/VrGvk4kuoazDLGLmmN
	LrF5a5wZlBxsv1o1Zz+18BPk0bAY49+Z2VBxM73n9YnwvEur5/LvvhMr+IegkKiT2wDgB8dGdEK
	0E4LIOeFlG9+5Q7+Nnvpni+TxiOVaNH6QkhawfX3vjLtlxiia+2AADppkkOzwzsMCh7MMDbAOGJ
	+9M/nIvwCIsYtqR7IIJz/Km90XAndqQE+SRY1P+Gt8Sl+aSCgHJ3MhY782QWWcdsMXS/eV4vozQ
	rBhJw7Mx1JSZb0ZNotthMtHoRcoIwMP1egH12MTA==
X-Google-Smtp-Source: AGHT+IFVqkEfLfTGvdmIGJBYdWliYvB0NgYsfvwuG94uEyOa932xyvoRuQxRLgAADufDrFdCRsjB+A==
X-Received: by 2002:a05:6102:162c:b0:5d5:f6ae:38bb with SMTP id ada2fe7eead31-5d5f6ae3ba6mr8838169137.36.1760601431801;
        Thu, 16 Oct 2025 00:57:11 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9310b284ef5sm17143241.8.2025.10.16.00.57.11
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:57:11 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d61f261ebfso157936137.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 00:57:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMuDnhMZAMe+C61Slnawpg/CfkR6vrqJQ6OwEIYRdB7/zJ3LUJow93FHxjhRcoQ62GDP46R1z67MU=@vger.kernel.org
X-Received: by 2002:a05:6102:512a:b0:519:534a:6c20 with SMTP id
 ada2fe7eead31-5d5e23afcd1mr10705349137.30.1760601430958; Thu, 16 Oct 2025
 00:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015232015.846282-1-robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 09:56:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
X-Gm-Features: AS18NWDjBoTWi0arzS-uHQaIyzTZ8PYUb4ECqZaEUF0sSO-4JEe-m7M7qjhxsvY
Message-ID: <CAMuHMdVBDN8-gWVs1f=1E2NgD6Dp4=ZFUnyzqHaQj9JWPpZepw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
To: "Rob Herring (Arm)" <robh@kernel.org>
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

Hi Rob,

On Thu, 16 Oct 2025 at 01:20, Rob Herring (Arm) <robh@kernel.org> wrote:
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for your patch!

Since you are mentioning mixed quotes, is one or the other preferred?
Shouldn't we try to be consistent across all files?

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> @@ -129,7 +129,7 @@ additionalProperties:
>
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>
>  examples:
>    - |
> @@ -190,7 +190,7 @@ examples:
>
>              sdhi0_pins: sd0 {
>                      groups = "sdhi0_data4", "sdhi0_ctrl";
> -                    function = "sdhi0";
> +                    function = "sdhi0';

Huh?

>                      power-source = <3300>;
>              };
>      };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

