Return-Path: <linux-iio+bounces-22492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A833B1F4DB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9915668C6
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD65E286897;
	Sat,  9 Aug 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTElCiPe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4818C322;
	Sat,  9 Aug 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747663; cv=none; b=ZpXV5qYPUkFSLfu+Atk3FHElpVdgoxRojpTYE3IV7ys72oMtmkxc6c8B+YduhCtOZze263wiUv1EGCbUMNsqEYPmiQSbHwdhPfDp5g5fKH4OL5rl0EqD/iEZRtyQFk1UH90y3bHC2utwdNB5kzvtE7LHcYXYGzAT3Yi+Ua0YFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747663; c=relaxed/simple;
	bh=7Xp+H3/Fm8Q2xD0Zm9yjoa74Ff3Js1v2RozQaurWIKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHcLISIDTzRdL14lTQjeeb77fRirCJHS+RymZM53yPISrV9hEnxtSInNzz/isjiA7VaO1mAUTH705LeZNs/Vw3VB5zv/UOe8/jdQ3psaoqQBJfWiaQpGq+ulKvrJJoCLFHQMV9WeOGWLMjeFBg3GoZVGmAmDEckgxHI87MNRcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTElCiPe; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so3616966a12.2;
        Sat, 09 Aug 2025 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754747660; x=1755352460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKbJICwI7R9TEKBrctvbj5erT6wdzmAXj7iW9KBeWVs=;
        b=HTElCiPeRQbkPmk3QtuSX4qdDgWBq2oCn99UmPe9D6Xm+KXY2D9E0B/gJLG1J/pJuQ
         D9ww5bI1dcq8kQ3MNqugXmOr2RlXjs74LFHVcrWY8ScvxaHLZnjXNhZvCF7aBohkKInZ
         U0cFG6LGWYhLdBZWTTEAjmzjktoknrONPkumKqeuHvyc33Le06lwI4QSGQ6VySzw9X1E
         yZt45zV2LhnzIdDbyogXPSjClnFbbeEuKBn0RMxNN/+fJ2N3UIlrVTTlpr/fH6oisU8Z
         NeK/lsl/t2OxmvrK69sRjIJyGoB9eifAVurn02pjfBgSWvqNb9cnSgdZ32vj+ihn3j/2
         0SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754747660; x=1755352460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKbJICwI7R9TEKBrctvbj5erT6wdzmAXj7iW9KBeWVs=;
        b=uGQ6+Bml0w0myL0FH8hu9Pv8AYaWoQ2+kfsOc4bTXBHtkhPoiaJs76MIWyQtfrBW6s
         Ozt1ux5MUy3buFEcFIvXb4+59HYAPT4GDH+DFJvQVaeK5x9eKIaOZk0zyZ/f8EfxR3u+
         LmEULZrRBE7a+wkQtOVi9Jeh8X6rolYzkQ81NiLYTAH6BE52eye3qwWvJk/OEA0YCBIA
         uBwe3EADz/ATvO/7HB6oaxTdv9L6SY8aPRsHFTEq193E4RgSZUi/BjTyNBDBE7JEcqt9
         UomfaEXzUiFbM8WSXszi5qGiPRiVkFgXV8lGnvv3vQVU/Q546+2A3x2yEuOWzRXrH/Cq
         iSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1sJVETeK9HeQeEoWFAgdBz4reV4Igbu4zaPipPaInpafodR5wuo/HqQ+WMd/JgiGfhPgVUip53B8u0Nrw@vger.kernel.org, AJvYcCUwCS1K/XV2MQ905XigPAbFP4SmSyHHSdVv+NRCwBRb4Wogxb7adOKhQB6tXYR3U1pjP5xZl2LMdYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxekGWpPZ4uLjHtuKTWFoQhISnCl4q3Yq+g+c3PrBMB4g/QxhBd
	4/R7R0Pst7mKyIdDQbcOS92Yh1gI6r2i3bDaFhe3+gZTIaImF3srDNr5YlhWEkyi0HtKRihrmuA
	/faJXeH+N6zRJ/rwGaBRSi+uOMOd6nwo=
X-Gm-Gg: ASbGncuC7dNAYs7S7StHIk3903cGffPqX38KurP4QvbwCk6RhdeFVJbmA/+AL6ZDw6M
	knnmF3hH1bj+4hB6jN5SbAxeiCVASspt/sGGzJUpEBhYW6LiZfE7joa9RUBk+n0xhM/JrLM2Nlp
	GJUMIrHE3P9v6s1XXiz66PGsUGMWAfnMOUG2/nEdUn4rolRdeKcjUskSCzzK9ijAjFDhFafDJ5P
	+mUfXBrQQ==
X-Google-Smtp-Source: AGHT+IGFKn7yA9e2N9IurEtBV7XxrZhhF9iFQPjWWNgCk2ICO4tBbIc2md2clhXR7CaxLDLs5nDGWg7lakOdE+eW3dU=
X-Received: by 2002:a17:906:9f85:b0:ade:43e8:8fa4 with SMTP id
 a640c23a62f3a-af9c6373614mr675128166b.18.1754747660120; Sat, 09 Aug 2025
 06:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808190203.7493-1-marcelo.schmitt@analog.com>
 <CAHp75Vc1KgiDUUEjeEKdrSfom6NThPG-383O=sezydnrZLoGqg@mail.gmail.com> <aJdSYIv8_QX0WwdI@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aJdSYIv8_QX0WwdI@debian-BULLSEYE-live-builder-AMD64>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Aug 2025 15:53:42 +0200
X-Gm-Features: Ac12FXxIrAjtdDv5Q0kGFop7xcEZ9v_yGMoa6DhqTYIs_wezLkDMJmGOVN_uv0U
Message-ID: <CAHp75Vdgafv9hqtZYiouC_RgY+0m2a3TfOOsk12LUMDEmY+4AQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update max30208 maintainership
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, andy@kernel.org, 
	dlechner@baylibre.com, jic23@kernel.org, nuno.sa@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 3:51=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
> On 08/08, Andy Shevchenko wrote:
> > On Fri, Aug 8, 2025 at 9:02=E2=80=AFPM Marcelo Schmitt
> > <marcelo.schmitt@analog.com> wrote:

...

> > > -S:     Maintained
> > > +S:     Supported
> >
> > Just curious, are you really having this as a day job task?
>
> There is a request for MAX30210 support and so this driver may get extend=
ed to
> also support that part. Though, even if we end up with a separate driver =
for
> MAX30210, it feel unlikely to me that people lost interest in MAX30208
> as that's still in production according to MAX30208's page [1].

Ah, cool, thanks for taking care of this!

> [1]: https://www.analog.com/en/products/MAX30208.html



--=20
With Best Regards,
Andy Shevchenko

