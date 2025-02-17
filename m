Return-Path: <linux-iio+bounces-15708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BA8A3869C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C2B1631B1
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D56221546;
	Mon, 17 Feb 2025 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REXlLDW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD521A953;
	Mon, 17 Feb 2025 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802840; cv=none; b=RfKZfIm2II0GX9DuEQ/23+WvmyIY3pTUdkwTMnJnxkwzWpZdxotLuQtElUYxc7CEUkGqQflh9RzLX3AcGXKSZTehCrWUziyaDE7tyhDVH0MPCedNtoxLa0OPKs62gRoapLWPo3PNMMfTUUr201cyJzAzlFv5EXgJVk9Axj+jI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802840; c=relaxed/simple;
	bh=s4FZcldSfuvs/OAiBQjChQlCVE02/dSY8r/d3fNaChQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUzvUcqzp2MGAvXUd7vjhwkqz7i9MCwdUGfk0aj4il6dUF/s7Wpvu4wj5bU2tHJjsW8T5JJ+Ed2Dhtel1MsbLJjRzLxZZbb/gD7guSzBOlPC5wY2hxRgV+jmO7OChlcLSqD7b+XQB6ZN/UB8pw+gIqRrFvoojVAV2PBZ7LkDuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REXlLDW2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so30279895e9.0;
        Mon, 17 Feb 2025 06:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739802837; x=1740407637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3eDcVTpKoU3IaebilmiBpD0xiEz596IPX2MkPMQ7FA=;
        b=REXlLDW2MUSBve2NxQ9Zt8/8GmpHZwRzUhm3pWMq7M7kMibmQnBqR76Mhfd9oD9n+W
         3W5DgbkKlMa2pmP+xbJoHi2MrULZcceLlIeppQTzr4jsgEHHkdkdOrczhpdS4rYHAM9+
         6QRH5K9Wht32XvBJgnHpmpOtewKRKrK70KmnAWnCXA7vjosEB8ID/m3l2F/k98Z3gKRE
         xc8hUadkd7sfBF7aUaUIP+LYOjFv3GL+YA2rAcfqug2QbABXAjLt89vfGTdmMkusl3Mj
         wMl8xUNFSZB1+KCnHZEEq31E379dF0mcrQXDZyt2FZVX3AQZV7tB5ifUMFkNq4G3bhI3
         bncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802837; x=1740407637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3eDcVTpKoU3IaebilmiBpD0xiEz596IPX2MkPMQ7FA=;
        b=uOT58X99nw9PzUHAoaBGCzJjaSsPj1bIvTQsyYKLx76t77sPfO/bSeePL4iY68RZil
         3bTy464M5HvJ5mmTRPchoPEiA8OYlYXfiqgPvU5Ua8WG/q/FryM8B76f0KXB2Bx6/69R
         Vg+dTEmKt/SdRb+GmkuqVKqzPFoysbovyYqfslSgek3qNJVTkxqxkLpR1o8g+88343/c
         ZK1+Tj6uTSKy6ClvC68yoh/s6/i8NWpNvtOf5yivnNfMXsXUx3x0TzqlInd42DdteWGU
         12+7stEToMWB4fP8mH+iRLlQGPH2bwqymqA7TO7W6YeT2CVVE3H2xxWN90BME4orIg7i
         g++w==
X-Forwarded-Encrypted: i=1; AJvYcCUH2RXABnliDM+eiD6pMhEYDTHklMovUYIt2KGwUzVz4VqFA5VyFm8v2IUhSuXPIEhv0aUvFjDKoX5StCE=@vger.kernel.org, AJvYcCUvseboXT9QMcvMrakNTcrNlKXmAV9dhIkPtnwPQFEX+oqIvLL8/nDIQ3XX1oh2cfdzeBqwaWpeWnFP@vger.kernel.org, AJvYcCXxONeiFpT1V63QDbGNNllj7EvcOJvnGVr+yOz+IuxfzBYmP+UFPerVqAqFcgaoT83fKD2uM7FR5dnoI7cC@vger.kernel.org, AJvYcCXxUvhcSGpDpNqXfOSVPgIsxcB0Xa7keRVFfvFEvSKwtxZy3N2PYutqg82GI2b6zkbUyTL1VmIZkgvx@vger.kernel.org
X-Gm-Message-State: AOJu0YxbCEwxvnyJ+REI1w89TyuU1GvyACQb+oGUoVx8CW2VOJXuVtG7
	kB+qPT8BoPxxXHnzghfL06GNhoGwFXc+XHCTRPmP/5c69iRX9Pqrtr3MpB8DxlEoNHd4eSNIMkR
	oTUB5BlHzw5NkmMxKRgY/T5s9hIo=
X-Gm-Gg: ASbGncvm4KOz7/ZpK3EjHPhZ6EfWiz+I1IO6AV7HzxiYiSCDeOy5U9G4yB0HsLxsO3K
	8PDuHTxaAlupE4Rt2kpASuhWzf93ThDcEVnUnuBdiUyrgdjU0WK9+CM+7PEhTXhMEBW/28V6pxQ
	==
X-Google-Smtp-Source: AGHT+IEuERBuQnmdvYeQnbEgjpz5oivYR2/NeU+ZeDZj6y5f79re8Qc/hjfZmskbo4J7XhuGBCBKQIQ5nW0sf7jKqYI=
X-Received: by 2002:a05:600c:4e88:b0:439:8bb3:cf8e with SMTP id
 5b1f17b1804b1-4398bb3d119mr16449985e9.20.1739802836742; Mon, 17 Feb 2025
 06:33:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140336.107476-1-clamor95@gmail.com> <20250217143006.1f043a0e@jic23-huawei>
In-Reply-To: <20250217143006.1f043a0e@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 17 Feb 2025 16:33:45 +0200
X-Gm-Features: AWEUYZnoYmWGH7uRDOTDGMyupdg6fWLMPQSMtlg1TZj4Q1o16qSOkRPpRU7P2Zg
Message-ID: <CAPVz0n1FKe_ujAHyn=f1+12pV4r3GZpaZKPZe+caE79L3dn9tg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] iio: light: add al3000a als support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
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

=D0=BF=D0=BD, 17 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:30 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 17 Feb 2025 16:03:33 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > AL3000a is an illuminance sensor found in ASUS TF101 tablet.
> Hi Svyatoslav,
>
> Just a small request.  Please reduce rate of sending new versions.
> That tends to give time for discussions on earlier versions to progress
> and for more reviewers to see the current version.
>
> I'd suggest at least 3-4 days between versions.  It's great to
> responsive to reviewers of course!
>
> Jonathan
>
>

Once you are satisfied with amount of time patch will hang, let me
know, I will upload new version. Thank you.

> >
> > ---
> > Changes on switching from v3 to v4:
> > - return write function directly
> > - clean up and fix i2c_device_id
> >
> > Changes on switching from v2 to v3:
> > - droped linux/iio/sysfs.h
> > - set driver name directly
> > - switched to IIO_CHAN_INFO_PROCESSED
> > - split al3000a_set_pwr into 2 functions
> > - added i2c_device_id
> > - improved code formatting
> >
> > Changes on switching from v1 to v2:
> > - sort compatible alphabetically in schema
> > - clarify commit descriptions
> > - convert to use regmap
> > - arrangle lux conversion table in rows of 8
> > - add more used headers
> > - improve code formatting
> > ---
> >
> > Svyatoslav Ryhel (3):
> >   dt-bindings: iio: light: al3010: add al3000a support
> >   iio: light: Add support for AL3000a illuminance sensor
> >   ARM: tegra: tf101: Add al3000a illuminance sensor node
> >
> >  .../bindings/iio/light/dynaimage,al3010.yaml  |   6 +-
> >  .../boot/dts/nvidia/tegra20-asus-tf101.dts    |  11 +
> >  drivers/iio/light/Kconfig                     |  10 +
> >  drivers/iio/light/Makefile                    |   1 +
> >  drivers/iio/light/al3000a.c                   | 209 ++++++++++++++++++
> >  5 files changed, 235 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/iio/light/al3000a.c
> >
>

