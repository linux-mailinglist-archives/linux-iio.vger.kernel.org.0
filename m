Return-Path: <linux-iio+bounces-25305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D1BF50FB
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B24E74F70ED
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5028506C;
	Tue, 21 Oct 2025 07:47:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D74284670
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032838; cv=none; b=lv59Fs5YFNRDTAjTiqz1SYN7f2mUdApu8kcH++mXOXNg3Xl2WtK29RPvjpBVNmeju+nbWFwWnpwflRWutNmgvsz5rt9kx8CDOe2sqA4N9e2gJgHfvIq2UDgMoOqKk9P7NEGrA5YjJXUxFiV86R6x0km3BamMP7w/xunfn1HD/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032838; c=relaxed/simple;
	bh=4rLfdYNYjsSbcnQhe0QwWJ01RmTVRIBvCLsXhlunggg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezPd4kgxkTGGnFh/xXjvJmslfzXa5BOX6lcUa7It63V18urp4dEsqjLLqvxwSEOO5AFGR6+vCkvja2Ug+VPDtxQoraixY5W2+LGykwLX35kN8UQHQJ0sVKDf2dTpjW/TU32vUD/ctoiSNNQJjjwUz6eXRbNirH+lwoZnpFEosIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-90f6d66e96dso1343495241.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032835; x=1761637635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyBTSkqNbsTAr96ACFRRuX4nnSDrq9+ChtxprKl4p5Q=;
        b=hqLL+ZrNBwcCBJNnasl3Q8NGEoHFt4w9F1tA6EtmWA8fxiNsihDprqchp8T54IoFj1
         L0+dBGFIgdZopQ4l69Xe7jZBNxgQeZ1ioZhH3L7BQ9bdq4GOWYdoZZSCMy8p2SUV7oUV
         7+88LRiakWPwuimaJr0bT0QEjkQOz1av+Urogss07ULjL76VDBSKXvF1czglGKZu6uZC
         2Idk26WwcEONVn1m3JtqX0DefqWmyIM96xqHJDSHH3CnISQX1pCmgiPGgM6XLtRiznma
         2NE4vdBUMTrtmkUXaZ7UFKpl3CpwK2DoFoW1jc2QdwDkHqxSV0qQioFHGX9wB0cdsI4A
         MJFA==
X-Forwarded-Encrypted: i=1; AJvYcCW7T7NELFU2dVx7jkt8xdtz2jCSTIHG0TyQUb4m7pO4BbjOr5Ysjcro6dD2KRnDdFNQ0NNB7xV6Pv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx747YgIDOAjIAmM5eRLQ73wgxlEj7lv71Ap+z7Mcfc4rlRwaJn
	ObCRVnDk0fsFQZsHJxqAL3HMD0vjHMwIedPBB1xX6ngf3br4y0dk/wEcRjTkDdpj
X-Gm-Gg: ASbGncv/QQZnOxZUxeVU/XuNGeGtmVJt0FToiV38Wa+7AUtagSr0PN8oUuMwD8dbR6I
	Dx4MC+OpcCegCb4D7U1X5QOqkd+n9UasiqjPr6S1zbmyLroWCrgxPy1oaPuZOlsuPOPdqLoi5o+
	flzVPDtXz8vEA9Eh/hqvFJNYi3JUAfMvhj6zTeQXsLSwb2jqw9+190T1S4i6Jnl3j2hIVZgkDTr
	3sMhYeDyJgavPaCoJy3egVVxOgnx7juRkovL+Z0cn/JPm5XPYG1Iz496vkuUxdqP/0t/InOCL+8
	YBK7a5irGJE40+Ib26JEiTs4jFK2AQTz2SidqYEEYKfBjrIBzQGjj0pp8EsDXe0Y8yIh9uy2zXm
	bNQHIjeHzIKRo45O4RtHefM21Pu6O8NdIHXz8JKOWHl+yNzZgCdTtno9jM0yLxAGBD3oU4QkUlG
	BMrnkJuQGFWojPKNcvzlY9K0LEt498qGRvhdyGWg==
X-Google-Smtp-Source: AGHT+IEs3MTQ7DNxv8qQp0/bLYZTn4WeTb8idTgPlvgFPJQCym2AJ5vzI7ga0VckHcv7kH4t2fPX6w==
X-Received: by 2002:a05:6102:304d:b0:59c:4925:eba3 with SMTP id ada2fe7eead31-5d7dd6803d2mr4502984137.34.1761032835325;
        Tue, 21 Oct 2025 00:47:15 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c2794e4sm3315428137.13.2025.10.21.00.47.14
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:47:15 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-930fe879d1dso1460082241.3
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:47:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzo4jDc3L5GSTohwiG93JZNZ60yj69ApyCgT2TEG3Z6uCdUimhDmhQX76xGlw9HdnIeSteFL53mac=@vger.kernel.org
X-Received: by 2002:a05:6102:548d:b0:5d6:687:ac with SMTP id
 ada2fe7eead31-5d7dd67f9a9mr4245252137.31.1761032834720; Tue, 21 Oct 2025
 00:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-6-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:47:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDGJyp-aOWSMuPR79heRGg07VMd_F_GgV7j7yb9k+RSg@mail.gmail.com>
X-Gm-Features: AS18NWBfETG-hXu7wbnQOlGl6tEMYt_Vg7yeLyUKLs2dRaA7g8MciWHBy3GKdoI
Message-ID: <CAMuHMdXDGJyp-aOWSMuPR79heRGg07VMd_F_GgV7j7yb9k+RSg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: renesas: rzt2h/rzn2h-evk: enable ADCs
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 13:15, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The ADCs on RZ/T2H and RZ/N2H are exposed on the evaluation kit boards.
>
> Enable them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

