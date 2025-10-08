Return-Path: <linux-iio+bounces-24844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC78BC431F
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8230818940C0
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD9A29B778;
	Wed,  8 Oct 2025 09:51:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B62475F7
	for <linux-iio@vger.kernel.org>; Wed,  8 Oct 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917078; cv=none; b=lC7bYXSRWT5qgC57RSy/tFUbLlwDQYIjIKEkbdUrTYR+emF4RkeB4wQl4XQd7IcRCmhxI5K8C8y7eNa4HW+q6mQ5cMzNUqy6tQpGp0orM0vrCZweR2dqlNEKWtZQmIq3mgX+VEcqCjw5W3BxUpeEWUI/7PkJ4Y4M45009kleG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917078; c=relaxed/simple;
	bh=r+ToGzTI6uxWEPYumm60pPHWI41nkxsIjrp4Zp1EsqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxoGpLFXdG5m/FOeFbkBlWo471Y2D904vNYH5zqmQma21zk9Q3EBWa5azrm29DgTJm4qnkakVO6um3eu9KoaJWXSPhhvt0mtnK4QfXMQOc2/hFiHO+Kxj5/lGgvtlrna/gpbFiBW6Z+ehavDDJJIF3NYLpe4HA4FpBsun/Cxc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5c72dce3201so3041600137.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Oct 2025 02:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917076; x=1760521876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G09dlK4ttSR1bBxdlZNpESQsXtEQhLpmRygu9mDDuZI=;
        b=ezMCOXFgDn7C7yzaeoB09ZSwia0naV54UZ6vlJNQQ2FV6XLZY2GO3btpW55hyA9roe
         s5i7wNJLqw8pYsoZFz8Smf0CAvLJaj76RnI7/J/VPMf7g3SQ6tpMqr8xYQstGNXnUl5L
         rxrtlk+4Sjph6i481Heo2yMZCH9snv5HBTcN7bihEOqcTwWgen6FlGVHR+TUYcR7aBu5
         xm80v0k3hkAXh1tH7NII0mposutUoymOVbxO/pZjz3YuFo7BgbLCJdza8m5VAwQy4o0M
         9yMLDOh6xQiYClW9K6s5Lp1XSOrW9LRkE1/qMoKPUNPaPM3nFAJxs3agFLhD8CFvTRdF
         wRqA==
X-Forwarded-Encrypted: i=1; AJvYcCV2R2XqGZolJ2AZFYcac+IrXjB9QwpgRc7DXjw/FucgkFAi7Rkd9jugd/gi44DuS/JtMHYKrzDtJXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhlztG14dkqwUvkkOktdu6/WVhs14Ths9OWEA++w28ubM8YGu
	Whbra43qmkmCoUtGRCUdmzGBVG0eCgvv43tLzzfVWi9aU7EM/kvbJUJotBB/Nz24
X-Gm-Gg: ASbGncuNEF8e0FEYTLJNoCm9V6qoq9QJAcI3hbT2XD7EbyqxMmGXHGyVBlIganpMQwv
	/Mpe0RqAdfZjl6gVB0SZ47/LarvsQroqAyn98QbxExC+Wi1UmlhEmHcjEORmrMqxpeLXXxBMbHx
	mQqkkhLVXoF9XAriT210zFWyYJtxkm99KQlFaJ36lfD7xP+/pnmmDOG+PwwswDS88gSjlvYE+/9
	m2nfmEJzAVKKA1CGGBEz90DCY2ECtt3ALi5maDxQfQ9LutXam/rBb32Y7FA+SjG/cGaYwTCpFq/
	UkE/cmuGLzCKhyWZ79Bj20FMLEgMiXl0VdF2GYLvsETn8a55fDox/xi58KvC9KShzJE0WitGjVE
	r4AR7mzU4p6qvFi96hRSaIRgrdxUIeZO1EZp4rGWJy04Opg+waTO6svLuEUiuzjJxYCYVjCTB9i
	cgSk1C7fa/
X-Google-Smtp-Source: AGHT+IGrtPXqVslXMhvC5f2aabSuhxFO/phiJJQNKYxIlaU4MONf1zMSOn9O0PMCejuvm3N9sJJCbg==
X-Received: by 2002:a05:6102:e12:b0:528:d2ad:1f54 with SMTP id ada2fe7eead31-5d5e223768amr954798137.8.1759917075624;
        Wed, 08 Oct 2025 02:51:15 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39f1a2dsm1516577137.15.2025.10.08.02.51.14
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:51:15 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5c72dce3201so3041587137.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Oct 2025 02:51:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1oFmjZ4Br/zaGtZYuq+atvnsuSI1rRrZT5ITaCog+0nwtj33zRUUSWaFz2f/Q8mO6Frikd9WBMWA=@vger.kernel.org
X-Received: by 2002:a05:6102:512a:b0:519:534a:6c20 with SMTP id
 ada2fe7eead31-5d5e23afcd1mr853215137.30.1759917074311; Wed, 08 Oct 2025
 02:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com> <20251006172119.2888-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20251006172119.2888-2-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Oct 2025 11:51:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUb105BF1pNtqMpq2N2Yrh0Rp2hAxuzaZZWXfQfou=k4A@mail.gmail.com>
X-Gm-Features: AS18NWDRVT_iGSvxNuYXIG-QZwF9FHymRVnJQTzRE7VPezsiv6NxhZyhisJFrAc
Message-ID: <CAMuHMdUb105BF1pNtqMpq2N2Yrh0Rp2hAxuzaZZWXfQfou=k4A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iio: accel: adxl345: document second interrupt
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 01:20, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The pinout of all the supported chips in this binding have two interrupt
> pins. Document the second one, too, even though the Linux driver
> currently does not support the second interrupt. Boards may have it
> wired nonetheless.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

