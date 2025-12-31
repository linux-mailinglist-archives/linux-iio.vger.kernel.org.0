Return-Path: <linux-iio+bounces-27436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8FCEBDAD
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A52300F32E
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4AA2D7DF7;
	Wed, 31 Dec 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHo+IGSN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F726F2A7
	for <linux-iio@vger.kernel.org>; Wed, 31 Dec 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767180026; cv=none; b=LzP4DOvN4jYoeLQBSq6FdtbSnX9e906zkuYBo4ChfrFBB2bbwQNn2WZi9fDAT/Yv0SFu1IO54W0hpa7uKNt3B8/Ok+BUWRB8B0DBwGEuq2/YW7NW0GtItDPmtzbuz+keB7YT5kD3xuKCUYlCdbxXxkitRPTMnsQali8xF9a5c2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767180026; c=relaxed/simple;
	bh=fF6cAauMjzbu3RmeJ6ocqkoiEglRnlXC4k9TnkgCUGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4xDhljRReoL3lUgPHdZwbP3Ks1m3IGBdzjuH0Ky+Lh+3cP2yS6ZVIHlKZalvIy6ujUedwHa4i4bBIlyTWLOWmVYewZ3SMnZjeQUVGLFyDyc4B+HLlM/PFTL55K/nzw27g6ZbjuSBXionOHHIv4RDaIvB8MBIj3xXUbD0WG7lcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHo+IGSN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7ffa5d1b80so1362766466b.0
        for <linux-iio@vger.kernel.org>; Wed, 31 Dec 2025 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767180023; x=1767784823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXDHUxZgK2BZrRgxIJ8QsHtEdy7CS+cUzQSNiUuHj6s=;
        b=RHo+IGSNzm2eQJGokBml+nvnKet2xBgj1NU2zp55eNj9+qTqIJLIj5uKq5MnVHsTZd
         FjsD4mR/BRo0fr1XPXZ15eKAIX66BPa6fPCoYxbQX3yT+KMoPirqqFKufG/u1AyXLU/I
         kiMXaGmpG5AixYTKzFxoEpc2CD1tnpLZKpyqiPEHmCYuDeeP3VPvkkgL3GHrjme3o4+q
         5ziZTE+H0T+v2Tir4pQkAY3lz5+AykgPong/H2qVCPO0+OF7kifXzZdW0kXetT67GV3x
         p5cVxdDuI2RPTm1Hq2qPQW/Pr25Vv9v3o9KcybaevwZAHjvoDWw0dKNyD/XIUyVxWode
         PpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767180023; x=1767784823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TXDHUxZgK2BZrRgxIJ8QsHtEdy7CS+cUzQSNiUuHj6s=;
        b=VC9strspmz422D40fXJFhcSlpzhBaTntbZp+InlPZLlNR05Sp5Z6SrxF28bxRf8p57
         lEEybS/onDclpS8lOTivMBIHIfwXnc3l+J/+7NnUblABN5HFe2uE4HjLAy3faIyJ56QD
         OurN/oEXQuqAREzvRqRSg5e8FTIYOE0uCpDiCVcyYDQsJE8rnA0gPbDoJCOMJJN8Kg2z
         bB7+2VlCHm42BQZsvSIrEJ3ofa/DUrHpIsiAKGHS4Fxaz2f1S2BN5FJsZDturs1q9RPZ
         O08XPoCMoXTqvLbJ8vY4OZKHdSTaFI4SmPpEM+sU/IM4PlIYqhZG9Z0WUg/E1t/68bvK
         dgvw==
X-Forwarded-Encrypted: i=1; AJvYcCUM6jKR613+1/1p/fz23en6LVhbk4e7quGypPkrWG9zH29gume5hWx3oA2Rub/X+7Wu30MDXn7T5Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywite4waRcFhSnhOa2rmXib41jXgd4RzNGg/N8QtbHZTnmLie/2
	CqPQg4FECJguJlRcPjLRcV4b5jJn8e7tv/j74PZbCp8QcatemNrzk7eJMI7HWf4Hj+c+eQfFq4z
	g6gi7K9EdJt8nvrtCVlsYPaY7Riyzzbs=
X-Gm-Gg: AY/fxX4tcx9r8cYiqvtsvZbjtn5Hb6E8c96T+vY0iCurCAlzt2gRBPOSlDp6E+zF8xY
	PCXSIkkJboPAMKjlx71PHbl06uVTt3c4mjYCpsy4EAFDIrt5PzT1RTcPbFwcMAuodrVogfuquDn
	dqf9qsUFdiuFSaAZkrf5lu9rP8Z2phZcnJLuL+Q76DJjJPlQsAZP4R+P2brd5u/c2n2SkeFwpBN
	cj5dpoDLeVV1jVXQDG1yPQRiT8uhAlERE/NSqS5yysKOMWNdK0ujN0j1d5PaiATyyz7WG12gnIb
	83F5wsJeknuzqGgCN1/P191fkU6RojqkNwtKonNS2PvEalegnWmMydg31h/36kVaa31U3oTbToo
	3N7vR0aU=
X-Google-Smtp-Source: AGHT+IHd70x4z9NmirnC62VS9ymerJNPW4rVUIIw3LMjCYxypAZjekhi2eC185myWRoZczMXIoB8CRCJ3FXmDIrtSLY=
X-Received: by 2002:a17:907:7fa8:b0:b76:d880:398c with SMTP id
 a640c23a62f3a-b8037255548mr3957841866b.61.1767180022543; Wed, 31 Dec 2025
 03:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230123609.210454-1-suunj1331@gmail.com> <20251230132126.217802-1-suunj1331@gmail.com>
In-Reply-To: <20251230132126.217802-1-suunj1331@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Dec 2025 13:19:46 +0200
X-Gm-Features: AQt7F2ryqyUts5FXfTEBVtzTGvG9ylL8O5WrLoIb8eqNV-y-CLhhSSBQBpxDr8c
Message-ID: <CAHp75VdOX_h1Ksm4MbYyipiSpGrTp84GTkUAO9L_0o3auR3Xkg@mail.gmail.com>
Subject: Re: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset mask
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, andriy.shevchenko@intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 3:21=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
> twice instead of checking both SOFT_RESET_MSK (bit 0) and
> SOFT_RESET_R_MSK (bit 7). This causes incomplete reset status check.

an incomplete

> Fix by using both masks as done in regmap_update_bits() above.

...


May I ask how you tested this? Logically from the code it sounds
correct, but I haven't read the datasheet yet, so I can't tell if this
is the expected value to read or not.


>         return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
> -                                       !(read_val & (ADF4377_0000_SOFT_R=
ESET_R_MSK |
> +                                       !(read_val & (ADF4377_0000_SOFT_R=
ESET_MSK |
>                                         ADF4377_0000_SOFT_RESET_R_MSK)), =
200, 200 * 100);

Okay, I opened the datasheet, and the below is what I read there. The
code first sets the SOFT_RESET_R and SOFT_RESET bits to "1", and waits
for them to be cleared. But the Table 43 does not mention that
SOFT_RESET_R is auto cleaned, and actually I don't see with a brief
look what the "repeat of" term means.

And for normal operation they needs to be 0ed as per:
  "SOFT_RESET, SOFT_RESET_R, RST_SYS, and ADC_ST_CNV are the only
remaining RW bit fields not mentioned yet, and must also be set to
their POR state (see Table 34)."

With that said, I would wait for AD people to clarify the programming
workflow here.

--=20
With Best Regards,
Andy Shevchenko

