Return-Path: <linux-iio+bounces-26770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D3CA5122
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C45430577B2
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0A348468;
	Thu,  4 Dec 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFv91Wxq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEB347BC3
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875351; cv=none; b=MC6q7p6Jbh7PspGbto4GSMBW2a+EIAIJO7323AM3IZl+PotLvHZFF1HLF+akpUeQTm/es2LDwCZXfnPz2LASglOeTp1BPTTWd12Cs8zfuDz2udBxVA/a5WrYsxE/owMqtCUNH+NFAhh3WMxBAkUSqtpjdJiy7D/L6D7pqcO0x3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875351; c=relaxed/simple;
	bh=oIiCE2xi/Erk35MxEw0TBeShsC29RnTxb3mcE85UQQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VE5dSeWWt6o2lUl0bWhoiNew1SONHNa/cy5z9Dk9InSJodRy8lOzm/sctOj44zpqjcLrMmF2F5KfhPMkpKXnbOMyGGiXu2jSJMPhH0CdCnLaK9A70/flnQSF9S5Lj4Y0nobm2TEfo5LuQquKaFzFsxspMtMGe7T1d/IClN9llNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFv91Wxq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735b7326e5so229791666b.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 11:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764875347; x=1765480147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIiCE2xi/Erk35MxEw0TBeShsC29RnTxb3mcE85UQQw=;
        b=XFv91WxqcQbspOpcFGuZOFzVJICaHs7Tdt4AKJuBEOEXaJ4co8xKEqYV+g0LLGepox
         VAwUZtfR59n/9SgqGplsfO4xdS66ALH5Th4ReAQf7/YyePLqhZaYetVvBTRqMiefEE/A
         n1KKbpuvnaMCH2vWrcA8RJ8NE+h1P2MbWZNaV1fDjoYJu0CiOFA1gOec2PGbCk9Fqlt8
         kRqHmt4zobwOrwmual8vZQtNhg7s7Mynnry0LGkLjeCxCzO8XIY0qnRcM9PvkYa1phcF
         JHyjUCZG4QDE8JGUn05LMWRJE1dgrCp2K1kCoqSAspES+aElnkFGuRTgZNSSyy1BrduU
         cgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764875347; x=1765480147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oIiCE2xi/Erk35MxEw0TBeShsC29RnTxb3mcE85UQQw=;
        b=uBKkZBzylSpgsaqirkI7TfuGQs7Pigh7fp5fYr2i8U/k3YwY/hXyVjB14gM26f9z8n
         gxChBmY0KKHNyJEuGli7p0V+Hc/kJtVDamrFzHFULkc/k6mXs4UgT/ItWdc65mXpLnqZ
         yCfScB0jzDSOElegtM0jh/fz+zNu0XIrX5AbNSSfFkrojk3TyenYiIJ/ppP1bGK3yu7/
         8wpOL/DNFYtoLDqOC+LtU7oyufyA6x90NTIrKXctXTRsILd9AFrkQs96vJHO86Jcw5L2
         LhLZFjOmLm4IIaAZm2dxR516GMFi5TJ0wHtriSv0rVYTg8NAIx2zkLvGO6tgu+RJYiGw
         2YpA==
X-Forwarded-Encrypted: i=1; AJvYcCURteQk+2valsOBLhqpF/FTxn/guMmUeZxJ2oqnRW6RN+7fuUM8HgtJQv1PxTBnsykt9XREdqJobsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC4oChfR11MCEKvXKAHoCT3K2T2GFdeDGSl0eKOSeOFCY+P/8m
	ZT6fKFqsMn6OSdPMDjECMSOOAeQLscf4OaTemcM0bvwmLJjhxlx+WiNKFPLv+Q/UamYF93hCwPf
	jQkBKXWNvGYFYcHmJzHPe/SNvbyoBEWg=
X-Gm-Gg: ASbGncuZc8j3EUYwvnWJC19NGt4zWp0RVEIpgfkBVr+cCliEdM+tKtXKTBEjq7aNMzY
	7GwzDoVpH32TRRHl7GvW058LyM09u5UHnENrCPwAOhaI9an3CQXlfW6LIres2+/RlRV6z9RG5qb
	kFUsP7TDui4iRFTY9cRzgUdQ2/yp8KLaqFplUypQOdVVYxKgEYyfWVTPVJH3xUVMVoIHfj+/FXe
	X96ctXmEVdZvHM3zJljw0vzNlprtzf97Y8MV+fTVrbg0fVX7rhtHCuoH5h/Atl2bgpb6gtcDrB7
	e0bj9soXF9mYdZiTOo/6knF58S3s8oT3SKYT15fhGYMIUQaADd3mbL+4It4lMVwaqDqLv1Y=
X-Google-Smtp-Source: AGHT+IFif6PPSQ3bdYZyl60xBVHS+YHQUdU3U18xVfPP7wuBbgXOWw5TN+8NrQFPhWC+NkdiecPTcbm2zzCbaphULTI=
X-Received: by 2002:a17:907:9444:b0:b76:afa4:933f with SMTP id
 a640c23a62f3a-b79eb620ca7mr439360766b.22.1764875346485; Thu, 04 Dec 2025
 11:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204185434.4542-1-tomasborquez13@gmail.com>
In-Reply-To: <20251204185434.4542-1-tomasborquez13@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 21:08:29 +0200
X-Gm-Features: AWmQ_blbaURTYD3UjoGkmi8lxQ2B7F4TGEx836s04tzX7VJ_RhPksJC95T8Yj4I
Message-ID: <CAHp75Vd-qJwBAg-LuCa-iyDoHm5Tar46AV3tOYpR4dS9bZ6Grw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad9832: remove platform_data support
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 8:55=E2=80=AFPM Tomas Borquez <tomasborquez13@gmail.=
com> wrote:
>
> Remove legacy platform_data support as there are no in tree users and
> this approach belongs to a long gone era. The policy decision on what
> to output is a userspace problem, not something that should be provided
> from firmware.
>
> The driver now initializes the device to a safe state (SLEEP|RESET|CLR)
> outputting nothing. Userspace can configure the desired frequencies and
> phases via the existing sysfs attributes once the device is ready to be
> used.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
> Original discussion:
> https://lore.kernel.org/linux-iio/20250628161040.3d21e2c4@jic23-huawei/

This can be made as Link:

...
Original discussion started here [1].

Link: ... [1]
Suggested-by: ...
SoB: ...

...

Code wise I like and support this change, thanks!

--=20
With Best Regards,
Andy Shevchenko

