Return-Path: <linux-iio+bounces-22598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF77B2154B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187B942769A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA332D8377;
	Mon, 11 Aug 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9PVhdoS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C245149C51;
	Mon, 11 Aug 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940188; cv=none; b=rv/pFSrk8ACcD1t5w5FZltcDR5gk1EZP2rxod+unI7n+PNPcPrqEZg0XwQMChNRfFm4djcduU7k9RVilvjWq/uVbaaD0VuVbOxJ6wYEJEZ18fmOlr3x+GvXdEvnMofyBSmEvQHl/l5Mrqi3NxgaH+gcZICfhLt9yyJiWAxTxlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940188; c=relaxed/simple;
	bh=JY8s0Z9hdpRQcufudBWVhQMc3pYUSvN2/3PccKGiYEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=si/EhfhTJJKdETx7Ao/54TTiwOs9nhB8rTQtieXYgpm/TR/JSvd6i3sSdiKUVlST4LIX0jtZzp/zmQA0hRdw/Mv2zoJqwBvVBKcx+XyfQVm0MOclbrIyBl2tgKeKOaUp/GHaHebxfFrRm157/Az4lP1JDvOfq9283QBBIh8Lu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9PVhdoS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so5521396a12.2;
        Mon, 11 Aug 2025 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754940185; x=1755544985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4YdDTwD+VhVAOjXWk+9RG+ki3RkcphAUlUyjP4j9P4=;
        b=g9PVhdoSKq+E1lhigP7D7QXoCj0mn3skFCQzLx+bYTLXSNEhlKjYjuGn5l2X5xy8YD
         kXRHlNXOKue2ovDOLX+OBrfEoiM7WEUpoCHKKb/4gZNsd8kYW/I64AO8F9C23ZS/Qe1G
         ahjrvlFM2B4xBCP2YnnFfAh1J6EoKuDq2jLqFuabjMJRvaIQAUFi9m6+X0YeCnPC7IJL
         8CgQ8xbKMHmPLZXXEZVVnF9xubSur8gkfCjBqNCFT+3k+5chXNpv92Gp4X8JVuwyTdxh
         EHZ3+EHuz8TT+f5ouC9fyaiX8xaFt9jqIrDG9j6Ck9UinB94iZIaWWDnHf6QH7OsZQ4s
         mkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754940185; x=1755544985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4YdDTwD+VhVAOjXWk+9RG+ki3RkcphAUlUyjP4j9P4=;
        b=LMLHjTF/TiCEY4uEeMPUjEXRQPwv4HphggkA+H92wUr4OmPB2DWKoUdaSuvyYy7rQf
         fZiNJ9FUaJx0rUFjU+z3C12dm4TzeVdzfd7qtMEekd60B6V9XmOk9PdX2H+/OgsrpobR
         GihL0L6FI41K9PlP27NBxVJMFRTCXv9B20AiAdjONE7dEVQuEpkuW1patDrkoEkdJwuJ
         7B1mH1zeJ6hzqU64xNDEWCbyH9iEhclQO53WqMq2sQnw2Vva2ch+V7gS2wi6P42X8J5p
         yJKzc9HF6jIT4cVLyZO79e7fWDvRwyKc24TQZ5Pdx2rwgyQJPegDSsFPogW1HARtptVr
         zwhg==
X-Forwarded-Encrypted: i=1; AJvYcCU2li6vCgnOlv7id+yoTDJyz2U8bBVHBeq9TZr6XT9YBQTOfGWJbDRSXo/5eS7mwEVQzM3tHUYxPWM=@vger.kernel.org, AJvYcCUTiopfYUVRcFGxFT+ignHBiIfNJGBrxVnEhmWptvFa3G9KI1JUifJnJiBVmZFdQHKdRtObaAGi1GBHJTeZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YHlI/N8KhHvSPnmXCPLxIfZaCRJ0H+KwrJhlGDJd/+6dp9Wu
	JiaGSo17DfKLP5Gf+/qB0nLmnCvtBuZ7l6ZhvPK6WajUerd8VX6rNa9ABFDR1CAt50X68IX6smM
	AbEMkl15ESGmzFGO8HxquSyoVJj28bk5YNImrNR8=
X-Gm-Gg: ASbGncu/x0ULFvIb+3uoC/c9iDmjK8xMQ6WAP12Hem58gF2XcbNqGRE9Ccm2LnIulYe
	JghWTYGj2gPuS2pGP9Ou+Ot2CwmgnsaSaw+gZ/xmTrilv1aCI7oqMhEaAFf7aLFRzoyGw5YF21E
	B8FMgjUODtx9Mxyzv/2j8jCz0BNIs8k3FP0rOZbTb9FeRm3efRH0Ns3RvW+8NbVP3EXqRHgJ/RV
	uGMii+VYA==
X-Google-Smtp-Source: AGHT+IHFv0NbHgNM41Zi2g/uol7kNjolm/Z50ofS48c0fwIqCNI5EdqM71PkMehN/VSgLbgqNFf73ffFR8Fa8+i3mDs=
X-Received: by 2002:a17:907:da4:b0:af9:3d0a:f38f with SMTP id
 a640c23a62f3a-af9c6086b26mr1370458466b.0.1754940185122; Mon, 11 Aug 2025
 12:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
 <CAHp75Vc_-2czsaZ_-3+cSWAzyvz-PASR5mjCyoAxTu9qSEYyLA@mail.gmail.com> <5732b907-ccb8-4302-8fd7-ded63a5d852b@baylibre.com>
In-Reply-To: <5732b907-ccb8-4302-8fd7-ded63a5d852b@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:22:28 +0200
X-Gm-Features: Ac12FXzjpWpknWGnhabz1oYRizbUUq7XDkMINv4qURu564JnBN0GpDbJQIfXLEE
Message-ID: <CAHp75Vf3s1ftm0wBPbeTuKgO0W22ndpdcGE+zSMSHD=4z1O4Xg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7380: fix missing max_conversion_rate_hz on adaq4381-4
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:18=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
> On 8/11/25 2:07 PM, Andy Shevchenko wrote:
> > On Mon, Aug 11, 2025 at 8:32=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:

...

> >> +       .max_conversion_rate_hz =3D 4 * MEGA,
> >
> > MEGA --> HZ_PER_MHZ
>
> If we do this, we should fix up all of the other similar ones
> in a separate patch. So I would leave this patch as-is.

Will it happen sooner?

> > With that done
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>

I leave this to Jonathan because in spite of being a fix I still think
it's better to use an appropriate multiplier (also note, MEGA appeared
in the kernel much later than HZ_PER_* constants, which sounds in my
favour).

--=20
With Best Regards,
Andy Shevchenko

