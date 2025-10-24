Return-Path: <linux-iio+bounces-25413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CECAC0529B
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 904D5564828
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308133081A0;
	Fri, 24 Oct 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX2s72mv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBC305E2E
	for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295140; cv=none; b=B/5eXEhZ0srke/Fyg+PSAVD9GQJgDZq76CCyo8SPEJztAIOhE72Cbcw/u4axR5ItWFBQ4huaoFjCxKjibkoCrEFuZVCg5RlHDMJ6+Ge1Fj0WSSk0p3IFDjrCU5bhowvj/GCiZwT+Gg0v0PFs0SSJfTyNQRkgQFO076Krk4LPgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295140; c=relaxed/simple;
	bh=WXCqwiJaVzwif74IHtQzyPxXFrlHw+EGeR8pfbgmG08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9RG+qhzRE0G+sZUWboowExGq3fHGS6ux8323b3GbLgcGdu0CHbhYguTo38s9M2ZVP2WYYN4VCLgT7FVfczuNtkj8oUnL5qIqcNdYntmLdFhbFBOuVELbW3AW6GAYxWUo65RbcYR+8WSMiKhMOl1UijUeP4UBHmFfxiGUPkS0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX2s72mv; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b6d78062424so38794566b.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295137; x=1761899937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOoOk6fIvEaDShhUmAzlzdMKvgXXV9HjXrl++QyhiQI=;
        b=NX2s72mv9cBjMc5Fwa+10R5tk+AsdfpiTQVwN3tMWFthG3RwMzxr9zNDiPxGRXXpgA
         yDVLTyg7oKTd6tu0LrL6z0aC97r181X17EiWbDfV7forO0DkaQIR294mt2gZ0eYHqK1J
         JEWmDLnxerR0oSNlvxEQ+2V9snXLKou2wIU07eLQWIdmHGVKMiAMOYFZoq+ybN7yg1EW
         GG3wKIso9Pb2vXuwrFmuS/dZtDrFq6hsAyiSLxZOVwSM51KU645Lcmoz/85H0b47VMFF
         ZQWOIerznZh3a8JCloR5FjKu4zWwowiZYtO6ZYBtuC3E7I0d+Pt4i445kE24u6AqzKbz
         7jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295137; x=1761899937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOoOk6fIvEaDShhUmAzlzdMKvgXXV9HjXrl++QyhiQI=;
        b=TER85EBs8BFSonk841ETJF3+mP7WjODbiuwO3ZG6uICCF59P86Og/gSNCGGkRJ/4z/
         VKsLwSgl9E6A9NcU5yx64uDC/S1MjALduHqDEwmPCNA4zfwSfRlK0ZvisDa6ZGPbSY4F
         44EfD9mlym8zrNTHYXbXS4Hc/kF2TCQYmBQuz73AdD7/JE0mDDZA4Qd7oOWtexG/Ck88
         dFnbcsQPKxS+h8o7DYo3vCVwOFY9kB1o3/WNJB9emFoEwFz1gjCX8icMET367QUqTbxA
         4BU99lWRf12IMOfz2gam5b33UprJTVauFeeQ4DL3o8c8mHhGOmDCsKYoycJFmS9PUkgN
         l3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoEckQz4Yn9GTs7aod5VumGAhdHxoVpqpYEBsGp7fNKSadMjKJbHadwtAJkZZ5Cilrz6MbqPgEorg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6W0Js6T0WlDhtelsGsbmOCyi9BDJkU5dXRyFYU0aYCN7q4n0
	mw8CyivSySxN3y05yCqvA+OHXe9Q7Ve7u+agFwzybD6PU+fvxMNXWBIEr4uLjeWO34zp2oe/Ekq
	b0mv96mwq58aCEswbOPPhFQ24zvE7Mug=
X-Gm-Gg: ASbGncuuHQiMG90q/ODRE4DrmodsbC8ppJ6k8Ius13V/9nhSOwzYl2VBH7MPsLaAt5p
	FNHizSaVtojdW2+CG3M9DrHwmMVtGfC5WBOtdOfhWyv66JQJto99vSB5HTAtpX+v6TdPzvoc1/N
	p+sU0c6woc9Egpx5nvQ7YUELLtTK4uxbsAtl4Rrwfh2fKUk1MUSWawq9wrQtQAvZqlFieZr7qLr
	LBP6+bnxNJDV8SQVhgGb8u0g5K6MyHO8VwILbEpVf/WqYprEbvVu34xXKvTmZ0nn1X6iibW
X-Google-Smtp-Source: AGHT+IFix1z6tMmwfjPEG1oQQ06cd/niYVFK7A3ERyfKb9o0nkBTriHS7CNo7xGrw+fDhLGT1YJYfTTjX20y7ecwqRg=
X-Received: by 2002:a17:907:948f:b0:b57:2b82:732b with SMTP id
 a640c23a62f3a-b6475706215mr3433422466b.54.1761295136987; Fri, 24 Oct 2025
 01:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012173035.12536-1-raskar.shree97@gmail.com> <20251018160400.6921df6c@jic23-huawei>
In-Reply-To: <20251018160400.6921df6c@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Fri, 24 Oct 2025 14:08:44 +0530
X-Gm-Features: AS18NWBKc75onvPQ2KcRtEzbrT_rOdOOZhjS01vyTKH3-6a5Fttp43NYSt_gDrg
Message-ID: <CAHc1_P6a=6MGT4_6mmMLzBXz8WxVv1C29iwDwXrDywV+Z2k-0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] iio: health: max30100: Add DT LED pulse-width support
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 8:34=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 12 Oct 2025 23:00:33 +0530
> Shrikant Raskar <raskar.shree97@gmail.com> wrote:
>
> > Add Device Tree support for configuring the LED pulse-width of the MAX3=
0100
> > sensor, and updates the driver to read and apply this property.
> >
> > Testing:
> > - Verify DT property read successfully in probe().
> > - Verify default fallback to 1600 us when DT property is omitted.
> > - Confirm SPO2_CONFIG register programmed correctly using regmap_read()=
.
> > - Validate different DT pulse-width values (200, 400, 800, 1600 us)
> >   are applied correctly.
> > - Validate probe() failure for invalid LED pulse-width
> > - Tested-on: Raspberry Pi 3B + MAX30100 breakout board
> >
> > Changelog:
> > Changes from v2:
> > - Fix DT binding schema errors
> > - Add default value
> > - Remove changelog from commit message
> > - Add missing header file
> >
> > Shrikant Raskar (2):
> >   dt-bindings: iio: health: max30100: Add LED pulse-width property
> >   iio: health: max30100: Make LED pulse-width configurable via DT
> >
> >  .../bindings/iio/health/maxim,max30100.yaml   |  8 ++++
> >  drivers/iio/health/max30100.c                 | 38 +++++++++++++++++--
> >  2 files changed, 43 insertions(+), 3 deletions(-)
> >
> >
> > base-commit: 8bd9238e511d02831022ff0270865c54ccc482d6
>
> Applied to the togreg branch of iio.git and pushed out as testing for now
Thanks for the update. I really appreciate your time and support!

Regards,
Shrikant

