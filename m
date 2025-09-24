Return-Path: <linux-iio+bounces-24403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AD6B99B1B
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 13:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317217A19F6
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 11:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4992FF158;
	Wed, 24 Sep 2025 11:57:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FA2FD7C3
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715037; cv=none; b=aKvojCx4h2xQqyZUTJDoK83X/R5Wek6/OA3NZEnverlKpZ7bbWQW+dE5q5pLdPbLmcKmR47Qie1AqWuOR2XJ67o9D+CTJZdETajZShUUTH4JKC0FQGexfBghhkg4fgERmsAet7VaH7VQsMziJu2weXs2jxF44nVYJprVlzsAxGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715037; c=relaxed/simple;
	bh=9tehMRz08WQLUJ/smHN3UjG/IZMKp1SRULcKii4ippo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okadjRjJC0qFWD/4QuzLLStnUn9/LLdvEMajr+IViLrP/5r3ue1hrwvr0tSC3QRLxxF5qahFK07mZ/JpasKw+GHeT+kSXtiWL+YCNHVEawU8S1q5NrK9nnZLZo1k3J3pqHX9Y5hIfUlbo5V7Eq3eDglyeAalTQ3HpWQgtW5fLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-79f79e37c04so3848a34.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 04:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715031; x=1759319831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UvM+/QBcNnuTK2u1snMXMO5HJEe0Z5rWe+7sqxETZ0=;
        b=BUMHxfYWikUrtrvdxrWP/mobkLa42R60ZyEFlRiyAFDcH56w6R3M1Hgx8tGWGqaW3S
         Kz40Miozx6bWXOqVLRNGrWh3KeDiBrHcqPJhkTHdpSDVxe7rygwh1gPuE5oh6XfBzNqm
         G/6rSbL6RIe2hTcsTj6DrS8E5T2pk7F1k/+heYUmJA2IoPW4JvdXCQ5OwOFSmN1AArzP
         nhQT0rb5zXLHX5qBEO0eIEXw5bi+M2m366rS5AVOea00mU6VNGAR9X3kTvpKdlfHoQ6u
         gSEHak9y8y4GF5ea8xoatljM0H+dPc0YQ+Bj1+103F1FejYyeyN9CEfN/m/bANeLs6Re
         cVKg==
X-Forwarded-Encrypted: i=1; AJvYcCXaG6ygX2Bvc00cNNf3nzu+SCiqBVSBG9nHmEk6hpa3cOqkhOqTCLSEDF8KseoGjEqxntbB9q0q5zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya3xe+nzufJKWkSyFg6li1RYW67KfUKBzsmLDPfcBobl/6UfhL
	KzpoCuHGr6eZMLmd/d20yI5MTMeovAPNSjbFAbEiIpLyjoXvtnxxsBMeSolQxfxq
X-Gm-Gg: ASbGncvwWJipS1I/WlsPy8l9LmDRe+NsZQLCAqTkjA0fS6RkaXP7zzUvRB6WnG94K5j
	PT5rbfLADXhb2kJq4Oi5RgEE3wYI0R/cnHkEE/CYYVEvgBm3Sa4yViu5VTuhgfg0j5cTUNd6hHN
	uLvXdshCSb+ZoHejCsCAAMRhTgMUx5CfKba1pj1ZsMUM869VFWf7J7muVw2+n0Qng3AnFyqxJAl
	F9hccyEl+DzI1r42zPhEFHz6PyeUVpWcMzEVfFsZoj9whlk82OhHmqjcllFLB+mgTxq76S+eUku
	869GoXW2bpD3zk/Pi+fZSTG9f7boAu57Vc4bG3QMm+viRbvyk0zm2E2N/9NAvbSYNiTLkj7okuR
	YN9U9iIHF4Ql1vPaOOa36Jp0X61wG3IbN5u3NHu4paE6enwiVZWN3adl/NyrV
X-Google-Smtp-Source: AGHT+IE95lWmcLRb1SXoPkHiBhtYl575r6baMpWTQqqGHpdE/Dd8Cw+pDunOSSqRPlZ3nGW5t0lVIw==
X-Received: by 2002:a05:6808:1388:b0:437:eb1d:cdde with SMTP id 5614622812f47-43f2d3f600bmr3061282b6e.33.1758715031024;
        Wed, 24 Sep 2025 04:57:11 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c88501dsm6545295b6e.31.2025.09.24.04.57.10
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:57:10 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74526ca7d64so6876379a34.2
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 04:57:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtrDWB9+E2M2HBJk1Bswa1IIVF6Gy/UFWbI1dDn5Pe5PPuue4j4854Sfnd0l6n6aOo9TECtX6KOvs=@vger.kernel.org
X-Received: by 2002:a05:6102:1610:b0:533:ff66:698c with SMTP id
 ada2fe7eead31-5a57e77391fmr2023739137.2.1758714597528; Wed, 24 Sep 2025
 04:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com> <20250923160524.1096720-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923160524.1096720-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 13:49:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULfR3PZVdh4=2QQv5N3-J8kH=3--mPS5ckkd44Xf8miA@mail.gmail.com>
X-Gm-Features: AS18NWAd607zcV9Nbln-a-J8dRoED1AjG1taSvoUWP2QDMqIsRBLiGt34BtVpEo
Message-ID: <CAMuHMdULfR3PZVdh4=2QQv5N3-J8kH=3--mPS5ckkd44Xf8miA@mail.gmail.com>
Subject: Re: [PATCH 1/7] clk: renesas: r9a09g077: Add ADC modules clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 18:06, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three 12bit
> ADC peripherals, each with its own peripheral clock.
>
> For conversion, they use the PCLKL clock.
>
> Add their clocks to the list of module clocks.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

