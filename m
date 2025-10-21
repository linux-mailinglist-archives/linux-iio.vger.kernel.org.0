Return-Path: <linux-iio+bounces-25306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60208BF50D7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 09:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A718A1072
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F330286417;
	Tue, 21 Oct 2025 07:47:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A6285C85
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032862; cv=none; b=aB4BxX86oVwlp70bHkMuRrcohouArNkfya6GsdIokDV1uAncqVCB1IRjxcoCb0MCvgMl3o7PI5s5wcFOqPGQYi7j9fg7hEJrITG501scrzjW8/dym+i3SqLGB5fgt96DSMV1Z++W8oWls+r2CCuvQucQY1cmO/nkenq8gs7eYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032862; c=relaxed/simple;
	bh=LgD3fmQmo2Vj3ctKAuzbU8OX0SkBcW7bbU6i+teUALM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI9Nuz0p7u3M60vtu2tNa7D1Zza4rDqWphTDomxlPJN8N6Wqu4Iz0TnCtM/NV16UenBLdztJsPBM4Bq29EeXUKQ8pp3Eil+BrEAHoqsYeeCW9xPx4Mhej+sfrS8B+SB5HGPkS1AP8l6Y1Y2S1uPdbsVxBKKKd49fuIuL6kNqALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5d3fb34ba53so4492716137.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032860; x=1761637660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RAzApxyYEKbjbp0xhiRiTTYJ8A63jge42aUGr1Ascc=;
        b=m48Utd8i+sdXkWkVNlItIQ+Y010aL+1FnxfIf1wNVHBCHOoKbhXtvi/PjTp7B1Ik79
         CaKlyLUaGXdMgh4RZH3MQO0mcaBobOlaBp85ow88O1qgyqrlEx3VQnM+bD8cWbPc2m0n
         VMHKoB9l32BzkRB67g/Bz76w2Fxko2iwZBAggMzl1A3CvaXuXnwnr71heJ6NJ/i8olDj
         4z3KgcwbA9JTyaJi2XBxkQfoT2fwMeGoVNGhUCazbEyFRcy3rsVZwkhLxmMVBYxWye4K
         KQLfQ0Op3iZv/VLADtU5AP3Jg3fumwTrtL7w+2eqb+I14gQorl40D57gN0MOzXu9sXCC
         1eBg==
X-Forwarded-Encrypted: i=1; AJvYcCX3J4zyhKUWZIxIvyz7fdQO/791MltYwZI83H2Dj3Lo/BNz9sPBd1Mt+R99HKR1/2chMo+PJTvu0Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6pcMtxhAPzILEVUW3VVU8uSgmtltceW3FBH/zkExU7JYas7j
	/conoggL6II8qG0vwu3hUnJsEHqF9Yav5zREK/43eOps2OEWVue9KlnFM2nRsofM
X-Gm-Gg: ASbGncuQkr43fUXsRNX3LfliVl2KOE+3rnReVKdswwQKJx/JtjADmZRopILfbjXAXQw
	C67BM9PYFyVq27e9xi+oL5Kc9AbtyWQiJZnYEUM39EXJYSTnmd3WyzxkfLh1e1Pni+0kP1eQAdL
	x9HZ+KXsFtfazvaIooLiOjhB5Ae8XDFPVUfugrhNqms07oajv2orsWtRCNqwWkDqjZTKtIz7VfA
	HTSSlPOAwIPL/IEpYY6NU8GSx8kj1EhejxpYTWajTUM5/iYhHsqITst0RshP4E8DlzMnDn3ppim
	hU8hZt5x78wNut102lNhx2oqAHqbQjEk2eDXAIDsOLQPehT4UDYVTQZliN/na8weNcLpnJZjnFr
	EAi4S1KDDnPx9r5xXZd7FRm/2wH3VCxE4DQ1V3Idmcng3SfOVSyp1A/mAlDbDJ7NPlZ+SH2C8Sg
	jKd5K2zErVWG+ebl8WwbndSFag7X79nJzHHk8XNg==
X-Google-Smtp-Source: AGHT+IEIip9PfLqLuNE+1gsPzmJKWleAOqh0UTUmSTmaeOsLggltwQANSLctBL3Bdxt5KEKOtUXEgg==
X-Received: by 2002:a05:6102:40c6:10b0:5d7:dec6:389a with SMTP id ada2fe7eead31-5d7dec64177mr3851073137.9.1761032859561;
        Tue, 21 Oct 2025 00:47:39 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c25dd20sm3339820137.11.2025.10.21.00.47.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:47:38 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5d967b67003so3365373137.2
        for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 00:47:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrLzCca2puHjvod850RLFbfT2T+FBIv+x9jnijJlzB1tzY+BAJO51vC5JyXn8ORCk/dCZB5noKfZQ=@vger.kernel.org
X-Received: by 2002:a05:6102:3594:b0:5d6:218c:c737 with SMTP id
 ada2fe7eead31-5d7dd55ac83mr5106961137.7.1761032857706; Tue, 21 Oct 2025
 00:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251005111323.804638-7-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251005111323.804638-7-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 09:47:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVU7dxJdZ-Fc0+KtH=vXt4iTA+uzEvAxu3xRR8KSVgg6A@mail.gmail.com>
X-Gm-Features: AS18NWDjbmYiPPiW4sH01TT_kOMR7nPnFgygby00VrAZBRa3sfL3fwyjeGQ-q4o
Message-ID: <CAMuHMdVU7dxJdZ-Fc0+KtH=vXt4iTA+uzEvAxu3xRR8KSVgg6A@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver
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
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs include three
> 12-Bit successive approximation A/D converters.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Enable the driver for them.
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

