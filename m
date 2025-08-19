Return-Path: <linux-iio+bounces-23016-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D524B2CD83
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 22:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D91BC5540
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7357302CC6;
	Tue, 19 Aug 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BITInTl3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64B1C5F27;
	Tue, 19 Aug 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634231; cv=none; b=T2pYZND4XmnTTkp1CYi1WlP5OuXTlfRzo4LyleJtepmjThin20Zk+WDZK5oZ5zs1SJhZmhcKvEVAUsG3f5EZD1hbA/BmAjfpWSXZcK09P4+k7tFnN1OXtr+gBtqJEMfs1m6HtQn+PYTN1idmCRw1Y2JXFx/im7DIAVGhLgJl+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634231; c=relaxed/simple;
	bh=VGta13z9vU1c49zM5LqnvxqNXWJuXzxy5grqLQ3xTVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7L68nFs6RymksN9Ca8FEN/V1N7Uvnhrboz1N82ZDzwjSssQ0ubVj3aIsycevyO/5VFukBZii/x0EWWryKiL3gzRZKTWIjMy3bK9Mmozuhj6IIgo4UZl3H/Mqs1C+2RwRsFu+M0LW5sZYTcCLaZ5VPRYhINI89n0JjWuAs+OwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BITInTl3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b5b7c72so7733681a12.0;
        Tue, 19 Aug 2025 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755634228; x=1756239028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1GsDDi6vP6UuMb6/BeFHKVGi4oUcjZwWb6yFeF7428=;
        b=BITInTl3hD955vTaa2a8pBSJZMFZqpb4IHzv2Bm6GVj3T5zyRYVcYUgF53fwrX6OjC
         UEd23tkosYkfK2UWTLalseeOtzx0YZb2/0LL6hVU+dL6IWGv7KBDiqAr6nJfb23mObt/
         l2VD0GRUtmGRGbuUivxMuIFOJSN1B9xsHXkUqTvY1uHJFZgnnKIQ700eHbtETcSq7OEY
         d9cxhGdKwVxoyZ+9DSyT4+joukAiKxzpO6L5x1lt3MIZSFUxuoFEYPasTSV+WA4k4fwB
         5xmaCvQyo/lUzz2iBmA3y1idRk/gjidfS4D52MqkxvGvNH3UcG07lkV2m+H4pVZLPG3P
         l5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634228; x=1756239028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1GsDDi6vP6UuMb6/BeFHKVGi4oUcjZwWb6yFeF7428=;
        b=kwwXHdIrGCvo8p74WX+N30EwL8AncDDmfsQN8XRAhfhEf9QSPJuWk/JFWrvzux0rrF
         /I7EucwD4Q/7LObiC6Kvuak4skr4XwqndMCq3t1+8OyTm+zSxBbFm5oNcowAqICzdJ8t
         eAqRmbBQOylIlM/oBGILxU1f/EAV675K8nnh8jNjeSwQ2QyslxbxWykcljR/Z4A56yI1
         yQQoY8nM81QBddCpAMAwyaFjYdfp+mi1f4ANQjL8gH6dFgjhfycG/+ff/QAIDgrjTer0
         7f/mprx+e2zjRNqFTOFULX+R94lHWCM6jlYb3NRgewHRmgSRLjEoLrqeL4Bya5rMVRSz
         B4kg==
X-Forwarded-Encrypted: i=1; AJvYcCWh4/BQPDn06huKV/+hludCAsMOGaMs0lxxJ8WGpDgMxVpj4OQ5jhZEURyvk1aIevSGQN/TCM6T+PxPdfOc@vger.kernel.org, AJvYcCXK/ZJ7ikMtHdRGm3PXW6Mwq9SE0npeWpLz2s0naVVpDSBHfqLECg5sHD3pVsZpmpT2r4oHQsKQDsCd@vger.kernel.org, AJvYcCXu/KyXCgZ5zzXUDyWhqVmhtAFakZwpr2o03uahWbm8iEpg5Qorri3+zOBqgMf2jmYYX3BrhrLIVROz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2skJddFOF6BaIzcU2IsoTcj5bQ8vV9m57hsqO82/r/NQmFpR5
	irM3L/C9np9ajOZF3ZVSegmCX30m3p8uneRDG0uAeiQd9VKsuaBuGQcaUEmCapsBfBqf3WlyT7T
	YcAtbLf+BQ7+ZsKUNNON5C/aYn6A3PnQ=
X-Gm-Gg: ASbGnctj3DHz4hvTjqQyVxqnlvUROVo+ZR9szAm5bxI/DabjradRygNLNZhWonMLiEi
	Cj1MrLmSVJ66dvOoHgqsbiSCC5sTskaRaH7yXKTGsg75syCwXiSRB05odO2Q9KC950Xz6qtObEs
	dHM48sFWCGkJe2pBGR024v2AwKAcr5LLfQ8ELsLEg4t9mGhVZymuu2cerXiG6VpdRWJMtUny0B0
	lSJp/k=
X-Google-Smtp-Source: AGHT+IGvvZwSDf+nqoMUriQUBWi5cXhB47oTQxbHjTCLnj4WG9s6ooc9sSWJQFJI03LwI/NhEfSLMWMtmDimj/avu8A=
X-Received: by 2002:a17:907:96a2:b0:afd:d9e4:5a4a with SMTP id
 a640c23a62f3a-afdf0211301mr19233766b.62.1755634228039; Tue, 19 Aug 2025
 13:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
 <aKTNEP7pNY9ZbrPe@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aKTNEP7pNY9ZbrPe@debian-BULLSEYE-live-builder-AMD64>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 23:09:51 +0300
X-Gm-Features: Ac12FXwMoppmzt85kIowopKHGNV-HfCrAOZmMdJD6FEEPzVULS5II94QvPN0tl8
Message-ID: <CAHp75VepJCCk9zJ6g9tO__FP5jq4EiCtf4mwYGuFf9BO3auJYg@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:14=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
> On 08/12, Jonathan Santos wrote:
> > Add support for ADAQ7767/68/69-1 series, which includes PGIA and

...

> > +static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
> > +                             int gain_fract, int precision)
> > +{
> > +     u64 gain_nano, tmp;
> > +     int gain_idx;
> > +
> > +     precision--;
> This is odd out of context.
> Also, it only applies to ADCs that provide output codes in two's compleme=
nt
> format. See comment below.
>
>
> > +     gain_nano =3D gain_int * NANO + gain_fract;
> > +     if (gain_nano < 0 || gain_nano > ADAQ776X_GAIN_MAX_NANO)
> I've seen some build tools complain about comparisons like gain_nano < 0 =
with
> gain_nano being u64. Since that's unsigned, it can never be < 0. And in t=
he
> context of gain/attenuation, we know gain_nano shall never be negative.
> Would just drop the gain_nano < 0 comparison. Or maybe clamp() the value?

in_range() can be used as well.

> > +             return -EINVAL;
> > +
> > +     tmp =3D DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
> > +     gain_nano =3D DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
> > +     if (st->chip->has_variable_aaf)
> > +             /* remove the AAF gain from the overall gain */
> > +             gain_nano =3D DIV_ROUND_CLOSEST_ULL(gain_nano *  MILLI,
> > +                                               ad7768_aaf_gains[st->aa=
f_gain]);
> > +     tmp =3D st->chip->num_pga_modes;
> > +     gain_idx =3D find_closest(gain_nano, st->chip->pga_gains, tmp);
> > +
> > +     return gain_idx;
> > +}

--=20
With Best Regards,
Andy Shevchenko

