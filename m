Return-Path: <linux-iio+bounces-12932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510849DFCF6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 10:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3849162407
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF91FA248;
	Mon,  2 Dec 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRaXnheW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E21FA16A;
	Mon,  2 Dec 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131386; cv=none; b=Hb5rjlki+IJTmv32Y8VXc4OUHP+6Of6tADDoM8rs/c4EMntOQxje1ERx+orgV2nVUqwYE1F52NAcvi260+khvyMb4iHYcO7aJf5DwJyDP/yrRqASvwjZsRxAYJ3Lk7/JV63prYNrFS684MrW+eF2onDbpLdF5ILZCoR3Q2Cj5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131386; c=relaxed/simple;
	bh=g4gw6HyzaksuOXDxjYZHVe1BewoRaC3XCvYQTNgdJjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZzqxszyvbWp3vUkA2g0fAOiMbvgkaDA8/A8uNE9wuTAAa+Y8g3Zwn782T0HGpnQJiMGCvCynptTnxXhaSxjqEbhSXShyeZKWis4fDMH4dHiSG6ZM/hX4jfZdMnbKmsRs8NNLookJzbRXoeeDio+OssuBrX7Y3LcjyIjlG9GzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRaXnheW; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so3291823276.3;
        Mon, 02 Dec 2024 01:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733131383; x=1733736183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoSXCHM+h910tSJRU701H8nxQkL3/nyAdM8/SWBnlLA=;
        b=MRaXnheW7AB+hCm9pAHj98UYTpbEdv6Qj5uvsgE+OhBwtmxxWJZLEiOwalshXVZUdP
         3N00dduUEiPNd5vsCr4x+sLf/xU1gCLT39urSUG+lf/qYJlch3Yb+6+AYtzLvXMuLNfY
         vaocj1qhY5WZANtqwbAjjZVGnp/SCq0X9K/3E7O6jHqRX2YYV66wsFHBEVdEsM5BtPOZ
         N2NC20C7VeDaqKABmOtPQ8t76djvbe8D4xRVZidAcM0SD0hPqOymlX2Z5O0C5cgv6PzK
         wzVFDqYMwudA1CJRwT3CUTwhc3ts8/Shx/5YnswbL3os2PBpd4KrOIivhHGY2280NjaV
         9Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131383; x=1733736183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoSXCHM+h910tSJRU701H8nxQkL3/nyAdM8/SWBnlLA=;
        b=tMQyjjgan1rffiUFTg+635RIiDnfC3VNK/jAVv96K18g0/W+9XsTr8uIGf2S2TIZde
         hLrM3CsBtho9CGY8DPlhhxZdrg+SYFVjsi6S9zE8wn+rOZTnvU6AE5mlIl4NC30DR/Re
         G7KxyaMxbpgg5Va8p8TpQtzDOksq9+eg9gCRSvS4Tiv0YjhbszM5ZT94kyVnwe0U7mVN
         ox09oNm71k+dqEPAjpH8T70U/OX7ABZDp7hNLo8HqrJ0ntPQkgphnGk3NPUEG4/VwWfz
         8SJAhPsNGZUhf8SjJ5MuMmy/TnU0qlCDYW54uBzmr/41x7sFWXY8XIoVFjrrN42/xITR
         NDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpBqjMHaO5mb/7IO1f3cKdwVonge/3yU2wMYwA1JigEP5nfeKN1dbwnPhhzXcgo+V/6goUETR6g2i3@vger.kernel.org, AJvYcCX/nTwtcOlvfDyRlNYK0ZsgJ1YoDvPPaELQQKMHJqjomCDhnwIsNeQcW5SQZyjZOZqC62hx9JnYxqVsDpWo@vger.kernel.org, AJvYcCXBNf9xPF+g8Ev4Nerf3HHGhGrKUabeHNfUSbaQRLs0NkEwGrwwyj1+Zmv+7p99gleUyhC8UfSUAFY3@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3vEBZWuH26zQwXKC/9cldbiwudj1g5yiik3ocYTIW9iD0oxb
	ktllL9Nubz5mQNuTwaryFL7+gT7kXh6WgeXod6+ATBXkCnxPEXD0BVk6EoB1vKr/O0m0RXYqBpP
	VGcXKP25bMNuSYEOBogPducxM/+M=
X-Gm-Gg: ASbGnctLbh8FiVCZRzNGH1T2JZVrTa4xz85em460UaeERN3zic1ACEa0iMcGYXK+iA5
	NsHOu9y4dHb5A+aSjGuDG0VJMzXL4SHCQkEcW4GJHp5BoHBee7oxGF7uLlZv95md0
X-Google-Smtp-Source: AGHT+IGztXoxAdcHJd9YnxaBaWbobaVNYryb4PFIcv1saAQn7Wr5i8e+trUl1lQbr3FaaKSqn8OvN2L7sBaEmyvuzis=
X-Received: by 2002:a05:6902:721:b0:e39:8a36:5781 with SMTP id
 3f1490d57ef6-e398a365a98mr11154731276.1.1733131383334; Mon, 02 Dec 2024
 01:23:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126074005.546447-1-tmyu0@nuvoton.com> <20241130202849.13eedb04@jic23-huawei>
In-Reply-To: <20241130202849.13eedb04@jic23-huawei>
From: Ming Yu <a0282524688@gmail.com>
Date: Mon, 2 Dec 2024 17:22:52 +0800
Message-ID: <CAOoeyxUyi_HKLH64Sokd9YU9vDnuizBaP2AOUYqQ8hTvJKo2-g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Nuvoton NCT7718W IIO driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: tmyu0@nuvoton.com, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, cmo@melexis.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Jonathan,

Thank you for your reply, I'll move the driver to HWMON.
Additionally, for conventional ADC, Thermal sensor, and tachometer
like chips, would it be more appropriate to implement them in HWMON?

Best regards
Ming


Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2024=E5=B9=B412=E6=9C=881=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=884:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 26 Nov 2024 15:40:03 +0800
> Ming Yu <a0282524688@gmail.com> wrote:
>
> > NCT7718W is an I2C based thermal sensor chip from Nuvoton.
> Hi Ming Yu,
>
> +CC Jean and Guenter,
>
> Why an IIO driver rather than a HWMON one?  Superficially this looks like=
 a hwmon
> chip.  We do have the means to put a generic driver in IIO and bridge to =
hwmon, but
> when a device is very much intended for monitoring of hardware temperatur=
es etc
> the IIO driver rarely has any purpose and a simpler hwmon only solution m=
akes sense.
>
> For temperature sensors IIO normally makes sense if:
> 1) They are part of a series of devices some of which have more functiona=
lity than temp
> 2) Fast devices where hwmon sysfs interfaces become a bottleneck - note y=
ou have to have
> a usecase for reading them fast, not simply a device that is capable of i=
t.
> 3) 'Unusual' temperature sensors such as infrared thermometers or very hi=
gh precision
>    thermocouple interfaces.
>
> Any of those apply here?
>
> Note that hwmon has better threshold and critical temperature handling th=
an we can do
> in IIO and it seems your part has those as well.
>
> Thanks,
>
> Jonathan
>
>
> >
> > Ming Yu (2):
> >   dt-bindings: iio: temperature: Add support for NCT7718W
> >   iio: temperature: Add Nuvoton NCT7718W support
> >
> >  .../iio/temperature/nuvoton,nct7718.yaml      |  44 ++
> >  MAINTAINERS                                   |   7 +
> >  drivers/iio/temperature/Kconfig               |  10 +
> >  drivers/iio/temperature/Makefile              |   1 +
> >  drivers/iio/temperature/nct7718.c             | 505 ++++++++++++++++++
> >  5 files changed, 567 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/n=
uvoton,nct7718.yaml
> >  create mode 100644 drivers/iio/temperature/nct7718.c
> >
>

