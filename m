Return-Path: <linux-iio+bounces-24555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CFCBA9033
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 13:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996627B2C46
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 11:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66943002A1;
	Mon, 29 Sep 2025 11:27:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0D1922FD
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145264; cv=none; b=cmXVIwDVSKkNLKKoTT0JQIbcl/LSnnAxWrF4SQwwOy2ivky73njdKg9XZdplvEquqsdH3/F5myUUXC5ITfEjt5ArJdIsPft2LrnhUb4Pxrwb28ggUlbcQqCAc6esa0LTflWvJbEIDY82MO1gktEPG8VFEquzQxXdUoQAIa+yhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145264; c=relaxed/simple;
	bh=rmWlDx8/WnTcn1dhj2ug2PQJyxzNzRBfLIGobT30KUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lp4hnopJyUDoLOmA22ph5pWcXyqQPokYjVxpv0xC9Jrv+mKakA6WK9aXtUXGCRP236dcxmSu46WxWVi9GALVqI2pItlqizXHBl8eQcc4qTwEeRcKZySKGw1P129Ua/3Znqb1wrg6JqoYXhJxe2gI2HOo1aKC0m7pGsGKxXwe8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5b658b006e2so1517541137.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 04:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145262; x=1759750062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3p5ZyLrRZH5goQlwa/vwelLSKRvjTSePuKZhRKGtt3c=;
        b=GupklF9wiURW2EfJaYXK6sX1Xa3ALaaXQBfTIzCBaql0kfm0LViy7Pn/LmG2blC/4a
         CseE5qBJy9jO5yBo7FZS2vouZo/Lp3kYx9EUWGB6CtHt6hxxY7dpmrVOg9F0COtohcm7
         qwyuNTuQUR6BPZ5iqZBbBO2GuHaictXV5mZ4/mDoXGKnk/3gHSEQ5vdQRLjBbt2jRYKR
         SzWyOdz1aD0vfiy8e0Zv9kDSUfH1eLPR06crB0GCLxpYpIg2DjSG6lDaNiUUv+1ydB5L
         SJq3JE4QQTVTk1Yr+M59cq2zhD+oKD1I9VabZyNXLckzv3ddSgz82/lL6OkhGNa7YgNH
         iXcw==
X-Forwarded-Encrypted: i=1; AJvYcCVVxH4IUYs9F0XE/royJOhGOqdQ9Jcz4cgAA31pFvB2HjzX9kgd4vKMY8fPIWmeMvu2ewvC27eH0GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1IZzWgZQvHXNpZ+lvwlY/TFrxv+nne7vXov07PUxbDbUoFGL
	Dboqo5B8rlBcGXUA7M+EZkCcM5tCpKw7icJkULhjyrXDXGSq/fuR847yNTnm2CxP
X-Gm-Gg: ASbGncvnL+ypSi8vwMoG9gImpFVcVjjqKuME888np7pG7mbal3XZJR+AHvHHLN9y6MI
	Y3VEq5FxdMWIFFXr4E9DhW+GpIkGfJfjQXrO9d9UJYi+sfBBlIoLjsNDjehvcWHlp8qOVKGaCOg
	1txAU4guYWZqboTxKUlf9BonY8v+mCLrVuTFV+VwihRU10Es5TjsIdCjvez7C9pc049tx0AFIaO
	9F1t0XfzxfuVqZjVIMfnaRJUBVBO90a4QY8p+UlwcKKKxquWQWKRQ5V1d4kGrV/rYq3P9Tr3WwD
	E1Km/0uoTNp7KNYF034SVMly9KZRu3qzcnklNOcwr6CXP4FJkylhZoV3SvxZtErF/0b1qkjYXUo
	Z2Me1a8IwDlvociNjtJhpZCIdsbyr+8Rsna/EsfgzSiVDsF+yf2cTfynfWCTQ
X-Google-Smtp-Source: AGHT+IGgr2yvG/fNX3R4MX3AUdlLKUCubKP+m6qg6UbAgFI0IFyDgnMaEEbvjTHlyO6KPCFmk3nOwA==
X-Received: by 2002:a05:6102:d91:b0:590:f704:6dca with SMTP id ada2fe7eead31-5acc6236640mr6168988137.10.1759145261879;
        Mon, 29 Sep 2025 04:27:41 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ae302edafasm3293691137.4.2025.09.29.04.27.40
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 04:27:41 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-580a1f1f187so1859494137.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 04:27:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXH0/0rASEu/csYkNqSQ/tR/niJEWO32fHY0lQnt0o2+6dlrByETGhPzzsB70xNE+d482l7Yom2SVk=@vger.kernel.org
X-Received: by 2002:a05:6102:442c:b0:521:7afa:3b95 with SMTP id
 ada2fe7eead31-5acd046d9damr5432533137.30.1759145260742; Mon, 29 Sep 2025
 04:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925224013.2146983-1-cosmin-gabriel.tanislav.xa@renesas.com> <20250925224013.2146983-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250925224013.2146983-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2025 13:27:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUytaS3P9UrK-bpFSP-z8ys4w37d0BWCJ6c5idnM4iNTg@mail.gmail.com>
X-Gm-Features: AS18NWB5KjkQR6-4iBJ8hPH8oU_cNUXGPtBKbJx7p1IFxsy7u1OLZLpvVydcc3k
Message-ID: <CAMuHMdUytaS3P9UrK-bpFSP-z8ys4w37d0BWCJ6c5idnM4iNTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 00:41, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Document the A/D 12-Bit successive approximation converters found in the
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

