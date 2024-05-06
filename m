Return-Path: <linux-iio+bounces-4853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A2A8BD10F
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 17:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1335E1C22632
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1AB154C09;
	Mon,  6 May 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D7cr83Ck"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD102153BF9
	for <linux-iio@vger.kernel.org>; Mon,  6 May 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715008166; cv=none; b=kFMZvykNyD7H9FylQqRoT5q0n8k6cVff/Jyn/qB6cQSZoM/JEB4EkndyoOeDBZSnhvtwwAm59UII1FYEH/hNpo/qzC6I2t2RmM4p5K1FFq3vOkPDZqPkv/DXVj8C4zzsksAy5zCY5rs6rLGm1sp6/PrWOBBSuHH3N3BerOMZUh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715008166; c=relaxed/simple;
	bh=ChkvKKXLsQfoTAngZYFoQe3YF0MVY7h2bQeifwJOfXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FluCF4zjl2O6rl3jvhuuwuTqsOPPdTw0OoCUEjypx604IEXS81SuzeCjSafAIbdMCXTM7qo/FA5HwEY7M8BF5uFCQRt3Ob5CB9G/80kNfGIMCTFXdQ6l2A3N9kgvymgpM5ZH8Fv2PHc4N8w4ICYcQw4WI9G9xsTdV3UXvY8tXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D7cr83Ck; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so18256385ad.1
        for <linux-iio@vger.kernel.org>; Mon, 06 May 2024 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715008164; x=1715612964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqhhV/e5mzK+6hrJY0o8mJ/dhifJ48pvMgC6Mb03m1s=;
        b=D7cr83CkvLjIWUYEJCkNYrBeNWOSZbxfu1cTC6X0JdHucDTa2sQbimKLYKe6WyEr+w
         RCWIaJB8/7yifgTAPioVa1+hZn5zdAwHARBTBP6S+3Ok5CZ9WH18RzUU7QNQR8a3iu0l
         hb0XJGSdyFGR3Q80JmQWX680NnG4iiZqA3T8ptOjaeFtDIq8WIJ424+rakNmWEZe4mpS
         t7w/ANcwVyxNEVEDxJP5W2Hu7dm8knNvVdchTC6ikP9vCPDDAblddaXLLFMmbjq4gsZd
         vGdzGvVHHr26EeUA8YVNZYTE+cTHTD2BXAVH+W6nu44cuyOoN43BOfCalXGb0jSA9Ixx
         g2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715008164; x=1715612964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqhhV/e5mzK+6hrJY0o8mJ/dhifJ48pvMgC6Mb03m1s=;
        b=e/+E1sifERQLWCM/h0vFLTlSyvdFaP4q7VXrMcC4qD7ttXu6zyUx1NRq40I7OorhUC
         HWBb9vj7knCZ8hr6Tf/mZwGS74ZToeUVJPpovLGAB8rM7pDfUBcpkvn03R8Rspln+CbO
         ahfJ8RHxQroOhDDypu/Z/YhJZQ8vbYPbcPXvgmIGCdCj+IqJiTv12ugPP6fdXcgMhC9Y
         KJvvi/l6HNZ7yDUQ5Csj3FiG8l5vqNI+xm2lzL2ZfbbizeTBQktynrUKon+Dar1BqiyF
         UKf6rYIg8S/om8gTaJ9VkTVy/8p3kEhx9OW0g9npMR0DetvIg2PhUbIiNeQNqKl5y/Us
         BHqA==
X-Forwarded-Encrypted: i=1; AJvYcCX0VuhcP/JkFqAB6rEJSr2Ffu9JsYX6+/RSV+AGDNU5FZt/4P3EQM5cJfGDmlp3b8y8RmQhJeVtEYrAnN2s1V9o8JvW7GeJ/3BX
X-Gm-Message-State: AOJu0YyH/RgIj77A9W+W1CfwA8gKnb+kJ8/2P/sG8klHJgBLuWkTMHtC
	mPbGeKGLDOgkzenaLOnFIyQ1EJM/mA+DUYaxJla5N9X1+GZ0dm8pdKFAx+bZhRMNIkEk2kUnqqo
	XN+8uLYbHU+4S+UHxJf9qZBf82EsrxDQ96eOpxw==
X-Google-Smtp-Source: AGHT+IFuMxUNzP457b7U27MNOYdMQrjSKz9fzKAVldClapC+zcuPtIK7aQhL5DhJm6xmhclACvVqpG+BxSbRUjZltq8=
X-Received: by 2002:a17:902:6847:b0:1eb:51fb:de09 with SMTP id
 f7-20020a170902684700b001eb51fbde09mr9967887pln.14.1715008163823; Mon, 06 May
 2024 08:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
 <20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com> <a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com>
In-Reply-To: <a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 6 May 2024 10:09:11 -0500
Message-ID: <CAMknhBEnJXCRGEUE+7VTfve6aPWZiandvE5xX4FPo17pqhmEeQ@mail.gmail.com>
Subject: Re: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for resolution boost
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 3:55=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com>=
 wrote:
>
> On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote:

...

> > +     /*
> > +      * If bits_per_word =3D=3D realbits (resolution boost enabled), w=
e don't
> > +      * need to manipulate the raw data, otherwise we may need to fix =
things
> > +      * up a bit to fit the scan_type specs
> > +      */
> > +     if (bits_per_word < realbits) {
> > +             if (realbits > 16 && bits_per_word <=3D 16) {
> > +                     /*
> > +                      * Here realbits > 16 so storagebits is 32 and
> > bits_per_word is <=3D 16
> > +                      * so we need to sign extend u16 to u32 using rev=
erse
> > order to
> > +                      * avoid writing over union data
> > +                      */
> > +                     for (i =3D st->chip_info->num_channels - 2; i >=
=3D 0; i--)
> > +                             st->scan_data.raw.u32[i] =3D sign_extend3=
2(st-
> > >scan_data.raw.u16[i],
> > +
> > bits_per_word - 1);
> > +             } else if (bits_per_word < 16) {
>
> Can't we have bits_per_word =3D 16 in case realbits <=3D 16?
>
This case is handled by the outermost if, so can't have that here. (In
that case, no manipulation is required so the whole big if statement
is skipped). realbits will never be < bits_per_word.

