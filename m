Return-Path: <linux-iio+bounces-18881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BCAA3AF4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288D2179E52
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 22:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED225744F;
	Tue, 29 Apr 2025 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptvu4ciK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6135966;
	Tue, 29 Apr 2025 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964356; cv=none; b=KKXLVsgROW92XTZUU/hHmKmn4aQa5T0S32Gfpb3t/vQOnFfrzS31hoPPAgHeWvOV+B5oNpZmHi6GpMK/b0Xo5qfu4QqkGOA4JGgZvuTjpyizneyRfo/ymjvHj4e1qwI4niZtea6dJBjIKEc4vSOBamsoosG/3T1JYmze2nx7Ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964356; c=relaxed/simple;
	bh=4O2j4TGs4G8CaqLecCzN8FOvXNaVx3SdjP3YLwA3vGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMt6DcNxdpBFCkHaAIuxsqdm4X2sey0tG1HI3qWIjnY4t+Fpa3r26xZqDZ1fuQmszOxMlumzh5fBmKmxrUEd8Nk2DQEYffNktKI8gek5m5yucrkYHMG08EZS/ejXg+3f0f4AijE/Sged4bmAV4vjnNMZIM2AchzdTxKXvZQ2zZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ptvu4ciK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acbb48bad09so1230252366b.0;
        Tue, 29 Apr 2025 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745964353; x=1746569153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngyVqPjRfvSenmNYMWAtrNOcgdOx/7rX2SoMZ7xGFK0=;
        b=Ptvu4ciKwK/YI0wRXe6aSPSeiJEBqTKr6TeGDNnJlfhlmY6JxUZG/frWZz9Nl73KAZ
         Pdtmj8nv7Km05TGpCJyfci/RrVYoOr1IJ42t1G0QZ3AfPZ2Ao/Nw3R4BghV06LOLchV+
         1FiFZSWXCYC1jBGBWJbItJ5KWlSdWk+v0GeOl8GvdlaLhA3dWSPnYYsPyNYPqpT8LA5j
         Mw9+woGrtM6FRlRWirb1MeOyMxAGu4Mx1et6Kol2vVKFkWD1C1NQhFsVV3wvy0uRRytt
         eAUN3P52jBupGIBbBA+i4y++o9J0oJbsOG95C24/nNSnaSfR3cmnHRvjSKu6dfmbJ3d7
         ls1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964353; x=1746569153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngyVqPjRfvSenmNYMWAtrNOcgdOx/7rX2SoMZ7xGFK0=;
        b=DpJcIQOAh0F6tjh7U3Qgr2q/JDhKF09pR5Lsr7DxEyt8W+AXALRuEiVh6ePUBjd0hO
         qX8N3ltA2QolQHpaGfMIfc1EkGNPKumU/Z+YQfPsVPhQ/s46UZSnSbew08yQ8xr0JOic
         KR3JHG2PVXGakhW6zSUG3Zyk0U4PD32esd3JN1sZQAkB0sXARltnIKNF6Mu9ACtx+IfA
         9JZgJmTL6BmXaTdFKr6fBJNAoHK0QgNe29RmQ8JoS2rq4YTmdl9ab10Fgk+8c3cMhm2b
         AvHAn33YzKiw7ofKLgJJE1jxlwL1dlVJFA2hvFNpAfnMRWNBbi4WD1X7578IIKMg7gfV
         xPzg==
X-Forwarded-Encrypted: i=1; AJvYcCW03LEAqQm8lYNff77HurFgEHRABlgghzCQoqvPSUTsQJ1lRVUYMFRIfkWRYBVX9LpmDl3GUSAldYr2DhGC@vger.kernel.org, AJvYcCWkooBbWuPHrlkOc4vRCBB5x43UBfxNTAHUuntH4iHkt7fxxFS/NzD55zQXumXIl2gOLfgxm9njaG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ZpWeMWTr0PBI50hwv4m0qTNcX8spU3G3lwuXloFV2EsBhiEy
	riTkI4vp/jJUleKeWTWi1s8Ckumo6tdluJpUDrW6m7NAQtZcOc01T1LmOv6LpPciKJvEsJVAMX7
	SPfiOlognxYcsxSr9b6pPc/i8RFk=
X-Gm-Gg: ASbGncu30rbRS39RVngDD9C0ouAr4CA6dEenuKMuN6HYdUXxhfPjIShDSiBISQav626
	qipr5sE4PHaSs7U3TN7s5cNb4OeWvGkJtbHfhyGbv5w0lOJMJLGV3qk+tWgzjMxmidjHIh9B7qa
	YFR5jQ2SOKOTzF2T0TH3uwzg==
X-Google-Smtp-Source: AGHT+IHNNsKhQKCg6aIsyYV7pnfSuCjUZUABgxChEteF6kywXt2dEXwuhxrLc2At+HvwHYHM31ityr7Hw9JhJe5r/xc=
X-Received: by 2002:a17:907:97c7:b0:ac6:d0f6:c85c with SMTP id
 a640c23a62f3a-acee21ab689mr15923166b.20.1745964353325; Tue, 29 Apr 2025
 15:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0@baylibre.com>
 <20250409-ad3552r-fix-bus-read-v2-2-34d3b21e8ca0@baylibre.com>
 <Z_alpFoaQQUlWdfo@smile.fi.intel.com> <udqm2qkw3yrewmovua54twfzbsfduojc5f5uoj4nptxldpbbr5@75bb2pldwq7f>
In-Reply-To: <udqm2qkw3yrewmovua54twfzbsfduojc5f5uoj4nptxldpbbr5@75bb2pldwq7f>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Apr 2025 01:05:17 +0300
X-Gm-Features: ATxdqUEIjX_f1ZVn41mqh2bcpKKKRKJ43eZTgNTzTgN_lDDRQC6xeSIwKe30Zp4
Message-ID: <CAHp75VfpgqNnLOn4n+Tf03mmLFMj36SsV7j06TvhEhyqmmGgVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: dac: adi-axi-dac: use unique bus free check
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 5:34=E2=80=AFPM Angelo Dureghello
<adureghello@baylibre.com> wrote:
> On 09.04.2025 19:51, Andy Shevchenko wrote:
> > On Wed, Apr 09, 2025 at 11:16:55AM +0200, Angelo Dureghello wrote:

...

> > > +   if (ret =3D=3D -ETIMEDOUT)
> > > +           dev_err(st->dev, "AXI bus timeout\n");
> >
> > Why do you need this? The error code will go to the user space at the e=
nd? If
> > yes, it will be enough to have it printed there, no?
> >
>
> This warning means something very bad happen at AXI level. I never seen
> this warning issued, but it may help to debug AXI/HDL issues, would not
> remove it.

But wouldn't user space get the error code and translate to a message if ne=
eded?

> > > +   return ret;

--=20
With Best Regards,
Andy Shevchenko

