Return-Path: <linux-iio+bounces-13154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015D59E6FA4
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 14:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4941882799
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AAC207DFE;
	Fri,  6 Dec 2024 13:55:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B03201269;
	Fri,  6 Dec 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493310; cv=none; b=aItQkN176yqpLWxBuW0WclAVXOUDta7jD5w/XoOFG0LUZyjaEFloE8OCwKmt84Aa9yu0oqllsfLjzOz0m1zN0JC2VAcK93yB3PMOhLbC1Oy33Kze2PCUxjZAAq9qAl+to5+X0NLvX28wqkzQwB1cSyvoaqPQQ+wwYRLPoTQ72qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493310; c=relaxed/simple;
	bh=35tXrHehphd8UKl5WJEOudgvnNENyraL3kMkrb/5N20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA2Yv4PvjKOmlk4c7E1XrWKL33Xjj2/2NJk8u7hsGiWcTDsN+5DYZXigkqOVP7iX53kznWJBdoNU50jIQyTQmg5J7JYAX//kJYg3wJg4DBFBFwVRW/SAwNVuBKpkN9oLyTLufULLZvGglR6s53kUlc6UMCzm3/Sh1pdvDW4QGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85c529e72bcso80088241.0;
        Fri, 06 Dec 2024 05:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733493306; x=1734098106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFx+gnmIbf6Ff/K8kUB1TzM57MX3Vguw4LO8xY75gyw=;
        b=XT4T20I0Ia3twlO9ZoKoEgvvnOuf36oZpDqItjRSgzS4O5ZAdBZvSr6CahMHj6VLpO
         b1phqGrDRPmFro1o9Vo9kjmv5VUUcB1Fywqt9PfcExjFyPnJvsHYLzspXglYRNZFQUM6
         RLZADF4EC5PAxvRtN3S2nCRCJJgZSmUgwfCbiL/H9nI4oSKi5BBZWZpOdy2hRiyYb3R+
         ktfzmzQJ/F4NIwNhVZTrdXlEfKCwV8XgZJrtSf+HROFiuRHvRobh0D4cUYwwTBz0tnOM
         9BhXtjYKY/y1P0+qa17fiSidcaH6hIe/0nrWFOn6AvByYhZjh/CnFY+m1rx5LshR2bE6
         z0kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT5S60ZsJ7j0PbBfZP1bk5VBcxfsyfj6hmZljpkTexEOt3O2EpRqW8f5Yxa7/ntA5vl5zI1lL3JrBiBtF/Q/qQ1IU=@vger.kernel.org, AJvYcCV7LpoRuleAghIzYZP0QuBiysSa77rhWdQV7BNAUl3/Sajs2NGz8CUgIjMFmHHoxDy4DdMH1S3nqRsB@vger.kernel.org, AJvYcCWKGaHoLOE7m1/hlBBPou/tnIKoidMXmtq9Cqy1dUFnc3TbV6y/MQm9kKhZJHr6DgCu45quyEr9WLKIrsGu@vger.kernel.org, AJvYcCWiNq0LYKtpdn8SKXGuCHFKUcLuQF0u9f0CCEYQFMbGQbki0QOoqiHp539A8Dh3eIHf9fjDchxX0Lzz@vger.kernel.org, AJvYcCXnZ1fQTYbA7dgj3p+gqlbJsaOc0YlB55765rC9sKG8SxDhwKbwxy3dSlhcI+zGs+6EOKtoGgIOOGS9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjw2l5DIYshNyMQobfFPDqHHyuhxuxwHGLL4mQvAe+AnRuAHJJ
	xo5rc0bOVq1WxXfl06+co/krftzvozxS0HI4Y+MgTSqCamZhD+aSi8glmy/e
X-Gm-Gg: ASbGncsbIxiPDc7B0qxeZTy6I4xjIwOEFJzYOoWTYEC3MwzoUvkodkkdcpnPu2QxiKV
	B9qTukPKuc2j5fb9tHdFN06FNY/NdpNtwQ8zElgXBOFMpepFW77Bi42IssBRWbcbi86zml52pMs
	11vxj7XW6Fvik6XjER4H/hYHi+EIWmT4Z3aKx9nXHM+fFYs0ZBQ3CKGjHPFnLETSLYzNtAVbzWt
	N87v9uX/hJmAqEAblxoKwc11vvf1kvSh4jXVoUs5TZox47ON5LxT/BouWHSCbjuSDAITs4pjHCt
	CaAYuW6S8Zj8
X-Google-Smtp-Source: AGHT+IELHsyph6EjruavIZbnBltuZ6aqNdZ8QzzgBnhI6WIWB/QC1unKyTNKCavV5E3ukn211r0vlA==
X-Received: by 2002:a05:6102:3e92:b0:4af:c435:58b5 with SMTP id ada2fe7eead31-4afcab164admr2887011137.22.1733493306530;
        Fri, 06 Dec 2024 05:55:06 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51606dc43efsm73014e0c.32.2024.12.06.05.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 05:55:06 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4aef1e4c3e7so524253137.2;
        Fri, 06 Dec 2024 05:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZXlqfxnsNroBqlKLet62oM9LBkng3EtmwEdXVLKWJf3saTuqGlajErnvH0k7/nLxY0CGo4XRGTi6Z@vger.kernel.org, AJvYcCUwCHpmnK9yPvSFnNitDw16g5rISOTWnyB1Co/p+1ynAiAmtXtpeSREMUYqihH6w9Xxs35liEIduzr6@vger.kernel.org, AJvYcCVf9EoYgp0vD/g+TC/xhkGl5feVmTZW01CzVEA5hYkFkz5pSahfv/ulxzbI1cC66+cdsp4V71LMPsEftjz5kUPpT2A=@vger.kernel.org, AJvYcCWU3pwkXUAnhw7/gnApWMgVYlg0sreFUIcU4gxAiFoTnwGg4UttFHxAeZZXPuPafGIkXnYlaIPh4Upg@vger.kernel.org, AJvYcCXRcr7o8dnkYEwtntz0RMhtuvShX/mWIKTLrj1eFfTeEwKrRtljTdcfN7vGtGZFOSwsCej9lHWNCMYyGPvf@vger.kernel.org
X-Received: by 2002:a05:6102:cc6:b0:4af:4d60:2e12 with SMTP id
 ada2fe7eead31-4afcaa3dbb5mr3166643137.7.1733493305691; Fri, 06 Dec 2024
 05:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Dec 2024 14:54:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUo4Fy+MF6fp6oFn965pf0=ZR0or0GQ6nZLGb9PmVYe5Q@mail.gmail.com>
Message-ID: <CAMuHMdUo4Fy+MF6fp6oFn965pf0=ZR0or0GQ6nZLGb9PmVYe5Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] clk: renesas: r9a08g045: Add clocks, resets and
 power domain support for the ADC IP
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:13=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add clocks, resets and power domains for ADC IP available on the Renesas
> RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - rebased on top of the latest r9a08g045-cpg version

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.14.

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

