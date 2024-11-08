Return-Path: <linux-iio+bounces-12021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670399C190F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 10:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C722282317
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8201E0DDC;
	Fri,  8 Nov 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Uc1ILo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1E16C850;
	Fri,  8 Nov 2024 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057839; cv=none; b=cUE5YJVsAN1mXJbrBBKAxG+9IsMXUlnWn6UUY8YTCqzaY89dxlCDtwFPXLdqpG1uHl2m9PcnV6p5x21qBGB8kZdU1X+Pb9gY8AW7J+jc+ynsjVU7aUp3KxuLkEfD45jmwSslcMSzO8q3Odxv+9zmSq+FoCNU2zPO7UjGWFLBd5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057839; c=relaxed/simple;
	bh=5tiFYnYNjiF9DxyuqMpwBgTABYBWW9WLbjtJmblyCqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pel9K78f3cgmzm4JW3ZiTQkdvQizToFi3FJ18h3u4HmBU3nCSpGfyfCQfiT1js27GXQ7tAb7GwjK5qAyknvK3vUXQQADCvnDR/FA13KeWc7ORebhrH5c4ySPcyePRA9wLX1XhT9EZiTftrZxWFWzo430Ptae221w9daj3a+b4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Uc1ILo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a628b68a7so317345166b.2;
        Fri, 08 Nov 2024 01:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731057836; x=1731662636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqNbdR4tY83FWQ35k8iH8IJFZj1/6xMoHklTonqN55Y=;
        b=l2Uc1ILoE1Zb3b2aIKksT35Z8a5iBiMI/PDc1SdV5Hd9/l/+cjPK82N9C8734BeyFw
         D8lz84KkHBHJnBiU4JnKvwOJQYaDBEVzjVdYDi//+Pevn7S39C54w9nAdVAJhHIObHlj
         L/pdyVcIlPDtfACSAntLFSQdP17jJUdIxMWb6EnTI2gdbaCKcx1OroiHSQ+0iegYJeHF
         nD8DRS1yISJo5KKVNwE4hhmXsiRvhtd6t6hogRKzD82zTlngeX9OtRJpahjTT+M0GwVH
         LLY0TzyB678xhM4RHZ/I9VlE2lRx0+NhYkuM2rBOAEEh2hOZ+hEg6oOQvaSMyGBOW3mN
         k4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057836; x=1731662636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqNbdR4tY83FWQ35k8iH8IJFZj1/6xMoHklTonqN55Y=;
        b=ay7cNQ+v4iJuz5iw9HSseeBi/ygDNA7bhX6nmMVungd/2ukDbS42VwPL6J0lER9a8D
         E3gglrRT5VmrYZB665VJBADgZvdQlCg8nykVldgp221+43pM79t3mjYsmWWYJf9Appva
         uoQu70CnjPcRkzVd8eilL55XHANKqZI5Tbu0aHlHqployOCojoctZiL0fihF3grA5wsY
         sbplEqG7HwLTcF9wApV95qTGgz2Yumh3/nfzj5hlvmBBntj4oWlZrj1TMorTi4j6EG3Y
         kC4xo1fzxMjzixmKmvjUcwQh4j2kJU4ZnJOycdf3Q6eXuV1okd0UmY+PSLGAxrKJcjXD
         HGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/F3PfRp6fm/+yrBjx8MaUo30czopmE5vaVLUsa/Z0gBqmJNmDKs+ERwmMJ1m+7Uj6jO83fvWvUsM=@vger.kernel.org, AJvYcCXnKxNiOuSKxbwDa5MbgLbp4mOEf4SgM2ehRJG2l5QJW5aCRroIz/TV6Jn5DfjSUGWEdiVXwgbKBF9RKVqg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2t0Y7U2aC2kIllBoVLzB3cE0+Mlx3OZMOQHDACx9lzA+oNdb
	Q9JE34nhoy36hn2+2fDHrIEi+d8F8/VGAk/r3PByTPF9TL2moRAjeTKUpLrUIMOazyMuKYnZcCU
	BaoHrVZGWFNGr+r4/Pr39LtwrkbI=
X-Google-Smtp-Source: AGHT+IG/Z+Hs72+O/gyRmONrbBho9cUb4V4qH0/NznwgrLYtp4iajd44NTJKZnpJeDPH6jsJKglhDzDW+eKYnnNJlnA=
X-Received: by 2002:a17:907:7b89:b0:a9e:38ac:9fa0 with SMTP id
 a640c23a62f3a-a9eefeb302fmr155241366b.6.1731057835255; Fri, 08 Nov 2024
 01:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108085012.13147-1-victor.duicu@microchip.com>
In-Reply-To: <20241108085012.13147-1-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Nov 2024 11:23:18 +0200
Message-ID: <CAHp75Vd924pNBKkoWNse5Bjazrp9+HuqBJ5nj2tdk6vngaOiJg@mail.gmail.com>
Subject: Re: [PATCH v8] iio: adc: pac1921: Add ACPI support to Microchip pac1921
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 10:52=E2=80=AFAM <victor.duicu@microchip.com> wrote:
>
> From: Victor Duicu <victor.duicu@microchip.com>
>
> This patch implements ACPI support to Microchip pac1921.
> The driver can read shunt resistor value and label from ACPI table.

read the shunt
from the ACPI

...

>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/regmap.h>
>  #include <linux/units.h>
> +#include <linux/limits.h>

Please, keep them sorted.

...

> +#define PAC1921_DSM_UUID                        "f7bb9932-86ee-4516-a236=
-7a7a742e55cb"

Besides the need to include uuid.h and call guid_parse(), just put
this to the comment and use
GUID_INIT() instead. It will save a few CPU cycles each time we want
to read that information from the ACPI.

...

> +static inline bool pac1921_shunt_is_valid(u32 shunt_val)
> +{
> +       return shunt_val > 0 && shunt_val <=3D INT_MAX;
> +}

This basically is the (shunt_val - 1) & BIT(31) which can be used
inline in the caller. Hence, drop this function and use the check
inline. See also below.

...

> +       /* This check is to ensure rshunt_uohm is non-zero positive */

Please, describe better the range of the values, because currently
it's quite confusing, taking into account the unsigned type of the
variable.

> +       if (!pac1921_shunt_is_valid(rshunt_uohm))
>                 return -EINVAL;

...

> +       guid_parse(PAC1921_DSM_UUID, &guid);

No need after use of GUID_INIT().

--=20
With Best Regards,
Andy Shevchenko

