Return-Path: <linux-iio+bounces-9258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF36970012
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 07:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73721C2229F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 05:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B34481AA;
	Sat,  7 Sep 2024 05:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kc1p0YEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846B4D8C6
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 05:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685331; cv=none; b=cJLrSdoKpL3JEwQsWUucGWlcVHXHyu8WoYgMj7gxGHcJtvTjk+FX/8CCxWRvGfE5SdpQOqOWRQFJ2hQyb7Zq8+ryLyrfSNi+rNJq1C182mKurnIwa8py15X0RePsPBtnjTl+0DjlK+153aTXpD9k8BqyOTV/gXCBRzYKgshX9Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685331; c=relaxed/simple;
	bh=D1aq/RQocG348OD7UVm0XytzAgvWjbKs0e4befvJOIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdqZxqtqInhY3WhXTeDTIa+a1/q/WE2wJdDHxMI0HuiP8PkoT6PG98QRsIcPTjRFLsj3k2xYZmxRCHzvKBhAumHsdYTs08pyVP+jfzBQNDOcri2jpl/FSHZj3O6ouikMxTdYdkkT3EsC6x+dWoJF6bgXm096mk9f9wi/mmT/ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kc1p0YEM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-846bc787b3dso746198241.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725685327; x=1726290127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQAqhIMKypqklZhoaptNP1nf1GTYRvwTcnfCJhLc3Jc=;
        b=kc1p0YEMKkjlGutYj2dcc89w5lYo0gE/1tJ5BQ7bw8DbFWw3GXXZj/YDhXI2+N9pGP
         0RR8gZcstDqPTvEMLbBK8RiozSFOhC/2cnNHNkPo+hBB5gGK6IwarnvBOBUDCgEZI6po
         KbSaqSwPJmj/A+ZUnxD+fYYEM+h1zjdHQ789q+xrdMelbH2WhDJvKo2uvblraxbhML9L
         FJabFAZewjloY0Pda9lLxgCZXRS/zr9anQ8FXrUY89dgNqpGlKANfrjwzTzVixFurBWf
         IZOeINixqiqYVVADA/76C+h2CKFTLBZZ3ja/wVvGaKL4QNRAhsIvTe8R27MysODWe6K7
         MghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685327; x=1726290127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQAqhIMKypqklZhoaptNP1nf1GTYRvwTcnfCJhLc3Jc=;
        b=fNQoKAsvOmtA1sFzWxXT4NEtNNibRQ38ryG5qUDxObmEKOccF5fJICsTT9m42luuof
         aLL/JeY5dEsdahm6+oOAFNZ/iSScIbfoxQqwnlJUV0iYoj2jZFKNHnycYxSD8+XrlVGN
         ozSrgbahVPnePpe9CpJ2Z9jFMlg8eyTVmnOUM5lvkQIu7/UQaKGWEWEHUphxfY/4orW2
         B2fXck3gAqWfRyYp2W3sjsEiF/yL/j52HQ4zr7zJc9WB54yzpeX1diOFuqIPpgUxvo5J
         8Ep9dgv3TI3YOCuqLcJBrdO4s4f+qcfOULKfjT9Cb9WNJe4PHAsFS3n24kCjTdlXr7KT
         Ek/g==
X-Gm-Message-State: AOJu0YyvEqDWXjlUKQbCwwWSYf+6fRGuZedjWWL4usNwhuLF+4O6uolT
	TdyD2Kd3uJmLoSFttq7YO3C8/geOw9ckSpr+oO6LHO1Sa2VYpRD46/h9A+aP91m2KucJRORgoDa
	/eIg8poFLcii0BfuP/vmunc1YRWPiSdwjZhOpRA==
X-Google-Smtp-Source: AGHT+IGYLP069UXYJAM+qennzi+blh9eqsxz/QeTRHI14ojthq+7+jDAogYcEQOImmmSjIIAahoo0p97CCF716qI7es=
X-Received: by 2002:a05:6122:a1e:b0:500:daf0:8909 with SMTP id
 71dfb90a1353d-502143d4260mr5220112e0c.13.1725685327108; Fri, 06 Sep 2024
 22:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-8-aardelean@baylibre.com> <0a7f796a-7762-4c25-85ba-27240a3cd59c@baylibre.com>
In-Reply-To: <0a7f796a-7762-4c25-85ba-27240a3cd59c@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Sat, 7 Sep 2024 08:01:55 +0300
Message-ID: <CA+GgBR9AMR8jvU+bTMA=PZWMo7NdZfZwAZBLHeYEd1H-RvcTWg@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: add docs for
 AD7606C-{16,18} parts
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 1:02=E2=80=AFAM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 9/5/24 3:24 AM, Alexandru Ardelean wrote:
> > The driver will support the AD7606C-16 and AD7606C-18.
> > This change adds the compatible strings for these devices.
> >
> > The AD7606C-16,18 channels also support these (individually configurabl=
e)
> > types of channels:
> >  - bipolar single-ended
> >  - unipolar single-ended
> >  - bipolar differential
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
>
> ...
>
> > @@ -170,6 +220,17 @@ allOf:
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
> > +        "^channel@[1-8]$": false
> > +
>
> Technically, we should also have "^channel@[1-8]$": false
> if adi,sw-mode is not set (not: required: [adi,sw-mode]).

Yes.
That's true.
Maybe I'll add another condition here for that.

