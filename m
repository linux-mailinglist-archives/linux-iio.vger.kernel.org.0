Return-Path: <linux-iio+bounces-23431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B6B3C8D6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 09:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF940580E9C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7B27CCF0;
	Sat, 30 Aug 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+MjoK3w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1D278150;
	Sat, 30 Aug 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539573; cv=none; b=caAWrUiX1/w9pHHYAeYEkghKb0KzkUx2PAzpQAjP+3P255YOVpZibrO8CVni277cPCw0l5fthcqSNAmXJLU9URRnX1QEAsDVpVBSeA22JSuNB/zumrbtnUBVq3u0eam8YtjfAx0cwL9GCYbMNWlT3BbSo52MF5KCtk/hRMsqipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539573; c=relaxed/simple;
	bh=Bg9g1x1rYaTs+copcNUaaE4C4bSo4LI700eHfn+A6lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reGC5GMgJd5DJykpr/WAr1MPeQve5a9vkGPOFB5HtAIgQIHRGyDxaruVui1FXnGYzKfGUUd0ykdfttXDHZZdaTUAqChgBFzIB8ZUbbYVEqlYQLgCalMZkJD1dsozpSJjAA4aN3BdZveZDoZoVAaJf7yqpxlkkDf31QvgN9r6pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+MjoK3w; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ace3baso483385866b.3;
        Sat, 30 Aug 2025 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756539570; x=1757144370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/ZMWXFdOhhGWVgKNOZATkobr1qFVHPKCGw846d0Eko=;
        b=H+MjoK3wfl0htYP2pnyUYw6kX79gg2WvoYjJMnfVOsENKfPd662eOiRwKDardBVjc2
         Gz48WLDFZdn4o2/MjfddsVueEgHPsXZoQIciLDDP/zTzX7nDOmxIdXjaWPTlw30tNPro
         FEzjuDRdHUMx7KhhHH4Cy+T4/6B/4I1ORWFhxHDwv1KIzZ4O2WQk0LvBGbByE6Uou+gm
         6elq3SAH4KB0vRp/RM/bJgomv1B2aUzA4PjoZdepGybMN5Mxdh95oz+h8iKortiaeLsk
         lIkJ0sw5M+B+s3gDjnl5Cyu0X1fD1Cs1hpA9ZCRKiCmWN62L+jDQ2jJKT+G3SuJUNIQc
         Hqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756539570; x=1757144370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/ZMWXFdOhhGWVgKNOZATkobr1qFVHPKCGw846d0Eko=;
        b=WwcfC1mvwJ3yXxnXvQK/ol7ZOx4UIPPKe6ToMy5AayWLleqxT/uhYHbDPWVtSyLyNP
         GfkCuUw/XvUbOZeSLhvgFsBLl8ZT8I4c3sMh/JfU0vOubPaWJNOd41ZMY9QbUlEiCmiw
         RdlDRIWBfU0y9EvqeZ/YXeI8b9EOT5QUTxrLYrsI52GeSy+/aMRncMhHeczSZ0gccq4c
         XCobGrfBILPUt9/5DNLdcwsrCsUcQUh6GQVopJ555nxcsNPzg9UYSx0zyfDtlyT3WUDk
         uIePvugZGwvNb5YN8vGYl0m0dI16UW8s5pfWJaqvG8YMnx5f4Kaxn3aVHpQPgR6PE+on
         EXKg==
X-Forwarded-Encrypted: i=1; AJvYcCVAZyQYPcdwVMLcCy9JHNZ6clfBrWWfgTk29J2gf98pcdGD179Hi7BP+S0iDSp8Ujf2RLX5vR3iM6vL@vger.kernel.org, AJvYcCVLjI0Lua3D4Y5IgP5Pg+9aDi3ZFiV8NzPzaRka/obOev5KHs2sXJ5tuFsdbPfE72zodwxhVYLEZyC00JL0@vger.kernel.org, AJvYcCX8EfGb9ZcfJPitgb76zbvKqkSERW0qxX3AQ3LCR/epK1EEDuaXZecIGtEJO3eDd9zBsp7rz3V6zIYR@vger.kernel.org, AJvYcCXtmYAOvGKbgFfPI+1pnDy2lgTudvd6oi342yGRUgwYOSwh1d8j5IfHZK8PlkIR6QaYn+sXGevv0nCr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ESWnU+w10MJ+G7B6hm4gTKadsnPAX2T49s62NBgmWFB4IovR
	3GFncC+ijUFE3WVZVvhG5Q1tThYumiFYucxJiURPzGP8TQZr+IvVFB3i0q3ZfVB7ORZzp6t1tgo
	ih3zYawESvyK78NeXCLZShlfyMZ/sVI8=
X-Gm-Gg: ASbGnctnuYKtfD7I3KkeX8gszqURspPUZ7Wcvr21tVTB8teyMNbDVmcX9PEe9iSTaFA
	eQt/VyE+NxyPc2+27JU5cKQ6vphQycZDPtr8Jk85TyguQAfaP4/ED/baBufW4Kbt5W9eQsYpwYd
	OsbYYGE+7yU4H4ud+3cb3PY54FuwCzes4AqkdpiVa1RnTk1MZqqi+sK8AZwMzyNAB7S1v4oO14i
	jgdlrE=
X-Google-Smtp-Source: AGHT+IFp2u3E8NDGllQA8/h/rnikwJVHJdBwq1/zISCcd50jQPdSoWEhx3RdWQ7Tbe6a1BaxlRZ/yqbws6XG7K7lxvk=
X-Received: by 2002:a17:907:9623:b0:afe:ca13:a1ea with SMTP id
 a640c23a62f3a-b01af2db751mr100999966b.0.1756539570015; Sat, 30 Aug 2025
 00:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <4e2b2d07a255bb249a1dc40a4470c7e123d4213f.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <4e2b2d07a255bb249a1dc40a4470c7e123d4213f.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 10:38:53 +0300
X-Gm-Features: Ac12FXxKDFZV9bCsQANXtl7PzxIoEWWvJTOokcoVBhIUQhe739fQCVQJ5uBpgkg
Message-ID: <CAHp75Vf6xa_ei1WbhGaQ+xKUEp_6JKcXFYJZpQvYd8YN-33S_g@mail.gmail.com>
Subject: Re: [PATCH 09/15] iio: adc: ad4030: Support multiple data lanes per channel
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, jic23@kernel.org, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com, 
	andy@kernel.org, corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, Jonathan.Cameron@huawei.com, 
	andriy.shevchenko@linux.intel.com, ahaslam@baylibre.com, 
	sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:43=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> AD4030 and similar chips can output ADC sample data through 1, 2, or 4
> lines per channel. The number of SPI lines the device uses to output data
> is specified in firmware. Parse SPI read bus width setting from firmware
> and configure the device to use that amount of lines to output data.

...

> -               offload_bpw  =3D data_width;
> +               offload_bpw  =3D data_width / (1 << st->lane_mode);

This is interesting. What's the difference you see to the use of the
right shift?
Also note, in case of lane_mode =3D=3D 31 (yeah, I understand that here
it's not the case) this is UB in accordance with C standard.

--=20
With Best Regards,
Andy Shevchenko

