Return-Path: <linux-iio+bounces-24003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0153CB541B7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 06:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F31B26498
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 04:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4C26CE20;
	Fri, 12 Sep 2025 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC8mBrKf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B9260587
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757652035; cv=none; b=Mp48ChwvlPUMS/lt/5fLb/B9vQYvaVzv07OmgFNj0xMcyZJTdwCU/UV+bbvrYClVW5Paawpq8woWoqr/L1soMh0FFMEgGEOZNKYEC1Pe6rwteBZybDY5Y4gKuDlVj/rpqaWjq9+UGAIdeUucaJ0Sx+30zWwp5KjoJYWVrz5SB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757652035; c=relaxed/simple;
	bh=JnOJEtY+4oI3dkX6hygsdXN4IOFa6dvROTGR7RWiews=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdLakAYDd0jk35f+09OfVkBziqHEnk+kwWXIZv3McxRnRooIXW+PSWbHiTD3dQ3S5ln01WK5/cosmmqHhZgBYsfGicR7sUYKAQvNYUTFtMLC2YU4u0hW+1koMtL1bF0aCaj0XdYnhCVpS/bziKShtMx/LSLpvoAKG1cIJZV6hbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC8mBrKf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b046f6fb230so280369966b.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757652032; x=1758256832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnOJEtY+4oI3dkX6hygsdXN4IOFa6dvROTGR7RWiews=;
        b=JC8mBrKfDi/iIlj8wB8Qmsq9Hoc2xJG+q1zh9JctvJBUVZiyzNSVPs6i6QlRYBuRNB
         V6dp6oOii59EGXDgNWQQOsbHI3Olsejg3yKAF4CIe/zanjleiSdEsX6X+Uy+gBc4kQbo
         YnYmD8BD8i0qWDJJhYj8rjzoQxAISmgQWTY2Qb/iqb/3aYuI3EbZGYm+d8sirDR5p6/+
         MWAt5T1Op0d8pRRAe4rsmDa5BrD9erSg3QDvSMf//X/Ygx4YCYqcxQck1SCKYHflKCsR
         31ZAcdEy/RsasVB5yTg9ZlgccpftOV3jx6W6nLhzYy+XwwMiTjXf/xwm564rb6nyhPlK
         KciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757652032; x=1758256832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnOJEtY+4oI3dkX6hygsdXN4IOFa6dvROTGR7RWiews=;
        b=oOpyNVZAkEeI8lBwg6DCnr+o/hXrcFnJ16Mm8A3UX4TzKHPJ5an9LquwDEWSOIdVHe
         EE2NIP9hKnt8x4U44jWayNVk9jAvCoExRFBRfOUMiAF3SCvZnPmTjuB54Yn441lRFPxg
         wrPRPiBLXe1Bt4gMRHoRTMEttZx1SjaDYNFKZXcxcOYDSBASsOxAHFloEIKmHC9zilJR
         gxONQ4rquUZk0S5T5XBbU6dzn88BQfHudfjX/c1kkPe+aHjnUpnQE/hiaROOo3P1e3hz
         LP4XybgCJAiCoa1+oZANsnOYD7JrZ3Tp6bKcSvLGM9Pz5DH8Hf7RbHoD7fPPsK5Y6i/E
         s/gg==
X-Forwarded-Encrypted: i=1; AJvYcCXXML0y9v9THQdAOvhdCU4nDow7dcPG/BOqQQW1uXeiJHagWWRqmXWQuXurOUtlPffXLY59eBq1jjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TsWRCncsLC/jzq97e4uQlbQzALvoi+92yn4Cp7V3+a985GDl
	g6mRdwWth/lMvqIx+qwObsLvtSuPLBuNGowlYdNNQ6mJdQ63Oqk4cs0vkDr2hkKrIH+frMR/r6o
	Cs8AgT+OmrtADET8fUSUHsi8D7rNGqi5Z/TVl4Qg=
X-Gm-Gg: ASbGnct74X9CR63q8ki5kH2e6ghbmp2XM9s3almP3ATWV1m/Hek7YoB4x8eHW4PVPbY
	nEhA9jEHZKhHvp7I0ZNUT8MYo5GgLCxQu5348Sr/owod1OH2xp4BurRyoMRSodMI/tO6NKkEoDo
	4xJGhSBTmOZUhYlJfjS54C2TwHcDrdueDPQbII9zvKd4UkW8K/NzHVYQk2lwlvEbkUxFS4uG2aa
	H46f5Q=
X-Google-Smtp-Source: AGHT+IFrfcnrpMLV/t/LzuVFjBmS4lyJP+lzg+q2uPkMoRZmooYUhr/7XgxZrK/LZBQ4oKfXikDeXrDmovFmxBLs76g=
X-Received: by 2002:a17:907:97cc:b0:b07:8930:b09e with SMTP id
 a640c23a62f3a-b07c24fbb4bmr175250966b.20.1757652031494; Thu, 11 Sep 2025
 21:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-3-b09f492416c7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 07:39:54 +0300
X-Gm-Features: Ac12FXwkkmmo9DDKVMvnCsQpKMsHCLWHUjcsGaAij9tSRV7t8M9EQuR242A3AIs
Message-ID: <CAHp75VdVUOxkKhiheujAK0gjk_GXGqQ0g=LhNDjZr-Of1gH=sQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] iio: adc: ad7124: use guard(mutex) to simplify
 return paths
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:42=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Use guard(mutex) in a couple of functions to allow direct returns. This
> simplifies the code a bit and will make later changes easier.

From this and the patch it's unclear if cleanup.h was already there or
not. If not, this patch misses it, if yes, the commit message should
be different.

--=20
With Best Regards,
Andy Shevchenko

