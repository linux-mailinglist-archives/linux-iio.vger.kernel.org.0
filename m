Return-Path: <linux-iio+bounces-20834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E184AE2B70
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 21:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871403A5C85
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71526FA5C;
	Sat, 21 Jun 2025 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7zxZgTr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D632149C4A;
	Sat, 21 Jun 2025 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750533919; cv=none; b=qXYDkCuLcXDkGlgm9oPkycfKD5Krjd5MwxuSPsZuxBy+Qx+z5bqeaYJ9E+ebfWSqXM7x/niBxsrMHUFc4WT/ZprhYMeoz8optMYypqRh8oLxvb/muveJ3CxO1Qcn8tUMeuTTBcapvS/vsSkw0PetnGFS+6Qo9d2q4cSLKn4Cd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750533919; c=relaxed/simple;
	bh=3NVITkTixvEjR5IDowbSLBIV9lH+tQ1XjjE6qpYhyVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/YzSjEu1sCNCDnnMNTGitOzBz0aeHk5VaLnLUJjk0zCe8GcCRpi13VJ98x2u15mWaoh86nPkpfKfEEjXNJqSI9cFUt/+uRwljG6c0pHHZJ15T4HDXNuYo1TFCEeL5BBLFUHOVW70EGbygq86Z3V6cdvyGqeR879nVDtviTQikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7zxZgTr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad572ba1347so470383766b.1;
        Sat, 21 Jun 2025 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750533914; x=1751138714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2p0xkDcwjQK+9++i7Y9S6LbGF/qPoK8hHd6+P81clc=;
        b=d7zxZgTrqjo1IECI9kPH4B6T5H94FiCZa8O8Lbmqbx1E1uXzceH0TUGJsuF+3dm+Cr
         PChfQEUcgS40laiI09jUM1HbTT0vkPXuBwyVM6ku5MHLXebA0jLaq/vj8nARKDrLkLkg
         Ny5OaQlTmL8J6jyXQuSgUH400FeOd0I82iSLQ/yjyPIZASpPeNZBg60lks5RqQVACqT6
         Vh63eVUVP3ikwDuBopU5vdarjJkfZG5PEG0f3uUJiecAp6evh9t41AEciJPI9JUNEe2n
         wLycFoIhWvfw5aFq0q9wzSuJO7r+fxrAa7d+eiWkNy0Y0/1YrLp5fS+9jXi+LU0Q4TCY
         jCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750533914; x=1751138714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2p0xkDcwjQK+9++i7Y9S6LbGF/qPoK8hHd6+P81clc=;
        b=DsjyYmVRqAKl3RL5ZWZVFgT0RLsLtjRn6zod553eNxavzaoLqYAR/6z9WRP/iL3FZW
         kil4d2nR/WOHS0OIA2WhpyJZe6KhK7ZbCR/uBFSRAOwLscNWUAQ5kAyWFW5jfhZkJpKc
         QiiquFhWjnzXYymjMh1zaztB/qAm6X0MAu9GQRvB6mS6Qv3M5qKRxb7GpObrAExX5RlH
         S3UEQ8BC4bZglUOkxxWe0fWq3WMTNPT2Y42gf7mZWKPY+MUZUZDQ+U0Fewy42Hhv5Kqk
         x+yw8b2RzCORiFpRgVynQRjJ9jGNbkF4LZUO2WlPSw/yWlX/YZKKUaTSA9dwCZo7GTzd
         6hFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWPif0KbfmV+hl29glG1ugm1oOQuTYWDuwXUp2v6CYs0V8A2fpg6kA0XtRQZrS3VV11OhHaL89vY0=@vger.kernel.org, AJvYcCW7+dF1TRLno3wk0txAO+HrpkVYls3GfEfjDm2Sr2+zCseonb+5Ye1h3V9D6sevSq7CdbWqn2LAVCc0mlZz@vger.kernel.org, AJvYcCXWKD7O6y0VxrtQmMy7rFnolG+5ew639y4nVXvgWL6WnXcrrK2CW8H/z8q7NvivvwhMUnyHxkTb6KIR@vger.kernel.org
X-Gm-Message-State: AOJu0YylUAvYfzQeGmMYZmurTJgIn18DXqfppyID48CYY8Z9RlAOlNT0
	tGH4+iyJfVJFDjAoYYkHwdARZUIa9xSv0zC4JmgMMzk7utTHU18+rK2+/FU4icEUTCUdgm92v4U
	2HEcbsUSR53Jdg0ZaKdmscvZh11+RARg=
X-Gm-Gg: ASbGncupcdvk+u515Mjg5FgVSXHDu8hbgoTNhUt9+NDkv371z9wf/vFlu5r2jl9cgcb
	yDlN7ks9icF7sOSLhARYC0Bv0usNVf4Hho/czfE1ycR6aH1WpZ+kIDiHQkGgURmILVn1R0zbp5D
	GvQlwTHgHoVV4ga3OgDZmnQtGPH/en7dOmoPJoJsX+hR0=
X-Google-Smtp-Source: AGHT+IF9D41jxFD2zo6LUxcBBubPPAUleT+kh/hdbAjAVUOMmdkZ/F5VenVcdT1IDVyTqThiPHuTFSeCZs4WzfP5YVw=
X-Received: by 2002:a17:907:9087:b0:ad8:a935:b8e8 with SMTP id
 a640c23a62f3a-ae0579d1a99mr500577366b.5.1750533913577; Sat, 21 Jun 2025
 12:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-9-l.rubusch@gmail.com>
 <aErE0xmlm4qBHg03@smile.fi.intel.com> <CAFXKEHao9xKsizGLMQxikcLbG5Him9n9i3btLtqK2Orj_39a9Q@mail.gmail.com>
In-Reply-To: <CAFXKEHao9xKsizGLMQxikcLbG5Him9n9i3btLtqK2Orj_39a9Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 21 Jun 2025 22:24:37 +0300
X-Gm-Features: AX0GCFuId-A4XxZYQA9oJyRLpj9ewhzTQyspj6yopi59uo4loSE3Xf_d9PUBMFE
Message-ID: <CAHp75VfxqMh8j=TAPFXTDx2PSPVU=No=vDdo+-J-ETDavuYnRA@mail.gmail.com>
Subject: Re: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 9:54=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com=
> wrote:
> On Thu, Jun 12, 2025 at 2:15=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jun 10, 2025 at 09:59:30PM +0000, Lothar Rubusch wrote:

Please, remove the pieces of email you agree with, or comment on why
you disagree. Leaving tons of the pieces without comments is confusing
at bare minimum.

...

> > > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > > +                     ? min_boundary : max_boundary - adxl345_odr_tbl=
[odr][0];
> >
> > clamp() ?
>
> Isn't clamp() dealing with signed ints?

clamp() is a macro.

> Also, I'll take the diff from
> max_boundary here.

How does it affect usage of the clamp()?

> So, I'll try staying with the current line and hope
> it's fine.

I suggest you spend some time thinking about this expression on how to
make it easier to read and understand. In my opinion clamp() helps a
lot in this case.

--=20
With Best Regards,
Andy Shevchenko

