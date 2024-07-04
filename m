Return-Path: <linux-iio+bounces-7296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB78F9271D9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF9C1F2428B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905561A4F03;
	Thu,  4 Jul 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKBaP8ke"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434D1A38D3;
	Thu,  4 Jul 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082159; cv=none; b=gRaUY9WDttiBdJqepsGp65RLAqC2ho3yhtZbA+aSzjFY4k3lFmBoNW+IqjBFaoY6s4oM05h1EXNARK+6ToXwdhmauX/FGEcwDPbS3Qy+qwbMi7OLy0VuwREYBHU5qdmhYgu2F8kHAPfDqdLvHrW1wKNNXN4lKswO7yWWeqb3ofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082159; c=relaxed/simple;
	bh=N0s2Ffug3KsUyVOVpMTjNnqEONA+e7nedDtd7zfjrR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXYZHi1yvkWAJODb9893yZwUmQWQxsELk6JQUaous6oJ+vj+dJElenFVXXrYZeeusPgA8Ohak4tZd+siD5SblbHsk1qejwsHOznPFgjqysBsCEDlBHg9BA5wfZ0Udh6kU7JI4OvjuB3FD+T4HfkXmEPUNnOc+6kRTtLCGzh0z/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKBaP8ke; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-36798ea618bso237367f8f.0;
        Thu, 04 Jul 2024 01:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720082156; x=1720686956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNloepPD+p+4CEPZuvu00Mga81trYIFIo58BevYKhzA=;
        b=aKBaP8keO46u4FPTNRYv5Muym5/6Q+D2GsRxzAA8CfLW5MPhXKLXN/W0kGOzvzmY/D
         HgrVyWUJ/dC9vXGWqY5VapHUA4x7GQmf4MGqHSPwUDyt/kly9RtGf26H80GwncPItRZG
         UR2kvnd1l/K/6x9RXFdmO3PU9J0d9aVzGqMeLt/A0mbyKQ898B3vvvBnMYBxDsLqHEzK
         SM8n0fh3eUqwrX3sF+5RrMe31Nh1yNieWjZAI2EHWnc7/PE4U6LN64grMiLbujdnzRdp
         oFlUmY45vn5N8kCACy9VpOFooWcFDZDFM63f55UfAj130K0wv5hGmCf8DvycAyAMGql1
         Lpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720082156; x=1720686956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNloepPD+p+4CEPZuvu00Mga81trYIFIo58BevYKhzA=;
        b=VmlUyqPfQzTqGziJrlOzUEeICPw01AsvTiMDQC6OOu95ip4I1s8RFB8RzauhIkPX2c
         sw1JlZBzntSBN56BV2YcfI2ooqEztYGbEQyqfCs/y2bML3cclycJ30RQDv4Mr3Uvo4zJ
         CESN20KgQVpy10kHkwkCGbNcYah9z1jtP4Mk6N3X3n7i9kma3cWk6/oy+UhK0qI2Uw1e
         3i8dnxSURY0gdVLy+aVzOYNfMeX8/qnoqsK86Kursu0y0N+6HnJE05G6T8T3l+tqVohe
         sj/6EGiLnQ+3XcPF5rA/UFV/5CT7Imf7jAvlI3QtPwnaaVnMc49fTd50jzeK24NH0c7O
         n4ww==
X-Forwarded-Encrypted: i=1; AJvYcCV1Z+P+a43KwM1fxLizz84h2gbDYLgTbt0n7gjRlUwd6bDTaX3zl9vmSoi+UwyX0HY9REyOfs2HL0Uf4u7fvOakwsFszJrXFfwBXbr7Wt1YvqO8X7+EaXP16rd+ENkwCuYsezzNPS2VWKQBF4dx2EHzFQCXojmPOeZRtorpFCh73vtxsA==
X-Gm-Message-State: AOJu0Yy4C2JXJfCSkU/FMuhl1pJZPnx2rEfdJq5n+YrfRI9Y6YjabMRV
	MBn9+e1hKH7kXsVLQmID7v/MTwhVbFAktFUN9uZOND+r2mJCkSUqXG7ebey4KCMz/aXl8/3TaXJ
	zStOAztXaRv+OGRiOmiN0wh48CzzZ0FUj
X-Google-Smtp-Source: AGHT+IF67g0qhulUK26sPlB0Pl6olhKlrI+0ER/88ksT3Bu87q4eZq8pP3Kv8zJbdZlqLFc6e9TjmMiir5hZRfVA74Q=
X-Received: by 2002:a5d:630a:0:b0:35f:28e1:5028 with SMTP id
 ffacd0b85a97d-3679dd23947mr656706f8f.15.1720082155950; Thu, 04 Jul 2024
 01:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com> <20240702211822.3bce44c2@jic23-huawei>
In-Reply-To: <20240702211822.3bce44c2@jic23-huawei>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Thu, 4 Jul 2024 10:35:45 +0200
Message-ID: <CADFWO8EBP7zFH9zBpHNaF0tfK5OAzOdc=OuVJ6c768FE97x9xg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
To: Jonathan Cameron <jic23@kernel.org>
Cc: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>, linux-iio@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 10:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 02 Jul 2024 16:59:08 +0200
> Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> wro=
te:
>
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> >
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
> > diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,s=
dp500.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp50=
0.yaml
> > new file mode 100644
> > index 000000000000..6b3e54def367
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.y=
aml
> > @@ -0,0 +1,41 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
>
> Naming mismatch (as already reporteD).

Same mistake as in the MAINTAINERS file. Sigh.

>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: sdp500/sdp510 pressure sensor with I2C bus interface
> > +
> > +maintainers:
> > +  - Petar Stoykov <petar.stoykov@prodrive-technologies.com>
> > +
> > +description: |
> > +  Pressure sensor from Sensirion with I2C bus interface.
> > +  There is no software difference between sdp500 and sdp510.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sensirion,sdp500
> > +      - sensirion,sdp510
>
> Include the vdd-supply both as a property and in requried.
>
>   vdd-supply: true;
>
> is enough for the property.

Thank you for the example!
But I don't think it's a required property.
Our system is an example where it's not needed.
The device is always powered on and Linux has no control over it's supply.
One can argue that it's nice to write down what is that power supply but
to me it's just noise, because I can write anything there and it would stil=
l
work. So I prefer to not add anything instead of putting a value I can't tr=
ust.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      pressure@40 {
> > +        compatible =3D "sensirion,sdp500";
> > +        reg =3D <0x40>;
> > +        vdd-supply =3D <&foo>;
> > +      };
> > +    };
> >
>

