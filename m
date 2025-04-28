Return-Path: <linux-iio+bounces-18756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA1A9E8A2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3875F175095
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 06:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72BF1D5173;
	Mon, 28 Apr 2025 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMZyaN9F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FF757F3;
	Mon, 28 Apr 2025 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823384; cv=none; b=ZuFysKK1rXIXlzXa4P4O5tvmvMyPpx/4cZTWedImoIYj3H6TZ1KdfPAfmVO0VRu6sYLMOdBfQnkKoTFV6PGkpmKEeSiagHwhW6rJFKu3EOAy1QiH0Eq2gtQlwLh0K12Rukp0O/MLt0CDD5pHztjIQrJ87Xg8wnGP3MPjNadLDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823384; c=relaxed/simple;
	bh=+acStz/Dse4jpv4MBbLpD5tJGTHSXq7vbjuO+00Xyao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgAZhwHcs4xP1Qf3jqUzgNHrkN5XZ3UME8RYwv/t8UFBeJjqbQ6/Pt1LMh7F1W7VFvO2bWqBY99exq88QMdwXWsm59/uF4JizK8lR802Se/0DksP1OHf0j7UWm+OoHuemuSrImQcrLwbBNqr9ie8f3p45fC7Wr+a+vxBUGpLAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMZyaN9F; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so534760266b.1;
        Sun, 27 Apr 2025 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823381; x=1746428181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMAxDXlv1aopPBGRhq36xfaXhilkSkGB8/oDJ5bRsUs=;
        b=gMZyaN9FBEiJ+BgHzaxJ1UFYD2mJy8cKJyGM/QHjYWQtSekbDuE6fObEue2b+jCNp0
         jBhCgArAIp6sgAFLdFVDqp5ZceqfX9hqVDjjmdy3NOLLfnHMj/g7MU7YPmaNY0bQgqVs
         d5spWHPx1TmQhZcMgOmlWBvPzKk/J7LPLYaB8cADIcpxrc0TRbwc32q4Ew4YiG13p/Fg
         S5HDDskaMYoJT2hLtE2HXl8kA5N9+8rajCoPamcJi//p/QDlnBD/EKYXWbOhQ9Vw16Qh
         G5Dpz3pyL5gswndkWSWlUOzW1BVAXe9wq6oOSxX6lf0imOLURPKCL3xJiIzR0kPtq8Or
         bRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823381; x=1746428181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMAxDXlv1aopPBGRhq36xfaXhilkSkGB8/oDJ5bRsUs=;
        b=tQSGMgZAFGdi/iUpiZ9kiZ/a2sWbj/D7PmU9zea5lZDC2RV94qd5/Ul0u9NUcWYAEb
         Dz8uLRWbND1UUQTe2rBjINGWyGvUxNMT8rcCNmMKxofhf64TCFZe/SffBbPnPeofRdy5
         Sm7pRW8G1riDX+qmKoXbX5An2cnMY6DEk0z2pPUSG01qVlW3Sv57VsWlluov8Sx32FIN
         PA9jB4yc73wu7swr19YRURqBszF9Si6Z0r5rrDH/GY7XiQs1JFb59bejWxplBr6PAbdU
         eAiwXpWrt2IIuwvS/Lv6s5yyP9ko4l2jppNf9+Z7ovb7DbIcAvtpQktj12xMILV4YKMN
         iUdw==
X-Forwarded-Encrypted: i=1; AJvYcCUccse+HOrcwdPzlAyMCDsKvAUt8WEcNjYelPJBzB6hiTAAbE1akAD/49FN3SwCdy3YNtzNREuVXVHapg==@vger.kernel.org, AJvYcCX0rlWW19QHqYqYVaxymBpwkRIZcsfok1+rCvZF9rZbQ4xg4UMkitqGdhCsosp8up9du2co+raqsMH4@vger.kernel.org, AJvYcCXXUncK1CkeW8kooCF3GB4+CoMDuaalMelc/8rdgakXj5YHjqJLJmBvz9xtrBuCoMBz8apsDx0ozWA9o5rB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jr9gbxXITEaC2wAtGn/hVe6uar+MgpArLVkG0fm6zMJZUOsL
	f6cz/Uxby+BbyndxXJdaQw2TkKQFUYF/XIiM5rlSzh8hVC+hAS2JprPuVW4Qc3jeVzM1XP66rlV
	rdOH42H+3qM1Uy0AQCBiufZl4BI8=
X-Gm-Gg: ASbGncty/A8qPAvOIduB766wQLn1cdx4R0joJCs9nHjuiNGgygX83lu+7q6Cy1efMoM
	n/j9QhUEvH2ITeoy2WKTMl1bQO0PxxL+9+QlJhF6laDZbDcTZyXV23bduAdEjdcRRSaYWZoDTRu
	YpxL30NWtZP3EXl7Os9VvXmDYY
X-Google-Smtp-Source: AGHT+IFV2itzLpoFraDMPTaa8NOOgj1dLte+8y2kr9YYgzCqprEUo8QvUPqITZS5O9fBMncBBx/ddJ4TIEj+dBZNAGE=
X-Received: by 2002:a17:907:1b13:b0:ace:4197:9ac5 with SMTP id
 a640c23a62f3a-ace71124427mr952233266b.27.1745823380413; Sun, 27 Apr 2025
 23:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745605382.git.Jonathan.Santos@analog.com> <0a214d5dfacc3976db71af8a80f9dcf2887fe6cc.1745605382.git.Jonathan.Santos@analog.com>
In-Reply-To: <0a214d5dfacc3976db71af8a80f9dcf2887fe6cc.1745605382.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 Apr 2025 09:55:44 +0300
X-Gm-Features: ATxdqUG_LU6TdUnzlvAgq3Jvw--wjKNazD1RkT6rJZoXywM9R8GEIBZyAyEkhfE
Message-ID: <CAHp75VcUgwZWgaAX8XNrVLc8Rnn-xMAqFSKvh=+bQWNM50pyPA@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, 
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl, 
	lgirdwood@gmail.com, broonie@kernel.org, jonath4nns@gmail.com, 
	dlechner@baylibre.com, David Lechner <dlechner@baylire.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:13=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> When the device is configured to decimation x8, only possible in the
> sinc5 filter, output data is reduced to 16-bits in order to support
> 1 MHz of sampling frequency due to clock limitation.
>
> Use multiple scan types feature to enable the driver to switch
> scan type in runtime, making possible to support both 24-bit and

at runtime
making it possible

> 16-bit resolution.

...

> +       ret =3D spi_read(st->spi, &st->data.scan.chan,
> +                      BITS_TO_BYTES(scan_type->realbits));
>         if (ret < 0)
>                 goto out;

Add a TODO to convert this to use a new helper from 163ddf1fea59.

--=20
With Best Regards,
Andy Shevchenko

