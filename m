Return-Path: <linux-iio+bounces-22197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A46B18EA5
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 15:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18353B8CF8
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52E23C4E1;
	Sat,  2 Aug 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGTcxj85"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074F221FB6;
	Sat,  2 Aug 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754141193; cv=none; b=d0lkEFbK5LMzxEWeLy/vDkww3ffdK+52QM7/A01QFCz4PoaGTU7uilbvR4ne+xacReZFApTn6OJLpw9A5K+g4Tv0cx6c1WiuJ++BVvb7ik4WFBZ2AuManPQmiy5liFxmOmjgQeiRliZ7GoO+PTXQrkJUJleJvbXVFRRYBkRHbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754141193; c=relaxed/simple;
	bh=/4crSiN30dSloJaXXqMGBV4r+CEX6tDvBU/QfCCKxP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6p9ie+DbTtHVeM/FhhWea5YlZN4JDKgZEGeGsIINeHUAg9ffk6VdK7NDTHol7qJQArsiK127N85Qj4AtU7s+rzU6Mv6DRGJKbGMvu5uOjLQYqMMVS/Kw17ZKwcOENYP3nYBT8ezEbF7YwuG0B+10hRHEYGaw8wUKX4jUwQWzS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGTcxj85; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso4005810a12.3;
        Sat, 02 Aug 2025 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754141190; x=1754745990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2WPNw0I6XzWPDAp4qmeaw4Yfp83TAoP049VoC7bMVY=;
        b=KGTcxj85KRybHywi4viRrmu8Vcx6HiTxlDcQ9xAIAJ2L2lyONQdJMuLIUmILgnAm+n
         mIb87WA3ZTvrZrzsLBqSXrqPv3pSguAf1dFwJfoPyP2fszjEjDi1LRyDa9PWixQsKdhO
         yhzG7205T4eMD/4pJ/ySv0OyBM9FDxWnkMW6/1x8x0DqBhtbXGdeWD7guknojxd1QCeC
         NvoT04B0acgWEaAqxgKDw81Smn8IqZLCKYJL0+Hw6zVnUQoGLg+TRGMj6npH4BPJzgdm
         UjyFbn4zi8bm7ECTIfF/IiIQaxodaDY9bjX0wPZQMLd/eM1+OIizbPWzlSg5wf95SdYb
         GjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754141190; x=1754745990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2WPNw0I6XzWPDAp4qmeaw4Yfp83TAoP049VoC7bMVY=;
        b=LYMMD7lD7bBIc5jrnKqYZhxEajDvV035fxCfFs4RsQnkc8ahfisapSoMu88pBGrRMm
         ndxtNtMwMhd0gpodsiCl42ghcvono9OhghFnmP7nfsQUOtzZ0OMZYATBrFX922/ZvB8n
         a4KtDTd58a2kDRgUwuKk7C29XCWbDu1ij2nWN4V3IIGYMFOrL0SOXEAD5BBHqK2890Dw
         fTSmpz8LL05XVL9k2HouYj6g+NozMey7IslMXxpNhYdLdUDQmHkroKy4AQsIDTJYPwbA
         z/vWovBTe8q8d4vHaoPx608tOr89CUz6PLo3XEsXj/urpfunletrd0Lwpl3h+KqGfXce
         kdXA==
X-Forwarded-Encrypted: i=1; AJvYcCWidOAR5KAqaHEmEoAqedtWbo/AMRYSIbfdBha/M1W/A8YLO6JG6LSxdeyQ88NFKejZ11A2/XsnNETx@vger.kernel.org, AJvYcCX7y/jWQtUOWtfBJMEUiwGy1c0H1gWS9Lsh/keiwZm53Vg5ZnR8nDEkO2YuDTfwY23VBokR6gS3UNffykcz@vger.kernel.org, AJvYcCXpuDlfUpcQz4EdrHbi2W6NepFzWn+ow1wvycumnW+UuCvX1mgg2rnUIOkBIaPUG6x4L6LpTMbKG0Rp@vger.kernel.org
X-Gm-Message-State: AOJu0YwKv0vTgqWHdSgPCbnxhusT/6r1+ZKuuHpd3DBaPJq/vzTyTC1x
	nKhxLpxT4VUizJ0m9BY08PGKTPuwaUc+spxJR/Oh8hiLLy6Ce44vpwxV9Ys0URvzPym3JtteCs0
	1HAGuqCI2VzWPAGL1aeNEJxo3/lhkdfw=
X-Gm-Gg: ASbGncsqWmLWCguvz1sl+Ifopv1wq+rV8hy7h+/qd417MmP7uftbHAflLFJcV+c5TB4
	z0dC25LDxxTWeZHQKalJU2zfEOYFJbq/yXbgPKhRUwjOU41GLnFJ68vaIWQg1f47MPlnHU957O/
	wiwZo6MxfS1ikcJzERCL2UoVt3g5djNc897Zgpxz8qB8OI21HkD298o7+NtSzTHWnuvurgPf4UF
	tmFnk1C2qFHJSno0sDd
X-Google-Smtp-Source: AGHT+IGP26q7g//ODnOqXi+xOmeoNUM/WD+PpMklLSRMgcUDnCJrZddoH3kgwmSFWsYFz2GsetLXdaKRf7hQo+u4kL8=
X-Received: by 2002:a17:907:72c2:b0:ae3:6ff6:1aad with SMTP id
 a640c23a62f3a-af940009783mr304916766b.14.1754141189961; Sat, 02 Aug 2025
 06:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
 <20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com> <20250802124333.67f64863@jic23-huawei>
In-Reply-To: <20250802124333.67f64863@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 2 Aug 2025 15:25:52 +0200
X-Gm-Features: Ac12FXyUc20aph_0pV3bKsHUq9U5-euyrn8HhDdq8pCrFQbPz3ZVhsz1hDak-Xc
Message-ID: <CAHp75Vd+D1RQC-pVQjsgkSMdmV=GXcRGkbD5hHgo-9+Tyy9Uzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dixit Parmar <dixitparmar19@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 1:43=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Sat, 02 Aug 2025 12:14:27 +0530
> Dixit Parmar <dixitparmar19@gmail.com> wrote:

...

> > +/*
> > + * Different mode has different measurement cycle time, this time is
> > + * used in deriving the sleep and timemout while reading the data from

timeout

> > + * sensor in polling.
> > + * Power-down mode: No measurement.
> > + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> > + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> > + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> > + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> > + */

...

> > +/*
> > + * The datasheet mentions the sensor supports only direct byte-stream =
write
> > + * starting from register address 0x0. So for any modification to be m=
ade to
> > + * any write registers, it must be written starting from the register =
address
> > + * 0x0. I2C write operation should not contain register address in the=
 I2C
> > + * frame, it should contains only raw byte stream for the write regist=
ers.

contain

> > + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> > + */

...

> > +                     /*
> > +                      * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 =
=C2=B5T)
> > +                      * Magnetic filed in Guass: mT * 10 =3D 0.098.

field
Gauss

> > +                      */

...

> > +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> > +                     tlv493d_runtime_suspend, tlv493d_runtime_resume, =
NULL);
> Preferred wrapping here is
> static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops, tlv493d_runtime_suspend,
>                                  tlv493d_runtime_resume, NULL);
>
> So go nearer 80 chars on first line and align second line below the param=
eters
> on the first line.

I prefer the original split as it's more logical.
One can make use of 2x TAB indentation, however it might be a bit
inconsistent with the rest of the code.

--=20
With Best Regards,
Andy Shevchenko

