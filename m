Return-Path: <linux-iio+bounces-23505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B547B3CF32
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FFB560F7B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0EB2DF710;
	Sat, 30 Aug 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSrOHlqX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9049620;
	Sat, 30 Aug 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583937; cv=none; b=JXqCnjnYub/vrY5S744J4Cwmq33PBGbKD5MRGjb1hjIKVIUXuWSwftnWFzITkUbHmH+HX6/HmMYLFiXh0eecFDY4Ao+mMDSKA+ky6U3DFzl6ERAGoxVsCvxS70L2OoFoob0ePorFHw/Ouhv0cAQwMf4lrgBEFGdS2VpKt6ucdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583937; c=relaxed/simple;
	bh=QjHR2JQRajF5vyFwERKX/p+Afxqj+XNaaamdVL/axY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ou46OwNj5OiBnz462GauaB162V4p5J8OlBTqrpSypPJo5pP1CdQySRhZ2Y4+Z+AYWYJtGgCTT5WAT80OXftbhkiQuDPew9DTlm9gguqi3CYUY0irv5OBQX8m/6wflnLwrPAWbEfv+KTorE4hZqAfb3VPyhw7kvTD0ypLm31skUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSrOHlqX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so7472819a12.1;
        Sat, 30 Aug 2025 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756583934; x=1757188734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjHR2JQRajF5vyFwERKX/p+Afxqj+XNaaamdVL/axY0=;
        b=lSrOHlqXbp7PUufmlxpp4S83wLrWf0YQZBHpAg157VBCDRTLumGZ1jg6E2nP5yf1yS
         G8f+JrFqxA7TZKe2y4K1oThKIMlQ4ZiMnsNLtcFb/7KMXD0+lxMh+GM2fsoaanDSsUWF
         S8n/0Cs5vKqJXY21h7861zoNO72cveyB5nfZn9tEwesdx2MgNgHIVOqWnY7197lwznun
         J+lMyfV/0cvVHW8voN3vn2o646r+yWBetKs66OxcQkOvYpO0r1l4QNXVij9DCFwKmlYS
         DHwxGoUvjv7QJAE0eguWSt6HprJkdgWhtD23gT2xxmcDFJD+yBn8ZZBY5QTz2arElHzu
         ZW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583934; x=1757188734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjHR2JQRajF5vyFwERKX/p+Afxqj+XNaaamdVL/axY0=;
        b=i9OYPL3LvdXjpoq1u62zvqOeMET2wu0hTIxmZgtU6wNcp5fsU26TR5XrFOP3lXgBIZ
         H6vTLiy1KDUjiU2dQ/s//ey9hcF8OJZlZWyrgAJzflLsLLlmG5s9hpgGuSI7DgK1bg7I
         kBt0+Boj/tu3G8kQaOnhcwwyR1wVR6YP20aFsTtiVjRfMnv2jJpx3jNikBEvrsI7DnPZ
         N1gj6bnhNLasUZyO9n1/6CBiRC5w0BEbNvKYd9fgvf4BPT3+m6aqYmqsXc2+lqFTJGWy
         rXXyQ1cJiHXT7TC9bRVe2tcE0OYmVajGtxq/FmbDZQDMVkVKlZ2Y6LqBJXmSyNIk4Dm+
         Yb5g==
X-Forwarded-Encrypted: i=1; AJvYcCUAxrbEADd5G9Umfx7KYxsEP3+BxB/eDiMpwNTSWhsul+bcghz68Fnu+0Ixbq7halhnGYo/2ck+bWM=@vger.kernel.org, AJvYcCUEq4UaxDClAYm+Y+CQfiDZk0w4yqHBk6mUVaSTMtuTdKfzkimT3OdpN+N3gnyjR24+3eHncaqHbqWAK05z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgu8NSw0EPfIbjHOHvbOhNywueS3cvX8dh6r2EL8pZgkBU6i1r
	2dmgNualMvLIwdO4I03AE4zOnvR27fSyqugyGhe72qDBDhqiKwp50v4kGObS3gN7v6hQziSyMHK
	2OBOBq7iXPZOMne2SgoJIJYIGhaiR2cs=
X-Gm-Gg: ASbGnctGGGyh9QPSC+875n24PZnHib+uAaEZS4o3mFzcwKc33MAYxhokKPLWayJSdgw
	tsxDXS87C8bFpnizgney+LudCeQld5UoePztbDzkHELNxaQnd6DBataIATYDCelfCKCMN/Xjx2G
	Iu4cdtBGC0AlR44KJFTBMS4zXFxfrD/ZP2Q+s3XFT844h0r9Ut0pYyJXCBnBmukBe5DAWENqxaM
	vXlXkum5reGy/dnEQ==
X-Google-Smtp-Source: AGHT+IH17cIhYAXAEnoWRYt/nfaezfYG2EstusuWWP+H0n0JCPR4DIFOD+fiYbJla8N+SZSiKgw6pl0eMEmB15DxK8g=
X-Received: by 2002:a17:907:970f:b0:ae3:5185:5416 with SMTP id
 a640c23a62f3a-b01d8c74a17mr335341566b.13.1756583933787; Sat, 30 Aug 2025
 12:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830115858.21477-1-gustavograzs@gmail.com>
 <20250830115858.21477-3-gustavograzs@gmail.com> <CAHp75Vf13aqDJj2j7MtfLTAT2MW-S3+M7wtEXsG1Wh7EKfxJSQ@mail.gmail.com>
 <20250830180534.24a8ad56@jic23-huawei> <20250830180920.7a65df94@jic23-huawei>
In-Reply-To: <20250830180920.7a65df94@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 22:58:17 +0300
X-Gm-Features: Ac12FXyxJo3an5yVLTmM-Qe8fbifyQAg8iLh1yxnlBEtQ2LJ6ZyVRQrhj_9nj9w
Message-ID: <CAHp75VckFnumUG8GodAwigG10NVd66Tj-2Tkm3kLWQUET0EorQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: ABI: document accel and roc event attributes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Gustavo Silva <gustavograzs@gmail.com>, lanzano.alex@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Sat, 30 Aug 2025 18:05:34 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sat, 30 Aug 2025 15:49:50 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Aug 30, 2025 at 2:58=E2=80=AFPM Gustavo Silva <gustavograzs@g=
mail.com> wrote:
> > > >
> > > > Add accelerometer and rate of change event-related sysfs attributes
> > > > exposed by the bmi270 driver.
> > >
> > > Seems to me like the absent attributes that are already in the kernel=
,
> > > should be added in the separate patch.
> > Agreed that would be ideal.
>
> Actually what did you mean by absent attributes?

Absent in the documentation, but present in the code. That's what this
patch adds mainly, no?

> This is documenting ABI that is part of the general 'scope' of the full
> IIO ABI but which hasn't turned up before in this particular combination
> (or possibly we missed updating docs when it did!)
>
> Whether it is worth separating out any we know are in another driver is
> an open question, but Gustavo hasn't called out any as being like that.
> It's possible that these are all surfacing for the first time in this dri=
ver.

Hmm... But if the code handles the attribute which is not documented,
that needs to be fixed.

--=20
With Best Regards,
Andy Shevchenko

