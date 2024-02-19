Return-Path: <linux-iio+bounces-2789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A6785ABCF
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DEB215DF
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8A5026B;
	Mon, 19 Feb 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="po788f8/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6450243
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370030; cv=none; b=R8aEmOTSqt3gfF8DRupLkTZ9im1lLlJqjGEkIb/SnxRWmonddfHwedwlwxjlG1xmUmFzQIUhfuhZq4rIj2mKi0Aps9XpuqZ0EO5Mx2Lmt7jzhM25+umDaXCqyu6GY/bmHmVxOLdDIPiL/kGGFrTucDTRSMS/vH+RtRFEH9zGFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370030; c=relaxed/simple;
	bh=6eisWDm4LZWmGOH+OzqLp8spW6idnvtgSOrHuuYZFBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpdByXb22xcbWslrhdr/7d0eTFzhHQejLj8v2v4G28C98zQNdQ3kmGso2u25yT3xg4Y4kF+zV9BQkv9zEFzdJLP/Hz2N99CK5QwHnBDyIJrdK454ekG6FtIgcKnPXWfh7IAtKQJp05obLQNjFMY3GmdhdNbJgtbFhzGm5cQrmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=po788f8/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so34391511fa.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708370027; x=1708974827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csS8H22FayrstR0dzfkJS68NFu6zUIzIumHSfC39WBs=;
        b=po788f8/fNdaIU26zjOYxRqMTG9kuFwvmBcqrw9R6l8Y8qvQylvTLk+fpf1tNyl7Zs
         0QxCCVNhHvpDJm2B4WkQn4W4D17l0JErN4b12PX5uVMiffO7FJnhEjGIOEfDY6A4BNjV
         qAPe7KLknHCe6Hc2dbV18kB0khvQ4o6PapnXYAHiLYwrcqd3LR/LAWlrzrEWQiWdQTPz
         +Xab6tXSkD999qfSC3+S8zOkbwiUd6sZxsSfCq5+QKTevYOWtgQpGD+C1tJaHCSBD7U2
         7eagpe30UDr4jTuuHYq8VjMgRp+SMTRKdq0zWRpf7arxFUWD7ytiiEZ0jWEeoo1mrIxw
         5fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708370027; x=1708974827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csS8H22FayrstR0dzfkJS68NFu6zUIzIumHSfC39WBs=;
        b=XEMDOYsmeb70Isp3V2x3GC/8oKoOAF0hN08SplPwk9sGGBmzQjz2OWLNFS0hrmmC/+
         xsXq37zGLmHteF3tS/yAgD1j2Npz2ittU+BZJlBgvH72QWrlaSHYzHODpwhXK0FCu63k
         1fnlIpxlPpz7oZeNjBUEOwg/sMZXqMc05HqPg8vrPDeKeZko94TFwT1aLMOwc0NIGAAd
         U17ImaNw+AIgfue0JaelesSdI+TO3I63QEG+lJrxz1klF5KdxjMzxaP7uFD61WOZUr0y
         h1zwvsxP/jFbjOSx0gVMOUR6fnHzn85m737GF+mMInzQgh9yhs8TnC9+fg01TGw+riCd
         IJFA==
X-Gm-Message-State: AOJu0YzJ8nYbZWBVseJFNcl9J5qa/I2sh/zM889Kzzi+qUoExbYXJ4gW
	JsGg6TIAQHjN06koXlAnMeJXn9fKN17M7HqOC4fiJoxWSdDPsg5RY9Jxt/ybBY8o/U+tzaAb5Fw
	eJ0K9s1IBbRJH0cO48l587/7x/y1ndbEqpfr40t1+iaT4Hx6YXX8=
X-Google-Smtp-Source: AGHT+IHbq/rDn6jxtClwjRc65peUUfpaYcvy+EKHprzAkBgAfUpS2zbcXtPOpk0oAi9MtZwbl3N6G3rbsPaA8/7kS7I=
X-Received: by 2002:a2e:b6c6:0:b0:2d2:3a89:b97b with SMTP id
 m6-20020a2eb6c6000000b002d23a89b97bmr1993750ljo.24.1708370026492; Mon, 19 Feb
 2024 11:13:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216-ad7944-mainline-v2-0-7eb69651e592@baylibre.com> <20240216-ad7944-mainline-v2-2-7eb69651e592@baylibre.com>
In-Reply-To: <20240216-ad7944-mainline-v2-2-7eb69651e592@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 19 Feb 2024 13:13:35 -0600
Message-ID: <CAMknhBH2Pqa9xpPxnTCxJegVTbOG-QDeJA4YrQUPfj+hfSs73A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7944: add driver for AD7944/AD7985/AD7986
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 1:47=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:

...

> +
> +#define AD7944_DEFINE_CHIP_INFO(_name, _t, _bits, _sign)               \
> +static const struct ad7944_chip_info _name##_chip_info =3D {            =
 \
> +       .name =3D #_name,                                                =
 \
> +       .t =3D &_t##_timing_spec,                                        =
 \
> +       .channels =3D {                                                  =
 \
> +               {                                                       \
> +                       .type =3D IIO_VOLTAGE,                           =
 \
> +                       .indexed =3D 1,                                  =
 \
> +                       .differential =3D 1,                             =
 \
> +                       .channel =3D 0,                                  =
 \
> +                       .channel2 =3D 1,                                 =
 \
> +                       .scan_index =3D 0,                               =
 \
> +                       .scan_type.sign =3D _sign,                       =
 \
> +                       .scan_type.realbits =3D _bits,                   =
 \
> +                       .scan_type.storagebits =3D _bits > 16 ? 32 : 16, =
 \
> +                       .scan_type.endianness =3D IIO_CPU,               =
 \
> +                       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)   =
 \
> +                                       | BIT(IIO_CHAN_INFO_SCALE),     \
> +               },                                                      \
> +               IIO_CHAN_SOFT_TIMESTAMP(1),                             \
> +       },                                                              \
> +}
> +
> +AD7944_DEFINE_CHIP_INFO(ad7944, ad7944, 14, 'u');
> +AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 'u');
> +AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 's');

Now that I have been enlightened [1] about pseudo-differntial inputs,
I'm thinking that AD7944 and AD7985 should not have the .differential
=3D 1 flag set since they are pseudo-differential inputs with a ground
sense on the negative input (and no extra supply needed since it is
always ground). Does that sound right?

AD7986 is true differential though, so should be correct already.

[1]: https://lore.kernel.org/linux-iio/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2khXn=
qA1cSdKpWHKWp0w@mail.gmail.com/

