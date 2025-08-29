Return-Path: <linux-iio+bounces-23360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B2AB3B7A5
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6CE3AFAAD
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D62E2EF3;
	Fri, 29 Aug 2025 09:47:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379E33985;
	Fri, 29 Aug 2025 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756460879; cv=none; b=ChSD7ktySnDRbmn6ld7pqbdOKX6h4m/G4zmSyhkDFy1M+80C+YKcNGuTw7/EydzqvvLdtAEsTSux67FKwVIc7B47GtnlhiROsxJtbIyAOA3IZ0hnS4z4GqoCmos96YYjQVStsbD47Co+Aq7tiJam78Ccbyj5mkuahjISZXvVh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756460879; c=relaxed/simple;
	bh=Uam47n9XP2yNSU+KEkGNi082Ub+UjYkvl37Onz7YMGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8Y54Yj3Oc7co2VBFzuZd1Frf/pqtPim2/GfPKuPtBTr46aMcDC3Evht3Oa2rIUougATWt8pZYKigJsADCIW1R136EUmLJS82HtB16fsbFjSEm4dcIL8/exhr6YQEa1Lfc3TD5FeVJcm258q4G5iMvXtPZub8rEvzbyd97z02sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54494c3f7e3so93524e0c.3;
        Fri, 29 Aug 2025 02:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756460876; x=1757065676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SjwK9jXSJ6vy5qbcZE6vx6xB7K4aY3jNf25jf3fHvcU=;
        b=nsJxo684igLQkv5DrQsu13X3rn6GfzCCXBIadNcZIcawPKLiHxSzDOyuVI85FvbxqE
         +lUHCYs0p3bxo521EHh1ZxHHq4uf2D3r6gCAElQ0/0I3SQewRhBAyXn8yQqrSVHBfaeX
         hOVFN7cG1LwkSuayb4ZT2kHSbHbNkNaS6Oq325GCvmVdJIjSpKsVSyjCURkRq6ETgCIJ
         vheblAT3fSpFSO1JYxPsWTGte/+cNgcc31XpphGdv9c6U8NtqS5kQppUWBS7hEcjCdWX
         s6tgcF11r3OUbqO3naANmv6B5LVAIedrBjgfF/F+UaMga8KxF2nCvcHpecmUKaBjH3P7
         GMOw==
X-Forwarded-Encrypted: i=1; AJvYcCUqAPKSuOszS4lp+sf9ovfmiuBaiu0wSh0yIafVsf9vjsmMx1hHb+8EaVUBPo3z5MlXPIg/toA8M7GVxsPa@vger.kernel.org, AJvYcCX1tdKExWHSDtHR/yu2Il+k8B4s/G8yL5fnR53Zx7Al2/mDEbI5f05pyr06oLVznoMz8+wqo9fqigY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18+xjA7F0gpqu9IVLtGi3q/VeUnx00yUCbRPG3BAtH1psXyh0
	dQwicYy2TeoFfq5lgoxQ0l+gDZJmAbgHS9I+55VfUC1zwuQYWFb0abu9siy2EIc5
X-Gm-Gg: ASbGnctJEiy0D6VWdrYylh6vCY+Uw3Xmc3DMBXcKkJf1fT4vYnvKbU2vPG02kjsNy1Z
	ibiDcquXxWN89/Cce/P6Ya/AKpFZ3QSx3BFYRl1rfUTsNIJ4eO0TJXxS8Ikcekz8gvIs7ErEgp9
	TEkACl+12+Y3OedDtbnWfAdNsE+2svIfU+6LChcqWoFz1uxTdaltZ0nPQ8xeJM6XuQO/YtREEkp
	bfh/dtaALlfdkLHUw9nxNTlTGC/uNPNZvyzseEcMsIL68dhLQXnowZZ8/uvNhFZjXLls640nTLO
	TgS6fX0papcuFvQfgxfbCDPMqU+a2nyxlrdzEA6ZRiqdSgtCsAowmTMZ3vU03p3L5jzgqoaQ2qP
	zXws4Eli8v89KI/ma/hpUqs+ISlpwBLJFNieUnb3qXKwFlGJJ31pcOMmf0l71TLxACLuDQ0Y=
X-Google-Smtp-Source: AGHT+IG8jIKDsVWnAuswpo/MqWNPhyyrZCHuqJY72pBh0mx+lvb5wymxARAFOAJ0RFD3rfp1xyu3Uw==
X-Received: by 2002:a05:6122:25e7:b0:541:366:d15a with SMTP id 71dfb90a1353d-5410366d42emr4515194e0c.2.1756460875666;
        Fri, 29 Aug 2025 02:47:55 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544914c0e8esm637779e0c.28.2025.08.29.02.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 02:47:55 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-52069272157so295727137.3;
        Fri, 29 Aug 2025 02:47:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnkWB7FZ03ZIMOo6vOb5aqqknwPHM6/f3BxOAMelzGmhkm6+kvNseKgjXCrLnvKRgHKr2U/R50HoU=@vger.kernel.org, AJvYcCV+wcayYkck0zLXs1tkIkt5mdsTqRg/0B0pIWtZgYN56JR+VxYwco46S8GO9qmr0rZD5bp3Hcm2qkwr6x+o@vger.kernel.org
X-Received: by 2002:a05:6102:5045:b0:4e9:9659:3a5f with SMTP id
 ada2fe7eead31-51d0d3295fcmr9051801137.10.1756460875111; Fri, 29 Aug 2025
 02:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
In-Reply-To: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Aug 2025 11:47:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNNu+gwHdhfaShLyXHqxD=esp4CXpWiHJCqrCGho0z3g@mail.gmail.com>
X-Gm-Features: Ac12FXw4ySjEeOeCH0mF3GQ3nupnIdCJpFWX1FkdY409glgjEvUK-Xh-p3wrdqg
Message-ID: <CAMuHMdWNNu+gwHdhfaShLyXHqxD=esp4CXpWiHJCqrCGho0z3g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: isl29501: fix buffered read on
 big-endian systems
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Mathieu Othacehe <othacehe@gnu.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 22 Jul 2025 at 22:55, David Lechner <dlechner@baylibre.com> wrote:
> Fix passing a u32 value as a u16 buffer scan item. This works on little-
> endian systems, but not on big-endian systems.
>
> A new local variable is introduced for getting the register value and
> the array is changed to a struct to make the data layout more explicit
> rather than just changing the type and having to recalculate the proper
> length needed for the timestamp.
>
> Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Thanks for your patch, which is now commit de18e978d0cda23e ("iio:
proximity: isl29501: fix buffered read on big-endian systems")
in v6.17-rc3.

> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -938,12 +938,18 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
>         struct iio_dev *indio_dev = pf->indio_dev;
>         struct isl29501_private *isl29501 = iio_priv(indio_dev);
>         const unsigned long *active_mask = indio_dev->active_scan_mask;
> -       u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
> -
> -       if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
> -               isl29501_register_read(isl29501, REG_DISTANCE, buffer);
> +       u32 value;
> +       struct {
> +               u16 data;
> +               aligned_s64 ts;
> +       } scan = { };

This still looks rather obfuse to me: you rely on the implicit
presence of a 6-byte hole between data and ts, and on the implicit
64-bit alignment of data.

What about making this explicit?

    struct {
            u16 data;
            u16 unused[3];
            s64 ts;
    } __aligned(8) scan = { };

> +
> +       if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask)) {
> +               isl29501_register_read(isl29501, REG_DISTANCE, &value);
> +               scan.data = value;
> +       }
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +       iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
>         iio_trigger_notify_done(indio_dev->trig);
>
>         return IRQ_HANDLED;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

