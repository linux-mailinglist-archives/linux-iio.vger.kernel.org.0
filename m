Return-Path: <linux-iio+bounces-9165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10396D1D0
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 10:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE151F2B357
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADCE1991D8;
	Thu,  5 Sep 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ki1ZTvxK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93B1991C9
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524161; cv=none; b=RqmYOJoMymtJYa7qSAHhgYZRGv9+iACKa9QwTZpmTN3npwPA/U2aX2qclXL1a/ijMpDBQvBz9EYszovfMAl2uUMYfoK0pHWquaMoH2ZxwTG+wEOoNWhdW7Ov18MsM2gafu4gqZsE1qre/Lz8TRtpzLq47nPuYxEXpjUT3Qr6LjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524161; c=relaxed/simple;
	bh=icEa2sW0vAQa973BQSvnfSg86nhC1mMPXtOnkbj4Kvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shq07nhwfsGrlT9+Hkw2TfYJn+ZqLDJF46bk6/jlJ05pHx6ZQDJLrQ83XI+ghS+oYgfwIgT3e81bFZ6J05RR/E3Mw8NhiijZioDPV+085Av9S1v5zD4AdAETZ4gM7fOvL+GNFDAwWuIXT6Y2HwMFYrAJAiH8lqtGZ1BUf17CnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ki1ZTvxK; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846bd770d9cso309421241.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725524156; x=1726128956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0rSmKjg6Zyu63XwLKpT0uVVvkdtwY/RJAX7lMT3kHE=;
        b=ki1ZTvxKRrHDThv+Qayzt4FxsgYe4eCp6kB1FCJEiNFJMt88/yxwRi+xSZ1NQNHZck
         RrDhkrTn/jVYDKVARD4rFhEObPzry5IpIIkKZf7HOu3KL4n2yxhP10zm6ja5Xohqsu3t
         qX+gRjgJN7cnhVLBGAf8de7YxtylnktLVCuCL2inxtUfgy1Dl+ZH1OtGvMiIYNY/D52Y
         SYuOQTUtSvGp0ciT0vxSjmRd1pDHG2SZ/INapLIL9BWesIXj81mfFhOjiyggaXunrqyS
         XglU3Os55yXGRfQ8cUDthjmhbjnQfWZHZCOe3oVHVqSiiQKp0vKlwybhUOQNN0TG9WPw
         BZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524156; x=1726128956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0rSmKjg6Zyu63XwLKpT0uVVvkdtwY/RJAX7lMT3kHE=;
        b=LafW5JV0fRCn0hYZLJXFzw92sIpwWgp3QbNOtutDdPEp2Q8XwpAvD9Bu57D0tJ9dYn
         wYXzMFVKnItTc0fdRCrD/dQw4cpjJ2UkUzc8VyxX22Gxwep7RAnvZwGPmCf7Wd4VSIfK
         ZPyn0UsVdWUZjefHUSW26xlBeT792ycuEPYlyNhtf34z0ARLJSJIuqfd/jlWw3OoLwrU
         +axIO5vMh4iwCIOBkYKx8clr1F9K+mDS6vMX2RSJAWTV0hvlHP0pDbWKCoX+FqlErKqM
         7L3dKBxijYLG729kyF0/uSQC+aNgg3cjLRJtFppCSCTeZLCq3+6a2KiUeBqOEcLgajGw
         LTVw==
X-Gm-Message-State: AOJu0YwpJo3leW0JSGBLwdDjYhqh9yaUosLUx8jsdNPUIbKUC5SXGLhS
	pnniKAYWQ8tSQRCXgEYWvEK8i/0p2JBI83qOOwV6l8/XMoB7WY7xRq4Wf8eijoXeF9NUi2hiXGY
	8XhYdALLlTWOe/0j7zzo9lGh5psHWErKVZRFwkw==
X-Google-Smtp-Source: AGHT+IFEH+lyNDFzGtkVSG1R/MllAqnAbnshuBp7OLXzYpkWk9kP5U+zafpVUGNBEIuYZPwN0AjC2CdInBVcFvp2Bi0=
X-Received: by 2002:a05:6102:c4c:b0:497:921:b799 with SMTP id
 ada2fe7eead31-49bba766182mr3164053137.11.1725524155939; Thu, 05 Sep 2024
 01:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904072718.1143440-1-aardelean@baylibre.com>
 <20240904072718.1143440-8-aardelean@baylibre.com> <tpl7wufkyog2bvnhg36keczeokadxkqkcoiy5qjscsoosxsiql@6a3ghbo4pc7f>
In-Reply-To: <tpl7wufkyog2bvnhg36keczeokadxkqkcoiy5qjscsoosxsiql@6a3ghbo4pc7f>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Thu, 5 Sep 2024 11:15:44 +0300
Message-ID: <CA+GgBR-oER6S3iqJR_T781fT-qxH2awPwdD7ubKxTZsC_RWn0g@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:39=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Sep 04, 2024 at 10:27:15AM +0300, Alexandru Ardelean wrote:
> > @@ -114,6 +124,45 @@ properties:
> >        assumed that the pins are hardwired to VDD.
> >      type: boolean
> >
> > +patternProperties:
> > +  "^channel@([1-8])$":
>
> Drop ()
>
> > +    type: object
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        description:
> > +          The channel number, as specified in the datasheet (from 1 to=
 8).
> > +        minimum: 1
> > +        maximum: 8
> > +
> > +      diff-channels:
> > +        description:
> > +          Each channel can be configured as a differential bipolar cha=
nnel.
> > +          The ADC uses the same positive and negative inputs for this.
> > +          This property must be specified as 'reg' (or the channel num=
ber) for
> > +          both positive and negative inputs (i.e. diff-channels =3D <r=
eg reg>).
> > +        items:
> > +          minimum: 1
> > +          maximum: 8
> > +
> > +      bipolar:
> > +        description:
> > +          Each channel can be configured as a unipolar or bipolar sing=
le-ended.
> > +          When this property is not specified, it's unipolar, so the A=
DC will
> > +          have only the positive input wired.
> > +          For this ADC the 'diff-channels' & 'bipolar' properties are =
mutually
> > +          exclusive.
> > +
> > +    oneOf:
> > +      - required:
> > +          - reg
> > +          - diff-channels
> > +      - required:
> > +          - reg
> > +          - bipolar
>
> rather:
>
> required:
>   - reg
>
> oneOf:
>  - required:
>      - diff-channels
>  - required:
>     - bipolar

Ack

>
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -170,6 +219,17 @@ allOf:
> >          adi,conversion-start-gpios:
> >            maxItems: 1
> >
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            enum:
> > +              - adi,ad7606c-16
> > +              - adi,ad7606c-18
> > +    then:
> > +      patternProperties:
> > +        "^channel@[1-8]+$": false
>
>
> You have two different patterns here and in top-level. Please keep one:
> ^channel@[1-8]$

Ah.
Good point.

>
>
> Best regards,
> Krzysztof
>

