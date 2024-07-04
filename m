Return-Path: <linux-iio+bounces-7297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E35469271DD
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C7C1F2396E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495181A4F01;
	Thu,  4 Jul 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxVvV6GP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AF61891DE;
	Thu,  4 Jul 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082330; cv=none; b=XUrZI9cuEv6VkdLiubUOU2xSCJ8Sp+S3nnDU+2NJ8cfAlDvuVZs6f28iJe3tJGbGt8dvOiATa3djPYsa+5gdOjqSmUPwipLr6UflfXlo9v/w0gIcEhAKv8dNB6QsEyWPZlD+FmyaFEJZ+mBLtjjD800oGkFjBbLFp9sDkpd9i9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082330; c=relaxed/simple;
	bh=u7aRjPjfHUtsWIhXuK0woV/rPv/LQQHRWApUhoOwyJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arIHoYIHgsiwNpP4y/2DBwO5TI7+KfiqTprhU9ojhpZ4g9VpdF7GQrk/RTmNYaYhoYOutx5mKvqYjwcrkaoW4giUn3LJwxKrAG02q6mSfHKCQx4LPxIPLbZktJ2IfZg4JlqhPPBheyDNaj32j95klzx2PsGJyqzV16XrW2Z5TEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxVvV6GP; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-424ad991cbbso2600545e9.0;
        Thu, 04 Jul 2024 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720082326; x=1720687126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG4eZvU0MlJftauF4Foggzy1qvM1CPkGDM2HmV9sP/w=;
        b=PxVvV6GPqeekYfqmMppgBWhxJWw1egpEEUVs1QuhZ+GxjxPv5kTUxRQRSkdb2PI7tb
         zLbkH+70jLkx48DCenpbryEcdlLZk5nBvG7h3lYSpEBFQltAjWP5AeDQMpFyvX9DK209
         ZhxJfp2T0f5INLTTA0mv9RVFNsu5s8Rmbz78tJ4ymRuhEG7H69LM7F4egitSQVBuvjdb
         lWCPASB7QgMw0twTS3DvPSzt5t6gnQZKWabbexIwMkVJ5hgY5AzvDFHKBYGp12NLVibf
         fbsJRZVyZRwZfh3f5NI4yPhil+U/ykEg5rCpndx3tKwKiolMEV6smKu1Hh7DsGXIzM6M
         UWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720082326; x=1720687126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QG4eZvU0MlJftauF4Foggzy1qvM1CPkGDM2HmV9sP/w=;
        b=gILEKgoRq//Yyzi08MGiKP78U4+meZmd/C3ISxc5puCEUYw/FKC5wLotZFsgKwQxTK
         cJrjrcKSCf8KpZRQjfMfPZwNmL1c/W1J14HIZTzDC+O36ieMXPQFQMxa2qnq0ofuRi4Z
         2f2B8mb4Q+apVP4xVn0Gb7NXQiXLohqMmgUKQmUvQz5FHTQl79UiDgkLMiyP8KmE2J5M
         gq26ygFvhEpxfuxOPLAWuSx8+5PR/6Emo7Ar31oCTaH/z6zXUMDSdN1sj7GCTd6ujgE0
         MpXHP5bsQnLNXkyshS5T0QLcbhhm/RFBE4BLmWBv+Bo/AThrtCbEtLNbmymbOPNywWz0
         fFfA==
X-Forwarded-Encrypted: i=1; AJvYcCXn53UMvR4UgPDT02+lL9Y9GQI5Ygg9ayYcU2dYYizUqh9vZV5rZ6xFMLPwplmFh8GXUZTkiMTpFON2Z32AlDcP7hzLa7WItAhhFFQy8Bjq8CdVr/8NlqzfHg3zd083tlsCqPKwlEc/2tqaoZg2RYhxANE84tnJ7v5DiujWBTUzjvYvoA==
X-Gm-Message-State: AOJu0YxO1gglps4vLnKwOK3zZcF4aRXzjgZcxUFdEHnG5IoB0mPbK7ZA
	aBbTMe/ip1KGREx8R8AN+WrV6zZpXkpTQvHaiRDit6Yr9FvfZeL5vn4yAN4ezQ1pKc9/vBoVXEN
	0jGcJqAmOZRmrY7HHIi2G3JDe2yI=
X-Google-Smtp-Source: AGHT+IGh+G0Wo9NUvnBFBdxqTfvyXFzMLOSpfkbscMrfYPWLvaNorcg31cDT6xysRPm6qfKMLnEknDpz7gl2DA5h3ls=
X-Received: by 2002:a5d:6182:0:b0:367:9409:f7f7 with SMTP id
 ffacd0b85a97d-3679dd34158mr702967f8f.31.1720082326425; Thu, 04 Jul 2024
 01:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com> <171993784259.3739500.10383587148467749192.robh@kernel.org>
In-Reply-To: <171993784259.3739500.10383587148467749192.robh@kernel.org>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Thu, 4 Jul 2024 10:38:35 +0200
Message-ID: <CADFWO8Enf1yqACpjqZBoQpROK7Pjyf2upfm0FnsAABX5K46Asg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:30=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Tue, 02 Jul 2024 16:59:08 +0200, Petar Stoykov wrote:
> > Sensirion SDP500 is a digital differential pressure sensor. It provides
> > a digital I2C output. Add devicetree bindings requiring the compatible
> > string and I2C slave address (reg).
> >
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> > ---
> >  .../bindings/iio/pressure/sensirion,sdp500.yaml    | 41 ++++++++++++++=
++++++++
> >  1 file changed, 41 insertions(+)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i=
io/pressure/sensirion,sdp500.yaml: $id: Cannot determine base path from $id=
, relative path/filename doesn't match actual path or filename
>          $id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml
>         file: /builds/robherring/dt-review-ci/linux/Documentation/devicet=
ree/bindings/iio/pressure/sensirion,sdp500.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i=
io/pressure/sensirion,sdp500.example.dtb: pressure@40: 'vdd-supply' does no=
t match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/iio/pressure/sdp50=
0.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202407=
02-mainline_sdp500-v3-1-0902047b3eee@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade

I did not know about this tool before. And I did need to update a bunch of
dependencies to make it work. Thanks!

>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

The setting of DT_SCHEMA_FILES was a huge help in saving time!!

