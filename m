Return-Path: <linux-iio+bounces-24007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5EAB5421D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 07:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79235567C0F
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18D274B44;
	Fri, 12 Sep 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUv/zMzU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB723BCEE
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655559; cv=none; b=MoHLiVhPYiG0djWpDizCn9Tdv62vkVZE97TzdXTna45w5KUqR6Gdf0K9XSQQwu/7rnSYKkBL6mHeDJzPFKvqpK5WtqXgJtRrKt0C9woZdb2ebiKiD+Eei8ILtETes06TpG4dHIkc1Qt0WtUMfCcYjhgg4jDlogHfjUv/N0U+3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655559; c=relaxed/simple;
	bh=Cw4butNgp+M8PS0EaOjYSmn26rCmVDJqa5vIVv/kH7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umerCc5t9NCYf24jrvNTIZzWVKBq/kkDBzgdEAbc0Vely4rdpAWJJfiCO7KL01b3SiK2ILRTHDdWxv0XsSy1R8lOli+xSWP6/kQLkCl6UU4RwaZUhFm+1COO/k743cjjtOx4EWIRh7KJ9Ea2X08AiDEJUopGngofac7o5ClrMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUv/zMzU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07c38680b3so66288166b.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 22:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757655556; x=1758260356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH0Afa714fvtVfmdaqCtg2gFW/ZwCcELG2I0LrcyEII=;
        b=EUv/zMzUSfGcPSrn7giBDe1JM9vRpoGUhhVCt0+PS+YrQYn11+OBZm0D2wnsDWQ8mr
         O1h/Mgjmoy3INkzzqnOZ2rReTTpqb0SNJZdDY7TsR/M/BSmuIni6peoPkwP9wmxb0pKm
         B54qpz5Fet0ETabtUToj50QKrkBanEfTwtgib3Q1Q409cGpHLa6HaTEb1n2P0m1ZgUOy
         K5Uut1niV0ogyucUCg6BarmIMq6tGl5+sjzK/+zHXdQC7u9kmCF7wKph2BvnhmEMRbO2
         g1KgL0SmK1VpYjkmtGDWidqiT61NHp6r2xp4fKuKE9TlhhTee3bs0mEy3ZJudGhc1OYJ
         CTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757655556; x=1758260356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vH0Afa714fvtVfmdaqCtg2gFW/ZwCcELG2I0LrcyEII=;
        b=GysGTmjqxp/oG68HO/wI/ttJyprxqlEZ3wY3eOOpacLr96RdgwJBmb0f6RaJyXzcbh
         kKmpo8nBSIvKePYu1kyr8g11ZBLwYySr9pqQDzdNiOZs6/vaA/0FSAyMbsS90KFPadOn
         wOdK1+M7RtGttfM3bcbI4huLKqg083ufVUjNfBOh14eUnT2ooAKY2xIJE4dmGcuryRik
         YZdgB9Cs62atndUx9xrgVZPxiRm1GGxz/J4luv4FcuY5mKfXzG8RSbBwkZ9MpZpK9yDH
         8h4zh0+JvreRq2WoFE3Qf+ODwDwZGT2nyUDY2Espbq1ZJw3SG3stJCho83rLMLnfbGVh
         TbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg1GVx3YCrU/Fjz65GJtv4S+ZOPnTkxuTb94iIrwHYXTa6IALOlrQ9YZa5a/z16tz3FLPuRX4GC2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5GPMgD0Ev1g4m4967A5rkZCWDtTJ9tbLKtM3PIsF/1mUJwmp0
	G8o7+VAEG1Q4VdT0lNYgo/qaS/lRE7jovz4GofS3YMMTAN+9+42mKprc2atlS4ygEKPLziw7IdH
	IdXLX3vmS4hiIfu4i0UYxaRmMtDavqdU=
X-Gm-Gg: ASbGnctH65NJhDQdUKZnhYIaO8RdSK920IQjNdaN4vrDlvjApxGNAefzlx+ij4boy2L
	mjsFStEv72GfaZki9Ca1NI5enhex1Jf9Hchz29+TmuNagvmm7HAepT/nqtW1l0j3wViF0AuT/hn
	RodRBgQxjvJPW5elW3k9PwpD38xzv3d56bW8WgV2xBLEGOJSdbohCvjKjIy5Nsbsqgt6+Jffr/x
	wdRr14RyEto6vJL+E8ZBgyA7Yhk
X-Google-Smtp-Source: AGHT+IG60HJ4b1fJ4dk8St0WhJ1SX1AxKjx2gKZnbNVTZ59Vw6b7ERyt7G4PUyCug0AMO75WHmZcgdfhh1sgd5jaOJU=
X-Received: by 2002:a17:907:76a5:b0:b07:c90a:8ade with SMTP id
 a640c23a62f3a-b07c90acd21mr54196266b.20.1757655556307; Thu, 11 Sep 2025
 22:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910155759.75380-1-daniel.lezcano@linaro.org>
 <20250910155759.75380-3-daniel.lezcano@linaro.org> <d53b22d1-35d6-4fb8-ae56-3ba4953b64af@baylibre.com>
 <ea57a466-97b3-49d4-8d1c-142fd49a0da2@linaro.org>
In-Reply-To: <ea57a466-97b3-49d4-8d1c-142fd49a0da2@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 08:38:39 +0300
X-Gm-Features: Ac12FXwz8S94TfU3YcaY1R7trfgV194Ut6I1vQdt1Jx09BV9gffwQdAifTPMIRw
Message-ID: <CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
	linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:03=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 11/09/2025 22:10, David Lechner wrote:
> > On 9/10/25 10:57 AM, Daniel Lezcano wrote:

[ ... ]

> >> +            /* iio_push_to_buffers_with_timestamp should not be calle=
d
> >> +             * with dma_samples as parameter. The samples will be sma=
shed
> >> +             * if timestamp is enabled.
> >> +             */

/*
 * Btw, comment style for multi-line
 * comments is wrong for this subsystem.
 * Use this as an example, Also, refer to
 * the function as func(), i.e. mind the parentheses.
 */

> >> +            timestamp =3D iio_get_time_ns(indio_dev);
> >> +            ret =3D iio_push_to_buffers_with_timestamp(indio_dev,
> >> +                                                     info->buffer,
> >> +                                                     timestamp);
> >
> > Is it OK to call this with spinlock held? It looks like it can call
> > devm_krealloc() which may sleep.
>
> It should be ok, devm_krealloc is in the code path of
> iio_push_to_buffers_with_ts_unaligned(), not in
> iio_push_to_buffers_with_timestamp()

This is a good observation, can we document this in the respective
kernel-doc:s please? Also add might_sleep().might_sleep_if() in the
appropriate functions.

--=20
With Best Regards,
Andy Shevchenko

