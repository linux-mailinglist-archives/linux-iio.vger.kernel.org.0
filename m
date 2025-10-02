Return-Path: <linux-iio+bounces-24656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03EBB3E03
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 14:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C478116DA74
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1481D3101B2;
	Thu,  2 Oct 2025 12:23:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C193101BC
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407804; cv=none; b=kt+TPxPGq/H62KjJVYGA0iiKuPsdb+mtW/xXEryPMtIuFYKJ7ysMoIX5znVobldEXvyQhl/L/f2JXTnZRSi5mn8EWkqaVND3VYn2UCJY06IrweB6FlPWYnCPEdfYOcGS00elalP5ejH1TFgNGHySDRRxEvJnwRjgKwRg1MDkEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407804; c=relaxed/simple;
	bh=gvmbEnM8Xq9x/tMwG+SeGSBdS/Mqy/IpPOizc/FKLiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7zcBUNVIWnnYE4uZn9O5G1SB9NbpSEJv6tjsjCHjKRKwbz/gn+JKmkMpo5Bnci8md6WybwgV9P5hxJ/4l6RsrVBQKNi6ihj8oaBK8fA1IA1tleZB9ovWCdch+icV68DbdLkB9Jx0chvs7SeBSnXjy8OgEBITVk93767f0ScQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4539dddd99so198844766b.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407800; x=1760012600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQMLIxPrWBfFJ+so4wBwnJ1QOuXysLo+deF3cZFSCvo=;
        b=HDoJDYtbfoqP4hkPGL2MjEI4va4gENmfTNaEiN2GgFupp3aDeF8CdRPSkn67/Ytnbv
         Gw7HiREBfQiVJK5JFJiFXHmUFFvH18BQhRWCPW/pfN+y+eePqLZ1g6YLo/BC/530Ni3P
         0Zlcm48NqsEPPevt/CGQsRWcFP0IOpwhl85SsnBI1cmw40JKS24tTIYgrLYGjJgZzrlo
         2D3CQQcBnFi12EvUYNJSWjZg1eiqmTGl4cewdEdlETbfBEeT/rA1r6ta2/sfSgZXkPvD
         2HbGJsynF2COmXuvuRD54d87ATX3uyV6x3rRBuLzBgL3TEDNSagyVKDMiSVlVXF+Z3qh
         cLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdu28HT2LZAXKNsm3iDbMTkgv4P7R9Di8HmyYbFaebWUV6Zb53rMbXxSdSpHdyTXzaHHHtpApCH+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxRoCpBvcPPeFg8pCF30FSsOIgXKanC5I2nVwT0cRnnsA0113o
	ww3XTY/VEb7qSHKwmbE8cPDaZd0YILy4axxxC6eOV/C6N1a7uXHHncG/xHUI4C4IAgU=
X-Gm-Gg: ASbGncvyEBIJJ7dP4z9jaHxPptndeXoOyeni4BBfFLl0O4b92TxhTGeCq6ztbeoPKf7
	a1BAeERcz9pylxQEhjEGO/1KCba18g8PJMU9AaJym2utw6ToM+iciHyg8UOA45grJFYkzf/OxL6
	2+l3AkWd4WZOCvHXjnKyHq6VpuFoQ2LeqJfDQds8N9PSJvw7ekqms8YmcU3efd/RuUK0rilvcJq
	tN9h0YQU/5Pe1k1u0ho1vsNV0Xntu1jqkYJ3LUd+nqZeeUpJeUFU6gp2caOFokLxT7UZhFcfZka
	tjCVCoBbkQjhn/wtKoyZViR4yoUVSSW8QZgG+KkJyWPXimRCXJqT8oIMBozDprRoYrjcmMFr4xD
	pXQog9k1ZH8jqFguFnZOsUvJvKfoG/mLhgO+NfidauCuCXVf2gjibDJv201X4oKmw8gdcb+oFiA
	h1+5A+DXfn
X-Google-Smtp-Source: AGHT+IH1T0coZD2mDU7LU6I7VpARCd+59zUjh2vD9Mn3uewGg9zBPoMpFAtuDzzf+cx7jv/KKdVJQg==
X-Received: by 2002:a17:907:9622:b0:b42:e3fb:c950 with SMTP id a640c23a62f3a-b46e612bedbmr890475766b.42.1759407800311;
        Thu, 02 Oct 2025 05:23:20 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b74f1sm1789602a12.12.2025.10.02.05.23.18
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:23:18 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so1909724a12.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:23:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu76WXweIBIiNeqwQ5sfxoA59cFJQ9+wP7AxwcL8FSqpFjNTSoP4dxePfHyZqiWmHSUwY2pplgO+o=@vger.kernel.org
X-Received: by 2002:a05:6402:31eb:b0:634:cb54:810e with SMTP id
 4fb4d7f45d1cf-63678c7b7f1mr5768917a12.31.1759407798672; Thu, 02 Oct 2025
 05:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-6-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-6-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:23:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXD9eUSJGNH0+naHSvf8MjqZ3ctdqFp8wkrMq=qY9Zaww@mail.gmail.com>
X-Gm-Features: AS18NWAfWE-zmoZFShiXGWGVfqa0891jOjlp3tuzjqrJNKFCJ5kcTO_xUtaAquY
Message-ID: <CAMuHMdXD9eUSJGNH0+naHSvf8MjqZ3ctdqFp8wkrMq=qY9Zaww@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] arm64: dts: renesas: r9a09g087: Add ADCs support
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
> Renesas RZ/T2H (R9A09G087) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 15-channel
> ADC.
>
> Add support for all of them.
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

