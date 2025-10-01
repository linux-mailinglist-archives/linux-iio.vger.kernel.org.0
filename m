Return-Path: <linux-iio+bounces-24625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF6BB0849
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 15:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040163C65A9
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 13:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F8266B6F;
	Wed,  1 Oct 2025 13:36:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10B2EE617
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325770; cv=none; b=jU3qm5WmKBHx486J59ft/REfVSzKynwgG9vksCiV60DsoEvC6XyajUW/Cy5Sf846PLGIcJz8Z7mIYlw94LnXeHCCEOU0rRYsyvZEMcTiPeM2AcX+GExjN4JUI322qLUaiFdCIiLuBCfQxEmr1IB3kod9gG7rqNVHa5px1ryEzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325770; c=relaxed/simple;
	bh=cCOspOg10LPIcpADaHReTKiZQPz1A+QQStO+5J4q0Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/JRuR68MDPc1aV2ysVNbtpvXd2WRJNWl0GLHBBqSteVWWQgMUQSM3ntpwMFNyDdfCNKko+4gj3k1MR4n5c2GhvuUjlprrk6/+F/e5k4cZXo1vob9nZGRRwosvJRS9POe/kCJH8AkqYToB+THx716x+VR26LhYP3q4FDG5d/1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so3069758e0c.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Oct 2025 06:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759325767; x=1759930567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTnvOCbceGyglohEUcee1/fNsyqLgTdEhUXaZIqhQic=;
        b=Hqp8jDunFmDtaw5BAeV9a53AHsDMsdVwYJXOQ4JT2tiFqJFUnp4pvLDrMRFuj+py+7
         t2zMmtwxEJ9qvB6UWF/1xDJpfDtPjvYZ+z+TirsOnsN0MsN/Os2gP8+1nm3Z+xAKz392
         Wsqv4Yfz31ysabjSUV+6AUxZoAteuCsuPOk3cfTgoMtpqU0c0Q1alHGy0lyCHVNk4nCv
         kSlCIc2f7wY0oClV+Pszgp7+ikIVF9yi+laBC+1hmY+xKGIWCGkIx8I6XDY9ANNPcJhE
         3GLvOel2cyrOaqPwvSA51L76FqrVxka1iZimFFSSQKOKPEDljhHYwoUxA/6m/29fkiDj
         km1w==
X-Forwarded-Encrypted: i=1; AJvYcCUiFnp65fUDDhNmKKsA7UFa1eTv/C7tyn0KL8TrDkOCHmUkc0ZK9Biqx3YI+vO5eFviTYxL1JLsuSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGV68od15Q7uOaidLNUy0NfU28BUnv8bjFCcEVGkR/KSOEjC0
	fiFPIf2ynesIihRzjZTLpolRJAQWlcbHbiyyr3yIS+Aab2e0LrxAMEYEKE046mF2
X-Gm-Gg: ASbGncuUgOACAW0QMJy+3MmQVL7dvNMfqwNmmcvKmuELAXJAS253eullQVRK9QbC292
	3gEQ2igEjrXjpQ3a+3r+R+sUzM5ActzrMnLFfWBzj5ZB7pOMdPfbVq2earT9EEv3yvsc+Q+n1PT
	RB+8/ij/X7U88IJFBstj8+7xJnbZiuc6bpF/N/EeC1CId58J451prxdf5EWi2TYBCd0fxIsKHnv
	c+eDqsF6lX44xtSNTa11ApiVduB9uS64+Ip6wB5Y7ZfcNzG2JNjMTKB5FIjRDuxgOFFcsKSa5SK
	4gsQuWIkrCCotAffbbJbUwHbpKLCZIKedwatqIDtH/XaPOlVx+Ab8BKF4TNYbncE5JYm8VBw/wa
	cSVwJH5S5zx2BM7sv91yNwHuRlfOrdPXXaXQBoCyLi4PDVi9m27yDYAcJ7I1D5G1coaSIIhgolL
	WSwDDe7QzX
X-Google-Smtp-Source: AGHT+IFBe03CLFEmr4f4PpOlFR/+GZLXOccH0HDvmSValcxX15dg2kKMb8MPIc2yFMe40EjLSQfb9Q==
X-Received: by 2002:a05:6122:1681:b0:53f:8fcb:b630 with SMTP id 71dfb90a1353d-5522d232d05mr1396972e0c.4.1759325766987;
        Wed, 01 Oct 2025 06:36:06 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bedca058bsm3515098e0c.18.2025.10.01.06.36.05
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:36:06 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d4018cb45fso410419137.2
        for <linux-iio@vger.kernel.org>; Wed, 01 Oct 2025 06:36:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNXDsdIFdbMEyJQUJARppmy5g+Fs3pBAr8Hx+F4XcNHADH5Zvj93Fh0dJFeGJXMfbXULpIf8X5NGY=@vger.kernel.org
X-Received: by 2002:a05:6102:d86:b0:522:255d:4d19 with SMTP id
 ada2fe7eead31-5d3fe747011mr1261198137.23.1759325764988; Wed, 01 Oct 2025
 06:36:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Oct 2025 15:35:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUA5r519G=OQM66wSig9r2dDP4y1NTH8zOZCTLb5m2Tew@mail.gmail.com>
X-Gm-Features: AS18NWDLqgedMT7ALXpq29QgD05-Zz5HL5W7UgCB9wanWY8rYAtz-4hGklmKwbI
Message-ID: <CAMuHMdUA5r519G=OQM66wSig9r2dDP4y1NTH8zOZCTLb5m2Tew@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] clk: renesas: r9a09g077: Add ADC modules clock
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have three 12bit
> ADC peripherals, each with its own peripheral clock.
>
> For conversion, they use the PCLKL clock.
>
> Add their clocks to the list of module clocks.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for your patch!

As I have already queued v1 in renesas-clk-for-v6.19, there is no
need to resend it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

