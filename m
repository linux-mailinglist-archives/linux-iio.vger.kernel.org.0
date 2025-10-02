Return-Path: <linux-iio+bounces-24657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D797BB3E1B
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0882420B9C
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DBB31063B;
	Thu,  2 Oct 2025 12:23:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C58E3101C9
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407835; cv=none; b=Yk8NeOVLg7bko7oBasZGRpDuYZabGwvUVHBCuObzttANmYFjgxaK9mlQdf+S06OkYH6UsZQ3z0Qzl9TV3Fdg2CciIOxLsVX6GxfEBpt3D77QE4HeQGIhizJUbU8y5F4+FJoEt1U+KHmlK86g975NbOfm9rdpwvSp5l670zAsXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407835; c=relaxed/simple;
	bh=AC0onUH/KWR12euPrEMMEF6CxzSfY+hS18p7k/rNiSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSqViplt0UCznHQJBBt/eTVIDcZbkvnu9ccBjH1iUuV9Z9uQkdwdIqtrU7+DTRv12DIy7kdBv7hVvC7uULMfcrnN/CmItLvWabjdfZGVxrvItHBzrwQA4Z98sOKE9WNhlRDTEmmA+bo6G6UZDgyIWp+2oaXzodwExoejOFUQYz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-636535e4b1aso3547203a12.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407832; x=1760012632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHq3klzPYB8yjcAVOmszOfkdhflrtsWL0PRMLhhvkhU=;
        b=Etd7mqKZG51yRuplORAZ4dcoonKLimmYzNpwXoFG0GWEyRuYnzPqL8nrtXxnqKxoB8
         7X7u/6w2XdB2Mw3EDz3sfcFuyXsVZgiTznjp+Y8RyhphMQe3gt7c0FuoQDIaFK8L2Zz9
         eQYDZY5EWrWjzj3XHP0a6hmf+lEFKu1kIs0MNeXMG5VUKp9NRvv78ntjomfC+EGT3/dv
         H1naFZCFQo19EigKSlxZfajw/gwDXu/OqDr5PoBf8E+m5MssYfXNGVGxay62t1orKM2a
         2x6hwj9CKhhkLF5+LAIjHLBDKPzkKFZnxZAxE4/lDHhOMWAYAY9qXlongJXVNJSB6wip
         lUMg==
X-Forwarded-Encrypted: i=1; AJvYcCXmUWRE177diBse9k6KPnEMJYJu2QyBqBNzlprbBZSL16Oe6qXd0ExfXKjW7t2uYASLVwTM3zQPKPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgk6mBcurQ0JnnmggsfmwFhg4wioyPgssoGcY4P7Hl0gHazEA3
	rpC9YyJNn+277DTNI0THvAfH+LSfbaieD60v8Rn6QusdrXf4Erv/jNoAoXaa2+pRqlo=
X-Gm-Gg: ASbGncvfEcxLw8ZL/Yk9FBmAGSj1U1YuqLnX77RI0QR+GKW4vKq8eslVWjYmww7d0uH
	XVkxnzLVw/3ww9jA+rCi3Is+13n3eWzimw0LWvXFQMxAG3HiYLqdvIkIoR+TUYZZSGYM3pI+Eek
	6iQvjec93bHNT2qQmu9NbQnGaF/vdVGoJEctY0sbbxfh2RU0Vo9AYjeAyDUGZM1LyhrDjkTcsiD
	Mj9lX+xNCEgkLn4F9A4tb1ggMzgRx2dpRhp6qnDWvxYAiM1PpUG2+0Mq50U2fRS5xk/+pbcub3U
	rnVEiTnUrq1A471jo4IzCZD1GAjjPaAUy3kdemRSlehwS5a333Ns/BzpLyND77SuiJI3ikGzwsc
	RmrCc0m/DFqjviHG5JOVWA+V1vG0PXx6DI6XWyBYbjHMvHM8qyoqVBBiFQANrzD2rJQqCBp24sd
	ztCzCpUrFVHZR8ZoPga9nq91g0RvIs7A==
X-Google-Smtp-Source: AGHT+IEGWIGBVPkJkK1Pwsh0lj3e8EnyBmM6/BFyFx4BQX6Vrd50APLAxfgVMr1qwg31qdM96HE6CQ==
X-Received: by 2002:a17:907:60cc:b0:b2a:47c9:8ff5 with SMTP id a640c23a62f3a-b4859e7d4d6mr428008366b.10.1759407832026;
        Thu, 02 Oct 2025 05:23:52 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa62csm199358366b.19.2025.10.02.05.23.45
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:23:45 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso2034754a12.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:23:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4CxS4udM2fUlJYdTjUX1pqup7MEAhURJZgowXvZrY5iaa7xhwVSU+siytFvMD81I6pxnwoY5wlAw=@vger.kernel.org
X-Received: by 2002:a50:99db:0:b0:631:6acd:fa3a with SMTP id
 4fb4d7f45d1cf-6376a8cbaebmr2386247a12.4.1759407825048; Thu, 02 Oct 2025
 05:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-8-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-8-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:23:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQZzgv-St7a05Z0nr6ijDG=a5UT6dkz0apx4Ympxowgw@mail.gmail.com>
X-Gm-Features: AS18NWAPPSWmlScZEb54OFRRxiDbKu9VBgdxP80maayV33NLkOLsg7T87DMtor8
Message-ID: <CAMuHMdWQZzgv-St7a05Z0nr6ijDG=a5UT6dkz0apx4Ympxowgw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: defconfig: enable RZ/T2H / RZ/N2H ADC driver
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

