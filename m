Return-Path: <linux-iio+bounces-15511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45697A356FC
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4399E7A6904
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 06:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9B41FFC52;
	Fri, 14 Feb 2025 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1vOSeLL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5019007F;
	Fri, 14 Feb 2025 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514080; cv=none; b=gFwcFMHdVGMjkky2ZiyZVJb4K5ixvlj6KdJA9iL5MiZ24XA8DnJ+J2l957b4BKphFVXJ/6hslGdT3htAM41m4mh8LJ6M8sI4v0cjHr3/bItOEnjNieQtgnZE5brh2E1xPJFP7aYBeOd+0RqOc0+LHDT1zYKSri7MC+henTyEJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514080; c=relaxed/simple;
	bh=NAU3AVm4eV/usC6vbc9yMMvy4cwmwfP9l346LdyuCYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEFVOM+3X+4f5oEqHDoowuO25q8HTsf2+ZFELxTfEZZ36EJBo3NxyMppkH9qMJ5AggoXAYOs6n3lL/ElyvgXxAQrkGUi/36gJEnVfnK5mkl44r939Bcg7+bAf0k98gFt2ArA7s/kqJguxWrsQ27ND5LN1xLlkq92HC+zjN6AYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1vOSeLL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso1741339f8f.0;
        Thu, 13 Feb 2025 22:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739514074; x=1740118874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCsOlKlhoB3KyOaKJojj7jOpAy8XUWuEdDWgdN66pjs=;
        b=h1vOSeLLzG0Gti10pCMFoXbwdgmvo4kvoheOamW43wpJZYP1A3QjICwjsJMFJXFGHs
         FaD3qcQzmjNItZN5f7RBLsyzAC/g9G7gKph5BJmu6KruFj5mV7oVDqD0AgLeuHWj9Tqq
         DzDX4ZbMmya92kioFM8D/CIb5hvYe/TVQs0T4T2LB3T8nlAqJR3kPbATXWRsh1FNlkaG
         PwjzWONMVCQdGJ8HSWDbktZqsg7te0DpDl+PgxIVvuzucn5gcbuOd4Gn8j76oVmLviHL
         vs1Kmu2G+1Q5GulzPjPBD9ytonzxNOKo5p4XQcdu9PTq5o5C5ToRYJofpEyT3M5ZULn7
         1s9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514074; x=1740118874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCsOlKlhoB3KyOaKJojj7jOpAy8XUWuEdDWgdN66pjs=;
        b=r/dEGQ6EVvEkeA5oIB+9nFUuW1l6DITXWURmC7EA4jANsvYRIVcID8YzK/g/Zp9vpT
         tjK0CpmospconEPuEo6pICvJVQLnx58sycj1Fflh9M++jvfHNmSmCW7JhZWtxvtpRGXL
         II+Xj7GL1lfBIccGWFLuLZOlcAgYFkMt/tifpEqfeubThTxGuMK42rXSH2Hzkgp9HM1G
         JSOAqxJVAhedv/+oFSypevXf66yqowq0MEsGV93Qn+xtD+M5JD8DEj7DjKJhHHD7C40W
         OZ1cvLxmXM3ROxW1aRCEtVZVxzFja7NEjB+XGf4bc61MQI0Rf293QKMyHt0iEi6FXukw
         OKZA==
X-Forwarded-Encrypted: i=1; AJvYcCVDfGoBouiLM6xDfLht//yQIQkMgcrO8uk6cSghCBPkYXaWB6lfN9Sk+rpbzX5DtmcXNtASN5vfM+pG@vger.kernel.org, AJvYcCVQXuBVoE+xHRvrYMCxKiaBiB/ZRYcU/vJzm9h9zr96mFKTPQ+dYciqJfV7WilFfJbFkwWgZq5tJsibEBM=@vger.kernel.org, AJvYcCVTfC1Zvd25q5Vuz54OP7iseyYZXLzp/1WDxECbfPVrp0oT6kHox45EsscZ+z8bW42yas6k5iIMvJ5RecJ7@vger.kernel.org, AJvYcCWs2uVv3u2g/FPBukZaLFoIK+MX+7mKyhuHyWUSoppNY8DchheHJIUVjQmBIj7QRRcWT3I+uG3rmX8h@vger.kernel.org
X-Gm-Message-State: AOJu0YwLd+hqMtpj5wkYRVKyL2Le/TSKaHhKr6/Q7xPu7/KCaYgBAEgV
	TbApTM0YhazM+HV11qnZIr5zzL4rvZHtUOpk9CX7P1gArnbO/cKyss9TjzRZKmxCTGl/2qX0kR9
	hNn8hhE92t+qCOENG1jlqZ4jqYqQ=
X-Gm-Gg: ASbGncuXCbHhUT59c7sr+V9imUOCPRVYvRXESRQL3Q26z5Zvrf9UYPRLqbRGjKb+1dH
	MdRQ9pCnQ3+pvozLw6GCqHhHqQfd5B1pN9S/ZPr+1gH4GlSdnLUIMqnLf5dzASGnokM5pyffa8g
	==
X-Google-Smtp-Source: AGHT+IG8BOtiCxNf6QI0vU+mnOel6R4Bjz0DlGpwWvpzOVrQGjoe4i+7P8GUXY5Iqx8vx2Br9ut6AYt4WMmQGGBxKHs=
X-Received: by 2002:a5d:6da9:0:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-38f24f96284mr7091087f8f.25.1739514074226; Thu, 13 Feb 2025
 22:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064657.5683-1-clamor95@gmail.com> <20250212064657.5683-2-clamor95@gmail.com>
 <20250212-unwritten-compile-7011777a11b3@spud> <CAPVz0n0xR_nGPdWn800H=HhMCPqnRUhqP-s1P4eMhtpZdxpxzg@mail.gmail.com>
 <20250213-reflex-earlobe-ebbeaece6fad@spud>
In-Reply-To: <20250213-reflex-earlobe-ebbeaece6fad@spud>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 14 Feb 2025 08:21:03 +0200
X-Gm-Features: AWEUYZmVS1XUCLAzw9vAyVc_HXeyFlMuZvE7KiYkZpLOEfJLCqTLk6pkIqA4BQ0
Message-ID: <CAPVz0n1aw1+kKhvGwOUi_58HqRqo0fHxDNRQZt_2O4yJ=ws56w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a support
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 13 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 22:15 Cono=
r Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 09:39:06PM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 21:20 =
Conor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Wed, Feb 12, 2025 at 08:46:55AM +0200, Svyatoslav Ryhel wrote:
> > > > AL3000a is an ambient light sensor quite closely related to
> > > > exising AL3010 and can re-use exising schema for AL3010.
> > >
> > > Quite close you say, but the driver is entirely different it seems. H=
ow
> > > closely related is the hardware itself?
> > >
> >
> > Well, I can simply duplicate al3010 or al3320a schema if re-using
> > schema is not allowed. AL3000a has no available datasheet online.
> > Downstream code for al3000a and al3010 seems to have same principles,
> > apart from light measurements.
>
> It's probably more of a question as to why you're duplicating the driver
> for them, rather than telling you not to put both bindings together.
> That said, information on what's actually different is helpful in the
> binding, to explain why you're not using a fallback compatible etc.
>

Quoting writing-bindings.rst:
DON'T refer to Linux or "device driver" in bindings. Bindings should
be based on what the hardware has, not what an OS and driver currently
support.

From all available data, hw configuration of al3000a closely matches
al3010 and seems to be part of same sensor lineup. It is not
prohibited to add new compatibles to existing schema. Schema does not
take in account way of processing data generated by sensor and this is
the main difference between al3000a and al3010

> >
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++=
++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,=
al3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.=
yaml
> > > > index a3a979553e32..6db4dfd5aa6c 100644
> > > > --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.=
yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.=
yaml
> > > > @@ -4,14 +4,16 @@
> > > >  $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml=
#
> > > >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >
> > > > -title: Dyna-Image AL3010 sensor
> > > > +title: Dyna-Image AL3000a/AL3010 sensor
> > > >
> > > >  maintainers:
> > > >    - David Heidelberg <david@ixit.cz>
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: dynaimage,al3010
> > > > +    enum:
> > > > +      - dynaimage,al3010
> > > > +      - dynaimage,al3000a
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > --
> > > > 2.43.0
> > > >

