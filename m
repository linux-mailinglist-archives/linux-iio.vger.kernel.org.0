Return-Path: <linux-iio+bounces-24937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA3BCF3B6
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 12:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF14015DE
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E8725C816;
	Sat, 11 Oct 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiMyerF+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86204254848
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760179113; cv=none; b=TLoffD0AN5JG/kq6iZvsfMgrx3pTQ+kwtZuUZR5C3t0YHSRE4xuZsWQyVKKyEOpsrIcxn4kHbf8V7GEcDRJSrXRxdByTdNKN3SeIM9vQrShrx5HlOQLx7U2WecPjJYXx1PbBScwORvvxqj2uEMo9xiZyfkmqDf1UrwWjLJNdKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760179113; c=relaxed/simple;
	bh=ZM6gK8/ptNL07x+/PAG3f+iZfMJySGfBm2OlXDFCx6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdlQBIDdCfqk20TBjkVm2T5r4pBpA9punRNe+vFIWKcbBl6/CSk51pfXljWs3JN4kBrB81b5GhagJiUJQVxN3l2ldVhzMmd7CPjgmlezQ423Xb6HOfHaRalGjlPhrBSC8/7r7LKCIn2CZ1Vx0dsL9JoIuEp3i2GgMr+q8J3/4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiMyerF+; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so474184066b.3
        for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760179104; x=1760783904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xny2m3uhM/SxXH2HjS7Fl5XTjSKvXRs2Du0+aNtpjtY=;
        b=YiMyerF+Ci5i4X30bpQRx6Ef7bP9jro3kTE1spZMla6EroksOqX2stYaQKh95Dj1pH
         TPkEvDNiCP9uJoMxsDStJuCa3KDg29cogpL80yYZtBwRQ3cpxnKpfJgwQQ0kDuWLjoxn
         NcRCxSSGodwQpoyKu1Zopi/gtpHSouaUUAfTbE8AhRwMjAMzRx6NROWU1zY0/7kLjXJk
         TxB4Bw4dawK6lO5XVzDAEBbCP6hjt0XNv7znZxDic94Jg5eMWOHq/eF6j9JCj8JTpbJk
         iAcAog+GhRzpn08Nv0MaLXvDP614G256LtpWWKHP67hWGk2mf9ML/iCrRhsEJ0W1h8er
         daGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760179104; x=1760783904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xny2m3uhM/SxXH2HjS7Fl5XTjSKvXRs2Du0+aNtpjtY=;
        b=Z2YQSIRRaEJ8mOlvaU2305kn1Zv9I4ar9s9wtOxOfgSTGGVQHsIOAuDxZpd/LfRFrC
         m6hZKfLdq0KmP0T2ax8+Rbl6AtI6/CjmoM4MYP6P9w7ibLlQFgqoBGqiSOb9ezydDFuK
         mzv7ohDXfjnGnbb4G7yucCIDGHegZE4zppxkuH/We2WwLcK3rJj/zahMve1B8Kozxk/q
         OeqNOXAwEGEp9akgiVHvB6DvTKmcmFYCIQ/L3DD4OrMBDPyi0UPjWfyRCiC+4uR66gO5
         Abpcpy7CNJfut8UO5A+c7/vEovNgZlBr2G38XtQkatomie2wvcvCaXRqabc1b1hXLcWg
         JuMA==
X-Forwarded-Encrypted: i=1; AJvYcCX6p8wVSAniHN97Z0ASpU3oBlvARjqJQU11kMo7zxnaYzPRkMoTzGRM7aolFF08JvmJ2CLu/0fzthk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBi2lYstYAkXbMVj2tLfP5B51/PRFwFOpNhhU8rOWcbErr3etV
	2oXFLMEcRoxK1sddLq3VIR8u6c9RWgQwI6LtSiC3EmJuWKkhsc+q2VYvAUOA1eGWIyqrjDfqhsg
	urUXALSMYzLtO/qPjvv/r7oF5Z6cu0Cw=
X-Gm-Gg: ASbGncsEPKWpqAtDz2lO+FYG0E5sYguJSA88lYWDPQkh6Bxgg3WiqQVJNWkK+pjuySt
	tVWSGX5cdiAxsbw8Pu/IVTmpLUR9XvT1H/1C043wLw4KIdveH9LovLo13XLZD5TB/ynxAwOx2XP
	dO9p988mLlE4Enx8IahHevv05Vj6Wc45HtcskDT9MndA8PxyaL4H1szRmTOmY2Yx26pUW34v7NH
	eusTOMXdNDoeVKG8CVpRznU6A==
X-Google-Smtp-Source: AGHT+IE7l5xvIFgT9i4m7mh7Oy/v5NjT9bqTFYELpGCEXyYpZaEcHvHT3oTtVXEc7bXN+PyntmQrK0WQUm7ynfY+S08=
X-Received: by 2002:a17:907:3e13:b0:b40:a71b:152e with SMTP id
 a640c23a62f3a-b50ac1cc39emr1445899966b.40.1760179103638; Sat, 11 Oct 2025
 03:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com> <175992812188.3371104.5716471946724146308.robh@kernel.org>
In-Reply-To: <175992812188.3371104.5716471946724146308.robh@kernel.org>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sat, 11 Oct 2025 16:08:12 +0530
X-Gm-Features: AS18NWAnttKcW-sKW8_JBGa9qUMRxmLzTjvvzFAZDNvf13qm3vN4yW9SF_3ub_k
Message-ID: <CAHc1_P6xDS1kec8mScCGHfPiVYbBBK8Hr8rgve5xSsLk=2Keyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: nuno.sa@analog.com, dlechner@baylibre.com, linux-kernel@vger.kernel.org, 
	andy@kernel.org, linux-iio@vger.kernel.org, matt@ranostay.sg, 
	linux-kernel-mentees@lists.linux.dev, krzk+dt@kernel.org, 
	devicetree@vger.kernel.org, skhan@linuxfoundation.org, jic23@kernel.org, 
	conor+dt@kernel.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i=
io/health/maxim,max30100.yaml: properties:maxim,pulse-width-us: 'enum' shou=
ld not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclu=
siveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
>         hint: Scalar and array keywords cannot be mixed
>         from schema $id: http://devicetree.org/meta-schemas/keywords.yaml=
#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i=
io/health/maxim,max30100.yaml: properties:maxim,pulse-width-us: 'anyOf' con=
ditional failed, one must be fixed:
>         'enum' is not one of ['maxItems', 'description', 'deprecated']
>                 hint: Only "maxItems" is required for a single entry if t=
here are no constraints defined for the values.
>         Additional properties are not allowed ('enum' was unexpected)
>                 hint: Arrays must be described with a combination of minI=
tems/maxItems/items
>         'maxItems' is not one of ['description', 'deprecated', 'const', '=
enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
>         1 is less than the minimum of 2
>                 hint: Arrays must be described with a combination of minI=
tems/maxItems/items
>         hint: cell array properties must define how many entries and what=
 the entries are when there is more than one entry.
>         from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202510=
08031737.7321-2-raskar.shree97@gmail.com
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
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>
Hi Rob,
Thank you for reviewing my patch and pointing out the dt-binding schema iss=
ues.
I=E2=80=99ve updated the YAML to fix the reported warnings. I=E2=80=99ll ve=
rify with
yamllint and dtschema
to confirm there are no remaining errors and submit a corrected v3
patch shortly.

Thanks for your guidance.

Regards,
Shrikant

