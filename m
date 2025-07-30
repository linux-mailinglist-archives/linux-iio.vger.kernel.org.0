Return-Path: <linux-iio+bounces-22158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4EFB16818
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5245F567DDA
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C63222590;
	Wed, 30 Jul 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6HUqdph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425A173;
	Wed, 30 Jul 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909956; cv=none; b=BnzCqBj2MYuDECIWpPtJN5JQGaWEaYeCKkr7wyFE7lnYRkMaMHc8xXVbK2L4fbfjadsGhQd+RcwDYzfrbzIEIo0+bMtK9MsOFcWKGy/FukGuzTCDK12nSXLZHiTp6o3OGU+Ql+6HhngOWnJ2pYiI6b0mIovvTqV6ekwPKrDWWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909956; c=relaxed/simple;
	bh=hRw1ORdatHqHpJ8fQ4oH31UFvPsAeC+YzsG3fJrPP2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQzfohHihoFWewvropECe13tfH35VRh2OvumiKdP8kIL0lbL5WiajtRYsgvBkon5JXHozTgxmHRr+XgZRyI3paCgV0OZgQ9B0sOUJmvuJAWMcPBzZ6uuDFhV91VX4cLgr4XJ9ENiQ/x2f5J55pKB0zND5Ce7I0celhKrv9sVX5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6HUqdph; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af0dc229478so39309166b.1;
        Wed, 30 Jul 2025 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753909952; x=1754514752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qgz7u73foOW4QDlCE6BAQ/Ul8X9iqPI5jIdj8hklAfk=;
        b=E6HUqdphQ2Np8CegB2pp7Oe9Uk0pjiyYi9r0DmRrA0+D+bwFBDk8Y2PPL8hlR6221u
         l69dqIVcUpL2IOnEcN9oxSNdID/bH6HUlBh0OuxHPzlxS8gLzLnPaBF0GGGFuQdyoyEu
         1Rrab0hXWsEW2NTJ1Zp8msnAZ0g1MPe25VlKPXGDJD/r3RcPW6t6uywkC0v7WuAvfqxK
         waL8PoTFoDenxWbpjeSpfOBXffR1/y3kKDBk+2/7LpfrEbKQmJysRy7tfs4AExU2aF5P
         ljNF2v+CW+V1mMn00+HTf8/I1AwC0gGNlIDbYHsABtsUYeCiihNV594mwglODIG0Y1Cz
         8jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753909952; x=1754514752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgz7u73foOW4QDlCE6BAQ/Ul8X9iqPI5jIdj8hklAfk=;
        b=gZPi9UbctKEX9AdsSaJp4iOFkaZqdYiSkMlPmRHtBSmIfVLMlQkDGGf84fWsJAj6PA
         ImgjdlJ4wNnsxWeoA3oQFi4+5KKRH4QjPPaIoFqNPCG9a7e81MvScGwt8onxWp02ENK1
         l9DUzo3kaJ+uMgSXdWdF1uz1jK8eHbBcfJFBI8eMBtIjDGcdrB5w8T6UZNqZ2Ym5xzJD
         zqYJsaLdGbJ8KbliBA16KLkOojMTwUBmbfz9b4ZVSzvIFRWIyXJwQEivhvsdyBgsEFYG
         J5jQGWl06r3GRNImmVx6KPt1TysXTWkrefymdv+7QZWg4xyGEeetoRbziRsE3OFydqVv
         2Edg==
X-Forwarded-Encrypted: i=1; AJvYcCV9CCA409PM2bgwhDOYyfMyj5GJ2trJPGxqszqxrqESnAJ/fda3tKOaFytiPvyyXINQDv+u9wczPArufFQn@vger.kernel.org, AJvYcCXwqGRWUpzCCMoe6lqUq16pufFAI5FsKyEKolY9PjBUwL7wD0UG2e3Vrs9VEdr7JUPGwBHAEgu0XWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT7t1ZgTQfiAS6yZOwymGWb/Bz7aLQQUC6ZUxM2itKqiUcz9hx
	xWCBxJwv3eF0hp5kwLljr5E4GhHVLHhTHZ6JyRYBZAkMN+A8r4ftUtywMcIa7HiX5G0NsZqgult
	riZNRywVAPoCD3SIxTmimG2OwBygJ1Yo=
X-Gm-Gg: ASbGncusVd1uhfYN51Eec0OuPUve1fimq5Kr4pd1OA7zjjGbYHYE6BFqI3D4T0fjP+e
	EFlPmNtoJPh/+qMfAHMmHNXCpCIZq8inMzZsUWMsM/EZ9qpoi807m2JZlvTug9Uh2Iit1nm4ZRv
	raWaCSqW7Yw1sOEzjcTWwe0rTN3KhKSjBS94xn5nQ0VpQLPacxBfHb6vp7TNc74+7DiEXEUmNAj
	s/oeKaGhQ==
X-Google-Smtp-Source: AGHT+IGjpPZPueGCU/I4oL2SObPkegd+m9xS18v1HGJkW9Wa4pF73LsKYXn5sGbjIDR+OTTt5EK63BCCRLhn4RTtR84=
X-Received: by 2002:a17:907:3ea9:b0:ae3:a799:8e84 with SMTP id
 a640c23a62f3a-af8fd6912c2mr528791766b.8.1753909952143; Wed, 30 Jul 2025
 14:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com> <CAHp75Vc2K3AmPhwme3+7cCGwDTA6V+4Ug8f++iFr8gCThCOnQw@mail.gmail.com>
In-Reply-To: <CAHp75Vc2K3AmPhwme3+7cCGwDTA6V+4Ug8f++iFr8gCThCOnQw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Jul 2025 23:11:55 +0200
X-Gm-Features: Ac12FXyx86b7BmvQ85gYUYYiMuPPGbMcBbsaxI4emkZ_6EKZQ7yhfMAaDDSwNK0
Message-ID: <CAHp75VfKvp6CLyic2JSBDEgRipoSq8SkBF7Cqv1pa_vLoGSxRA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD firmware
To: liziyao@uniontech.com
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@uniontech.com>, 
	Jun Zhan <zhanjun@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 10:57=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jul 30, 2025 at 2:56=E2=80=AFPM Cryolitia PukNgae via B4 Relay
> <devnull+liziyao.uniontech.com@kernel.org> wrote:
> >
> > Some GPD devices ship a buggy firmware that describes on-device BMI260
> > with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
> > let's match the correct ID to detect the device. The buggy ID "BMI0160"
> > is kept as well to maintain compatibility with older firmwares.
>
> No, it's not true. See below why,
>
> > ---
> > Some GPD devices ship a buggy firmware that describes on-device BMI260
> > with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1],
> > let's match the correct ID to detect the device. The buggy ID "BMI0160"
> > is kept as well to maintain compatibility with older firmwares.
> >
> > Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.=
41.zip
> >
> > [1]. See the update nodes in the archive file above
>
> Yeah... I think you need one more attempt to fix it right.

...

> >  static const struct acpi_device_id bmi270_acpi_match[] =3D {
> >         /* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
> >         { "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
>
> Unbelievable! How is the above supposed to work? Do we have DMI quirks
> in both drivers (bmi160 and bmi270)?

Okay, I found the answer to this question, it uses chip ID to
distinguish the actual HW.

> > +       /* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
> > +       { "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>
> For the record this is incorrect ACPI ID, nor PNP ID for Bosh, unless
> I missed that https://www.bensonmedical.com/ is bought by Bosh or part
> of the groups of the companies.,
>
> >         { }
> >  };
>
> Can you work with Bosh to resolve this as soon as possible and use a
> real Bosh ACPI ID (BOSCxxxx) or PNP ID (BSGxxxx)?
> Also, each ACPI ID adding patch (when it's incorrect) must provide a
> DSDT excerpt in the commit message to show this. Ideally this also
> should be confirmed by the vendor of the device (GPD) that the ID is
> incorrect and a correct one needs to be used.



--=20
With Best Regards,
Andy Shevchenko

