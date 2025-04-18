Return-Path: <linux-iio+bounces-18279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F32A93B91
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 19:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365F01B63651
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C0219300;
	Fri, 18 Apr 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnESSXM+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B313B590;
	Fri, 18 Apr 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995676; cv=none; b=GKiC5UilisDLOo5rPAVlHJov/tdDqcDEKHryY+llVoAbIjGYyAukTEgGwJIv7B0PFQTJ1Phd59JYyw8Ks45xhADncGQsi7GqH5U+K6qb42eenLd4E7bJZpjKHswLaYNBeKyt7NlrZGmJLDTXtRWZouIH+VsYJdQpggQqK0bVRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995676; c=relaxed/simple;
	bh=8w1HZbYIpGw2lsE8fxuZH0Z+2IIZJk+H61XsQgcKQao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INaPPOw7GP2FMCHTGukqxZp+AQb/Rx1rwVjm92JARbcmyiCBh6j2vLEdZNBFqs1PXornPsz6sBGnMwAr6r7t7SM8uDwhqWaMu/HabWMSrsEpYwPTqGEvrS//DrxOIP3krX5KLuGXVEhPcv9iu4TPk+Nf5SbP8yWrJi9woVFEJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnESSXM+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47686580529so22448571cf.2;
        Fri, 18 Apr 2025 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995673; x=1745600473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4jOaTYIRWPNV5975r6TtN5MoRcAB00ZTyeDTKmI1wU=;
        b=HnESSXM+aCJ0XeEsmXKiZ/SzPoGnuXlp0GpuJNyfv8oNS4HzeT0fN0caBxenhQcRi8
         KZeXyT6DsfT7CtouMGi9htK5Az059tArWoGmY5LVsOpVUTmPXGYErmK6zYHY0ZWQxrjs
         T5Fq67hYo6GxIfT/JatOFPFTd7JbJwA33vnglPm0+L1K/2YABNur4dgdGWS7cr35zXDe
         YwGEcuMzFpI7PjwY7BSWSZUBWyfjz5Or/09FbcRRrf7kUMQmCHUnY087ZAiPWPEjjgYK
         vED0tC12SYdz6aBw/kWRH7fmm9gGdY8E3654DbbdEtu0RgfJteog3rLAkmUYPVQmZ799
         +OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995673; x=1745600473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4jOaTYIRWPNV5975r6TtN5MoRcAB00ZTyeDTKmI1wU=;
        b=NLLvaqUo7ZNrMC8Q9Oh5E1gnEHrm/9UVTE3a98udeXyczNpkkJNc+8QSQFtnYjzn9l
         Dj841+Cst5N894BubHNQvTD059narfmz1tt49usZeUihGF6Nrho54XdHbHrnWGp9nYtp
         V1wnHq+VEFAUJPJb0aG7indu32yGIGAh1SUtW05gS2AwMcV2t/5qWtdFZVHNW1O+w+2K
         jLFvxK8QhV9fvjaZ/gL71w8CfTo6ssanbsrr0VtL+kXOT4gP2ktTDvHTvXSuMzuE3Gq+
         9MDaE2J1vXFyEDtljLhRSEJ+ZgfZ7yXT91BgX3r3t6fR62X5G/Z5lcvK8XKoQJmiNKp6
         4K5A==
X-Forwarded-Encrypted: i=1; AJvYcCVh3RHjttrc/Zn5Oz9RvLHIxpUP3DCl6QwopD9GdtrmolL/UWSzA1SbOiCZn81/CFNMp5NvTC7f@vger.kernel.org, AJvYcCWrDpqmY9gNSMgGEYT81kiq/fk7m0Zfeu6SEY5bF1KuLCGWWyjZXOEKRlQuGTJgzMyDB5DZW1upZMYKRTz/@vger.kernel.org, AJvYcCXrXGWSVX0P4vYjqTAPCLSQDrczOqZZW2A7qVM5/frNkOXI/McbmstpeBpjiqyKt7Rp2aCrzgUsRyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIqabFKEgsPyU6BMMbH2FUQvf5PmhKVtMh69sJUP4zFus7Cx3
	BfLj3fuN3X0FmorPcCPkcOUwzC56gO3eyCKxs+q3aOBbV/mGlpVuOJvlMusNCG16+1uOYbERk+y
	Uxcozok2W7dAIxTeXhXI8Tf5TjSanNHKwE7w=
X-Gm-Gg: ASbGncsn6ee9EJjEg8iB2VoEhxAzwPhFPHGKJ8JzROCegnK/9Ohlkp4SW0eadNEGgYm
	csuC+1TWuSWDM0uL7O5d//jYHNGsSPIFN8qILrJdtBqDZdzyw8zYPvkryHZ3CGjuo6T9HAd0MUK
	CQerKvm+d45oupABqTZmHE80y1ah1X+5kH4BP2kLlfOQ2U6588Q3U1zYO2V+63e/A=
X-Google-Smtp-Source: AGHT+IGfRaxUib4vxMeg5ZHVwz3sTnnqydjjr+BZWaabAYNvr6HBK0qxHxLDmk+tzoqUGiqm3k5sVAVmzeMakuDT4ZI=
X-Received: by 2002:ac8:584f:0:b0:476:af62:8532 with SMTP id
 d75a77b69052e-47aec4ba327mr49626361cf.45.1744995673373; Fri, 18 Apr 2025
 10:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417135434.568007-1-gshahrouzi@gmail.com> <20250418164040.0f103380@jic23-huawei>
In-Reply-To: <20250418164040.0f103380@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Fri, 18 Apr 2025 13:01:02 -0400
X-Gm-Features: ATxdqUHYpoK_uf-3FQX72Xc5r4NMTYfDz6xHt0YdITsiYSrcp9t89ZozAiI7UVo
Message-ID: <CAKUZ0z+kr1ToeOJaRihbfQyKoJ+vgOF7YjK811TbEcyd-43a-Q@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: Use SLEEP bit instead of RESET to disable output
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 11:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 17 Apr 2025 09:54:34 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > According to the AD9832 datasheet (Table 10, D12 description), setting
> > the RESET bit forces the phase accumulator to zero, which corresponds t=
o
> > a full-scale DC output, rather than disabling the output signal.
> >
> > The correct way to disable the output and enter a low-power state is to
> > set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
> > the internal DAC current sources and disables internal clocks.
> >
> > Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> Seems reasonable but I'd like some more review of this before picking it =
up.
> So feel free to poke me if nothing happens in say 2 weeks from now.
Sounds good.
>
> >  drivers/staging/iio/frequency/ad9832.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/i=
io/frequency/ad9832.c
> > index db42810c7664b..0872ff4ec4896 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -232,7 +232,7 @@ static ssize_t ad9832_write(struct device *dev, str=
uct device_attribute *attr,
> >                       st->ctrl_src &=3D ~(AD9832_RESET | AD9832_SLEEP |
> >                                       AD9832_CLR);
> >               else
> > -                     st->ctrl_src |=3D AD9832_RESET;
> > +                     st->ctrl_src |=3D AD9832_SLEEP;
> >
> >               st->data =3D cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_S=
HIFT) |
> >                                       st->ctrl_src);
>

