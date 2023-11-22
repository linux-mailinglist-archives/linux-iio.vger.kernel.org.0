Return-Path: <linux-iio+bounces-266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E97F4640
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 13:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B60B20DEE
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC44D129;
	Wed, 22 Nov 2023 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="Va8Eg1CM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4141A4
	for <linux-iio@vger.kernel.org>; Wed, 22 Nov 2023 04:29:02 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b8382b8f5aso881736b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Nov 2023 04:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700656142; x=1701260942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NMtf5TNC4hWWw549jqhQu4xI8dAUFYNGtWt0AUtBAo=;
        b=Va8Eg1CMUMgl9VcyHVf/u07WW3Wg5MlUSVd1r6f1Gwbli7OjTw5SW8eYJZAeD1BJNh
         gOG+aBBR1nOdjJ4ngu52CgyLsgtxBSSyMJF3dr4gGDfgRRaD5GxVy9f+pdwShT/rrYcz
         1lbgDigVEKu7N3RHA99kES49F7wa3NlkKoqk70OS8Tny8o816QntvI+jyYJE+p9WLV1b
         La0iALB2Hnfy8gEEJOV3Q/lR1yPvI0cw748UDB2LXevKNYuGt6ElMOfQIDpWGVKAFIMY
         p2+2v9Lo2so6j4c/T+tquQLEg2ZwiXfobhonVNeJveoXKZ/Z9jcZa/TN5SXYwOBynxys
         9j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656142; x=1701260942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NMtf5TNC4hWWw549jqhQu4xI8dAUFYNGtWt0AUtBAo=;
        b=SdfyuMI+0Zj3PMbIpjEuo3hOAzS2Oci+/eyvkxXQeo7y8AgO4IcMePVchsP4ArAtb+
         uKuFiT+bpOPQE8k05Xvs6sIK/8izZX6pMJNCO+kVsn5PIWD+/xIIQwwcZ5FOj59FVBBn
         E9F6QBvAx2vHOoYNPAzDtDUHGTyB/Z7syQZRe7f4JfSpwKp/twic8G1dR4vg5nl7TYTi
         kVSK55AbOeJN4Roamu6ex54jjS7VpYhbHV175knMef1gEyxEuaGn9BY9blY1omZALMbi
         Mp2v2iqN8PGdaNe/tVHfRz9je1fYwDdU4DNJKQEpe3KlgQvvTAfF/LsQaMp23nMJBsi4
         5wog==
X-Gm-Message-State: AOJu0YydV2oc/COEBtAws9JoyfEC8fTP4160pZeF9oAICjiAIE+KYJ8v
	1Q59bOiZfj+Mk1qBNVAnxp7BF20Jjsh8qX3pNkBYeA==
X-Google-Smtp-Source: AGHT+IE4RhkDbuclMq9ltVuFBkZXZA8BM882FOXeUnb6DCxbwIotur+3+O8VDD4iyzzyKVOmUB7dBUVGZkG6Y+BhQW4=
X-Received: by 2002:a05:6870:c98f:b0:1e1:e36a:fb74 with SMTP id
 hi15-20020a056870c98f00b001e1e36afb74mr2997080oab.26.1700656141830; Wed, 22
 Nov 2023 04:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700648164.git.cmo@melexis.com> <2e8b4a7d3ef4bc1c53bd0a849e4c31eaf2477f6b.1700648165.git.cmo@melexis.com>
 <99d1808a-da04-4bc1-a1f7-cbd269adbbf0@kernel.org>
In-Reply-To: <99d1808a-da04-4bc1-a1f7-cbd269adbbf0@kernel.org>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 22 Nov 2023 13:28:25 +0100
Message-ID: <CAKv63uv87srZ3gJxFASuGWV6cULXkN=gYi_L=BCcd3dgOFQEfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: add MLX90635 device bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 12:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 22/11/2023 11:27, Crt Mori wrote:
> > Add device tree bindings for MLX90635 Infra Red contactless temperature
> > sensor.
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>

OK, will put everyone in that list in next spin.

> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
>

 Ok, will fix that in next version (probably main driver review will
get some comments).

> >
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> > ---
> >  .../iio/temperature/melexis,mlx90635.yaml     | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
> > new file mode 100644
> > index 000000000000..96463121a806
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90635.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Melexis MLX90635 contactless Infra Red temperature sensor
> > +
> > +maintainers:
> > +  - Crt Mori <cmo@melexis.com>
> > +
> > +description: |
> > +  https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90635
> > +
> > +  There are various applications for the Infra Red contactless temperature
> > +  sensor and MLX90635 is most suitable for consumer applications where
> > +  measured object temperature is in range between -20 to 100 degrees
> > +  Celsius with relative error of measurement 2 degree Celsius in
> > +  object temperature range for industrial applications, while just 0.2
> > +  degree Celsius for human body measurement applications. Since it can
> > +  operate and measure ambient temperature in range of -20 to 85 degrees
> > +  Celsius it is suitable also for outdoor use.
> > +
> > +  Be aware that electronics surrounding the sensor can increase ambient
> > +  temperature. MLX90635 can be calibrated to reduce the housing effect via
> > +  already existing EEPROM parameters.
> > +
> > +  Since measured object emissivity effects Infra Red energy emitted,
> > +  emissivity should be set before requesting the object temperature.
> > +
> > +properties:
> > +  compatible:
> > +    const: melexis,mlx90635
>
> It's the same as mlx90632. Add it there (as enum).
>

Properties are the same, but then you can't have much differences for
a temperature sensor. It has a bit worse relative measurement error
outside of the human body range and overall different DSP, register
map, even physical size - it's 1.8x1.8 mm compared to 90632 3x3 mm. I
was not sure how it qualifies for adding it as another enum, but I
went with the feeling that if it can reuse the driver, then it is an
enum, otherwise it is a new file. And I could not reuse anything from
90632.

Thanks for quick feedback and best regards,
Crt
> Best regards,
> Krzysztof
>

