Return-Path: <linux-iio+bounces-20015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7699AC820A
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 20:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DFF3BCA90
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6695122DA1B;
	Thu, 29 May 2025 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7G9CArz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6221A931;
	Thu, 29 May 2025 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542627; cv=none; b=mj4v/3qGr39MssIuRN7x3gOq2RJ+j/uPPMcwpYehkDUEglauInb4Q2IgcOozycYWrNf+DDaBiLtlc2S5lW3coXsVoW3XMdp8eoOz1Sb+qIUStusGm8CzNhLh/jQur0LwBvyRDK/3Q5Jx+iqVL9ehAhFAkO0hMiLJKFNm+saVDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542627; c=relaxed/simple;
	bh=qpoBvtm6ea8l0MnxcBFqYjnL6/WyamPPJfPi8ccdDFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCx9ylbwH3KKFhcwWS6FKL3Cubit7QGiTamlAzjnsRLyeZIDRrNg670LG3WXf7N3LdV3oCTXp2gc22R98SSpzcE5YybXD95qymPg2OkNFDaafpE2TJ++TegcyR/ivs57KLXo0z8bjBZmXHvWLiOArkd5o/rMxaCFdEvqtjXPK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7G9CArz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604533a2f62so2202697a12.3;
        Thu, 29 May 2025 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748542624; x=1749147424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpoBvtm6ea8l0MnxcBFqYjnL6/WyamPPJfPi8ccdDFQ=;
        b=i7G9CArz+gL9Pl4rlYLB3DyHQzea4jECCakT3jKiih4VwbDTwqcmCrR4KWU34oG+Fk
         3l9MU68GDQKyONdlRtTod8Zw5s7bE8i17J+e3MecjOTQHSVu1t0nCer+Z3LmAL20W4FT
         A2GnFimONnL0vdToX13UWs8Pp7FUCBPg6I3SA44Sor8ljIKyeFp6sp1LNn7v+0ykRJQi
         NZpAyfp9ZBwUPO0Q0qlb1HCXovoDK3v4Xzo17koJqp3v+b1HqBUPjIbp/lRM+ZamQa4h
         nHyURLtsewvgf4PWOg94vOYPdYq7yP48eP7zGhkgXV+iETTzcAbmGv6R7F0DbLYbEUfl
         Hu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748542624; x=1749147424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpoBvtm6ea8l0MnxcBFqYjnL6/WyamPPJfPi8ccdDFQ=;
        b=HDehTtzvoML7iFnsqfH+tLTiTmii2DVaW+dMrxCZf23Esx8Z5mMvaAvUarfcNghFUK
         CShJ8a264qc7h8Hp+Hwro+VvfX0x/3euhHJZyNhgniQ+9BwZMT7w+VlCKd3dvaPK9RuQ
         cMa5soaoZZH5oGYOUgqddFVyip/ZmeyMA1mWdaH5Xv3RCzdHritmdz7wpLAkr8E/p8t9
         KZ1PdS8TCNy1mHITzWhYMGOi/K+lsNqmGeBxOW6CcyH8ACI2dsebjCMJKXjFA6oHerV3
         JYQdLHQHhJzaoRTOLh09PZSFEOfe1Xcii3Q99rBALf1xeDnmaeMdwobb1p0M0BGDg8IH
         M1yw==
X-Forwarded-Encrypted: i=1; AJvYcCU37ftoJxuH400vxzjD4L/uPNfAvvDr5xIUIu2Qm9Qk6bSjZuo12yn/v3tWbOQw43d7OKe7YwbovMw=@vger.kernel.org, AJvYcCWGQt1fJ/0mHWsa0t7wkq372yaRcsbNFHEkSzf0NdpJ814TcwAEnfddOPeYbZ3dYp/b92oVHW8/nrs1m3dW@vger.kernel.org, AJvYcCXi5BVYGYWuUPruQVh0vORt5PSrw78qmHi2mUPrWERL3JV6SyMeR1BkR0SOmJfpg8yzfxR//lCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7fd6tsLQvDOOvTPxZJczGGN5La4gO/4SVBJQ+VTQnIw//3Ik
	qEno/4f+/gXb7l5DvR5B+BKtFCOw09Ob4zkL2gdOGb3Ef6oKTsnoW6LJ8NrD0/MWK5FLyBAjwb/
	zYOFg23d6Rlic9x3NaqIjBJKX5kstOeo=
X-Gm-Gg: ASbGnctFxQzgSSmsawloGwI4GI9ilWu+X+WJLot4NqHQ9M4sN1iDWBotnIw0mhm+JR8
	8zrL39B6xqkkGArsFkmd8jJnwapJzdtIJ/5CXOMWwEke//McPnyYn1Hj2LlGuOwudmRnmoIwNFu
	ul7EGXx4XAxvTBwKeqXbk/Boi3STozMLCD
X-Google-Smtp-Source: AGHT+IFM0+piKu1rGaqMi0pKdb0lI6X4rWTslZyASxD990s/7Muh8t2GyRz7YMaetwaRiDgn9YC/e5rYM4mNGJx8nag=
X-Received: by 2002:a17:907:961a:b0:ad8:a935:b907 with SMTP id
 a640c23a62f3a-adb322b3682mr39557766b.8.1748542623490; Thu, 29 May 2025
 11:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com> <ed40509d-9627-43ce-b209-ca07674988ff@baylibre.com>
In-Reply-To: <ed40509d-9627-43ce-b209-ca07674988ff@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 29 May 2025 21:16:26 +0300
X-Gm-Features: AX0GCFuFcVPQH9mVs9Dm7_Q62qwCfnDpYDtGhUfXX9m4Hv-KJrr05FhjEekc0OQ
Message-ID: <CAHp75VeAOFXuxsiAEwJ=dMJ8NZsyA7E-h4L=2ZgpprdUXU2EUA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in fxls8962af_fifo_flush
To: David Lechner <dlechner@baylibre.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 7:02=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 5/24/25 5:34 AM, Sean Nyekjaer wrote:

...

> fxls8962af_suspend() calls enable_irq_wake(data->irq); before disabling t=
he
> interrupt by calling fxls8962af_buffer_predisable(indio_dev);
>
> It seems like the order should be reversed.

AFAIU the wake capability of IRQ line is orthogonal to the interrupt
controller enabling (unmasking) / disabling (masking) the line itself.
Or did you mean something else?

--=20
With Best Regards,
Andy Shevchenko

