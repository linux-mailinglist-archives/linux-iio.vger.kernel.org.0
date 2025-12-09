Return-Path: <linux-iio+bounces-26968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D3CB04F8
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 15:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50E303009C1D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134122FDC49;
	Tue,  9 Dec 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqZNDQ1o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E815217723
	for <linux-iio@vger.kernel.org>; Tue,  9 Dec 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291322; cv=none; b=p02+iPlTP3/nMI26tDUEfglQX/tLHpK0/BydG6jIaaYaSeypeoVwgo2F1UY9rcxgeeeyxglLYfQ+OQ6ySjgQ+P2QTFUDfHS8Lflahef/qSjILxfdIr8W+eJoG8RO3g3p3CbuXcEA67AzzTQ2eRuBmnZIvBs7f32p9WqfW79D2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291322; c=relaxed/simple;
	bh=gHqdCRggiC1qawexOpb4AjKThsp/g++sisBWtwBvyLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZp5ENWZ2PpEk5E/iSAM8PDzGzqpWN7wFmDasfF4+Bmm24kKq47y2UGKuF5eEZ6GRMPyWsbEAvZiUQwGZag+MIPWg94WugtdT1FkfX+WuMU/WRDbHG/t5BCKIReQi/cWfONz8sIJEwFr33AelFmaenDoLSG7xjWtb5qg/leXNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqZNDQ1o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7a6e56193cso100117266b.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765291320; x=1765896120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqRkHX3uUoTV7RGz58i34DgHDqrGLuheoNHC1Vcq2fo=;
        b=fqZNDQ1od+BLFiOV3Way36DsEUMPUoq+ve4gd55/4oxztgPF81vbQX9R3L5IwJ4fOn
         BMC980G5s+Wwqf2Zqhhv0O2ZSqkUp/VYmtjFHeayU314Na5S2mDBhxBoDez2fI1wOp0L
         x4yF4Paox2vjOD/DV744FS9ILCxGC5zzE065Z2kiGJ+oKzI0cqLm+hePndFRbs/OhLxp
         /051PoVi7aVvI9jBzuaEk8abmJXkq31io9Iwm5R0c/geDf282OhU8+ZbhqxbHoa60bHc
         2bkCaWe9vtf8sqcbRjUDDRLuhIETnxUA6mUFSNbKkDIR9vE7P2IDHl/qLx1B8ZPPVR4s
         sUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765291320; x=1765896120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RqRkHX3uUoTV7RGz58i34DgHDqrGLuheoNHC1Vcq2fo=;
        b=AAbOKJDoMUTCT+lo6PDpbfN7TbuziREUCSETdbmDd95rstflWssBqwpGvlYoNBOdE9
         c5i6WABjbRiC13hDv9th9v/uk8E+PoEWVlunRLm7tpdLj6K9zIrX/mzOw9JSjzXXGdfb
         TVRSLHq+my/GgL9GW7AWI+W8Jg3tQ+20bUK8+YopJ4Gj/HPNaaaEsEC+dLM4yrFommC5
         p4y1yBUFH9L1YD9e/qUVLM8u8ztiexxkgwVSLjcXaTZ1kxaNOBzQsBxdksZGuCDN8cUK
         wbjv0Au6YPDTaJezqlPwL7z3s7wOUuOPazK9hOVstFmI4pL9sZiHQtxWfL6HHYbTo6OY
         wGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxSuTAsLw+kJ8iNKg67szPmWNYugDnQm/AU07Z4v3ftHbUFprIWKC3LbsTGluuoM6HsCN7LaIHKeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLtlNzQtghb+TIvChGu0CnYgNmdYdj1GyZiViqU66cTFW/jnd
	an7fvOAkqVA1cyqQwNQAjfBc+5SD/NciKffqAVAnsijQVVe/eZ3uvNOL2uN4LEZt7JfXbtKIooS
	UqRTd9D/0H4Cj4Mu/Y1gY2IBwHFBo4YQ=
X-Gm-Gg: ASbGncsXBLU0LWTqAeJsBfFTZe9YgLeJ+Ty36FubdlQvLt0SS1XDamojBG9nsPGUj7C
	HulwH6OsXruMFL9jamYkjyJmRKFU1dqttBGsjVrbWQ3tAKhpKEYmAnGgy532lnO++vCKYWyX6Bm
	LDv2NBhWmcV/YA0gxUJWk3fcjsJBesqImX99ByZJh4KtWagFXMWhgHzn78yFH4xe/mMyFgUFyDI
	47fd+a286lBpS/FNgjpod5ykGarTz/a7BB4tIOYJQVkBakP0hGjbdGBKEtRmTftHKzHCqk2cnMp
	XZSj6uUTljHpHHiZ8NWuLYQZnd7l+8tW+XM8k2sg4cVhA+w7zNQvgnhZ+K4DzeBZNMLjpvM=
X-Google-Smtp-Source: AGHT+IFxmZiNI42SRpXqXTDNB51Gn26kid+01P2lpGxZFZVLJJktwR5+c0QfKmFQciisvQS6DYt+VQuwhMDpI9J1SCY=
X-Received: by 2002:a17:906:c109:b0:b76:52d3:c870 with SMTP id
 a640c23a62f3a-b7a24514134mr1260140066b.43.1765291319480; Tue, 09 Dec 2025
 06:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com> <20251209-add-ad9211-v4-2-02217f401292@vaisala.com>
In-Reply-To: <20251209-add-ad9211-v4-2-02217f401292@vaisala.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 9 Dec 2025 16:41:22 +0200
X-Gm-Features: AQt7F2pBBS715lQDsqRAwsno830A62St3Z5PysjEvjs99zqnEB7jPn5_JfMVi4E
Message-ID: <CAHp75VeOZHvxr60R0TCS5_c-xsrmfC97gWdP4-EWvFPpbodLTA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: adc: ad9467: sort header includes
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 7:34=E2=80=AFAM Tomas Melin <tomas.melin@vaisala.com=
> wrote:
>
> Include headers in ascending order.

Thanks, but...

>  #include <linux/iio/backend.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

...this was specifically grouped to show the relation to the certain
subsystem. At the end we should have something like this

linux/*.h // generic ones
...blank line...
asm/*.h // generic ones (optionally, if there is a need in a such)
...blank line...
linux/iio/*.h
...blank line...

So, what I meant with fixing clk.h is just to move it to the main
group and sort that.

You can check (recent enough) drivers for the examples. Yes, some of
them (but minority IIRC) might have linux/iio/*.h among linux/*.h, but
usually they are grouped separately.

--=20
With Best Regards,
Andy Shevchenko

