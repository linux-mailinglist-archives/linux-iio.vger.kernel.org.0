Return-Path: <linux-iio+bounces-18551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D48FA97AB7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F85460736
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD582BCF52;
	Tue, 22 Apr 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COF+EbeI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB452C3759;
	Tue, 22 Apr 2025 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362432; cv=none; b=RZLP3QTvkXT5SUgMcG4E4tjdyVCDx2QC63rIqdL8b2sZZVwtgTpNsWVH/NYmtu6e85n0n0kJvVRHZUTTFUacn2gw/BDyaFj7PmqE58t6f0C5ZWfggyN2hcFHMMhO5H3MFxO60Sno5aMGIMGy4KANg7ZfcoDGMYk0wHVs3i4kDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362432; c=relaxed/simple;
	bh=R41URHuvizW8HQzTFTrec2A6inn8BZR/ujGfQSBTJq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYQCybkID6La8lMXw8lSp5poTXBlVPosUL3M0WX3J+pzJUnj1c06bPza7szIypIOHEsuF5LnANYCAMmQqWHoZM1sbCT2A+KFSoulZrIJkiTynQT0AR2V3FNeK0JdB8iajN1vJ+mgbe0tX3oMbSHzMscFbhhUTeuUSmXFVF1dni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COF+EbeI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f4ca707e31so8554480a12.2;
        Tue, 22 Apr 2025 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362429; x=1745967229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+1Ngscj1sLQkaXbBjPeNhRnXqru6dzUdV9MGLQmLQU=;
        b=COF+EbeIoFPip2u6Yk+2WgY/Lzd+5F3RLvCPgYg5u+Ac3APMn5CL84P3xbqFzG0eOp
         y7VqOY1MDuaD3DD0fCs/H7+pSqyhEdCUtEwSnEdlqNpAVxSenNjo0Z2W9aHV1U7DGnv8
         Vwr013EFIsgmASdIplEHkBRzQYkZnQn1iZCJzq24nPbNoZGt0dPybQp9UScYMXb7Msmf
         CoqIwkgYIKeaz764PdZFMUai49w+Vml6ukl22oYSgV7CRJuATclJW2BiuNc5ckKvBwGT
         yPKbS7fjIu+VLy+MXIZihKvmD7g24DtB5hxayhpPkxYkermHeoCoIuoniN1Xu0QuMej3
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362429; x=1745967229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+1Ngscj1sLQkaXbBjPeNhRnXqru6dzUdV9MGLQmLQU=;
        b=D8viNnr0D1Nib6gw8+pnkWOqGnR4UOKMaqUt3vcsNz2qA9FC4ZtR2UvJH45JvlgvIy
         Qk7iOVhe418253pFkjGLrjVVA3Ada/GbHjziuoKklNYRuTHYkwiIZQR2eZl1JZyzQzqG
         nhyOtGKi0HYCliMPJvEZsGhhr4vK6Ay+xbS7uvRjmPCTTeMRMgOuuNxx9+Klz8ECxdbP
         omwLKEoEKLlo0YcLH95dz2/XhJ8CjF5gnWC4Nt76+eRfRezhAQIBGKDrHK5uXdn2ushc
         xR2bwFkz52lyYLmhOVRpVTO6DF+gx9fr0lZheERIbf9kOYfUZf2Rqmh32h2g21kx2US3
         yQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmIf0BRr66jImRfIfm0GhhhnxArOCA4sQx45+/lLAok5VFk926ySjvx3cXs0GLnT48HhtjGQSWYLbi2Z81@vger.kernel.org, AJvYcCWiZSdeNEQMRdeA+xWw/zrydAJWDGL3+z+Bjv5seVwB/S1pablCy5wXWavgmRIKWCrgWmCuMVkK82E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvhk0EwsbZ+bq2Wt30ujxBtPceknXRP09Jtlo8UuH154RWpVTi
	2XHc2xH6QFq3ro9fXtV0puHIEFYUEUO3Qkt7wBb9icyeBenv9TGSJBIGTR8wez1aTX08XxTd5l5
	7un99Riwg1nZYY9Z+/OAR2IfsA2A=
X-Gm-Gg: ASbGncs87BAUwipf+muIBmSaTdaruo30F42EPe8Nt48xgdgkvDqf5vObNBR6TisvRH6
	hG6aLtekKRk3Z3SwwkzBXeUsdQott4M4ZyVu+Kn1GWsLYEWChWCVUkuxR55JIFzs4jBziVZr+o4
	eO9dD0A/TCvvxvBIxJbMd3TA==
X-Google-Smtp-Source: AGHT+IHMPrXJqYYAB6pAgjxvZ17pVvfJXLHs9OfoWIoo18nkISokZoisDnXlemOEpRBjn1DUA8AriHhqSMFKfX2dk+I=
X-Received: by 2002:a17:906:da81:b0:acb:ba0f:4b0f with SMTP id
 a640c23a62f3a-acbba0f4c70mr579009566b.31.1745362428662; Tue, 22 Apr 2025
 15:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-4-3fd36475c706@baylibre.com>
 <CAHp75VdqanGpwB5raE8AmH-Tmb82N9yYmhB+k_rQtc2_Zb8HQw@mail.gmail.com> <55f8a997-77e7-4d07-aec2-8d20f56314d0@baylibre.com>
In-Reply-To: <55f8a997-77e7-4d07-aec2-8d20f56314d0@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 01:53:11 +0300
X-Gm-Features: ATxdqUH1YUeTsEMT0CwtykvmoOSl52HrGojQPmTu1v6wjba29-5vfKptJFLiT2I
Message-ID: <CAHp75VcoXwBNYmpNNCWbp1mOtJ6UJoKfxymRBRok91_NS8RcTA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 1:41=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 4/22/25 5:33 PM, Andy Shevchenko wrote:
> > On Wed, Apr 23, 2025 at 1:08=E2=80=AFAM David Lechner <dlechner@baylibr=
e.com> wrote:

...

> >> +       IIO_DECLARE_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * s=
izeof(u32))
> >
> > Btw, why not DECLARE_IIO_...() as other DECLARE_*() look like?
>
> IMHO, namespace should always go first and people who write DECLARE_NS_..=
. are
> doing it wrong. :-)

Not really. AFAICT it depends on the globality of the macro. Those,
which are defined in types.h are all DECLARE_something(). Which makes
sense. So the Q here is if the IIO macros like these ever go out for a
wider audience. But in any case this can be amended later (with maybe
a bit of additional churn).

> There is not existing DECLARE_IIO_ to match anyway.

True.

--=20
With Best Regards,
Andy Shevchenko

