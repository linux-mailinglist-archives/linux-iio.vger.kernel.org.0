Return-Path: <linux-iio+bounces-3346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49335871169
	for <lists+linux-iio@lfdr.de>; Tue,  5 Mar 2024 01:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AC628691F
	for <lists+linux-iio@lfdr.de>; Tue,  5 Mar 2024 00:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53FC139D;
	Tue,  5 Mar 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HqNU/HwM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DB38F
	for <linux-iio@vger.kernel.org>; Tue,  5 Mar 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597295; cv=none; b=AGUE32kRr8jj0/aaQHQYq2KHl/k8oqC3MHBaeP52K9ZmZnUb6/zOK/X4NgDOqckThzXo3/Lmn/iIeeORAmFNC9ptwjPCmoLN08CsqjaOXDmnITIUI1Kexs/jeuF7KJAvDCcL32mEStZixT78SkiiYzcWzSJK5jzBEhrpmWPQAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597295; c=relaxed/simple;
	bh=iBD/lWgE32zXC2QBHxGi//O0lo0WtY3b6Y89v266YRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8E0GS9hZORBAZRbVvAcs3OnVMwhtATypzB0v3Bzm+D94bQvfVamI2esY8peklCM6jlAv+RJnt277orS1YuVC+46TNDOzkTzo6lSMjiZRgvUXd22JGSshu/lw8Kk4kj+WtQD/ZVQ3aAcMq7224wM3HwlXIAjGSBQ7522eEsdqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HqNU/HwM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d2628e81b8so58622521fa.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Mar 2024 16:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709597290; x=1710202090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09gjUa1aNcaW8opSfWpZn+d038/7XmkYe107VGCZCIo=;
        b=HqNU/HwMJojUyz7FtaNRbupydTeXR2g7v53SFHgK0tz1oDHIb8pD9EZVXlej7N0Akd
         la5MGK8zmB0y+Fla9yJY6YzCjt1y6rNW5ATmbonl3k80n5d0ohFIXsDt5nNRHsYsrvoA
         ZpXEAHbvR+NIAiaM6Tr2AebUD9kggTCr9VJekSWzWGWZhvrEU8749h3yXYHd+JTLEFOp
         fCWIIopAx3jhAHlC6lcgE8EYJwJd58JZjpIuP0L8Qhdx9X5x2Ci/xv76gJDzKZHMCgp/
         C1oGIM04zQg5MpH/Ha8xa4CQiiDbYaAlFqvhE7d65C7Sv+KxorSXBokzmcOubsO1nGyO
         1nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709597290; x=1710202090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09gjUa1aNcaW8opSfWpZn+d038/7XmkYe107VGCZCIo=;
        b=ilLg2SJhAzo8KTmPy9GHFwU4ikhNYZBcrOhzYCoCBwVH9Imwzp6c8AzbVMOrmS0Qz9
         FjucE6SnkakeU5TNioYMtmuTTsJKkUeJPPzIrr/4eMWbmRNjGxogI1wjMrkwLCuZSWT5
         cu1KuqfLwn/rnL4yRSjd60jBT7MYUkzjVh1eh3jzEznuFGJw5dSh59RdkRGB737Jq7ES
         jcFQgyGzKljvN77F4r2Q21Q8Zq2QIWvvnlDBrUSySFUsFHNoBHwR9BVBFmEm5/z/qycn
         LTpfNUbbXGd2/CGACRW3/Fwv7wO2HxgXGxC9gkuze6kaMY7kABoPTqKbIePMqclLrD0y
         Dkgw==
X-Forwarded-Encrypted: i=1; AJvYcCVOVWOEA1e1ixX3M7NhnWeyTLUvq485HF4gbUEMJQQn2kvJtjE7cIcaPn1WHfY6h6wkLkIeA9ttxI5hDEArqKGncWQoYNYWsCeo
X-Gm-Message-State: AOJu0YzHSJMF/J3Z4wCoy5ueCSHHIhNKLz0aHph8VAhhNDDja6KxKF2+
	UjO6riojR/L2aN42EvngGm6PpzZDD14VNt2M+ysZP+f8hrbpLnhQ+CfYPJu8PoUqJB4P0OpGo5h
	u9yq+lkqwO47R0gqU2IamKM2KXIDPG5eqeP67zQ==
X-Google-Smtp-Source: AGHT+IF6jOcbxgpV5XnETtLmcngNiEFaSfy9AoFXhR2CKsQ+k92FKANJqu2HvZwGqa3iyBWwRU+kqKS0bmNwUI/avkY=
X-Received: by 2002:a05:651c:b06:b0:2d2:b5cb:cc3f with SMTP id
 b6-20020a05651c0b0600b002d2b5cbcc3fmr124275ljr.2.1709597290067; Mon, 04 Mar
 2024 16:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228135532.30761-1-mitrutzceclan@gmail.com> <20240228135532.30761-3-mitrutzceclan@gmail.com>
In-Reply-To: <20240228135532.30761-3-mitrutzceclan@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 4 Mar 2024 18:07:58 -0600
Message-ID: <CAMknhBGv5vfFPRJ_4nKrYWgxiovgHqTEtJoRs+EzvbvpF8a+Bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7173: add support for additional models
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:55=E2=80=AFAM Dumitru Ceclan <mitrutzceclan@gmail=
.com> wrote:
>
> Add support for Analog Devices AD7172-2, AD7175-8, AD7177-2.
>
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  drivers/iio/adc/ad7173.c | 82 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index b42fbe28a325..e60ecce20e08 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1,6 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
> + * AD717x family SPI ADC driver
> + *
> + * Supported devices:
> + *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
> + *  AD7175-8/AD7176-2/AD7177-2
> + *
>   * Copyright (C) 2015, 2024 Analog Devices, Inc.
>   */
>
> @@ -61,10 +66,13 @@
>  #define AD7173_AIN_TEMP_POS    17
>  #define AD7173_AIN_TEMP_NEG    18
>
> -#define AD7172_ID                      0x00d0
> -#define AD7173_ID                      0x30d0
> -#define AD7175_ID                      0x0cd0
> +#define AD7172_2_ID                    0x00d0
>  #define AD7176_ID                      0x0c90
> +#define AD7175_2_ID                    0x0cd0
> +#define AD7172_4_ID                    0x2050
> +#define AD7173_ID                      0x30d0
> +#define AD7175_8_ID                    0x3cd0
> +#define AD7177_ID                      0x4fd0

It would be nice to keep these sorted by name/number like they were.

>  #define AD7173_ID_MASK                 GENMASK(15, 4)
>
>  #define AD7173_ADC_MODE_REF_EN         BIT(15)
> @@ -110,15 +118,19 @@
>  #define AD7173_SETUP_REF_SEL_EXT_REF   0x0
>  #define AD7173_VOLTAGE_INT_REF_uV      2500000
>  #define AD7173_TEMP_SENSIIVITY_uV_per_C        477
> +#define AD7177_ODR_START_VALUE         0x07
>
>  #define AD7173_FILTER_ODR0_MASK                GENMASK(5, 0)
>  #define AD7173_MAX_CONFIGS             8
>
>  enum ad7173_ids {
>         ID_AD7172_2,
> +       ID_AD7172_4,
>         ID_AD7173_8,
>         ID_AD7175_2,
> +       ID_AD7175_8,
>         ID_AD7176_2,
> +       ID_AD7177_2,
>  };
>
>  struct ad7173_device_info {
> @@ -190,7 +202,7 @@ static const unsigned int ad7175_sinc5_data_rates[] =
=3D {
>  static const struct ad7173_device_info ad7173_device_info[] =3D {
>         [ID_AD7172_2] =3D {
>                 .name =3D "ad7172-2",
> -               .id =3D AD7172_ID,
> +               .id =3D AD7172_2_ID,

It would be nice to put these renames in a separate patch since it is
unrelated to the parts being added.

