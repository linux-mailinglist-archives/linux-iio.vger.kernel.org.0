Return-Path: <linux-iio+bounces-12194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8989C6B6D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 10:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A59B261B2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D725E1F77B6;
	Wed, 13 Nov 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFQDw9qZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4B17CA1F;
	Wed, 13 Nov 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489996; cv=none; b=Jr8MTZrUQAw4/Vc9bqcoNv6KRnmBmBe3IyZ2Qt2KTpuKpf7/PFpoDN8xe0+G86ccpDa8jXMHf+QjCzdrZVUQrkvpWG25HrmyV6ZKzmLIQwOvR0N4z/3MTMSkJm1AEHKty2zXCTDYJ76qOXGyc8703HLlYe2i9EnAUFVxyXvxB8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489996; c=relaxed/simple;
	bh=vVClFqqRLgFQB0Fa367MozCa4hMoCb2+z8bMDD6xwjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rnYWgdYNl4KsTd6WdU7xJkzLAc5fRBsWy1QbVcV3DJQ9njNvCe9OOWe0PaJ4+U33A55DrxkUBmZKw281WZ2H6FlaGixc+9U3F1CH4l10f/brLuD5pkjjBb0EpSfhHpJOoWJOJpFKu65DiEcZixgyzT3TdfRItJqx43bs0IjbLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFQDw9qZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f2b95775so8436762e87.1;
        Wed, 13 Nov 2024 01:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731489993; x=1732094793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcnMsHr2Rd3GgD9bQAjLgi+Zo7asxBiT+Hk7fbTZndQ=;
        b=cFQDw9qZgvVj0gFgzB4MA2GhZXrI1ekJrI89tsP0SoQkpHj2EzdNKgkVD10Pm2vFhS
         khowfLUGMNwmPIfe1oAP9yEjKEIeiRifNzu7Ws1GtM12xLIcExnw7Ic0s3hZb68543vZ
         ntaGFiNHM8voV46HcAxu/YAq1cEcxC8IBt8EN6AlPg232igo7LG5Q5rjK5pZFAPIg8xe
         6GK6zY2C1l5Rie9guJmm0Z41E57nEEAlco4l7PZswXg/6avmz2AW5RI2yTiVUsMX1hMB
         BgU7ZMJ2gQ6gKLkKqo7tuGHzlPDrmULN8kbUm9yuN5RZc4CJJXX6Lm3Es7jSiqqadBRX
         vDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489993; x=1732094793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcnMsHr2Rd3GgD9bQAjLgi+Zo7asxBiT+Hk7fbTZndQ=;
        b=IPsH0zN3C4Y65DY+t1m2AVFJ1s7ISITCGVgRzO7IuvyD3WwfiixGleyAzju1l3/QgN
         9uNobPIRWxsWlaGIk1OucMC2lJaVnRsSPuvImD4pyOM72oWcBZa+uMvXb2SAhcmJaLRm
         kSBh2b994gUwv5LA0CS3ZDC80WGKSVyEIRtITKyMhB+ZduBbGh5SiEYbWpYLJsSFcp5L
         Q8bb7qMM4K+uQEgE08AUbaVvctxqMJQS3k7oEM1U48HhSuQp4Zm/yEj21K5JzCGpk9M2
         1hj73hcAF/TgPCzlVBXmLcxqiHTok01ju7wbMrIS/T6iiw/KDmF2uSj0+lHwraOGdCqs
         puZg==
X-Forwarded-Encrypted: i=1; AJvYcCViesXq7K/wfnZHfBfYn6l3EmOWnLo46ZDvxaIHmiqNM98jhtwNW6xEDc43YeEhvta+3ZOR39gLdZA=@vger.kernel.org, AJvYcCWY5KWc74cRPSXuvwlWiEe8m0LzIcl8c1t9stkJ0mlFwBLy8rkVZSo+xtCaFzcUx9NDmWKbjOWIGiMMOxkC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4oPtTOd5UzQ13HizS8rv1dRL8bXAY7pGEksjXCNcYIbVqJd5
	T5sYJNlSnSFZjFg6DoUKcoxr0zHs8qZDurt5gzcmmJwrtXzwcjHojp4V5icZ+8Mztuzt2W8BGm6
	P8+TXM7LiKeR3CxvW+W0LAp/yTzw=
X-Google-Smtp-Source: AGHT+IHteRyKxZP1u25osdpoLoKarZeBWhAAwa7jAcBbbFNi4c6zDgmKqU9CRtwV4QDfJYaulmQakg2LMh2GRq6MKNw=
X-Received: by 2002:a05:6512:3b13:b0:53d:a16e:3684 with SMTP id
 2adb3069b0e04-53da16e3d22mr1052249e87.41.1731489992427; Wed, 13 Nov 2024
 01:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113064935.4449-1-victor.duicu@microchip.com>
In-Reply-To: <20241113064935.4449-1-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Nov 2024 11:25:55 +0200
Message-ID: <CAHp75Vd4a0P3yLMsarcKH=rZ_sBTmJ4Hr545LJCfchCJMyzLUQ@mail.gmail.com>
Subject: Re: [PATCH v9] iio: adc: pac1921: Add ACPI support to Microchip pac1921
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marius.cristea@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:51=E2=80=AFAM <victor.duicu@microchip.com> wrote:
>
> From: Victor Duicu <victor.duicu@microchip.com>
>
> This patch implements ACPI support to Microchip pac1921.
> The driver can read the shunt resistor value and label from the ACPI tabl=
e.

...

> +/*
> + * The maximum acceptable shunt value is 2146.999999 OHM.
> + * This value, which is below INT_MAX, was chosen in order to
> + * allow the readings from dt and ACPI to share the same range
> + * and to simplify the checks.
> + * With this value the maximum current that can be read is
> + * 0.1V / 2146.999999OHM =3D 46.576 uA
> + * If we use INT_MAX the maximum current that can be read is
> + * 0.1V / 2147.483647OHM =3D 46.566 uA
> + * The relative error between the two values is
> + * |(46.566 - 46.576) / 46.566| * 100 =3D 0.0214
> + */
> +#define PAC1921_MAX_SHUNT_VALUE_uOHMS          2146999999

You most likely want to have UL/ULL at the end.

+ blank line.

> +/* f7bb9932-86ee-4516-a236-7a7a742e55cb */
> +static const guid_t pac1921_guid =3D
> +                       GUID_INIT(0xf7bb9932, 0x86ee, 0x4516, 0xa2,
> +                                 0x36, 0x7a, 0x7a, 0x74, 0x2e, 0x55, 0xc=
b);
> +

...

> +       /*
> +        * This check validates shunt is not zero

the shunt

> +        * and does not surpass maximum value.
> +        * The check is done before calculating in order
> +        * to avoid val * MICRO overflowing.

Btw, does this use a full room of 80 characters per line?

> +        */

...

> +       if (ACPI_HANDLE(dev))

Probably we want here to have the same check as other drivers use,
i.e. is_acpi_node() / is_acpi_device_node() (choose one that suits
better for you).

> +               ret =3D pac1921_match_acpi_device(indio_dev);
> +       else
> +               ret =3D pac1921_parse_of_fw(indio_dev);

...


With above being addressed,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

