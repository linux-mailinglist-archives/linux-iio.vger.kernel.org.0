Return-Path: <linux-iio+bounces-20117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B76ACA052
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0FF3B4114
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC9812F399;
	Sun,  1 Jun 2025 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEPfzgdv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D65383;
	Sun,  1 Jun 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748807169; cv=none; b=B1Tf3WAV1py39dARieHU6dvGO5vo0HEkLdVjsYlXqq7OUHektFeZx1KKR07T0nGqohsP8GHFT7kthUb1STTi5SW5ggXXXHnFdquch5IOExMG63FPgf4lVMea7dRUaq1m8trHNt4Yx/Hi1/Kmbc8XAPInRoUi7OFXMD496fJMXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748807169; c=relaxed/simple;
	bh=yA9Q212Lf05WBc2PH4G49tMKxCEGyBSZ9pEkU+MwG90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAGh1/LgGLsisNTTEXY3Os3WS3EwCffMnAodjs2jl6QKOPgxJDXXXPBjlriUbW2x2cop2cSNiqVB976nu3VzXByC+/+xuVEx+vsSxLvVlz5ce2789piqVi1oQGHPA7qhk66Yba4gpehCFrSggIaerzRsdfLmkkVAQnYL7Pth/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEPfzgdv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad572ba1347so555722066b.1;
        Sun, 01 Jun 2025 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748807166; x=1749411966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkRn9YZ0Rm8OZGEegaym0YxIYoFsgbWeEIqOP9jK7OE=;
        b=FEPfzgdvn15QIaFck+WCOpexfVmfqwZtIFMWe/GgOtPQRIB2wUu/bFOuW7tlHDW8Xm
         DT2mXVxG7fWX2X2xA+5PsjhvSjjFLYXF/0Fp7D65NtfZkTzgbESXlY2jihfidUs3A4Oa
         S//4oNKD/GyW3sZX+/zdsnSzjNGVlSiBr7q9uqniUaL0hza+re3nwGsH411tgMbBcGWP
         bxbbpHKqm8RfU45jSn8J0Bx0yAzInLuTFWE/onhHMya4SayZmlc4azG4NtDHjRNPQERj
         KE6QVN6pbqIA/FLAeW7s/xIAhxZAu33tddyIsVdGg8fpL2QAItf9DaKjcaDEt8M0prdA
         jH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748807166; x=1749411966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkRn9YZ0Rm8OZGEegaym0YxIYoFsgbWeEIqOP9jK7OE=;
        b=f5mmdTuQ4pdZ00N4QrbkqOA556X+EjsjKXS3SSHKC3mCWe+jqPgGP2qTnHlPaxpI3V
         Hl8PxWHJN07itCpApPmR3UU8LiqZB/4ZHPX45rF3gznMEafdvPWNAIeTOsXIBqb7ZGKW
         vFcWBkN/B9baoseGoS2oTos/JAFRymtKne2wh0iTFxNcje75x+RgUi+olWEfYC5eB0nB
         d5vlaF0RVR95B3TIdiirzulatTHl4thg305lBY7UAkWBy6/gnQsy4j9TOUk1LQJQiHCO
         wcQOo3fqBWVmMkL7CQjFa4eRiw4OEvYC8FX1ji/0i4eXTqDKpa3IdTgfvzuIs03PKO5J
         eH8g==
X-Forwarded-Encrypted: i=1; AJvYcCVYaiAJA0xwfnhFEVrSWGdP0RUYA7Y7/KYdzR2M8o1k9CBPwDlbfOQmxYv3X/ST2UNY48L5H+prfI8=@vger.kernel.org, AJvYcCW8sp3Tkp0CW79iolo96YMEgLn5954qF9rt6IhewZEXkHU/g3KA5lLCg7oneKeb1Qn40tGD8Owlq4ZT@vger.kernel.org, AJvYcCX2A4l5cD/LjaBzTbvGVKK/h2cakGmvJi99vspWbfvPeTBGW8LsCrN5D/tQU7535Mre6knjvmIE4N3xtrXM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25QiyZaa66mtt5Z127I1MpoVV/94j8neOFBuxD2isjY4J8sYZ
	xIvIqqHV+OTZi+DROk3sTitNPLpYxcJEwydNFmpMCg9QxGsiRMJsIbFhHrZDwXouBc47SwMYuWE
	9VKUeG/sA1LgV/uyO3poRZzVAMAGw/Fs=
X-Gm-Gg: ASbGncvpHZ4VgO/u/+5jDF6PkkrSO3cR8Y13RqrUCqgMRcBgZCJGY83h+IsRAziUQxv
	fLPC8gVaRp9k+V3cXmThXXxyk7BEWBFtOu99HCw4wwjlPftTONfDGH3JUdqEphUfhWaLpaEyn2U
	VSOUc1FdhZVOupgwfur9/5HMCctVuyhxuI
X-Google-Smtp-Source: AGHT+IGx7OWgE1wYNxbtfmiIWIk2xFK/qPfS/f0C8s3grU1lDP21eeKQSHvw8AslmPTVvJGMsRzso2JOjfFF8D0K/DU=
X-Received: by 2002:a17:907:2cc3:b0:adb:449c:7621 with SMTP id
 a640c23a62f3a-adb494bd297mr593554166b.29.1748807166361; Sun, 01 Jun 2025
 12:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-9-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-9-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:45:29 +0300
X-Gm-Features: AX0GCFtrQnvSTrb8q81asRvJW99c-SqRvuCmLXgOGMcJoj3XT2THj_0aho1nY24
Message-ID: <CAHp75Vd=mzfVN_UBUHAkTyj2Ap_tz76AB0LtKEz28pR=WmNzog@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] iio: accel: adxl313: add inactivity sensing
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:22=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> Extend the interrupt handler to process interrupts as inactivity events.
> Add functions to set threshold and period registers for inactivity. Add
> functions to enable / disable inactivity. Extend the fake iio channel to

IIO

> deal with inactivity events on x, y and z combined with AND.

...

> +static int adxl313_set_inact_time_s(struct adxl313_data *data,
> +                                   unsigned int val_s)
> +{
> +       unsigned int max_boundary =3D 255;

This is unclear how it's defined. What is the limit behind? Size of a
bit field? Decimal value from the datasheet?

The forms of (BIT(8) - 1) or GENMASK(7, 0) may be better depending on
the answers to the above questions.

> +       unsigned int val =3D min(val_s, max_boundary);
> +
> +       return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
> +}

...

> -       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +       if (type =3D=3D ADXL313_ACTIVITY)
> +               axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +       else
> +               axis_en =3D FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);

Even with this change my previous comment stays.

...

> +       en =3D cmd_en && threshold;
> +       if (type =3D=3D ADXL313_INACTIVITY) {
> +               ret =3D regmap_read(data->regmap, ADXL313_REG_TIME_INACT,=
 &inact_time_s);
> +               if (ret)
> +                       return ret;
> +
> +               en =3D en && inact_time_s;
> +       }

...

> -       if (info !=3D IIO_EV_INFO_VALUE)
> -               return -EINVAL;
> -
> -       /* Scale factor 15.625 mg/LSB */
> -       regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> -       switch (dir) {
> -       case IIO_EV_DIR_RISING:
> -               ret =3D regmap_write(data->regmap,
> -                                  adxl313_act_thresh_reg[ADXL313_ACTIVIT=
Y],
> -                                  regval);

Hmm... This was added by the previous patches, right? Why can't it be
done as a switch case to begin with? I remember one of the previous
versions had some nested switch-cases, perhaps you need to rethink on
how to split the code between functions to avoid too much nesting (add
some helper functions?).

> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               /* Scale factor 15.625 mg/LSB */
> +               regval =3D DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> +               switch (dir) {
> +               case IIO_EV_DIR_RISING:
> +                       ret =3D regmap_write(data->regmap,
> +                                          adxl313_act_thresh_reg[ADXL313=
_ACTIVITY],
> +                                          regval);
> +                       if (ret)
> +                               return ret;
> +                       return adxl313_set_measure_en(data, true);
> +               case IIO_EV_DIR_FALLING:
> +                       ret =3D regmap_write(data->regmap,
> +                                          adxl313_act_thresh_reg[ADXL313=
_INACTIVITY],
> +                                          regval);
> +                       if (ret)
> +                               return ret;
> +                       return adxl313_set_measure_en(data, true);
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_EV_INFO_PERIOD:
> +               ret =3D adxl313_set_inact_time_s(data, val);
>                 if (ret)
>                         return ret;
>                 return adxl313_set_measure_en(data, true);

--=20
With Best Regards,
Andy Shevchenko

