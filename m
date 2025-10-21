Return-Path: <linux-iio+bounces-25303-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11293BF50D1
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 149AB4F133A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED527B4F7;
	Tue, 21 Oct 2025 07:46:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4D22579E
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032775; cv=none; b=fKxfXvSPKo4qdZGh9IC1MeVQrA89//kjoq+kkuJDBahnfkvO8ZZnYDr3gulJoC6rdez3RsMKcD2wDeojFF3zEM5JyHYfgbq3nMXNAWDuoXNuA7eRM7+5NBx7RJlmvElHRkl4wlLpwIhTOdC6eyVc4X0MpOBbKElXZGu9hFPZ6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032775; c=relaxed/simple;
	bh=8b3HA5v4yZAxTJ8eIP9xopr8fWpaOCAQs9WFX5TX3YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9yUsntutD+5Fb3oEhiejTFbQWQvDCYV2hKJ8brt3scDWfEMS2kms12FePfJUSZ0LJ53uQ7B+MQv1tvVGe7SWprL3W7aTUqNTTQ+JI+NnncRGeBVX3tZkkwqEdgyBw371T6ZnZLIl91ckbeWa0azY2DIwUYQyvoEOwq6/6emnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso4782305137.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032773; x=1761637573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dz+xjmqR6cEerBTfm3rdjied7saH40mVkJYUcW/wH5Y=;
        b=fAVpbLkCEOidMnf19XZ8j5GIs5DCk9qDzUYSlGJ+zb+TQ/hqdsCvNknMgdljUDFmMB
         datM/s7t/CYRGJl8rRAbvqCVCGU5gBY/IO8FY5ahevja94Nmd6vg8Kqi5FQx/bIGj84/
         hLP2dn41zExOS1DtCiSvceiichqoce55Vrtrf89EbYxFwsyTG97jDaJZKJ5g9TxnBx8Y
         BW86CKAHtArcuSlyCSQNcxL2cu/5mX5nLmQRnEYDTNyqzufjPK1KnPXPSX8oRKkjjGX7
         7fW8FehkH/PcGAkRGk6nkJZbIc91wTt+cSUskVOSoQP04zUKoYQB3420C5njWqWbwQhN
         Nw/w==
X-Forwarded-Encrypted: i=1; AJvYcCXS0TX5lWoyLL3I4GoZtum2vb7cIx52B7+dDgya2AbFUdF08PFkO61lVWJ1ku4TYpr2KyIGS2Ff/bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXpsrV2u1I9gtvvK/F7qW17P8NEaDkcxbmqNvvQL2CZFcSNwi
	h8gGq40WGT9Bdgd+QOtYEiYZlt30lx0+uoXgxn8tvQVMZR7QHV6bhQHykqLFc/ti
X-Gm-Gg: ASbGncu4KbT7mBIT60p86e+SKwmJvDu5x1Z6hsjdqvv6pDTfda3HVe6EvSddO7qMBlg
	FqUe288kJli7MAazyrUiFxNN0lQOZmi38tLvY5aD5AQT6b+nAo8s46R4odmNGnKHr6EzNuMTPmR
	vZ6Bd8grnpuV8rDz3nyap9xYGkvSS0PvtI/kCdFRPumi7GWYU9GyhMdmWFE0e1pL5yeR2JBwmjG
	8ZiokvgVzJryrKpkccbWASDoaUqjtpvRhZodBI+w58Ml6394jC7BrrEAvI45hciD3fAvV6wnsqL
	D9Qwzo0mUSrFGyeDHGJiPi9wD7QjNnTY3q+k1Zb3lrLvl4NdVm9+TmXzre3sP/1yZLS14BXfeDe
	Ycd0tWFc21/XZ8pCOCI4GMgtrIjo429JV8qhiSCE7cs4OwBFe4YfyntkWHM//XBUnLte8NUzQ9R
	i8agaybWHyf9OC6Q8r16BJ1SBa+bLsc1RacG/HTF2tm8CGAq9H
X-Google-Smtp-Source: AGHT+IGMjSngg+joZi52eTUvsTgCK5Wfhkhg/B523iXzlFipGKPpTcM4BKwMpAOqwKSpwpki//eRkA==
X-Received: by 2002:a05:6102:418d:b0:5d6:5d9:dc0a with SMTP id ada2fe7eead31-5d7dd4650bcmr4994697137.10.1761032772759;
        Tue, 21 Oct 2025 00:46:12 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c2accf4sm3387275137.15.2025.10.21.00.46.12
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:46:12 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-932bf9d3deeso2751697241.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVB3N+E9RJptH+nwWD8JnNTfi92Cs7HTF/Ztz8Yibn8rBF9cqSUYsDTOyqV/PkFvNwEbkSdDW0Lhr4=@vger.kernel.org
X-Received: by 2002:a05:6102:374d:b0:59d:b0f7:664c with SMTP id
 ada2fe7eead31-5d7dd5ecfc8mr4994352137.35.1761032772016; Tue, 21 Oct 2025
 00:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-4-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-4-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:46:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZKDmME8vtCOR6xdtKxXO6YdR=60Nti8_Dc0SH8TnVwA@mail.gmail.com>
X-Gm-Features: AS18NWB6U78jSeH5jtDsRrmJGY1udV7PT7USkr6r0d8-dTFiq84SEiscvsgnda4
Message-ID: <CAMuHMdWZKDmME8vtCOR6xdtKxXO6YdR=60Nti8_Dc0SH8TnVwA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] arm64: dts: renesas: r9a09g077: Add ADCs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 13:14, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 6-channel ADC.
>
> Add support for all of them.
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

