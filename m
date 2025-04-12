Return-Path: <linux-iio+bounces-18035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D70A86F18
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 21:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230A8189AC5C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2177B221702;
	Sat, 12 Apr 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaoHcPyo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C621B1B9;
	Sat, 12 Apr 2025 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744485394; cv=none; b=cvvb8oujId8S3PBmiYMlSZ21Z/1mVvKvZnij7X6WQ7AHOGsqUACLShKCX8jRM8I9SpW3f4QiOSBsZNo6SPXbgM5pjLEt0hm/c1vUL680H59j0Wv28tZeAE2PFtBJ2R8WJI2cpSLgWiU88R3JDjUz8XDk22RJxrB88HUCbG57FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744485394; c=relaxed/simple;
	bh=XMuYj0LGiAKB8vPzNQ8u2+91c2SqLd/udUEtcIUgKC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbZhJkNw4PI0hQbFBNVe5W3KOd9akEtBLoaDbxrZj7q0xf67QS4T36yaQj1ZZiMBe9CD/LBEhLRxi4q9Kx+6rp1Sci9bO8kAKEsTlY76oNtbPQ3Nkw/ua0q2yfSgTa4+qmJiIN5r/ugJC+3zoRq7Nu5oO43xr+7Xcl94RedJkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaoHcPyo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac297cbe017so734601866b.0;
        Sat, 12 Apr 2025 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744485391; x=1745090191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Psd/UlLqcGLWtxU+5uM/TRLcPo0oLgpI0a7WCHYFYr0=;
        b=JaoHcPyoqOyHx2polRYbUTqjCmKJ8v4DdS6CJcQflkGn60la1piAjSEnGVMnNRm9M9
         fb93U8SHNI08lvyqj2TxCr4Pn+EpD9CHhnWIceiND131D4ZGqPTFEQokmha4Xvk8PP0l
         jwYMmcOcl53KgWeNiez9dA5A51kumraKC8NZiQEmwlDHJyJ02ZoC/oRgbpGLwwsGa/J5
         Co3mwqsStMgcDJtUF75+lLH2GNXCXq6PDYNkvne+MYavdR3yR6hVE6eCvEHkalQ83yxA
         bxj4M59W5j8E6yx47s631oUt2Hk8wy9ZSlF1JbR9n+OpZHqAO0BcOqUuSe+j3OEFGbOW
         Y38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744485391; x=1745090191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Psd/UlLqcGLWtxU+5uM/TRLcPo0oLgpI0a7WCHYFYr0=;
        b=OKNssywz/jHyauwAOwA6g6Ci1FIrnv50NB7N1AWRv3GS2qI1TAlqBbjjJX3x8+ZP2Y
         wg0t3br9FAUJBL+ZJ51UU8n4IhQGgWN7PmAWuxNaH8IbJgFKgltEQsKk89a36rU52iX0
         StI+7uVDNMDBPOXGruODVs+ziYLEiBIyGuIP/vPkbQG9n49BXsYRGzNANQkSx6Dv1SeU
         koKNqvN3GttPMyS3SQp69pfaeqb87s9wJGX5GGlRg70eRNzTiRZaeg4MPReHeGz2VNFM
         Tq+xh+VqDU1yXSRm5flMQq5CxiL0OHgwPJ1pszk1vlvy7WcubFqSBNJdp1Cbby+SR+MB
         Jitw==
X-Forwarded-Encrypted: i=1; AJvYcCVsC+7Bw9/WgBg/rPZo/tKd0LJSkETnOhTIqAQm4fyO/AMCvsW9evIqSea1j7VBbR2X4SyaXCN969Hjvv72@vger.kernel.org, AJvYcCXiMymSPueq6HiUDX+y3gU5TofJh6bTr3c4jxeogQCiFD3dD8fnvoye4bKqR6ASxGwAqIIeuM02FzFR@vger.kernel.org, AJvYcCXj8GgjSkLKRoogPxjPlOMzwqeTE+jYWrAIuZHtYNQXzFN+47Y91JbV+qu+265Wk1xjjzPnsaGdSzu9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj05X6+JvffqjYgIGt8jF6v+rBftGf355kjA1MqT3nY6VYqGjl
	73j15F7po5zszs42ngSYuWIryeHtdiZZT3bAiT3xHsNjO0wN/JqM31JI/agI3FMVfFpTf3OTQfv
	ROwPbThbajgOW71RWDtzyhnBSV2E=
X-Gm-Gg: ASbGncu7Cc4vY2DwXJovJxqX726kwF6DSQJLWywc9TWwCIjahXWNYv+XXoiMtiQoWPy
	ftJiY0a7Ffpwb2wy3YVgt2kc6vv391nYClWqVvUeTAUdF8430FksTjaO3DvypWGUyRFbVqqKLq9
	/Iv4NCWNU7wxIAJqvVO1A/5g==
X-Google-Smtp-Source: AGHT+IH6zqHapEQXC2Dt2PNuoKrromqT6QHV87nhuJqUb6y5cWmGnwJPCQHaWpLu7aW4HUCCvvI2qLq864R2Wdr8R6g=
X-Received: by 2002:a17:907:3d0f:b0:ac8:1e67:9474 with SMTP id
 a640c23a62f3a-acabbeb6eb1mr1059879066b.3.1744485391361; Sat, 12 Apr 2025
 12:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
 <20250411-add_newport_driver-v1-5-15082160b019@tdk.com> <20250412201354.45eb4dd2@jic23-huawei>
In-Reply-To: <20250412201354.45eb4dd2@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Apr 2025 22:15:55 +0300
X-Gm-Features: ATxdqUF4jm58jBCDKLl2z0MBr18ybNVfhE5o5lpKBeHznFWEBDdFFNQI-hT19LQ
Message-ID: <CAHp75VcTZjM0Sxd43EPmLsqQV2nR_-7NJx-PK_fWtOde0BOHqQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] iio: imu: inv_icm45600: add buffer support in iio devices
To: Jonathan Cameron <jic23@kernel.org>
Cc: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>, remi.buisson@tdk.com, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 10:14=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> On Fri, 11 Apr 2025 13:28:37 +0000
> Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote=
:

...

> > +     raw_wm =3D INV_ICM45600_FIFO_WATERMARK_VAL(watermark);
> > +     memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
> > +     ret =3D regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMAR=
K,
> > +                             st->buffer, sizeof(raw_wm));
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> trivial but return regmap_bulk_write()

Actually looking at this I think it should have proper __be16/__le16
(or what is there?) types and use respective putter-getter instead of
memcpy().

--=20
With Best Regards,
Andy Shevchenko

