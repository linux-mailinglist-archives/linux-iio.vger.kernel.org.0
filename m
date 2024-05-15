Return-Path: <linux-iio+bounces-5063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802038C6F39
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 01:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82E4B2193C
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2024 23:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5EA4F8BC;
	Wed, 15 May 2024 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OFoq6v99"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329D101C8
	for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715816072; cv=none; b=gWG32uZJ1gG1UVYMxSltJ/bTs9UpuI3K55E5PSVf8g9qu8oxY1KXPtSsP5AckKB+q+djZ4BsDEFmyxmySh65gJOja3FMkobZpd35cFnef5sAcbCrms2jbU8Y7TptnZ6UOmLK9IQa9EE5Pvya+kN01rMyB3eGYlUZhtrLbpI+1Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715816072; c=relaxed/simple;
	bh=+9uW7MlCfHiJsNdkLK4ioFsnx3akBtUYjnkX7SoEjV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tf481/9ug3JDQs98vP58msTWR+A1wlnY9Vid857TliizWcWDEnHfbH1pYm6uaxZmG49JZto6TuyD59TGWzl0P1+i5IGi1ifFJwNxr+P9/uoU5iCf/anKYjA+L/d61uaBo4klLsgvU+5dUhV+2/IPmKssPrlCEJfPiNQXCvcZ+sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OFoq6v99; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso1210681fa.0
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715816069; x=1716420869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM1vVgDISZc1YG7TkPKZwT01C1rQBO8QJzo5w5mgocY=;
        b=OFoq6v99JhEeMlw4e2dybI0cgyYBM6yCu+YMAIWSuZvrzNg8XFMpEs54U5GtV/TpT5
         DC9/zFOjyNS9e2IWrda0nikiclKAwvygTnaMItP/tHIF4CaKR+7DPNi4220quYPbXECd
         6LuOsjlC0Bx9o0BsAqHsyEJ6uTjXPcfYv1uc0u1yPcRpXviuRQiMsA8f66GFDF1ViZMz
         0szaX9ULI/WI8LQKaivo2JdH+EhVvm7K3B2eUi7EfLoPqv3iOmPg3PJHvQJfkAKBK7+L
         h10xvgrtkO0K5kHX6q9HMbqScXECqfuJZrWejhuWJaGobYoCowzVHJ0XrbbGkS3xZzOy
         kWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715816069; x=1716420869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM1vVgDISZc1YG7TkPKZwT01C1rQBO8QJzo5w5mgocY=;
        b=eYxkuASvoH/rlYhfeiJ12eC6FI1mV4nl8jHEXXpYxNGg+yBV2AO7h29m76nmegeNIz
         3L61vv8nL5hjs6KaSiA7rSMzvsn//M1QRX0w/aeLQTxU4sstrS8KiI0BF5jj7T5PpJjY
         pSCQ7Ey++BjNObM3dZyBou+rXAwH3rs3CmLgRrwnMk8hZMdLMC5nZfnmh8nGanDiK5EN
         ptv1kdsrHaSGU57Dk/3kWhFhvrXxJn3CZ+m4+qvdidZ2dHC4mvKIVdxC7K7XsrD20jQ4
         dKft1qgx8zg0nj757PNh0OeC+UH8/swwn0rJDvqcgpgWCz1s22keBGgMhUhJSyvLwrlq
         quYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdxfUktX0xx+cg7yM9dISD5JVqx3UQtIiyE/qlI68T56tGn76ijxjieMDlObIE+Aoxm2f3HZv3uh8PrL/2RRZbxM4amLSRiWKQ
X-Gm-Message-State: AOJu0YySguA7T+dTPF0aegmRkWs6zK0rXm8WM1ri1cBXrdLld+0oQI1e
	/aH8FkmQDIzMJB99QHj0k93liA4b0X7DJ5+7nhpafDQbES6vmU39ECegbQWgfvuLueWZvmkBOIr
	p45LmFVH/hR250Vj9hH6mG3v2NzKU4NzYseHBCA==
X-Google-Smtp-Source: AGHT+IF4HTk4lQ/MZlscTmkZB2wVbX5P7zvHwqNQ7NPS+iwWOITja47wZizPnUJAYB8kFKyOfMMCLIG7MbpgWvOJo9k=
X-Received: by 2002:a2e:812:0:b0:2d4:535a:e7a with SMTP id 38308e7fff4ca-2e51b4784b6mr54882141fa.24.1715816068070;
 Wed, 15 May 2024 16:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com> <20240514-ad4111-v2-7-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-7-29be6a55efb5@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 15 May 2024 18:34:17 -0500
Message-ID: <CAMknhBGfu_an738aWqL19zGm7tTOZtoOv-+eY3kn3Zt+-eShwg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] iio: adc: ad7173: Remove index from temp channel
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Temperature channel is unique per device, index is not needed.
>
> This is breaking userspace: as main driver has not reached mainline yet
> it won't affect users as there are none.

But it is queued up, so probably need a Fixes: here to make sure it
makes it into the release.

>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  drivers/iio/adc/ad7173.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index d965b66d4d5a..d66b47e1a186 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -828,7 +828,6 @@ static const struct iio_chan_spec ad7173_channel_temp=
late =3D {
>
>  static const struct iio_chan_spec ad7173_temp_iio_channel_template =3D {
>         .type =3D IIO_TEMP,
> -       .indexed =3D 1,
>         .channel =3D AD7173_AIN_TEMP_POS,
>         .channel2 =3D AD7173_AIN_TEMP_NEG,
>         .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>
> --
> 2.43.0
>
>

